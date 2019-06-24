Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F65C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66620204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfFXQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:52:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfFXQwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:52:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF5E360;
        Mon, 24 Jun 2019 09:52:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223FE3F71E;
        Mon, 24 Jun 2019 09:52:10 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:52:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steve Capper <Steve.Capper@arm.com>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "david@redhat.com" <david@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        James Morse <James.Morse@arm.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH V6 3/3] arm64/mm: Enable memory hot remove
Message-ID: <20190624165148.GA9847@lakrids.cambridge.arm.com>
References: <1560917860-26169-1-git-send-email-anshuman.khandual@arm.com>
 <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
 <20190621143540.GA3376@capper-debian.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621143540.GA3376@capper-debian.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 03:35:53PM +0100, Steve Capper wrote:
> Hi Anshuman,
> 
> On Wed, Jun 19, 2019 at 09:47:40AM +0530, Anshuman Khandual wrote:
> > The arch code for hot-remove must tear down portions of the linear map and
> > vmemmap corresponding to memory being removed. In both cases the page
> > tables mapping these regions must be freed, and when sparse vmemmap is in
> > use the memory backing the vmemmap must also be freed.
> > 
> > This patch adds a new remove_pagetable() helper which can be used to tear
> > down either region, and calls it from vmemmap_free() and
> > ___remove_pgd_mapping(). The sparse_vmap argument determines whether the
> > backing memory will be freed.
> > 
> > remove_pagetable() makes two distinct passes over the kernel page table.
> > In the first pass it unmaps, invalidates applicable TLB cache and frees
> > backing memory if required (vmemmap) for each mapped leaf entry. In the
> > second pass it looks for empty page table sections whose page table page
> > can be unmapped, TLB invalidated and freed.
> > 
> > While freeing intermediate level page table pages bail out if any of its
> > entries are still valid. This can happen for partially filled kernel page
> > table either from a previously attempted failed memory hot add or while
> > removing an address range which does not span the entire page table page
> > range.
> > 
> > The vmemmap region may share levels of table with the vmalloc region.
> > There can be conflicts between hot remove freeing page table pages with
> > a concurrent vmalloc() walking the kernel page table. This conflict can
> > not just be solved by taking the init_mm ptl because of existing locking
> > scheme in vmalloc(). Hence unlike linear mapping, skip freeing page table
> > pages while tearing down vmemmap mapping.
> > 
> > While here update arch_add_memory() to handle __add_pages() failures by
> > just unmapping recently added kernel linear mapping. Now enable memory hot
> > remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
> > 
> > This implementation is overall inspired from kernel page table tear down
> > procedure on X86 architecture.
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> 
> FWIW:
> Acked-by: Steve Capper <steve.capper@arm.com>
> 
> One minor comment below though.
> 
> >  arch/arm64/Kconfig  |   3 +
> >  arch/arm64/mm/mmu.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 284 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6426f48..9375f26 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -270,6 +270,9 @@ config HAVE_GENERIC_GUP
> >  config ARCH_ENABLE_MEMORY_HOTPLUG
> >  	def_bool y
> >  
> > +config ARCH_ENABLE_MEMORY_HOTREMOVE
> > +	def_bool y
> > +
> >  config SMP
> >  	def_bool y
> >  
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 93ed0df..9e80a94 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -733,6 +733,250 @@ int kern_addr_valid(unsigned long addr)
> >  
> >  	return pfn_valid(pte_pfn(pte));
> >  }
> > +
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +static void free_hotplug_page_range(struct page *page, size_t size)
> > +{
> > +	WARN_ON(!page || PageReserved(page));
> > +	free_pages((unsigned long)page_address(page), get_order(size));
> > +}
> 
> We are dealing with power of 2 number of pages, it makes a lot more
> sense (to me) to replace the size parameter with order.
> 
> Also, all the callers are for known compile-time sizes, so we could just
> translate the size parameter as follows to remove any usage of get_order?
> PAGE_SIZE -> 0
> PMD_SIZE -> PMD_SHIFT - PAGE_SHIFT
> PUD_SIZE -> PUD_SHIFT - PAGE_SHIFT

Now that I look at this again, the above makes sense to me.

I'd requested the current form (which I now realise is broken), since
back in v2 the code looked like:

static void free_pagetable(struct page *page, int order)
{
	...
	free_pages((unsigned long)page_address(page), order);
	...
}

... with callsites looking like:

free_pagetable(pud_page(*pud), get_order(PUD_SIZE));

... which I now see is off by PAGE_SHIFT, and we inherited that bug in
the current code, so the calculated order is vastly larger than it
should be. It's worrying that doesn't seem to be caught by anything in
testing. :/

Anshuman, could you please fold in Steve's suggested change? I'll look
at the rest of the series shortly, so no need to resend that right away,
but it would be worth sorting out.

Thanks,
Mark.
