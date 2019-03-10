Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF46C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F95207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCJLd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:33:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCJLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:33:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiH-00006R-4J; Sun, 10 Mar 2019 12:33:53 +0100
Subject: [GIT pull] x86/asm for 5.1
Message-ID: <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
Date:   Sun, 10 Mar 2019 12:33:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

The following updates for 5.1 are available:

 - Add pinning of sensitive CR0/CR4 bits, i.e. WP and SMAP/SMEP as these
   have been targets of recent exploits. This includes a lktdm test.

 - Remove unused macros/inlines and obsolete __GNUC__ conditionals.

Thanks,

	tglx

------------------>
Kees Cook (4):
      x86/asm: Pin sensitive CR4 bits
      x86/asm: Avoid taking an exception before cr4 restore
      x86/asm: Pin sensitive CR0 bits
      lkdtm: Check for SMEP clearing protections

Rasmus Villemoes (2):
      x86/asm: Remove dead __GNUC__ conditionals
      x86/asm: Remove unused __constant_c_x_memset() macro and inlines


 arch/x86/include/asm/bitops.h        |   6 --
 arch/x86/include/asm/special_insns.h |  43 ++++++++++++++-
 arch/x86/include/asm/string_32.h     | 104 -----------------------------------
 arch/x86/include/asm/string_64.h     |  15 -----
 arch/x86/kernel/cpu/common.c         |  12 +++-
 drivers/misc/lkdtm/bugs.c            |  61 ++++++++++++++++++++
 drivers/misc/lkdtm/core.c            |   1 +
 drivers/misc/lkdtm/lkdtm.h           |   1 +
 8 files changed, 116 insertions(+), 127 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index ad7b210aa3f6..d153d570bb04 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,13 +36,7 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 1)
-/* Technically wrong, but this avoids compilation errors on some gcc
-   versions. */
-#define BITOP_ADDR(x) "=m" (*(volatile long *) (x))
-#else
 #define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
-#endif
 
 #define ADDR				BITOP_ADDR(addr)
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..7fa4fe880395 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/processor-flags.h>
 #include <asm/nops.h>
 
 /*
@@ -25,7 +26,28 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	bool warn = false;
+
+again:
+	val |= X86_CR0_WP;
+	/*
+	 * In order to have the compiler not optimize away the check
+	 * after the cr4 write, mark "val" as being also an output ("+r")
+	 * by this asm() block so it will perform an explicit check, as
+	 * if it were "volatile".
+	 */
+	asm volatile("mov %0,%%cr0" : "+r" (val) : "m" (__force_order) : );
+	/*
+	 * If the MOV above was used directly as a ROP gadget we can
+	 * notice the lack of pinned bits in "val" and start the function
+	 * from the beginning to gain the WP bit for sure. And do it
+	 * without first taking the exception for a WARN().
+	 */
+	if ((val & X86_CR0_WP) != X86_CR0_WP) {
+		warn = true;
+		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
 }
 
 static inline unsigned long native_read_cr2(void)
@@ -72,9 +94,28 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
+extern volatile unsigned long cr4_pin;
+
 static inline void native_write_cr4(unsigned long val)
 {
+	unsigned long warn = 0;
+
+again:
+	val |= cr4_pin;
 	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
+	/*
+	 * If the MOV above was used directly as a ROP gadget we can
+	 * notice the lack of pinned bits in "val" and start the function
+	 * from the beginning to gain the cr4_pin bits for sure. Note
+	 * that "val" must be volatile to keep the compiler from
+	 * optimizing away this check.
+	 */
+	if ((val & cr4_pin) != cr4_pin) {
+		warn = ~val & cr4_pin;
+		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin cr4 bits: %lx; bypass attack?!\n",
+		  warn);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 55d392c6bd29..f74362b05619 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -179,14 +179,7 @@ static inline void *__memcpy3d(void *to, const void *from, size_t len)
  *	No 3D Now!
  */
 
-#if (__GNUC__ >= 4)
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-#else
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy((t), (f), (n))	\
-	 : __memcpy((t), (f), (n)))
-#endif
 
 #endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
