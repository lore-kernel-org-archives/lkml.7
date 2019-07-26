Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C7C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B721852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGZLJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:60500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfGZLJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9229AD12;
        Fri, 26 Jul 2019 11:09:39 +0000 (UTC)
Date:   Fri, 26 Jul 2019 13:09:37 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: Remove move_pfn_range()
Message-ID: <20190726110933.GA27545@linux>
References: <20190724142324.3686-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724142324.3686-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:23:24PM +0200, David Hildenbrand wrote:
> Let's remove this indirection. We need the zone in the caller either
> way, so let's just detect it there. Add some documentation for
> move_pfn_range_to_zone() instead.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index efa5283be36c..e7c3b219a305 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -715,7 +715,11 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  
>  	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
>  }
> -
> +/*
> + * Associate the pfn range with the given zone, initializing the memmaps
> + * and resizing the pgdat/zone data to span the added pages. After this
> + * call, all affected pages are PG_reserved.
> + */
>  void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
> @@ -804,20 +808,6 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>  	return default_zone_for_pfn(nid, start_pfn, nr_pages);
>  }
>  
> -/*
> - * Associates the given pfn range with the given node and the zone appropriate
> - * for the given online type.
> - */
> -static struct zone * __meminit move_pfn_range(int online_type, int nid,
> -		unsigned long start_pfn, unsigned long nr_pages)
> -{
> -	struct zone *zone;
> -
> -	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
> -	move_pfn_range_to_zone(zone, start_pfn, nr_pages, NULL);
> -	return zone;
> -}
> -
>  int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_type)
>  {
>  	unsigned long flags;
> @@ -840,7 +830,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
>  	put_device(&mem->dev);
>  
>  	/* associate pfn range with the zone */
> -	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
> +	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
> +	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
>  
>  	arg.start_pfn = pfn;
>  	arg.nr_pages = nr_pages;
> -- 
> 2.21.0
> 

-- 
Oscar Salvador
SUSE L3
