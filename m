Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA52720862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfENJAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:00:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfENJAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:00:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C4B374;
        Tue, 14 May 2019 02:00:42 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56FB23F71E;
        Tue, 14 May 2019 02:00:34 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: [PATCH V3 4/4] arm64/mm: Enable memory hot remove
Date:   Tue, 14 May 2019 14:30:07 +0530
Message-Id: <1557824407-19092-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory removal from an arch perspective involves tearing down two different
kernel based mappings i.e vmemmap and linear while releasing related page
table and any mapped pages allocated for given physical memory range to be
removed.

Define a common kernel page table tear down helper remove_pagetable() which
can be used to unmap given kernel virtual address range. In effect it can
tear down both vmemap or kernel linear mappings. This new helper is called
from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.

For linear mapping there are no actual allocated pages which are mapped to
create the translation. Any pfn on a given entry is derived from physical
address (__va(PA) --> PA) whose linear translation is to be created. They
need not be freed as they were never allocated in the first place. But for
vmemmap which is a real virtual mapping (like vmalloc) physical pages are
allocated either from buddy or memblock which get mapped in the kernel page
table. These allocated and mapped pages need to be freed during translation
tear down. But page table pages need to be freed in both these cases.

These mappings need to be differentiated while deciding if a mapped page at
any level i.e [pte|pmd|pud]_page() should be freed or not. Callers for the
mapping tear down process should pass on 'sparse_vmap' variable identifying
kernel vmemmap mappings.

While here update arch_add_mempory() to handle __add_pages() failures by
just unmapping recently added kernel linear mapping. Now enable memory hot
remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.

This implementation is overall inspired from kernel page table tear down
procedure on X86 architecture.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig  |   3 +
 arch/arm64/mm/mmu.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1c0cb51..bb4e571 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -268,6 +268,9 @@ config HAVE_GENERIC_GUP
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 37a902c..bd2d003 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -733,6 +733,177 @@ int kern_addr_valid(unsigned long addr)
 
 	return pfn_valid(pte_pfn(pte));
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void free_hotplug_page_range(struct page *page, ssize_t size)
+{
+	WARN_ON(PageReserved(page));
+	free_pages((unsigned long)page_address(page), get_order(size));
+}
+
+static void free_hotplug_pgtable_page(struct page *page)
+{
+	free_hotplug_page_range(page, PAGE_SIZE);
+}
+
+static void free_pte_table(pte_t *ptep, pmd_t *pmdp, unsigned long addr)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		if (!pte_none(ptep[i]))
+			return;
+	}
+
+	page = pmd_page(*pmdp);
+	pmd_clear(pmdp);
+	__flush_tlb_kernel_pgtable(addr);
+	free_hotplug_pgtable_page(page);
+}
+
+#if (CONFIG_PGTABLE_LEVELS > 2)
+static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_none(pmdp[i]))
+			return;
+	}
+
+	page = pud_page(*pudp);
+	pud_clear(pudp);
+	__flush_tlb_kernel_pgtable(addr);
+	free_hotplug_pgtable_page(page);
+}
+#else
+static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr) { }
+#endif
+
+#if (CONFIG_PGTABLE_LEVELS > 3)
+static void free_pud_table(pud_t *pudp, pgd_t *pgdp, unsigned long addr)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (!pud_none(pudp[i]))
+			return;
+	}
+
+	page = pgd_page(*pgdp);
+	pgd_clear(pgdp);
+	__flush_tlb_kernel_pgtable(addr);
+	free_hotplug_pgtable_page(page);
+}
+#else
+static void free_pud_table(pud_t *pudp, pgd_t *pgdp, unsigned long addr) { }
+#endif
+
+static void
+remove_pte_table(pmd_t *pmdp, unsigned long addr,
+			unsigned long end, bool sparse_vmap)
+{
+	struct page *page;
+	pte_t *ptep;
+	unsigned long start = addr;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		ptep = pte_offset_kernel(pmdp, addr);
+		if (!pte_present(*ptep))
+			continue;
+
+		if (sparse_vmap) {
+			page = pte_page(READ_ONCE(*ptep));
+			free_hotplug_page_range(page, PAGE_SIZE);
+		}
+		pte_clear(&init_mm, addr, ptep);
+	}
+	flush_tlb_kernel_range(start, end);
+}
+
+static void
+remove_pmd_table(pud_t *pudp, unsigned long addr,
+			unsigned long end, bool sparse_vmap)
+{
+	unsigned long next;
+	struct page *page;
+	pte_t *ptep_base;
+	pmd_t *pmdp;
+
+	for (; addr < end; addr = next) {
+		next = pmd_addr_end(addr, end);
+		pmdp = pmd_offset(pudp, addr);
+		if (!pmd_present(*pmdp))
+			continue;
+
+		if (pmd_sect(*pmdp)) {
+			if (sparse_vmap) {
+				page = pmd_page(READ_ONCE(*pmdp));
+				free_hotplug_page_range(page, PMD_SIZE);
+			}
+			pmd_clear(pmdp);
+			continue;
+		}
+		ptep_base = pte_offset_kernel(pmdp, 0UL);
+		remove_pte_table(pmdp, addr, next, sparse_vmap);
+		free_pte_table(ptep_base, pmdp, addr);
+	}
+}
+
+static void
+remove_pud_table(pgd_t *pgdp, unsigned long addr,
+			unsigned long end, bool sparse_vmap)
+{
+	unsigned long next;
+	struct page *page;
+	pmd_t *pmdp_base;
+	pud_t *pudp;
+
+	for (; addr < end; addr = next) {
+		next = pud_addr_end(addr, end);
+		pudp = pud_offset(pgdp, addr);
+		if (!pud_present(*pudp))
+			continue;
+
+		if (pud_sect(*pudp)) {
+			if (sparse_vmap) {
+				page = pud_page(READ_ONCE(*pudp));
+				free_hotplug_page_range(page, PUD_SIZE);
+			}
+			pud_clear(pudp);
+			continue;
+		}
+		pmdp_base = pmd_offset(pudp, 0UL);
+		remove_pmd_table(pudp, addr, next, sparse_vmap);
+		free_pmd_table(pmdp_base, pudp, addr);
+	}
+}
+
+static void
+remove_pagetable(unsigned long start, unsigned long end, bool sparse_vmap)
+{
+	unsigned long addr, next;
+	pud_t *pudp_base;
+	pgd_t *pgdp;
+
+	spin_lock(&init_mm.page_table_lock);
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+		pgdp = pgd_offset_k(addr);
+		if (!pgd_present(*pgdp))
+			continue;
+
+		pudp_base = pud_offset(pgdp, 0UL);
+		remove_pud_table(pgdp, addr, next, sparse_vmap);
+		free_pud_table(pudp_base, pgdp, addr);
+	}
+	spin_unlock(&init_mm.page_table_lock);
+}
+#endif
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 #if !ARM64_SWAPPER_USES_SECTION_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
@@ -780,6 +951,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+#ifdef CONFIG_MEMORY_HOTPLUG
+	remove_pagetable(start, end, true);
+#endif
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
@@ -1070,10 +1244,16 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
+{
+	WARN_ON(pgdir != init_mm.pgd);
+	remove_pagetable(start, start + size, false);
+}
+
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		    bool want_memblock)
 {
-	int flags = 0;
+	int ret, flags = 0;
 
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
@@ -1081,7 +1261,27 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
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
+	int ret = 0;
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

