Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAAAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C237214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="IHFgKCWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfJJNY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:24:57 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3845 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbfJJNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:24:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 9B82A3F5BA;
        Thu, 10 Oct 2019 15:24:49 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IHFgKCWe;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3XUqGEMUE5gz; Thu, 10 Oct 2019 15:24:48 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 200C13F218;
        Thu, 10 Oct 2019 15:24:47 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A5D6E36016C;
        Thu, 10 Oct 2019 15:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570713887; bh=yK1u/Rnoy8IWU/rETIHj7UhNPo8garpxzlHbvHp5834=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IHFgKCWekWXRCUBFYpE7MI2azz39w2sMws1Pmp9PW7aroDSXaYN6vvEhi0Ddcsgkx
         fE3JK0Bcu9btM3I9urNCO94OY/ZGUcOz3BxfWjYBP9iSzM6Wzy7ziqNiIcvs0+JyfD
         XE8lmUOAnCrCnTVW/pXYeJ3upXkPWFMMWXQHLSUc=
Subject: Re: [PATCH v5 4/8] mm: Add write-protect and clean utilities for
 address space ranges
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
 <20191010124314.40067-5-thomas_os@shipmail.org>
 <20191010130542.GP2328@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <45cf5965-bd63-3574-d8c2-abbd6c4960d5@shipmail.org>
Date:   Thu, 10 Oct 2019 15:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191010130542.GP2328@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 3:05 PM, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 02:43:10PM +0200, Thomas Hellström (VMware) wrote:
>
>> +/**
>> + * struct wp_walk - Private struct for pagetable walk callbacks
>> + * @range: Range for mmu notifiers
>> + * @tlbflush_start: Address of first modified pte
>> + * @tlbflush_end: Address of last modified pte + 1
>> + * @total: Total number of modified ptes
>> + */
>> +struct wp_walk {
>> +	struct mmu_notifier_range range;
>> +	unsigned long tlbflush_start;
>> +	unsigned long tlbflush_end;
>> +	unsigned long total;
>> +};
>> +
>> +/**
>> + * wp_pte - Write-protect a pte
>> + * @pte: Pointer to the pte
>> + * @addr: The virtual page address
>> + * @walk: pagetable walk callback argument
>> + *
>> + * The function write-protects a pte and records the range in
>> + * virtual address space of touched ptes for efficient range TLB flushes.
>> + */
>> +static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
>> +		  struct mm_walk *walk)
>> +{
>> +	struct wp_walk *wpwalk = walk->private;
>> +	pte_t ptent = *pte;
>> +
>> +	if (pte_write(ptent)) {
>> +		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
>> +
>> +		ptent = pte_wrprotect(old_pte);
>> +		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
>> +		wpwalk->total++;
>> +		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
>> +		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
>> +					   addr + PAGE_SIZE);
>> +	}
>> +
>> +	return 0;
>> +}
>> +/*
>> + * wp_clean_pre_vma - The pagewalk pre_vma callback.
>> + *
>> + * The pre_vma callback performs the cache flush, stages the tlb flush
>> + * and calls the necessary mmu notifiers.
>> + */
>> +static int wp_clean_pre_vma(unsigned long start, unsigned long end,
>> +			    struct mm_walk *walk)
>> +{
>> +	struct wp_walk *wpwalk = walk->private;
>> +
>> +	wpwalk->tlbflush_start = end;
>> +	wpwalk->tlbflush_end = start;
>> +
>> +	mmu_notifier_range_init(&wpwalk->range, MMU_NOTIFY_PROTECTION_PAGE, 0,
>> +				walk->vma, walk->mm, start, end);
>> +	mmu_notifier_invalidate_range_start(&wpwalk->range);
>> +	flush_cache_range(walk->vma, start, end);
>> +
>> +	/*
>> +	 * We're not using tlb_gather_mmu() since typically
>> +	 * only a small subrange of PTEs are affected, whereas
>> +	 * tlb_gather_mmu() records the full range.
>> +	 */
>> +	inc_tlb_flush_pending(walk->mm);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * wp_clean_post_vma - The pagewalk post_vma callback.
>> + *
>> + * The post_vma callback performs the tlb flush and calls necessary mmu
>> + * notifiers.
>> + */
>> +static void wp_clean_post_vma(struct mm_walk *walk)
>> +{
>> +	struct wp_walk *wpwalk = walk->private;
>> +
>> +	if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
>> +		flush_tlb_range(walk->vma, wpwalk->tlbflush_start,
>> +				wpwalk->tlbflush_end);
>> +
>> +	mmu_notifier_invalidate_range_end(&wpwalk->range);
>> +	dec_tlb_flush_pending(walk->mm);
>> +}
>> +/**
>> + * wp_shared_mapping_range - Write-protect all ptes in an address space range
>> + * @mapping: The address_space we want to write protect
>> + * @first_index: The first page offset in the range
>> + * @nr: Number of incremental page offsets to cover
>> + *
>> + * Note: This function currently skips transhuge page-table entries, since
>> + * it's intended for dirty-tracking on the PTE level. It will warn on
>> + * encountering transhuge write-enabled entries, though, and can easily be
>> + * extended to handle them as well.
>> + *
>> + * Return: The number of ptes actually write-protected. Note that
>> + * already write-protected ptes are not counted.
>> + */
>> +unsigned long wp_shared_mapping_range(struct address_space *mapping,
>> +				      pgoff_t first_index, pgoff_t nr)
>> +{
>> +	struct wp_walk wpwalk = { .total = 0 };
>> +
>> +	i_mmap_lock_read(mapping);
>> +	WARN_ON(walk_page_mapping(mapping, first_index, nr, &wp_walk_ops,
>> +				  &wpwalk));
>> +	i_mmap_unlock_read(mapping);
>> +
>> +	return wpwalk.total;
>> +}
> That's a read lock, this means there's concurrency to self. What happens
> if someone does two concurrent wp_shared_mapping_range() on the same
> mapping?
>
> The thing is, because of pte_wrprotect() the iteration that starts last
> will see a smaller pte_write range, if it completes first and does
> flush_tlb_range(), it will only flush a partial range.
>
> This is exactly what {inc,dec}_tlb_flush_pending() is for, but you're
> not using mm_tlb_flush_nested() to detect the situation and do a bigger
> flush.
>
> Or if you're not needing that, then I'm missing why.

Good catch. Thanks,

Yes the read lock is not intended to protect against concurrent users 
but to protect the vmas from disappearing under us. Since it 
fundamentally makes no sense having two concurrent threads picking up 
dirty ptes on the same address_space range we have an external 
range-based lock to protect against that.

However, that external lock doesn't protect other code  from 
concurrently modifying ptes and having the mm's  tlb_flush_pending 
increased, so I guess we unconditionally need to test for that and do a 
full range flush if necessary?

Thanks,

Thomas


