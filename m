Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC6CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EFD2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XNGB0ddy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfJ2JxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7884 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733210AbfJ2JxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:53:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 472RjN13hxz9tysm;
        Tue, 29 Oct 2019 10:53:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XNGB0ddy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 81R-kucN2VBK; Tue, 29 Oct 2019 10:53:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 472RjM71Rcz9tysj;
        Tue, 29 Oct 2019 10:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572342792; bh=gp9eHVQXcmLGsiCH27WLeZfCu7vE82qJv2qSCrrxkhE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=XNGB0ddylbSaBhNVaOKEKt/o6x+5IRYgtOeM3wbz4HNhQxAm8/dRdRilbLY6c9RZu
         //1on9g6idWgAwhVgSqv4zC6vR0bkaCMF8HMQbl5X8Sz3c7Qj3TKwsDQkV7I0zULb3
         ZauDjjsWgcOS3p5bbXYxKHVJjMHrypkL0ZbBwjOI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E58B48B84C;
        Tue, 29 Oct 2019 10:53:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wZQmnHkwCTtx; Tue, 29 Oct 2019 10:53:12 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B602C8B755;
        Tue, 29 Oct 2019 10:53:12 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 823176B6FD; Tue, 29 Oct 2019 09:53:12 +0000 (UTC)
Message-Id: <9e82b282e67e4355cbe3d1732684b3e85605d5b2.1572342582.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1572342582.git.christophe.leroy@c-s.fr>
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 7/8] powerpc/vdso32: implement clock_getres entirely
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Oct 2019 09:53:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock_getres returns hrtimer_res for all clocks but coarse ones
for which it returns KTIME_LOW_RES.

return EINVAL for unknown clocks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/asm-offsets.c         |  3 +++
 arch/powerpc/kernel/vdso32/gettimeofday.S | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 07d5596ff646..4879c41ed5d0 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -417,7 +417,10 @@ int main(void)
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
+	DEFINE(CLOCK_MAX, CLOCK_TAI);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
+	DEFINE(EINVAL, EINVAL);
+	DEFINE(KTIME_LOW_RES, KTIME_LOW_RES);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index ff431482739c..181e66a15fe2 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -198,17 +198,20 @@ V_FUNCTION_END(__kernel_clock_gettime)
 V_FUNCTION_BEGIN(__kernel_clock_getres)
   .cfi_startproc
 	/* Check for supported clock IDs */
-	cmpwi	cr0,r3,CLOCK_REALTIME
-	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-	bne	cr0,99f
+	cmplwi	cr0, r3, CLOCK_MAX
+	cmpwi	cr1, r3, CLOCK_REALTIME_COARSE
+	cmpwi	cr7, r3, CLOCK_MONOTONIC_COARSE
+	bgt	cr0, 99f
+	LOAD_REG_IMMEDIATE(r5, KTIME_LOW_RES)
+	beq	cr1, 1f
+	beq	cr7, 1f
 
 	mflr	r12
   .cfi_register lr,r12
 	get_datapage	r3, r0
 	lwz	r5, CLOCK_HRTIMER_RES(r3)
 	mtlr	r12
-	li	r3,0
+1:	li	r3,0
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
@@ -217,11 +220,11 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	blr
 
 	/*
-	 * syscall fallback
+	 * invalid clock
 	 */
 99:
-	li	r0,__NR_clock_getres
-	sc
+	li	r3, EINVAL
+	crset	so
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_clock_getres)
-- 
2.13.3

