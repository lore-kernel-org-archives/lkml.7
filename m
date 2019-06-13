Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5342C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D6420896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVen7Bl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbfFMPKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbfFMNvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fjXzmITMVOoNvNjljFDnvaCzY9NwQmPBhP4eMTbt0cg=; b=RVen7Bl1B8MzvMEMWh+y4+2uAh
        z4Om+wKVlkkAUPXcsF5V1SdgYwOwQ6Zg0TJXYhVlCtQWg3vwVukzhOFuv1yQgEauTQq30e0nKd0GC
        T8/80Kd/rYPmYJArRFG4y7LpO7FU1mq8DjyBwX3Gctyg2NoSZQmGMCvTy7TKdKJbIo9x6UgsgyO6s
        6eD1crpRk3pk/gzXjUqr3crVbkRb1jna1vf0bSkJl0lVZR9J6New+biJQhZcj6Axc1pn8SXq1Vrc5
        lOaQuRHbtfCJPMzKBjZ1G+XGGlXZCNTGffhzortrdQ+k1ftobvqqo6pRWYlTUVCyM/2wSjYMV0LBM
        5aanoDTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQ80-0001Ga-2z; Thu, 13 Jun 2019 13:50:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 013D8203165B1; Thu, 13 Jun 2019 15:50:54 +0200 (CEST)
Message-Id: <20190613134932.954074997@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:43:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com, paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: [PATCH v2 2/4] mips/atomic: Fix loongson_llsc_mb() wreckage
References: <20190613134317.734881240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment describing the loongson_llsc_mb() reorder case doesn't
make any sense what so ever. Instruction re-ordering is not an SMP
artifact, but rather a CPU local phenomenon. Clarify the comment by
explaining that these issue cause a coherence fail.

For the branch speculation case; if futex_atomic_cmpxchg_inatomic()
needs one at the bne branch target, then surely the normal
__cmpxch_asm() implementation does too. We cannot rely on the
barriers from cmpxchg() because cmpxchg_local() is implemented with
the same macro, and branch prediction and speculation are, too, CPU
local.

