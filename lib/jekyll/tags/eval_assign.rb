module Jekyll
  class EvalAssignTag < Liquid::Tag
    Syntax = /([^\s]*)\s*=\s*(.*)/

    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @to = $1.to_s.chomp
        @from = $2
      else
        raise SyntaxError.new("SyntaxError in 'evalassign' - Valid syntax: evalassign [var] = [ruby expression]")
      end
      super
    end

    def render(context)
      post = context.scopes[0]["post"] if context.scopes[0]
      site = context.scopes[1]["site"] if context.scopes[1]
      page = context.scopes[1]["page"] if context.scopes[1]
      context.scopes.last[@to.to_s.chomp] = eval(@from)
      ""
    end
  end
end

Liquid::Template.register_tag("evalassign", Jekyll::EvalAssignTag)
