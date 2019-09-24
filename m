Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2375214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569333379;
	bh=bfEprrHa+7Gr9RYeOCSfKA93F0JM/gdUSVwWH0XdvRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YL4Cl03pSuaKwBkN+Lk52K3r/KrWLujE6+L06Gahzm+3EofWLCd1ZMh4dwACqlJMd
	 Oqx2whpVKnFGj6rXTsoBUMTNR49eEGtFT2CcWKPB8/r5FMQUrLe1jTDPGNOAnyyFgz
	 CAukxsPcSwqnrw+Nvts5D/AWJ6WrMSr/DQvkEikk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395449AbfIXN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:56:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:47200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfIXN4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:56:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79F45AC4A;
        Tue, 24 Sep 2019 13:56:09 +0000 (UTC)
Date:   Tue, 24 Sep 2019 15:56:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, rientjes@google.com, ktkhai@virtuozzo.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        hannes@cmpxchg.org, cai@lca.pw, yang.shi@linux.alibaba.com
Subject: Re: + mm-thp-extract-split_queue_-into-a-struct.patch added to -mm
 tree
Message-ID: <20190924135608.GW23050@dhcp22.suse.cz>
References: <20190923220902.-_eJc%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923220902.-_eJc%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do we really need this if deferred list is going to be shrunk more
pro-actively as discussed already - I am sorry I do not have a link handy
but in short the deferred list would be drained from a kworker context
more pro-actively rather than wait for the memory pressure to happen.

