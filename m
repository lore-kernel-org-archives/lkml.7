Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9126BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497B4217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dJ0mdpQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfC2Qi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:38:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10012 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbfC2QiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:38:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44W6qf0jLQz9tyQR;
        Fri, 29 Mar 2019 17:38:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dJ0mdpQU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Qffci-lMUeuP; Fri, 29 Mar 2019 17:38:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qd6YD2z9tyQP;
        Fri, 29 Mar 2019 17:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553877501; bh=lJBtMnSFW2yqq75oMeFEyh7+q/2Gg904rlRsTop45jI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dJ0mdpQUVrNsKqCpjYpCwOEUSV/ZunpGV8JiVVSgs0+0gnFBrVah7kUn0CAfV1KB6
         F48CzaPuPRBFKV3AAXk22WqpWHxaGUD+Ik08MFv72LUAGRblx4OGLfxWF6Xi3XuJyW
         g4s1S4iSkJMcIb9P/czr9DBsipLuZwF1K+cFIA2I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F9878B93D;
        Fri, 29 Mar 2019 17:38:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s_UK5eXNcKbS; Fri, 29 Mar 2019 17:38:23 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 591478B938;
        Fri, 29 Mar 2019 17:38:23 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4FF566FC56; Fri, 29 Mar 2019 16:38:23 +0000 (UTC)
Message-Id: <1816291fbd779358e8464e103d8e810cfb0fb7a2.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/17] powerpc/32: Refactor EXCEPTION entry macros for
 head_8xx.S and head_32.S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 16:38:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXCEPTION_PROLOG is similar in head_8xx.S and head_32.S

This patch creates head_32.h and moves EXCEPTION_PROLOG macro
into it. It also converts it from a GCC macro to a GAS macro
in order to ease refactorisation with 40x later, since
GAS macros allows the use of #ifdef/#else/#endif inside it.
And it also has the advantage of not requiring the uggly "; \"
at the end of each line.

This patch also moves EXCEPTION() and EXC_XFER_XXXX() macros which
are also similar while adding START_EXCEPTION() out of EXCEPTION().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  |  99 +---------------------------------
 arch/powerpc/kernel/head_32.h  | 118 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_8xx.S |  98 +---------------------------------
 3 files changed, 122 insertions(+), 193 deletions(-)
 create mode 100644 arch/powerpc/kernel/head_32.h

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 48051c8977c5..577d196c26f2 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -37,6 +37,8 @@
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
 
+#include "head_32.h"
+
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
 	/* see the comment for clear_bats() -- Cort */ \
@@ -242,103 +244,6 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.long	-1
 
