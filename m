Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2250214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCLPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:35:08 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:46023 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfCLPfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:35:08 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 87303453F; Tue, 12 Mar 2019 16:35:06 +0100 (CET)
Date:   Tue, 12 Mar 2019 16:35:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/hotplug: don't reset pagetype flags for offline
Message-ID: <20190312153458.qvmrblg3pnokgx4d@d104.suse.de>
References: <20190310200102.88014-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310200102.88014-1-cai@lca.pw>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 04:01:02PM -0400, Qian Cai wrote:
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
> will be marked as MIGRATE_MOVABLE again once onlining. In addition, fix
> an incorrect comment along the way.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

One thing I noticed when looking at start_isolate_page_range and 
undo_isolate_page_range functions, is that start_isolate_page_range increments
the number of isolated pageblocks, while undo_isolate_page_range does the counter
part.
Since undo_isolate_page_range is really never called during offlining,
we leave zone->nr_isolate_pageblock with a stale value.

I __think__  this does not matter much.
We only get to check whether a zone got isolated pageblocks in
has_isolate_pageblock(), and this is called from:

free_one_page
free_pcppages_bulk
__free_one_page

With a quick glance, the only difference in has_isolate_pageblock() returning
true or false, seems to be that those functions perform some extra checks in
case the zone reports to have isolated pageblocks.

I wonder if we should set nr_isolate_pageblock back to its original value
before start_isolate_page_range.

> ---
>  mm/memory_hotplug.c | 2 --
>  mm/sparse.c         | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6b05576fb4ec..46017040b2f8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1655,8 +1655,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	/* Ok, all of our target is isolated.
>  	   We cannot do rollback at this point. */
>  	offline_isolated_pages(start_pfn, end_pfn);
> -	/* reset pagetype flags and makes migrate type to be MOVABLE */
> -	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>  	/* removal success */
>  	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
>  	zone->present_pages -= offlined_pages;
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 77a0554fa5bd..b3771f35a0ed 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -556,7 +556,7 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
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
> 

-- 
Oscar Salvador
SUSE L3
