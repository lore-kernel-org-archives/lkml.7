Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EFB21655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VyvATy6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLUIdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:33:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:45061 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfLUIce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:34 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPq2jc9z9txhB;
        Sat, 21 Dec 2019 09:32:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VyvATy6j; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HfDi2Hrf6vqo; Sat, 21 Dec 2019 09:32:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPq1T8Mz9txh9;
        Sat, 21 Dec 2019 09:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917151; bh=z7CDoj65y2axQ8EI+vOdmey1E1OSCEBxOpggEgCL0JQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VyvATy6jgRW8TRvW00fB2Ve1yOZMm6i3SbVop5lkZJeCZ9rio6Hb4kzc4c1+BZyqr
         SM5kJTOlrQj7SVAwylEdBi2oElZYbTTw9YAjTC+8D5ucDdN16MVpaQFoXCoKHMOJvI
         3X/H0hSpZq9cqPY8/RQbP3yd3xPs07BZNUZFT58Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E9D88B77C;
        Sat, 21 Dec 2019 09:32:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BNMjCSa-xNiv; Sat, 21 Dec 2019 09:32:32 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0CFC8B752;
        Sat, 21 Dec 2019 09:32:31 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id A27DB637B6; Sat, 21 Dec 2019 08:32:31 +0000 (UTC)
Message-Id: <c5287ea59ae9630f505019b309bf94029241635f.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 10/17] powerpc/8xx: Use alternative scratch registers in
 DTLB miss handler
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of handling CONFIG_VMAP_STACK, DTLB miss handler need
to use different scratch registers than other exception handlers in
order to not jeopardise exception entry on stack DTLB misses.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 27 ++++++++++++++-------------
 arch/powerpc/perf/8xx-pmu.c    | 12 ++++++++----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 25e19af49705..3de9c5f1746c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -193,8 +193,9 @@ SystemCall:
 0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	addi	r10, r10, 1
 	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
 	rfi
 #endif
 
@@ -337,8 +338,8 @@ ITLBMissLinear:
 
 	. = 0x1200
 DataStoreTLBMiss:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
+	mtspr	SPRN_DAR, r10
+	mtspr	SPRN_M_TW, r11
 	mfcr	r11
 
 	/* If we are faulting a kernel address, we have to use the
@@ -403,10 +404,10 @@ DataStoreTLBMiss:
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
 
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+0:	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_1
 
@@ -422,10 +423,10 @@ DTLBMissIMMR:
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
 
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+0:	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_2
 
@@ -459,10 +460,10 @@ DTLBMissLinear:
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
 
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+0:	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_3
 
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 19124b0b171a..1ad03c55c88c 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -157,10 +157,6 @@ static void mpc8xx_pmu_read(struct perf_event *event)
 
 static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 {
-	/* mfspr r10, SPRN_SPRG_SCRATCH0 */
-	unsigned int insn = PPC_INST_MFSPR | __PPC_RS(R10) |
-			    __PPC_SPR(SPRN_SPRG_SCRATCH0);
-
 	mpc8xx_pmu_read(event);
 
 	/* If it was the last user, stop counting to avoid useles overhead */
@@ -173,6 +169,10 @@ static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
 		if (atomic_dec_return(&itlb_miss_ref) == 0) {
+			/* mfspr r10, SPRN_SPRG_SCRATCH0 */
+			unsigned int insn = PPC_INST_MFSPR | __PPC_RS(R10) |
+					    __PPC_SPR(SPRN_SPRG_SCRATCH0);
+
 			patch_instruction_site(&patch__itlbmiss_exit_1, insn);
 #ifndef CONFIG_PIN_TLB_TEXT
 			patch_instruction_site(&patch__itlbmiss_exit_2, insn);
@@ -181,6 +181,10 @@ static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 		break;
 	case PERF_8xx_ID_DTLB_LOAD_MISS:
 		if (atomic_dec_return(&dtlb_miss_ref) == 0) {
+			/* mfspr r10, SPRN_DAR */
+			unsigned int insn = PPC_INST_MFSPR | __PPC_RS(R10) |
+					    __PPC_SPR(SPRN_DAR);
+
 			patch_instruction_site(&patch__dtlbmiss_exit_1, insn);
 			patch_instruction_site(&patch__dtlbmiss_exit_2, insn);
 			patch_instruction_site(&patch__dtlbmiss_exit_3, insn);
-- 
2.13.3