@@ -216,29 +209,6 @@ static inline void *__memset_generic(void *s, char c, size_t count)
 /* we might want to write optimized versions of these later */
 #define __constant_count_memset(s, c, count) __memset_generic((s), (c), (count))
 
-/*
- * memset(x, 0, y) is a reasonably common thing to do, so we want to fill
- * things 32 bits at a time even when we don't know the size of the
- * area at compile-time..
- */
-static __always_inline
-void *__constant_c_memset(void *s, unsigned long c, size_t count)
-{
-	int d0, d1;
-	asm volatile("rep ; stosl\n\t"
-		     "testb $2,%b3\n\t"
-		     "je 1f\n\t"
-		     "stosw\n"
-		     "1:\ttestb $1,%b3\n\t"
-		     "je 2f\n\t"
-		     "stosb\n"
-		     "2:"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (c), "q" (count), "0" (count/4), "1" ((long)s)
-		     : "memory");
-	return s;
-}
-
 /* Added by Gertjan van Wingerde to make minix and sysv module work */
 #define __HAVE_ARCH_STRNLEN
 extern size_t strnlen(const char *s, size_t count);
@@ -247,72 +217,6 @@ extern size_t strnlen(const char *s, size_t count);
 #define __HAVE_ARCH_STRSTR
 extern char *strstr(const char *cs, const char *ct);
 
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as we by now know that both pattern and count is constant..
- */
-static __always_inline
-void *__constant_c_and_count_memset(void *s, unsigned long pattern,
-				    size_t count)
-{
-	switch (count) {
-	case 0:
-		return s;
-	case 1:
-		*(unsigned char *)s = pattern & 0xff;
-		return s;
-	case 2:
-		*(unsigned short *)s = pattern & 0xffff;
-		return s;
-	case 3:
-		*(unsigned short *)s = pattern & 0xffff;
-		*((unsigned char *)s + 2) = pattern & 0xff;
-		return s;
-	case 4:
-		*(unsigned long *)s = pattern;
-		return s;
-	}
-
-#define COMMON(x)							\
-	asm volatile("rep ; stosl"					\
-		     x							\
-		     : "=&c" (d0), "=&D" (d1)				\
-		     : "a" (eax), "0" (count/4), "1" ((long)s)	\
-		     : "memory")
-
-	{
-		int d0, d1;
-#if __GNUC__ == 4 && __GNUC_MINOR__ == 0
-		/* Workaround for broken gcc 4.0 */
-		register unsigned long eax asm("%eax") = pattern;
-#else
-		unsigned long eax = pattern;
-#endif
-
-		switch (count % 4) {
-		case 0:
-			COMMON("");
-			return s;
-		case 1:
-			COMMON("\n\tstosb");
-			return s;
-		case 2:
-			COMMON("\n\tstosw");
-			return s;
-		default:
-			COMMON("\n\tstosw\n\tstosb");
-			return s;
-		}
-	}
-
-#undef COMMON
-}
-
-#define __constant_c_x_memset(s, c, count)			\
-	(__builtin_constant_p(count)				\
-	 ? __constant_c_and_count_memset((s), (c), (count))	\
-	 : __constant_c_memset((s), (c), (count)))
-
 #define __memset(s, c, count)				\
 	(__builtin_constant_p(count)			\
 	 ? __constant_count_memset((s), (c), (count))	\
@@ -321,15 +225,7 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, size_t);
 #ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ >= 4)
 #define memset(s, c, count) __builtin_memset(s, c, count)
-#else
-#define memset(s, c, count)						\
-	(__builtin_constant_p(c)					\
-	 ? __constant_c_x_memset((s), (0x01010101UL * (unsigned char)(c)), \
-				 (count))				\
-	 : __memset((s), (c), (count)))
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMSET16
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4e4194e21a09..75314c3dbe47 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -14,21 +14,6 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
-#ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ == 4 && __GNUC_MINOR__ < 3) || __GNUC__ < 4
-#define memcpy(dst, src, len)					\
-({								\
-	size_t __len = (len);					\
-	void *__ret;						\
-	if (__builtin_constant_p(len) && __len >= 64)		\
-		__ret = __memcpy((dst), (src), __len);		\
-	else							\
-		__ret = __builtin_memcpy((dst), (src), __len);	\
-	__ret;							\
-})
-#endif
-#endif /* !CONFIG_FORTIFY_SOURCE */
-
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..7e0ea4470f8e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -312,10 +312,16 @@ static __init int setup_disable_smep(char *arg)
 }
 __setup("nosmep", setup_disable_smep);
 
