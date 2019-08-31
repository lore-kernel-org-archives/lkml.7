Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926CEC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B6122DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ipp/MOCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfHaKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:18:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32223 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfHaKSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:18:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46LC3p1htKz9v4gb;
        Sat, 31 Aug 2019 12:18:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ipp/MOCh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8RpTSmImh0lt; Sat, 31 Aug 2019 12:18:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46LC3p0ZV0z9v4gL;
        Sat, 31 Aug 2019 12:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567246710; bh=uFiRLpIkjK57Hf5CaAnRZcWsB6+unevIPvAia3/sItM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ipp/MOChQD3z0aaX19rY5DO/Q6Kqk0L0usfgBPTqVvdqru8SJk9u7Fus587Veog3k
         1dJpYgM5vYF2I5mEinFzizoMU+Ro0E4poBq1mdvAc+jvvVI2maYwrBivpgHMr3MiQx
         KXwOHikwm3YPU8hGlXeMWJ6fAcId2oO1LB2RuA5A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B84D8B7B9;
        Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RnAFIdvWqsKv; Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 363718B789;
        Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F134B6985C; Sat, 31 Aug 2019 10:18:30 +0000 (UTC)
Message-Id: <0c7e0184b94856503b5b32cf9159788ea76d96bf.1567245404.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1567245404.git.christophe.leroy@c-s.fr>
References: <cover.1567245404.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 06/10] powerpc/8xx: move DataStoreTLBMiss perf handler
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 31 Aug 2019 10:18:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DataStoreTLBMiss perf handler in order to cope
with future growing exception prolog.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 4a3459c7d708..d194cff6528b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -171,18 +171,6 @@ SystemCall:
  */
 	EXCEPTION(0x1000, SoftEmu, program_check_exception, EXC_XFER_STD)
 
-/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
-#ifdef CONFIG_PERF_EVENTS
-	patch_site	0f, patch__dtlbmiss_perf
-0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	addi	r10, r10, 1
-	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r11, SPRN_M_TW
-	rfi
-#endif
-
 
 	. = 0x1100
 /*
@@ -493,6 +481,18 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
+/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
+#ifdef CONFIG_PERF_EVENTS
+	patch_site	0f, patch__dtlbmiss_perf
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
+	rfi
+#endif
+
 /* On the MPC8xx, these next four traps are used for development
  * support of breakpoints and such.  Someday I will get around to
  * using them.
-- 
2.13.3

