Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB820830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SB6H8+gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfCYInj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:43:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfCYIng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:43:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44SSTY6VCsz9v0Yf;
        Mon, 25 Mar 2019 09:43:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SB6H8+gG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JfIeCVt34caO; Mon, 25 Mar 2019 09:43:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44SSTY5NCWz9v0Yd;
        Mon, 25 Mar 2019 09:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553503409; bh=OnQtmWg9C9UStx9j31BaChQI6BzXyrV/OOoH1buhqws=;
        h=From:Subject:To:Cc:Date:From;
        b=SB6H8+gGB0JpHxzT7cmlZcg03bIxRrb+JzZbtG0rQZI8N62LTZHT/hmn1qHfyYbu5
         Z68x7NYVDVVvkHohYxgUSYOtiWmPLIY444VwxfzJ98/N+nZVo3+kWhulyONEtqemvL
         qk57reGo69tHI8WTg+INwsuttanuqJlgiGhzzU1w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49D508B89B;
        Mon, 25 Mar 2019 09:43:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hpS_PZ4n1TPe; Mon, 25 Mar 2019 09:43:34 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1136A8B74F;
        Mon, 25 Mar 2019 09:43:34 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CC8E86FC66; Mon, 25 Mar 2019 08:43:33 +0000 (UTC)
Message-Id: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/rtas: fix early boot failure.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Mar 2019 08:43:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing
stack pointer while in RTAS") changes the code to use a field in
thread struct to store the stack pointer while in RTAS instead of
using SPRN_SPRG2. It therefore converts all places which were
manipulating SPRN_SPRG2 to use that field. During early startup,
the zeroing of SPRN_SPRG2 has been replaced by a zeroing of that
field in thread struct. But at least in start_here, that's done
wrongly because it used the physical address of the fields while
MMU is on at that time.

So the virtual address of the field should be used instead, but in
the meantime, thread struct has already been zeroised and initialised
so we can just drop this initialisation.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Fixes: 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 48051c8977c5..e25b615e9f9e 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -851,10 +851,6 @@ __secondary_start:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
 	mtspr	SPRN_SPRG_THREAD,r4
-#ifdef CONFIG_PPC_RTAS
-	li	r3,0
-	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
-#endif
 	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
 	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
 	mtspr	SPRN_SPRG_PGDIR, r4
@@ -941,10 +937,6 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
-#ifdef CONFIG_PPC_RTAS
-	li	r3,0
-	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
-#endif
 	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
 	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
 	mtspr	SPRN_SPRG_PGDIR, r4
-- 
2.13.3

