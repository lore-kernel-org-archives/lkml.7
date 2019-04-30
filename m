Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD26C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867B921734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YQ2lTY02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfD3MjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:39:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53029 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfD3MjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:39:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44th0g50hXz9vD32;
        Tue, 30 Apr 2019 14:38:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YQ2lTY02; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4p0JiHYyzkKq; Tue, 30 Apr 2019 14:38:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44th0g3zFmz9vD30;
        Tue, 30 Apr 2019 14:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556627939; bh=Nn7y9niThmKUvevx3q50lC3WSkdJf9qvxs5/rH9nF4U=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=YQ2lTY023s4rNB12lL+ULR3OC2mYvAu1cieYHjiQWRKoSdkrAug8SYbiyxgHd7xRl
         xRUCiJU7doSbTo4HFLpq2PKNou3ii+lcFjorh22BtXiZBNGOKwd28a/3DLtmR+Pm0V
         JlxsIEIBvjjQ/+oSUMF6BtKZhly13mgvIYZ8uzb0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E81A08B8DF;
        Tue, 30 Apr 2019 14:39:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TvLcsr2SEEsD; Tue, 30 Apr 2019 14:39:00 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6BCD8B8C2;
        Tue, 30 Apr 2019 14:39:00 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 74C25666F8; Tue, 30 Apr 2019 12:39:00 +0000 (UTC)
Message-Id: <923b1c0afa27de7a867435abf5336af74c4a7ec8.1556627571.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556627571.git.christophe.leroy@c-s.fr>
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 11/16] powerpc/32: get rid of COPY_EE in exception entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 30 Apr 2019 12:39:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXC_XFER_TEMPLATE() is not called with COPY_EE anymore so
we can get rid of copyee parameters and related COPY_EE and NOCOPY
macros.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[splited out from benh RFC patch]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.h    | 12 ++++--------
 arch/powerpc/kernel/head_40x.S   |  8 +++-----
 arch/powerpc/kernel/head_booke.h | 22 ++++++++--------------
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 8881b6887841..14cb0af2f494 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -103,28 +103,24 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	xfer(n, hdlr)
 
-#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
+#define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)		\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
 	LOAD_MSR_KERNEL(r10, msr);				\
-	copyee(r10, r9);					\
 	bl	tfer;						\
 	.long	hdlr;						\
 	.long	ret
 
-#define COPY_EE(d, s)		rlwimi d,s,0,MSR_EE
-#define NOCOPY(d, s)
-
 #define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full,	\
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full,	\
 			  ret_from_except_full)
 
 #define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, transfer_to_handler, \
 			  ret_from_except)
 
 #define EXC_XFER_SYS(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, transfer_to_handler, \
 			  ret_from_except)
 
 #endif /* __HEAD_32_H__ */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 71597fb7cd89..b68de183faf1 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -166,8 +166,7 @@ _ENTRY(saved_ksp_limit)
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, crit_transfer_to_handler,	\
-			  ret_from_crit_exc)
+			  crit_transfer_to_handler, ret_from_crit_exc)
 
 /*
  * 0x0100 - Critical Interrupt Exception
@@ -651,7 +650,7 @@ _ENTRY(saved_ksp_limit)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
 		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+		crit_transfer_to_handler, ret_from_crit_exc)
 
 	/* Programmable Interval Timer (PIT) Exception. (from 0x1000) */
 Decrementer:
@@ -673,8 +672,7 @@ WDTException:
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	EXC_XFER_TEMPLATE(WatchdogException, 0x1020+2,
 	                  (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),
-			  NOCOPY, crit_transfer_to_handler,
-			  ret_from_crit_exc)
+			  crit_transfer_to_handler, ret_from_crit_exc)
 
 /*
  * The other Data TLB exceptions bail out to this point
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 264976c43f34..56dd1341eb3d 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -217,8 +217,7 @@ END_BTB_FLUSH_SECTION
 	CRITICAL_EXCEPTION_PROLOG(intno);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, crit_transfer_to_handler, \
-			  ret_from_crit_exc)
+			  crit_transfer_to_handler, ret_from_crit_exc)
 
 #define MCHECK_EXCEPTION(n, label, hdlr)			\
 	START_EXCEPTION(label);					\
@@ -227,32 +226,27 @@ END_BTB_FLUSH_SECTION
 	stw	r5,_ESR(r11);					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	EXC_XFER_TEMPLATE(hdlr, n+4, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, mcheck_transfer_to_handler,   \
-			  ret_from_mcheck_exc)
+			  mcheck_transfer_to_handler, ret_from_mcheck_exc)
 
-#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
+#define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
 	lis	r10,msr@h;					\
 	ori	r10,r10,msr@l;					\
-	copyee(r10, r9);					\
 	bl	tfer;		 				\
 	.long	hdlr;						\
 	.long	ret
 
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
 #define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full, \
 			  ret_from_except_full)
 
 #define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, transfer_to_handler, \
 			  ret_from_except)
 
 #define EXC_XFER_SYS(n, hdlr)						\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, transfer_to_handler, \
 			  ret_from_except)
 
 /* Check for a single step debug exception while in an exception
@@ -319,7 +313,7 @@ END_BTB_FLUSH_SECTION
 	/* continue normal handling for a debug exception... */		      \
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
+	EXC_XFER_TEMPLATE(DebugException, 0x2008, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), debug_transfer_to_handler, ret_from_debug_exc)
 
 #define DEBUG_CRIT_EXCEPTION						      \
 	START_EXCEPTION(DebugCrit);					      \
@@ -372,7 +366,7 @@ END_BTB_FLUSH_SECTION
 	/* continue normal handling for a critical exception... */	      \
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), crit_transfer_to_handler, ret_from_crit_exc)
 
 #define DATA_STORAGE_EXCEPTION						      \
 	START_EXCEPTION(DataStorage)					      \
-- 
2.13.3

