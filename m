Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EFE217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDCEab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:30:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60308 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfDCEab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:30:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85EA8168F;
        Tue,  2 Apr 2019 21:30:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D9863F721;
        Tue,  2 Apr 2019 21:30:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, pasha.tatashin@oracle.com, david@redhat.com,
        cai@lca.pw
Subject: [PATCH 3/6] arm64/mm: Enable struct page allocation from device memory
Date:   Wed,  3 Apr 2019 10:00:03 +0530
Message-Id: <1554265806-11501-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_DEVICE based device memory like persistent memory would typically be
more than available system RAM and can have size in TBs. Allocating struct
pages from system RAM for these vast range of device memory will reduce
amount of system RAM available for other purposes. There is a mechanism
with struct vmem_altmap which reserves range of device memory to be used
for it's own struct pages.

On arm64 platforms this enables vmemmap_populate() & vmemmap_free() which
creates & destroys struct page mapping to accommodate a given instance of
struct vmem_altmap.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0777b..4b25b75 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -735,6 +735,15 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_pages((unsigned long)page_address(page), order);
 }
 
+static void __meminit free_huge_pagetable(struct page *page, int order,
+						struct vmem_altmap *altmap)
+{
+	if (altmap)
+		vmem_altmap_free(altmap, (1UL << order));
+	else
+		free_pagetable(page, order);
+}
+
 #if (CONFIG_PGTABLE_LEVELS > 2)
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd, bool direct)
 {
@@ -828,8 +837,8 @@ remove_pte_table(pte_t *pte_start, unsigned long addr,
 }
 
 static void __meminit
-remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
-			unsigned long end, bool direct)
+remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
+			bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pte_t *pte_base;
@@ -843,8 +852,8 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 
 		if (pmd_large(*pmd)) {
 			if (!direct)
-				free_pagetable(pmd_page(*pmd),
-						get_order(PMD_SIZE));
+				free_huge_pagetable(pmd_page(*pmd),
+						get_order(PMD_SIZE), altmap);
 			spin_lock(&init_mm.page_table_lock);
 			pmd_clear(pmd);
 			spin_unlock(&init_mm.page_table_lock);
@@ -857,8 +866,8 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 }
 
 static void __meminit
-remove_pud_table(pud_t *pud_start, unsigned long addr,
-			unsigned long end, bool direct)
+remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
+			bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	pmd_t *pmd_base;
@@ -872,21 +881,22 @@ remove_pud_table(pud_t *pud_start, unsigned long addr,
 
 		if (pud_large(*pud)) {
 			if (!direct)
-				free_pagetable(pud_page(*pud),
-						get_order(PUD_SIZE));
+				free_huge_pagetable(pud_page(*pud),
+						get_order(PUD_SIZE), altmap);
 			spin_lock(&init_mm.page_table_lock);
 			pud_clear(pud);
 			spin_unlock(&init_mm.page_table_lock);
 			continue;
 		}
 		pmd_base = pmd_offset(pud, 0UL);
-		remove_pmd_table(pmd_base, addr, next, direct);
+		remove_pmd_table(pmd_base, addr, next, direct, altmap);
 		free_pmd_table(pmd_base, pud, direct);
 	}
 }
 
 static void __meminit
-remove_pagetable(unsigned long start, unsigned long end, bool direct)
+remove_pagetable(unsigned long start, unsigned long end,
+			bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long addr, next;
 	pud_t *pud_base;
@@ -899,7 +909,7 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct)
 			continue;
 
 		pud_base = pud_offset(pgd, 0UL);
-		remove_pud_table(pud_base, addr, next, direct);
+		remove_pud_table(pud_base, addr, next, direct, altmap);
 		free_pud_table(pud_base, pgd, direct);
 	}
 	flush_tlb_kernel_range(start, end);
@@ -938,7 +948,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
+			if (altmap)
+				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
+			else
+				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
 			if (!p)
 				return -ENOMEM;
 
@@ -954,7 +967,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
 #ifdef CONFIG_MEMORY_HOTPLUG
-	remove_pagetable(start, end, false);
+	remove_pagetable(start, end, false, altmap);
 #endif
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
@@ -1244,7 +1257,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
 static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 {
 	WARN_ON(pgdir != init_mm.pgd);
-	remove_pagetable(start, start + size, true);
+	remove_pagetable(start, start + size, true, NULL);
 }
 
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
-- 
2.7.4

