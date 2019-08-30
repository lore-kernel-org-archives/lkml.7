Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE9A21721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567144175;
	bh=yYODkBTXKNyWYokAf9LiJ+mP/dtDhNaR7mR+7vs2ov8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j9Nbs+tALcHj1tGBx4YmVjcERMBTXdDhT3GSv8tXaU2VBbzU4fEDBQeXrjHKwzauD
	 w01Suf42vZP86AqBn6otsbWw95VuVeJp2L0Z87jfZUakYdioe/OP7xvO6pjhDiMa9l
	 gEbS2EqXZF/gN+cykg/JsBwHQyPDlwb9HacgkSIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH3Ftf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfH3Ftf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:49:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65AC2B671;
        Fri, 30 Aug 2019 05:49:33 +0000 (UTC)
Date:   Fri, 30 Aug 2019 07:49:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix percpu vmstats and vmevents flush
Message-ID: <20190830054931.GN28313@dhcp22.suse.cz>
References: <20190829203110.129263-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829203110.129263-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-08-19 13:31:10, Shakeel Butt wrote:
> Instead of using raw_cpu_read() use per_cpu() to read the actual data of
> the corresponding cpu otherwise we will be reading the data of the
> current cpu for the number of online CPUs.
> 
> Fixes: bb65f89b7d3d ("mm: memcontrol: flush percpu vmevents before releasing memcg")
> Fixes: c350a99ea2b1 ("mm: memcontrol: flush percpu vmstats before releasing memcg")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>

Ups, missed that when reviewing. Sorry about that.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> Note: The buggy patches were marked for stable therefore adding Cc to
> stable.
> 
>  mm/memcontrol.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 26e2999af608..f4e60ee8b845 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3271,7 +3271,7 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
>  
>  	for_each_online_cpu(cpu)
>  		for (i = 0; i < MEMCG_NR_STAT; i++)
> -			stat[i] += raw_cpu_read(memcg->vmstats_percpu->stat[i]);
> +			stat[i] += per_cpu(memcg->vmstats_percpu->stat[i], cpu);
>  
>  	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  		for (i = 0; i < MEMCG_NR_STAT; i++)
> @@ -3286,8 +3286,8 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
>  
>  		for_each_online_cpu(cpu)
>  			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -				stat[i] += raw_cpu_read(
> -					pn->lruvec_stat_cpu->count[i]);
> +				stat[i] += per_cpu(
> +					pn->lruvec_stat_cpu->count[i], cpu);
>  
>  		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
>  			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> @@ -3306,8 +3306,8 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
>  
>  	for_each_online_cpu(cpu)
>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -			events[i] += raw_cpu_read(
> -				memcg->vmstats_percpu->events[i]);
> +			events[i] += per_cpu(memcg->vmstats_percpu->events[i],
> +					     cpu);
>  
>  	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 

-- 
Michal Hocko
SUSE Labs
