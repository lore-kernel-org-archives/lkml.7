Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71780C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C7B20679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222772;
	bh=SHX3lD0VzLQO1bzcsOuVaWBuWiz6t/PJpl5Xz0r+vp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjZ5+jr1IjDB1TUOx+tc0w8z0BEpGA2dFx7xVUvGu1AlPjyJ5Z5oYMu0R7bAliVNA
	 dmMUSYOoEOMml2SR43qF4z8vfqYhRjbEPVU90f3f9s+n2igDzeo10lr1JTtaLFhSnR
	 FbLTGWoZe3tAv9CHxRNHtWBQJr/9upz0bqPGGul4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfFVQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfFVQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aYkO21+57WhHrMos1KtTm4cyY8Mb4Xx9tR+j2J1rYNI=; b=dOqZCFvSr/KGjvvUWsOekDkCkZ
        VO75FYeYSM2/sabjOnNASvZF9UvmvJAd2xJQm0MkTqVk8RZzkXbzwpsqhXHxIuG3vywskXm0LJQOe
        sQ3aSNzWPGKa26fOj+4hRCgcnXNXI5KAaeq2xRsUsqvmHUlAtlR46dV1qpLhVI7jGnC5wbUcKHWl0
        fvYO0WB5RmV6maWdeulE5L2eyxs76i06SxCCcM5AM5SexdyKJ4prqPlgnRtaFxnlowH5XMWQm/WFW
        dc+r+RT8vYbcZhvZlPysM52ibNia8fTBxYXfo9/xTEkoA2ylMgL1Kh05Qh13Fg9nAZq2Yr6Nc7/SQ
        jXbprTiw==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLz-00054v-1V; Sat, 22 Jun 2019 16:59:03 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLs-0000vo-2X; Sat, 22 Jun 2019 13:58:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] docs: kernel_abi.py: Handle with a lazy Sphinx parser
Date:   Sat, 22 Jun 2019 13:58:52 -0300
Message-Id: <31bb430e89d3c4e7320fd9e976a76a5675d5c590.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sphinx docutils parser is lazy: if the content is bigger than
a certain number of lines, it silenlty stops parsing it,
producing an incomplete content. This seems to be worse on newer
Sphinx versions, like 2.0.

So, change the logic to parse the contents per input file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 39 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index efa338e18764..a417026ed690 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -36,6 +36,7 @@ import os
 import subprocess
 import sys
 import re
+import kernellog
 
 from os import path
 
@@ -79,12 +80,6 @@ class KernelCmd(Directive):
         "debug"     : directives.flag
     }
 
-    def warn(self, message, **replace):
-        replace["fname"]   = self.state.document.current_source
-        replace["line_no"] = replace.get("line_no", self.lineno)
-        message = ("%(fname)s:%(line_no)s: [kernel-abi WARN] : " + message) % replace
-        self.state.document.settings.env.app.warn(message, prefix="")
-
     def run(self):
 
         doc = self.state.document
@@ -110,7 +105,7 @@ class KernelCmd(Directive):
         shell_env["srctree"] = srctree
 
         lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
-        nodeList = self.nestedParse(lines, fname)
+        nodeList = self.nestedParse(lines, self.arguments[0])
         return nodeList
 
     def runCmd(self, cmd, **kwargs):
@@ -137,9 +132,9 @@ class KernelCmd(Directive):
                               % (self.name, ErrorString(exc)))
         return out
 
-    def nestedParse(self, lines, f):
+    def nestedParse(self, lines, fname):
         content = ViewList()
-        node    = nodes.section()
+        node = nodes.section()
 
         if "debug" in self.options:
             code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
@@ -149,22 +144,42 @@ class KernelCmd(Directive):
 
         line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
         ln = 0
+        n = 0
+        f = fname
 
         for line in lines.split("\n"):
+            n = n + 1
             match = line_regex.search(line)
             if match:
-                f = match.group(1)
+                new_f = match.group(1)
+
+                # Sphinx parser is lazy: it stops parsing contents in the
+                # middle, if it is too big. So, handle it per input file
+                if new_f != f and content:
+                    self.do_parse(content, node)
+                    content = ViewList()
+
+                f = new_f
+
                 # sphinx counts lines from 0
                 ln = int(match.group(2)) - 1
             else:
                 content.append(line, f, ln)
 
-        buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+        kernellog.info(self.state.document.settings.env.app, "%s: parsed %i lines" % (fname, n))
 
+        if content:
+            self.do_parse(content, node)
+
+        return node.children
+
+    def do_parse(self, content, node):
         if Use_SSI:
             with switch_source_input(self.state, content):
                 self.state.nested_parse(content, 0, node, match_titles=1)
         else:
+            buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+
             self.state.memo.title_styles  = []
             self.state.memo.section_level = 0
             self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
@@ -172,5 +187,3 @@ class KernelCmd(Directive):
                 self.state.nested_parse(content, 0, node, match_titles=1)
             finally:
                 self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
-
-        return node.children
-- 
2.21.0

