Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C172C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="C5lhLwpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHPFln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:41:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3321 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfHPFlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:41:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468sdH60FGz9txsx;
        Fri, 16 Aug 2019 07:41:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=C5lhLwpl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gExlPo0f7j56; Fri, 16 Aug 2019 07:41:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468sdH4rX9z9tygC;
        Fri, 16 Aug 2019 07:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565934099; bh=WYMNLBFh6ch1zZnLludHa1zT7jT6U/Npzey3DZ406rk=;
        h=From:Subject:To:Cc:Date:From;
        b=C5lhLwpleju2b8lyT+L27+zEbj+avXjLCfBBxMxmRpMFKuXZydNZzww35RD4suPNt
         A3/llx9A6wn0EMy3RhP3sdb9eKB/W2Q/xysEX1PKITP1ElUoNpO6MifhOzZWQPEIZG
         TPpC6D5Gi7SHldu/E7cq2Dc8inzkXkGoxTk0Qhqw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D6898B776;
        Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YQUxJCzoC-E9; Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AB1C8B754;
        Fri, 16 Aug 2019 07:41:40 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 49DDE6B6CC; Fri, 16 Aug 2019 05:41:40 +0000 (UTC)
Message-Id: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/5] powerpc/mm: define empty update_mmu_cache() as static
 inline
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 16 Aug 2019 05:41:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only BOOK3S and FSL_BOOK3E have a usefull update_mmu_cache().

For the others, just define it static inline.

In the meantime, simplify the FSL_BOOK3E related ifdef as
book3e_hugetlb_preload() only exists when CONFIG_PPC_FSL_BOOK3E
is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/pgtable.h | 11 +++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h | 13 +++++++++++++
 arch/powerpc/include/asm/pgtable.h        | 12 ------------
 arch/powerpc/mm/mem.c                     | 11 +++++++----
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index 6436b65ac7bc..0e1263455d73 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -26,5 +26,16 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ * On machines which use an MMU hash table, we use this to put a
+ * corresponding HPTE into the hash table ahead of time, instead of
+ * waiting for the inevitable extra hash-table miss exception.
+ */
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 1ca1c1864b32..7fed9dc0f147 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -293,5 +293,18 @@ static inline int pgd_huge(pgd_t pgd)
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ */
+#if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_HUGETLB_PAGE)
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
+#else
+static inline
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep) {}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index c58ba7963688..c70916a7865a 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -77,18 +77,6 @@ extern void paging_init(void);
 
 #include <asm-generic/pgtable.h>
 
-
-/*
- * This gets called at the end of handling a page fault, when
- * the kernel has put a new PTE into the page table for the process.
- * We use it to ensure coherency between the i-cache and d-cache
- * for the page which has just been mapped in.
- * On machines which use an MMU hash table, we use this to put a
- * corresponding HPTE into the hash table ahead of time, instead of
- * waiting for the inevitable extra hash-table miss exception.
- */
-extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
-
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_large(pmd)		0
 #endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9191a66b3bc5..582ad728ac9d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -414,10 +414,10 @@ EXPORT_SYMBOL(flush_icache_user_range);
  * 
  * This must always be called with the pte lock held.
  */
+#ifdef CONFIG_PPC_BOOK3S
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
-#ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
@@ -455,13 +455,16 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 
 	hash_preload(vma->vm_mm, address, is_exec, trap);
+}
 #endif /* CONFIG_PPC_BOOK3S */
-#if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
-	&& defined(CONFIG_HUGETLB_PAGE)
+#if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_HUGETLB_PAGE)
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+		      pte_t *ptep)
+{
 	if (is_vm_hugetlb_page(vma))
 		book3e_hugetlb_preload(vma, address, *ptep);
-#endif
 }
+#endif
 
 /*
  * System memory should not be in /proc/iomem but various tools expect it
-- 
2.13.3

