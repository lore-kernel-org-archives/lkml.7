Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6504C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35E9204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566902597;
	bh=DgzBwafkcWP7vXvi0ntkF77ZVB19ePV2F8i3vcXt+uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IGJ0zNbXAoKBait0OwzLPqd8b1YVOirkPhPTXWcXkwEfftrQk6eZ11E/7kH+DyOyj
	 0pOx+j43+Fqg3IWT/06DwmSf9l/2p+rTeAvhcOINFOKdCJUgFGujy1li5AipslrYQ4
	 B3l4oQiuWi10OVybVLEOUPYGBV0zudx06bjBLIQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfH0KnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfH0KnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C68BAFD4;
        Tue, 27 Aug 2019 10:43:15 +0000 (UTC)
Date:   Tue, 27 Aug 2019 12:43:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Adric Blake <promarbler14@gmail.com>, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, hannes@cmpxchg.org,
        daniel.m.jordan@oracle.com, laoar.shao@gmail.com,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
Message-ID: <20190827104313.GW7538@dhcp22.suse.cz>
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com>
 <20190826105521.GF7538@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826105521.GF7538@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are no objection to the patch I will post it as a standalong
one.

On Mon 26-08-19 12:55:21, Michal Hocko wrote:
> From 59d128214a62bf2d83c2a2a9cde887b4817275e7 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 26 Aug 2019 12:43:15 +0200
> Subject: [PATCH] mm, memcg: do not set reclaim_state on soft limit reclaim
> 
> Adric Blake has noticed the following warning:
> [38491.963105] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:245 set_task_reclaim_state+0x1e/0x40
> [...]
> [38491.963239] Call Trace:
> [38491.963246]  mem_cgroup_shrink_node+0x9b/0x1d0
> [38491.963250]  mem_cgroup_soft_limit_reclaim+0x10c/0x3a0
> [38491.963254]  balance_pgdat+0x276/0x540
> [38491.963258]  kswapd+0x200/0x3f0
> [38491.963261]  ? wait_woken+0x80/0x80
> [38491.963265]  kthread+0xfd/0x130
> [38491.963267]  ? balance_pgdat+0x540/0x540
> [38491.963269]  ? kthread_park+0x80/0x80
> [38491.963273]  ret_from_fork+0x35/0x40
> [38491.963276] ---[ end trace 727343df67b2398a ]---
> 
> which tells us that soft limit reclaim is about to overwrite the
> reclaim_state configured up in the call chain (kswapd in this case but
> the direct reclaim is equally possible). This means that reclaim stats
> would get misleading once the soft reclaim returns and another reclaim
> is done.
> 
> Fix the warning by dropping set_task_reclaim_state from the soft reclaim
> which is always called with reclaim_state set up.
> 
> Reported-by: Adric Blake <promarbler14@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmscan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c77d1e3761a7..a6c5d0b28321 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3220,6 +3220,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  
>  #ifdef CONFIG_MEMCG
>  
> +/* Only used by soft limit reclaim. Do not reuse for anything else. */
>  unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  						gfp_t gfp_mask, bool noswap,
>  						pg_data_t *pgdat,
> @@ -3235,7 +3236,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  	};
>  	unsigned long lru_pages;
>  
> -	set_task_reclaim_state(current, &sc.reclaim_state);
> +	WARN_ON_ONCE(!current->reclaim_state);
> +
>  	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
>  			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
>  
> @@ -3253,7 +3255,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  
>  	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
>  
> -	set_task_reclaim_state(current, NULL);
>  	*nr_scanned = sc.nr_scanned;
>  
>  	return sc.nr_reclaimed;
> -- 
> 2.20.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
