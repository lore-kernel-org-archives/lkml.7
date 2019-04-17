Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E176217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfDQOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:22:07 -0400
Received: from foss.arm.com ([217.140.101.70]:45596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbfDQOWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:22:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3779C374;
        Wed, 17 Apr 2019 07:22:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2673F557;
        Wed, 17 Apr 2019 07:22:00 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:21:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V2 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20190417142154.GA393@lakrids.cambridge.arm.com>
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
 <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
 <20190415134841.GC13990@lakrids.cambridge.arm.com>
 <2faba38b-ab79-2dda-1b3c-ada5054d91fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2faba38b-ab79-2dda-1b3c-ada5054d91fa@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:28:18PM +0530, Anshuman Khandual wrote:
> On 04/15/2019 07:18 PM, Mark Rutland wrote:
> > On Sun, Apr 14, 2019 at 11:29:13AM +0530, Anshuman Khandual wrote:
> >> Memory removal from an arch perspective involves tearing down two different
> >> kernel based mappings i.e vmemmap and linear while releasing related page
> >> table pages allocated for the physical memory range to be removed.
> >>
> >> Define a common kernel page table tear down helper remove_pagetable() which
> >> can be used to unmap given kernel virtual address range. In effect it can
> >> tear down both vmemap or kernel linear mappings. This new helper is called
> >> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
> >> The argument 'direct' here identifies kernel linear mappings.
> > 
> > Can you please explain why we need to treat these differently? I thought
> > the next paragraph was going to do that, but as per my comment there it
> > doesn't seem to be relevant. :/
> 
> For linear mapping there is no actual allocated page which is mapped. Its the
> pfn derived from physical address (from __va(PA)-->PA translation) which is
> there in the page table entry and need not be freed any where during tear down.
> 
> But in case of vmemmap (struct page mapping for a given range) which is a real
> virtual mapping (like vmalloc) real pages are allocated (buddy or memblock) and
> are mapped in it's page table entries to effect the translation. These pages
> need to be freed while tearing down the translation. But for both mappings
> (linear and vmemmap) their page table pages need to be freed.
> 
> This differentiation is needed while deciding if [pte|pmd|pud]_page() at any
> given level needs to be freed or not. Will update the commit message with this
> explanation if required.

Ok. I think you just need to say:

  When removing a vmemmap pagetable range, we must also free the pages
  used to back this range of the vmemmap.

> >> While here update arch_add_mempory() to handle __add_pages() failures by
> >> just unmapping recently added kernel linear mapping. 
> > 
> > Is this a latent bug?
> 
> Did not get it. __add_pages() could fail because of __add_section() in which
> case we should remove the linear mapping added previously in the first step.
> Is there any concern here ?

That is the question.

If that were to fail _before_ this series were applied, does that permit
anything bad to happen? e.g. is it permitted that when arch_add_memory()
fails, the relevant memory can be physically removed?

If so, that could result in a number of problems, and would be a latent
bug...

[...]

> >> +#ifdef CONFIG_MEMORY_HOTPLUG
> >> +static void free_pagetable(struct page *page, int order)
> > 
> > On arm64, all of the stage-1 page tables other than the PGD are always
> > PAGE_SIZE. We shouldn't need to pass an order around in order to free
> > page tables.
> > 
> > It looks like this function is misnamed, and is used to free vmemmap
> > backing pages in addition to page tables used to map them. It would be
> > nicer to come up with a better naming scheme.
> 
> free_pagetable() is being used both for freeing page table pages as well
> mapped entries at various level (for vmemmap). As you rightly mentioned
> page table pages are invariably PAGE_SIZE (other than pgd) but theses
> mapped pages size can vary at various level. free_pagetable() is a very
> generic helper which can accommodate pages allocated from buddy as well
> as memblock. But I agree that the naming is misleading.
> 
> Will something like this will be better ?
> 
> void free_pagetable_mapped_page(struct page *page, int order)
> {
> 	.......................
> 	.......................
> }
> 
> void free_pagetable_page(struct page *page)
> {
> 	free_pagetable_mapped_page(page, 0);
> }
> 
> - Call free_pgtable_page() while freeing pagetable pages
> - Call free_pgtable_mapped_page() while freeing mapped pages

I think the "pgtable" naming isn't necessary. These functions are passed
the relevant page, and free that page (or a range starting at that
page).

I think it would be better to have something like:

static void free_hotplug_page_range(struct page *page, unsigned long size)
{
	int order = get_order(size);
	int nr_pages = 1 << order;

	...
}

static void free_hotplug_page(struct page *page)
{
	free_hotplug_page_range(page, PAGE_SIZE);
}

... which avoids having to place get_order() in all the callers, and
makes things a bit easier to read.

> > 
> >> +{
> >> +	unsigned long magic;
> >> +	unsigned int nr_pages = 1 << order;
> >> +
> >> +	if (PageReserved(page)) {
> >> +		__ClearPageReserved(page);
> >> +
> >> +		magic = (unsigned long)page->freelist;
> >> +		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
> > 
> > Not a new problem, but it's unfortunate that the core code reuses the
> > page::freelist field for this, given it also uses page::private for the
> > section number. Using fields from different parts of the union doesn't
> > seem robust.> 
> > It would seem nicer to have a private2 field in the struct for anonymous
> > pages.
> 
> Okay. But I guess its not something for us to investigate in this context.
> 
> > 
> >> +			while (nr_pages--)
> >> +				put_page_bootmem(page++);
> >> +		} else {
> >> +			while (nr_pages--)
> >> +				free_reserved_page(page++);
> >> +		}
> >> +	} else {
> >> +		free_pages((unsigned long)page_address(page), order);
> >> +	}
> >> +}

