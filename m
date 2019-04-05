Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E837C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751720663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDEVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:45:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:51871 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfDEVo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:44:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 14:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="140486250"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2019 14:44:55 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kernel-doc: Rename -function to -symbol
Date:   Fri,  5 Apr 2019 14:44:52 -0700
Message-Id: <20190405214453.18768-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405214453.18768-1-sean.j.christopherson@intel.com>
References: <20190405214453.18768-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -function option applies to all symbol types, not just functions.
Rename it and update its help text and comments to reflect reality.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 Documentation/sphinx/kerneldoc.py | 4 ++--
 scripts/kernel-doc                | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9d0a7f08f93b..c52b6caac356 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -73,12 +73,12 @@ class KernelDocDirective(Directive):
             cmd += ['-internal']
             export_file_patterns = str(self.options.get('internal')).split()
         elif 'doc' in self.options:
-            cmd += ['-function', str(self.options.get('doc'))]
+            cmd += ['-symbol', str(self.options.get('doc'))]
         elif 'functions' in self.options:
             functions = self.options.get('functions').split()
             if functions:
                 for f in functions:
-                    cmd += ['-function', f]
+                    cmd += ['-symbol', f]
             else:
                 cmd += ['-no-doc-sections']
 
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9190110b9802..60ef90222a51 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -63,10 +63,10 @@ Output selection (mutually exclusive):
   -internal		Only output documentation for symbols that have NOT been
 			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
                         in any input FILE or -export-file FILE.
-  -function NAME	Only output documentation for the given function(s)
-			or DOC: section title(s). All other functions and DOC:
+  -symbols	NAME	Only output documentation for the given symbol(s)
+			or DOC: section title(s). All other symbols and DOC:
 			sections are ignored. May be specified multiple times.
-  -nosymbol NAME	Do NOT output documentation for the given symbol(s);
+  -nosymbol	NAME	Do NOT output documentation for the given symbol(s);
 			only output documentation for the other symbols and
 			DOC: sections. May be specified multiple times.
 
@@ -409,7 +409,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$output_mode = "none";
     } elsif ($cmd eq "module") { # not needed for XML, inherits from calling document
 	$modulename = shift @ARGV;
-    } elsif ($cmd eq "function") { # to only output specific function
+    } elsif ($cmd eq "symbol") { # to only output specific symbol
 	$output_selection = OUTPUT_INCLUDE;
 	$function = shift @ARGV;
 	$function_table{$function} = 1;
-- 
2.21.0

