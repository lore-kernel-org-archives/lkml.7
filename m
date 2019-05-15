Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0970C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDC12053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfEOLtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:49:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbfEOLtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:49:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F25980D;
        Wed, 15 May 2019 04:49:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A7DC3F71E;
        Wed, 15 May 2019 04:49:14 -0700 (PDT)
Date:   Wed, 15 May 2019 12:49:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mhocko@suse.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V3 4/4] arm64/mm: Enable memory hot remove
Message-ID: <20190515114911.GC23983@lakrids.cambridge.arm.com>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557824407-19092-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, May 14, 2019 at 02:30:07PM +0530, Anshuman Khandual wrote:
> Memory removal from an arch perspective involves tearing down two different
> kernel based mappings i.e vmemmap and linear while releasing related page
> table and any mapped pages allocated for given physical memory range to be
> removed.
> 
> Define a common kernel page table tear down helper remove_pagetable() which
> can be used to unmap given kernel virtual address range. In effect it can
> tear down both vmemap or kernel linear mappings. This new helper is called
> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
> 
> For linear mapping there are no actual allocated pages which are mapped to
> create the translation. Any pfn on a given entry is derived from physical
> address (__va(PA) --> PA) whose linear translation is to be created. They
> need not be freed as they were never allocated in the first place. But for
> vmemmap which is a real virtual mapping (like vmalloc) physical pages are
> allocated either from buddy or memblock which get mapped in the kernel page
> table. These allocated and mapped pages need to be freed during translation
> tear down. But page table pages need to be freed in both these cases.

As previously discussed, we should only hot-remove memory which was
hot-added, so we shouldn't encounter memory allocated from memblock.

> These mappings need to be differentiated while deciding if a mapped page at
> any level i.e [pte|pmd|pud]_page() should be freed or not. Callers for the
> mapping tear down process should pass on 'sparse_vmap' variable identifying
> kernel vmemmap mappings.

I think that you can simplify the paragraphs above down to:

  The arch code for hot-remove must tear down portions of the linear map
  and vmemmap corresponding to memory being removed. In both cases the
  page tables mapping these regions must be freed, and when sparse
  vmemmap is in use the memory backing the vmemmap must also be freed.

  This patch adds a new remove_pagetable() helper which can be used to
  tear down either region, and calls it from vmemmap_free() and
  ___remove_pgd_mapping(). The sparse_vmap argument determines whether
  the backing memory will be freed.

Could you add a paragraph describing when we can encounter partial
tables (for which we need the p??_none() checks? IIUC that's not just
for cleaning up a failed hot-add, and it would be good to call that out.

> While here update arch_add_mempory() to handle __add_pages() failures by
> just unmapping recently added kernel linear mapping. Now enable memory hot
> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.

Nit: s/arch_add_mempory/arch_add_memory/.

[...]

> +#if (CONFIG_PGTABLE_LEVELS > 2)
> +static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
> +{
> +	struct page *page;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		if (!pmd_none(pmdp[i]))
> +			return;
> +	}
> +
> +	page = pud_page(*pudp);
> +	pud_clear(pudp);
> +	__flush_tlb_kernel_pgtable(addr);
> +	free_hotplug_pgtable_page(page);
> +}
> +#else
> +static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr) { }
> +#endif

Can we fold the check in and remove the ifdeferry? e.g.

static void free_pmd_table(pmd_t *pmdp, pud_t *pudp, unsigned long addr)
{
	struct page *page;
	int i;

	if (CONFIG_PGTABLE_LEVELS <= 2)
		return;
	
	...
}

... that would ensure that we always got build coverage here, and
minimize duplication. We do similar in map_kernel() and
early_fixmap_init() today.

Likewise for the other levels.

For arm64, the general policy is to use READ_ONCE() when reading a page
table entry (even if not strictly necessary), so please do so
consistently.

[...]

> +static void
> +remove_pte_table(pmd_t *pmdp, unsigned long addr,
> +			unsigned long end, bool sparse_vmap)
> +{
> +	struct page *page;
> +	pte_t *ptep;
> +	unsigned long start = addr;
> +
> +	for (; addr < end; addr += PAGE_SIZE) {
> +		ptep = pte_offset_kernel(pmdp, addr);
> +		if (!pte_present(*ptep))
> +			continue;
> +
> +		if (sparse_vmap) {
> +			page = pte_page(READ_ONCE(*ptep));
> +			free_hotplug_page_range(page, PAGE_SIZE);
> +		}
> +		pte_clear(&init_mm, addr, ptep);
> +	}
> +	flush_tlb_kernel_range(start, end);
> +}

Please use a temporary pte variable here, e.g.

static void remove_pte_table(pmd_t *pmdp, unsigned long addr,
			     unsigned long end, bool sparse_vmap)
{
	unsigned long start = addr;
	struct page *page;
	pte_t *ptep, pte;

	for (; addr < end; addr += PAGE_SIZE) {
		ptep = pte_offset_kernel(pmdp, addr);
		pte = READ_ONCE(*ptep);

		if (!pte_present(pte))
			continue;
		
		if (sparse_vmap) {
			page = pte_page(pte);
			free_hotplug_page_range(page, PAGE_SIZE);
		}

		pte_clear(&init_mm, addr, ptep);
	}

	flush_tlb_kernel_range(start, end);
}

Likewise for the other levels.

[...]

> +static void
> +remove_pagetable(unsigned long start, unsigned long end, bool sparse_vmap)
> +{
> +	unsigned long addr, next;
> +	pud_t *pudp_base;
> +	pgd_t *pgdp;
> +
> +	spin_lock(&init_mm.page_table_lock);

It would be good to explain why we need to take the ptl here.

IIUC that shouldn't be necessary for the linear map. Am I mistaken?

Is there a specific race when tearing down the vmemmap?

Thanks,
Mark.
