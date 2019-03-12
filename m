Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552403169;
	bh=J/0N/IM9xJzOzfAKDWofrN3/R7hnhWZOm6onYTPN8dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eUJJCW2iZhoQ5bvglTk0kGq+PuR+M3zyLdx6vuRxsB2eYzfP3cg/oMDRy74f6E4eu
	 4rDi6+SXffFAXUWN2b+xoEE2HxO98GSXBtcWulLZ9Eo2ZrcXTgAsxpf78pQ6RDwTIQ
	 ZOqiqe/a3M3r4zbPuRiQF7cZafsla+az7EXaRoHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfCLPGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbfCLPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9D05B168;
        Tue, 12 Mar 2019 15:06:04 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:06:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/hotplug: don't reset pagetype flags for offline
Message-ID: <20190312150604.GT5721@dhcp22.suse.cz>
References: <20190310200102.88014-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310200102.88014-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 10-03-19 16:01:02, Qian Cai wrote:
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

Well spotted. Thanks!

Acked-by: Michal Hocko <mhocko@suse.com>

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

-- 
Michal Hocko
SUSE Labs
