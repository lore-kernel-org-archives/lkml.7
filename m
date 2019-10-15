Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A42ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03CD217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571126964;
	bh=Gkk26azVo/PWmRl53CGaexoCU5dWwCk5Sajn/80GDKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v4qlwcBkgPwQH2iOrR6R7dH/RkQ3ObYCzj/ITWP7XFxPyu6Txn7uAZCnz6sP8tdDL
	 CeCQMNb/FoawP/ZzbCbUrOI43ntHpc24cldWCe33K4Ohwwd0lXaTOUE7RYBrXJLvbT
	 zHdnK+MhaeGPiUtndQrgBUh6s+qFvBzchXMni7mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfJOIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:09:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbfJOIJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:09:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F163FAB92;
        Tue, 15 Oct 2019 08:09:19 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:09:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org,
        hughd@google.com, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC, PATCH] mm, thp: Try to bound number of pages on deferred
 split queue
Message-ID: <20191015080918.GT317@dhcp22.suse.cz>
References: <20191009144509.23649-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009144509.23649-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 17:45:09, Kirill A. Shutemov wrote:
> THPs on deferred split queue got split by shrinker if memory pressure
> comes.
> 
> In absence of memory pressure, there is no bound on how long the
> deferred split queue can be. In extreme cases, deferred queue can grow
> to tens of gigabytes.
> 
> It is suboptimal: even without memory pressure we can find better way to
> use the memory (page cache for instance).
> 
> Make deferred_split_huge_page() to trigger a work that would split
> pages, if we have more than NR_PAGES_ON_QUEUE_TO_SPLIT on the queue.

I very much do agree with the problem statement and the proposed
solution makes some sense to me as well. With this in place we can drop
the large part of the shrinker infrastructure as well (including memcg
and node awereness).

> The split can fail (i.e. due to memory pinning by GUP), making the
> queue grow despite the effort. Rate-limit the work triggering to at most
> every NR_CALLS_TO_SPLIT calls of deferred_split_huge_page().
> 
> NR_PAGES_ON_QUEUE_TO_SPLIT and NR_CALLS_TO_SPLIT chosen arbitrarily and
> will likely require tweaking.
> 
> The patch has risk to introduce performance regressions. For system with
> plenty of free memory, triggering the split would cost CPU time (~100ms
> per GB of THPs to split).
> 
> I have doubts about the approach, so:
> 
> Not-Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Well, I doubt we will get this to see a wider testing if it is not s-o-b
and therefore unlikely to hit linux-next.

Yang Shi had a workload that observed a noticeable number deferred THPs.
Would it be possible to have it tested with the same workload and see
how it behaves?

