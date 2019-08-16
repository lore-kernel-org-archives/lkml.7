Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8BEC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8603E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oqfC7rCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHPFln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:41:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64699 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPFln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:41:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468sdJ4m0fz9txv0;
        Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oqfC7rCu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aVEJRST0G_nS; Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468sdJ3ddCz9txty;
        Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565934100; bh=t4EaISFyjqqTityq896SebQSVDC7kJa7UoIn3sFKv+I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=oqfC7rCuCtbk8nonHpvlR6ZAzFoSkdmxyEVH7zr97r2ASH4JCpqGOcSOQGexZjlfX
         MNaG+yxedLaS0HzmsB0/JD0ep2NqpjjQTqPyJqECwNVnK5gM029qyxLwtmrKkCUYEu
         qrYD5hmaNyMhe/WfbZqJJ/1oOyknYiDCiuufNSZU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 713338B776;
        Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wHJbFhMqNw1B; Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57AC48B754;
        Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 554EC6B6CC; Fri, 16 Aug 2019 05:41:41 +0000 (UTC)
Message-Id: <4d69fdc86df9c74adc71a60331a86f6afb8b5e9e.1565933217.git.christophe.leroy@c-s.fr>
In-Reply-To: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
References: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/5] powerpc/mm: move FSL_BOOK3 version of update_mmu_cache()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 16 Aug 2019 05:41:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move FSL_BOOK3E version of update_mmu_cache() at the same
place as book3e_hugetlb_preload() as update_mmu_cache() is
the only user of book3e_hugetlb_preload().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h          |  3 ---
 arch/powerpc/mm/mem.c                       |  8 --------
 arch/powerpc/mm/nohash/book3e_hugetlbpage.c | 16 ++++++++++++++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 20a101046cff..bd6504c28c2f 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -31,9 +31,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 	return 0;
 }
 
-void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
-			    pte_t pte);
-
 #define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 582ad728ac9d..c45d44538ddb 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -457,14 +457,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	hash_preload(vma->vm_mm, address, is_exec, trap);
 }
 #endif /* CONFIG_PPC_BOOK3S */
-#if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_HUGETLB_PAGE)
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *ptep)
-{
-	if (is_vm_hugetlb_page(vma))
-		book3e_hugetlb_preload(vma, address, *ptep);
-}
-#endif
 
 /*
  * System memory should not be in /proc/iomem but various tools expect it
diff --git a/arch/powerpc/mm/nohash/book3e_hugetlbpage.c b/arch/powerpc/mm/nohash/book3e_hugetlbpage.c
index 61915f4d3c7f..8b88be91b622 100644
--- a/arch/powerpc/mm/nohash/book3e_hugetlbpage.c
+++ b/arch/powerpc/mm/nohash/book3e_hugetlbpage.c
@@ -122,8 +122,8 @@ static inline int book3e_tlb_exists(unsigned long ea, unsigned long pid)
 	return found;
 }
 
-void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
-			    pte_t pte)
+static void
+book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea, pte_t pte)
 {
 	unsigned long mas1, mas2;
 	u64 mas7_3;
@@ -183,6 +183,18 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	local_irq_restore(flags);
 }
 
+/*
+ * This is called at the end of handling a user page fault, when the
+ * fault has been handled by updating a PTE in the linux page tables.
+ *
+ * This must always be called with the pte lock held.
+ */
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	if (is_vm_hugetlb_page(vma))
+		book3e_hugetlb_preload(vma, address, *ptep);
+}
+
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 	struct hstate *hstate = hstate_file(vma->vm_file);
-- 
2.13.3

