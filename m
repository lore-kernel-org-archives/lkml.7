Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62798C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3029F206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Yu0/cyLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfGaGBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:01:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaGBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:01:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45z2qp3v34z9vBLm;
        Wed, 31 Jul 2019 08:01:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Yu0/cyLA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NSKsWU6BdTI3; Wed, 31 Jul 2019 08:01:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45z2qp2kbNz9vBLQ;
        Wed, 31 Jul 2019 08:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564552902; bh=IG7IceHsqpR4ypCLfyEAq7ZqVq97qCsq5eFIVAcghZA=;
        h=From:Subject:To:Cc:Date:From;
        b=Yu0/cyLArZOyeVzBDEwsi8J7PHg42rs84VU6QdqraFH++PVrqrvGp6ncPLIJoVnp5
         1H8C1uU2nFs0NvMxDu9BSx9u/DRsthsrqI30Bx3wJ+Xzigf5xrVwFsUDyvsVKiEAPm
         bKF+1sKWcK/wtseoqOCwUTm8MMVaTvBiaHzxNNRQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39BED8B824;
        Wed, 31 Jul 2019 08:01:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ovo0elEEJFsH; Wed, 31 Jul 2019 08:01:43 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 084B28B752;
        Wed, 31 Jul 2019 08:01:43 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C64E968F53; Wed, 31 Jul 2019 06:01:42 +0000 (UTC)
Message-Id: <da89670093651437f27d2975224712e0a130b055.1564552796.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/kasan: fix early boot failure on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 31 Jul 2019 06:01:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to commit 4a6d8cf90017 ("powerpc/mm: don't use pte_alloc_kernel()
until slab is available on PPC32"), pte_alloc_kernel() cannot be used
during early KASAN init.

Fix it by using memblock_alloc() instead.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 0d62be3cba47..74f4555a62ba 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -21,7 +21,7 @@ static void kasan_populate_pte(pte_t *ptep, pgprot_t prot)
 		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
 }
 
-static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
+static int __ref kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
@@ -35,7 +35,10 @@ static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		new = pte_alloc_one_kernel(&init_mm);
+		if (slab_is_available())
+			new = pte_alloc_one_kernel(&init_mm);
+		else
+			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
 		if (!new)
 			return -ENOMEM;
-- 
2.13.3

