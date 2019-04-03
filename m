Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC807C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884AD2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="I1laEwCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDCUGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:06:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48109 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfDCUGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCB2fvQz9v9xv;
        Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=I1laEwCX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id syjxpZMeIk_6; Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCB1YV4z9v6Km;
        Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321974; bh=I6vDW7xatwA/Ox9lPNQD2SArMrxzZL5Q321+bt074uY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=I1laEwCX1rwZesVIU2/66nXtw5l7X2R36QazhjPeH5tF0z2l2cEGEnGs1LjDbCy94
         0j7a7FEeegq5yxgMpgBb2OXfBlJiM6GI5lO8BCGpAQubv1UK952YJxA4uVr1DWvW3h
         cwoVEXprljUPkgZ2QEUXV2yhYxxq8SrPQgemPOSs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54E5A8B905;
        Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ECypOPOUf9EK; Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E86C8B902;
        Wed,  3 Apr 2019 22:06:14 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 21E6D655EC; Wed,  3 Apr 2019 20:06:14 +0000 (UTC)
Message-Id: <ab6175d5ba0a1716ff068b35c4e9d073357b75c0.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 02/15] powerpc/mm: define __pud_free_tlb() at all time on
 nohash/64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PPC_64K_PAGES is not selectable on nohash/64, so get
__pud_free_tlb() defined at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 66d086f85bd5..ded453f9b5a8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -171,12 +171,9 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
 	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
-#ifndef CONFIG_PPC_64K_PAGES
 #define __pud_free_tlb(tlb, pud, addr)		      \
 	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
 
-#endif /* CONFIG_PPC_64K_PAGES */
-
 #define check_pgt_cache()	do { } while (0)
 
 #endif /* _ASM_POWERPC_PGALLOC_64_H */
-- 
2.13.3

