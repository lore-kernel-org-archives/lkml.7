Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF69C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728692146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uHMmhX5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBH5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 02:57:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51844 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBH5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:57:34 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47RHX84lMzz9txt3;
        Mon,  2 Dec 2019 08:57:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uHMmhX5/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jLMTh157QIWf; Mon,  2 Dec 2019 08:57:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47RHX83hWpz9txsp;
        Mon,  2 Dec 2019 08:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575273448; bh=dAixbg2856IVDTJUGcX9CkGdb1Msgmw2hMVJFKg+cLw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=uHMmhX5/tI4jalCVzbmEbBOroNwBXN9OdwBgmY0h2MOwy4Af2Fnm2pxWV0uohO5/P
         1aJZsp4zbm97095Q0nUll9Enu9pqONyejCXbtLLmbOS02Vlwtnm79j29PhHupVr2Ur
         0V5tkmCHDL8DEGp/rF+27ZwQCkg2VcklOMGzhy3w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F8A78B79B;
        Mon,  2 Dec 2019 08:57:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vNVfrct8lKmH; Mon,  2 Dec 2019 08:57:33 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 014E78B79A;
        Mon,  2 Dec 2019 08:57:32 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F061C63600; Mon,  2 Dec 2019 07:57:32 +0000 (UTC)
Message-Id: <36f111437e66e601929308f5d5dce230e1ce472f.1575273217.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1575273217.git.christophe.leroy@c-s.fr>
References: <cover.1575273217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 6/8] powerpc/vdso32: use LOAD_REG_IMMEDIATE()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de
Date:   Mon,  2 Dec 2019 07:57:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use LOAD_REG_IMMEDIATE() to load registers with immediate value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 74973548529a..9aafacea9c4a 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -37,8 +37,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	get_datapage	r9, r0
 	cmplwi	r10,0			/* check if tv is NULL */
 	beq	3f
-	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
-	addi	r7,r7,1000000@l		/* so we get microseconds in r4 */
+	LOAD_REG_IMMEDIATE(r7, 1000000)	/* load up USEC_PER_SEC */
 	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
 	stw	r3,TVAL32_TV_SEC(r10)
 	stw	r4,TVAL32_TV_USEC(r10)
@@ -81,8 +80,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
 	get_datapage	r9, r0
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
+	LOAD_REG_IMMEDIATE(r7, NSEC_PER_SEC)	/* load up NSEC_PER_SEC */
 	beq	cr5, .Lcoarse_clocks
 .Lprecise_clocks:
 	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
-- 
2.13.3

