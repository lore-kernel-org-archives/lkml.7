Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D989CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22047205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571660855;
	bh=SpG/kT83ZECr/0cYqbLOX1ihCe0GZbVTpeuYM3pJd70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mr8wrEeAUudAN+tfbDAzAj52VKdwFcj9LWP8cc7/BtEkknfAGyKNGdg/RbaSm7UKe
	 JgZHRmLr1LENtwSGj5cp4cCo1Z2Wu0IpR7/RJ9+/qieuyVFqJRMdEjcSOj2ZQPtXgT
	 D65xpD84eozp6ctEbNbC/QYWohoCPNVeylsZHyS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfJUM1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:27:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfJUM1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 498BCAE16;
        Mon, 21 Oct 2019 12:27:30 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:27:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v1] mm: add page preemption
Message-ID: <20191021122728.GN9379@dhcp22.suse.cz>
References: <20191020134304.11700-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020134304.11700-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 20-10-19 21:43:04, Hillf Danton wrote:
> 
> Unlike cpu preemption, page preemption would have been a two-edge
> option for quite a while. It is added by preventing tasks from
> reclaiming as many lru pages as possible from other tasks of
> higher priorities.

This really begs for more explanation. I would start with what page
preemption actually is. Why do we care and which workloads would benefit
and how much. And last but not least why the existing infrastructure
doesn't help (e.g. if you have clearly defined workloads with different
memory consumption requirements then why don't you use memory cgroups to
reflect the priority).
 
> Who need pp?
> Users who want to manage/control jitters in lru pages under memory
> pressure. Way in parallel to scheduling with task's memory footprint
> taken into account, pp makes task prio a part of page reclaiming.

How do you assign priority to generally shared pages?

> [Off topic: prio can also be defined and added in memory controller
> and then plays a role in memcg reclaiming, for example check prio
> when selecting victim memcg.]
> 
> First on the page side, page->prio that is used to mirror the prio
> of page owner tasks is added, and a couple of helpers for setting,
> copying and comparing page->prio to help to add pages to lru.
> 
> Then on the reclaimer side, pgdat->kswapd_prio is added to mirror
> the prio of tasks that wake up the kthread, and it is updated
> every time kswapd raises its reclaiming priority.

This sounds like a very bad design to me. You essentially hand over
to a completely detached context while you want to handle priority
inversion problems (or at least that is what I think you want).

