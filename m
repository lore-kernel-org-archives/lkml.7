Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B922071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ST2yTTZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfKZMg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:36:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:44208 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfKZMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:17 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0b696nz9v0G9;
        Tue, 26 Nov 2019 13:36:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ST2yTTZp; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fgCG9oe60t4O; Tue, 26 Nov 2019 13:36:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0b55yCz9v0G3;
        Tue, 26 Nov 2019 13:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771775; bh=mTnSd5K48HUvkTFKOuCKJIWuBpZFeLQZSv1zWTZ0KFQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ST2yTTZpS/fbPUWKHzXohvhcRAlknP15IEdRnAOKNJ/qnyyf7v3YdfLH7qXuqqU9M
         Rm5oFWe9KE9HXMP2+iZG+nfieb5FRjBiUVDZNBBp/TCeFxTiFJDrgSS3hCguC43yw7
         bb1XbE/kBf2uDmTOdUqv3MllgnQWlG4gWO1MNH24=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F20058B7FC;
        Tue, 26 Nov 2019 13:36:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0eE_v2FhZUyJ; Tue, 26 Nov 2019 13:36:16 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C168A8B771;
        Tue, 26 Nov 2019 13:36:16 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2AFBE6B76A; Tue, 26 Nov 2019 12:36:16 +0000 (UTC)
Message-Id: <f9f926326ed150b2ab24ce362b14d97b76db7176.1574771541.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1574771539.git.christophe.leroy@c-s.fr>
References: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 12/16] powerpc/8xx: split breakpoint exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breakpoint exception is big.

Split it to support future growth on exception prolog.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1e718e47fe3c..225e242ce1c5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -490,14 +490,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	. = 0x1c00
-DataBreakpoint:
-	EXCEPTION_PROLOG_0
-	mfspr	r11, SPRN_SRR0
-	cmplwi	cr1, r11, (.Ldtlbie - PAGE_OFFSET)@l
-	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
-	beq-	cr1, 11f
-	beq-	cr7, 11f
+do_databreakpoint:
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -505,7 +498,15 @@ DataBreakpoint:
 	stw	r4,_DAR(r11)
 	mfspr	r5,SPRN_DSISR
 	EXC_XFER_STD(0x1c00, do_break)
-11:
+
+	. = 0x1c00
+DataBreakpoint:
+	EXCEPTION_PROLOG_0
+	mfspr	r11, SPRN_SRR0
+	cmplwi	cr1, r11, (.Ldtlbie - PAGE_OFFSET)@l
+	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
+	cror	4*cr1+eq, 4*cr1+eq, 4*cr7+eq
+	bne	cr1, do_databreakpoint
 	mtcr	r10
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-- 
2.13.3

