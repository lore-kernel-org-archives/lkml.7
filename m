Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50409C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D212084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDZOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfDZOEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:04:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37162AF3A;
        Fri, 26 Apr 2019 14:04:42 +0000 (UTC)
Date:   Fri, 26 Apr 2019 16:04:39 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] mm: Kill is_dev_zone() helper
Message-ID: <20190426140439.GC30513@linux>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:39:32AM -0700, Dan Williams wrote:
> Given there are no more usages of is_dev_zone() outside of 'ifdef
> CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/mmzone.h |   12 ------------
>  mm/page_alloc.c        |    2 +-
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b13f0cddf75e..3237c5e456df 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -855,18 +855,6 @@ static inline int local_memory_node(int node_id) { return node_id; };
>   */
>  #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
>  
> -#ifdef CONFIG_ZONE_DEVICE
> -static inline bool is_dev_zone(const struct zone *zone)
> -{
> -	return zone_idx(zone) == ZONE_DEVICE;
> -}
> -#else
> -static inline bool is_dev_zone(const struct zone *zone)
> -{
> -	return false;
> -}
> -#endif
> -
>  /*
>   * Returns true if a zone has pages managed by the buddy allocator.
>   * All the reclaim decisions have to use this function rather than
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c9ad28a78018..fd455bd742d5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5844,7 +5844,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	unsigned long start = jiffies;
>  	int nid = pgdat->node_id;
>  
> -	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
> +	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
>  		return;
>  
>  	/*
> 

-- 
Oscar Salvador
SUSE L3
