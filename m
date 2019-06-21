Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC08CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9107E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561130892;
	bh=PducdwPLFZP9azYnGPXaoHu1SEIoxu9sstvwxYommpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JHTUp4Ckm1aesfOrq+5YGv7SEe93+vBzGiD0fFM2wTZy9E8hNTV8fA9+d948oOM98
	 5OEVRpaeSpecsTudTJ0lWrcHt+ygB46AIp6/S43Y7FZaDLPTeYW7RUSL6LrLzOYtYu
	 9otdjtpu1ZMUoArKzXcONQhN895NuBANW5B2wPUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFUP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:28:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFUP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OxYHxuhO2A3jKgWH7QzxkO6AYqKVbir/TdN17HPdksE=; b=Vv006MlNVoSUf9KgGWQStu1nZw
        /T9uCiyMM059iy8zwxh/6DZ67a9kwa5ZlKGL1kGYAbXRxILQRaWsxYXUGSsNMY4r6f2b6DtJE1qPj
        TayUoi8+6dO9x2A5j8g8vdSyzQHyAi6G6y0EV0b8lrD8IORh5zMOcfMdqP4HKlrOihy6enxCHjMaU
        OhMiWG3Z0EWozb71BnNyo8xK3XO0tBdnD4FiRR3ERo5IEzb57BeTJabGcoobaXzwDecHkGSSa56eE
        +b/oqWdJorVRtoSe+5jD125dF3BCiFV2UIIJ0QoR7smOgt2db0szOwaFPDejZKwPspQJ6xA4rGuRX
        QD5CbvfA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heLSR-0006As-KA; Fri, 21 Jun 2019 15:28:07 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heLSO-0005iF-Ja; Fri, 21 Jun 2019 12:28:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        gregkh@linuxfoundation.org
Subject: [PATCH 2/2] docs: kernel_abi.py: use --enable-lineno for get_abi.pl
Date:   Fri, 21 Jun 2019 12:28:02 -0300
Message-Id: <3d64e957b8fb9bd17d4d7f7dbc4d77d76091d44d.1561130657.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561130657.git.mchehab+samsung@kernel.org>
References: <cover.1561130657.git.mchehab+samsung@kernel.org>
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
index 88dddb8f4152..7f00f9d04a53 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -35,6 +35,7 @@ import codecs
 import os
 import subprocess
 import sys
+import re
 
 from os import path
 
@@ -93,7 +94,7 @@ class KernelCmd(Directive):
 
         env = doc.settings.env
         cwd = path.dirname(doc.current_source)
-        cmd = "get_abi.pl rest --dir "
+        cmd = "get_abi.pl rest --enable-lineno --dir "
 
         cmd += self.arguments[0]
 
@@ -141,7 +142,7 @@ class KernelCmd(Directive):
                               % (self.name, ErrorString(exc)))
         return out
 
-    def nestedParse(self, lines, fname):
+    def nestedParse(self, lines, f):
         content = ViewList()
         node    = nodes.section()
 
@@ -151,8 +152,17 @@ class KernelCmd(Directive):
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

