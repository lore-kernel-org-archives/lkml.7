Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9137C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720EA21726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfE0IJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:09:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfE0IJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:09:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFDD1374;
        Mon, 27 May 2019 01:09:05 -0700 (PDT)
Received: from [10.162.40.17] (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8023F5AF;
        Mon, 27 May 2019 01:08:58 -0700 (PDT)
Subject: Re: [PATCH V4 4/4] arm64/mm: Enable memory hot remove
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        cai@lca.pw, logang@deltatee.com, james.morse@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com
References: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
 <1558329516-10445-5-git-send-email-anshuman.khandual@arm.com>
 <a660313e-f96c-91ed-1e15-5f3ec6463596@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b226746e-fed1-ea18-f100-0a2c6c561d1f@arm.com>
Date:   Mon, 27 May 2019 13:39:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a660313e-f96c-91ed-1e15-5f3ec6463596@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2019 03:50 PM, David Hildenbrand wrote:
> On 20.05.19 07:18, Anshuman Khandual wrote:
>> The arch code for hot-remove must tear down portions of the linear map and
>> vmemmap corresponding to memory being removed. In both cases the page
>> tables mapping these regions must be freed, and when sparse vmemmap is in
>> use the memory backing the vmemmap must also be freed.
>>
>> This patch adds a new remove_pagetable() helper which can be used to tear
>> down either region, and calls it from vmemmap_free() and
>> ___remove_pgd_mapping(). The sparse_vmap argument determines whether the
>> backing memory will be freed.
>>
>> While freeing intermediate level page table pages bail out if any of it's
>> entries are still valid. This can happen for partially filled kernel page
>> table either from a previously attempted failed memory hot add or while
>> removing an address range which does not span the entire page table page
>> range.
>>
>> The vmemmap region may share levels of table with the vmalloc region. Take
>> the kernel ptl so that we can safely free potentially-shared tables.
>>
>> While here update arch_add_memory() to handle __add_pages() failures by
>> just unmapping recently added kernel linear mapping. Now enable memory hot
>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>>
>> This implementation is overall inspired from kernel page table tear down
>> procedure on X86 architecture.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/Kconfig  |   3 +
>>  arch/arm64/mm/mmu.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 213 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4780eb7..ce24427 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -267,6 +267,9 @@ config HAVE_GENERIC_GUP
>>  config ARCH_ENABLE_MEMORY_HOTPLUG
>>  	def_bool y
>>  
>> +config ARCH_ENABLE_MEMORY_HOTREMOVE
>> +	def_bool y
>> +
>>  config SMP
>>  	def_bool y
>>  
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index a1bfc44..0cf0d41 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -733,6 +733,187 @@ int kern_addr_valid(unsigned long addr)
>>  
>>  	return pfn_valid(pte_pfn(pte));
>>  }
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static void free_hotplug_page_range(struct page *page, ssize_t size)
>> +{
>> +	WARN_ON(PageReserved(page));
>> +	free_pages((unsigned long)page_address(page), get_order(size));
>> +}
>> +
>> +static void free_hotplug_pgtable_page(struct page *page)
>> +{
>> +	free_hotplug_page_range(page, PAGE_SIZE);
>> +}
>> +
>> +static void free_pte_table(pte_t *ptep, pmd_t *pmdp, unsigned long addr)
>> +{
>> +	struct page *page;
>> +	int i;
>> +
>> +	for (i = 0; i < PTRS_PER_PTE; i++) {
>> +		if (!pte_none(ptep[i]))
>> +			return;
>> +	}
>> +
>> +	page = pmd_page(READ_ONCE(*pmdp));
>> +	pmd_clear(pmdp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
>> +{
>> +	struct page *page;
>> +	int i;
>> +
>> +	if (CONFIG_PGTABLE_LEVELS <= 2)
>> +		return;
>> +
>> +	for (i = 0; i < PTRS_PER_PMD; i++) {
>> +		if (!pmd_none(pmdp[i]))
>> +			return;
>> +	}
>> +
>> +	page = pud_page(READ_ONCE(*pudp));
>> +	pud_clear(pudp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void free_pud_table(pud_t *pudp, pgd_t *pgdp, unsigned long addr)
>> +{
>> +	struct page *page;
>> +	int i;
>> +
>> +	if (CONFIG_PGTABLE_LEVELS <= 3)
>> +		return;
>> +
>> +	for (i = 0; i < PTRS_PER_PUD; i++) {
>> +		if (!pud_none(pudp[i]))
>> +			return;
>> +	}
>> +
>> +	page = pgd_page(READ_ONCE(*pgdp));
>> +	pgd_clear(pgdp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void
>> +remove_pte_table(pmd_t *pmdp, unsigned long addr,
>> +			unsigned long end, bool sparse_vmap)
>> +{
>> +	struct page *page;
>> +	pte_t *ptep, pte;
>> +	unsigned long start = addr;
>> +
>> +	for (; addr < end; addr += PAGE_SIZE) {
>> +		ptep = pte_offset_kernel(pmdp, addr);
>> +		pte = READ_ONCE(*ptep);
>> +
>> +		if (pte_none(pte))
>> +			continue;
>> +
>> +		WARN_ON(!pte_present(pte));
>> +		if (sparse_vmap) {
>> +			page = pte_page(pte);
>> +			free_hotplug_page_range(page, PAGE_SIZE);
>> +		}
>> +		pte_clear(&init_mm, addr, ptep);
>> +	}
>> +	flush_tlb_kernel_range(start, end);
>> +}
>> +
>> +static void
>> +remove_pmd_table(pud_t *pudp, unsigned long addr,
>> +			unsigned long end, bool sparse_vmap)
>> +{
>> +	unsigned long next;
>> +	struct page *page;
>> +	pte_t *ptep_base;
>> +	pmd_t *pmdp, pmd;
>> +
>> +	for (; addr < end; addr = next) {
>> +		next = pmd_addr_end(addr, end);
>> +		pmdp = pmd_offset(pudp, addr);
>> +		pmd = READ_ONCE(*pmdp);
>> +
>> +		if (pmd_none(pmd))
>> +			continue;
>> +
>> +		WARN_ON(!pmd_present(pmd));
>> +		if (pmd_sect(pmd)) {
>> +			if (sparse_vmap) {
>> +				page = pmd_page(pmd);
>> +				free_hotplug_page_range(page, PMD_SIZE);
>> +			}
>> +			pmd_clear(pmdp);
>> +			continue;
>> +		}
>> +		ptep_base = pte_offset_kernel(pmdp, 0UL);
>> +		remove_pte_table(pmdp, addr, next, sparse_vmap);
>> +		free_pte_table(ptep_base, pmdp, addr);
>> +	}
>> +}
>> +
>> +static void
>> +remove_pud_table(pgd_t *pgdp, unsigned long addr,
>> +			unsigned long end, bool sparse_vmap)
>> +{
>> +	unsigned long next;
>> +	struct page *page;
>> +	pmd_t *pmdp_base;
>> +	pud_t *pudp, pud;
>> +
>> +	for (; addr < end; addr = next) {
>> +		next = pud_addr_end(addr, end);
>> +		pudp = pud_offset(pgdp, addr);
>> +		pud = READ_ONCE(*pudp);
>> +
>> +		if (pud_none(pud))
>> +			continue;
>> +
>> +		WARN_ON(!pud_present(pud));
>> +		if (pud_sect(pud)) {
>> +			if (sparse_vmap) {
>> +				page = pud_page(pud);
>> +				free_hotplug_page_range(page, PUD_SIZE);
>> +			}
>> +			pud_clear(pudp);
>> +			continue;
>> +		}
>> +		pmdp_base = pmd_offset(pudp, 0UL);
>> +		remove_pmd_table(pudp, addr, next, sparse_vmap);
>> +		free_pmd_table(pmdp_base, pudp, addr);
>> +	}
>> +}
>> +
>> +static void
>> +remove_pagetable(unsigned long start, unsigned long end, bool sparse_vmap)
>> +{
>> +	unsigned long addr, next;
>> +	pud_t *pudp_base;
>> +	pgd_t *pgdp, pgd;
>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +	for (addr = start; addr < end; addr = next) {
>> +		next = pgd_addr_end(addr, end);
>> +		pgdp = pgd_offset_k(addr);
>> +		pgd = READ_ONCE(*pgdp);
>> +
>> +		if (pgd_none(pgd))
>> +			continue;
>> +
>> +		WARN_ON(!pgd_present(pgd));
>> +		pudp_base = pud_offset(pgdp, 0UL);
>> +		remove_pud_table(pgdp, addr, next, sparse_vmap);
>> +		free_pud_table(pudp_base, pgdp, addr);
>> +	}
>> +	spin_unlock(&init_mm.page_table_lock);
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>  #if !ARM64_SWAPPER_USES_SECTION_MAPS
>>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>> @@ -780,6 +961,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  void vmemmap_free(unsigned long start, unsigned long end,
>>  		struct vmem_altmap *altmap)
>>  {
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +	remove_pagetable(start, end, true);
>> +#endif
>>  }
>>  #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
>>  
>> @@ -1070,10 +1254,16 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
>>  }
>>  
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> +static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>> +{
>> +	WARN_ON(pgdir != init_mm.pgd);
>> +	remove_pagetable(start, start + size, false);
>> +}
>> +
>>  int arch_add_memory(int nid, u64 start, u64 size,
>>  			struct mhp_restrictions *restrictions)
>>  {
>> -	int flags = 0;
>> +	int ret, flags = 0;
>>  
>>  	if (rodata_full || debug_pagealloc_enabled())
>>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> @@ -1081,7 +1271,25 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>  			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
>>  
>> -	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>> +	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>>  			   restrictions);
>> +	if (ret)
>> +		__remove_pgd_mapping(swapper_pg_dir,
>> +					__phys_to_virt(start), size);
> 
> Nit: Indentation of the parameters looks really weird.
> 
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +void arch_remove_memory(int nid, u64 start, u64 size,
>> +				struct vmem_altmap *altmap)
>> +{
>> +	unsigned long start_pfn = start >> PAGE_SHIFT;
>> +	unsigned long nr_pages = size >> PAGE_SHIFT;
>> +	struct zone *zone = page_zone(pfn_to_page(start_pfn));
>> +
>> +	__remove_pages(zone, start_pfn, nr_pages, altmap);
>> +	__remove_pgd_mapping(swapper_pg_dir,
>> +					__phys_to_virt(start), size);
> 
> Dito, indentation of the parameters.
> 
> For these two changes (arch_*_memory)
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks David. The following change on this patch should fix the indentation
problem. If there are no other comments I will incorporate this and re-spin
the series once more.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0cf0d41..a87ba18 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1273,9 +1273,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   restrictions);
-	if (ret)
-		__remove_pgd_mapping(swapper_pg_dir,
-					__phys_to_virt(start), size);
+	if (!ret)
+		return ret;
+
+	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 	return ret;
 }
 
@@ -1288,8 +1289,7 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 	struct zone *zone = page_zone(pfn_to_page(start_pfn));
 
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
-	__remove_pgd_mapping(swapper_pg_dir,
-					__phys_to_virt(start), size);
+	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
 #endif
 #endif
