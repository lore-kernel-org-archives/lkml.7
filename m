Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A42D23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nZhxgx3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbfHVQeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:34:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20874 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfHVQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:34:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46DqqF4yp7z9v0d5;
        Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nZhxgx3M; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ev5vktKTN8mC; Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46DqqF3q5Gz9v0d3;
        Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566491641; bh=UIHQXP6V1jWugQMbEinSuLqC2er8Mq/UwaqIPYmrK0I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=nZhxgx3MqS6P5rC2OQdFWiGuynawFt2r+1HVXupVUAN4O3CXNf4xpI7NtCLt0aQ4g
         mFDNkG16RbHDi7EOQMXF8/PEiD8DxrXV7xJKA45Gueii5Lh0aVXHsOewt6Sjz6RLsK
         UHHeFaZe8LRD5XvP5FWv/gqWhRQOtHu4NKK7fjfU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40AEB8B84C;
        Thu, 22 Aug 2019 18:34:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5vmrNhqZORQE; Thu, 22 Aug 2019 18:34:03 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05FE28B81D;
        Thu, 22 Aug 2019 18:34:03 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D577B6B730; Thu, 22 Aug 2019 16:34:02 +0000 (UTC)
Message-Id: <8821031917206414454a100bb9721ea078693600.1566491310.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566491310.git.christophe.leroy@c-s.fr>
References: <cover.1566491310.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/8] powerpc/vdso32: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Aug 2019 16:34:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is copied and adapted from commit 5c929885f1bb ("powerpc/vdso64:
Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
from Santosh Sivaraj <santosh@fossix.org>

Benchmark from vdsotest-all:
clock-gettime-realtime: syscall: 3601 nsec/call
clock-gettime-realtime:    libc: 1072 nsec/call
clock-gettime-realtime:    vdso: 931 nsec/call
clock-gettime-monotonic: syscall: 4034 nsec/call
clock-gettime-monotonic:    libc: 1213 nsec/call
clock-gettime-monotonic:    vdso: 1076 nsec/call
clock-gettime-realtime-coarse: syscall: 2722 nsec/call
clock-gettime-realtime-coarse:    libc: 805 nsec/call
clock-gettime-realtime-coarse:    vdso: 668 nsec/call
clock-gettime-monotonic-coarse: syscall: 2949 nsec/call
clock-gettime-monotonic-coarse:    libc: 882 nsec/call
clock-gettime-monotonic-coarse:    vdso: 745 nsec/call

Additional test passed with:
	vdsotest -d 30 clock-gettime-monotonic-coarse verify

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Link: https://github.com/linuxppc/issues/issues/41
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 64 +++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index becd9f8767ed..decd263c16e0 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -71,7 +71,13 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cmpli	cr0,r3,CLOCK_REALTIME
 	cmpli	cr1,r3,CLOCK_MONOTONIC
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-	bne	cr0,99f
+
+	cmpli	cr5,r3,CLOCK_REALTIME_COARSE
+	cmpli	cr6,r3,CLOCK_MONOTONIC_COARSE
+	cror	cr5*4+eq,cr5*4+eq,cr6*4+eq
+
+	cror	cr0*4+eq,cr0*4+eq,cr5*4+eq
+	bne	cr0, .Lgettime_fallback
 
 	mflr	r12			/* r12 saves lr */
   .cfi_register lr,r12
@@ -80,8 +86,10 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mr	r9,r3			/* datapage ptr in r9 */
 	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
 	ori	r7,r7,NSEC_PER_SEC@l
-50:	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
-	bne	cr1,80f			/* not monotonic -> all done */
+	beq	cr5, .Lcoarse_clocks
+.Lprecise_clocks:
+	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
+	bne	cr1, .Lfinish		/* not monotonic -> all done */
 
 	/*
 	 * CLOCK_MONOTONIC
@@ -105,12 +113,53 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	add	r9,r9,r0
 	lwz	r0,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
         cmpl    cr0,r8,r0		/* check if updated */
-	bne-	50b
+	bne-	.Lprecise_clocks
+	b	.Lfinish_monotonic
+
+	/*
+	 * For coarse clocks we get data directly from the vdso data page, so
+	 * we don't need to call __do_get_tspec, but we still need to do the
+	 * counter trick.
+	 */
+.Lcoarse_clocks:
+	lwz	r8,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
+	andi.	r0,r8,1                 /* pending update ? loop */
+	bne-	.Lcoarse_clocks
+	add	r9,r9,r0		/* r0 is already 0 */
+
+	/*
+	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
+	 * too
+	 */
+	lwz	r3,STAMP_XTIME+TSPC32_TV_SEC(r9)
+	lwz	r4,STAMP_XTIME+TSPC32_TV_NSEC(r9)
+	bne	cr6,1f
+
+	/* CLOCK_MONOTONIC_COARSE */
+	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
+	lwz	r6,WTOM_CLOCK_NSEC(r9)
+
+	/* check if counter has updated */
+	or	r0,r6,r5
+1:	or	r0,r0,r3
+	or	r0,r0,r4
+	xor	r0,r0,r0
+	add	r3,r3,r0
+	lwz	r0,CFG_TB_UPDATE_COUNT+LOPART(r9)
+	cmpl	cr0,r0,r8               /* check if updated */
+	bne-	.Lcoarse_clocks
+
+	/* Counter has not updated, so continue calculating proper values for
+	 * sec and nsec if monotonic coarse, or just return with the proper
+	 * values for realtime.
+	 */
+	bne	cr6, .Lfinish
 
 	/* Calculate and store result. Note that this mimics the C code,
 	 * which may cause funny results if nsec goes negative... is that
 	 * possible at all ?
 	 */
+.Lfinish_monotonic:
 	add	r3,r3,r5
 	add	r4,r4,r6
 	cmpw	cr0,r4,r7
@@ -118,11 +167,12 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	blt	1f
 	subf	r4,r7,r4
 	addi	r3,r3,1
-1:	bge	cr1,80f
+1:	bge	cr1, .Lfinish
 	addi	r3,r3,-1
 	add	r4,r4,r7
 
-80:	stw	r3,TSPC32_TV_SEC(r11)
+.Lfinish:
+	stw	r3,TSPC32_TV_SEC(r11)
 	stw	r4,TSPC32_TV_NSEC(r11)
 
 	mtlr	r12
@@ -133,7 +183,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	/*
 	 * syscall fallback
 	 */
-99:
+.Lgettime_fallback:
 	li	r0,__NR_clock_gettime
   .cfi_restore lr
 	sc
-- 
2.13.3

