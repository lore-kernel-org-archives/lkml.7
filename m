Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D0CFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4D72082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571223573;
	bh=MH1lAOLAmOqimzjmC01RwPih+47UvtVHbjzbGIk6qjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FWyZUtq8nra+rOzN5pgnqTvdpJQJM6WRBh3gTSqhL58AFbviI24AR01N1myHN/3JS
	 FW9ZEqM0qa76uy8xvLjbfsEhvioWQWNKghB/8P7gqttTQwXv9uiX67R6rzbSzzEkgW
	 KfWv72Mk5OPCbbRzxYNqIbXVKOakQeGZL+WSJG+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404756AbfJPK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:59:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfJPK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:59:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C182DAE4B;
        Wed, 16 Oct 2019 10:59:29 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:59:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/3] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191016105928.GS317@dhcp22.suse.cz>
References: <20191016095438.12391-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016095438.12391-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 11:54:36, Uladzislau Rezki (Sony) wrote:
> Some background. The preemption was disabled before to guarantee
> that a preloaded object is available for a CPU, it was stored for.

Probably good to be explicit that this has been achieved by combining
the disabling the preemption and taking the spin lock while the
ne_fit_preload_node is checked resp. repopulated, right?

> The aim was to not allocate in atomic context when spinlock
> is taken later, for regular vmap allocations. But that approach
> conflicts with CONFIG_PREEMPT_RT philosophy. It means that
> calling spin_lock() with disabled preemption is forbidden
> in the CONFIG_PREEMPT_RT kernel.
> 
> Therefore, get rid of preempt_disable() and preempt_enable() when
> the preload is done for splitting purpose. As a result we do not
> guarantee now that a CPU is preloaded, instead we minimize the
> case when it is not, with this change.

by populating the per cpu preload pointer under the vmap_area_lock.
This implies that at least each caller which has done the preallocation
will not fallback to an atomic allocation later. It is possible that the
preallocation would be pointless or that no preallocation is done
because of the race but your data shows that this is really rare.

> For example i run the special test case that follows the preload
> pattern and path. 20 "unbind" threads run it and each does
> 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> not preloaded. So it can happen but the number is negligible.
> 
> V2 - > V3:
>     - update the commit message
> 
> V1 -> V2:
>   - move __this_cpu_cmpxchg check when spin_lock is taken,
>     as proposed by Andrew Morton
>   - add more explanation in regard of preloading
>   - adjust and move some comments
> 
> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmalloc.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e92ff5f7dd8b..b7b443bfdd92 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1078,31 +1078,34 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  retry:
>  	/*
> -	 * Preload this CPU with one extra vmap_area object to ensure
> -	 * that we have it available when fit type of free area is
> -	 * NE_FIT_TYPE.
> +	 * Preload this CPU with one extra vmap_area object. It is used
> +	 * when fit type of free area is NE_FIT_TYPE. Please note, it
> +	 * does not guarantee that an allocation occurs on a CPU that
> +	 * is preloaded, instead we minimize the case when it is not.
> +	 * It can happen because of cpu migration, because there is a
> +	 * race until the below spinlock is taken.
>  	 *
>  	 * The preload is done in non-atomic context, thus it allows us
>  	 * to use more permissive allocation masks to be more stable under
> -	 * low memory condition and high memory pressure.
> +	 * low memory condition and high memory pressure. In rare case,
> +	 * if not preloaded, GFP_NOWAIT is used.
>  	 *
> -	 * Even if it fails we do not really care about that. Just proceed
> -	 * as it is. "overflow" path will refill the cache we allocate from.
> +	 * Set "pva" to NULL here, because of "retry" path.
>  	 */
> -	preempt_disable();
> -	if (!__this_cpu_read(ne_fit_preload_node)) {
> -		preempt_enable();
> -		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> -		preempt_disable();
> +	pva = NULL;
>  
> -		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
> -			if (pva)
> -				kmem_cache_free(vmap_area_cachep, pva);
> -		}
> -	}
> +	if (!this_cpu_read(ne_fit_preload_node))
> +		/*
> +		 * Even if it fails we do not really care about that.
> +		 * Just proceed as it is. If needed "overflow" path
> +		 * will refill the cache we allocate from.
> +		 */
> +		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
>  
>  	spin_lock(&vmap_area_lock);
> -	preempt_enable();
> +
> +	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
> +		kmem_cache_free(vmap_area_cachep, pva);
>  
>  	/*
>  	 * If an allocation fails, the "vend" address is
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
