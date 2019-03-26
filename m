Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7EF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfCZMla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:41:30 -0400
Received: from retiisi.org.uk ([95.216.213.190]:42376 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731477AbfCZMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:41:11 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 0C545634C83;
        Tue, 26 Mar 2019 14:41:05 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/6] lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
Date:   Tue, 26 Mar 2019 14:41:04 +0200
Message-Id: <20190326124106.27694-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%pS and %ps are now the preferred conversion specifiers to print function
%names. The functionality is equivalent; remove the old, deprecated %pF
%and %pf support.

Depends-on: ("treewide: Switch printk users from %pf and %pF to %ps and
	      %pS, respectively")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 10 ----------
 lib/vsprintf.c                            |  8 ++------
 scripts/checkpatch.pl                     |  1 -
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c37ec7cd9c06..c90826a1ff17 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -78,8 +78,6 @@ Symbols/Function Pointers
 
 	%pS	versatile_init+0x0/0x110
 	%ps	versatile_init
-	%pF	versatile_init+0x0/0x110
-	%pf	versatile_init
 	%pSR	versatile_init+0x9/0x110
 		(with __builtin_extract_return_addr() translation)
 	%pB	prev_fn_of_versatile_init+0x88/0x88
@@ -89,14 +87,6 @@ The ``S`` and ``s`` specifiers are used for printing a pointer in symbolic
 format. They result in the symbol name with (S) or without (s)
 offsets. If KALLSYMS are disabled then the symbol address is printed instead.
 
-Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
-and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
-parisc64 function pointers are indirect and, in fact, are function
-descriptors, which require additional dereferencing before we can lookup
-the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
-platforms (when needed), so ``F`` and ``f`` exist for compatibility
-reasons only.
-
 The ``B`` specifier results in the symbol name with offsets and should be
 used when printing stack backtraces. The specifier takes into
 consideration the effect of compiler optimisations which may occur
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 791b6fa36905..5f60b8d41277 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -797,7 +797,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #ifdef CONFIG_KALLSYMS
 	if (*fmt == 'B')
 		sprint_backtrace(sym, value);
-	else if (*fmt != 'f' && *fmt != 's')
+	else if (*fmt != 's')
 		sprint_symbol(sym, value);
 	else
 		sprint_symbol_no_offset(sym, value);
@@ -1853,9 +1853,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  *
  * - 'S' For symbolic direct pointers (or function descriptors) with offset
  * - 's' For symbolic direct pointers (or function descriptors) without offset
- * - 'F' Same as 'S'
- * - 'f' Same as 's'
- * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
+ * - '[Ss]R' as above with __builtin_extract_return_addr() translation
  * - 'B' For backtraced symbolic direct pointers with offset
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
  * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
@@ -1970,8 +1968,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	}
 
 	switch (*fmt) {
-	case 'F':
-	case 'f':
 	case 'S':
 	case 's':
 		ptr = dereference_symbol_descriptor(ptr);
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b756278df13..b2e80259fb8c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5994,7 +5994,6 @@ sub process {
 					my $ext_type = "Invalid";
 					my $use = "";
 					if ($bad_specifier =~ /p[Ff]/) {
-						$ext_type = "Deprecated";
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
 					}
-- 
2.11.0

