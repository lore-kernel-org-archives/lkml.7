Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4181621906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571840702;
	bh=iKfrHvDPGJjmgU12ECgdueMxOFlk15uQz9yI2YNB23s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pgLRnDBaP506yooStivknkeayTz4GxUEV/A880WaE9icUNcBHE9tix0nJtRYtBB6Q
	 ojkOr8RL3nfXYNuq3VGV6wqeXzkQ7B1uNmCJTLZW00FDSbvcnvaPKKVn3Rr5NzERJl
	 IuQJlS0K2L2y8VDsP+2YwAQ1KPE/ov0qixgYmUz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbfJWOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJWOZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:25:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6384FB422;
        Wed, 23 Oct 2019 14:24:38 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:24:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 7/8] mm: vmscan: split shrink_node() into node part and
 memcgs part
Message-ID: <20191023142437.GH17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-8-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-8-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:48:02, Johannes Weiner wrote:
> This function is getting long and unwieldy, split out the memcg bits.
> 
> The updated shrink_node() handles the generic (node) reclaim aspects:
>   - global vmpressure notifications
>   - writeback and congestion throttling
>   - reclaim/compaction management
>   - kswapd giving up on unreclaimable nodes
> 
> It then calls a new shrink_node_memcgs() which handles cgroup specifics:
>   - the cgroup tree traversal
>   - memory.low considerations
>   - per-cgroup slab shrinking callbacks
>   - per-cgroup vmpressure notifications
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index db073b40c432..65baa89740dd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2722,18 +2722,10 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>  		(memcg && memcg_congested(pgdat, memcg));
>  }
>  
> -static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  {
> -	struct reclaim_state *reclaim_state = current->reclaim_state;
>  	struct mem_cgroup *root = sc->target_mem_cgroup;
> -	unsigned long nr_reclaimed, nr_scanned;
> -	bool reclaimable = false;
>  	struct mem_cgroup *memcg;
> -again:
> -	memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -	nr_reclaimed = sc->nr_reclaimed;
> -	nr_scanned = sc->nr_scanned;
>  
>  	memcg = mem_cgroup_iter(root, NULL, NULL);
>  	do {
> @@ -2786,6 +2778,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			   sc->nr_reclaimed - reclaimed);
>  
>  	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> +}
> +
> +static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +	struct reclaim_state *reclaim_state = current->reclaim_state;
> +	struct mem_cgroup *root = sc->target_mem_cgroup;
> +	unsigned long nr_reclaimed, nr_scanned;
> +	bool reclaimable = false;
> +
> +again:
> +	memset(&sc->nr, 0, sizeof(sc->nr));
> +
> +	nr_reclaimed = sc->nr_reclaimed;
> +	nr_scanned = sc->nr_scanned;
> +
> +	shrink_node_memcgs(pgdat, sc);
>  
>  	if (reclaim_state) {
>  		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> @@ -2793,7 +2801,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	}
>  
>  	/* Record the subtree's reclaim efficiency */
> -	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +	vmpressure(sc->gfp_mask, root, true,
>  		   sc->nr_scanned - nr_scanned,
>  		   sc->nr_reclaimed - nr_reclaimed);
>  
> -- 
> 2.23.0
> 

-- 
Michal Hocko
SUSE Labs
