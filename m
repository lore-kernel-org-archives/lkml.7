Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1veXPCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfJJNGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:06:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387430AbfJJNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tqf8tFgNaaRaIaDieyfawLGHKKkqZqtuef52CA1Rf+g=; b=b1veXPCc0t4IF5wvmsySDMJ4dz
        fJ7ac0Csl/pY02yu3PdJetQbkUKnlhkHeTTVhmJdpGidpq2WNtEkBFu71AP3HqbmDPQcXvmbbtMh8
        z94TPqvrTixMFEHedbi+lXlo4nAxXm4tWIhr4YqAj0EihUMkEicsONPhkKsc861vJMTeFNEykuY7g
        foHr4SCUlLqDzAFwP5SrdAGhWFQjyA1zbRjfVtZk7OgBgVCCpXYTD+8W3OI/CyzqAkTeWAQ1leVzq
        tGivrwFCtToFBzqro6WIIZeTdbKOQRtFv63TcBRXaW0lHZG5t9HP2fffXyRCwTbcBwt2wBjLnmf1s
        I/7fqQEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIY8X-0004H5-LV; Thu, 10 Oct 2019 13:05:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A21833056BE;
        Thu, 10 Oct 2019 15:04:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C171A20427801; Thu, 10 Oct 2019 15:05:42 +0200 (CEST)
Date:   Thu, 10 Oct 2019 15:05:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v5 4/8] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20191010130542.GP2328@hirez.programming.kicks-ass.net>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
 <20191010124314.40067-5-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010124314.40067-5-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:43:10PM +0200, Thomas Hellström (VMware) wrote:

> +/**
> + * struct wp_walk - Private struct for pagetable walk callbacks
> + * @range: Range for mmu notifiers
> + * @tlbflush_start: Address of first modified pte
> + * @tlbflush_end: Address of last modified pte + 1
> + * @total: Total number of modified ptes
> + */
> +struct wp_walk {
> +	struct mmu_notifier_range range;
> +	unsigned long tlbflush_start;
> +	unsigned long tlbflush_end;
> +	unsigned long total;
> +};
> +
> +/**
> + * wp_pte - Write-protect a pte
> + * @pte: Pointer to the pte
> + * @addr: The virtual page address
> + * @walk: pagetable walk callback argument
> + *
> + * The function write-protects a pte and records the range in
> + * virtual address space of touched ptes for efficient range TLB flushes.
> + */
> +static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
> +		  struct mm_walk *walk)
> +{
> +	struct wp_walk *wpwalk = walk->private;
> +	pte_t ptent = *pte;
> +
> +	if (pte_write(ptent)) {
> +		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
> +
> +		ptent = pte_wrprotect(old_pte);
> +		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
> +		wpwalk->total++;
> +		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
> +		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
> +					   addr + PAGE_SIZE);
> +	}
> +
> +	return 0;
> +}

> +/*
> + * wp_clean_pre_vma - The pagewalk pre_vma callback.
> + *
> + * The pre_vma callback performs the cache flush, stages the tlb flush
> + * and calls the necessary mmu notifiers.
> + */
> +static int wp_clean_pre_vma(unsigned long start, unsigned long end,
> +			    struct mm_walk *walk)
> +{
> +	struct wp_walk *wpwalk = walk->private;
> +
> +	wpwalk->tlbflush_start = end;
> +	wpwalk->tlbflush_end = start;
> +
> +	mmu_notifier_range_init(&wpwalk->range, MMU_NOTIFY_PROTECTION_PAGE, 0,
> +				walk->vma, walk->mm, start, end);
> +	mmu_notifier_invalidate_range_start(&wpwalk->range);
> +	flush_cache_range(walk->vma, start, end);
> +
> +	/*
> +	 * We're not using tlb_gather_mmu() since typically
> +	 * only a small subrange of PTEs are affected, whereas
> +	 * tlb_gather_mmu() records the full range.
> +	 */
> +	inc_tlb_flush_pending(walk->mm);
> +
> +	return 0;
> +}
> +
> +/*
> + * wp_clean_post_vma - The pagewalk post_vma callback.
> + *
> + * The post_vma callback performs the tlb flush and calls necessary mmu
> + * notifiers.
> + */
> +static void wp_clean_post_vma(struct mm_walk *walk)
> +{
> +	struct wp_walk *wpwalk = walk->private;
> +
> +	if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
> +		flush_tlb_range(walk->vma, wpwalk->tlbflush_start,
> +				wpwalk->tlbflush_end);
> +
> +	mmu_notifier_invalidate_range_end(&wpwalk->range);
> +	dec_tlb_flush_pending(walk->mm);
> +}

> +/**
> + * wp_shared_mapping_range - Write-protect all ptes in an address space range
> + * @mapping: The address_space we want to write protect
> + * @first_index: The first page offset in the range
> + * @nr: Number of incremental page offsets to cover
> + *
> + * Note: This function currently skips transhuge page-table entries, since
> + * it's intended for dirty-tracking on the PTE level. It will warn on
> + * encountering transhuge write-enabled entries, though, and can easily be
> + * extended to handle them as well.
> + *
> + * Return: The number of ptes actually write-protected. Note that
> + * already write-protected ptes are not counted.
> + */
> +unsigned long wp_shared_mapping_range(struct address_space *mapping,
> +				      pgoff_t first_index, pgoff_t nr)
> +{
> +	struct wp_walk wpwalk = { .total = 0 };
> +
> +	i_mmap_lock_read(mapping);
> +	WARN_ON(walk_page_mapping(mapping, first_index, nr, &wp_walk_ops,
> +				  &wpwalk));
> +	i_mmap_unlock_read(mapping);
> +
> +	return wpwalk.total;
> +}

That's a read lock, this means there's concurrency to self. What happens
if someone does two concurrent wp_shared_mapping_range() on the same
mapping?

The thing is, because of pte_wrprotect() the iteration that starts last
will see a smaller pte_write range, if it completes first and does
flush_tlb_range(), it will only flush a partial range.

This is exactly what {inc,dec}_tlb_flush_pending() is for, but you're
not using mm_tlb_flush_nested() to detect the situation and do a bigger
flush.

Or if you're not needing that, then I'm missing why.
