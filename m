Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8103C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9111E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKYITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:19:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38700 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKYIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:19:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZ9aR-0001QS-LA; Mon, 25 Nov 2019 09:19:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 576301C1AF3;
        Mon, 25 Nov 2019 09:19:11 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:19:11 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/refcount: Consolidate implementations of
 refcount_t
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121115902.2551-9-will@kernel.org>
References: <20191121115902.2551-9-will@kernel.org>
MIME-Version: 1.0
Message-ID: <157466995127.21853.8023988577315790855.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca
Gitweb:        https://git.kernel.org/tip/fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:59:00 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2019 09:15:32 +01:00

locking/refcount: Consolidate implementations of refcount_t

The generic implementation of refcount_t should be good enough for
everybody, so remove ARCH_HAS_REFCOUNT and REFCOUNT_FULL entirely,
leaving the generic implementation enabled unconditionally.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191121115902.2551-9-will@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig                       |  21 +----
 arch/arm/Kconfig                   |   1 +-
 arch/arm64/Kconfig                 |   1 +-
 arch/s390/configs/debug_defconfig  |   1 +-
 arch/x86/Kconfig                   |   1 +-
 arch/x86/include/asm/asm.h         |   6 +-
 arch/x86/include/asm/refcount.h    | 126 +----------------------
 arch/x86/mm/extable.c              |  49 +---------
 drivers/gpu/drm/i915/Kconfig.debug |   1 +-
 include/linux/refcount.h           | 158 ++++++++++------------------
 lib/refcount.c                     |   2 +-
 11 files changed, 59 insertions(+), 308 deletions(-)
 delete mode 100644 arch/x86/include/asm/refcount.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 5f8a5d8..8bcc1c7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -892,27 +892,6 @@ config STRICT_MODULE_RWX
 config ARCH_HAS_PHYS_TO_DMA
 	bool
 
-config ARCH_HAS_REFCOUNT
-	bool
-	help
-	  An architecture selects this when it has implemented refcount_t
-	  using open coded assembly primitives that provide an optimized
-	  refcount_t implementation, possibly at the expense of some full
-	  refcount state checks of CONFIG_REFCOUNT_FULL=y.
-
-	  The refcount overflow check behavior, however, must be retained.
-	  Catching overflows is the primary security concern for protecting
-	  against bugs in reference counts.
-
-config REFCOUNT_FULL
-	bool "Perform full reference count validation at the expense of speed"
-	help
-	  Enabling this switches the refcounting infrastructure from a fast
-	  unchecked atomic_t implementation to a fully state checked
-	  implementation, which can be (slightly) slower but provides protections
-	  against various use-after-free conditions that can be used in
-	  security flaw exploits.
-
 config HAVE_ARCH_COMPILER_H
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a50efb..0d3c5d7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -117,7 +117,6 @@ config ARM
 	select OLD_SIGSUSPEND3
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
-	select REFCOUNT_FULL
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 41a9b42..bc990d3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -181,7 +181,6 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
-	select REFCOUNT_FULL
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 38d6403..2e60c80 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -62,7 +62,6 @@ CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_STATIC_KEYS_SELFTEST=y
-CONFIG_REFCOUNT_FULL=y
 CONFIG_LOCK_EVENT_COUNTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa..fa6274f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -73,7 +73,6 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
-	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ff577c..5a0c14e 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -139,9 +139,6 @@
 # define _ASM_EXTABLE_EX(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
 
-# define _ASM_EXTABLE_REFCOUNT(from, to)			\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
-
 # define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
@@ -170,9 +167,6 @@
 # define _ASM_EXTABLE_EX(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
 
