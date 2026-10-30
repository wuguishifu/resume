%% Expects pdflatex (latexmk -pdf), which is what CI and LaTeX Workshop use.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[Resume Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass{extarticle}

%% ---- Packages --------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage[a-1b]{pdfx}  % PDF/A output; also loads hyperref
\RequirePackage{accsupp}
\RequirePackage[margin=1.5cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{dashrule}
\RequirePackage[newcommands]{ragged2e}

%% ---- Fonts -----------------------------------------------------------------
%% Map ligatures back to plain characters so copy-paste and ATS parsers see
%% "fi" instead of "ﬁ".
\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\input{glyphtounicode}
\pdfglyphtounicode{f_f}{FB00}
\pdfglyphtounicode{f_f_i}{FB03}
\pdfglyphtounicode{f_f_l}{FB04}
\pdfglyphtounicode{f_i}{FB01}
\pdfgentounicode=1

\RequirePackage[default]{lato}
\renewcommand{\baselinestretch}{0.9}

%% ---- Colors ---------------------------------------------------------------
\definecolor{heading}{HTML}{0F6688}
\definecolor{accent}{HTML}{228FBD}
\definecolor{body}{HTML}{6D6E71}
\colorlet{headingrule}{black}
\colorlet{name}{black}

%% ---- Page setup ------------------------------------------------------------
\setlength{\parindent}{0pt}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip}
\setlist[itemize]{label=\raisebox{0.25ex}{\tiny$\bullet$}}
\AtBeginEnvironment{itemize}{\small}

\AtBeginDocument{%
  \hypersetup{hidelinks}%
  \urlstyle{same}%
  \pagestyle{empty}%
  \color{body}%
  \raggedright
}

%% ---- Header ----------------------------------------------------------------
%% \cvheader{NAME}{contact fields}
\newcommand{\cvheader}[2]{%
  \begin{minipage}{\textwidth}
  {\LARGE\color{name}\bfseries #1}\par\vspace{4px}
  {\footnotesize\bfseries #2}
  \vspace{6px}
  \end{minipage}%
}

%% \printinfo{icon}{label}{text}{url}: one contact field. The label is what
%% copy-paste and ATS parsers see in place of the icon.
\newcommand{\printinfo}[4]{%
  \BeginAccSupp{method=escape,ActualText={#2: #3}}%
  \mbox{\textcolor{accent}{\normalfont #1}~\href{#4}{#3} \hspace{2em}}%
  \EndAccSupp{}%
}
\newcommand{\email}[1]{\printinfo{\faAt}{Email}{#1}{mailto:#1}}
\newcommand{\linkedin}[1]{\printinfo{\faLinkedin}{LinkedIn}{#1}{https://linkedin.com/in/#1}}
\newcommand{\homepage}[1]{\printinfo{\faGlobe}{Website}{#1}{https://#1}}
\newcommand{\github}[1]{\printinfo{\faGithub}{GitHub}{#1}{https://github.com/#1}}

%% ---- Sections and entries --------------------------------------------------
\newcommand{\cvsection}[1]{%
  \nointerlineskip\bigskip
  {\color{heading}\large\bfseries\MakeUppercase{#1}}\\[-1ex]%
  {\color{headingrule}\rule{\linewidth}{2pt}\par}\medskip
}

%% \cventry{Organisation}{Location}: blue first line of an entry.
\newcommand{\cventry}[2]{%
  {\color{accent}\bfseries #1}\hfill\null{\small\bfseries\itshape #2}\par\smallskip
}

%% \cvrole{Title}{Dates}: one line per title held at the organization.
\newcommand{\cvrole}[2]{%
  {\small\bfseries #1}\hfill\null{\small\bfseries\itshape #2}\par
}

%% Bullet list under an entry.
\newenvironment{highlights}{\medskip\begin{itemize}}{\end{itemize}}

\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\smallskip}
