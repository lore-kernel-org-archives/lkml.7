Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B002C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE00620679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222784;
	bh=wtbdst6zH0+kuX43YMwUoimhCkpe2IzP6DFwcw+i/uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gb0ZFB0YdMGYZrjxOkQ4tQ8f2J7oCeoHeKHqbJF8e+u3N26O8DSudLGDHGhoey5vO
	 n0XxYwFBuc2NeLa4jjvJWUAQa+9lmJZ+S0ToAyZeSCyKSYidpJ34i+aVgb+N2UOrF7
	 fXUrOOXg0qtWBGaMRl9ztZ8dMc0YM0yVHnUqldJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PIAs7lJjyaQE53dcQ6QY9JIHl8hWEaQxmoiFris3yfc=; b=RNZueuofP4rWNEkgKeRA6Qp5b6
        yHz/3qXs+pJBMtsYXbeK7lv17sFFpExKcm9GKo48Is6R1fdqVOECyBkQ9VMyVFUPZtmjwAVSciyso
        6x/CX9LaYfRwzDY/d1IeGe8CPWkuM2ASuQoQ1n/qojxT83QeYWwd9u+y1axrZYVLJnCk0wPMg1Z7R
        nUtjXCEY3D16NCpnGZtQS9RNoD7MpB4CLOzfIFxytTbGdwr2hO0Ci40bq9O7PpokUJuWeMjrYDu7d
        vlZ3U8BmzMT/HdD/CKCDNFoJ7BkJmhXRUfisZOjbCQ84TFfjJURuYoK72tfUGdcoBHTI4GHUMR1N+
        zOR7TcHA==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054o-GY; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000vP-U0; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] docs: kernel_abi.py: add a script to parse ABI documentation
Date:   Sat, 22 Jun 2019 13:58:46 -0300
Message-Id: <cfff325dcb2c55e6c1052fc7f60a83d561296cc4.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI documentation is special: it is not plain text files,
but, instead, files with an strict format, as specified by
Documentation/ABI/README.

Add a parser for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 155 +++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/sphinx/kernel_abi.py

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
new file mode 100644
index 000000000000..32ce90775d96
--- /dev/null
+++ b/Documentation/sphinx/kernel_abi.py
@@ -0,0 +1,155 @@
+# -*- coding: utf-8; mode: python -*-
+u"""
+    kernel-abi
+    ~~~~~~~~~~
+
+    Implementation of the ``kernel-abi`` reST-directive.
+
+    :copyright:  Copyright (C) 2016  Markus Heiser
+    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
+    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
+
+    The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
+    scripts/get_abi.pl script to parse the Kernel ABI files.
+
+    Overview of directive's argument and options.
+
+    .. code-block:: rst
+
+        .. kernel-abi:: <ABI directory location>
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
+import sys
+import os
+from os import path
+import subprocess
+
+from sphinx.ext.autodoc import AutodocReporter
+
+from docutils import nodes
+from docutils.parsers.rst import Directive, directives
+from docutils.statemachine import ViewList
+from docutils.utils.error_reporting import ErrorString
+
+
+__version__  = '1.0'
+
+# We can't assume that six is installed
+PY3 = sys.version_info[0] == 3
+PY2 = sys.version_info[0] == 2
+if PY3:
+    # pylint: disable=C0103, W0622
+    unicode     = str
+    basestring  = str
+
+def setup(app):
+
+    app.add_directive("kernel-abi", KernelCmd)
+    return dict(
+        version = __version__
+        , parallel_read_safe = True
+        , parallel_write_safe = True
+    )
+
+class KernelCmd(Directive):
+
+    u"""KernelABI (``kernel-abi``) directive"""
+
+    required_arguments = 1
+    optional_arguments = 0
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
+        message = ("%(fname)s:%(line_no)s: [kernel-abi WARN] : " + message) % replace
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
+        cmd = "get_abi.pl rest --dir "
+        cmd += self.arguments[0]
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
+                , universal_newlines = True
+                , **kwargs
+            )
+            out, err = proc.communicate()
+            if err:
+                self.warn(err)
+            if proc.returncode != 0:
+                raise self.severe(
+                    u"command '%s' failed with return code %d"
+                    % (cmd, proc.returncode)
+                )
+        except OSError as exc:
+            raise self.severe(u"problems with '%s' directive: %s."
+                              % (self.name, ErrorString(exc)))
+        return unicode(out)
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
+        self.state.memo.title_styles  = []
+        self.state.memo.section_level = 0
+        self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
+        try:
+            self.state.nested_parse(content, 0, node, match_titles=1)
+        finally:
+            self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+        return node.children
-- 
2.21.0

