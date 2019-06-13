Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B73BC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF7620896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFMTChXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbfFMPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbfFMNvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gyYwmo558t82wMk+Xft5j1Hxt2su0A1y8PA29lib60Q=; b=eFMTChXBq8CHJMY5xViVNER5Mt
        sklSYe3EDfMih33t1zyXOKDvVW6d1BwWUWbLeTMRDXwrWZsi5EPAnE/v2O+2vKEJmWiStx5lW3VsM
        eMFy0Gq2h1P/zlb8Lud6h1hZvJ98e5WQYhx4+wQI1mNc2NWI6BWucDFbBX0OJx2ntA9AS5Wef0nyv
        0l1CSd482xtaMzDCA2/keAT0UcVR4YjWcxpfrFx42dxNgOMg0Wtb4ONqk71m554i/18kEVBSQE4Jc
        HSlvWUdv8jk1pii8siEsE8NcL3JULowFo5Kdu1e0pz07UYrukZNWctF4PxgybzCc5OS1AhlcqAa1V
        j/0v9cHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQ80-0001GT-2y; Thu, 13 Jun 2019 13:50:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 08B4B20435AA8; Thu, 13 Jun 2019 15:50:54 +0200 (CEST)
Message-Id: <20190613134933.048961704@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:43:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com, paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH v2 3/4] mips/atomic: Fix smp_mb__{before,after}_atomic()
References: <20190613134317.734881240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent probing at the Linux Kernel Memory Model uncovered a
'surprise'. Strongly ordered architectures where the atomic RmW
primitive implies full memory ordering and
smp_mb__{before,after}_atomic() are a simple barrier() (such as MIPS
without WEAK_REORDERING_BEYOND_LLSC) fail for:

	*x = 1;
	atomic_inc(u);
	smp_mb__after_atomic();
	r0 = *y;

Because, while the atomic_inc() implies memory order, it
(surprisingly) does not provide a compiler barrier. This then allows
the compiler to re-order like so:

	atomic_inc(u);
	*x = 1;
	smp_mb__after_atomic();
	r0 = *y;

Which the CPU is then allowed to re-order (under TSO rules) like:

	atomic_inc(u);
	r0 = *y;
	*x = 1;

And this very much was not intended. Therefore strengthen the atomic
RmW ops to include a compiler barrier.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h  |   14 ++++++-------
 arch/mips/include/asm/barrier.h |   12 +++++++++--
 arch/mips/include/asm/bitops.h  |   42 +++++++++++++++++++++++-----------------
 arch/mips/include/asm/cmpxchg.h |    6 ++---
 4 files changed, 45 insertions(+), 29 deletions(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -68,7 +68,7 @@ static __inline__ void atomic_##op(int i
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -98,7 +98,7 @@ static __inline__ int atomic_##op##_retu
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -132,7 +132,7 @@ static __inline__ int atomic_fetch_##op#
 		"	move	%0, %1					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -210,7 +210,7 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i));
+		: "Ir" (i) : __LLSC_CLOBBER);
 	} else {
 		unsigned long flags;
 
@@ -270,7 +270,7 @@ static __inline__ void atomic64_##op(s64
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -300,7 +300,7 @@ static __inline__ s64 atomic64_##op##_re
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -334,7 +334,7 @@ static __inline__ s64 atomic64_fetch_##o
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -211,14 +211,22 @@
 #define __smp_wmb()	barrier()
 #endif
 
+/*
+ * When LL/SC does imply order, it must also be a compiler barrier to avoid the
+ * compiler from reordering where the CPU will not. When it does not imply
+ * order, the compiler is also free to reorder across the LL/SC loop and
+ * ordering will be done by smp_llsc_mb() and friends.
+ */
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
 #define __WEAK_LLSC_MB		"	sync	\n"
+#define smp_llsc_mb()		__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
+#define __LLSC_CLOBBER
 #else
 #define __WEAK_LLSC_MB		"		\n"
+#define smp_llsc_mb()		do { } while (0)
+#define __LLSC_CLOBBER		"memory"
 #endif
 
-#define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
-
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
 #define __smp_mb__before_llsc() __smp_wmb()
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -66,7 +66,8 @@ static inline void set_bit(unsigned long
 		"	beqzl	%0, 1b					\n"
 		"	.set	pop					\n"
 		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
+		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m)
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		loongson_llsc_mb();
@@ -76,7 +77,8 @@ static inline void set_bit(unsigned long
 			"	" __INS "%0, %3, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit), "r" (~0));
+			: "ir" (bit), "r" (~0)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
@@ -90,7 +92,8 @@ static inline void set_bit(unsigned long
 			"	" __SC	"%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_set_bit(nr, addr);
@@ -122,7 +125,8 @@ static inline void clear_bit(unsigned lo
 		"	beqzl	%0, 1b					\n"
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (~(1UL << bit)));
+		: "ir" (~(1UL << bit))
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		loongson_llsc_mb();
@@ -132,7 +136,8 @@ static inline void clear_bit(unsigned lo
 			"	" __INS "%0, $0, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit));
+			: "ir" (bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
@@ -146,7 +151,8 @@ static inline void clear_bit(unsigned lo
 			"	" __SC "%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (~(1UL << bit)));
+			: "ir" (~(1UL << bit))
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_clear_bit(nr, addr);
@@ -192,7 +198,8 @@ static inline void change_bit(unsigned l
 		"	beqzl	%0, 1b				\n"
 		"	.set	pop				\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (1UL << bit));
+		: "ir" (1UL << bit)
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -207,7 +214,8 @@ static inline void change_bit(unsigned l
 			"	" __SC	"%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_change_bit(nr, addr);
@@ -244,7 +252,7 @@ static inline int test_and_set_bit(unsig
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -260,7 +268,7 @@ static inline int test_and_set_bit(unsig
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -301,7 +309,7 @@ static inline int test_and_set_bit_lock(
 		"	.set	pop					\n"
 		: "=&r" (temp), "+m" (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -317,7 +325,7 @@ static inline int test_and_set_bit_lock(
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -360,7 +368,7 @@ static inline int test_and_clear_bit(uns
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -375,7 +383,7 @@ static inline int test_and_clear_bit(uns
 			"	" __SC	"%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "ir" (bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif
 	} else if (kernel_uses_llsc) {
@@ -394,7 +402,7 @@ static inline int test_and_clear_bit(uns
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -437,7 +445,7 @@ static inline int test_and_change_bit(un
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -453,7 +461,7 @@ static inline int test_and_change_bit(un
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -61,7 +61,7 @@ extern unsigned long __xchg_called_with_
 		"	.set	pop				\n"	\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)			\
-		: "memory");						\
+		: __LLSC_CLOBBER);					\
 	} else {							\
 		unsigned long __flags;					\
 									\
@@ -134,8 +134,8 @@ static inline unsigned long __xchg(volat
 		"	.set	pop				\n"	\
 		"2:						\n"	\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
-		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
-		: "memory");						\
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)	\
+		: __LLSC_CLOBBER);					\
 		loongson_llsc_mb();					\
 	} else {							\
 		unsigned long __flags;					\


