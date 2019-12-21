Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5DBC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E4821927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kkuxk88F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLUIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:32:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:5083 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfLUIc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:29 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPk0zwKz9vBmt;
        Sat, 21 Dec 2019 09:32:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kkuxk88F; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id V1aKPqdfVmtk; Sat, 21 Dec 2019 09:32:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPj6xZBz9v1Ks;
        Sat, 21 Dec 2019 09:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917146; bh=8ftmeyPqqlcOQZKXXYr2+SgDzTYbbqznzk6320BOCv8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kkuxk88FC/AAKIFHLP7ko54ZWEPhxm2zMN6Q20rQS7gFc8k/EzvsBrL74QdTBD8hy
         g2NsF0pWlVHboeFa744rikfAg3Um/rt5VF5BdkMXEAWnACeLXljD2l/pBlGQ1m76Hx
         6q/tfEPPpEUXaI8XWmyWUftW81OQn5RPeGivpZFo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF6E88B77C;
        Sat, 21 Dec 2019 09:32:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JR21AhPaIQ_j; Sat, 21 Dec 2019 09:32:26 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B59488B752;
        Sat, 21 Dec 2019 09:32:26 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 7C125637B6; Sat, 21 Dec 2019 08:32:26 +0000 (UTC)
Message-Id: <1286b3e51b07727c6b4b05f2df9af3f9b1717fb5.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 05/17] powerpc/32: add a macro to get and/or save DAR and
 DSISR on stack.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor reading and saving of DAR and DSISR in exception vectors.

This will ease the implementation of VMAP stack.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  |  5 +----
 arch/powerpc/kernel/head_32.h  | 11 +++++++++++
 arch/powerpc/kernel/head_8xx.S | 23 +++++++----------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index bebb49d877f2..449625b4ff03 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -339,10 +339,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	DO_KVM  0x600
 Alignment:
 	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_DAR
-	stw	r4,_DAR(r11)
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x600, alignment_exception)
 
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 436ffd862d2a..f19a1ab91fb5 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -144,6 +144,17 @@
 	RFI				/* jump to handler, enable MMU */
 .endm
 
+.macro save_dar_dsisr_on_stack reg1, reg2, sp
+	mfspr	\reg1, SPRN_DAR
+	mfspr	\reg2, SPRN_DSISR
+	stw	\reg1, _DAR(\sp)
+	stw	\reg2, _DSISR(\sp)
+.endm
+
+.macro get_and_save_dar_dsisr_on_stack reg1, reg2, sp
+	save_dar_dsisr_on_stack \reg1, \reg2, \sp
+.endm
+
 /*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r11, r12 (SRR0), and r9 (SRR1).
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 175c3cfc8014..25e19af49705 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -128,12 +128,9 @@ instruction_counter:
 	. = 0x200
 MachineCheck:
 	EXCEPTION_PROLOG
-	mfspr r4,SPRN_DAR
-	stw r4,_DAR(r11)
-	li r5,RPN_PATTERN
-	mtspr SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
-	mfspr r5,SPRN_DSISR
-	stw r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
+	li	r6, RPN_PATTERN
+	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
 	addi r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x200, machine_check_exception)
 
@@ -156,12 +153,9 @@ InstructionAccess:
 	. = 0x600
 Alignment:
 	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_DAR
-	stw	r4,_DAR(r11)
-	li	r5,RPN_PATTERN
-	mtspr	SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
+	li	r6, RPN_PATTERN
+	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x600, alignment_exception)
 
@@ -502,10 +496,7 @@ DataTLBError:
 DARFixed:/* Return from dcbx instruction bug workaround */
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
-	mfspr	r4,SPRN_DAR
-	stw	r4, _DAR(r11)
+	get_and_save_dar_dsisr_on_stack r4, r5, r11
 	andis.	r10,r5,DSISR_NOHPTE@h
 	beq+	.Ldtlbie
 	tlbie	r4
-- 
2.13.3

