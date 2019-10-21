Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA3CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812BD2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571669030;
	bh=4tucuf7nmKqmOHZr8VTJCYuBSVagd0+Lf0FuQZjv800=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=acZSVXkaBOduOQLdLIgYTrtV/gxVcecZmK7B1r5HBHRn3Ml5N6mjX/kYsG1TY5rbZ
	 pfoDl2Ga3sFmgf5V6y8vhKHk3G4tys0d/AIe/ylEskxNZWmOl/0d2Z7arwIy8hOvW7
	 6xdVD0A5qxc5E219hgUIkFmO1Ov8o3DrNBsiNYO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfJUOnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:43:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbfJUOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D9E6B794;
        Mon, 21 Oct 2019 14:43:46 +0000 (UTC)
Date:   Mon, 21 Oct 2019 16:43:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc.c: Don't set pages PageReserved()
 when offlining
Message-ID: <20191021144345.GT9379@dhcp22.suse.cz>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021141927.10252-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 16:19:25, David Hildenbrand wrote:
> We call __offline_isolated_pages() from __offline_pages() after all
> pages were isolated and are either free (PageBuddy()) or PageHWPoison.
> Nothing can stop us from offlining memory at this point.
> 
> In __offline_isolated_pages() we first set all affected memory sections
> offline (offline_mem_sections(pfn, end_pfn)), to mark the memmap as
> invalid (pfn_to_online_page() will no longer succeed), and then walk over
> all pages to pull the free pages from the free lists (to the isolated
> free lists, to be precise).
> 
> Note that re-onlining a memory block will result in the whole memmap
> getting reinitialized, overwriting any old state. We already poision the
> memmap when offlining is complete to find any access to
> stale/uninitialized memmaps.
> 
> So, setting the pages PageReserved() is not helpful. The memap is marked
> offline and all pageblocks are isolated. As soon as offline, the memmap
> is stale either way.
> 
> This looks like a leftover from ancient times where we initialized the
> memmap when adding memory and not when onlining it (the pages were set
> PageReserved so re-onling would work as expected).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

We still set PageReserved before onlining pages and that one should be
good to go as well (memmap_init_zone).
Thanks!

There is a comment above offline_isolated_pages_cb that should be
removed as well.

> ---
>  mm/page_alloc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ed8884dc0c47..bf6b21f02154 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8667,7 +8667,7 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct page *page;
>  	struct zone *zone;
> -	unsigned int order, i;
> +	unsigned int order;
>  	unsigned long pfn;
>  	unsigned long flags;
>  	unsigned long offlined_pages = 0;
> @@ -8695,7 +8695,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		 */
>  		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
>  			pfn++;
> -			SetPageReserved(page);
>  			offlined_pages++;
>  			continue;
>  		}
> @@ -8709,8 +8708,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  			pfn, 1 << order, end_pfn);
>  #endif
>  		del_page_from_free_area(page, &zone->free_area[order]);
> -		for (i = 0; i < (1 << order); i++)
> -			SetPageReserved((page+i));
>  		pfn += (1 << order);
>  	}
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
