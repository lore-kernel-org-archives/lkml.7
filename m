Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15857217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556174293;
	bh=iwMJUFNVpk4z4+U9uUl4wvG0ZwnqSiD/EyFKjeHjPsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wepb9y5lr9q/8Rhcfj9ZN6Nu1QjO9dHIWTwkulNmYV1bEM0GNqeRVtAAWmaJPGXJn
	 HmQfvSf2Qm3n2ECr98pYoe2tdB6SEuprjKLXY0T2IpROJ5RSE1KDysuOwIqfB2LNw3
	 blUSUR4oknzC618osrK9HQjnUptFTTZ4DPV05k/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfDYGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:38:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729765AbfDYGiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:38:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F706AE5E;
        Thu, 25 Apr 2019 06:38:08 +0000 (UTC)
Date:   Thu, 25 Apr 2019 08:38:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Fan Du <fan.du@intel.com>
Cc:     akpm@linux-foundation.org, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Message-ID: <20190425063807.GK12751@dhcp22.suse.cz>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556155295-77723-6-git-send-email-fan.du@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 09:21:35, Fan Du wrote:
> On system with heterogeneous memory, reasonable fall back lists woul be:
> a. No fall back, stick to current running node.
> b. Fall back to other nodes of the same type or different type
>    e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3
> c. Fall back to other nodes of the same type only.
>    e.g. DRAM node 0 -> DRAM node 1
> 
> a. is already in place, previous patch implement b. providing way to
> satisfy memory request as best effort by default. And this patch of
> writing build c. to fallback to the same node type when user specify
> GFP_SAME_NODE_TYPE only.

So an immediate question which should be answered by this changelog. Who
is going to use the new gfp flag? Why cannot all allocations without an
explicit numa policy fallback to all existing nodes?
 
> Signed-off-by: Fan Du <fan.du@intel.com>
> ---
>  include/linux/gfp.h    |  7 +++++++
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 15 +++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index fdab7de..ca5fdfc 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -44,6 +44,8 @@
>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> +#define ___GFP_SAME_NODE_TYPE	0x1000000u
> +
>  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>  
>  /*
> @@ -215,6 +217,7 @@
>  
>  /* Disable lockdep for GFP context tracking */
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> +#define __GFP_SAME_NODE_TYPE ((__force gfp_t)___GFP_SAME_NODE_TYPE)
>  
>  /* Room for N __GFP_FOO bits */
>  #define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> @@ -301,6 +304,8 @@
>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
>  
> +#define GFP_SAME_NODE_TYPE (__GFP_SAME_NODE_TYPE)
> +
>  /* Convert GFP flags to their corresponding migrate type */
>  #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
>  #define GFP_MOVABLE_SHIFT 3
> @@ -438,6 +443,8 @@ static inline int gfp_zonelist(gfp_t flags)
>  #ifdef CONFIG_NUMA
>  	if (unlikely(flags & __GFP_THISNODE))
>  		return ZONELIST_NOFALLBACK;
> +	if (unlikely(flags & __GFP_SAME_NODE_TYPE))
> +		return ZONELIST_FALLBACK_SAME_TYPE;
>  #endif
>  	return ZONELIST_FALLBACK;
>  }
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8c37e1c..2f8603e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -583,6 +583,7 @@ static inline bool zone_intersects(struct zone *zone,
>  
>  enum {
>  	ZONELIST_FALLBACK,	/* zonelist with fallback */
> +	ZONELIST_FALLBACK_SAME_TYPE,	/* zonelist with fallback to the same type node */
>  #ifdef CONFIG_NUMA
>  	/*
>  	 * The NUMA zonelists are doubled because we need zonelists that
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a408a91..de797921 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5448,6 +5448,21 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
>  	}
>  	zonerefs->zone = NULL;
>  	zonerefs->zone_idx = 0;
> +
> +	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK_SAME_TYPE]._zonerefs;
> +
> +	for (i = 0; i < nr_nodes; i++) {
> +		int nr_zones;
> +
> +		pg_data_t *node = NODE_DATA(node_order[i]);
> +
> +		if (!is_node_same_type(node->node_id, pgdat->node_id))
> +			continue;
> +		nr_zones = build_zonerefs_node(node, zonerefs);
> +		zonerefs += nr_zones;
> +	}
> +	zonerefs->zone = NULL;
> +	zonerefs->zone_idx = 0;
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
