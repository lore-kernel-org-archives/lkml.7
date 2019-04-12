Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12ABC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B4B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLVHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:07:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDLVHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECAFC70008;
        Fri, 12 Apr 2019 21:07:48 +0000 (UTC)
Received: from redhat.com (ovpn-125-94.rdu2.redhat.com [10.10.125.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4135D6A9;
        Fri, 12 Apr 2019 21:07:46 +0000 (UTC)
Date:   Fri, 12 Apr 2019 17:07:43 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/9] mm: Add an apply_to_pfn_range interface
Message-ID: <20190412210743.GA19252@redhat.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
 <20190412160338.64994-3-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412160338.64994-3-thellstrom@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 12 Apr 2019 21:07:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 04:04:18PM +0000, Thomas Hellstrom wrote:
> This is basically apply_to_page_range with added functionality:
> Allocating missing parts of the page table becomes optional, which
> means that the function can be guaranteed not to error if allocation
> is disabled. Also passing of the closure struct and callback function
> becomes different and more in line with how things are done elsewhere.
> 
> Finally we keep apply_to_page_range as a wrapper around apply_to_pfn_range
> 
> The reason for not using the page-walk code is that we want to perform
> the page-walk on vmas pointing to an address space without requiring the
> mmap_sem to be held rather thand on vmas belonging to a process with the
> mmap_sem held.
> 
> Notable changes since RFC:
> Don't export apply_to_pfn range.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  include/linux/mm.h |  10 ++++
>  mm/memory.c        | 130 ++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 108 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80bb6408fe73..b7dd4ddd6efb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2632,6 +2632,16 @@ typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
>  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
>  			       unsigned long size, pte_fn_t fn, void *data);
>  
> +struct pfn_range_apply;
> +typedef int (*pter_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
> +			 struct pfn_range_apply *closure);
> +struct pfn_range_apply {
> +	struct mm_struct *mm;
> +	pter_fn_t ptefn;
> +	unsigned int alloc;
> +};
> +extern int apply_to_pfn_range(struct pfn_range_apply *closure,
> +			      unsigned long address, unsigned long size);
>  
>  #ifdef CONFIG_PAGE_POISONING
>  extern bool page_poisoning_enabled(void);
> diff --git a/mm/memory.c b/mm/memory.c
> index a95b4a3b1ae2..60d67158964f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1938,18 +1938,17 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
>  }
>  EXPORT_SYMBOL(vm_iomap_memory);
>  
> -static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> -				     unsigned long addr, unsigned long end,
> -				     pte_fn_t fn, void *data)
> +static int apply_to_pte_range(struct pfn_range_apply *closure, pmd_t *pmd,
> +			      unsigned long addr, unsigned long end)
>  {
>  	pte_t *pte;
>  	int err;
>  	pgtable_t token;
>  	spinlock_t *uninitialized_var(ptl);
>  
> -	pte = (mm == &init_mm) ?
> +	pte = (closure->mm == &init_mm) ?
>  		pte_alloc_kernel(pmd, addr) :
> -		pte_alloc_map_lock(mm, pmd, addr, &ptl);
> +		pte_alloc_map_lock(closure->mm, pmd, addr, &ptl);
>  	if (!pte)
>  		return -ENOMEM;
>  
> @@ -1960,86 +1959,107 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  	token = pmd_pgtable(*pmd);
>  
>  	do {
> -		err = fn(pte++, token, addr, data);
> +		err = closure->ptefn(pte++, token, addr, closure);
>  		if (err)
>  			break;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
>  	arch_leave_lazy_mmu_mode();
>  
> -	if (mm != &init_mm)
> +	if (closure->mm != &init_mm)
>  		pte_unmap_unlock(pte-1, ptl);
>  	return err;
>  }
>  
> -static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
> -				     unsigned long addr, unsigned long end,
> -				     pte_fn_t fn, void *data)
> +static int apply_to_pmd_range(struct pfn_range_apply *closure, pud_t *pud,
> +			      unsigned long addr, unsigned long end)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> -	int err;
> +	int err = 0;
>  
>  	BUG_ON(pud_huge(*pud));
>  
> -	pmd = pmd_alloc(mm, pud, addr);
> +	pmd = pmd_alloc(closure->mm, pud, addr);
>  	if (!pmd)
>  		return -ENOMEM;
> +
>  	do {
>  		next = pmd_addr_end(addr, end);
> -		err = apply_to_pte_range(mm, pmd, addr, next, fn, data);
> +		if (!closure->alloc && pmd_none_or_clear_bad(pmd))
> +			continue;
> +		err = apply_to_pte_range(closure, pmd, addr, next);
>  		if (err)
>  			break;
>  	} while (pmd++, addr = next, addr != end);
>  	return err;
>  }
>  
> -static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
> -				     unsigned long addr, unsigned long end,
> -				     pte_fn_t fn, void *data)
> +static int apply_to_pud_range(struct pfn_range_apply *closure, p4d_t *p4d,
> +			      unsigned long addr, unsigned long end)
>  {
>  	pud_t *pud;
>  	unsigned long next;
> -	int err;
> +	int err = 0;
>  
> -	pud = pud_alloc(mm, p4d, addr);
> +	pud = pud_alloc(closure->mm, p4d, addr);
>  	if (!pud)
>  		return -ENOMEM;
> +
>  	do {
>  		next = pud_addr_end(addr, end);
> -		err = apply_to_pmd_range(mm, pud, addr, next, fn, data);
> +		if (!closure->alloc && pud_none_or_clear_bad(pud))
> +			continue;
> +		err = apply_to_pmd_range(closure, pud, addr, next);
>  		if (err)
>  			break;
>  	} while (pud++, addr = next, addr != end);
>  	return err;
>  }
>  
> -static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
> -				     unsigned long addr, unsigned long end,
> -				     pte_fn_t fn, void *data)
> +static int apply_to_p4d_range(struct pfn_range_apply *closure, pgd_t *pgd,
> +			      unsigned long addr, unsigned long end)
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
> -	int err;
> +	int err = 0;
>  
> -	p4d = p4d_alloc(mm, pgd, addr);
> +	p4d = p4d_alloc(closure->mm, pgd, addr);
>  	if (!p4d)
>  		return -ENOMEM;
> +
>  	do {
>  		next = p4d_addr_end(addr, end);
> -		err = apply_to_pud_range(mm, p4d, addr, next, fn, data);
> +		if (!closure->alloc && p4d_none_or_clear_bad(p4d))
> +			continue;
> +		err = apply_to_pud_range(closure, p4d, addr, next);
>  		if (err)
>  			break;
>  	} while (p4d++, addr = next, addr != end);
>  	return err;
>  }
>  
> -/*
> - * Scan a region of virtual memory, filling in page tables as necessary
> - * and calling a provided function on each leaf page table.
> +/**
> + * apply_to_pfn_range - Scan a region of virtual memory, calling a provided
> + * function on each leaf page table entry
> + * @closure: Details about how to scan and what function to apply
> + * @addr: Start virtual address
> + * @size: Size of the region
> + *
> + * If @closure->alloc is set to 1, the function will fill in the page table
> + * as necessary. Otherwise it will skip non-present parts.
> + * Note: The caller must ensure that the range does not contain huge pages.
> + * The caller must also assure that the proper mmu_notifier functions are
> + * called. Either in the pte leaf function or before and after the call to
> + * apply_to_pfn_range.

This is wrong there should be a big FAT warning that this can only be use
against mmap of device file. The page table walking above is broken for
various thing you might find in any other vma like THP, device pte, hugetlbfs,
...

Also the mmu notifier can not be call from the pfn callback as that callback
happens under page table lock (the change_pte notifier callback is useless
and not enough). So it _must_ happen around the call to apply_to_pfn_range

apply_to_page_range was really not meant to be use in that way ... it was not
for regular vma.

Using this function for anything else is dangerous and having its uses spread
more increase that risk. So there must be a big FAT warning saying that you
should not use this lightly and that it should only be only on mmap of device
file.


> + *
> + * Returns: Zero on success. If the provided function returns a non-zero status,
> + * the page table walk will terminate and that status will be returned.
> + * If @closure->alloc is set to 1, then this function may also return memory
> + * allocation errors arising from allocating page table memory.
>   */
> -int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
> -			unsigned long size, pte_fn_t fn, void *data)
> +int apply_to_pfn_range(struct pfn_range_apply *closure,
> +		       unsigned long addr, unsigned long size)
>  {
>  	pgd_t *pgd;
>  	unsigned long next;
> @@ -2049,16 +2069,62 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  	if (WARN_ON(addr >= end))
>  		return -EINVAL;
>  
> -	pgd = pgd_offset(mm, addr);
> +	pgd = pgd_offset(closure->mm, addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data);
> +		if (!closure->alloc && pgd_none_or_clear_bad(pgd))
> +			continue;
> +		err = apply_to_p4d_range(closure, pgd, addr, next);
>  		if (err)
>  			break;
>  	} while (pgd++, addr = next, addr != end);
>  
>  	return err;
>  }
> +
> +/**
> + * struct page_range_apply - Closure structure for apply_to_page_range()
> + * @pter: The base closure structure we derive from
> + * @fn: The leaf pte function to call
> + * @data: The leaf pte function closure
> + */
> +struct page_range_apply {
> +	struct pfn_range_apply pter;
> +	pte_fn_t fn;
> +	void *data;
> +};
> +
> +/*
> + * Callback wrapper to enable use of apply_to_pfn_range for
> + * the apply_to_page_range interface
> + */
> +static int apply_to_page_range_wrapper(pte_t *pte, pgtable_t token,
> +				       unsigned long addr,
> +				       struct pfn_range_apply *pter)
> +{
> +	struct page_range_apply *pra =
> +		container_of(pter, typeof(*pra), pter);
> +
> +	return pra->fn(pte, token, addr, pra->data);
> +}
> +
> +/*
> + * Scan a region of virtual memory, filling in page tables as necessary
> + * and calling a provided function on each leaf page table.
> + */

It would be good to improve that comment too and make it a warning of
DO NOT USE ! THIS IS NOT SAFE ON REGULAR VMA !

> +int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
> +			unsigned long size, pte_fn_t fn, void *data)
> +{
> +	struct page_range_apply pra = {
> +		.pter = {.mm = mm,
> +			 .alloc = 1,
> +			 .ptefn = apply_to_page_range_wrapper },
> +		.fn = fn,
> +		.data = data
> +	};
> +
> +	return apply_to_pfn_range(&pra.pter, addr, size);
> +}
>  EXPORT_SYMBOL_GPL(apply_to_page_range);
>  
>  /*
> -- 
> 2.20.1
> 
