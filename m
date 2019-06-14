Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB4C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CCB21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfFNNjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:39:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:27070 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbfFNNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:39:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:39:24 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 06:39:22 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide book
In-Reply-To: <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
Date:   Fri, 14 Jun 2019 16:42:20 +0300
Message-ID: <87o930uvur.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>
> As we don't want a generic Sphinx extension to execute commands,
> change the one proposed to Markus to call the abi_book.pl
> script.
>
> Use a script to parse the Documentation/ABI directory and output
> it at the admin-guide.

We had a legacy kernel-doc perl script so we used that instead of
rewriting it in python. Just to keep it bug-for-bug compatible with the
past. That was the only reason.

I see absolutely zero reason to add a new perl monstrosity with a python
extension to call it. All of this could be better done in python,
directly.

Please don't complicate the documentation build. I know you know we all
worked hard to take apart the old DocBook Rube Goldberg machine to
replace it with Sphinx. Please don't turn the Sphinx build to another
complicated mess.

My strong preferences are, in this order:

1) Convert the ABI documentation to reStructuredText

2) Have the python extension read the ABI files directly, without an
   extra pipeline.


BR,
Jani.


>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/admin-guide/abi-obsolete.rst |  10 ++
>  Documentation/admin-guide/abi-removed.rst  |   4 +
>  Documentation/admin-guide/abi-stable.rst   |  13 ++
>  Documentation/admin-guide/abi-testing.rst  |  19 +++
>  Documentation/admin-guide/abi.rst          |  11 ++
>  Documentation/admin-guide/index.rst        |   1 +
>  Documentation/conf.py                      |   2 +-
>  Documentation/sphinx/kernel_abi.py         | 155 +++++++++++++++++++++
>  8 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/abi-obsolete.rst
>  create mode 100644 Documentation/admin-guide/abi-removed.rst
>  create mode 100644 Documentation/admin-guide/abi-stable.rst
>  create mode 100644 Documentation/admin-guide/abi-testing.rst
>  create mode 100644 Documentation/admin-guide/abi.rst
>  create mode 100644 Documentation/sphinx/kernel_abi.py
>
> diff --git a/Documentation/admin-guide/abi-obsolete.rst b/Documentation/admin-guide/abi-obsolete.rst
> new file mode 100644
> index 000000000000..cda9168445a5
> --- /dev/null
> +++ b/Documentation/admin-guide/abi-obsolete.rst
> @@ -0,0 +1,10 @@
> +ABI obsolete symbols
> +====================
> +
> +Documents interfaces that are still remaining in the kernel, but are
> +marked to be removed at some later point in time.
> +
> +The description of the interface will document the reason why it is
> +obsolete and when it can be expected to be removed.
> +
> +.. kernel-abi:: $srctree/Documentation/ABI/obsolete
> diff --git a/Documentation/admin-guide/abi-removed.rst b/Documentation/admin-guide/abi-removed.rst
> new file mode 100644
> index 000000000000..497978fc9632
> --- /dev/null
> +++ b/Documentation/admin-guide/abi-removed.rst
> @@ -0,0 +1,4 @@
> +ABI removed symbols
> +===================
> +
> +.. kernel-abi:: $srctree/Documentation/ABI/removed
> diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/admin-guide/abi-stable.rst
> new file mode 100644
> index 000000000000..7495d7a35048
> --- /dev/null
> +++ b/Documentation/admin-guide/abi-stable.rst
> @@ -0,0 +1,13 @@
> +ABI stable symbols
> +==================
> +
> +Documents the interfaces that the developer has defined to be stable.
> +
> +Userspace programs are free to use these interfaces with no
> +restrictions, and backward compatibility for them will be guaranteed
> +for at least 2 years.
> +
> +Most interfaces (like syscalls) are expected to never change and always
> +be available.
> +
> +.. kernel-abi:: $srctree/Documentation/ABI/stable
> diff --git a/Documentation/admin-guide/abi-testing.rst b/Documentation/admin-guide/abi-testing.rst
> new file mode 100644
> index 000000000000..5c886fc50b9e
> --- /dev/null
> +++ b/Documentation/admin-guide/abi-testing.rst
> @@ -0,0 +1,19 @@
> +ABI testing symbols
> +===================
> +
> +Documents interfaces that are felt to be stable,
> +as the main development of this interface has been completed.
> +
> +The interface can be changed to add new features, but the
> +current interface will not break by doing this, unless grave
> +errors or security problems are found in them.
> +
> +Userspace programs can start to rely on these interfaces, but they must
> +be aware of changes that can occur before these interfaces move to
> +be marked stable.
> +
> +Programs that use these interfaces are strongly encouraged to add their
> +name to the description of these interfaces, so that the kernel
> +developers can easily notify them if any changes occur.
> +
> +.. kernel-abi:: $srctree/Documentation/ABI/testing
> diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/abi.rst
> new file mode 100644
> index 000000000000..3b9645c77469
> --- /dev/null
> +++ b/Documentation/admin-guide/abi.rst
> @@ -0,0 +1,11 @@
> +=====================
> +Linux ABI description
> +=====================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   abi-stable
> +   abi-testing
> +   abi-obsolete
> +   abi-removed
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 8001917ee012..20c3020fd73c 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -16,6 +16,7 @@ etc.
>     README
>     kernel-parameters
>     devices
> +   abi
>  
>  This section describes CPU vulnerabilities and their mitigations.
>  
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 7ace3f8852bd..598256fb5c98 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -34,7 +34,7 @@ needs_sphinx = '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
> +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig', 'kernel_abi']
>  
>  # The name of the math extension changed on Sphinx 1.4
>  if (major == 1 and minor > 3) or (major > 1):
> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> new file mode 100644
> index 000000000000..32ce90775d96
> --- /dev/null
> +++ b/Documentation/sphinx/kernel_abi.py
> @@ -0,0 +1,155 @@
> +# -*- coding: utf-8; mode: python -*-
> +u"""
> +    kernel-abi
> +    ~~~~~~~~~~
> +
> +    Implementation of the ``kernel-abi`` reST-directive.
> +
> +    :copyright:  Copyright (C) 2016  Markus Heiser
> +    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
> +    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
> +
> +    The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
> +    scripts/get_abi.pl script to parse the Kernel ABI files.
> +
> +    Overview of directive's argument and options.
> +
> +    .. code-block:: rst
> +
> +        .. kernel-abi:: <ABI directory location>
> +            :debug:
> +
> +    The argument ``<ABI directory location>`` is required. It contains the
> +    location of the ABI files to be parsed.
> +
> +    ``debug``
> +      Inserts a code-block with the *raw* reST. Sometimes it is helpful to see
> +      what reST is generated.
> +
> +"""
> +
> +import sys
> +import os
> +from os import path
> +import subprocess
> +
> +from sphinx.ext.autodoc import AutodocReporter
> +
> +from docutils import nodes
> +from docutils.parsers.rst import Directive, directives
> +from docutils.statemachine import ViewList
> +from docutils.utils.error_reporting import ErrorString
> +
> +
> +__version__  = '1.0'
> +
> +# We can't assume that six is installed
> +PY3 = sys.version_info[0] == 3
> +PY2 = sys.version_info[0] == 2
> +if PY3:
> +    # pylint: disable=C0103, W0622
> +    unicode     = str
> +    basestring  = str
> +
> +def setup(app):
> +
> +    app.add_directive("kernel-abi", KernelCmd)
> +    return dict(
> +        version = __version__
> +        , parallel_read_safe = True
> +        , parallel_write_safe = True
> +    )
> +
> +class KernelCmd(Directive):
> +
> +    u"""KernelABI (``kernel-abi``) directive"""
> +
> +    required_arguments = 1
> +    optional_arguments = 0
> +    has_content = False
> +    final_argument_whitespace = True
> +
> +    option_spec = {
> +        "debug"     : directives.flag
> +    }
> +
> +    def warn(self, message, **replace):
> +        replace["fname"]   = self.state.document.current_source
> +        replace["line_no"] = replace.get("line_no", self.lineno)
> +        message = ("%(fname)s:%(line_no)s: [kernel-abi WARN] : " + message) % replace
> +        self.state.document.settings.env.app.warn(message, prefix="")
> +
> +    def run(self):
> +
> +        doc = self.state.document
> +        if not doc.settings.file_insertion_enabled:
> +            raise self.warning("docutils: file insertion disabled")
> +
> +        env = doc.settings.env
> +        cwd = path.dirname(doc.current_source)
> +        cmd = "get_abi.pl rest --dir "
> +        cmd += self.arguments[0]
> +
> +        srctree = path.abspath(os.environ["srctree"])
> +
> +        fname = cmd
> +
> +        # extend PATH with $(srctree)/scripts
> +        path_env = os.pathsep.join([
> +            srctree + os.sep + "scripts",
> +            os.environ["PATH"]
> +        ])
> +        shell_env = os.environ.copy()
> +        shell_env["PATH"]    = path_env
> +        shell_env["srctree"] = srctree
> +
> +        lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
> +        nodeList = self.nestedParse(lines, fname)
> +        return nodeList
> +
> +    def runCmd(self, cmd, **kwargs):
> +        u"""Run command ``cmd`` and return it's stdout as unicode."""
> +
> +        try:
> +            proc = subprocess.Popen(
> +                cmd
> +                , stdout = subprocess.PIPE
> +                , stderr = subprocess.PIPE
> +                , universal_newlines = True
> +                , **kwargs
> +            )
> +            out, err = proc.communicate()
> +            if err:
> +                self.warn(err)
> +            if proc.returncode != 0:
> +                raise self.severe(
> +                    u"command '%s' failed with return code %d"
> +                    % (cmd, proc.returncode)
> +                )
> +        except OSError as exc:
> +            raise self.severe(u"problems with '%s' directive: %s."
> +                              % (self.name, ErrorString(exc)))
> +        return unicode(out)
> +
> +    def nestedParse(self, lines, fname):
> +        content = ViewList()
> +        node    = nodes.section()
> +
> +        if "debug" in self.options:
> +            code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
> +            for l in lines.split("\n"):
> +                code_block += "\n    " + l
> +            lines = code_block + "\n\n"
> +
> +        for c, l in enumerate(lines.split("\n")):
> +            content.append(l, fname, c)
> +
> +        buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
> +        self.state.memo.title_styles  = []
> +        self.state.memo.section_level = 0
> +        self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
> +        try:
> +            self.state.nested_parse(content, 0, node, match_titles=1)
> +        finally:
> +            self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
> +        return node.children

-- 
Jani Nikula, Intel Open Source Graphics Center
