Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A12C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D152083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051556;
	bh=ipAnUHiXjTEL/Vvt9v5F2Orf7IAKvOxeWADrSavweNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xPBkWALRdXm8XBjmLjMh5xMtgNOcavZwyNj8K4SWDcSs9tzGV2vP0dmbp9ERDnlhF
	 Dfo6aC9QJlSUY1/GDWIaC9OYe1NCBfoc6+nagK1btZ6gmIW1RlE7W7r1H5fRAIygM9
	 rqvgbc0Lgt+qFgbU/A3SsxuMHh5guSbodJb27yjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfFTRZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4yo27ijYQu1yYo30q/R/RGMGUqSkkm83kufrAmJA9ng=; b=Bfk95lQbh+8kmjHfnS9t42zdM7
        GVOZCTygmwqJitE5dgYSWqJt/nfNKMTNHS1LyrnF+lshSqbrtJ+M1FSQvUjOJoy0oU4Ggc5R6x8SJ
        SuISoX2aHeGXxOtgw2hIa6BWQ3rAfHE4IbaEp3GYGt+5AIUbsD7thrG6REGSpp0hCt65nwOzxMVwR
        zgySLezwEm3c0O6XQVFOD9ITlGshinpnEle5PvDwxwiMPZ5eX35FaP8tQJl5dY2zAiE45eWJtAdBr
        LnIg9L5whzAHnKE7DYuEkXJwuFB6utN8Jcx3yXzBm+YPHEx0gcvIHii4ImCLDqi5xh7MCXl4ZsjiE
        d6JWBFmA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rp-77; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Db-TX; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 15/22] sphinx/kernel_abi.py: make it compatible with Sphinx 1.7+
Date:   Thu, 20 Jun 2019 14:23:07 -0300
Message-Id: <76a9db53d324ff55fca23fae86b223110aca7678.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
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

