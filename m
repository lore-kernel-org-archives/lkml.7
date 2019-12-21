Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1BCC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1054824689
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NHh9gLjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLUIc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:32:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13338 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfLUIcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:36 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPt2qJJz9txhF;
        Sat, 21 Dec 2019 09:32:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NHh9gLjy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KZQOUT_s_-qN; Sat, 21 Dec 2019 09:32:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPt1LrZz9txh9;
        Sat, 21 Dec 2019 09:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917154; bh=mTnSd5K48HUvkTFKOuCKJIWuBpZFeLQZSv1zWTZ0KFQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=NHh9gLjyeYT5TDS5JorrihyN/MS1RVn+SX55hISP8tF5vU4eWlWuXIgRqcVZ2tfPs
         C5YI8SLN5+77RJQFYZlY2Y6HPZmNwXjdUGduglp9UBM1lEOl6VVKNlZnhn9lkPeIDa
         4xSM5aoOSJY+I3m/OVHYjIMIxp6vVYUwJT4b35cA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EFDB8B77C;
        Sat, 21 Dec 2019 09:32:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5bAbWXmEC5-J; Sat, 21 Dec 2019 09:32:35 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F05E58B752;
        Sat, 21 Dec 2019 09:32:34 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B8ABC637B6; Sat, 21 Dec 2019 08:32:34 +0000 (UTC)
Message-Id: <1dda3293d86d0f715b13b2633c95d2188a42a02c.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 13/17] powerpc/8xx: split breakpoint exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:34 +0000 (UTC)
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

