Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4F205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571660099;
	bh=gxe8amgA3j+2mXZNltCG2z8gwr3mIP2lfecaHEwAHQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HbJutOTR39cfT1ob2tbowTa860eQFwJt76Y7g8XoJefTnw6g+dihQt0OEtTK3rbhS
	 TdhgOrdVhSxNxls9FGROmfFnC3nbcmdA/yG9TTIyRKFgvwt2zODtpbms5WP5AXRUlf
	 /siH1CfSlXOuTGYyq2KbEjHRFNkODR7MeMcdJxTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfJUMO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:32868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbfJUMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C924ACB7;
        Mon, 21 Oct 2019 12:14:54 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:14:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v1] memcg: add memcg lru for page reclaiming
Message-ID: <20191021121453.GK9379@dhcp22.suse.cz>
References: <20191021115654.14740-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021115654.14740-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 19:56:54, Hillf Danton wrote:
> 
> Currently soft limit reclaim is frozen, see
> Documentation/admin-guide/cgroup-v2.rst for reasons.
> 
> Copying the page lru idea, memcg lru is added for selecting victim
> memcg to reclaim pages from under memory pressure. It now works in
> parallel to slr not only because the latter needs some time to reap
> but the coexistence facilitates it a lot to add the lru in a straight
> forward manner.

This doesn't explain what is the problem/feature you would like to
fix/achieve. It also doesn't explain the overall design. 

> A lru list paired with a spin lock is added, thanks to the current
> memcg high_work that provides other things it needs, and a couple of
> helpers to add memcg to and pick victim from lru.
> 
> V1 is based on 5.4-rc3.
> 
> Changes since v0
> - add MEMCG_LRU in init/Kconfig
> - drop changes in mm/vmscan.c
> - make memcg lru work in parallel to slr
> 
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -843,6 +843,14 @@ config MEMCG
>  	help
>  	  Provides control over the memory footprint of tasks in a cgroup.
>  
> +config MEMCG_LRU
> +	bool
> +	depends on MEMCG
> +	help
> +	  Select victim memcg on lru for page reclaiming.
> +
> +	  Say N if unsure.
> +
>  config MEMCG_SWAP
>  	bool "Swap controller"
>  	depends on MEMCG && SWAP
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -223,6 +223,10 @@ struct mem_cgroup {
>  	/* Upper bound of normal memory consumption range */
>  	unsigned long high;
>  
> +#ifdef CONFIG_MEMCG_LRU
> +	struct list_head lru_node;
> +#endif
> +
>  	/* Range enforcement for interrupt charges */
>  	struct work_struct high_work;
>  
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2338,14 +2338,54 @@ static int memcg_hotplug_cpu_dead(unsign
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MEMCG_LRU
> +static DEFINE_SPINLOCK(memcg_lru_lock);
> +static LIST_HEAD(memcg_lru);	/* a copy of page lru */
> +
> +static void memcg_add_lru(struct mem_cgroup *memcg)
> +{
> +	spin_lock_irq(&memcg_lru_lock);
> +	if (list_empty(&memcg->lru_node))
> +		list_add_tail(&memcg->lru_node, &memcg_lru);
> +	spin_unlock_irq(&memcg_lru_lock);
> +}
> +
> +static struct mem_cgroup *memcg_pick_lru(void)
> +{
> +	struct mem_cgroup *memcg, *next;
> +
> +	spin_lock_irq(&memcg_lru_lock);
> +
> +	list_for_each_entry_safe(memcg, next, &memcg_lru, lru_node) {
> +		list_del_init(&memcg->lru_node);
> +
> +		if (page_counter_read(&memcg->memory) > memcg->high) {
> +			spin_unlock_irq(&memcg_lru_lock);
> +			return memcg;
> +		}
> +	}
> +	spin_unlock_irq(&memcg_lru_lock);
> +
> +	return NULL;
> +}
> +#endif
> +
>  static void reclaim_high(struct mem_cgroup *memcg,
>  			 unsigned int nr_pages,
>  			 gfp_t gfp_mask)
>  {
> +#ifdef CONFIG_MEMCG_LRU
> +	struct mem_cgroup *start = memcg;
> +#endif
>  	do {
>  		if (page_counter_read(&memcg->memory) <= memcg->high)
>  			continue;
>  		memcg_memory_event(memcg, MEMCG_HIGH);
> +		if (IS_ENABLED(CONFIG_MEMCG_LRU))
> +			if (start != memcg) {
> +				memcg_add_lru(memcg);
> +				return;
> +			}
>  		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
>  	} while ((memcg = parent_mem_cgroup(memcg)));
>  }
> @@ -3158,6 +3198,13 @@ unsigned long mem_cgroup_soft_limit_recl
>  	unsigned long excess;
>  	unsigned long nr_scanned;
>  
> +	if (IS_ENABLED(CONFIG_MEMCG_LRU)) {
> +		struct mem_cgroup *memcg = memcg_pick_lru();
> +		if (memcg)
> +			schedule_work(&memcg->high_work);
> +		return 0;
> +	}
> +
>  	if (order > 0)
>  		return 0;
>  
> @@ -5068,6 +5115,8 @@ static struct mem_cgroup *mem_cgroup_all
>  	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
>  		goto fail;
>  
> +	if (IS_ENABLED(CONFIG_MEMCG_LRU))
> +		INIT_LIST_HEAD(&memcg->lru_node);
>  	INIT_WORK(&memcg->high_work, high_work_func);
>  	memcg->last_scanned_node = MAX_NUMNODES;
>  	INIT_LIST_HEAD(&memcg->oom_notify);
> --
> 

-- 
Michal Hocko
SUSE Labs
