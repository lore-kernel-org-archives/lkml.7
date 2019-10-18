Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32EFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6B321925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571402346;
	bh=nwNjuJIXnFqnhF8w+lexSmZ2c36P//HQ07zmxgnzLMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NTu16joqh6akJyUlRhdSgTZSl89u/cZ2ehA+Kz8fDwSVuTG1CAgTJFRdUhzTgm4Ek
	 s1+4PouudP3N7smICQ0D3qHJMO+5eqkYWGAHGcQdCyX4cIcbk6Tp8kphK/3oR4PFJ5
	 0QVo/HJq7a9C9aSsbXsmDH+9Tnnf8uH9hUU5lnwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633901AbfJRMjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:39:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728515AbfJRMjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:39:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AD3AB390;
        Fri, 18 Oct 2019 12:39:02 +0000 (UTC)
Date:   Fri, 18 Oct 2019 14:39:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191018123901.GN5017@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017142123.24245-12-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 16:21:18, Oscar Salvador wrote:
> This patch changes the way we set and handle in-use poisoned pages.
> Until now, poisoned pages were released to the buddy allocator, trusting
> that the checks that take place prior to hand the page would act as a
> safe net and would skip that page.
> 
> This has proved to be wrong, as we got some pfn walkers out there, like
> compaction, that all they care is the page to be PageBuddy and be in a
> freelist.
> Although this might not be the only user, having poisoned pages
> in the buddy allocator seems a bad idea as we should only have
> free pages that are ready and meant to be used as such.

Agreed on this part.

> Before explainaing the taken approach, let us break down the kind
> of pages we can soft offline.
> 
> - Anonymous THP (after the split, they end up being 4K pages)
> - Hugetlb
> - Order-0 pages (that can be either migrated or invalited)
> 
> * Normal pages (order-0 and anon-THP)
> 
>   - If they are clean and unmapped page cache pages, we invalidate
>     then by means of invalidate_inode_page().
>   - If they are mapped/dirty, we do the isolate-and-migrate dance.
> 
>   Either way, do not call put_page directly from those paths.
>   Instead, we keep the page and send it to page_set_poison to perform the
>   right handling.
> 
>   page_set_poison sets the HWPoison flag and does the last put_page.
>   This call to put_page is mainly to be able to call __page_cache_release,
>   since this function is not exported.
> 
>   Down the chain, we placed a check for HWPoison page in free_pages_prepare,
>   that just skips any poisoned page, so those pages do not end up in any
>   pcplist/freelist.
> 
>   After that, we set the refcount on the page to 1 and we increment
>   the poisoned pages counter.
> 
>   We could do as we do for free pages:
>   1) wait until the page hits buddy's freelists
>   2) take it off
>   3) flag it
> 
>   The problem is that we could race with an allocation, so by the time we
>   want to take the page off the buddy, the page is already allocated, so we
>   cannot soft-offline it.
>   This is not fatal of course, but if it is better if we can close the race
>   as does not require a lot of code.
> 
> * Hugetlb pages
> 
>   - We isolate-and-migrate them
> 
>   After the migration has been succesful, we call dissolve_free_huge_page,
>   and we set HWPoison on the page if we succeed.
>   Hugetlb has a slightly different handling though.
> 
>   While for non-hugetlb pages we cared about closing the race with an allocation,
>   doing so for hugetlb pages requires quite some additional code (we would need to
>   hook in free_huge_page and some other places).
>   So I decided to not make the code overly complicated and just fail normally
>   if the page we allocated in the meantime.
> 
> Because of the way we handle now in-use pages, we no longer need the
> put-as-isolation-migratetype dance, that was guarding for poisoned pages
> to end up in pcplists.

I am sorry but I got lost in the above description and I cannot really
make much sense from the code either. Let me try to outline the way how
I think about this.

Say we have a pfn to hwpoison. We have effectivelly three possibilities
- page is poisoned already - done nothing to do
- page is managed by the buddy allocator - excavate from there
- page is in use

The last category is the most interesting one. There are essentially
three classes of pages
- freeable
- migrateable
- others

We cannot do really much about the last one, right? Do we mark them
HWPoison anyway?
Freeable should be simply marked HWPoison and freed.
For all those migrateable, we simply do migrate and mark HWPoison.

