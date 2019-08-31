Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DAC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B394B22D37
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WlJ0A9OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfHaKTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:19:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34472 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHaKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:18:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46LC3j6LMjz9v4gS;
        Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WlJ0A9OK; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5GgF6y7icjAm; Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46LC3j5BY1z9v4gL;
        Sat, 31 Aug 2019 12:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567246705; bh=E4aomYJpSb8XUJSjcLreHvSqPpw/Uuaudfxhpwkoawk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WlJ0A9OKYOkt8dqW8taTTLmi+762lWI8idZEoqrXxzy/Xb/ZGgAh84wLCd7uH9ufV
         CSAaTvlTu2DM9hwtrVIWXT+bV9t9L3/58BTvCnF4KcECXt4X33WC19gQsZuf/XL3gb
         4Lw59/XYJP/S2l/QJv5GqOIt5BJYWfTQECMvAIz8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 15A938B7B9;
        Sat, 31 Aug 2019 12:18:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VMENq3P3FZVC; Sat, 31 Aug 2019 12:18:27 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B793D8B789;
        Sat, 31 Aug 2019 12:18:26 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7D4436985C; Sat, 31 Aug 2019 10:18:26 +0000 (UTC)
Message-Id: <b665e61982f5b1963751c4d9d44288a5201e433b.1567245404.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1567245404.git.christophe.leroy@c-s.fr>
References: <cover.1567245404.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 02/10] powerpc/32: Add EXCEPTION_PROLOG_0 in head_32.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 31 Aug 2019 10:18:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a macro for the very first part of
exception prolog, this will help when implementing
CONFIG_VMAP_STACK

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  | 4 +---
 arch/powerpc/kernel/head_32.h  | 9 ++++++---
 arch/powerpc/kernel/head_8xx.S | 9 ++-------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9e6f01abb31e..53a9dab024c7 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -264,9 +264,7 @@ __secondary_hold_acknowledge:
  */
 	. = 0x200
 	DO_KVM  0x200
-	mtspr	SPRN_SPRG_SCRATCH0,r10
-	mtspr	SPRN_SPRG_SCRATCH1,r11
-	mfcr	r10
+	EXCEPTION_PROLOG_0
 #ifdef CONFIG_PPC_CHRP
 	mfspr	r11, SPRN_SPRG_THREAD
 	lwz	r11, RTAS_SP(r11)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index b2ca8c9ffd8b..8e345f8d4b0e 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -10,13 +10,16 @@
  * We assume sprg3 has the physical address of the current
  * task's thread_struct.
  */
-
 .macro EXCEPTION_PROLOG
+	EXCEPTION_PROLOG_0
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
+.endm
+
+.macro EXCEPTION_PROLOG_0
 	mtspr	SPRN_SPRG_SCRATCH0,r10
 	mtspr	SPRN_SPRG_SCRATCH1,r11
 	mfcr	r10
-	EXCEPTION_PROLOG_1
-	EXCEPTION_PROLOG_2
 .endm
 
 .macro EXCEPTION_PROLOG_1
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5ab9178c2347..16d68c8575ca 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -493,10 +493,7 @@ InstructionTLBError:
  */
 	. = 0x1400
 DataTLBError:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mfcr	r10
-
+	EXCEPTION_PROLOG_0
 	mfspr	r11, SPRN_DAR
 	cmpwi	cr0, r11, RPN_PATTERN
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
@@ -529,9 +526,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  */
 	. = 0x1c00
 DataBreakpoint:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mfcr	r10
+	EXCEPTION_PROLOG_0
 	mfspr	r11, SPRN_SRR0
 	cmplwi	cr0, r11, (.Ldtlbie - PAGE_OFFSET)@l
 	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
-- 
2.13.3

