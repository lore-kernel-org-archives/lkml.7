Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7002077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552558760;
	bh=wT13TxYGvRYjG1lh0gnDBzbPeSjddt7G10I9XvVEyYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lltVj8m31gNgtPmavKAHOnGeOl3thd0MZVRMnguBk30Ncvz67QEMtPfDJNT8Y+d09
	 Z0UC9QElB4vIlHxoCiaRsABQT0aVxzVmuZegpdfAmKNDDUbi+6t/DFLpkrumYIhv7t
	 RP6KgIoSTEBHS3k30HyYCC2cPeyCOMPiTf53DpOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCNKTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:19:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfCNKTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:19:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A042AFFB;
        Thu, 14 Mar 2019 10:19:16 +0000 (UTC)
Date:   Thu, 14 Mar 2019 11:19:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     vbabka@suse.cz, jrdr.linux@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] mm: vmscan: drop may_writepage and classzone_idx from
 direct reclaim begin template
Message-ID: <20190314101915.GI7473@dhcp22.suse.cz>
References: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
 <1551421452-5385-2-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551421452-5385-2-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-03-19 14:24:12, Yafang Shao wrote:
> There are three tracepoints using this template, which are
> mm_vmscan_direct_reclaim_begin,
> mm_vmscan_memcg_reclaim_begin,
> mm_vmscan_memcg_softlimit_reclaim_begin.
> 
> Regarding mm_vmscan_direct_reclaim_begin,
> sc.may_writepage is !laptop_mode, that's a static setting, and
> reclaim_idx is derived from gfp_mask which is already show in this
> tracepoint.
> 
> Regarding mm_vmscan_memcg_reclaim_begin,
> may_writepage is !laptop_mode too, and reclaim_idx is (MAX_NR_ZONES-1),
> which are both static value.
> 
> mm_vmscan_memcg_softlimit_reclaim_begin is the same with
> mm_vmscan_memcg_reclaim_begin.
> 
> So we can drop them all.

I agree. Although classzone_idx is PITA to calculate nothing really
prevents us to have a tool to do that. may_writepage is not all that
useful anymore.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

From a quick glance this looks ok. I haven't really checked deeply or
tried to compile it but the change makes sense.

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/trace/events/vmscan.h | 26 ++++++++++----------------
>  mm/vmscan.c                   | 14 +++-----------
>  2 files changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a1cb913..153d90c 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -105,51 +105,45 @@
>  
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  
> -	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +	TP_PROTO(int order, gfp_t gfp_flags),
>  
> -	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx),
> +	TP_ARGS(order, gfp_flags),
>  
>  	TP_STRUCT__entry(
>  		__field(	int,	order		)
> -		__field(	int,	may_writepage	)
>  		__field(	gfp_t,	gfp_flags	)
> -		__field(	int,	classzone_idx	)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->order		= order;
> -		__entry->may_writepage	= may_writepage;
>  		__entry->gfp_flags	= gfp_flags;
> -		__entry->classzone_idx	= classzone_idx;
>  	),
>  
> -	TP_printk("order=%d may_writepage=%d gfp_flags=%s classzone_idx=%d",
> +	TP_printk("order=%d gfp_flags=%s",
>  		__entry->order,
> -		__entry->may_writepage,
> -		show_gfp_flags(__entry->gfp_flags),
> -		__entry->classzone_idx)
> +		show_gfp_flags(__entry->gfp_flags))
>  );
>  
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
>  
> -	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +	TP_PROTO(int order, gfp_t gfp_flags),
>  
> -	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +	TP_ARGS(order, gfp_flags)
>  );
>  
>  #ifdef CONFIG_MEMCG
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
>  
> -	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +	TP_PROTO(int order, gfp_t gfp_flags),
>  
> -	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +	TP_ARGS(order, gfp_flags)
>  );
>  
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
>  
> -	TP_PROTO(int order, int may_writepage, gfp_t gfp_flags, int classzone_idx),
> +	TP_PROTO(int order, gfp_t gfp_flags),
>  
> -	TP_ARGS(order, may_writepage, gfp_flags, classzone_idx)
> +	TP_ARGS(order, gfp_flags)
>  );
>  #endif /* CONFIG_MEMCG */
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ac4806f..cdc0305 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3304,10 +3304,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
>  		return 1;
>  
> -	trace_mm_vmscan_direct_reclaim_begin(order,
> -				sc.may_writepage,
> -				sc.gfp_mask,
> -				sc.reclaim_idx);
> +	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>  
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
> @@ -3338,9 +3335,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
>  
>  	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
> -						      sc.may_writepage,
> -						      sc.gfp_mask,
> -						      sc.reclaim_idx);
> +						      sc.gfp_mask);
>  
>  	/*
>  	 * NOTE: Although we can get the priority field, using it
> @@ -3389,10 +3384,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  
>  	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
>  
> -	trace_mm_vmscan_memcg_reclaim_begin(0,
> -					    sc.may_writepage,
> -					    sc.gfp_mask,
> -					    sc.reclaim_idx);
> +	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
>  
>  	psi_memstall_enter(&pflags);
>  	noreclaim_flag = memalloc_noreclaim_save();
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
