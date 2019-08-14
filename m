Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB5C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269F216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565798703;
	bh=aj8zMwQBj3aBE59hJyKXruEZDOwZMHzGHgnv1cUF8sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sYzoy2qrCStKeYpvu4LDo/UwvaJ8N5RzFCCZG5ZBsCy9f74kTX6jr2YiwuiD8jS+I
	 Bz3NwuHB0eMbUsv7ezarFWbWID383ksTdnNM9ZBDQLA9+pUR5MDxcceKbg+HfBL1SV
	 oI+xDNCtvA38DW4dr+MBvv9r6g/SJRXmwB6L6lXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfHNQFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:05:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfHNQFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:05:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01A52AB92;
        Wed, 14 Aug 2019 16:05:00 +0000 (UTC)
Date:   Wed, 14 Aug 2019 18:04:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/5] mm/memory_hotplug: Drop PageReserved() check in
 online_pages_range()
Message-ID: <20190814160458.GH17933@dhcp22.suse.cz>
References: <20190814154109.3448-1-david@redhat.com>
 <20190814154109.3448-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814154109.3448-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 17:41:06, David Hildenbrand wrote:
> move_pfn_range_to_zone() will set all pages to PG_reserved via
> memmap_init_zone(). The only way a page could no longer be reserved
> would be if a MEM_GOING_ONLINE notifier would clear PG_reserved - which
> is not done (the online_page callback is used for that purpose by
> e.g., Hyper-V instead). walk_system_ram_range() will never call
> online_pages_range() with duplicate PFNs, so drop the PageReserved() check.
> 
> This seems to be a leftover from ancient times where the memmap was
> initialized when adding memory and we wanted to check for already
> onlined memory.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks for spliting that up.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3706a137d880..10ad970f3f14 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -653,9 +653,7 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>  {
>  	unsigned long onlined_pages = *(unsigned long *)arg;
>  
> -	if (PageReserved(pfn_to_page(start_pfn)))
> -		onlined_pages += online_pages_blocks(start_pfn, nr_pages);
> -
> +	onlined_pages += online_pages_blocks(start_pfn, nr_pages);
>  	online_mem_sections(start_pfn, start_pfn + nr_pages);
>  
>  	*(unsigned long *)arg = onlined_pages;
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
