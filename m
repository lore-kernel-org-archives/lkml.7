Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14C21920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571840523;
	bh=CnpNR2AYuboEzEKcyCtXQfUcmMIPaafmb1dSdSOAzow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pNjTjhiryuenKRL561JJx8aeWdmNLhPILoZo2CTSpv5R/Cqk55otvfS9KzWRXmtIE
	 vVBjg8kEju1cR7h5ZQ+4uQe1vMuGYrfr8DsqVIJ0N/YUd1LJ2iuYlfNoGoBP+9DKqN
	 YrKepOzVXeFcaBBviW6BjBRilzj0kr6XRACAOx8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392182AbfJWOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:22:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJWOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC62FAFE1;
        Wed, 23 Oct 2019 14:21:59 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:21:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 6/8] mm: vmscan: turn shrink_node_memcg() into
 shrink_lruvec()
Message-ID: <20191023142158.GG17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-7-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:48:01, Johannes Weiner wrote:
> A lruvec holds LRU pages owned by a certain NUMA node and cgroup.
> Instead of awkwardly passing around a combination of a pgdat and a
> memcg pointer, pass down the lruvec as soon as we can look it up.
> 
> Nested callers that need to access node or cgroup properties can look
> them them up if necessary, but there are only a few cases.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 235d1fc72311..db073b40c432 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2280,9 +2280,10 @@ enum scan_balance {
>   * nr[0] = anon inactive pages to scan; nr[1] = anon active pages to scan
>   * nr[2] = file inactive pages to scan; nr[3] = file active pages to scan
>   */
> -static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
> -			   struct scan_control *sc, unsigned long *nr)
> +static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> +			   unsigned long *nr)
>  {
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>  	int swappiness = mem_cgroup_swappiness(memcg);
>  	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>  	u64 fraction[2];
> @@ -2530,13 +2531,8 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  	}
>  }
>  
> -/*
> - * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
> - */
> -static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
> -			      struct scan_control *sc)
> +static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
> -	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	unsigned long nr[NR_LRU_LISTS];
>  	unsigned long targets[NR_LRU_LISTS];
>  	unsigned long nr_to_scan;
> @@ -2546,7 +2542,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>  	struct blk_plug plug;
>  	bool scan_adjusted;
>  
> -	get_scan_count(lruvec, memcg, sc, nr);
> +	get_scan_count(lruvec, sc, nr);
>  
>  	/* Record the original scan target for proportional adjustments later */
>  	memcpy(targets, nr, sizeof(nr));
> @@ -2741,6 +2737,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  
>  	memcg = mem_cgroup_iter(root, NULL, NULL);
>  	do {
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  		unsigned long reclaimed;
>  		unsigned long scanned;
>  
> @@ -2777,7 +2774,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  
>  		reclaimed = sc->nr_reclaimed;
>  		scanned = sc->nr_scanned;
> -		shrink_node_memcg(pgdat, memcg, sc);
> +
> +		shrink_lruvec(lruvec, sc);
>  
>  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>  			    sc->priority);
> @@ -3281,6 +3279,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  						pg_data_t *pgdat,
>  						unsigned long *nr_scanned)
>  {
> +	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	struct scan_control sc = {
>  		.nr_to_reclaim = SWAP_CLUSTER_MAX,
>  		.target_mem_cgroup = memcg,
> @@ -3307,7 +3306,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  	 * will pick up pages from other mem cgroup's as well. We hack
>  	 * the priority and make it zero.
>  	 */
> -	shrink_node_memcg(pgdat, memcg, &sc);
> +	shrink_lruvec(lruvec, &sc);
>  
>  	trace_mm_vmscan_memcg_softlimit_reclaim_end(
>  					cgroup_ino(memcg->css.cgroup),
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
