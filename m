Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409452089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051432;
	bh=9xPWIYY7knjN5DzKOzsU/+0tgJnHIug+LQLSjVv4scs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mkjf7kNNv/4HXH8xV7tG+dyI4RcCllOz55ezFKu1m0rAIQlk8wVNAbUZEKEYzWScG
	 8VBY6bMtY4BvbVvReUZ2U76MOWpgJEy8f2kIYPCN5wEIbyAoaG+l19SNvYnEmsp6Es
	 h+WIr1/NAcmOt6bEtAazjm3eUNhneTfeQH02ui8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfFTRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:23:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbfFTRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iCSzZqLsrl4SZGgGSimNBkQcdOEuLjaMwS/hhvVK5Fk=; b=EPsioJ5wGUTTkgGp6YkE8sMWez
        ogV3xkkjy8zucX2C06wc6WfyPApPn5Cbu7jEnmlE13J9iAD8VTPZlzVO82T0ZGqgO0GQWBZlp8OO6
        AyZlUDT98rMURZOxDDhC/D6cLVeOgiL/C3l7XWM25289OESB1GsO55Fl1j6aEL6BEXWlbK4OQqkXB
        bpHmRA1/Xb1GzcZ/jzRjmWQi76omRZ4yi9xlha9JR7GlurcioUHaOzqQJiQNmSZ5RtaHrZNcCZJze
        KH7EkSWUzpSH+YIULKpCFX8Pm0jfrCGDdAhLgctmUvWGC1FUqHLvv3F9XIk3tLQ+zU77dPjzmYmEv
        GDRfFZSQ==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008S4-Ar; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mK-0000Dx-1S; Thu, 20 Jun 2019 14:23:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 20/22] docs: admin-guide, x86: add a features list
Date:   Thu, 20 Jun 2019 14:23:12 -0300
Message-Id: <f6e5d5d23a970e9fce689963890655917d776996.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a feature list matrix at the admin-guide and a x86-specific
feature list to the respective Kernel books.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/features.rst |   3 +
 Documentation/admin-guide/index.rst    |   1 +
 Documentation/conf.py                  |   2 +-
 Documentation/sphinx/kernel_feat.py    | 169 +++++++++++++++++++++++++
 Documentation/x86/features.rst         |   3 +
 Documentation/x86/index.rst            |   1 +
 6 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/sphinx/kernel_feat.py
 create mode 100644 Documentation/x86/features.rst

diff --git a/Documentation/admin-guide/features.rst b/Documentation/admin-guide/features.rst
new file mode 100644
index 000000000000..8c167082a84f
--- /dev/null
+++ b/Documentation/admin-guide/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 20c3020fd73c..14c8464f6ca9 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -17,6 +17,7 @@ etc.
    kernel-parameters
    devices
    abi
