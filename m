Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DC121916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCUVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:07:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCUVHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BCCC3086211;
        Thu, 21 Mar 2019 21:07:51 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD3AC60857;
        Thu, 21 Mar 2019 21:07:49 +0000 (UTC)
Date:   Thu, 21 Mar 2019 17:07:48 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "riel@surriel.com" <riel@surriel.com>
Subject: Re: [RFC PATCH RESEND 3/3] mm: Add write-protect and clean utilities
 for address space ranges
Message-ID: <20190321210747.GC15074@redhat.com>
References: <20190321132140.114878-1-thellstrom@vmware.com>
 <20190321132140.114878-4-thellstrom@vmware.com>
 <20190321141239.GD2904@redhat.com>
 <c1be4ce328f6170a74886518e175403afbaed119.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1be4ce328f6170a74886518e175403afbaed119.camel@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Mar 2019 21:07:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:29:31PM +0000, Thomas Hellstrom wrote:
> On Thu, 2019-03-21 at 10:12 -0400, Jerome Glisse wrote:
> > On Thu, Mar 21, 2019 at 01:22:41PM +0000, Thomas Hellstrom wrote:
> > > Add two utilities to a) write-protect and b) clean all ptes
> > > pointing into
> > > a range of an address space
> > > The utilities are intended to aid in tracking dirty pages (either
> > > driver-allocated system memory or pci device memory).
> > > The write-protect utility should be used in conjunction with
> > > page_mkwrite() and pfn_mkwrite() to trigger write page-faults on
> > > page
> > > accesses. Typically one would want to use this on sparse accesses
> > > into
> > > large memory regions. The clean utility should be used to utilize
> > > hardware dirtying functionality and avoid the overhead of page-
> > > faults,
> > > typically on large accesses into small memory regions.
> > 
> > Again this does not use mmu notifier and there is no scary comment to
> > explain the very limited use case it should be use for ie mmap of a
> > device file and only by the device driver.
> 
> Scary comment and asserts will be added.
> 
> > 
> > Using it ouside of this would break softdirty or trigger false COW or
> > other scary thing.
> 
> This is something that should clearly be avoided if at all possible.
> False COWs could be avoided by asserting that VMAs are shared. I need
> to look deaper into softdirty, but note that the __mkwrite / dirty /
> clean pattern is already used in a very similar way in
> drivers/video/fb_defio.c although it operates only on real pages one at
> a time.

It should just be allow only for mapping of device file for which none
of the above apply (softdirty, COW, ...).

