Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67619C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0FE2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552573401;
	bh=SxIvRXIdlcbxfzMwr2TApJkAptyVpPH2a7yV9R6GKlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wswhkcCZFQ4CS1CpxflxRHEwzOMxWi4Vusvm7aqIN4KbWZlqXVpaUiCpoJVZvaUlB
	 OmHpUtXS3kxN2wG+2VWXcnjAv/e3vqJ/FfD/93LM3uH5mZPkbZLiC9cmJu39AnwpvD
	 +pK/wYqAYL6Md4cg4wLQW1TMVG8M8TThv5OXXISg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCNOXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:23:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbfCNOXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:23:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AE4EAFF9;
        Thu, 14 Mar 2019 14:23:17 +0000 (UTC)
Date:   Thu, 14 Mar 2019 15:23:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hotplug: fix offline undo_isolate_page_range()
Message-ID: <20190314142317.GN7473@dhcp22.suse.cz>
References: <20190314140654.58883-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140654.58883-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 10:06:54, Qian Cai wrote:
> The commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online") introduced move_pfn_range_to_zone() which
> calls memmap_init_zone() during onlining a memory block.
> memmap_init_zone() will reset pagetype flags and makes migrate type to
> be MOVABLE.
> 
> However, in __offline_pages(), it also call undo_isolate_page_range()
> after offline_isolated_pages() to do the same thing. Due to
> the commit 2ce13640b3f4 ("mm: __first_valid_page skip over offline
> pages") changed __first_valid_page() to skip offline pages,
> undo_isolate_page_range() here just waste CPU cycles looping around the
> offlining PFN range while doing nothing, because __first_valid_page()
> will return NULL as offline_isolated_pages() has already marked all
> memory sections within the pfn range as offline via
> offline_mem_sections().
> 
> Also, after calling the "useless" undo_isolate_page_range() here, it
> reaches the point of no returning by notifying MEM_OFFLINE. Those pages
> will be marked as MIGRATE_MOVABLE again once onlining. The only thing
> left to do is to decrease the number of isolated pageblocks zone
> counter which would make some paths of the page allocation slower that
> the above commit introduced.
> 
> Even if alloc_contig_range() can be used to isolate 16GB-hugetlb pages
> on ppc64, an "int" should still be enough to represent the number of
> pageblocks there. Fix an incorrect comment along the way.
> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks for updating the doc. Looks good to me. I just guess you wanted
to make the doc a full kerneldoc and start it as /**

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

Just wondering, is there any specific reason to not consider the patch
for stable trees? While not critical, pushing some hotpaths into slower
mode is quite annoying. I cannot say this would be visible but it is
certainly an unintended behavior and the patch is reasonably safe to
backport so I would include it.

> ---
> 
> v3: Reconstruct the kernel-doc comments.
>     Use a more meaningful variable name per Oscar.
>     Update the commit log a bit.
> v2: Return the nubmer of isolated pageblocks in start_isolate_page_range() per
>     Oscar; take the zone lock when undoing zone->nr_isolate_pageblock per
>     Michal.
> 
>  include/linux/page-isolation.h |  4 ----
>  mm/memory_hotplug.c            | 17 +++++++++++++----
>  mm/page_alloc.c                |  2 +-
>  mm/page_isolation.c            | 35 +++++++++++++++++++++-------------
>  mm/sparse.c                    |  2 +-
>  5 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 4eb26d278046..5b24d56b2296 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -47,10 +47,6 @@ int move_freepages_block(struct zone *zone, struct page *page,
>   * For isolating all pages in the range finally, the caller have to
>   * free all pages in the range. test_page_isolated() can be used for
>   * test it.
> - *
> - * The following flags are allowed (they can be combined in a bit mask)
> - * SKIP_HWPOISON - ignore hwpoison pages
> - * REPORT_FAILURE - report details about the failure to isolate the range
>   */
>  int
>  start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d63c5a2959cf..cd1a8c4c6183 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1580,7 +1580,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  {
>  	unsigned long pfn, nr_pages;
>  	long offlined_pages;
> -	int ret, node;
> +	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
>  	unsigned long valid_start, valid_end;
>  	struct zone *zone;
> @@ -1606,10 +1606,11 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	ret = start_isolate_page_range(start_pfn, end_pfn,
>  				       MIGRATE_MOVABLE,
>  				       SKIP_HWPOISON | REPORT_FAILURE);
> -	if (ret) {
> +	if (ret < 0) {
>  		reason = "failure to isolate range";
>  		goto failed_removal;
>  	}
> +	nr_isolate_pageblock = ret;
>  
>  	arg.start_pfn = start_pfn;
>  	arg.nr_pages = nr_pages;
> @@ -1661,8 +1662,16 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	/* Ok, all of our target is isolated.
>  	   We cannot do rollback at this point. */
>  	offline_isolated_pages(start_pfn, end_pfn);
> -	/* reset pagetype flags and makes migrate type to be MOVABLE */
> -	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> +
> +	/*
> +	 * Onlining will reset pagetype flags and makes migrate type
> +	 * MOVABLE, so just need to decrease the number of isolated
> +	 * pageblocks zone counter here.
> +	 */
> +	spin_lock_irqsave(&zone->lock, flags);
> +	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +
>  	/* removal success */
>  	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
>  	zone->present_pages -= offlined_pages;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 03fcf73d47da..d96ca5bc555b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8233,7 +8233,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  
>  	ret = start_isolate_page_range(pfn_max_align_down(start),
>  				       pfn_max_align_up(end), migratetype, 0);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	/*
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e8baab91b1d1..dd7c002cd5ae 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -162,19 +162,22 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>  }
>  
>  /*
> - * start_isolate_page_range() -- make page-allocation-type of range of pages
> - * to be MIGRATE_ISOLATE.
> - * @start_pfn: The lower PFN of the range to be isolated.
> - * @end_pfn: The upper PFN of the range to be isolated.
> - * @migratetype: migrate type to set in error recovery.
> + * start_isolate_page_range() - make page-allocation-type of range of pages to
> + * be MIGRATE_ISOLATE.
> + * @start_pfn:		The lower PFN of the range to be isolated.
> + * @end_pfn:		The upper PFN of the range to be isolated.
> + *			start_pfn/end_pfn must be aligned to pageblock_order.
> + * @migratetype:	migrate type to set in error recovery.
> + * @flags:		The following flags are allowed (they can be combined in
> + *			a bit mask)
> + *			SKIP_HWPOISON - ignore hwpoison pages
> + *			REPORT_FAILURE - report details about the failure to
> + *			isolate the range
>   *
>   * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
>   * the range will never be allocated. Any free pages and pages freed in the
>   * future will not be allocated again.
>   *
> - * start_pfn/end_pfn must be aligned to pageblock_order.
> - * Return 0 on success and -EBUSY if any part of range cannot be isolated.
> - *
>   * There is no high level synchronization mechanism that prevents two threads
>   * from trying to isolate overlapping ranges.  If this happens, one thread
>   * will notice pageblocks in the overlapping range already set to isolate.
> @@ -182,6 +185,9 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * returns an error.  We then clean up by restoring the migration type on
>   * pageblocks we may have modified and return -EBUSY to caller.  This
>   * prevents two threads from simultaneously working on overlapping ranges.
> + *
> + * Return: the number of isolated pageblocks on success and -EBUSY if any part
> + * of range cannot be isolated.
>   */
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			     unsigned migratetype, int flags)
> @@ -189,6 +195,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	unsigned long pfn;
>  	unsigned long undo_pfn;
>  	struct page *page;
> +	int nr_isolate_pageblock = 0;
>  
>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> @@ -197,13 +204,15 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	     pfn < end_pfn;
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
> -		if (page &&
> -		    set_migratetype_isolate(page, migratetype, flags)) {
> -			undo_pfn = pfn;
> -			goto undo;
> +		if (page) {
> +			if (set_migratetype_isolate(page, migratetype, flags)) {
> +				undo_pfn = pfn;
> +				goto undo;
> +			}
> +			nr_isolate_pageblock++;
>  		}
>  	}
> -	return 0;
> +	return nr_isolate_pageblock;
>  undo:
>  	for (pfn = start_pfn;
>  	     pfn < undo_pfn;
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 69904aa6165b..56e057c432f9 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -567,7 +567,7 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -/* Mark all memory sections within the pfn range as online */
> +/* Mark all memory sections within the pfn range as offline */
>  void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	unsigned long pfn;
> -- 
> 2.17.2 (Apple Git-113)

-- 
Michal Hocko
SUSE Labs