Looking at this again, I'm surprised that we'd ever free bootmem pages.
I'd expect that we'd only remove memory that was added as part of a
hotplug, and that shouldn't have come from bootmem.

Will we ever really try to free bootmem pages like this?

[...]

> > I take it that some higher-level serialization prevents concurrent
> > modification to this table. Where does that happen?
> 
> mem_hotplug_begin()
> mem_hotplug_end()
> 
> which operates on DEFINE_STATIC_PERCPU_RWSEM(mem_hotplug_lock)
> 
> - arch_remove_memory() called from (__remove_memory || devm_memremap_pages_release)
> - vmemmap_free() called from __remove_pages called from (arch_remove_memory || devm_memremap_pages_release)
> 
> Both __remove_memory() and devm_memremap_pages_release() are protected with
> pair of these.
> 
> mem_hotplug_begin()
> mem_hotplug_end()
> 
> vmemmap tear down happens before linear mapping and in sequence.
> 
> > 
> >> +
> >> +	free_pagetable(pmd_page(*pmd), 0);
> > 
> > Here we free the pte level of table...
> > 
> >> +	spin_lock(&init_mm.page_table_lock);
> >> +	pmd_clear(pmd);
> > 
> > ... but only here do we disconnect it from the PMD level of table, and
> > we don't do any TLB maintenance just yet. The page could be poisoned
> > and/or reallocated before we invalidate the TLB, which is not safe. In
> > all cases, we must follow the sequence:
> > 
> > 1) clear the pointer to a table
> > 2) invalidate any corresponding TLB entries
> > 3) free the table page
> > 
> > ... or we risk a number of issues resulting from erroneous programming
> > of the TLBs. See pmd_free_pte_page() for an example of how to do this
> > correctly.
> 
> Okay will send 'addr' into these functions and do somehting like this
> at all levels as in case for pmd_free_pte_page().
> 
>         page = pud_page(*pudp);
>         pud_clear(pudp);
>         __flush_tlb_kernel_pgtable(addr);
>         free_pgtable_page(page);

That looks correct to me!

> > I'd have thought similar applied to x86, so that implementation looks
> > suspicious to me too...
> > 
> >> +	spin_unlock(&init_mm.page_table_lock);
> > 
> > What precisely is the page_table_lock intended to protect?
> 
> Concurrent modification to kernel page table (init_mm) while clearing entries.

Concurrent modification by what code?

If something else can *modify* the portion of the table that we're
manipulating, then I don't see how we can safely walk the table up to
this point without holding the lock, nor how we can safely add memory.

Even if this is to protect something else which *reads* the tables,
other code in arm64 which modifies the kernel page tables doesn't take
the lock.

Usually, if you can do a lockless walk you have to verify that things
didn't change once you've taken the lock, but we don't follow that
pattern here.

As things stand it's not clear to me whether this is necessary or
sufficient.

> > It seems odd to me that we're happy to walk the tables without the lock,
> > but only grab the lock when performing a modification. That implies we
> > either have some higher-level mutual exclusion, or we're not holding the
> > lock in all cases we need to be.
> 
> On arm64
> 
> - linear mapping is half kernel virtual range (unlikely to share PGD with any other)
> - vmemmap and vmalloc might or might not be aligned properly to avoid PGD/PUD/PMD overlap
> - This kernel virtual space layout is not fixed and can change in future
> 
> Hence just to be on safer side lets take init_mm.page_table_lock for the entire tear
> down process in remove_pagetable(). put_page_bootmem/free_reserved_page/free_pages should
> not block for longer period unlike allocation paths. Hence it should be safe with overall
> spin lock on init_mm.page_table_lock unless if there are some other concerns.

Given the other issues with the x86 hot-remove code, it's not clear to
me whether that locking is correct or necessary. I think that before we
make any claim as to whether that's safe we should figure out how the
lock is actually used today.

I do not think we should mindlessly copy that.

Thanks,
Mark.