-# define _ASM_EXTABLE_REFCOUNT(from, to)			\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
-
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 #endif
 
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
deleted file mode 100644
index 232f856..0000000
--- a/arch/x86/include/asm/refcount.h
+++ /dev/null
@@ -1,126 +0,0 @@
-#ifndef __ASM_X86_REFCOUNT_H
-#define __ASM_X86_REFCOUNT_H
-/*
- * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
- * PaX/grsecurity.
- */
-#include <linux/refcount.h>
-#include <asm/bug.h>
-
-/*
- * This is the first portion of the refcount error handling, which lives in
- * .text.unlikely, and is jumped to from the CPU flag check (in the
- * following macros). This saves the refcount value location into CX for
- * the exception handler to use (in mm/extable.c), and then triggers the
- * central refcount exception. The fixup address for the exception points
- * back to the regular execution flow in .text.
- */
-#define _REFCOUNT_EXCEPTION				\
-	".pushsection .text..refcount\n"		\
-	"111:\tlea %[var], %%" _ASM_CX "\n"		\
-	"112:\t" ASM_UD2 "\n"				\
-	ASM_UNREACHABLE					\
-	".popsection\n"					\
-	"113:\n"					\
-	_ASM_EXTABLE_REFCOUNT(112b, 113b)
-
-/* Trigger refcount exception if refcount result is negative. */
-#define REFCOUNT_CHECK_LT_ZERO				\
-	"js 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
-
-/* Trigger refcount exception if refcount result is zero or negative. */
-#define REFCOUNT_CHECK_LE_ZERO				\
-	"jz 111f\n\t"					\
-	REFCOUNT_CHECK_LT_ZERO
-
-/* Trigger refcount exception unconditionally. */
-#define REFCOUNT_ERROR					\
-	"jmp 111f\n\t"					\
-	_REFCOUNT_EXCEPTION
-
-static __always_inline void refcount_add(unsigned int i, refcount_t *r)
-{
-	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
-		: [var] "+m" (r->refs.counter)
-		: "ir" (i)
-		: "cc", "cx");
-}
-
-static __always_inline void refcount_inc(refcount_t *r)
-{
-	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		REFCOUNT_CHECK_LT_ZERO
-		: [var] "+m" (r->refs.counter)
-		: : "cc", "cx");
-}
-
-static __always_inline void refcount_dec(refcount_t *r)
-{
-	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		REFCOUNT_CHECK_LE_ZERO
-		: [var] "+m" (r->refs.counter)
-		: : "cc", "cx");
-}
-
-static __always_inline __must_check
-bool refcount_sub_and_test(unsigned int i, refcount_t *r)
-{
-	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
-					 REFCOUNT_CHECK_LT_ZERO,
-					 r->refs.counter, e, "er", i, "cx");
-
-	if (ret) {
-		smp_acquire__after_ctrl_dep();
-		return true;
-	}
-
-	return false;
-}
-
-static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
-{
-	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
-					 REFCOUNT_CHECK_LT_ZERO,
-					 r->refs.counter, e, "cx");
-
-	if (ret) {
-		smp_acquire__after_ctrl_dep();
-		return true;
-	}
-
-	return false;
-}
-
-static __always_inline __must_check
-bool refcount_add_not_zero(unsigned int i, refcount_t *r)
-{
-	int c, result;
-
-	c = atomic_read(&(r->refs));
-	do {
-		if (unlikely(c == 0))
-			return false;
-
-		result = c + i;
-
-		/* Did we try to increment from/to an undesirable state? */
-		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile(REFCOUNT_ERROR
-				     : : [var] "m" (r->refs.counter)
-				     : "cc", "cx");
-			break;
-		}
-
-	} while (!atomic_try_cmpxchg(&(r->refs), &c, result));
-
-	return c != 0;
-}
-
-static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
-{
-	return refcount_add_not_zero(1, r);
-}
-
-#endif
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 4d75bc6..30bb0bd 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -45,55 +45,6 @@ __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL_GPL(ex_handler_fault);
 
 /*
- * Handler for UD0 exception following a failed test against the
- * result of a refcount inc/dec/add/sub.
- */
-__visible bool ex_handler_refcount(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr,
-				   unsigned long error_code,
-				   unsigned long fault_addr)
-{
-	/* First unconditionally saturate the refcount. */
-	*(int *)regs->cx = INT_MIN / 2;
-
-	/*
-	 * Strictly speaking, this reports the fixup destination, not
-	 * the fault location, and not the actually overflowing
-	 * instruction, which is the instruction before the "js", but
-	 * since that instruction could be a variety of lengths, just
-	 * report the location after the overflow, which should be close
-	 * enough for finding the overflow, as it's at least back in
-	 * the function, having returned from .text.unlikely.
-	 */
-	regs->ip = ex_fixup_addr(fixup);
-
-	/*
-	 * This function has been called because either a negative refcount
-	 * value was seen by any of the refcount functions, or a zero
-	 * refcount value was seen by refcount_dec().
-	 *
-	 * If we crossed from INT_MAX to INT_MIN, OF (Overflow Flag: result
-	 * wrapped around) will be set. Additionally, seeing the refcount
-	 * reach 0 will set ZF (Zero Flag: result was zero). In each of
-	 * these cases we want a report, since it's a boundary condition.
-	 * The SF case is not reported since it indicates post-boundary
-	 * manipulations below zero or above INT_MAX. And if none of the
-	 * flags are set, something has gone very wrong, so report it.
-	 */
-	if (regs->flags & (X86_EFLAGS_OF | X86_EFLAGS_ZF)) {
-		bool zero = regs->flags & X86_EFLAGS_ZF;
-
-		refcount_error_report(regs, zero ? "hit zero" : "overflow");
-	} else if ((regs->flags & X86_EFLAGS_SF) == 0) {
-		/* Report if none of OF, ZF, nor SF are set. */
-		refcount_error_report(regs, "unexpected saturation");
-	}
-
-	return true;
-}
-EXPORT_SYMBOL(ex_handler_refcount);
-
-/*
  * Handler for when we fail to restore a task's FPU state.  We should never get
  * here because the FPU state of a task using the FPU (task->thread.fpu.state)
  * should always be valid.  However, past bugs have allowed userspace to set
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 00786a1..1400fce 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -22,7 +22,6 @@ config DRM_I915_DEBUG
         depends on DRM_I915
         select DEBUG_FS
         select PREEMPT_COUNT
-        select REFCOUNT_FULL
         select I2C_CHARDEV
         select STACKDEPOT
         select DRM_DP_AUX_CHARDEV
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 757d463..0ac50cf 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -1,64 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_REFCOUNT_H
-#define _LINUX_REFCOUNT_H
-
-#include <linux/atomic.h>
-#include <linux/compiler.h>
-#include <linux/limits.h>
-#include <linux/spinlock_types.h>
-
-struct mutex;
-
-/**
- * struct refcount_t - variant of atomic_t specialized for reference counts
- * @refs: atomic_t counter field
- *
- * The counter saturates at REFCOUNT_SATURATED and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free bugs.
- */
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
-#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
-enum refcount_saturation_type {
-	REFCOUNT_ADD_NOT_ZERO_OVF,
-	REFCOUNT_ADD_OVF,
-	REFCOUNT_ADD_UAF,
-	REFCOUNT_SUB_UAF,
-	REFCOUNT_DEC_LEAK,
-};
-
-void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
-
-/**
- * refcount_set - set a refcount's value
- * @r: the refcount
- * @n: value to which the refcount will be set
- */
-static inline void refcount_set(refcount_t *r, int n)
-{
-	atomic_set(&r->refs, n);
-}
-
-/**
- * refcount_read - get a refcount's value
- * @r: the refcount
- *
- * Return: the refcount's value
- */
-static inline unsigned int refcount_read(const refcount_t *r)
-{
-	return atomic_read(&r->refs);
-}
-
-#ifdef CONFIG_REFCOUNT_FULL
-#include <linux/bug.h>
-
 /*
  * Variant of atomic_t specialized for reference counts.
  *
@@ -136,6 +76,64 @@ static inline unsigned int refcount_read(const refcount_t *r)
  *
  */
 
