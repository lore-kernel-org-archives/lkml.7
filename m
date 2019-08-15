Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB84C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22B72084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565858140;
	bh=754ef3+byynvZQZ8Pv24KNLNkDNNTPOU22Tr2asgScE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pl3R9wrr66zzqOW0UWXa0tDg1/k0RsjgXiOsVVxfhLe3OvkmczZXPZdUwB4M97Tpf
	 GTmG3bSp0PjTZDlHEMtWxn3YQuXG8K/xSF9fOp6FQaABH9FYTinp9EO8Xh16tQ6oE0
	 dEOYC/q6sd1XKMB8ox3BhJvJUnrbHYyqavzva2so=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfHOIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:35:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730409AbfHOIfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:35:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EB69B601;
        Thu, 15 Aug 2019 08:35:37 +0000 (UTC)
Date:   Thu, 15 Aug 2019 10:35:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: flush percpu slab vmstats on kmem
 offlining
Message-ID: <20190815083536.GD9477@dhcp22.suse.cz>
References: <20190812222911.2364802-1-guro@fb.com>
 <20190812222911.2364802-3-guro@fb.com>
 <20190814113242.GV17933@dhcp22.suse.cz>
 <20190814215408.GA5584@tower.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814215408.GA5584@tower.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 21:54:12, Roman Gushchin wrote:
> On Wed, Aug 14, 2019 at 01:32:42PM +0200, Michal Hocko wrote:
> > On Mon 12-08-19 15:29:11, Roman Gushchin wrote:
> > > I've noticed that the "slab" value in memory.stat is sometimes 0,
> > > even if some children memory cgroups have a non-zero "slab" value.
> > > The following investigation showed that this is the result
> > > of the kmem_cache reparenting in combination with the per-cpu
> > > batching of slab vmstats.
> > > 
> > > At the offlining some vmstat value may leave in the percpu cache,
> > > not being propagated upwards by the cgroup hierarchy. It means
> > > that stats on ancestor levels are lower than actual. Later when
> > > slab pages are released, the precise number of pages is substracted
> > > on the parent level, making the value negative. We don't show negative
> > > values, 0 is printed instead.
> > 
> > So the difference with other counters is that slab ones are reparented
> > and that's why we have treat them specially? I guess that is what the
> > comment in the code suggest but being explicit in the changelog would be
> > nice.
> 
> Right. And I believe the list can be extended further. Objects which
> are often outliving the origin memory cgroup (e.g. pagecache pages)
> are pinning dead cgroups, so it will be cool to reparent them all.
> 
> > 
> > [...]
> > > -static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
> > > +static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg, bool slab_only)
> > >  {
> > >  	unsigned long stat[MEMCG_NR_STAT];
> > >  	struct mem_cgroup *mi;
> > >  	int node, cpu, i;
> > > +	int min_idx, max_idx;
> > >  
> > > -	for (i = 0; i < MEMCG_NR_STAT; i++)
> > > +	if (slab_only) {
> > > +		min_idx = NR_SLAB_RECLAIMABLE;
> > > +		max_idx = NR_SLAB_UNRECLAIMABLE;
> > > +	} else {
> > > +		min_idx = 0;
> > > +		max_idx = MEMCG_NR_STAT;
> > > +	}
> > 
> > This is just ugly has hell! I really detest how this implicitly makes
> > counters value very special without any note in the node_stat_item
> > definition. Is it such a big deal to have a per counter flush and do
> > the loop over all counters resp. specific counters around it so much
> > worse? This should be really a slow path to safe few instructions or
> > cache misses, no?
> 
> I believe that it is a big deal, because it's
> NR_VMSTAT_ITEMS * all memory cgroups * online cpus * numa nodes.

I am not sure I follow. I just meant to remove all for (i = 0; i < MEMCG_NR_STAT; i++)
from flushing and do that loop around the flushing function. That would
mean that the NR_SLAB_$FOO wouldn't have to play tricks and simply call
the flushing for the two counters.

> If the goal is to merge it with cpu hotplug code, I'd think about passing
> cpumask to it, and do the opposite. Also I'm not sure I understand
> why reordering loops will make it less ugly.

And adding a cpu/nodemasks would just work with that as well, right.

> 
> But you're right, a comment nearby NR_SLAB_(UN)RECLAIMABLE definition
> is totaly worth it. How about something like:
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8b5f758942a2..231bcbe5dcc6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -215,8 +215,9 @@ enum node_stat_item {
>         NR_INACTIVE_FILE,       /*  "     "     "   "       "         */
>         NR_ACTIVE_FILE,         /*  "     "     "   "       "         */
>         NR_UNEVICTABLE,         /*  "     "     "   "       "         */
> -       NR_SLAB_RECLAIMABLE,
> -       NR_SLAB_UNRECLAIMABLE,
> +       NR_SLAB_RECLAIMABLE,    /* Please, do not reorder this item */
> +       NR_SLAB_UNRECLAIMABLE,  /* and this one without looking at
> +                                * memcg_flush_percpu_vmstats() first. */
>         NR_ISOLATED_ANON,       /* Temporary isolated pages from anon lru */
>         NR_ISOLATED_FILE,       /* Temporary isolated pages from file lru */
>         WORKINGSET_NODES,

Thanks, that is an improvement.
-- 
Michal Hocko
SUSE Labs
