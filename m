Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35898C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39B421850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dRCFgRrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCTKHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:07:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37117 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfCTKGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZ55R4Cz9vC01;
        Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dRCFgRrL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rEzj4i2gFG5C; Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ54HXSz9vByx;
        Wed, 20 Mar 2019 11:06:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076413; bh=q2dlJcvwEx/19eP32GJoFNCETbHxRUMjc50a+XUWIls=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dRCFgRrL14qfFEKtLkGdld3JAzYDFmaJpaszSzdDQTDag3bhdOiEndInPRhpi73YI
         SbAaocZ4wlDGXfG/3iWKr3zdhnxPEkj4qSgL3iM1tN5VN0X8F3htETusVi4+R4sgbu
         WilFfN+ananrCgI6m5nuOgG5C8oxwmdJ4TcTd2rQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B21718B918;
        Wed, 20 Mar 2019 11:06:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OP7VsYGiveK5; Wed, 20 Mar 2019 11:06:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 956A58B911;
        Wed, 20 Mar 2019 11:06:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6ECA463AEF; Wed, 20 Mar 2019 10:06:54 +0000 (UTC)
Message-Id: <87b95ea8a9ea8395a3418f9c06bdf956cd944d5e.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 18/27] powerpc/mm: cleanup remaining ifdef mess in
 hugetlbpage.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 3 subarches support huge pages. So when it either 2 of them, it
is not the third one.

And mmu_has_feature() is known by all subarches so IS_ENABLED() can
be used instead of #ifdef

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index dd62006e1243..a463ebf276b6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -226,7 +226,7 @@ int __init alloc_bootmem_huge_page(struct hstate *h)
 	return __alloc_bootmem_huge_page(h);
 }
 
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
+#ifndef CONFIG_PPC_BOOK3S_64
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
 
@@ -596,10 +596,10 @@ static int __init hugetlbpage_init(void)
 		return 0;
 	}
 
-#if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
-	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled() &&
+	    !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
-#endif
+
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		unsigned shift;
 		unsigned pdshift;
@@ -637,10 +637,8 @@ static int __init hugetlbpage_init(void)
 			pgtable_cache_add(PTE_INDEX_SIZE);
 		else if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift);
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-		else
+		else if (IS_ENABLED(CONFIG_PPC_FSL_BOOK3E) || IS_ENABLED(CONFIG_PPC_8xx))
 			pgtable_cache_add(PTE_T_ORDER);
-#endif
 	}
 
 	if (IS_ENABLED(HUGETLB_PAGE_SIZE_VARIABLE))
-- 
2.13.3