+#ifndef _LINUX_REFCOUNT_H
+#define _LINUX_REFCOUNT_H
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/limits.h>
+#include <linux/spinlock_types.h>
+
+struct mutex;
+
+/**
+ * struct refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+#define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
+
+enum refcount_saturation_type {
+	REFCOUNT_ADD_NOT_ZERO_OVF,
+	REFCOUNT_ADD_OVF,
+	REFCOUNT_ADD_UAF,
+	REFCOUNT_SUB_UAF,
+	REFCOUNT_DEC_LEAK,
+};
+
+void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
+
+/**
+ * refcount_set - set a refcount's value
+ * @r: the refcount
+ * @n: value to which the refcount will be set
+ */
+static inline void refcount_set(refcount_t *r, int n)
+{
+	atomic_set(&r->refs, n);
+}
+
+/**
+ * refcount_read - get a refcount's value
+ * @r: the refcount
+ *
+ * Return: the refcount's value
+ */
+static inline unsigned int refcount_read(const refcount_t *r)
+{
+	return atomic_read(&r->refs);
+}
+
 /**
  * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
@@ -298,46 +296,6 @@ static inline void refcount_dec(refcount_t *r)
 	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
-#else /* CONFIG_REFCOUNT_FULL */
-# ifdef CONFIG_ARCH_HAS_REFCOUNT
-#  include <asm/refcount.h>
-# else
-static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
-{
-	return atomic_add_unless(&r->refs, i, 0);
-}
-
-static inline void refcount_add(int i, refcount_t *r)
-{
-	atomic_add(i, &r->refs);
-}
-
-static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
-{
-	return atomic_add_unless(&r->refs, 1, 0);
-}
-
-static inline void refcount_inc(refcount_t *r)
-{
-	atomic_inc(&r->refs);
-}
-
-static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
-{
-	return atomic_sub_and_test(i, &r->refs);
-}
-
-static inline __must_check bool refcount_dec_and_test(refcount_t *r)
-{
-	return atomic_dec_and_test(&r->refs);
-}
-
-static inline void refcount_dec(refcount_t *r)
-{
-	atomic_dec(&r->refs);
-}
-# endif /* !CONFIG_ARCH_HAS_REFCOUNT */
-#endif /* !CONFIG_REFCOUNT_FULL */
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
diff --git a/lib/refcount.c b/lib/refcount.c
index 8b7e249..ebac8b7 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Out-of-line refcount functions common to all refcount implementations.
+ * Out-of-line refcount functions.
  */
 
 #include <linux/mutex.h>
