Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63473C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332C4217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="R8vQCBxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfC2Qie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:38:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53875 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbfC2Qi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:38:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44W6qj129Fz9tyQV;
        Fri, 29 Mar 2019 17:38:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=R8vQCBxt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oU_AKdNhzpcp; Fri, 29 Mar 2019 17:38:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qh73GRz9tyQP;
        Fri, 29 Mar 2019 17:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553877505; bh=FpWIdVhXPqB6vibTfnZhtBnlLfysFeUxuV/R0Sq2tt8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=R8vQCBxtBfjrf2G/3TzBBL2ZkK3LdMOLU89sF309ej4vqk6QiqfMQ3rvWfRvvIOnV
         SuI474qGunPq3eTyJy2vrcZ1ru8MdOUMWPIlVJP1YS2H4AK6Qsxss4SYWUUBUR1b4f
         mb6aGnMHEPjmw1RCnMncggMnOlR6MM5mG2Q/wPtY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EED28B93D;
        Fri, 29 Mar 2019 17:38:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YS3R_R2F_E5l; Fri, 29 Mar 2019 17:38:26 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 724E88B938;
        Fri, 29 Mar 2019 17:38:26 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6574F6FC56; Fri, 29 Mar 2019 16:38:26 +0000 (UTC)
Message-Id: <7586d26323ae33466c4527fb98b0559cdbc71206.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/17] powerpc/40x: Don't use SPRN_SPRG_SCRATCH2 in
 EXCEPTION_PROLOG
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 16:38:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike said in the comment, r1 is not reused by the critical
exception handler, as it uses a dedicated critirq_ctx stack.
Decrementing r1 early is then unneeded.

Should the above be valid, the code is crap buggy anyway as
r1 gets some intermediate values that would jeopardise the
whole process (for instance after mfspr   r1,SPRN_SPRG_THREAD)

Using SPRN_SPRG_SCRATCH2 to save r1 is then not needed, r11 can be
used instead. This avoids one mtspr and one mfspr and makes the
prolog closer to what's done on 6xx and 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index a9c934f2319b..f49b0278e995 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -102,23 +102,20 @@ _ENTRY(saved_ksp_limit)
  * Exception vector entry code. This code runs with address translation
  * turned off (i.e. using physical addresses). We assume SPRG_THREAD has
  * the physical address of the current task thread_struct.
- * Note that we have to have decremented r1 before we write to any fields
- * of the exception frame, since a critical interrupt could occur at any
- * time, and it will write to the area immediately below the current r1.
  */
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG_SCRATCH0,r10;	/* save two registers to work with */\
 	mtspr	SPRN_SPRG_SCRATCH1,r11;					     \
-	mtspr	SPRN_SPRG_SCRATCH2,r1;					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	beq	1f;							     \
-	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
-1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
+	beq	1f;							     \
+	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
+	addi	r11,r11,THREAD_SIZE;					     \
+	tophys(r11,r11);						     \
+1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
@@ -128,11 +125,11 @@ _ENTRY(saved_ksp_limit)
 	stw	r12,GPR11(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRN_SPRG_SCRATCH2;					     \
 	mfspr	r12,SPRN_SRR0;						     \
-	stw	r10,GPR1(r11);						     \
+	stw	r1,GPR1(r11);						     \
 	mfspr	r9,SPRN_SRR1;						     \
-	stw	r10,0(r11);						     \
+	stw	r1,0(r11);						     \
+	tovirt(r1,r11);			/* set new kernel sp */	\
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
-- 
2.13.3

