Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756492087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfCQOaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:30:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56489 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfCQOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:30:23 -0400
Received: from [2a01:598:b88d:24ef:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h5Wns-00067o-A5; Sun, 17 Mar 2019 15:30:20 +0100
Date:   Sun, 17 Mar 2019 15:29:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [GIT pull] x86/asm update for 5.1-rc1
Message-ID: <alpine.DEB.2.21.1903171527010.9068@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

Two cleanup patches removing dead conditionals and unused code.

Thanks,

	tglx

------------------>
Rasmus Villemoes (2):
      x86/asm: Remove dead __GNUC__ conditionals
      x86/asm: Remove unused __constant_c_x_memset() macro and inlines


 arch/x86/include/asm/bitops.h    |   6 ---
 arch/x86/include/asm/string_32.h | 104 ---------------------------------------
 arch/x86/include/asm/string_64.h |  15 ------
 3 files changed, 125 deletions(-)

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