-/*
- * Exception entry code.  This code runs with address translation
- * turned off, i.e. using physical addresses.
- * We assume sprg3 has the physical address of the current
- * task's thread_struct.
- */
-#define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
-	mfcr	r10;		\
-	EXCEPTION_PROLOG_1;	\
-	EXCEPTION_PROLOG_2
-
-#define EXCEPTION_PROLOG_1	\
-	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
-	andi.	r11,r11,MSR_PR;	\
-	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
-	beq	1f;		\
-	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,TASK_STACK-THREAD(r11);	\
-	addi	r11,r11,THREAD_SIZE;	\
-	tophys(r11,r11);	\
-1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
-
-
-#define EXCEPTION_PROLOG_2	\
-	stw	r10,_CCR(r11);		/* save registers */ \
-	stw	r12,GPR12(r11);	\
-	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
-	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
-	stw	r12,GPR11(r11);	\
-	mflr	r10;		\
-	stw	r10,_LINK(r11);	\
-	mfspr	r12,SPRN_SRR0;	\
-	mfspr	r9,SPRN_SRR1;	\
-	stw	r1,GPR1(r11);	\
-	stw	r1,0(r11);	\
-	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
-	stw	r0,GPR0(r11);	\
-	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
-	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
-	stw	r10,8(r11);	\
-	SAVE_4GPRS(3, r11);	\
-	SAVE_2GPRS(7, r11)
-
-/*
- * Note: code which follows this uses cr0.eq (set if from kernel),
- * r11, r12 (SRR0), and r9 (SRR1).
- *
- * Note2: once we have set r1 we are in a position to take exceptions
- * again, and we could thus set MSR:RI at that point.
- */
-
-/*
- * Exception vectors.
- */
-#define EXCEPTION(n, label, hdlr, xfer)		\
-	. = n;					\
-	DO_KVM n;				\
-label:						\
-	EXCEPTION_PROLOG;			\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	xfer(n, hdlr)
-
-#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
-	li	r10,trap;					\
-	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
-	copyee(r10, r9);					\
-	bl	tfer;						\
-i##n:								\
-	.long	hdlr;						\
-	.long	ret
-
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
-#define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
-			  ret_from_except_full)
-
-#define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
-			  ret_from_except)
-
-#define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
-			  ret_from_except)
-
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
    putting it back to what it was (unknown_exception) when done.  */
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
new file mode 100644
index 000000000000..7456e2a45acc
--- /dev/null
+++ b/arch/powerpc/kernel/head_32.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HEAD_32_H__
+#define __HEAD_32_H__
+
+#include <asm/ptrace.h>	/* for STACK_FRAME_REGS_MARKER */
+
+/*
+ * Exception entry code.  This code runs with address translation
+ * turned off, i.e. using physical addresses.
+ * We assume sprg3 has the physical address of the current
+ * task's thread_struct.
+ */
+
+.macro EXCEPTION_PROLOG
+	mtspr	SPRN_SPRG_SCRATCH0,r10
+	mtspr	SPRN_SPRG_SCRATCH1,r11
+	mfcr	r10
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
+.endm
+
+.macro EXCEPTION_PROLOG_1
+	mfspr	r11,SPRN_SRR1		/* check whether user or kernel */
+	andi.	r11,r11,MSR_PR
+	tophys(r11,r1)			/* use tophys(r1) if kernel */
+	beq	1f
+	mfspr	r11,SPRN_SPRG_THREAD
+	lwz	r11,TASK_STACK-THREAD(r11)
+	addi	r11,r11,THREAD_SIZE
+	tophys(r11,r11)
+1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
+.endm
+
+.macro EXCEPTION_PROLOG_2
+	stw	r10,_CCR(r11)		/* save registers */
+	stw	r12,GPR12(r11)
+	stw	r9,GPR9(r11)
+	mfspr	r10,SPRN_SPRG_SCRATCH0
+	stw	r10,GPR10(r11)
+	mfspr	r12,SPRN_SPRG_SCRATCH1
+	stw	r12,GPR11(r11)
+	mflr	r10
+	stw	r10,_LINK(r11)
+	mfspr	r12,SPRN_SRR0
+	mfspr	r9,SPRN_SRR1
+	stw	r1,GPR1(r11)
+	stw	r1,0(r11)
+	tovirt(r1,r11)			/* set new kernel sp */
+	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR) /* can take exceptions */
+	MTMSRD(r10)			/* (except for mach check in rtas) */
+	stw	r0,GPR0(r11)
+	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
+	addi	r10,r10,STACK_FRAME_REGS_MARKER@l
+	stw	r10,8(r11)
+	SAVE_4GPRS(3, r11)
+	SAVE_2GPRS(7, r11)
+.endm
+
+/*
+ * Note: code which follows this uses cr0.eq (set if from kernel),
+ * r11, r12 (SRR0), and r9 (SRR1).
+ *
+ * Note2: once we have set r1 we are in a position to take exceptions
+ * again, and we could thus set MSR:RI at that point.
+ */
+
+/*
+ * Exception vectors.
+ */
+#ifdef CONFIG_PPC_BOOK3S
+#define	START_EXCEPTION(n, label)		\
+	. = n;					\
+	DO_KVM n;				\
+label:
+
+#else
+#define	START_EXCEPTION(n, label)		\
+	. = n;					\
+label:
+
+#endif
+
+#define EXCEPTION(n, label, hdlr, xfer)		\
+	START_EXCEPTION(n, label)		\
+	EXCEPTION_PROLOG;			\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
+	xfer(n, hdlr)
+
+#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
+	li	r10,trap;					\
+	stw	r10,_TRAP(r11);					\
+	li	r10,MSR_KERNEL;					\
+	copyee(r10, r9);					\
+	bl	tfer;						\
+i##n:								\
+	.long	hdlr;						\
+	.long	ret
+
+#define COPY_EE(d, s)		rlwimi d,s,0,MSR_EE
+#define NOCOPY(d, s)
+
+#define EXC_XFER_STD(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
+			  ret_from_except_full)
+
+#define EXC_XFER_LITE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
+#define EXC_XFER_EE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
+			  ret_from_except_full)
+
+#define EXC_XFER_EE_LITE(n, hdlr)	\
+	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
+			  ret_from_except)
+
+#endif /* __HEAD_32_H__ */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 03c73b4c6435..7b76ad1b9620 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -33,6 +33,8 @@
 #include <asm/export.h>
 #include <asm/code-patching-asm.h>
 
