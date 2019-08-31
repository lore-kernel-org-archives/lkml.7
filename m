Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A4C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809C21670
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Jmj/RO2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfHaKSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:18:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11844 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfHaKSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:18:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46LC3q1zqXz9v4gc;
        Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Jmj/RO2l; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jafzeWdXOY5n; Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46LC3q0zZjz9v4gL;
        Sat, 31 Aug 2019 12:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567246711; bh=0xISFeXI6V/VCCOBsr0ouHlrTV7K42C7OEIEr4+IWgQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Jmj/RO2l4WetigK6XG738kWgb7OdVdK9Xi7B91eZf6ZOHOAkedigP8ow6/szcGceX
         UviE0n/X3952teG9t8O0K0GCFf52W+qCU9sFBLLDQSCAV7X7hev3GowszR3LPCQmgX
         fvdq5A/LjRXWqGnoDnqT8rMEXijy1+RrNqR8lLUU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B91B8B7B9;
        Sat, 31 Aug 2019 12:18:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0vs0TmwIuvJt; Sat, 31 Aug 2019 12:18:32 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48D4B8B789;
        Sat, 31 Aug 2019 12:18:32 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0EEEB6985C; Sat, 31 Aug 2019 10:18:31 +0000 (UTC)
Message-Id: <b86ace4b0c34da731859fae0f44dbc079b603b09.1567245404.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1567245404.git.christophe.leroy@c-s.fr>
References: <cover.1567245404.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 07/10] powerpc/8xx: split breakpoint exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 31 Aug 2019 10:18:31 +0000 (UTC)
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
index d194cff6528b..2fa02ae7a88c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -497,14 +497,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	. = 0x1c00
-DataBreakpoint:
-	EXCEPTION_PROLOG_0
-	mfspr	r11, SPRN_SRR0
-	cmplwi	cr0, r11, (.Ldtlbie - PAGE_OFFSET)@l
-	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
-	beq-	cr0, 11f
-	beq-	cr7, 11f
+do_databreakpoint:
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -512,7 +505,15 @@ DataBreakpoint:
 	stw	r4,_DAR(r11)
 	mfspr	r5,SPRN_DSISR
 	EXC_XFER_STD(0x1c00, do_break)
-11:
+
+	. = 0x1c00
+DataBreakpoint:
+	EXCEPTION_PROLOG_0
+	mfspr	r11, SPRN_SRR0
+	cmplwi	cr0, r11, (.Ldtlbie - PAGE_OFFSET)@l
+	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
+	cror	4*cr0+eq, 4*cr0+eq, 4*cr7+eq
+	bne	do_databreakpoint
 	mtcr	r10
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-- 
2.13.3

