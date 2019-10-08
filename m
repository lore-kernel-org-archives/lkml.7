Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219B220659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfJHEgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:36:11 -0400
Received: from foss.arm.com ([217.140.110.172]:54278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfJHEgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:36:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34FF142F;
        Mon,  7 Oct 2019 21:36:09 -0700 (PDT)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A7B3F703;
        Mon,  7 Oct 2019 21:36:02 -0700 (PDT)
Subject: Re: [PATCH V8 2/2] arm64/mm: Enable memory hot remove
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, mhocko@suse.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
References: <1569217425-23777-1-git-send-email-anshuman.khandual@arm.com>
 <1569217425-23777-3-git-send-email-anshuman.khandual@arm.com>
 <20191007141738.GA93112@E120351.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6c277085-a430-eab4-3a4e-99fcfa170c10@arm.com>
Date:   Tue, 8 Oct 2019 10:06:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191007141738.GA93112@E120351.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2019 07:47 PM, Catalin Marinas wrote:
> On Mon, Sep 23, 2019 at 11:13:45AM +0530, Anshuman Khandual wrote:
>> The arch code for hot-remove must tear down portions of the linear map and
>> vmemmap corresponding to memory being removed. In both cases the page
>> tables mapping these regions must be freed, and when sparse vmemmap is in
>> use the memory backing the vmemmap must also be freed.
>>
>> This patch adds unmap_hotplug_range() and free_empty_tables() helpers which
>> can be used to tear down either region and calls it from vmemmap_free() and
>> ___remove_pgd_mapping(). The sparse_vmap argument determines whether the
>> backing memory will be freed.
> 
> Can you change the 'sparse_vmap' name to something more meaningful which
> would suggest freeing of the backing memory?

free_mapped_mem or free_backed_mem ? Even shorter forms like free_mapped or
free_backed might do as well. Do you have a particular preference here ? But
yes, sparse_vmap has been very much specific to vmemmap for these functions
which are now very generic in nature.

> 
>> It makes two distinct passes over the kernel page table. In the first pass
>> with unmap_hotplug_range() it unmaps, invalidates applicable TLB cache and
>> frees backing memory if required (vmemmap) for each mapped leaf entry. In
>> the second pass with free_empty_tables() it looks for empty page table
>> sections whose page table page can be unmapped, TLB invalidated and freed.
>>
>> While freeing intermediate level page table pages bail out if any of its
>> entries are still valid. This can happen for partially filled kernel page
>> table either from a previously attempted failed memory hot add or while
>> removing an address range which does not span the entire page table page
>> range.
>>
>> The vmemmap region may share levels of table with the vmalloc region.
>> There can be conflicts between hot remove freeing page table pages with
>> a concurrent vmalloc() walking the kernel page table. This conflict can
>> not just be solved by taking the init_mm ptl because of existing locking
>> scheme in vmalloc(). So free_empty_tables() implements a floor and ceiling
>> method which is borrowed from user page table tear with free_pgd_range()
>> which skips freeing page table pages if intermediate address range is not
>> aligned or maximum floor-ceiling might not own the entire page table page.
>>
>> While here update arch_add_memory() to handle __add_pages() failures by
>> just unmapping recently added kernel linear mapping. Now enable memory hot
>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>>
>> This implementation is overall inspired from kernel page table tear down
>> procedure on X86 architecture and user page table tear down method.
>>
>> Acked-by: Steve Capper <steve.capper@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Given the amount of changes since version 7, do the acks still stand?

I had taken the liberty to carry them till V7 where the implementation has
been sort of structurally similar but as you mention, there have been some
basic changes in the approach since V7. Will drop these tags in next version
and request their fresh ACKs once again.

> 
> [...]
>> +static void free_pte_table(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> +			   unsigned long floor, unsigned long ceiling)
>> +{
>> +	struct page *page;
>> +	pte_t *ptep;
>> +	int i;
>> +
>> +	if (!pgtable_range_aligned(addr, end, floor, ceiling, PMD_MASK))
>> +		return;
>> +
>> +	ptep = pte_offset_kernel(pmdp, 0UL);
>> +	for (i = 0; i < PTRS_PER_PTE; i++) {
>> +		if (!pte_none(READ_ONCE(ptep[i])))
>> +			return;
>> +	}
>> +
>> +	page = pmd_page(READ_ONCE(*pmdp));
> 
> Arguably, that's not the pmd page we are freeing here. Even if you get
> the same result, pmd_page() is normally used for huge pages pointed at
> by the pmd entry. Since you have the ptep already, why not use
> virt_to_page(ptep)?

Makes sense, will do.

> 
>> +	pmd_clear(pmdp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void free_pmd_table(pud_t *pudp, unsigned long addr, unsigned long end,
>> +			   unsigned long floor, unsigned long ceiling)
>> +{
>> +	struct page *page;
>> +	pmd_t *pmdp;
>> +	int i;
>> +
>> +	if (CONFIG_PGTABLE_LEVELS <= 2)
>> +		return;
>> +
>> +	if (!pgtable_range_aligned(addr, end, floor, ceiling, PUD_MASK))
>> +		return;
>> +
>> +	pmdp = pmd_offset(pudp, 0UL);
>> +	for (i = 0; i < PTRS_PER_PMD; i++) {
>> +		if (!pmd_none(READ_ONCE(pmdp[i])))
>> +			return;
>> +	}
>> +
>> +	page = pud_page(READ_ONCE(*pudp));
> 
> Same here, virt_to_page(pmdp).

Will do.

> 
>> +	pud_clear(pudp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void free_pud_table(pgd_t *pgdp, unsigned long addr, unsigned  long end,
>> +			   unsigned long floor, unsigned long ceiling)
>> +{
>> +	struct page *page;
>> +	pud_t *pudp;
>> +	int i;
>> +
>> +	if (CONFIG_PGTABLE_LEVELS <= 3)
>> +		return;
>> +
>> +	if (!pgtable_range_aligned(addr, end, floor, ceiling, PGDIR_MASK))
>> +		return;
>> +
>> +	pudp = pud_offset(pgdp, 0UL);
>> +	for (i = 0; i < PTRS_PER_PUD; i++) {
>> +		if (!pud_none(READ_ONCE(pudp[i])))
>> +			return;
>> +	}
>> +
>> +	page = pgd_page(READ_ONCE(*pgdp));
> 
> As above.

Will do.

> 
>> +	pgd_clear(pgdp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +
>> +static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>> +				    unsigned long end, bool sparse_vmap)
>> +{
>> +	struct page *page;
>> +	pte_t *ptep, pte;
>> +
>> +	do {
>> +		ptep = pte_offset_kernel(pmdp, addr);
>> +		pte = READ_ONCE(*ptep);
>> +		if (pte_none(pte))
>> +			continue;
>> +
>> +		WARN_ON(!pte_present(pte));
>> +		page = sparse_vmap ? pte_page(pte) : NULL;
>> +		pte_clear(&init_mm, addr, ptep);
>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +		if (sparse_vmap)
>> +			free_hotplug_page_range(page, PAGE_SIZE);
> 
> You could only set 'page' if sparse_vmap (or even drop 'page' entirely).

I am afraid 'page' is being used to hold pte_page(pte) extraction which
needs to be freed (sparse_vmap) as we are going to clear the ptep entry
in the next statement and lose access to it for good. We will need some
where to hold onto pte_page(pte) across pte_clear() as we cannot free it
before clearing it's entry and flushing the TLB. Hence wondering how the
'page' can be completely dropped.

> The compiler is probably smart enough to optimise it but using a
> pointless ternary operator just makes the code harder to follow.

Not sure I got this but are you suggesting for an 'if' statement here

if (sparse_vmap)
	page = pte_page(pte);

instead of the current assignment ?

page = sparse_vmap ? pte_page(pte) : NULL;

> 
>> +	} while (addr += PAGE_SIZE, addr < end);
>> +}
> [...]
>> +static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
>> +				 unsigned long end)
>> +{
>> +	pte_t *ptep, pte;
>> +
>> +	do {
>> +		ptep = pte_offset_kernel(pmdp, addr);
>> +		pte = READ_ONCE(*ptep);
>> +		WARN_ON(!pte_none(pte));
>> +	} while (addr += PAGE_SIZE, addr < end);
>> +}
>> +
>> +static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
>> +				 unsigned long end, unsigned long floor,
>> +				 unsigned long ceiling)
>> +{
>> +	unsigned long next;
>> +	pmd_t *pmdp, pmd;
>> +
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		pmdp = pmd_offset(pudp, addr);
>> +		pmd = READ_ONCE(*pmdp);
>> +		if (pmd_none(pmd))
>> +			continue;
>> +
>> +		WARN_ON(!pmd_present(pmd) || !pmd_table(pmd) || pmd_sect(pmd));
>> +		free_empty_pte_table(pmdp, addr, next);
>> +		free_pte_table(pmdp, addr, next, floor, ceiling);
> 
> Do we need two closely named functions here? Can you not collapse
> free_empty_pud_table() and free_pte_table() into a single one? The same
> comment for the pmd/pud variants. I just find this confusing.

The two functions could be collapsed into a single one. But just wanted to
keep free_pxx_table() part which checks floor/ceiling alignment, non-zero
entries clear off the actual page table walking.

> 
>> +	} while (addr = next, addr < end);
> 
> You could make these function in two steps: first, as above, invoke the
> next level recursively; second, after the do..while loop, check whether
> it's empty and free the pmd page as in free_pmd_table().

free_pte_table() freeing attempt actually belongs to free_empty_pte_table().
Yes, free_pte_table() part can be moved inside free_empty_pte_table() after
it's do..while(). Also s/free_pte_table/free_pte_page to make it sound more
distinct with respect to free_empty_pte_table(). Just that the pgtable page
freeing part is still wrapped in a helper function to hide it's details.

But if you prefer not to have these helpers free_pxx_page() and directly
encode the second step in free_empty_pxx_table(), then will that instead.

> 
>> +}
> [...]
> 
