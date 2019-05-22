Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E86C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7291C217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfEVUu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:50:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:49340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfEVUu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:57 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id D9DC0128A;
        Wed, 22 May 2019 20:50:56 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/8] doc: Cope with the deprecation of AutoReporter
Date:   Wed, 22 May 2019 14:50:28 -0600
Message-Id: <20190522205034.25724-3-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AutoReporter is going away; recent versions of sphinx emit a warning like:

  /stuff/k/git/kernel/Documentation/sphinx/kerneldoc.py:125:
      RemovedInSphinx20Warning: AutodocReporter is now deprecated.
      Use sphinx.util.docutils.switch_source_input() instead.

Make the switch.  But switch_source_input() only showed up in 1.7, so we
have to do ugly version checks to keep things working in older versions.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kerneldoc.py | 34 +++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 200c8aa4a04f..1159405cb920 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -37,7 +37,17 @@ import glob
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from sphinx.ext.autodoc import AutodocReporter
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
 
 import kernellog
 
@@ -125,13 +135,7 @@ class KernelDocDirective(Directive):
                     lineoffset += 1
 
             node = nodes.section()
-            buf = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
-            self.state.memo.title_styles, self.state.memo.section_level = [], 0
-            try:
-                self.state.nested_parse(result, 0, node, match_titles=1)
-            finally:
-                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+            self.do_parse(result, node)
 
             return node.children
 
@@ -140,6 +144,20 @@ class KernelDocDirective(Directive):
                            (" ".join(cmd), str(e)))
             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
 
+    def do_parse(self, result, node):
+        if Use_SSI:
+            with switch_source_input(self.state, result):
+                self.state.nested_parse(result, 0, node, match_titles=1)
+        else:
+            save = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+            self.state.memo.reporter = AutodocReporter(result, self.state.memo.reporter)
+            self.state.memo.title_styles, self.state.memo.section_level = [], 0
+            try:
+                self.state.nested_parse(result, 0, node, match_titles=1)
+            finally:
+                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = save
+
+
 def setup(app):
     app.add_config_value('kerneldoc_bin', None, 'env')
     app.add_config_value('kerneldoc_srctree', None, 'env')
-- 
2.21.0