> 
> > 
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Huang Ying <ying.huang@intel.com>
> > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> > > ---
> > >  include/linux/mm.h  |   9 +-
> > >  mm/Makefile         |   2 +-
> > >  mm/apply_as_range.c | 257
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 266 insertions(+), 2 deletions(-)
> > >  create mode 100644 mm/apply_as_range.c
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index b7dd4ddd6efb..62f24dd0bfa0 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2642,7 +2642,14 @@ struct pfn_range_apply {
> > >  };
> > >  extern int apply_to_pfn_range(struct pfn_range_apply *closure,
> > >  			      unsigned long address, unsigned long
> > > size);
> > > -
> > > +unsigned long apply_as_wrprotect(struct address_space *mapping,
> > > +				 pgoff_t first_index, pgoff_t nr);
> > > +unsigned long apply_as_clean(struct address_space *mapping,
> > > +			     pgoff_t first_index, pgoff_t nr,
> > > +			     pgoff_t bitmap_pgoff,
> > > +			     unsigned long *bitmap,
> > > +			     pgoff_t *start,
> > > +			     pgoff_t *end);
> > >  #ifdef CONFIG_PAGE_POISONING
> > >  extern bool page_poisoning_enabled(void);
> > >  extern void kernel_poison_pages(struct page *page, int numpages,
> > > int enable);
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index d210cc9d6f80..a94b78f12692 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -39,7 +39,7 @@ obj-y			:= filemap.o mempool.o
> > > oom_kill.o fadvise.o \
> > >  			   mm_init.o mmu_context.o percpu.o
> > > slab_common.o \
> > >  			   compaction.o vmacache.o \
> > >  			   interval_tree.o list_lru.o workingset.o \
> > > -			   debug.o $(mmu-y)
> > > +			   debug.o apply_as_range.o $(mmu-y)
> > >  
> > >  obj-y += init-mm.o
> > >  obj-y += memblock.o
> > > diff --git a/mm/apply_as_range.c b/mm/apply_as_range.c
> > > new file mode 100644
> > > index 000000000000..9f03e272ebd0
> > > --- /dev/null
> > > +++ b/mm/apply_as_range.c
> > > @@ -0,0 +1,257 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/mm.h>
> > > +#include <linux/mm_types.h>
> > > +#include <linux/hugetlb.h>
> > > +#include <linux/bitops.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/tlbflush.h>
> > > +
> > > +/**
> > > + * struct apply_as - Closure structure for apply_as_range
> > > + * @base: struct pfn_range_apply we derive from
> > > + * @start: Address of first modified pte
> > > + * @end: Address of last modified pte + 1
> > > + * @total: Total number of modified ptes
> > > + * @vma: Pointer to the struct vm_area_struct we're currently
> > > operating on
> > > + * @flush_cache: Whether to call a cache flush before modifying a
> > > pte
> > > + * @flush_tlb: Whether to flush the tlb after modifying a pte
> > > + */
> > > +struct apply_as {
> > > +	struct pfn_range_apply base;
> > > +	unsigned long start, end;
> > > +	unsigned long total;
> > > +	const struct vm_area_struct *vma;
> > > +	u32 flush_cache : 1;
> > > +	u32 flush_tlb : 1;
> > > +};
> > > +
> > > +/**
> > > + * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
> > > + * @pte: Pointer to the pte
> > > + * @token: Page table token, see apply_to_pfn_range()
> > > + * @addr: The virtual page address
> > > + * @closure: Pointer to a struct pfn_range_apply embedded in a
> > > + * struct apply_as
> > > + *
> > > + * The function write-protects a pte and records the range in
> > > + * virtual address space of touched ptes for efficient TLB
> > > flushes.
> > > + *
> > > + * Return: Always zero.
> > > + */
> > > +static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
> > > +			      unsigned long addr,
> > > +			      struct pfn_range_apply *closure)
> > > +{
> > > +	struct apply_as *aas = container_of(closure, typeof(*aas),
> > > base);
> > > +
> > > +	if (pte_write(*pte)) {
> > > +		set_pte_at(closure->mm, addr, pte,
> > > pte_wrprotect(*pte));
> > 
> > So there is no flushing here, even for x96 this is wrong. It
> > should be something like:
> >     ptep_clear_flush()
> >     flush_cache_page() // if pte is pointing to a regular page
> >     set_pte_at()
> >     update_mmu_cache()
> > 
> 
> Here cache flushing is done before any leaf function is called.
> According to 1) that should be equivalent, although flushing cache in
> the leaf function is probably more efficient for most use cases. Both
> these functions are no-ops for both x86 and ARM64 where they most
> likely will be used...
> 
> For ptep_clear_flush() the TLB flushing is here instead deferred to
> after all leaf functions have been called. It looks like if the PTE is
> dirty, the TLB has no business touching it until then anyway, it should
> be happy with its cached value.
> 
> Since flushing a single tlb page involves a broadcast across all cores,
> I believe flushing a range is a pretty important optimization.

Reading the code i missed the range flush below, it should be ok but
you should be using ptep_modify_prot_start()/ptep_modify_prot_commit()
pattern. I think some arch like to be involve in pte changes and the
2 patterns so far in the kernel (AFAIK) is ptep_clear_flush() or the
ptep_modify_prot_start//ptep_modify_prot_commit so i believe it is
better to stick to one of those instead of introducing a third one.

> 
> Also for update_mmu_cache() the impression I got from its docs is that
> it should only be used when increasing pte permissions, like in fault
> handlers, not the opposite?

I think some arch rely on it for something else but if you use the
range flushing properly you should not need it.

> > 
> > > +		aas->total++;
> > > +		if (addr < aas->start)
> > > +			aas->start = addr;
> > > +		if (addr + PAGE_SIZE > aas->end)
> > > +			aas->end = addr + PAGE_SIZE;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * struct apply_as_clean - Closure structure for apply_as_clean
> > > + * @base: struct apply_as we derive from
> > > + * @bitmap_pgoff: Address_space Page offset of the first bit in
> > > @bitmap
> > > + * @bitmap: Bitmap with one bit for each page offset in the
> > > address_space range
> > > + * covered.
> > > + * @start: Address_space page offset of first modified pte
> > > + * @end: Address_space page offset of last modified pte
> > > + */
> > > +struct apply_as_clean {
> > > +	struct apply_as base;
> > > +	pgoff_t bitmap_pgoff;
> > > +	unsigned long *bitmap;
> > > +	pgoff_t start, end;
> > > +};
> > > +
> > > +/**
> > > + * apply_pt_clean - Leaf pte callback to clean a pte
> > > + * @pte: Pointer to the pte
> > > + * @token: Page table token, see apply_to_pfn_range()
> > > + * @addr: The virtual page address
> > > + * @closure: Pointer to a struct pfn_range_apply embedded in a
> > > + * struct apply_as_clean
> > > + *
> > > + * The function cleans a pte and records the range in
> > > + * virtual address space of touched ptes for efficient TLB
> > > flushes.
> > > + * It also records dirty ptes in a bitmap representing page
> > > offsets
> > > + * in the address_space, as well as the first and last of the bits
> > > + * touched.
> > > + *
> > > + * Return: Always zero.
> > > + */
> > > +static int apply_pt_clean(pte_t *pte, pgtable_t token,
> > > +			  unsigned long addr,
> > > +			  struct pfn_range_apply *closure)
> > > +{
> > > +	struct apply_as *aas = container_of(closure, typeof(*aas),
> > > base);
> > > +	struct apply_as_clean *clean = container_of(aas,
> > > typeof(*clean), base);
> > > +
> > > +	if (pte_dirty(*pte)) {
> > > +		pgoff_t pgoff = ((addr - aas->vma->vm_start) >>
> > > PAGE_SHIFT) +
> > > +			aas->vma->vm_pgoff - clean->bitmap_pgoff;
> > > +
> > > +		set_pte_at(closure->mm, addr, pte, pte_mkclean(*pte));
> > 
> > Clearing the dirty bit is racy, it should be done with write protect
> > instead as the dirty bit can be set again just after you clear it.
> > So i am not sure what is the usage pattern where you want to clear
> > that bit without write protect.
> 
> If it's set again, then it will be picked up at the next GPU command
> submission referencing this page i. e. the next run of this function.
> What we're after here is to get to all pages that were dirtied *before*
> this call. The raciness and remedy (if desired) is mentioned in the
> comments to the exported function below. Typically users write-protect
> before scanning dirty bits only if transitioning to mkwrite-dirtying.
> The important thing is that we don't accidently clear dirty bits
> without picking them up.

Fair enough.

> > 
> > You also need proper page flushing with flush_cache_page()
> > 
> > > +		aas->total++;
> > > +		if (addr < aas->start)
> > > +			aas->start = addr;
> > > +		if (addr + PAGE_SIZE > aas->end)
> > > +			aas->end = addr + PAGE_SIZE;
> > > +
> > > +		__set_bit(pgoff, clean->bitmap);
> > > +		clean->start = min(clean->start, pgoff);
> > > +		clean->end = max(clean->end, pgoff + 1);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * apply_as_range - Apply a pte callback to all PTEs pointing into
> > > a range
> > > + * of an address_space.
> > > + * @mapping: Pointer to the struct address_space
> > > + * @aas: Closure structure
> > > + * @first_index: First page offset in the address_space
> > > + * @nr: Number of incremental page offsets to cover
> > > + *
> > > + * Return: Number of ptes touched. Note that this number might be
> > > larger
> > > + * than @nr if there are overlapping vmas
> > > + */
> > 
> > This comment need to be _scary_ it should only be use for device
> > driver
> > vma ie device driver mapping.
> > 
> > > +static unsigned long apply_as_range(struct address_space *mapping,
> > > +				    struct apply_as *aas,
> > > +				    pgoff_t first_index, pgoff_t nr)
> > > +{
> > > +	struct vm_area_struct *vma;
> > > +	pgoff_t vba, vea, cba, cea;
> > > +	unsigned long start_addr, end_addr;
> > > +
> > > +	/* FIXME: Is a read lock sufficient here? */
> > > +	down_write(&mapping->i_mmap_rwsem);
> > 
> > read would be sufficient and you should use i_mmap_lock_read() not
> > the down_write/read API.
> > 
> > > +	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
> > > +		first_index + nr - 1) {
> > > +		aas->base.mm = vma->vm_mm;
> > > +
> > > +		/* Clip to the vma */
> > > +		vba = vma->vm_pgoff;
> > > +		vea = vba + vma_pages(vma);
> > > +		cba = first_index;
> > > +		cba = max(cba, vba);
> > > +		cea = first_index + nr;
> > > +		cea = min(cea, vea);
> > > +
> > > +		/* Translate to virtual address */
> > > +		start_addr = ((cba - vba) << PAGE_SHIFT) + vma-
> > > >vm_start;
> > > +		end_addr = ((cea - vba) << PAGE_SHIFT) + vma->vm_start;
> > > +
> > > +		/*
> > > +		 * TODO: Should caches be flushed individually on
> > > demand
> > > +		 * in the leaf-pte callbacks instead? That is, how
> > > +		 * costly are inter-core interrupts in an SMP system?
> > > +		 */
> > > +		if (aas->flush_cache)
> > > +			flush_cache_range(vma, start_addr, end_addr);
> > 
> > flush_cache_range() is a noop on most architecture what you really
> > need
> > is proper per page flushing see above.
> 
> From the docs 1) they are interchangeable. But I will change to 
> per-page cache flushing anyway.

Yeah you can do flush_cache_range() it is fine.

Cheers,
Jérôme