On Mon 23-09-19 15:09:02, Andrew Morton wrote:
> ------------------------------------------------------
> From: Yang Shi <yang.shi@linux.alibaba.com>
> Subject: mm: thp: extract split_queue_* into a struct
> 
> Patch series "Make deferred split shrinker memcg aware", v6.
> 
> Currently THP deferred split shrinker is not memcg aware, this may cause
> premature OOM with some configuration.  For example the below test would
> run into premature OOM easily:
> 
> $ cgcreate -g memory:thp
> $ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
> $ cgexec -g memory:thp transhuge-stress 4000
> 
> transhuge-stress comes from kernel selftest.
> 
> It is easy to hit OOM, but there are still a lot THP on the deferred split
> queue, memcg direct reclaim can't touch them since the deferred split
> shrinker is not memcg aware.
> 
> Convert deferred split shrinker memcg aware by introducing per memcg
> deferred split queue.  The THP should be on either per node or per memcg
> deferred split queue if it belongs to a memcg.  When the page is
> immigrated to the other memcg, it will be immigrated to the target memcg's
> deferred split queue too.
> 
> Reuse the second tail page's deferred_list for per memcg list since the
> same THP can't be on multiple deferred split queues.
> 
> Make deferred split shrinker not depend on memcg kmem since it is not
> slab.  It doesn't make sense to not shrink THP even though memcg kmem is
> disabled.
> 
> With the above change the test demonstrated above doesn't trigger OOM even
> though with cgroup.memory=nokmem.
> 
> 
> This patch (of 4):
> 
> Put split_queue, split_queue_lock and split_queue_len into a struct in
> order to reduce code duplication when we convert deferred_split to memcg
> aware in the later patches.
> 
> Link: http://lkml.kernel.org/r/1565144277-36240-2-git-send-email-yang.shi@linux.alibaba.com
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Suggested-by: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/mmzone.h |   12 +++++++---
>  mm/huge_memory.c       |   45 +++++++++++++++++++++------------------
>  mm/page_alloc.c        |    8 ++++--
>  3 files changed, 39 insertions(+), 26 deletions(-)
> 
> --- a/include/linux/mmzone.h~mm-thp-extract-split_queue_-into-a-struct
> +++ a/include/linux/mmzone.h
> @@ -679,6 +679,14 @@ struct zonelist {
>  extern struct page *mem_map;
>  #endif
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +struct deferred_split {
> +	spinlock_t split_queue_lock;
> +	struct list_head split_queue;
> +	unsigned long split_queue_len;
> +};
> +#endif
> +
>  /*
>   * On NUMA machines, each NUMA node would have a pg_data_t to describe
>   * it's memory layout. On UMA machines there is a single pglist_data which
> @@ -758,9 +766,7 @@ typedef struct pglist_data {
>  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	spinlock_t split_queue_lock;
> -	struct list_head split_queue;
> -	unsigned long split_queue_len;
> +	struct deferred_split deferred_split_queue;
>  #endif
>  
>  	/* Fields commonly accessed by the page reclaim scanner */
> --- a/mm/huge_memory.c~mm-thp-extract-split_queue_-into-a-struct
> +++ a/mm/huge_memory.c
> @@ -2691,6 +2691,7 @@ int split_huge_page_to_list(struct page
>  {
>  	struct page *head = compound_head(page);
>  	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
> +	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int count, mapcount, extra_pins, ret;
> @@ -2777,17 +2778,17 @@ int split_huge_page_to_list(struct page
>  	}
>  
>  	/* Prevent deferred_split_scan() touching ->_refcount */
> -	spin_lock(&pgdata->split_queue_lock);
> +	spin_lock(&ds_queue->split_queue_lock);
>  	count = page_count(head);
>  	mapcount = total_mapcount(head);
>  	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>  		if (!list_empty(page_deferred_list(head))) {
> -			pgdata->split_queue_len--;
> +			ds_queue->split_queue_len--;
>  			list_del(page_deferred_list(head));
>  		}
>  		if (mapping)
>  			__dec_node_page_state(page, NR_SHMEM_THPS);
> -		spin_unlock(&pgdata->split_queue_lock);
> +		spin_unlock(&ds_queue->split_queue_lock);
>  		__split_huge_page(page, list, end, flags);
>  		if (PageSwapCache(head)) {
>  			swp_entry_t entry = { .val = page_private(head) };
> @@ -2804,7 +2805,7 @@ int split_huge_page_to_list(struct page
>  			dump_page(page, "total_mapcount(head) > 0");
>  			BUG();
>  		}
> -		spin_unlock(&pgdata->split_queue_lock);
> +		spin_unlock(&ds_queue->split_queue_lock);
>  fail:		if (mapping)
>  			xa_unlock(&mapping->i_pages);
>  		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> @@ -2827,52 +2828,56 @@ out:
>  void free_transhuge_page(struct page *page)
>  {
>  	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
> +	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> +	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (!list_empty(page_deferred_list(page))) {
> -		pgdata->split_queue_len--;
> +		ds_queue->split_queue_len--;
>  		list_del(page_deferred_list(page));
>  	}
> -	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> +	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  	free_compound_page(page);
>  }
>  
>  void deferred_split_huge_page(struct page *page)
>  {
>  	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
> +	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
>  
>  	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
>  
> -	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> +	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (list_empty(page_deferred_list(page))) {
>  		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -		list_add_tail(page_deferred_list(page), &pgdata->split_queue);
> -		pgdata->split_queue_len++;
> +		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
> +		ds_queue->split_queue_len++;
>  	}
> -	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> +	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
>  
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
>  	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> -	return READ_ONCE(pgdata->split_queue_len);
> +	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> +	return READ_ONCE(ds_queue->split_queue_len);
>  }
>  
>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
>  	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> +	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
>  	LIST_HEAD(list), *pos, *next;
>  	struct page *page;
>  	int split = 0;
>  
> -	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> +	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
> -	list_for_each_safe(pos, next, &pgdata->split_queue) {
> +	list_for_each_safe(pos, next, &ds_queue->split_queue) {
>  		page = list_entry((void *)pos, struct page, mapping);
>  		page = compound_head(page);
>  		if (get_page_unless_zero(page)) {
> @@ -2880,12 +2885,12 @@ static unsigned long deferred_split_scan
>  		} else {
>  			/* We lost race with put_compound_page() */
>  			list_del_init(page_deferred_list(page));
> -			pgdata->split_queue_len--;
> +			ds_queue->split_queue_len--;
>  		}
>  		if (!--sc->nr_to_scan)
>  			break;
>  	}
> -	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> +	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  
>  	list_for_each_safe(pos, next, &list) {
>  		page = list_entry((void *)pos, struct page, mapping);
> @@ -2899,15 +2904,15 @@ next:
>  		put_page(page);
>  	}
>  
> -	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> -	list_splice_tail(&list, &pgdata->split_queue);
> -	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> +	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> +	list_splice_tail(&list, &ds_queue->split_queue);
> +	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  
>  	/*
>  	 * Stop shrinker if we didn't split any page, but the queue is empty.
>  	 * This can happen if pages were freed under us.
>  	 */
> -	if (!split && list_empty(&pgdata->split_queue))
> +	if (!split && list_empty(&ds_queue->split_queue))
>  		return SHRINK_STOP;
>  	return split;
>  }
> --- a/mm/page_alloc.c~mm-thp-extract-split_queue_-into-a-struct
> +++ a/mm/page_alloc.c
> @@ -6646,9 +6646,11 @@ static unsigned long __init calc_memmap_
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void pgdat_init_split_queue(struct pglist_data *pgdat)
>  {
> -	spin_lock_init(&pgdat->split_queue_lock);
> -	INIT_LIST_HEAD(&pgdat->split_queue);
> -	pgdat->split_queue_len = 0;
> +	struct deferred_split *ds_queue = &pgdat->deferred_split_queue;
> +
> +	spin_lock_init(&ds_queue->split_queue_lock);
> +	INIT_LIST_HEAD(&ds_queue->split_queue);
> +	ds_queue->split_queue_len = 0;
>  }
>  #else
>  static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
> _
> 
> Patches currently in -mm which might be from yang.shi@linux.alibaba.com are
> 
> mmthp-add-read-only-thp-support-for-non-shmem-fs.patch
> mm-thp-extract-split_queue_-into-a-struct.patch
> mm-move-mem_cgroup_uncharge-out-of-__page_cache_release.patch
> mm-shrinker-make-shrinker-not-depend-on-memcg-kmem.patch
> mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-v6.patch
> mm-thp-make-deferred-split-shrinker-memcg-aware.patch
> mm-thp-make-deferred-split-shrinker-memcg-aware-v6.patch

-- 
Michal Hocko
SUSE Labs
