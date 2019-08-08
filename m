Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EAC32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB3217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IjPYZ6ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfHHGbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:31:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:31:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x786VIBC3013592
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 23:31:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x786VIBC3013592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565245878;
        bh=OnRdDif2XqLH5UEH4/KlNGhdeyLoxKF3RQndw6EbQ0w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IjPYZ6ETjGPCtOc4gF9FtVNJ4xqwX1hIwu//Nlo1QxW7YMji1O4yYTT6DV28bUQYE
         AK9Rh4RI9dey+P0ecimbaTg1m5CHTWXCq+9awYzKiwTbJ5MuuwGJzfsl05iyitZFQj
         rHa6JNTuo5dmrFLn4+Cf8Oa86K/iEU6dr9j7+Of6bWIj84tixGHOw56RCm0qc3VPiq
         DbiLu0HZFJ7IguE1u2CWkxpVGAdjwQ4iMbi6eGHOV1yNxmNucCl3NefOD1v6N6AuRz
         tLRnyaMYhxJfJsE031nbgH3yY/f1+mqw8b2lcWh8gl8rmQWMSZwdVD2/18lM26RdTt
         97c4lQcm6NA/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x786VIKE3013589;
        Wed, 7 Aug 2019 23:31:18 -0700
Date:   Wed, 7 Aug 2019 23:31:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-4ce97317f41d38584fb93578e922fcd19e535f5b@git.kernel.org>
Cc:     adelva@google.com, vaibhavrustagi@google.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@kernel.org,
        manojgupta@google.com
Reply-To: vaibhavrustagi@google.com, linux-kernel@vger.kernel.org,
          adelva@google.com, ndesaulniers@google.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, manojgupta@google.com
In-Reply-To: <20190807221539.94583-1-ndesaulniers@google.com>
References: <20190807221539.94583-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/purgatory: Do not use __builtin_memcpy and
 __builtin_memset
Git-Commit-ID: 4ce97317f41d38584fb93578e922fcd19e535f5b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4ce97317f41d38584fb93578e922fcd19e535f5b
Gitweb:     https://git.kernel.org/tip/4ce97317f41d38584fb93578e922fcd19e535f5b
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Wed, 7 Aug 2019 15:15:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Aug 2019 08:25:52 +0200

x86/purgatory: Do not use __builtin_memcpy and __builtin_memset

Implementing memcpy and memset in terms of __builtin_memcpy and
__builtin_memset is problematic.

GCC at -O2 will replace calls to the builtins with calls to memcpy and
memset (but will generate an inline implementation at -Os).  Clang will
replace the builtins with these calls regardless of optimization level.
$ llvm-objdump -dr arch/x86/purgatory/string.o | tail

0000000000000339 memcpy:
     339: 48 b8 00 00 00 00 00 00 00 00 movabsq $0, %rax
                000000000000033b:  R_X86_64_64  memcpy
     343: ff e0                         jmpq    *%rax

0000000000000345 memset:
     345: 48 b8 00 00 00 00 00 00 00 00 movabsq $0, %rax
                0000000000000347:  R_X86_64_64  memset
     34f: ff e0

Such code results in infinite recursion at runtime. This is observed
when doing kexec.

Instead, reuse an implementation from arch/x86/boot/compressed/string.c.
This requires to implement a stub function for warn(). Also, Clang may
lower memcmp's that compare against 0 to bcmp's, so add a small definition,
too. See also: commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")

Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Alistair Delva <adelva@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc: stable@vger.kernel.org
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=984056
Link: https://lkml.kernel.org/r/20190807221539.94583-1-ndesaulniers@google.com

---
 arch/x86/boot/string.c         |  8 ++++++++
 arch/x86/purgatory/Makefile    |  3 +++
 arch/x86/purgatory/purgatory.c |  6 ++++++
 arch/x86/purgatory/string.c    | 23 -----------------------
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 401e30ca0a75..8272a4492844 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -37,6 +37,14 @@ int memcmp(const void *s1, const void *s2, size_t len)
 	return diff;
 }
 
+/*
+ * Clang may lower `memcmp == 0` to `bcmp == 0`.
+ */
+int bcmp(const void *s1, const void *s2, size_t len)
+{
+	return memcmp(s1, s2, len);
+}
+
 int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 3cf302b26332..91ef244026d2 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -6,6 +6,9 @@ purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
+$(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
 $(obj)/sha256.o: $(srctree)/lib/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 6d8d5a34c377..b607bda786f6 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -68,3 +68,9 @@ void purgatory(void)
 	}
 	copy_backup_region();
 }
+
+/*
+ * Defined in order to reuse memcpy() and memset() from
+ * arch/x86/boot/compressed/string.c
+ */
+void warn(const char *msg) {}
diff --git a/arch/x86/purgatory/string.c b/arch/x86/purgatory/string.c
deleted file mode 100644
index 01ad43873ad9..000000000000
--- a/arch/x86/purgatory/string.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Simple string functions.
- *
- * Copyright (C) 2014 Red Hat Inc.
- *
- * Author:
- *       Vivek Goyal <vgoyal@redhat.com>
- */
-
-#include <linux/types.h>
-
-#include "../boot/string.c"
-
-void *memcpy(void *dst, const void *src, size_t len)
-{
-	return __builtin_memcpy(dst, src, len);
-}
-
-void *memset(void *dst, int c, size_t len)
-{
-	return __builtin_memset(dst, c, len);
-}
