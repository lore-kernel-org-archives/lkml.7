Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01255218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVL+QaS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfDXMsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:48:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34556 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfDXMsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k2796xg19+l0hrTXGXsQsOq/dPhZUcLZsq+I7Beh2B0=; b=BVL+QaS5xnbca/B9P8BSLWdWss
        uJxwxwMi+oOHluI5p4a1kZ6AyDHHXeKsc0ZQD4tfHvL4yP6ui3dKw7dPgDyze+J2nZtRxD/gNlm8S
        44rTO6/VkpuetbhCxC3zvgq/QJwCA8nqd64P3b4ezVxGRZmeZ0qIqkfs06yP22JIxWqf9X89xRpm8
        SzxrmmoN72tPN8rIZwNI72N8Nh5g64yYZVmGNg6Ci11Wsuqve1j4WzxP75uvBof3ydxma6O0+h93B
        5upAriHTD+rGybhKyAkeFB9mnV+Anm1XSOLpDAWckvkn9pT7FUt/K2Z1Ce/oBcmDjqTru3rpMt/mj
        0sJFaBZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHJS-0003HL-0D; Wed, 24 Apr 2019 12:47:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6748A2038D7B2; Wed, 24 Apr 2019 14:47:43 +0200 (CEST)
Message-Id: <20190424124421.636767843@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 14:36:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>,
        Paul Burton <paul.burton@mips.com>
Subject: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
References: <20190424123656.484227701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment describing the loongson_llsc_mb() reorder case doesn't
make any sense what so ever. Instruction re-ordering is not an SMP
artifact, but rather a CPU local phenomenon. This means that _every_
LL/SC loop needs this barrier right in front to avoid the CPU from
leaking a memop inside it.

For the branch speculation case; if futex_atomic_cmpxchg_inatomic()
needs one at the bne branch target, then surely the normal
__cmpxch_asmg() implementation does too. We cannot rely on the
barriers from cmpxchg() because cmpxchg_local() is implemented with
the same macro, and branch prediction and speculation are, too, CPU
local.

Fixes: e02e07e3127d ("MIPS: Loongson: Introduce and use loongson_llsc_mb()")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Huang Pei <huangpei@loongson.cn>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h  |   24 ++++++++++++++++++++----
 arch/mips/include/asm/barrier.h |    7 ++-----
 arch/mips/include/asm/bitops.h  |    5 +++++
 arch/mips/include/asm/cmpxchg.h |    5 +++++
 arch/mips/include/asm/local.h   |    2 ++
 arch/mips/kernel/syscall.c      |    1 +
 6 files changed, 35 insertions(+), 9 deletions(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -193,6 +193,7 @@ static __inline__ int atomic_sub_if_posi
 	if (kernel_uses_llsc) {
 		int temp;
 
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
@@ -200,16 +201,23 @@ static __inline__ int atomic_sub_if_posi
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
 		: "Ir" (i));
+
+		if (!IS_ENABLED(CONFIG_SMP))
+			loongson_llsc_mb();
+		/*
+		 * Otherwise the loongson_llsc_mb() for the bltz target is
+		 * implied by the smp_llsc_mb() below.
+		 */
 	} else {
 		unsigned long flags;
 
@@ -395,20 +403,28 @@ static __inline__ long atomic64_sub_if_p
 	if (kernel_uses_llsc) {
 		long temp;
 
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
-		"	bltz	%0, 1f					\n"
+		"	bltz	%0, 2f					\n"
 		"	scd	%1, %2					\n"
 		"\t" __scbeqz "	%1, 1b					\n"
-		"1:							\n"
+		"2:							\n"
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
+
+		if (!IS_ENABLED(CONFIG_SMP))
+			loongson_llsc_mb();
+		/*
+		 * Otherwise the loongson_llsc_mb() for the bltz target is
+		 * implied by the smp_llsc_mb() below.
+		 */
 	} else {
 		unsigned long flags;
 
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -248,10 +248,7 @@
  *
  *    In order to avoid this we need to place a memory barrier (ie. a sync
  *    instruction) prior to every ll instruction, in between it & any earlier
- *    memory access instructions. Many of these cases are already covered by
- *    smp_mb__before_llsc() but for the remaining cases, typically ones in
- *    which multiple CPUs may operate on a memory location but ordering is not
- *    usually guaranteed, we use loongson_llsc_mb() below.
+ *    memory access instructions.
  *
  *    This reordering case is fixed by 3A R2 CPUs, ie. 3A2000 models and later.
  *
@@ -267,7 +264,7 @@
  *    This case affects all current Loongson 3 CPUs.
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
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -49,6 +49,7 @@ static __inline__ long local_add_return(
 	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
@@ -96,6 +97,7 @@ static __inline__ long local_sub_return(
 	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
+		loongson_llsc_mb();
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
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


