; Identifiers

((identifier) @constant (#match? @constant "^[A-Z][A-Z\\d_]+$"))

(namespaced_identifier
  left: [
          ; Lowercased names in lhs typically are variables, while camel cased are namespaces
          ((identifier) @namespace (#match? @namespace "^[A-Z]+[a-z]+$"))
          ((identifier) @variable (#match? @variable "^[a-z]"))
          (_)
          ]
  right: [
           ; Lowercased are variables, camel cased are types
           ((identifier) @parameter (#match? @parameter "^[a-z]"))
           ((identifier) @type (#match? @type "^[A-Z]+[a-z]+$"))
           (_)
           ]
  )

((identifier) @constructor (#match? @constructor "^[A-Z]*[a-z]+"))

; Pointers

(address_of_identifier "&" @string.special.symbol)
(pointer_type "*" @string.special.symbol)
(indirection_identifier "*" @string.special.symbol)

; Misc

(number) @constant.numeric

[
  "{"
  "}"
  "("
  ")"
  "["
  "]"
  ] @punctuation.bracket

[
  ";"
  ":"
  "."
  ","
  "->"
  ] @punctuation.delimiter

; Reserved keywords

[
  "return"
  "yield"
  "break"
  ] @keyword.control.return


(null) @constant.builtin

[
  "typeof"
  "is"
  ] @keyword.operator

[
  (modifier)
  "var"
  "class"
  "interface"
  (property_parameter)
  (this)
  "enum"
  "new"
  "in"
  "as"
  "try"
  "catch"
  "requires"
  "ensures"
  "owned"
  "throws"
  "delete"
  "#if"
  "#elif"
  (preproc_else)
  (preproc_endif)
  ] @keyword

"throw" @keyword.control.exception

[
  "if"
  "else"
  "switch"
  "case"
  "default"
  ] @keyword.control.conditional

[
  "for"
  "foreach"
  "while"
  "do"
  ] @keyword.control.repeat

[
  (true)
  (false)
  ] @constant.builtin.boolean

; Operators

(binary_expression
  [
    "*"
    "/"
    "+"
    "-"
    "%"
    "<"
    "<="
    ">"
    ">="
    "=="
    "!="
    "+="
    "-="
    "*="
    "/="
    "%="
    "&&"
    "||"
    "&"
    "|"
    "^"
    "~"
    "|="
    "&="
    "^="
    "??"
    "="
    ] @operator
  )

(unary_expression
  [
    "-"
    "!"
    "--"
    "++"
    ] @operator
  )

; Declaration

(declaration
  type_name: (_) @type
  )

; Methods

(function_definition
  type: (_) @type
  name: [
          (identifier) @function.method
          (generic_identifier (_) @type)
          ]
  )

(function_call
  identifier: [
                (identifier) @function
                (generic_identifier (_) @type)
                ]
  )

(member_function
  identifier: [
                (identifier) @function
                (generic_identifier (_) @type)
                ]
  )

; Types

(primitive_type) @type

(nullable_type
  (_) @type
  "?" @string.special.symbol
  )

; Comments

(comment) @comment

; Namespace

(namespace
  "namespace" @keyword.control.import
  (_) @namespace
  )

"global::" @namespace

(using
  "using" @keyword.control.import
  (_) @namespace
  )

; Classes

(class_declaration) @type

(class_constructor_definition
  name: [
          (_)
          (namespaced_identifier (_) @constructor .)
          ] @constructor
  )

(class_destructor
  "~" @string.special.symbol
  (_) @constructor
  )

; Interfaces

(interface_declaration) @type

; Strings and escape sequences

(string_literal) @string
(verbatim) @string
(escape_sequence) @string

(string_template
  "@" @string.special.symbol
  ) @string

(string_template_variable) @variable.other

(string_template_expression) @variable.other

; New instance from Object

(new_instance
  "new" @keyword
  )

; GObject construct

(gobject_construct
  "construct" @keyword
  )

; Try statement

(try_statement
  exception: (parameter_list (declaration_parameter
                               (_) @keyword.control.exception
                               (_) @variable.parameter
                               ))
  )

; Enum

(enum_declaration
  name: (identifier) @type
  )

; Loop

(foreach_statement
  loop_item: (identifier) @variable
  )

; Casting

(static_cast
  type: (_) @type
  )

(dynamic_cast
  type: (_) @type
  )

; Regex

(regex_literal) @string.regexp

; Code attribute

(code_attribute
  name: (identifier) @variable.other.member
  param: (_) @variable.other.member
  ) @variable.other.member