+volatile unsigned long cr4_pin __ro_after_init;
+EXPORT_SYMBOL_GPL(cr4_pin);
+
 static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 {
-	if (cpu_has(c, X86_FEATURE_SMEP))
+	if (cpu_has(c, X86_FEATURE_SMEP)) {
+		if (!(cr4_pin & X86_CR4_SMEP))
+			cr4_pin |= X86_CR4_SMEP;
 		cr4_set_bits(X86_CR4_SMEP);
+	}
 }
 
 static __init int setup_disable_smap(char *arg)
@@ -334,6 +340,8 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_SMAP)) {
 #ifdef CONFIG_X86_SMAP
+		if (!(cr4_pin & X86_CR4_SMAP))
+			cr4_pin |= X86_CR4_SMAP;
 		cr4_set_bits(X86_CR4_SMAP);
 #else
 		cr4_clear_bits(X86_CR4_SMAP);
@@ -351,6 +359,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_UMIP))
 		goto out;
 
+	if (!(cr4_pin & X86_CR4_UMIP))
+		cr4_pin |= X86_CR4_UMIP;
 	cr4_set_bits(X86_CR4_UMIP);
 
 	pr_info_once("x86/cpu: User Mode Instruction Prevention (UMIP) activated\n");
diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7eebbdfbcacd..6176384b4f85 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -255,3 +255,64 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 	pr_err("FAIL: accessed page after stack!\n");
 }
+
+void lkdtm_UNSET_SMEP(void)
+{
+#ifdef CONFIG_X86_64
+#define MOV_CR4_DEPTH	64
+	void (*direct_write_cr4)(unsigned long val);
+	unsigned char *insn;
+	unsigned long cr4;
+	int i;
+
+	cr4 = native_read_cr4();
+
+	if ((cr4 & X86_CR4_SMEP) != X86_CR4_SMEP) {
+		pr_err("FAIL: SMEP not in use\n");
+		return;
+	}
+	cr4 &= ~(X86_CR4_SMEP);
+
+	pr_info("trying to clear SMEP normally\n");
+	native_write_cr4(cr4);
+	if (cr4 == native_read_cr4()) {
+		pr_err("FAIL: pinning SMEP failed!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+		return;
+	}
+	pr_info("ok: SMEP did not get cleared\n");
+
+	/*
+	 * To test the post-write pinning verification we need to call
+	 * directly into the the middle of native_write_cr4() where the
+	 * cr4 write happens, skipping the pinning. This searches for
+	 * the cr4 writing instruction.
+	 */
+	insn = (unsigned char *)native_write_cr4;
+	for (i = 0; i < MOV_CR4_DEPTH; i++) {
+		/* mov %rdi, %cr4 */
+		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)
+			break;
+	}
+	if (i >= MOV_CR4_DEPTH) {
+		pr_info("ok: cannot locate cr4 writing call gadget\n");
+		return;
+	}
+	direct_write_cr4 = (void *)(insn + i);
+
+	pr_info("trying to clear SMEP with call gadget\n");
+	direct_write_cr4(cr4);
+	if (native_read_cr4() & X86_CR4_SMEP) {
+		pr_info("ok: SMEP removal was reverted\n");
+	} else {
+		pr_err("FAIL: cleared SMEP not detected!\n");
+		cr4 |= X86_CR4_SMEP;
+		pr_info("restoring SMEP\n");
+		native_write_cr4(cr4);
+	}
+#else
+	pr_err("FAIL: this test is x86_64-only\n");
+#endif
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..fd668776414b 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -132,6 +132,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(CORRUPT_USER_DS),
+	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..9c78d7e21c13 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -26,6 +26,7 @@ void lkdtm_CORRUPT_LIST_DEL(void);
 void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
+void lkdtm_UNSET_SMEP(void);
 
 /* lkdtm_heap.c */
 void lkdtm_OVERWRITE_ALLOCATION(void);

