Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E8620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LJD/TT88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfCKIaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:30:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57540 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfCKIaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:30:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Hrrv5c3qzB09ZG;
        Mon, 11 Mar 2019 09:30:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LJD/TT88; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZLVP7xvMeONR; Mon, 11 Mar 2019 09:30:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrrv4WVvzB09ZD;
        Mon, 11 Mar 2019 09:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552293023; bh=OGZz0Q4R6Zdt3TK+8zOZmGmuwyLbFuizUxlVfu9yL9A=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LJD/TT887bLaODNMA/oS7jf1JB3Q2Of7WbGD4XWOuFBC1UUqnssCeA80DLIkYqf2H
         UhFcQJrQrguA+SloLKJsfQdf+/hbGKZHiGnz/co3PqwK88Hl/Xg4RVQEPkk3R9tg/O
         0M0WNgMAyl9O1By6Iun5Bc4+XFB0sl7v703Z3L20=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 26C938B813;
        Mon, 11 Mar 2019 09:30:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7A7YHdLI4gQ3; Mon, 11 Mar 2019 09:30:28 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00DAA8B7FE;
        Mon, 11 Mar 2019 09:30:27 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ED3AC6FA08; Mon, 11 Mar 2019 08:30:27 +0000 (UTC)
Message-Id: <b348c3da010023d1c163ddd527aab6aba87f73ee.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/10] powerpc/6xx: fix setup and use of SPRN_SPRG_PGDIR
 for hash32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Mar 2019 08:30:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not only the 603 but all 6xx need SPRN_SPRG_PGDIR to be initialised at
startup. This patch move it from __setup_cpu_603() to start_here()
and __secondary_start(), close to the initialisation of SPRN_THREAD.

Previously, virt addr of PGDIR was retrieved from thread struct.
Now that it is the phys addr which is stored in SPRN_SPRG_PGDIR,
hash_page() shall not convert it to phys anymore.
This patch removes the conversion.

Fixes: 93c4a162b014("powerpc/6xx: Store PGDIR physical address in a SPRG")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cpu_setup_6xx.S | 3 ---
 arch/powerpc/kernel/head_32.S       | 6 ++++++
 arch/powerpc/mm/hash_low_32.S       | 8 ++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 6f1c11e0691f..7534ecff5e92 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -24,9 +24,6 @@ BEGIN_MMU_FTR_SECTION
 	li	r10,0
 	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
-	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
-	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
-	mtspr	SPRN_SPRG_PGDIR, r10
 
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index ce6a972f2584..48051c8977c5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -855,6 +855,9 @@ __secondary_start:
 	li	r3,0
 	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
 #endif
+	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_PGDIR, r4
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
@@ -942,6 +945,9 @@ start_here:
 	li	r3,0
 	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
 #endif
+	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
+	mtspr	SPRN_SPRG_PGDIR, r4
 
 	/* stack */
 	lis	r1,init_thread_union@ha
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1f13494efb2b..a6c491f18a04 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -70,12 +70,12 @@ _GLOBAL(hash_page)
 	lis	r0,KERNELBASE@h		/* check if kernel address */
 	cmplw	0,r4,r0
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
-	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
+	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
 	blt+	112f			/* assume user more likely */
-	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
-	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
+	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
+	addi	r5 ,r5 ,(swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
-112:	tophys(r5, r5)
+112:
 #ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
 	lwz	r8,0(r5)		/* get pmd entry */
-- 
2.13.3