Now the main question is how to handle HWPoison page when it is freed
- aka last reference is dropped. The main question is whether the last
reference is ever dropped. If yes then the free_pages_prepare should
never release it to the allocator (some compound destructors would have
to special case as well, e.g. hugetlb would have to hand over to the
allocator rather than a pool). If not then the page would be lingering
potentially with some state bound to it (e.g. memcg charge).  So I
suspect you want the former.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/page-flags.h |  5 -----
>  mm/memory-failure.c        | 43 ++++++++++++++-----------------------------
>  mm/migrate.c               | 11 +++--------
>  mm/page_alloc.c            | 31 +++----------------------------
>  4 files changed, 20 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb8898ff0..21df81c9ea57 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -414,13 +414,8 @@ PAGEFLAG_FALSE(Uncached)
>  PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>  TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
>  #define __PG_HWPOISON (1UL << PG_hwpoison)
> -extern bool set_hwpoison_free_buddy_page(struct page *page);
>  #else
>  PAGEFLAG_FALSE(HWPoison)
> -static inline bool set_hwpoison_free_buddy_page(struct page *page)
> -{
> -	return 0;
> -}
>  #define __PG_HWPOISON 0
>  #endif
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 1d986580522d..9b40cf1cb4fc 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -80,9 +80,11 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
>  
>  extern bool take_page_off_buddy(struct page *page);
>  
> -static void page_handle_poison(struct page *page)
> +static void page_handle_poison(struct page *page, bool release)
>  {
>  	SetPageHWPoison(page);
> +	if (release)
> +		put_page(page);
>  	page_ref_inc(page);
>  	num_poisoned_pages_inc();
>  }
> @@ -1713,19 +1715,13 @@ static int soft_offline_huge_page(struct page *page)
>  			ret = -EIO;
>  	} else {
>  		/*
> -		 * We set PG_hwpoison only when the migration source hugepage
> -		 * was successfully dissolved, because otherwise hwpoisoned
> -		 * hugepage remains on free hugepage list, then userspace will
> -		 * find it as SIGBUS by allocation failure. That's not expected
> -		 * in soft-offlining.
> +		 * We set PG_hwpoison only when we were able to take the page
> +		 * off the buddy.
>  		 */
> -		ret = dissolve_free_huge_page(page);
> -		if (!ret) {
> -			if (set_hwpoison_free_buddy_page(page))
> -				num_poisoned_pages_inc();
> -			else
> -				ret = -EBUSY;
> -		}
> +		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
> +			page_handle_poison(page, false);
> +		else
> +			ret = -EBUSY;
>  	}
>  	return ret;
>  }
> @@ -1760,10 +1756,8 @@ static int __soft_offline_page(struct page *page)
>  	 * would need to fix isolation locking first.
>  	 */
>  	if (ret == 1) {
> -		put_page(page);
>  		pr_info("soft_offline: %#lx: invalidated\n", pfn);
> -		SetPageHWPoison(page);
> -		num_poisoned_pages_inc();
> +		page_handle_poison(page, true);
>  		return 0;
>  	}
>  
> @@ -1794,7 +1788,9 @@ static int __soft_offline_page(struct page *page)
>  		list_add(&page->lru, &pagelist);
>  		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
>  					MIGRATE_SYNC, MR_MEMORY_FAILURE);
> -		if (ret) {
> +		if (!ret) {
> +			page_handle_poison(page, true);
> +		} else {
>  			if (!list_empty(&pagelist))
>  				putback_movable_pages(&pagelist);
>  
> @@ -1813,27 +1809,16 @@ static int __soft_offline_page(struct page *page)
>  static int soft_offline_in_use_page(struct page *page)
>  {
>  	int ret;
> -	int mt;
>  	struct page *hpage = compound_head(page);
>  
>  	if (!PageHuge(page) && PageTransHuge(hpage))
>  		if (try_to_split_thp_page(page, "soft offline") < 0)
>  			return -EBUSY;
>  
> -	/*
> -	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
> -	 * to free list immediately (not via pcplist) when released after
> -	 * successful page migration. Otherwise we can't guarantee that the
> -	 * page is really free after put_page() returns, so
> -	 * set_hwpoison_free_buddy_page() highly likely fails.
> -	 */
> -	mt = get_pageblock_migratetype(page);
> -	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>  	if (PageHuge(page))
>  		ret = soft_offline_huge_page(page);
>  	else
>  		ret = __soft_offline_page(page);
> -	set_pageblock_migratetype(page, mt);
>  	return ret;
>  }
>  
> @@ -1842,7 +1827,7 @@ static int soft_offline_free_page(struct page *page)
>  	int rc = -EBUSY;
>  
>  	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
> -		page_handle_poison(page);
> +		page_handle_poison(page, false);
>  		rc = 0;
>  	}
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fe45d1428c8..71acece248d7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1224,16 +1224,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  	 * we want to retry.
>  	 */
>  	if (rc == MIGRATEPAGE_SUCCESS) {
> -		put_page(page);
> -		if (reason == MR_MEMORY_FAILURE) {
> +		if (reason != MR_MEMORY_FAILURE)
>  			/*
> -			 * Set PG_HWPoison on just freed page
> -			 * intentionally. Although it's rather weird,
> -			 * it's how HWPoison flag works at the moment.
> +			 * We release the page in page_handle_poison.
>  			 */
> -			if (set_hwpoison_free_buddy_page(page))
> -				num_poisoned_pages_inc();
> -		}
> +			put_page(page);
>  	} else {
>  		if (rc != -EAGAIN) {
>  			if (likely(!__PageMovable(page))) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 255df0c76a40..cb35a4c8b1f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1132,6 +1132,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> +	if (unlikely(PageHWPoison(page)) && !order)
> +		return false;
> +
>  	trace_mm_page_free(page, order);
>  
>  	/*
> @@ -8698,32 +8701,4 @@ bool take_page_off_buddy(struct page *page)
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  	return ret;
>   }
> -
> -/*
> - * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
> - * test is performed under the zone lock to prevent a race against page
> - * allocation.
> - */
> -bool set_hwpoison_free_buddy_page(struct page *page)
> -{
> -	struct zone *zone = page_zone(page);
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long flags;
> -	unsigned int order;
> -	bool hwpoisoned = false;
> -
> -	spin_lock_irqsave(&zone->lock, flags);
> -	for (order = 0; order < MAX_ORDER; order++) {
> -		struct page *page_head = page - (pfn & ((1 << order) - 1));
> -
> -		if (PageBuddy(page_head) && page_order(page_head) >= order) {
> -			if (!TestSetPageHWPoison(page))
> -				hwpoisoned = true;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&zone->lock, flags);
> -
> -	return hwpoisoned;
> -}
>  #endif
> -- 
> 2.12.3

-- 
Michal Hocko
SUSE Labs
