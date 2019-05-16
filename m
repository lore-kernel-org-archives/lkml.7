Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E85C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8020848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEPFez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 01:34:55 -0400
Received: from foss.arm.com ([217.140.101.70]:33608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 01:34:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41FA11715;
        Wed, 15 May 2019 22:34:54 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262853F71E;
        Wed, 15 May 2019 22:34:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 4/4] arm64/mm: Enable memory hot remove
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mhocko@suse.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-5-git-send-email-anshuman.khandual@arm.com>
 <20190515114911.GC23983@lakrids.cambridge.arm.com>
Message-ID: <499ebd4b-c905-dd99-3fc7-66050d89dc35@arm.com>
Date:   Thu, 16 May 2019 11:04:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190515114911.GC23983@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2019 05:19 PM, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Tue, May 14, 2019 at 02:30:07PM +0530, Anshuman Khandual wrote:
>> Memory removal from an arch perspective involves tearing down two different
>> kernel based mappings i.e vmemmap and linear while releasing related page
>> table and any mapped pages allocated for given physical memory range to be
>> removed.
>>
>> Define a common kernel page table tear down helper remove_pagetable() which
>> can be used to unmap given kernel virtual address range. In effect it can
>> tear down both vmemap or kernel linear mappings. This new helper is called
>> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
>>
>> For linear mapping there are no actual allocated pages which are mapped to
>> create the translation. Any pfn on a given entry is derived from physical
>> address (__va(PA) --> PA) whose linear translation is to be created. They
>> need not be freed as they were never allocated in the first place. But for
>> vmemmap which is a real virtual mapping (like vmalloc) physical pages are
>> allocated either from buddy or memblock which get mapped in the kernel page
>> table. These allocated and mapped pages need to be freed during translation
>> tear down. But page table pages need to be freed in both these cases.
> 
> As previously discussed, we should only hot-remove memory which was
> hot-added, so we shouldn't encounter memory allocated from memblock.

Right, not applicable any more. Will drop this word.

> 
>> These mappings need to be differentiated while deciding if a mapped page at
>> any level i.e [pte|pmd|pud]_page() should be freed or not. Callers for the
>> mapping tear down process should pass on 'sparse_vmap' variable identifying
>> kernel vmemmap mappings.
> 
> I think that you can simplify the paragraphs above down to:
> 
>   The arch code for hot-remove must tear down portions of the linear map
>   and vmemmap corresponding to memory being removed. In both cases the
>   page tables mapping these regions must be freed, and when sparse
>   vmemmap is in use the memory backing the vmemmap must also be freed.
> 
>   This patch adds a new remove_pagetable() helper which can be used to
>   tear down either region, and calls it from vmemmap_free() and
>   ___remove_pgd_mapping(). The sparse_vmap argument determines whether
>   the backing memory will be freed.

The current one is bit more descriptive on detail. Anyways will replace with
the above writeup if that is preferred.

> 
> Could you add a paragraph describing when we can encounter partial
> tables (for which we need the p??_none() checks? IIUC that's not just> for cleaning up a failed hot-add, and it would be good to call that out.

Sure, will do.

> 
>> While here update arch_add_mempory() to handle __add_pages() failures by
>> just unmapping recently added kernel linear mapping. Now enable memory hot
>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> Nit: s/arch_add_mempory/arch_add_memory/.

Oops, will do.

> 
> [...]
> 
>> +#if (CONFIG_PGTABLE_LEVELS > 2)
>> +static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
>> +{
>> +	struct page *page;
>> +	int i;
>> +
>> +	for (i = 0; i < PTRS_PER_PMD; i++) {
>> +		if (!pmd_none(pmdp[i]))
>> +			return;
>> +	}
>> +
>> +	page = pud_page(*pudp);
>> +	pud_clear(pudp);
>> +	__flush_tlb_kernel_pgtable(addr);
>> +	free_hotplug_pgtable_page(page);
>> +}
>> +#else
>> +static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr) { }
>> +#endif
> 
> Can we fold the check in and remove the ifdeferry? e.g.
> 
> static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
> {
> 	struct page *page;
> 	int i;
> 
> 	if (CONFIG_PGTABLE_LEVELS <= 2)
> 		return;
> 	
> 	...
> }
> 
> ... that would ensure that we always got build coverage here, and

Thats true. This will get compiled for all combinations.

> minimize duplication. We do similar in map_kernel() and
> early_fixmap_init() today.
> 
> Likewise for the other levels.

Sure, will do.

> 
> For arm64, the general policy is to use READ_ONCE() when reading a page
> table entry (even if not strictly necessary), so please do so
> consistently.

For the likes "page = p???_page(*p???p)" which got missed ? Will fix it.

> 
> [...]
> 
>> +static void
>> +remove_pte_table(pmd_t *pmdp, unsigned long addr,
>> +			unsigned long end, bool sparse_vmap)
>> +{
>> +	struct page *page;
>> +	pte_t *ptep;
>> +	unsigned long start = addr;
>> +
>> +	for (; addr < end; addr += PAGE_SIZE) {
>> +		ptep = pte_offset_kernel(pmdp, addr);
>> +		if (!pte_present(*ptep))
>> +			continue;
>> +
>> +		if (sparse_vmap) {
>> +			page = pte_page(READ_ONCE(*ptep));
>> +			free_hotplug_page_range(page, PAGE_SIZE);
>> +		}
>> +		pte_clear(&init_mm, addr, ptep);
>> +	}
>> +	flush_tlb_kernel_range(start, end);
>> +}
> 
> Please use a temporary pte variable here, e.g.
> 
> static void remove_pte_table(pmd_t *pmdp, unsigned long addr,
> 			     unsigned long end, bool sparse_vmap)
> {
> 	unsigned long start = addr;
> 	struct page *page;
> 	pte_t *ptep, pte;
> 
> 	for (; addr < end; addr += PAGE_SIZE) {
> 		ptep = pte_offset_kernel(pmdp, addr);
> 		pte = READ_ONCE(*ptep);
> 
> 		if (!pte_present(pte))
> 			continue;
> 		
> 		if (sparse_vmap) {
> 			page = pte_page(pte);
> 			free_hotplug_page_range(page, PAGE_SIZE);
> 		}
> 
> 		pte_clear(&init_mm, addr, ptep);
> 	}
> 
> 	flush_tlb_kernel_range(start, end);
> }
> 
> Likewise for the other levels.

Makes sense. Will do.

> 
> [...]
> 
>> +static void
>> +remove_pagetable(unsigned long start, unsigned long end, bool sparse_vmap)
>> +{
>> +	unsigned long addr, next;
>> +	pud_t *pudp_base;
>> +	pgd_t *pgdp;
>> +
>> +	spin_lock(&init_mm.page_table_lock);
> 
> It would be good to explain why we need to take the ptl here.

Will update both commit message and add an in-code comment here.

> 
> IIUC that shouldn't be necessary for the linear map. Am I mistaken?

Its not absolutely necessary for linear map right now because both memory hot
plug & ptdump which modifies or walks the page table ranges respectively take
memory hotplug lock. That apart, no other callers creates or destroys linear
mapping at runtime.

> 
> Is there a specific race when tearing down the vmemmap?

This is trickier than linear map. vmemmap additions would be protected with
memory hotplug lock but this can potential collide with vmalloc/IO regions.
Even if they dont right now that will be because they dont share intermediate
page table levels.

Memory hot-remove is not a very performance critical path. Not even as critical
as memory hot add. Hence its not worth relying on current non-overlapping kernel
virtual address range placement and reason it for not taking this critical lock
which might be problematic if things change later. Lets be on the safer side and
keep this lock.
