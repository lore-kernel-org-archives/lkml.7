Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB1C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776A204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477887;
	bh=mvwhLYy37gijYgvPzQqcnUY69SiRiZ7VeRND73EnfEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggXF4hsHQpHoSheXEDwtuS5ERFs9xHTvdZrPWvD0jHqYMrmxukqdaNJTy37IK7fan
	 ydzrnVuuqbv5MjpM2IMptwnWrysB4tER7wd93Fnr8Ce/i0upQqKmhN01+TNDm81Ibe
	 dmbsgF5o/5qdVHObodwL/oMKRwVblR7EIImVPd30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfFNCEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfFNCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2lZSJSMx6Y3MRGPxe0M3M6eDqWU4ZSMnhOq/IvfM44w=; b=r+3HHuXPGS3ZtKMbIKZ/3LhfYS
        dN1J2cRHSXcLomjjfYB7rcZYIOlTtPXB9ZlJ+GXpTEngauoLdyiBgw9Q6w4bUsdBDfp4IFkBj1oag
        fw+nAbYDRdmoWbPhUjVTf/hBlNir0nvXNLMKWzrgqdR9VUgTusVAzeCYvpQ8W3dktAW0TKeofKQIh
        kK0gn+Wg9UQ2CIzoiim26Prh0kAM1seD34W63Cj77+iPzcqu4vl/kS7jjJzfO/Oe4/ihOQMjq6Sb4
        wc1IXqTcO2SrBH+zR60kb6t6K0rwx7Y+ApcF2Ec/4+JSIuFTb/6btIgsmtUCZS5nCr7bPh4QFaKgx
        lFWuTsoA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZv-0000EG-1y; Fri, 14 Jun 2019 02:04:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZo-0002oK-16; Thu, 13 Jun 2019 23:04:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 13/14] sphinx/kernel_abi.py: make it compatible with Sphinx 1.7+
Date:   Thu, 13 Jun 2019 23:04:19 -0300
Message-Id: <b612c507d40fc4c175bc0884bfb64903b1c52e0f.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same way kerneldoc.py needed changes to work with newer
Sphinx, this script needs the same changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 31 ++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 32ce90775d96..7fa7806532dc 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -33,7 +33,16 @@ import os
 from os import path
 import subprocess
 
-from sphinx.ext.autodoc import AutodocReporter
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
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -145,11 +154,17 @@ class KernelCmd(Directive):
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