> Finally priorities on both sides are compared when deactivating lru
> pages, and skip page if it is higher on prio.
> 
> V1 is based on next-20191018.
> 
> Changes since v0
> - s/page->nice/page->prio/
> - drop the role of kswapd's reclaiming prioirty in prio comparison
> - add pgdat->kswapd_prio
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -281,6 +281,15 @@ config VIRT_TO_BUS
>  	  should probably not select this.
>  
>  
> +config PAGE_PREEMPTION
> +	bool
> +	help
> +	  This makes a task unable to reclaim as many lru pages as
> +	  possible from other tasks of higher priorities.
> +
> +	  Say N if unsure.
> +
> +
>  config MMU_NOTIFIER
>  	bool
>  	select SRCU
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -14,6 +14,7 @@
>  #include <linux/uprobes.h>
>  #include <linux/page-flags-layout.h>
>  #include <linux/workqueue.h>
> +#include <linux/sched/prio.h>
>  
>  #include <asm/mmu.h>
>  
> @@ -197,6 +198,10 @@ struct page {
>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>  	atomic_t _refcount;
>  
> +#ifdef CONFIG_PAGE_PREEMPTION
> +	int prio; /* mirror page owner task->prio */
> +#endif
> +
>  #ifdef CONFIG_MEMCG
>  	struct mem_cgroup *mem_cgroup;
>  #endif
> @@ -232,6 +237,54 @@ struct page {
>  #define page_private(page)		((page)->private)
>  #define set_page_private(page, v)	((page)->private = (v))
>  
> +#ifdef CONFIG_PAGE_PREEMPTION
> +static inline bool page_prio_valid(struct page *p)
> +{
> +	return p->prio > MAX_PRIO;
> +}
> +
> +static inline void set_page_prio(struct page *p, int task_prio)
> +{
> +	/* store page prio low enough to help khugepaged add lru pages */
> +	if (!page_prio_valid(p))
> +		p->prio = task_prio + MAX_PRIO + 1;
> +}
> +
> +static inline void copy_page_prio(struct page *to, struct page *from)
> +{
> +	to->prio = from->prio;
> +}
> +
> +static inline int page_prio(struct page *p)
> +{
> +	return p->prio - MAX_PRIO - 1;
> +}
> +
> +static inline bool page_prio_higher(struct page *p, int prio)
> +{
> +	return page_prio(p) < prio;
> +}
> +#else
> +static inline bool page_prio_valid(struct page *p)
> +{
> +	return true;
> +}
> +static inline void set_page_prio(struct page *p, int task_prio)
> +{
> +}
> +static inline void copy_page_prio(struct page *to, struct page *from)
> +{
> +}
> +static inline int page_prio(struct page *p)
> +{
> +	return MAX_PRIO + 1;
> +}
> +static inline bool page_prio_higher(struct page *p, int prio)
> +{
> +	return false;
> +}
> +#endif
> +
>  struct page_frag_cache {
>  	void * va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -402,6 +402,7 @@ static void __lru_cache_add(struct page
>  	struct pagevec *pvec = &get_cpu_var(lru_add_pvec);
>  
>  	get_page(page);
> +	set_page_prio(page, current->prio);
>  	if (!pagevec_add(pvec, page) || PageCompound(page))
>  		__pagevec_lru_add(pvec);
>  	put_cpu_var(lru_add_pvec);
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -647,6 +647,7 @@ void migrate_page_states(struct page *ne
>  		end_page_writeback(newpage);
>  
>  	copy_page_owner(page, newpage);
> +	copy_page_prio(newpage, page);
>  
>  	mem_cgroup_migrate(page, newpage);
>  }
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1575,6 +1575,7 @@ static int shmem_replace_page(struct pag
>  
>  	get_page(newpage);
>  	copy_highpage(newpage, oldpage);
> +	copy_page_prio(newpage, oldpage);
>  	flush_dcache_page(newpage);
>  
>  	__SetPageLocked(newpage);
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -671,6 +671,7 @@ static void __collapse_huge_page_copy(pt
>  			}
>  		} else {
>  			src_page = pte_page(pteval);
> +			copy_page_prio(page, src_page);
>  			copy_user_highpage(page, src_page, address, vma);
>  			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>  			release_pte_page(src_page);
> @@ -1723,6 +1724,7 @@ xa_unlocked:
>  				clear_highpage(new_page + (index % HPAGE_PMD_NR));
>  				index++;
>  			}
> +			copy_page_prio(new_page, page);
>  			copy_highpage(new_page + (page->index % HPAGE_PMD_NR),
>  					page);
>  			list_del(&page->lru);
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -738,6 +738,9 @@ typedef struct pglist_data {
>  	int kswapd_order;
>  	enum zone_type kswapd_classzone_idx;
>  
> +#ifdef CONFIG_PAGE_PREEMPTION
> +	int kswapd_prio; /* mirror task->prio waking up kswapd */
> +#endif
>  	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
>  
>  #ifdef CONFIG_COMPACTION
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -110,6 +110,10 @@ struct scan_control {
>  	/* The highest zone to isolate pages for reclaim from */
>  	s8 reclaim_idx;
>  
> +#ifdef CONFIG_PAGE_PREEMPTION
> +	s8 __pad;
> +	int reclaimer_prio; /* mirror task->prio */
> +#endif
>  	/* This context's GFP mask */
>  	gfp_t gfp_mask;
>  
> @@ -1710,11 +1714,18 @@ static unsigned long isolate_lru_pages(u
>  		total_scan += nr_pages;
>  
>  		if (page_zonenum(page) > sc->reclaim_idx) {
> +next_page:
>  			list_move(&page->lru, &pages_skipped);
>  			nr_skipped[page_zonenum(page)] += nr_pages;
>  			continue;
>  		}
>  
> +		if (IS_ENABLED(CONFIG_PAGE_PREEMPTION) &&
> +		    is_active_lru(lru) &&
> +		    global_reclaim(sc) &&
> +		    page_prio_higher(page, sc->reclaimer_prio))
> +			goto next_page;
> +
>  		/*
>  		 * Do not count skipped pages because that makes the function
>  		 * return with no isolated pages if the LRU mostly contains
> @@ -3260,6 +3271,9 @@ unsigned long try_to_free_pages(struct z
>  	unsigned long nr_reclaimed;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = SWAP_CLUSTER_MAX,
> +#ifdef CONFIG_PAGE_PREEMPTION
> +		.reclaimer_prio = current->prio,
> +#endif
>  		.gfp_mask = current_gfp_context(gfp_mask),
>  		.reclaim_idx = gfp_zone(gfp_mask),
>  		.order = order,
> @@ -3586,6 +3600,9 @@ static int balance_pgdat(pg_data_t *pgda
>  	bool boosted;
>  	struct zone *zone;
>  	struct scan_control sc = {
> +#ifdef CONFIG_PAGE_PREEMPTION
> +		.reclaimer_prio = pgdat->kswapd_prio,
> +#endif
>  		.gfp_mask = GFP_KERNEL,
>  		.order = order,
>  		.may_unmap = 1,
> @@ -3739,6 +3756,9 @@ restart:
>  		if (nr_boost_reclaim && !nr_reclaimed)
>  			break;
>  
> +		if (IS_ENABLED(CONFIG_PAGE_PREEMPTION))
> +			sc.reclaimer_prio = pgdat->kswapd_prio;
> +
>  		if (raise_priority || !nr_reclaimed)
>  			sc.priority--;
>  	} while (sc.priority >= 1);
> @@ -3831,6 +3851,10 @@ static void kswapd_try_to_sleep(pg_data_
>  		 */
>  		wakeup_kcompactd(pgdat, alloc_order, classzone_idx);
>  
> +		if (IS_ENABLED(CONFIG_PAGE_PREEMPTION)) {
> +			pgdat->kswapd_prio = MAX_PRIO + 1;
> +			smp_wmb();
> +		}
>  		remaining = schedule_timeout(HZ/10);
>  
>  		/*
> @@ -3865,8 +3889,13 @@ static void kswapd_try_to_sleep(pg_data_
>  		 */
>  		set_pgdat_percpu_threshold(pgdat, calculate_normal_threshold);
>  
> -		if (!kthread_should_stop())
> +		if (!kthread_should_stop()) {
> +			if (IS_ENABLED(CONFIG_PAGE_PREEMPTION)) {
> +				pgdat->kswapd_prio = MAX_PRIO + 1;
> +				smp_wmb();
> +			}
>  			schedule();
> +		}
>  
>  		set_pgdat_percpu_threshold(pgdat, calculate_pressure_threshold);
>  	} else {
> @@ -3917,6 +3946,8 @@ static int kswapd(void *p)
>  	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
>  	set_freezable();
>  
> +	if (IS_ENABLED(CONFIG_PAGE_PREEMPTION))
> +		pgdat->kswapd_prio = MAX_PRIO + 1;
>  	pgdat->kswapd_order = 0;
>  	pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
>  	for ( ; ; ) {
> @@ -3985,6 +4016,17 @@ void wakeup_kswapd(struct zone *zone, gf
>  		return;
>  	pgdat = zone->zone_pgdat;
>  
> +	if (IS_ENABLED(CONFIG_PAGE_PREEMPTION)) {
> +		int prio = current->prio;
> +
> +		if (pgdat->kswapd_prio < prio) {
> +			smp_rmb();
> +			return;
> +		}
> +		pgdat->kswapd_prio = prio;
> +		smp_wmb();
> +	}
> +
>  	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
>  		pgdat->kswapd_classzone_idx = classzone_idx;
>  	else
> --
> 

-- 
Michal Hocko
SUSE Labs
