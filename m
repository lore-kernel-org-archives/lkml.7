Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A334C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8582084E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561223845;
	bh=9i0sMI7wWhrzhSw7/8KCwOcXrJGRJIA7mrd97HslIhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYJfxpzCf+htWyv0y4zpYfh13PDchjUF4cU3iwBjUEl1wsOFSNBWDMtyA4VHh07YT
	 yo4APHYJPcuAqQJBgCfQgeqbtIZbxYTn4ueKwn5C3p8vsSztHEt93az9xRg4yTxfq9
	 dF6Im0C9SdGSAYmBiyWoZoh19oYEQv9lxh7y7sX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFVRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:17:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uoOl7Fx5ESHlZl3o3qLs6Qcg2WKTmmcBU+jl8KVsA8E=; b=Zi249TyucjVJAwh0htTSE6Huop
        k51tv/uOC+8leY9m91jFEaNG24fcOyLxX/n3nvN19Qcq0H/ePlyR+jPaVd0PWtP4TYZhUcEH2ODn0
        61s6lJq4L7dyhCnwQhhoTReJ1l8jxaRUHJsX/hiRUMRYfkWuy5rT0LPNT5B91fMHZuDeJHp22nVBL
        6YWm0SmKLUYRjAhN5dCmzV5jwueqVxjEnlb8Nb0aVxyWSgTj8KjivMsMY5GRK2ySue91Twf7r0j+8
        qGx/5uyBwMTfprKpFeE/LD+kwo3AVXp1yrz6PfitYQtrrbzUHQD9plyVUzMjHtm4agoDkN+lrEEhC
        s+pSJzDQ==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejdX-0002ti-Qx; Sat, 22 Jun 2019 17:17:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejdV-00014T-6i; Sat, 22 Jun 2019 14:17:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sphinx/kernel_feat.py: add a script to parse feature files
Date:   Sat, 22 Jun 2019 14:17:06 -0300
Message-Id: <98079ee5c60fd03477c7fab7c7c3dcf338082900.1561222784.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561222784.git.mchehab+samsung@kernel.org>
References: <cover.1561222784.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature files have a special well-defined format. Add
a script that parses them, allowing to search for a feature
and/or by an architecture and to produce ReST-compatible
outputs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_feat.py | 169 ++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/sphinx/kernel_feat.py

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
-- 
2.21.0

