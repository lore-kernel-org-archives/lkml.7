Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E4C32758
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D27217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfHJUIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:08:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfHJUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:08:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwXek-0007tk-VP; Sat, 10 Aug 2019 22:08:03 +0200
Date:   Sat, 10 Aug 2019 20:01:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc4
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
Message-ID: <156546731195.17538.5037114068802413527.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  04f5bda84b07: x86/lib/cpu: Address missing prototypes warning

A few fixes for x86:

 - Don't reset the carefully adjusted build flags for the purgatory and
   remove the unwanted flags instead. The 'reset all' approach led to build
   fails under certain circumstances.

 - Unbreak CLANG build of the purgatory by avoiding the builtin
   memcpy/memset implementations.

 - Address missing prototype warnings by including the proper header

 - Fix yet more fall-through issues

Thanks,

	tglx

------------------>
Gustavo A. R. Silva (2):
      x86/ptrace: Mark expected switch fall-through
      x86: mtrr: cyrix: Mark expected switch fall-through

Nick Desaulniers (2):
      x86/purgatory: Do not use __builtin_memcpy and __builtin_memset
      x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS

Valdis Kletnieks (1):
      x86/lib/cpu: Address missing prototypes warning


 arch/x86/boot/string.c           |  8 ++++++++
 arch/x86/kernel/cpu/mtrr/cyrix.c |  1 +
 arch/x86/kernel/ptrace.c         |  1 +
 arch/x86/lib/cpu.c               |  1 +
 arch/x86/purgatory/Makefile      | 36 +++++++++++++++++++++++++++++++-----
 arch/x86/purgatory/purgatory.c   |  6 ++++++
 arch/x86/purgatory/string.c      | 23 -----------------------
 7 files changed, 48 insertions(+), 28 deletions(-)
 delete mode 100644 arch/x86/purgatory/string.c

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
diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 4296c702a3f7..72182809b333 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -98,6 +98,7 @@ cyrix_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	case 7:
 		if (size < 0x40)
 			break;
+		/* Else, fall through */
 	case 6:
 	case 5:
 	case 4:
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 0fdbe89d0754..3c5bbe8e4120 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -201,6 +201,7 @@ static int set_segment_reg(struct task_struct *task,
 	case offsetof(struct user_regs_struct, ss):
 		if (unlikely(value == 0))
 			return -EIO;
+		/* Else, fall through */
 
 	default:
 		*pt_regs_access(task_pt_regs(task), offset) = value;
diff --git a/arch/x86/lib/cpu.c b/arch/x86/lib/cpu.c
index 04967cdce5d1..7ad68917a51e 100644
--- a/arch/x86/lib/cpu.c
+++ b/arch/x86/lib/cpu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/types.h>
 #include <linux/export.h>
+#include <asm/cpu.h>
 
 unsigned int x86_family(unsigned int sig)
 {
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 3cf302b26332..8901a1f89cf5 100644
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
 
@@ -17,11 +20,34 @@ KCOV_INSTRUMENT := n
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-# sure how to relocate those. Like kexec-tools, use custom flags.
-
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
-KBUILD_CFLAGS += -m$(BITS)
-KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+# sure how to relocate those.
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_sha256.o		+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_purgatory.o	+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_string.o		+= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_kexec-purgatory.o	+= $(CC_FLAGS_FTRACE)
+endif
+
+ifdef CONFIG_STACKPROTECTOR
+CFLAGS_REMOVE_sha256.o		+= -fstack-protector
+CFLAGS_REMOVE_purgatory.o	+= -fstack-protector
+CFLAGS_REMOVE_string.o		+= -fstack-protector
+CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector
+endif
+
+ifdef CONFIG_STACKPROTECTOR_STRONG
+CFLAGS_REMOVE_sha256.o		+= -fstack-protector-strong
+CFLAGS_REMOVE_purgatory.o	+= -fstack-protector-strong
+CFLAGS_REMOVE_string.o		+= -fstack-protector-strong
+CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector-strong
+endif
+
+ifdef CONFIG_RETPOLINE
+CFLAGS_REMOVE_sha256.o		+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_purgatory.o	+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_string.o		+= $(RETPOLINE_CFLAGS)
+CFLAGS_REMOVE_kexec-purgatory.o	+= $(RETPOLINE_CFLAGS)
+endif
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
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

