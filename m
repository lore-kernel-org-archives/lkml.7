Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D12087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556540542;
	bh=4HT+F/kTs3i1fGSX7dM4DpyUfzQn3WDwCqGA99HMRVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y44/iyaxmGntr8Nh0O2rkPczntS8nCaDqwPqA2MWyXX75Wc6xRsIuHUcatRy/D1+v
	 Vs9UHxtCK2Xybz+i7lfFUQq0EqHaHfrf+t1os85GJsZKA/EKZTBxQr1ITqFpxfyXV0
	 uKDe5trANb8n9IUxwJpaDfgs8BTQEjnw/vSUqq4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfD2MWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727710AbfD2MWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:22:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7349CAE1B;
        Mon, 29 Apr 2019 12:22:18 +0000 (UTC)
Date:   Mon, 29 Apr 2019 08:22:14 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
Message-ID: <20190429122214.GK21837@dhcp22.suse.cz>
References: <20190428235613.166330-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428235613.166330-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28-04-19 16:56:13, Shakeel Butt wrote:
> The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
> OOM killer will not be triggered and indeed the page alloc does not
> invoke OOM killer for such allocations. However we do trigger memcg
> OOM killer for __GFP_RETRY_MAYFAIL. Fix that.

An example of __GFP_RETRY_MAYFAIL memcg OOM report would be nice. I
thought we haven't been using that flag for memcg allocations yet.
But this is definitely good to have addressed.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2713b45ec3f0..99eca724ed3b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	unsigned long nr_reclaimed;
>  	bool may_swap = true;
>  	bool drained = false;
> -	bool oomed = false;
>  	enum oom_status oom_status;
>  
>  	if (mem_cgroup_is_root(memcg))
> @@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (nr_retries--)
>  		goto retry;
>  
> -	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
> +	if (gfp_mask & __GFP_RETRY_MAYFAIL)
>  		goto nomem;
>  
>  	if (gfp_mask & __GFP_NOFAIL)
> @@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	switch (oom_status) {
>  	case OOM_SUCCESS:
>  		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> -		oomed = true;
>  		goto retry;
>  	case OOM_FAILED:
>  		goto force;
> -- 
> 2.21.0.593.g511ec345e18-goog
> 

-- 
Michal Hocko
SUSE Labs
