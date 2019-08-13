Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA7C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCBD20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565683030;
	bh=CU7+0tpIXR//vhJ0kdSzFDCu6DcGx9rZ0rdX0SDIKiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YUp35FEsjaj7sBL3DfFd1vVrf4cVnpOQno1xTCZwyZ9Axhb+aQ0gJqsgYl/JUFIbM
	 qS0ej9IVKrI2QTKJMz67aYrgBTXJseZIk2Cn3GxldIL+hZBJDtWKFguAh3P9sagO2D
	 128JO8nmYxUkzqwEwFrekvSOVKAJf7j4NttjKxS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfHMH5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfHMH5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:57:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34D64AD3A;
        Tue, 13 Aug 2019 07:57:08 +0000 (UTC)
Date:   Tue, 13 Aug 2019 09:57:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: prevent memory leak when reuse pgdat
Message-ID: <20190813075707.GA17933@dhcp22.suse.cz>
References: <20190813020608.10194-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813020608.10194-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-08-19 10:06:08, Wei Yang wrote:
> When offline a node in try_offline_node, pgdat is not released. So that
> pgdat could be reused in hotadd_new_pgdat. While we re-allocate
> pgdat->per_cpu_nodestats if this pgdat is reused.
> 
> This patch prevents the memory leak by just allocate per_cpu_nodestats
> when it is a new pgdat.

Yes this makes sense! I was slightly confused why we haven't initialized
the allocated pcp area because __alloc_percpu does GFP_KERNEL without
__GFP_ZERO but then I've just found out that the zeroying is done
regardless. A bit unexpected...

> NOTE: This is not tested since I didn't manage to create a case to
> offline a whole node. If my analysis is not correct, please let me know.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memory_hotplug.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c73f09913165..efaf9e6f580a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -933,8 +933,11 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>  		if (!pgdat)
>  			return NULL;
>  
> +		pgdat->per_cpu_nodestats =
> +			alloc_percpu(struct per_cpu_nodestat);
>  		arch_refresh_nodedata(nid, pgdat);
>  	} else {
> +		int cpu;
>  		/*
>  		 * Reset the nr_zones, order and classzone_idx before reuse.
>  		 * Note that kswapd will init kswapd_classzone_idx properly
> @@ -943,6 +946,12 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>  		pgdat->nr_zones = 0;
>  		pgdat->kswapd_order = 0;
>  		pgdat->kswapd_classzone_idx = 0;
> +		for_each_online_cpu(cpu) {
> +			struct per_cpu_nodestat *p;
> +
> +			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> +			memset(p, 0, sizeof(*p));
> +		}
>  	}
>  
>  	/* we can use NODE_DATA(nid) from here */
> @@ -952,7 +961,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
>  	free_area_init_core_hotplug(nid);
> -	pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
>  
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
