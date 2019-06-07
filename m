Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DDAC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559923126;
	bh=Mk5P4fya3KDDGfujSsNIgINShNzGSC6TdI4Mp4kjOcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sleq7xmp/dXpzpYS93whVW4Dhk5Cx4cbArufMRPuWDqUVAIiwD9zAKqZs0cXKs01s
	 hNVLvp+iDbpS6eApScr3JTPOKPd7oRLudMKmxFFtf2ltNa1zRAjOmhIJ2Cj9iUJY8F
	 Pw40EDaF0rutFcDE8OqRQNDiaB6Hza4JS3MMifh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfFGPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbfFGPmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:42:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E162147A;
        Fri,  7 Jun 2019 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922144;
        bh=Mk5P4fya3KDDGfujSsNIgINShNzGSC6TdI4Mp4kjOcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT72/HQYU8RzCOYfsRNUECSnZ2QlV+FAevqlXOVNWajyv512lNbzx6KQU3oTOP4yJ
         hxIRBbz25s0eXsQ2tmKZT/G5MNM913VDPC85GpbHH78V+9Fy9Ydf+OsM36xeVQ8x8I
         QqrI/nP0A6W1SDC4zbz4YyyzMCv8m/1Ax+5vqYBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4.14 53/69] doc: Cope with the deprecation of AutoReporter
Date:   Fri,  7 Jun 2019 17:39:34 +0200
Message-Id: <20190607153854.768374834@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
References: <20190607153848.271562617@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

commit 2404dad1f67f8917e30fc22a85e0dbcc85b99955 upstream.

AutoReporter is going away; recent versions of sphinx emit a warning like:

  Documentation/sphinx/kerneldoc.py:125:
      RemovedInSphinx20Warning: AutodocReporter is now deprecated.
      Use sphinx.util.docutils.switch_source_input() instead.

Make the switch.  But switch_source_input() only showed up in 1.7, so we
have to do ugly version checks to keep things working in older versions.

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/sphinx/kerneldoc.py |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

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
 
 __version__  = '1.0'
 
@@ -117,13 +127,7 @@ class KernelDocDirective(Directive):
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
 
@@ -132,6 +136,20 @@ class KernelDocDirective(Directive):
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


