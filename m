Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61AAC5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C4B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF1EpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfF1EpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:45:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A26EC0A;
        Thu, 27 Jun 2019 21:45:12 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CDC23F706;
        Thu, 27 Jun 2019 21:45:10 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] arm64/mm: Enable device memory allocation and free for vmemmap mapping
Date:   Fri, 28 Jun 2019 10:14:43 +0530
Message-Id: <1561697083-7329-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables vmemmap_populate() and vmemmap_free() functions to incorporate
struct vmem_altmap based device memory allocation and free requests. With
this device memory with specific atlmap configuration can be hot plugged
and hot removed as ZONE_DEVICE memory on arm64 platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 57 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 39e18d1..8867bbd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -735,15 +735,26 @@ int kern_addr_valid(unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static void free_hotplug_page_range(struct page *page, size_t size)
+static void free_hotplug_page_range(struct page *page, size_t size,
+				    struct vmem_altmap *altmap)
 {
-	WARN_ON(!page || PageReserved(page));
-	free_pages((unsigned long)page_address(page), get_order(size));
+	if (altmap) {
+		/*
+		 * vmemmap_populate() creates vmemmap mapping either at pte
+		 * or pmd level. Unmapping request at any other level would
+		 * be a problem.
+		 */
+		WARN_ON((size != PAGE_SIZE) && (size != PMD_SIZE));
+		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
+	} else {
+		WARN_ON(!page || PageReserved(page));
+		free_pages((unsigned long)page_address(page), get_order(size));
+	}
 }
 
 static void free_hotplug_pgtable_page(struct page *page)
 {
-	free_hotplug_page_range(page, PAGE_SIZE);
+	free_hotplug_page_range(page, PAGE_SIZE, NULL);
 }
 
 static void free_pte_table(pmd_t *pmdp, unsigned long addr)
@@ -807,7 +818,8 @@ static void free_pud_table(pgd_t *pgdp, unsigned long addr)
 }
 
 static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
-				    unsigned long end, bool sparse_vmap)
+				    unsigned long end, bool sparse_vmap,
+				    struct vmem_altmap *altmap)
 {
 	struct page *page;
 	pte_t *ptep, pte;
@@ -823,12 +835,13 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 		pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		if (sparse_vmap)
-			free_hotplug_page_range(page, PAGE_SIZE);
+			free_hotplug_page_range(page, PAGE_SIZE, altmap);
 	} while (addr += PAGE_SIZE, addr < end);
 }
 
 static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
-				    unsigned long end, bool sparse_vmap)
+				    unsigned long end, bool sparse_vmap,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	struct page *page;
@@ -847,16 +860,17 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 			pmd_clear(pmdp);
 			flush_tlb_kernel_range(addr, next);
 			if (sparse_vmap)
-				free_hotplug_page_range(page, PMD_SIZE);
+				free_hotplug_page_range(page, PMD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pmd_table(pmd));
-		unmap_hotplug_pte_range(pmdp, addr, next, sparse_vmap);
+		unmap_hotplug_pte_range(pmdp, addr, next, sparse_vmap, altmap);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
-				    unsigned long end, bool sparse_vmap)
+				    unsigned long end, bool sparse_vmap,
+				    struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	struct page *page;
@@ -875,16 +889,16 @@ static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
 			pud_clear(pudp);
 			flush_tlb_kernel_range(addr, next);
 			if (sparse_vmap)
-				free_hotplug_page_range(page, PUD_SIZE);
+				free_hotplug_page_range(page, PUD_SIZE, altmap);
 			continue;
 		}
 		WARN_ON(!pud_table(pud));
-		unmap_hotplug_pmd_range(pudp, addr, next, sparse_vmap);
+		unmap_hotplug_pmd_range(pudp, addr, next, sparse_vmap, altmap);
 	} while (addr = next, addr < end);
 }
 
 static void unmap_hotplug_range(unsigned long addr, unsigned long end,
-				bool sparse_vmap)
+				bool sparse_vmap, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pgd_t *pgdp, pgd;
@@ -897,7 +911,7 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 			continue;
 
 		WARN_ON(!pgd_present(pgd));
-		unmap_hotplug_pud_range(pgdp, addr, next, sparse_vmap);
+		unmap_hotplug_pud_range(pgdp, addr, next, sparse_vmap, altmap);
 	} while (addr = next, addr < end);
 }
 
@@ -970,9 +984,9 @@ static void free_empty_tables(unsigned long addr, unsigned long end)
 }
 
 static void remove_pagetable(unsigned long start, unsigned long end,
-			     bool sparse_vmap)
+			     bool sparse_vmap, struct vmem_altmap *altmap)
 {
-	unmap_hotplug_range(start, end, sparse_vmap);
+	unmap_hotplug_range(start, end, sparse_vmap, altmap);
 	free_empty_tables(start, end);
 }
 #endif
@@ -982,7 +996,7 @@ static void remove_pagetable(unsigned long start, unsigned long end,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -1009,7 +1023,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
+			if (altmap)
+				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
+			else
+				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
 			if (!p)
 				return -ENOMEM;
 
@@ -1043,7 +1060,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 	 * given vmemmap range being hot-removed. Just unmap and free the
 	 * range instead.
 	 */
-	unmap_hotplug_range(start, end, true);
+	unmap_hotplug_range(start, end, true, altmap);
 #endif
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
@@ -1336,7 +1353,7 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	unsigned long end = start + size;
 
 	WARN_ON(pgdir != init_mm.pgd);
-	remove_pagetable(start, end, false);
+	remove_pagetable(start, end, false, NULL);
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
-- 
2.7.4

