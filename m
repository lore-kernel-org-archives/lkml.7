Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED07C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542E20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MkjTgoJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfIQUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:24:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31811 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfIQUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:24:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Xvhr3l7Zz9vKHf;
        Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MkjTgoJZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5TBdUO123Nwr; Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Xvhr2Lysz9vKHW;
        Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568751852; bh=/YM+jLAkL7rzYV6U2c34h3wDM7tw/nIeNfV5WeHFCUQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=MkjTgoJZ5mUZlcA2++bRs1zV0SKr0qwOnD9cNCmMbQXIbUeUuiyyfHwNllsJEHn2o
         c7FzdMB3GxdM1GGYb3xl1dRD9Uq0b15LyOiJdQsA6Ail0ra93d4emPga2zYxKyMNG2
         XkKeu3Il+YCRTHjhLrUBnX/Gpoh3t6PL/u3nI/oU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59CB48B8B4;
        Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Oeul_87x7YQ8; Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 143558B8B1;
        Tue, 17 Sep 2019 22:24:12 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D27B769881; Tue, 17 Sep 2019 20:24:11 +0000 (UTC)
Message-Id: <c7e545f7a2fb470ba0ad76d3e7fd58086b929f92.1568751807.git.christophe.leroy@c-s.fr>
In-Reply-To: <512ec59433470a2dfb0d1168e0c660b843fe92d5.1568751807.git.christophe.leroy@c-s.fr>
References: <512ec59433470a2dfb0d1168e0c660b843fe92d5.1568751807.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 17 Sep 2019 20:24:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_do_irq() and call_do_softirq() are quite similar on PPC32 and
PPC64 and are simple enough to be worth inlining.

Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.

This is inspired from S390 arch. Several other arches do more or
less the same. The way sparc arch does seems odd thought.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/irq.h |  2 --
 arch/powerpc/kernel/irq.c      | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S  | 25 -------------------------
 arch/powerpc/kernel/misc_64.S  | 22 ----------------------
 4 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 52adec9a379d..d3da269b0cc6 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -56,8 +56,6 @@ extern void *mcheckirq_ctx[NR_CPUS];
 extern void *hardirq_ctx[NR_CPUS];
 extern void *softirq_ctx[NR_CPUS];
 
-void call_do_softirq(void *sp);
-void call_do_irq(struct pt_regs *regs, void *sp);
 extern void do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 04204be49577..b028c49f9635 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -642,6 +642,20 @@ void __do_irq(struct pt_regs *regs)
 	irq_exit();
 }
 
+static inline void call_do_irq(struct pt_regs *regs, void *sp)
+{
+	register unsigned long r3 asm("r3") = (unsigned long)regs;
+
+	asm volatile(
+		"	"PPC_STLU"	1, %2(%1);\n"
+		"	mr		1, %1;\n"
+		"	bl		%3;\n"
+		"	"PPC_LL"	1, 0(1);\n" : "+r"(r3) :
+		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
+		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
+		"r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
+}
+
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
@@ -686,6 +700,18 @@ void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
 
+static inline void call_do_softirq(const void *sp)
+{
+	asm volatile(
+		"	"PPC_STLU"	1, %1(%0);\n"
+		"	mr		1, %0;\n"
+		"	bl		%2;\n"
+		"	"PPC_LL"	1, 0(1);\n" : :
+		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_softirq) :
+		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
+		"r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
+}
+
 void do_softirq_own_stack(void)
 {
 	void *irqsp = softirq_ctx[smp_processor_id()];
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index a5422f7782b3..307307b57743 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -33,31 +33,6 @@
 
 	.text
 
-_GLOBAL(call_do_softirq)
-	mflr	r0
-	stw	r0,4(r1)
-	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
-	mr	r1,r3
-	bl	__do_softirq
-	lwz	r1,0(r1)
-	lwz	r0,4(r1)
-	mtlr	r0
-	blr
-
-/*
- * void call_do_irq(struct pt_regs *regs, void *sp);
- */
-_GLOBAL(call_do_irq)
-	mflr	r0
-	stw	r0,4(r1)
-	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
-	mr	r1,r4
-	bl	__do_irq
-	lwz	r1,0(r1)
-	lwz	r0,4(r1)
-	mtlr	r0
-	blr
-
 /*
  * This returns the high 64 bits of the product of two 64-bit numbers.
  */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index b55a7b4cb543..69fd714a5236 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -27,28 +27,6 @@
 
 	.text
 
-_GLOBAL(call_do_softirq)
-	mflr	r0
-	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
-	mr	r1,r3
-	bl	__do_softirq
-	ld	r1,0(r1)
-	ld	r0,16(r1)
-	mtlr	r0
-	blr
-
-_GLOBAL(call_do_irq)
-	mflr	r0
-	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
-	mr	r1,r4
-	bl	__do_irq
-	ld	r1,0(r1)
-	ld	r0,16(r1)
-	mtlr	r0
-	blr
-
 	.section	".toc","aw"
 PPC64_CACHES:
 	.tc		ppc64_caches[TC],ppc64_caches
-- 
2.13.3

