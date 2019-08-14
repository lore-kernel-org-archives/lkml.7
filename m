Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0844C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F50B2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565792364;
	bh=emIXgB/YQjr4v0TyXyM6lU3UDQbYO+4N+duYi+dfGA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x5g70x/kr0GDrGXwKm4dAsYpelrpE6JLYT0e/7xnn5QRzxOmqzVzqDrDGGdugLFIl
	 4ma966j1Y+BKQAGT3e0dBYcBQBLMqgCYQRxyssb/v0EJhm9x43ZyCWdyMTag5INT0J
	 DGzg76MpOI6/Jmt1ycNkAlUcKBSXw2I9W8IvJcs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfHNOTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:19:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfHNOTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:19:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DC33AF87;
        Wed, 14 Aug 2019 14:19:21 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:19:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 3/4] mm/memory_hotplug: Simplify online_pages_range()
Message-ID: <20190814141920.GB17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:57:00, David Hildenbrand wrote:
> move_pfn_range_to_zone() will set all pages to PG_reserved via
> memmap_init_zone(). The only way a page could no longer be reserved
> would be if a MEM_GOING_ONLINE notifier would clear PG_reserved - which
> is not done (the online_page callback is used for that purpose by
> e.g., Hyper-V instead). walk_system_ram_range() will never call
> online_pages_range() with duplicate PFNs, so drop the PageReserved() check.
> 
> Simplify the handling, as online_pages always corresponds to nr_pages.
> There is no need for online_pages_blocks() anymore.

This would be easier to review if split up into two patches. One that
only performs cleanup without any other changes and the PageReserved
check. I like the check going away and we should get rid of the
dependency on the Reserved bit completely.

Other than that I find the start_pfn and pfn being used both for
iteration each a different way really confusing and I cannot convince
myself it is even correct because I didn't bother to look deeper as
I simply think that the order manipulation from the previous is just
making things worse at this moment. If the problem is even real then it
can be done on top instead with some real example of the memory layout
that breaks.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2abd938c8c45..87f85597a19e 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -632,37 +632,31 @@ static void generic_online_page(struct page *page, unsigned int order)
>  #endif
>  }
>  
> -static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> +static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> +			void *arg)
>  {
> -	unsigned long end = start + nr_pages;
> -	int order, onlined_pages = 0;
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn;
> +	int order;
>  
> -	while (start < end) {
> -		order = min(MAX_ORDER - 1,
> -			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> +	/*
> +	 * Online the pages. The callback might decide to keep some pages
> +	 * PG_reserved (to add them to the buddy later), but we still account
> +	 * them as being online/belonging to this zone ("present").
> +	 */
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
> +		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
>  		/* make sure the PFN is aligned and we don't exceed the range */
> -		while (!IS_ALIGNED(start, 1ul << order) ||
> -		       (1ul << order) > end - start)
> +		while (!IS_ALIGNED(start_pfn, 1ul << order) ||
> +		       (1ul << order) > end_pfn - pfn)
>  			order--;
> -		(*online_page_callback)(pfn_to_page(start), order);
> -
> -		onlined_pages += (1UL << order);
> -		start += (1UL << order);
> +		(*online_page_callback)(pfn_to_page(pfn), order);
>  	}
> -	return onlined_pages;
> -}
> -
> -static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> -			void *arg)
> -{
> -	unsigned long onlined_pages = *(unsigned long *)arg;
> -
> -	if (PageReserved(pfn_to_page(start_pfn)))
> -		onlined_pages += online_pages_blocks(start_pfn, nr_pages);
>  
> -	online_mem_sections(start_pfn, start_pfn + nr_pages);
> +	/* mark all involved sections as online */
> +	online_mem_sections(start_pfn, end_pfn);
>  
> -	*(unsigned long *)arg = onlined_pages;
> +	*(unsigned long *)arg += nr_pages;
>  	return 0;
>  }
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
