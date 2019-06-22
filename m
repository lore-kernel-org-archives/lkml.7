Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1695C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A85420675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222754;
	bh=ipAnUHiXjTEL/Vvt9v5F2Orf7IAKvOxeWADrSavweNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JErWYphLcMMy+dJpgVCanQdVWlxqt1xcwzsDosXpiQ0kVXR3Zo8LKgiJ+7LTIQf2m
	 Ijg/LCZe0InH1mUxxQrPz850ssWfRXPuxv2njAp9pYNzNKakJvVMBsF6/o3WGtvofK
	 Em/9jkDNnWds2fRLL++A3g2V2x8+1NUOb5uM5vfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFVQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4yo27ijYQu1yYo30q/R/RGMGUqSkkm83kufrAmJA9ng=; b=aG0oHNyitqdv4BKL74sEhz3za+
        wy0ANv0OsdGgH5c3Dmg9WThh3df+r39AeC+isJD0GLw1eknwlznaEqfDFFCWKmjNDx+NEO4pnQbCc
        ZYD/Xxm955zlUxAEg2K9tKCbRQKiFxvG9LvUolOQm39uyQg+2IYOfU65K8NetdoZaZHqDqyQtYz0D
        eOVSvSlxoTyAzPsyYWfexJsDFHu/cOIG2khPAslNre9bB4x9AWARih+th/OtGuTrMXkzRZ3Ab36n3
        t5W1tesi235ox9iRV2IWohcC7Ptd35JfjZFPZiWC28c/qz3qTVWsBoR+B0MZSQQCsxNSXBoXamZWV
        N6RBxJ3w==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054n-HS; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000vY-Vd; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] docs: kernel_abi.py: make it compatible with Sphinx 1.7+
Date:   Sat, 22 Jun 2019 13:58:48 -0300
Message-Id: <c0e5c974d3abb398e6fbeb55cd86602104e4afbb.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same way kerneldoc.py needed changes to work with newer
Sphinx, this script needs the same changes.

While here, reorganize the include order to match kerneldoc.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 39 +++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 0f3e51e67e8d..2d5d582207f7 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -30,18 +30,27 @@ u"""
 """
 
 import codecs
-import sys
 import os
-from os import path
 import subprocess
+import sys
 
-from sphinx.ext.autodoc import AutodocReporter
+from os import path
 
-from docutils import nodes
-from docutils.parsers.rst import Directive, directives
+from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
 from docutils.utils.error_reporting import ErrorString
 
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
 
@@ -139,11 +148,17 @@ class KernelCmd(Directive):
             content.append(l, fname, c)
 
         buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
-        self.state.memo.title_styles  = []
-        self.state.memo.section_level = 0
-        self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
-        try:
-            self.state.nested_parse(content, 0, node, match_titles=1)
-        finally:
-            self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
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
         return node.children
-- 
2.21.0

