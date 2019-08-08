Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F75421874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfHHNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:50:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732727AbfHHNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843FE15A2;
        Thu,  8 Aug 2019 06:50:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B4873F694;
        Thu,  8 Aug 2019 06:50:43 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:50:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH v3 1/3] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190808135037.GA47131@lakrids.cambridge.arm.com>
References: <20190731071550.31814-1-dja@axtens.net>
 <20190731071550.31814-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731071550.31814-2-dja@axtens.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

This is looking really good!

I spotted a few more things we need to deal with, so I've suggested some
(not even compile-tested) code for that below. Mostly that's just error
handling, and using helpers to avoid things getting too verbose.

On Wed, Jul 31, 2019 at 05:15:48PM +1000, Daniel Axtens wrote:
> +void kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
> +{
> +	unsigned long shadow_alloc_start, shadow_alloc_end;
> +	unsigned long addr;
> +	unsigned long page;
> +	pgd_t *pgdp;
> +	p4d_t *p4dp;
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +	pte_t pte;
> +
> +	shadow_alloc_start = ALIGN_DOWN(
> +		(unsigned long)kasan_mem_to_shadow(area->addr),
> +		PAGE_SIZE);
> +	shadow_alloc_end = ALIGN(
> +		(unsigned long)kasan_mem_to_shadow(area->addr + area->size),
> +		PAGE_SIZE);
> +
> +	addr = shadow_alloc_start;
> +	do {
> +		pgdp = pgd_offset_k(addr);
> +		p4dp = p4d_alloc(&init_mm, pgdp, addr);
> +		pudp = pud_alloc(&init_mm, p4dp, addr);
> +		pmdp = pmd_alloc(&init_mm, pudp, addr);
> +		ptep = pte_alloc_kernel(pmdp, addr);
> +
> +		/*
> +		 * The pte may not be none if we allocated the page earlier to
> +		 * use part of it for another allocation.
> +		 *
> +		 * Because we only ever add to the vmalloc shadow pages and
> +		 * never free any, we can optimise here by checking for the pte
> +		 * presence outside the lock. It's OK to race with another
> +		 * allocation here because we do the 'real' test under the lock.
> +		 * This just allows us to save creating/freeing the new shadow
> +		 * page in the common case.
> +		 */
> +		if (!pte_none(*ptep))
> +			continue;
> +
> +		/*
> +		 * We're probably going to need to populate the shadow.
> +		 * Allocate and poision the shadow page now, outside the lock.
> +		 */
> +		page = __get_free_page(GFP_KERNEL);
> +		memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
> +		pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
> +
> +		spin_lock(&init_mm.page_table_lock);
> +		if (pte_none(*ptep)) {
> +			set_pte_at(&init_mm, addr, ptep, pte);
> +			page = 0;
> +		}
> +		spin_unlock(&init_mm.page_table_lock);
> +
> +		/* catch the case where we raced and don't need the page */
> +		if (page)
> +			free_page(page);
> +	} while (addr += PAGE_SIZE, addr != shadow_alloc_end);
> +

From looking at this for a while, there are a few more things we should
sort out:

* We need to handle allocations failing. I think we can get most of that
  by using apply_to_page_range() to allocate the tables for us.

* Between poisoning the page and updating the page table, we need an
  smp_wmb() to ensure that the poison is visible to other CPUs, similar
  to what __pte_alloc() and friends do when allocating new tables.

* We can use the split pmd locks (used by both x86 and arm64) to
  minimize contention on the init_mm ptl. As apply_to_page_range()
  doesn't pass the corresponding pmd in, we'll have to re-walk the table
  in the callback, but I suspect that's better than having all vmalloc
  operations contend on the same ptl.

I think it would make sense to follow the style of the __alloc_p??
functions and factor out the actual initialization into a helper like:

static int __kasan_populate_vmalloc_pte(pmd_t *pmdp, pte_t *ptep)
{
	unsigned long page;
	spinlock_t *ptl;
	pte_t pte;

	page = __get_free_page(GFP_KERNEL);
	if (!page)
		return -ENOMEM;

	memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);

	/*
	 * Ensure poisoning is visible before the shadow is made visible
	 * to other CPUs.
	 */
	smp_wmb();
	
	ptl = pmd_lock(&init_mm, pmdp);
	if (likely(pte_none(*ptep))) {
		set_pte(ptep, pte)
		page = 0;
	}
	spin_unlock(ptl);
	if (page)
		free_page(page);
	return 0;
}

... with the apply_to_page_range() callback looking a bit like
alloc_p??(), grabbing the pmd for its ptl.

static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr, void *unused)
{
	pgd_t *pgdp;
	p4d_t *p4dp;
	pud_t *pudp;
	pmd_t *pmdp;

	if (likely(!pte_none(*ptep)))
		return 0;

	pgdp = pgd_offset_k(addr);
	p4dp = p4d_offset(pgdp, addr)
	pudp = pud_pffset(p4dp, addr);
	pmdp = pmd_offset(pudp, addr);

	return __kasan_populate_vmalloc_pte(pmdp, ptep);
}

... and the main function looking something like:

int kasan_populate_vmalloc(...)
{
	unsigned long shadow_start, shadow_size;
	unsigned long addr;
	int ret;

	// calculate shadow bounds here
	
	ret = apply_to_page_range(&init_mm, shadow_start, shadow_size,
				  kasan_populate_vmalloc_pte, NULL);
	if (ret)
		return ret;
	
	...

	// unpoison the new allocation here
}

> +	kasan_unpoison_shadow(area->addr, requested_size);
> +
> +	/*
> +	 * We have to poison the remainder of the allocation each time, not
> +	 * just when the shadow page is first allocated, because vmalloc may
> +	 * reuse addresses, and an early large allocation would cause us to
> +	 * miss OOBs in future smaller allocations.
> +	 *
> +	 * The alternative is to poison the shadow on vfree()/vunmap(). We
> +	 * don't because the unmapping the virtual addresses should be
> +	 * sufficient to find most UAFs.
> +	 */
> +	requested_size = round_up(requested_size, KASAN_SHADOW_SCALE_SIZE);
> +	kasan_poison_shadow(area->addr + requested_size,
> +			    area->size - requested_size,
> +			    KASAN_VMALLOC_INVALID);
> +}

Is it painful to do the unpoison in the vfree/vunmap paths? I haven't
looked, so I might have missed something that makes that nasty.

If it's possible, I think it would be preferable to do so. It would be
consistent with the non-vmalloc KASAN cases. IIUC in that case we only
need the requested size here (and not the vmap_area), so we could just
take start and size as arguments.

Thanks,
Mark.
