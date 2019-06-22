Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A238C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5920679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222751;
	bh=kF0ea2LLw8u2F/cnvyPnuyKrerKYSzN9FaoL+zoSPgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ciTMYSk20haQf8rN2RIaLE56Q3pw7WlWdwD/XlN3HVpB5dA8h/9xB+ntIXgAnUuj0
	 y0qGHQwWfmkTl/dJnDIX491oF5RqLa+NBBkNZf7Wje4Is55IfW8b3xsMIDo/49Z0Tt
	 JHwv11Nu+PZTXAMQo1+AAMqhkSphk8vG3v9np/lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFVQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nwm0MuWiU+CZGPXfeq9z6A2WqAr7Jlbvc3SpX02xbaE=; b=mt+wLPE/Lm93/twaJPuBpSoBpg
        QEkWtEzGEy+SkmD28j/POVyfDygA78mdyWAp+XlU1YvKrF3EyWcxm/zKoQOkWsADS/Ncb06o2yDBI
        /qH+/M8Tq++j6IQ8SWhhqz/tXAv9yjpzE6W/GcsGKIAucqJYage4Zu/pTku0VC+4nRdnlf7kp6xaa
        4BLMi0srfPoRv4YBi+dbK1ASCdfns9kUE4qVqi1jNt4aKkoJj7EKGMd6HiZCV0uUr3LrqdfLfo7tG
        TPKN+KynCQ9HdYMCX1JT/MfisHvYTnldYiJhOTb6MqvANdJ+eSwmT+tkYlJLpqWN2LG00Q3m3zG3K
        EwvGy2oQ==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054t-FV; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLs-0000vk-1m; Sat, 22 Jun 2019 13:58:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] docs: kernel_abi.py: use --enable-lineno for get_abi.pl
Date:   Sat, 22 Jun 2019 13:58:51 -0300
Message-Id: <959b98c5ff9f2f0889e57e330246d5ac7a61b45d.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like kernel-doc extension, we need to be able to identify
what part of an imported document has issues, as reporting them
as:

	get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1689: ERROR: Unexpected indentation.

Makes a lot harder for someone to fix.

It should be noticed that it the line which will be reported is
the line where the "What:" definition is, and not the line
with actually has an error.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 5d43cac73d0a..efa338e18764 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -35,6 +35,7 @@ import codecs
 import os
 import subprocess
 import sys
+import re
 
 from os import path
 
@@ -92,7 +93,7 @@ class KernelCmd(Directive):
 
         env = doc.settings.env
         cwd = path.dirname(doc.current_source)
-        cmd = "get_abi.pl rest --dir "
+        cmd = "get_abi.pl rest --enable-lineno --dir "
         cmd += self.arguments[0]
 
         srctree = path.abspath(os.environ["srctree"])
@@ -136,7 +137,7 @@ class KernelCmd(Directive):
                               % (self.name, ErrorString(exc)))
         return out
 
-    def nestedParse(self, lines, fname):
+    def nestedParse(self, lines, f):
         content = ViewList()
         node    = nodes.section()
 
@@ -146,8 +147,17 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        for c, l in enumerate(lines.split("\n")):
-            content.append(l, fname, c)
+        line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
+        ln = 0
+
+        for line in lines.split("\n"):
+            match = line_regex.search(line)
+            if match:
+                f = match.group(1)
+                # sphinx counts lines from 0
+                ln = int(match.group(2)) - 1
+            else:
+                content.append(line, f, ln)
 
         buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
 
-- 
2.21.0

