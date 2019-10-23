Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078E1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F7F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571838509;
	bh=vCfuzu7w9W+oICcIz9THHrwdCbpNpa+8+qzj4ppcLrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tuQsDgBMoVIs1BvQHtRR41dLm2HXo9QAnk6jOtgcnuA79JhRyoJ8NQ7UTKgXKS5ay
	 LjP4yUkdc14qBD0bf/ZQFv+HqSHeRS8Si9W078vQRw2vaTzg0Gv4giV234J1PbinnP
	 /oNuxmipyw6i/WC0aBsF45HHAlgCGRCE3jl6nVFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406126AbfJWNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405869AbfJWNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:48:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49913B239;
        Wed, 23 Oct 2019 13:48:26 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:48:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Message-ID: <20191023134824.GB17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:47:56, Johannes Weiner wrote:
> This function currently takes the node or lruvec size and subtracts
> the zones that are excluded by the classzone index of the
> allocation. It uses four different types of counters to do this.
> 
> Just add up the eligible zones.

The original intention was to optimize this for GFP_KERNEL like
allocations by reducing the number of zones to reduce. But considering
this is not called from hot paths I do agree that a simpler code is more
preferable.
 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1154b3a2b637..57f533b808f2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -351,32 +351,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
>  {
> -	unsigned long lru_size = 0;
> +	unsigned long size = 0;
>  	int zid;
>  
> -	if (!mem_cgroup_disabled()) {
> -		for (zid = 0; zid < MAX_NR_ZONES; zid++)
> -			lru_size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> -	} else
> -		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
> -
> -	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> +	for (zid = 0; zid <= zone_idx; zid++) {
>  		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> -		unsigned long size;
>  
>  		if (!managed_zone(zone))
>  			continue;
>  
>  		if (!mem_cgroup_disabled())
> -			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> +			size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>  		else
> -			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -				       NR_ZONE_LRU_BASE + lru);
> -		lru_size -= min(size, lru_size);
> +			size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>  	}
> -
> -	return lru_size;
> -
> +	return size;
>  }
>  
>  /*
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
