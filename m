Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0862175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vYURiZZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCTKGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30197 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCTKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYx2sWbz9vC0C;
        Wed, 20 Mar 2019 11:06:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=vYURiZZS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4o5wOWDjmx1r; Wed, 20 Mar 2019 11:06:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYx1gfHz9vC09;
        Wed, 20 Mar 2019 11:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076405; bh=eD+OnTvXXBmU17ByAiyjj/H0YiRpiZ8bmGRJJfpSFWk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=vYURiZZSlCbbBw8K6uzPbAdln8kehieqBeIA7wrT6GG0vnIzdiIWdo8/wjypsA2CM
         hH+GHZnNbYdrgbC1Lvmo9K0RgZXYXEv3WPh6C6m2S4GpSYdtb8Xtjeta9SXIDxS7SZ
         jkUBnDGlP0lDwe7P6s4X/WzdNhu5YyypnX1Duybs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 534518B918;
        Wed, 20 Mar 2019 11:06:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dk4dA4h4PLKW; Wed, 20 Mar 2019 11:06:46 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33E508B911;
        Wed, 20 Mar 2019 11:06:46 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1B2EC63AEF; Wed, 20 Mar 2019 10:06:46 +0000 (UTC)
Message-Id: <62a244f5b4f46d51b11a5189156fd7b27fdc7b57.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 10/27] powerpc/mm: make gup_hugepte() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gup_huge_pd() is the only user of gup_hugepte() and it is
located in the same file. This patch moves gup_huge_pd()
after gup_hugepte() and makes gup_hugepte() static.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h |  3 ---
 arch/powerpc/mm/hugetlbpage.c      | 38 +++++++++++++++++++-------------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 505550fb2935..c51846da41a7 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -89,9 +89,6 @@ extern void paging_init(void);
  */
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
 
-extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		       unsigned long end, int write,
-		       struct page **pages, int *nr);
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_large(pmd)		0
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 6d9751b188c1..29d1568c7775 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -539,23 +539,6 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
-int gup_huge_pd(hugepd_t hugepd, unsigned long addr, unsigned pdshift,
-		unsigned long end, int write, struct page **pages, int *nr)
-{
-	pte_t *ptep;
-	unsigned long sz = 1UL << hugepd_shift(hugepd);
-	unsigned long next;
-
-	ptep = hugepte_offset(hugepd, addr, pdshift);
-	do {
-		next = hugepte_addr_end(addr, end, sz);
-		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
-			return 0;
-	} while (ptep++, addr = next, addr != end);
-
-	return 1;
-}
-
 #ifdef CONFIG_PPC_MM_SLICES
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
@@ -754,8 +737,8 @@ void flush_dcache_icache_hugepage(struct page *page)
 	}
 }
 
-int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		unsigned long end, int write, struct page **pages, int *nr)
+static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
+		       unsigned long end, int write, struct page **pages, int *nr)
 {
 	unsigned long pte_end;
 	struct page *head, *page;
@@ -801,3 +784,20 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 
 	return 1;
 }
+
+int gup_huge_pd(hugepd_t hugepd, unsigned long addr, unsigned int pdshift,
+		unsigned long end, int write, struct page **pages, int *nr)
+{
+	pte_t *ptep;
+	unsigned long sz = 1UL << hugepd_shift(hugepd);
+	unsigned long next;
+
+	ptep = hugepte_offset(hugepd, addr, pdshift);
+	do {
+		next = hugepte_addr_end(addr, end, sz);
+		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
+			return 0;
+	} while (ptep++, addr = next, addr != end);
+
+	return 1;
+}
-- 
2.13.3

