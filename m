Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0583C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B7621871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJHKz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:55:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfJHKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:55:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86A615BE;
        Tue,  8 Oct 2019 03:55:25 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE33A3F6C4;
        Tue,  8 Oct 2019 03:55:22 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:55:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
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
Subject: Re: [PATCH V8 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20191008105520.GA5694@arrakis.emea.arm.com>
References: <1569217425-23777-1-git-send-email-anshuman.khandual@arm.com>
 <1569217425-23777-3-git-send-email-anshuman.khandual@arm.com>
 <20191007141738.GA93112@E120351.arm.com>
 <6c277085-a430-eab4-3a4e-99fcfa170c10@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c277085-a430-eab4-3a4e-99fcfa170c10@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:06:26AM +0530, Anshuman Khandual wrote:
> On 10/07/2019 07:47 PM, Catalin Marinas wrote:
> > On Mon, Sep 23, 2019 at 11:13:45AM +0530, Anshuman Khandual wrote:
> >> The arch code for hot-remove must tear down portions of the linear map and
> >> vmemmap corresponding to memory being removed. In both cases the page
> >> tables mapping these regions must be freed, and when sparse vmemmap is in
> >> use the memory backing the vmemmap must also be freed.
> >>
> >> This patch adds unmap_hotplug_range() and free_empty_tables() helpers which
> >> can be used to tear down either region and calls it from vmemmap_free() and
> >> ___remove_pgd_mapping(). The sparse_vmap argument determines whether the
> >> backing memory will be freed.
> > 
> > Can you change the 'sparse_vmap' name to something more meaningful which
> > would suggest freeing of the backing memory?
> 
> free_mapped_mem or free_backed_mem ? Even shorter forms like free_mapped or
> free_backed might do as well. Do you have a particular preference here ? But
> yes, sparse_vmap has been very much specific to vmemmap for these functions
> which are now very generic in nature.

free_mapped would do.

> >> +static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
> >> +				    unsigned long end, bool sparse_vmap)
> >> +{
> >> +	struct page *page;
> >> +	pte_t *ptep, pte;
> >> +
> >> +	do {
> >> +		ptep = pte_offset_kernel(pmdp, addr);
> >> +		pte = READ_ONCE(*ptep);
> >> +		if (pte_none(pte))
> >> +			continue;
> >> +
> >> +		WARN_ON(!pte_present(pte));
> >> +		page = sparse_vmap ? pte_page(pte) : NULL;
> >> +		pte_clear(&init_mm, addr, ptep);
> >> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >> +		if (sparse_vmap)
> >> +			free_hotplug_page_range(page, PAGE_SIZE);
> > 
> > You could only set 'page' if sparse_vmap (or even drop 'page' entirely).
> 
> I am afraid 'page' is being used to hold pte_page(pte) extraction which
> needs to be freed (sparse_vmap) as we are going to clear the ptep entry
> in the next statement and lose access to it for good.

You clear *ptep, not pte.

> We will need some
> where to hold onto pte_page(pte) across pte_clear() as we cannot free it
> before clearing it's entry and flushing the TLB. Hence wondering how the
> 'page' can be completely dropped.
> 
> > The compiler is probably smart enough to optimise it but using a
> > pointless ternary operator just makes the code harder to follow.
> 
> Not sure I got this but are you suggesting for an 'if' statement here
> 
> if (sparse_vmap)
> 	page = pte_page(pte);
> 
> instead of the current assignment ?
> 
> page = sparse_vmap ? pte_page(pte) : NULL;

I suggest:

	if (sparse_vmap)
		free_hotplug_pgtable_page(pte_page(pte), PAGE_SIZE);

> >> +	} while (addr += PAGE_SIZE, addr < end);
> >> +}
> > [...]
> >> +static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
> >> +				 unsigned long end)
> >> +{
> >> +	pte_t *ptep, pte;
> >> +
> >> +	do {
> >> +		ptep = pte_offset_kernel(pmdp, addr);
> >> +		pte = READ_ONCE(*ptep);
> >> +		WARN_ON(!pte_none(pte));
> >> +	} while (addr += PAGE_SIZE, addr < end);
> >> +}
> >> +
> >> +static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
> >> +				 unsigned long end, unsigned long floor,
> >> +				 unsigned long ceiling)
> >> +{
> >> +	unsigned long next;
> >> +	pmd_t *pmdp, pmd;
> >> +
> >> +	do {
> >> +		next = pmd_addr_end(addr, end);
> >> +		pmdp = pmd_offset(pudp, addr);
> >> +		pmd = READ_ONCE(*pmdp);
> >> +		if (pmd_none(pmd))
> >> +			continue;
> >> +
> >> +		WARN_ON(!pmd_present(pmd) || !pmd_table(pmd) || pmd_sect(pmd));
> >> +		free_empty_pte_table(pmdp, addr, next);
> >> +		free_pte_table(pmdp, addr, next, floor, ceiling);
> > 
> > Do we need two closely named functions here? Can you not collapse
> > free_empty_pud_table() and free_pte_table() into a single one? The same
> > comment for the pmd/pud variants. I just find this confusing.
> 
> The two functions could be collapsed into a single one. But just wanted to
> keep free_pxx_table() part which checks floor/ceiling alignment, non-zero
> entries clear off the actual page table walking.

With the pmd variant, they both take the floor/ceiling argument while
the free_empty_pte_table() doesn't even free anything. So not entirely
consistent.

Can you not just copy the free_pgd_range() functions but instead of
p*d_free_tlb() just do the TLB invalidation followed by page freeing?
That seems to be an easier pattern to follow.

-- 
Catalin
