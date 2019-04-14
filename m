Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BBC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EE62175B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 05:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfDNF7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 01:59:41 -0400
Received: from foss.arm.com ([217.140.101.70]:49622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfDNF7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 01:59:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8110615AD;
        Sat, 13 Apr 2019 22:59:39 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A6343F557;
        Sat, 13 Apr 2019 22:59:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: [PATCH V2 2/2] arm64/mm: Enable memory hot remove
Date:   Sun, 14 Apr 2019 11:29:13 +0530
Message-Id: <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory removal from an arch perspective involves tearing down two different
kernel based mappings i.e vmemmap and linear while releasing related page
table pages allocated for the physical memory range to be removed.

Define a common kernel page table tear down helper remove_pagetable() which
can be used to unmap given kernel virtual address range. In effect it can
tear down both vmemap or kernel linear mappings. This new helper is called
from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
The argument 'direct' here identifies kernel linear mappings.

Vmemmap mappings page table pages are allocated through sparse mem helper
functions like vmemmap_alloc_block() which does not cycle the pages through
pgtable_page_ctor() constructs. Hence while removing it skips corresponding
destructor construct pgtable_page_dtor().

While here update arch_add_mempory() to handle __add_pages() failures by
just unmapping recently added kernel linear mapping. Now enable memory hot
remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.

This implementation is overall inspired from kernel page table tear down
procedure on X86 architecture.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig               |   3 +
 arch/arm64/include/asm/pgtable.h |   2 +
 arch/arm64/mm/mmu.c              | 221 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 224 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c383625..a870eb2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -267,6 +267,9 @@ config HAVE_GENERIC_GUP
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index de70c1e..1ee22ff 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -555,6 +555,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 #else
 
+#define pmd_index(addr) 0
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
@@ -612,6 +613,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 
 #else
 
+#define pud_index(adrr)	0
 #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
 
 /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ef82312..a4750fe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -733,6 +733,194 @@ int kern_addr_valid(unsigned long addr)
 
 	return pfn_valid(pte_pfn(pte));
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void free_pagetable(struct page *page, int order)
+{
+	unsigned long magic;
+	unsigned int nr_pages = 1 << order;
+
+	if (PageReserved(page)) {
+		__ClearPageReserved(page);
+
+		magic = (unsigned long)page->freelist;
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			while (nr_pages--)
+				free_reserved_page(page++);
+		}
+	} else {
+		free_pages((unsigned long)page_address(page), order);
+	}
+}
+
+#if (CONFIG_PGTABLE_LEVELS > 2)
+static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	free_pagetable(pmd_page(*pmd), 0);
+	spin_lock(&init_mm.page_table_lock);
+	pmd_clear(pmd);
+	spin_unlock(&init_mm.page_table_lock);
+}
+#else
+static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+}
+#endif
+
+#if (CONFIG_PGTABLE_LEVELS > 3)
+static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	free_pagetable(pud_page(*pud), 0);
+	spin_lock(&init_mm.page_table_lock);
+	pud_clear(pud);
+	spin_unlock(&init_mm.page_table_lock);
+}
+
+static void free_pud_table(pud_t *pud_start, pgd_t *pgd)
+{
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	free_pagetable(pgd_page(*pgd), 0);
+	spin_lock(&init_mm.page_table_lock);
+	pgd_clear(pgd);
+	spin_unlock(&init_mm.page_table_lock);
+}
+#else
+static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+}
+
+static void free_pud_table(pud_t *pud_start, pgd_t *pgd)
+{
+}
+#endif
+
+static void
+remove_pte_table(pte_t *pte_start, unsigned long addr,
+			unsigned long end, bool direct)
+{
+	pte_t *pte;
+
+	pte = pte_start + pte_index(addr);
+	for (; addr < end; addr += PAGE_SIZE, pte++) {
+		if (!pte_present(*pte))
+			continue;
+
+		if (!direct)
+			free_pagetable(pte_page(*pte), 0);
+		spin_lock(&init_mm.page_table_lock);
+		pte_clear(&init_mm, addr, pte);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+}
+
+static void
+remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
+			unsigned long end, bool direct)
+{
+	unsigned long next;
+	pte_t *pte_base;
+	pmd_t *pmd;
+
+	pmd = pmd_start + pmd_index(addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+		if (!pmd_present(*pmd))
+			continue;
+
+		if (pmd_sect(*pmd)) {
+			if (!direct)
+				free_pagetable(pmd_page(*pmd),
+						get_order(PMD_SIZE));
+			spin_lock(&init_mm.page_table_lock);
+			pmd_clear(pmd);
+			spin_unlock(&init_mm.page_table_lock);
+			continue;
+		}
+		pte_base = pte_offset_kernel(pmd, 0UL);
+		remove_pte_table(pte_base, addr, next, direct);
+		free_pte_table(pte_base, pmd);
+	}
+}
+
+static void
+remove_pud_table(pud_t *pud_start, unsigned long addr,
+			unsigned long end, bool direct)
+{
+	unsigned long next;
+	pmd_t *pmd_base;
+	pud_t *pud;
+
+	pud = pud_start + pud_index(addr);
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+		if (!pud_present(*pud))
+			continue;
+
+		if (pud_sect(*pud)) {
+			if (!direct)
+				free_pagetable(pud_page(*pud),
+						get_order(PUD_SIZE));
+			spin_lock(&init_mm.page_table_lock);
+			pud_clear(pud);
+			spin_unlock(&init_mm.page_table_lock);
+			continue;
+		}
+		pmd_base = pmd_offset(pud, 0UL);
+		remove_pmd_table(pmd_base, addr, next, direct);
+		free_pmd_table(pmd_base, pud);
+	}
+}
+
+static void
+remove_pagetable(unsigned long start, unsigned long end, bool direct)
+{
+	unsigned long addr, next;
+	pud_t *pud_base;
+	pgd_t *pgd;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+		pgd = pgd_offset_k(addr);
+		if (!pgd_present(*pgd))
+			continue;
+
+		pud_base = pud_offset(pgd, 0UL);
+		remove_pud_table(pud_base, addr, next, direct);
+		free_pud_table(pud_base, pgd);
+	}
+	flush_tlb_kernel_range(start, end);
+}
+#endif
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 #if !ARM64_SWAPPER_USES_SECTION_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -780,6 +968,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+#ifdef CONFIG_MEMORY_HOTPLUG
+	remove_pagetable(start, end, false);
+#endif
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
@@ -1065,10 +1256,16 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
+{
+	WARN_ON(pgdir != init_mm.pgd);
+	remove_pagetable(start, start + size, true);
+}
+
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		    bool want_memblock)
 {
-	int flags = 0;
+	int ret, flags = 0;
 
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
@@ -1076,7 +1273,27 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
 
-	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
+	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   altmap, want_memblock);
+	if (ret)
+		__remove_pgd_mapping(swapper_pg_dir,
+					__phys_to_virt(start), size);
+	return ret;
 }
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone = page_zone(pfn_to_page(start_pfn));
+	int ret;
+
+	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	if (!ret)
+		__remove_pgd_mapping(swapper_pg_dir,
+					__phys_to_virt(start), size);
+	return ret;
+}
+#endif
 #endif
-- 
2.7.4

