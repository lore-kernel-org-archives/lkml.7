Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0420FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2420835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfDQLxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:53:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfDQLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:53:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 478D8AFFB;
        Wed, 17 Apr 2019 11:53:00 +0000 (UTC)
Message-ID: <1555501962.3139.10.camel@suse.de>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: Release memory resource after
 arch_remove_memory()
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Apr 2019 13:52:42 +0200
In-Reply-To: <20190409100148.24703-2-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
         <20190409100148.24703-2-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 12:01 +0200, David Hildenbrand wrote:
> __add_pages() doesn't add the memory resource, so __remove_pages()
> shouldn't remove it. Let's factor it out. Especially as it is a
> special
> case for memory used as system memory, added via add_memory() and
> friends.

I would call the special case the other way, aka: zone_device hooking
into hotplug path.

> 
> We now remove the resource after removing the sections instead of
> doing
> it the other way around. I don't think this change is problematic.
> 
> add_memory()
> 	register memory resource
> 	arch_add_memory()
> 
> remove_memory
> 	arch_remove_memory()
> 	release memory resource
> 
> While at it, explain why we ignore errors and that it only happeny if
> we remove memory in a different granularity as we added it.

In the future we may want to allow drivers to hook directly into
arch_add_memory()/arch_remove_memory(), and this will lead to different
granularity in hot_add/hot_remove operations. 

At least that was one of the conclusions I drew from the last vmemmap-
patchset.
So, we will have to see how we can handle those kind of errors.

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Besides what Andrew pointed out about the types of start,size, I do not
see anything wrong:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4970ff658055..696ed7ee5e28 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -562,20 +562,6 @@ int __remove_pages(struct zone *zone, unsigned
> long phys_start_pfn,
>  	if (is_dev_zone(zone)) {
>  		if (altmap)
>  			map_offset = vmem_altmap_offset(altmap);
> -	} else {
> -		resource_size_t start, size;
> -
> -		start = phys_start_pfn << PAGE_SHIFT;
> -		size = nr_pages * PAGE_SIZE;
> -
> -		ret = release_mem_region_adjustable(&iomem_resource,
> start,
> -					size);
> -		if (ret) {
> -			resource_size_t endres = start + size - 1;
> -
> -			pr_warn("Unable to release resource <%pa-
> %pa> (%d)\n",
> -					&start, &endres, ret);
> -		}
>  	}
>  
>  	clear_zone_contiguous(zone);
> @@ -1820,6 +1806,25 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> +static void __release_memory_resource(u64 start, u64 size)
> +{
> +	int ret;
> +
> +	/*
> +	 * When removing memory in the same granularity as it was
> added,
> +	 * this function never fails. It might only fail if
> resources
> +	 * have to be adjusted or split. We'll ignore the error, as
> +	 * removing of memory cannot fail.
> +	 */
> +	ret = release_mem_region_adjustable(&iomem_resource, start,
> size);
> +	if (ret) {
> +		resource_size_t endres = start + size - 1;
> +
> +		pr_warn("Unable to release resource <%pa-%pa>
> (%d)\n",
> +			&start, &endres, ret);
> +	}
> +}
> +
>  /**
>   * remove_memory
>   * @nid: the node ID
> @@ -1854,6 +1859,7 @@ void __ref __remove_memory(int nid, u64 start,
> u64 size)
>  	memblock_remove(start, size);
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
>  
-- 
Oscar Salvador
SUSE L3