+   features
 
 This section describes CPU vulnerabilities and their mitigations.
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 598256fb5c98..a0ef76ce5615 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -34,7 +34,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig', 'kernel_abi']
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig', 'kernel_abi', 'kernel_feat']
 
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
new file mode 100644
index 000000000000..2fee04f1dedd
--- /dev/null
+++ b/Documentation/sphinx/kernel_feat.py
@@ -0,0 +1,169 @@
+# coding=utf-8
+# SPDX-License-Identifier: GPL-2.0
+#
+u"""
+    kernel-feat
+    ~~~~~~~~~~~
+
+    Implementation of the ``kernel-feat`` reST-directive.
+
+    :copyright:  Copyright (C) 2016  Markus Heiser
+    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
+    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
+
+    The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
+    scripts/get_feat.pl script to parse the Kernel ABI files.
+
+    Overview of directive's argument and options.
+
+    .. code-block:: rst
+
+        .. kernel-feat:: <ABI directory location>
+            :debug:
+
+    The argument ``<ABI directory location>`` is required. It contains the
+    location of the ABI files to be parsed.
+
+    ``debug``
+      Inserts a code-block with the *raw* reST. Sometimes it is helpful to see
+      what reST is generated.
+
+"""
+
+import codecs
+import os
+import subprocess
+import sys
+
+from os import path
+
+from docutils import nodes, statemachine
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+from docutils.utils.error_reporting import ErrorString
+
+#
+# AutodocReporter is only good up to Sphinx 1.7
+#
+import sphinx
+
+Use_SSI = sphinx.__version__[:3] >= '1.7'
+if Use_SSI:
+    from sphinx.util.docutils import switch_source_input
+else:
+    from sphinx.ext.autodoc import AutodocReporter
+
+__version__  = '1.0'
+
+def setup(app):
+
+    app.add_directive("kernel-feat", KernelFeat)
+    return dict(
+        version = __version__
+        , parallel_read_safe = True
+        , parallel_write_safe = True
+    )
+
+class KernelFeat(Directive):
+
+    u"""KernelFeat (``kernel-feat``) directive"""
+
+    required_arguments = 1
+    optional_arguments = 2
+    has_content = False
+    final_argument_whitespace = True
+
+    option_spec = {
+        "debug"     : directives.flag
+    }
+
+    def warn(self, message, **replace):
+        replace["fname"]   = self.state.document.current_source
+        replace["line_no"] = replace.get("line_no", self.lineno)
+        message = ("%(fname)s:%(line_no)s: [kernel-feat WARN] : " + message) % replace
+        self.state.document.settings.env.app.warn(message, prefix="")
+
+    def run(self):
+
+        doc = self.state.document
+        if not doc.settings.file_insertion_enabled:
+            raise self.warning("docutils: file insertion disabled")
+
+        env = doc.settings.env
+        cwd = path.dirname(doc.current_source)
+        cmd = "get_feat.pl rest --dir "
+        cmd += self.arguments[0]
+
+        if len(self.arguments) > 1:
+            cmd += " --arch " + self.arguments[1]
+
+        srctree = path.abspath(os.environ["srctree"])
+
+        fname = cmd
+
+        # extend PATH with $(srctree)/scripts
+        path_env = os.pathsep.join([
+            srctree + os.sep + "scripts",
+            os.environ["PATH"]
+        ])
+        shell_env = os.environ.copy()
+        shell_env["PATH"]    = path_env
+        shell_env["srctree"] = srctree
+
+        lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
+        nodeList = self.nestedParse(lines, fname)
+        return nodeList
+
+    def runCmd(self, cmd, **kwargs):
+        u"""Run command ``cmd`` and return it's stdout as unicode."""
+
+        try:
+            proc = subprocess.Popen(
+                cmd
+                , stdout = subprocess.PIPE
+                , stderr = subprocess.PIPE
+                , **kwargs
+            )
+            out, err = proc.communicate()
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
+            if proc.returncode != 0:
+                raise self.severe(
+                    u"command '%s' failed with return code %d"
+                    % (cmd, proc.returncode)
+                )
+        except OSError as exc:
+            raise self.severe(u"problems with '%s' directive: %s."
+                              % (self.name, ErrorString(exc)))
+        return out
+
+    def nestedParse(self, lines, fname):
+        content = ViewList()
+        node    = nodes.section()
+
+        if "debug" in self.options:
+            code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
+            for l in lines.split("\n"):
+                code_block += "\n    " + l
+            lines = code_block + "\n\n"
+
+        for c, l in enumerate(lines.split("\n")):
+            content.append(l, fname, c)
+
+        buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+
+        if Use_SSI:
+            with switch_source_input(self.state, content):
+                self.state.nested_parse(content, 0, node, match_titles=1)
+        else:
+            self.state.memo.title_styles  = []
+            self.state.memo.section_level = 0
+            self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
+            try:
+                self.state.nested_parse(content, 0, node, match_titles=1)
+            finally:
+                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+
+        return node.children
diff --git a/Documentation/x86/features.rst b/Documentation/x86/features.rst
new file mode 100644
index 000000000000..b663f15053ce
--- /dev/null
+++ b/Documentation/x86/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features x86
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index ae36fc5fc649..ed42c8c9154d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -29,3 +29,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   features
-- 
2.21.0

