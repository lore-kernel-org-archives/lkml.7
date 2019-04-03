Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC1C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058FE2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WQIns6iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDCUGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:06:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22434 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfDCUG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCQ6gHgz9v3pp;
        Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WQIns6iB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OrLqd6ybMcLt; Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCQ5ZgCz9v3pn;
        Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321986; bh=83xPdMubQ9TI2dV0cl8TnZ18eHRoYYi1ptzaynCcobI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WQIns6iBWdE6jaOdm6Br9B/S4i3OeM3sV/3QOf8F/xsl7fF4L6GPp3kQfuI7vyZic
         ar809nFi6DsbH/0wTD2xbmgom1f/F5P9j7rlwLaqIjR9zoVysNoHjRUVaG4PE6iC3L
         Ml2h/ybhO5uSQn5wO0Ov5K+g4ollJs1AiERPHa5Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E34BF8B905;
        Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T-Z8-pTgKXSC; Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD5DE8B902;
        Wed,  3 Apr 2019 22:06:26 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 97461655EC; Wed,  3 Apr 2019 20:06:26 +0000 (UTC)
Message-Id: <48d8eb7326806e7f6e4d1eb210adb95a2c9f6ff5.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 14/15] powerpc/mm: refactor pmd_pgtable()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_pgtable() is identical on the 4 subarches, refactor it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 2 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 5 -----
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 2 --
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 --
 arch/powerpc/include/asm/pgalloc.h           | 5 +++++
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 1b9b5c228230..998317702630 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -37,8 +37,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 	*pmdp = __pmd(__pa(pte_page) | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index df2dce6afe14..053a7940504e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -163,11 +163,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	*pmd = __pmd(__pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
 }
 
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)pmd_page_vaddr(pmd);
-}
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6c0f5151dc1d..137761b01588 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -43,6 +43,4 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 		*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index c636feced1ff..5a0ea63c77c7 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -59,8 +59,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, (unsigned long)pte_page);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 5761bee0f004..2b2c60a1a66d 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -72,4 +72,9 @@ static inline void check_pgt_cache(void) { }
 #include <asm/nohash/pgalloc.h>
 #endif
 
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return (pgtable_t)pmd_page_vaddr(pmd);
+}
+
 #endif /* _ASM_POWERPC_PGALLOC_H */
-- 
2.13.3