+#include "head_32.h"
+
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
 #define SIMPLE_KERNEL_ADDRESS		1
@@ -123,102 +125,6 @@ instruction_counter:
 	.space	4
 #endif
 
-/*
- * Exception entry code.  This code runs with address translation
- * turned off, i.e. using physical addresses.
- * We assume sprg3 has the physical address of the current
- * task's thread_struct.
- */
-#define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG_SCRATCH0, r10;	\
-	mtspr	SPRN_SPRG_SCRATCH1, r11;	\
-	mfcr	r10;		\
-	EXCEPTION_PROLOG_1;	\
-	EXCEPTION_PROLOG_2
-
-#define EXCEPTION_PROLOG_1	\
-	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel */ \
-	andi.	r11,r11,MSR_PR;	\
-	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
-	beq	1f;		\
-	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,TASK_STACK-THREAD(r11);	\
-	addi	r11,r11,THREAD_SIZE;	\
-	tophys(r11,r11);	\
-1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
-
-
-#define EXCEPTION_PROLOG_2	\
-	stw	r10,_CCR(r11);		/* save registers */ \
-	stw	r12,GPR12(r11);	\
-	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
-	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
-	stw	r12,GPR11(r11);	\
-	mflr	r10;		\
-	stw	r10,_LINK(r11);	\
-	mfspr	r12,SPRN_SRR0;	\
-	mfspr	r9,SPRN_SRR1;	\
-	stw	r1,GPR1(r11);	\
-	stw	r1,0(r11);	\
-	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	mtmsr	r10;		\
-	stw	r0,GPR0(r11);	\
-	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l; \
-	stw	r10, 8(r11);	\
-	SAVE_4GPRS(3, r11);	\
-	SAVE_2GPRS(7, r11)
-
-/*
- * Note: code which follows this uses cr0.eq (set if from kernel),
- * r11, r12 (SRR0), and r9 (SRR1).
- *
- * Note2: once we have set r1 we are in a position to take exceptions
- * again, and we could thus set MSR:RI at that point.
- */
-
-/*
- * Exception vectors.
- */
-#define EXCEPTION(n, label, hdlr, xfer)		\
-	. = n;					\
-label:						\
-	EXCEPTION_PROLOG;			\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	xfer(n, hdlr)
-
-#define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
-	li	r10,trap;					\
-	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
-	copyee(r10, r9);					\
-	bl	tfer;						\
-i##n:								\
-	.long	hdlr;						\
-	.long	ret
-
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
-#define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, NOCOPY, transfer_to_handler_full,	\
-			  ret_from_except_full)
-
-#define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, NOCOPY, transfer_to_handler, \
-			  ret_from_except)
-
-#define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(n, hdlr, n, COPY_EE, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(n, hdlr, n+1, COPY_EE, transfer_to_handler, \
-			  ret_from_except)
-
 /* System reset */
 	EXCEPTION(0x100, Reset, system_reset_exception, EXC_XFER_STD)
 
-- 
2.13.3