Fixes: e02e07e3127d ("MIPS: Loongson: Introduce and use loongson_llsc_mb()")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Huang Pei <huangpei@loongson.cn>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h  |    5 +++--
 arch/mips/include/asm/barrier.h |   32 ++++++++++++++++++--------------
 arch/mips/include/asm/bitops.h  |    5 +++++
 arch/mips/include/asm/cmpxchg.h |    5 +++++
 arch/mips/kernel/syscall.c      |    1 +
 5 files changed, 32 insertions(+), 16 deletions(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -193,6 +193,7 @@ static __inline__ int atomic_sub_if_posi
 	if (kernel_uses_llsc) {
 		int temp;
 
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
@@ -200,12 +201,12 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	pop					\n"
 		"	subu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
-		"	bltz	%0, 1f					\n"
+		"	bltz	%0, 2f					\n"
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	sc	%1, %2					\n"
 		"\t" __scbeqz "	%1, 1b					\n"
-		"1:							\n"
+		"2:							\n"
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -238,36 +238,40 @@
 
 /*
  * Some Loongson 3 CPUs have a bug wherein execution of a memory access (load,
- * store or pref) in between an ll & sc can cause the sc instruction to
+ * store or prefetch) in between an LL & SC can cause the SC instruction to
  * erroneously succeed, breaking atomicity. Whilst it's unusual to write code
  * containing such sequences, this bug bites harder than we might otherwise
  * expect due to reordering & speculation:
  *
- * 1) A memory access appearing prior to the ll in program order may actually
- *    be executed after the ll - this is the reordering case.
+ * 1) A memory access appearing prior to the LL in program order may actually
+ *    be executed after the LL - this is the reordering case.
  *
- *    In order to avoid this we need to place a memory barrier (ie. a sync
- *    instruction) prior to every ll instruction, in between it & any earlier
- *    memory access instructions. Many of these cases are already covered by
- *    smp_mb__before_llsc() but for the remaining cases, typically ones in
- *    which multiple CPUs may operate on a memory location but ordering is not
- *    usually guaranteed, we use loongson_llsc_mb() below.
+ *    In order to avoid this we need to place a memory barrier (ie. a SYNC
+ *    instruction) prior to every LL instruction, in between it and any earlier
+ *    memory access instructions.
  *
  *    This reordering case is fixed by 3A R2 CPUs, ie. 3A2000 models and later.
  *
- * 2) If a conditional branch exists between an ll & sc with a target outside
- *    of the ll-sc loop, for example an exit upon value mismatch in cmpxchg()
+ * 2) If a conditional branch exists between an LL & SC with a target outside
+ *    of the LL-SC loop, for example an exit upon value mismatch in cmpxchg()
  *    or similar, then misprediction of the branch may allow speculative
- *    execution of memory accesses from outside of the ll-sc loop.
+ *    execution of memory accesses from outside of the LL-SC loop.
  *
- *    In order to avoid this we need a memory barrier (ie. a sync instruction)
+ *    In order to avoid this we need a memory barrier (ie. a SYNC instruction)
  *    at each affected branch target, for which we also use loongson_llsc_mb()
  *    defined below.
  *
  *    This case affects all current Loongson 3 CPUs.
+ *
+ * The above described cases cause an error in the cache coherence protocol;
+ * such that the Invalidate of a competing LL-SC goes 'missing' and SC
+ * erroneously observes its core still has Exclusive state and lets the SC
+ * proceed.
+ *
+ * Therefore the error only occurs on SMP systems.
  */
 #ifdef CONFIG_CPU_LOONGSON3_WORKAROUNDS /* Loongson-3's LLSC workaround */
-#define loongson_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
+#define loongson_llsc_mb()	__asm__ __volatile__("sync" : : :"memory")
 #else
 #define loongson_llsc_mb()	do { } while (0)
 #endif
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -249,6 +249,7 @@ static inline int test_and_set_bit(unsig
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	push				\n"
@@ -305,6 +306,7 @@ static inline int test_and_set_bit_lock(
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	push				\n"
@@ -364,6 +366,7 @@ static inline int test_and_clear_bit(uns
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
@@ -379,6 +382,7 @@ static inline int test_and_clear_bit(uns
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	push				\n"
@@ -438,6 +442,7 @@ static inline int test_and_change_bit(un
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		do {
 			__asm__ __volatile__(
 			"	.set	push				\n"
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -46,6 +46,7 @@ extern unsigned long __xchg_called_with_
 	__typeof(*(m)) __ret;						\
 									\
 	if (kernel_uses_llsc) {						\
+		loongson_llsc_mb();					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
@@ -117,6 +118,7 @@ static inline unsigned long __xchg(volat
 	__typeof(*(m)) __ret;						\
 									\
 	if (kernel_uses_llsc) {						\
+		loongson_llsc_mb();					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
@@ -134,6 +136,7 @@ static inline unsigned long __xchg(volat
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
+		loongson_llsc_mb();					\
 	} else {							\
 		unsigned long __flags;					\
 									\
@@ -229,6 +232,7 @@ static inline unsigned long __cmpxchg64(
 	 */
 	local_irq_save(flags);
 
+	loongson_llsc_mb();
 	asm volatile(
 	"	.set	push				\n"
 	"	.set	" MIPS_ISA_ARCH_LEVEL "		\n"
@@ -274,6 +278,7 @@ static inline unsigned long __cmpxchg64(
 	  "r" (old),
 	  "r" (new)
 	: "memory");
+	loongson_llsc_mb();
 
 	local_irq_restore(flags);
 	return ret;
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -132,6 +132,7 @@ static inline int mips_atomic_set(unsign
 		  [efault] "i" (-EFAULT)
 		: "memory");
 	} else if (cpu_has_llsc) {
+		loongson_llsc_mb();
 		__asm__ __volatile__ (
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"