> ---
>  include/linux/mmzone.h |   5 ++
>  mm/huge_memory.c       | 129 ++++++++++++++++++++++++++++-------------
>  mm/memcontrol.c        |   3 +
>  mm/page_alloc.c        |   2 +
>  4 files changed, 100 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index bda20282746b..f748542745ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -684,7 +684,12 @@ struct deferred_split {
>  	spinlock_t split_queue_lock;
>  	struct list_head split_queue;
>  	unsigned long split_queue_len;
> +	unsigned int deferred_split_calls;
> +	struct work_struct deferred_split_work;
>  };
> +
> +void flush_deferred_split_queue(struct work_struct *work);
> +void flush_deferred_split_queue_memcg(struct work_struct *work);
>  #endif
>  
>  /*
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c5cb6dcd6c69..bb7bef856e38 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2842,43 +2842,6 @@ void free_transhuge_page(struct page *page)
>  	free_compound_page(page);
>  }
>  
> -void deferred_split_huge_page(struct page *page)
> -{
> -	struct deferred_split *ds_queue = get_deferred_split_queue(page);
> -#ifdef CONFIG_MEMCG
> -	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
> -#endif
> -	unsigned long flags;
> -
> -	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> -
> -	/*
> -	 * The try_to_unmap() in page reclaim path might reach here too,
> -	 * this may cause a race condition to corrupt deferred split queue.
> -	 * And, if page reclaim is already handling the same page, it is
> -	 * unnecessary to handle it again in shrinker.
> -	 *
> -	 * Check PageSwapCache to determine if the page is being
> -	 * handled by page reclaim since THP swap would add the page into
> -	 * swap cache before calling try_to_unmap().
> -	 */
> -	if (PageSwapCache(page))
> -		return;
> -
> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -	if (list_empty(page_deferred_list(page))) {
> -		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
> -		ds_queue->split_queue_len++;
> -#ifdef CONFIG_MEMCG
> -		if (memcg)
> -			memcg_set_shrinker_bit(memcg, page_to_nid(page),
> -					       deferred_split_shrinker.id);
> -#endif
> -	}
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> -}
> -
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> @@ -2895,8 +2858,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> +	struct deferred_split *ds_queue = NULL;
>  	unsigned long flags;
>  	LIST_HEAD(list), *pos, *next;
>  	struct page *page;
> @@ -2906,6 +2868,10 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	if (sc->memcg)
>  		ds_queue = &sc->memcg->deferred_split_queue;
>  #endif
> +	if (!ds_queue) {
> +		struct pglist_data *pgdata = NODE_DATA(sc->nid);
> +		ds_queue = &pgdata->deferred_split_queue;
> +	}
>  
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
> @@ -2957,6 +2923,91 @@ static struct shrinker deferred_split_shrinker = {
>  		 SHRINKER_NONSLAB,
>  };
>  
> +static void __flush_deferred_split_queue(struct pglist_data *pgdata,
> +		struct mem_cgroup *memcg)
> +{
> +	struct shrink_control sc;
> +
> +	sc.nid = pgdata ? pgdata->node_id : 0;
> +	sc.memcg = memcg;
> +	sc.nr_to_scan = 0; /* Unlimited */
> +
> +	deferred_split_scan(NULL, &sc);
> +}
> +
> +void flush_deferred_split_queue(struct work_struct *work)
> +{
> +	struct deferred_split *ds_queue;
> +	struct pglist_data *pgdata;
> +
> +	ds_queue = container_of(work, struct deferred_split,
> +			deferred_split_work);
> +	pgdata = container_of(ds_queue, struct pglist_data,
> +			deferred_split_queue);
> +	__flush_deferred_split_queue(pgdata, NULL);
> +}
> +
> +#ifdef CONFIG_MEMCG
> +void flush_deferred_split_queue_memcg(struct work_struct *work)
> +{
> +	struct deferred_split *ds_queue;
> +	struct mem_cgroup *memcg;
> +
> +	ds_queue = container_of(work, struct deferred_split,
> +			deferred_split_work);
> +	memcg = container_of(ds_queue, struct mem_cgroup,
> +			deferred_split_queue);
> +	__flush_deferred_split_queue(NULL, memcg);
> +}
> +#endif
> +
> +#define NR_CALLS_TO_SPLIT 32
> +#define NR_PAGES_ON_QUEUE_TO_SPLIT 16
> +
> +void deferred_split_huge_page(struct page *page)
> +{
> +	struct deferred_split *ds_queue = get_deferred_split_queue(page);
> +#ifdef CONFIG_MEMCG
> +	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
> +#endif
> +	unsigned long flags;
> +
> +	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> +
> +	/*
> +	 * The try_to_unmap() in page reclaim path might reach here too,
> +	 * this may cause a race condition to corrupt deferred split queue.
> +	 * And, if page reclaim is already handling the same page, it is
> +	 * unnecessary to handle it again in shrinker.
> +	 *
> +	 * Check PageSwapCache to determine if the page is being
> +	 * handled by page reclaim since THP swap would add the page into
> +	 * swap cache before calling try_to_unmap().
> +	 */
> +	if (PageSwapCache(page))
> +		return;
> +
> +	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> +	if (list_empty(page_deferred_list(page))) {
> +		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
> +		ds_queue->split_queue_len++;
> +		ds_queue->deferred_split_calls++;
> +#ifdef CONFIG_MEMCG
> +		if (memcg)
> +			memcg_set_shrinker_bit(memcg, page_to_nid(page),
> +					       deferred_split_shrinker.id);
> +#endif
> +	}
> +
> +	if (ds_queue->split_queue_len > NR_PAGES_ON_QUEUE_TO_SPLIT &&
> +			ds_queue->deferred_split_calls > NR_CALLS_TO_SPLIT) {
> +		ds_queue->deferred_split_calls = 0;
> +		schedule_work(&ds_queue->deferred_split_work);
> +	}
> +	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int split_huge_pages_set(void *data, u64 val)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c313c49074ca..67305ec75fdc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5085,6 +5085,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
>  	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
>  	memcg->deferred_split_queue.split_queue_len = 0;
> +	memcg->deferred_split_queue.deferred_split_calls = 0;
> +	INIT_WORK(&memcg->deferred_split_queue.deferred_split_work,
> +			flush_deferred_split_queue_memcg);
>  #endif
>  	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
>  	return memcg;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15c2050c629b..2f52e538a26f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6674,6 +6674,8 @@ static void pgdat_init_split_queue(struct pglist_data *pgdat)
>  	spin_lock_init(&ds_queue->split_queue_lock);
>  	INIT_LIST_HEAD(&ds_queue->split_queue);
>  	ds_queue->split_queue_len = 0;
> +	ds_queue->deferred_split_calls = 0;
> +	INIT_WORK(&ds_queue->deferred_split_work, flush_deferred_split_queue);
>  }
>  #else
>  static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
