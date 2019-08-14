Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F39214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565782393;
	bh=nrOx7N8l+lMWtRLnzPLo+UJf0l2BDcnezae0I8VabLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oeNN1hioDhoL/3YsbVWIbnh22Fl5iBRDoYKSu3lOs5Bd8CiOcGwO+MAMR+NsgpF3j
	 uvVpy2F+X4xodKd7Z/JjtNjENBB9KfEHhWLoe2aUnK5Fkma2kD6FpIURbMYydWMv7C
	 sxhvStMXNQQyySl9zi2+HqiVpo7LNFwMuThzeu0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfHNLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:33:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbfHNLdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:33:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3579ADEF;
        Wed, 14 Aug 2019 11:33:10 +0000 (UTC)
Date:   Wed, 14 Aug 2019 13:33:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: flush percpu vmevents before releasing
 memcg
Message-ID: <20190814113310.GW17933@dhcp22.suse.cz>
References: <20190812233754.2570543-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812233754.2570543-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 16:37:54, Roman Gushchin wrote:
> Similar to vmstats, percpu caching of local vmevents leads to an
> accumulation of errors on non-leaf levels. This happens because
> some leftovers may remain in percpu caches, so that they are
> never propagated up by the cgroup tree and just disappear into
> nonexistence with on releasing of the memory cgroup.
> 
> To fix this issue let's accumulate and propagate percpu vmevents
> values before releasing the memory cgroup similar to what we're
> doing with vmstats.
> 
> Since on cpu hotplug we do flush percpu vmstats anyway, we can
> iterate only over online cpus.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6d2427abcc0c..249187907339 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3459,6 +3459,25 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg, bool slab_only)
>  	}
>  }
>  
> +static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
> +{
> +	unsigned long events[NR_VM_EVENT_ITEMS];
> +	struct mem_cgroup *mi;
> +	int cpu, i;
> +
> +	for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> +		events[i] = 0;
> +
> +	for_each_online_cpu(cpu)
> +		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> +			events[i] += raw_cpu_read(
> +				memcg->vmstats_percpu->events[i]);
> +
> +	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> +		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> +			atomic_long_add(events[i], &mi->vmevents[i]);
> +}
> +
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  {
>  	struct cgroup_subsys_state *css;
> @@ -4860,10 +4879,11 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  	int node;
>  
>  	/*
> -	 * Flush percpu vmstats to guarantee the value correctness
> +	 * Flush percpu vmstats and vmevents to guarantee the value correctness
>  	 * on parent's and all ancestor levels.
>  	 */
>  	memcg_flush_percpu_vmstats(memcg, false);
> +	memcg_flush_percpu_vmevents(memcg);
>  	for_each_node(node)
>  		free_mem_cgroup_per_node_info(memcg, node);
>  	free_percpu(memcg->vmstats_percpu);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
