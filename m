Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70DC208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oYqoNCVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDZP6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:58:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51081 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfDZP6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:58:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44rJcN4LM2z9v0yQ;
        Fri, 26 Apr 2019 17:58:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oYqoNCVF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GMQg314ZIhAo; Fri, 26 Apr 2019 17:58:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44rJcN38l6z9v0yN;
        Fri, 26 Apr 2019 17:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556294292; bh=gq2Nx/itywCyxGDuPbA+x+AlDfSMPOE10U84+Sw7e6E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=oYqoNCVFYzZkaAEyPA83IDcET8iGXFTgMfaeZ98Woh1FTPwyxyZnrxSIQW+RSK5rj
         w9m7/kGhMVnP0iD7zWVglig4ds6acB91tfiX50i0faFTxmMS5fJ8kxCCo3Pfae7Dbo
         9RKpLT9xeoAM/uKVoMKScvTfHE81mp3bt78XEJ/4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 17A088B94A;
        Fri, 26 Apr 2019 17:58:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4KNfwYMLUf1F; Fri, 26 Apr 2019 17:58:14 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F39DC8B82F;
        Fri, 26 Apr 2019 17:58:13 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D2623666FE; Fri, 26 Apr 2019 15:58:13 +0000 (UTC)
Message-Id: <cf0b6c1ff5ca934bbe02f88b1b1ba533b386225e.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 15/15] powerpc/mm: refactor pgd_alloc() and pgd_free() on
 nohash
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 26 Apr 2019 15:58:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgd_alloc() and pgd_free() are identical on nohash 32 and 64.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 11 -----------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 11 -----------
 arch/powerpc/include/asm/nohash/pgalloc.h    | 12 ++++++++++++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 137761b01588..11eac371e7e0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -5,17 +5,6 @@
 #include <linux/threads.h>
 #include <linux/slab.h>
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
-}
-
 /*
  * We don't have any real pmd's, and this code never triggers because
  * the pgd will always be present..
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 5a0ea63c77c7..62321cd12da9 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -18,17 +18,6 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
-}
-
 #define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 4fccac6af3ad..332b13b4ecdb 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_NOHASH_PGALLOC_H
 
 #include <linux/mm.h>
+#include <linux/slab.h>
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 #ifdef CONFIG_PPC64
@@ -16,6 +17,17 @@ static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
 }
 #endif /* !CONFIG_PPC_BOOK3E */
 
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
+}
+
 #ifdef CONFIG_PPC64
 #include <asm/nohash/64/pgalloc.h>
 #else
-- 
2.13.3

