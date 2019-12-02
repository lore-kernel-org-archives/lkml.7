Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA002146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 07:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dBB7rcYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLBH5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 02:57:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7492 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:57:37 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47RHXB5kv6z9txt5;
        Mon,  2 Dec 2019 08:57:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dBB7rcYa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TEHXNNCSGy1Q; Mon,  2 Dec 2019 08:57:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47RHXB4Yvnz9txsp;
        Mon,  2 Dec 2019 08:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575273450; bh=BOyz3x2j8FqwDgap1e4M4TWLLhjHOTpc8nf8rczMHLA=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dBB7rcYagcdpzDPv19SjvEFDXdH0yAB2KFkvaS8RBc+12wgXF73tZgEo7s1jegx37
         uR7YEa4uBs+tynuo3pJBw/fQz3zdHg2OwXTiIGh3H83LRPvR2HMlm8y7FN/Vw7hQRT
         +oELpgdx2pWxmE5iDi7ShOXIhfsscd7QVLbWOTOw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4292E8B79B;
        Mon,  2 Dec 2019 08:57:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Yi90lTl3K24X; Mon,  2 Dec 2019 08:57:35 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DC4B8B79A;
        Mon,  2 Dec 2019 08:57:35 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 18A1363600; Mon,  2 Dec 2019 07:57:35 +0000 (UTC)
Message-Id: <b4e79f963845545bcce1459cd6fcfe46bdde7863.1575273217.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1575273217.git.christophe.leroy@c-s.fr>
References: <cover.1575273217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 8/8] powerpc/vdso32: miscellaneous optimisations
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de
Date:   Mon,  2 Dec 2019 07:57:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various optimisations by inverting branches and removing
redundant instructions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso32/datapage.S     |  3 +--
 arch/powerpc/kernel/vdso32/getcpu.S       |  6 +++---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 18 +++++++++---------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 1095d818f94a..217bb630f8f9 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -30,11 +30,10 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	mr	r4,r3
+	mr.	r4,r3
 	get_datapage	r3, r0
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP32
-	cmpli	cr0,r4,0
 	beqlr
 	li	r0,NR_syscalls
 	stw	r0,0(r4)
diff --git a/arch/powerpc/kernel/vdso32/getcpu.S b/arch/powerpc/kernel/vdso32/getcpu.S
index 90b39af14383..ff5e214fec41 100644
--- a/arch/powerpc/kernel/vdso32/getcpu.S
+++ b/arch/powerpc/kernel/vdso32/getcpu.S
@@ -25,10 +25,10 @@ V_FUNCTION_BEGIN(__kernel_getcpu)
 	rlwinm  r7,r5,16,31-15,31-0
 	beq	cr0,1f
 	stw	r6,0(r3)
-1:	beq	cr1,2f
-	stw	r7,0(r4)
-2:	crclr	cr0*4+so
+1:	crclr	cr0*4+so
 	li	r3,0			/* always success */
+	beqlr	cr1
+	stw	r7,0(r4)
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_getcpu)
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 20ae38f3a5a3..a3951567118a 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -32,10 +32,9 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mflr	r12
   .cfi_register lr,r12
 
-	mr	r10,r3			/* r10 saves tv */
+	mr.	r10,r3			/* r10 saves tv */
 	mr	r11,r4			/* r11 saves tz */
 	get_datapage	r9, r0
-	cmplwi	r10,0			/* check if tv is NULL */
 	beq	3f
 	LOAD_REG_IMMEDIATE(r7, 1000000)	/* load up USEC_PER_SEC */
 	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
@@ -43,15 +42,16 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	stw	r4,TVAL32_TV_USEC(r10)
 
 3:	cmplwi	r11,0			/* check if tz is NULL */
-	beq	1f
+	mtlr	r12
+	crclr	cr0*4+so
+	li	r3,0
+	beqlr
+
 	lwz	r4,CFG_TZ_MINUTEWEST(r9)/* fill tz */
 	lwz	r5,CFG_TZ_DSTTIME(r9)
 	stw	r4,TZONE_TZ_MINWEST(r11)
 	stw	r5,TZONE_TZ_DSTTIME(r11)
 
-1:	mtlr	r12
-	crclr	cr0*4+so
-	li	r3,0
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_gettimeofday)
@@ -245,10 +245,10 @@ V_FUNCTION_BEGIN(__kernel_time)
 	lwz	r3,STAMP_XTIME_SEC+LOPART(r9)
 
 	cmplwi	r11,0			/* check if t is NULL */
-	beq	2f
-	stw	r3,0(r11)		/* store result at *t */
-2:	mtlr	r12
+	mtlr	r12
 	crclr	cr0*4+so
+	beqlr
+	stw	r3,0(r11)		/* store result at *t */
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_time)
-- 
2.13.3

