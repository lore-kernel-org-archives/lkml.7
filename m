Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3EECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F0720659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571058794;
	bh=92fWcLoUU6ZXYmS3LOYt4HjPc2qNe2JHcnMxLLRyblA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPpJ2S18lI7oMrHpUFMgA92b9IKEyxOmEU0WANvLgS05MCos+DbizoYGDamCazovO
	 djB/NicGYqwr9vU+JSc7vlb1tifSCDoMHiq8kMZCVNoCbZuPyGaOhKKH8XHKYGaRyp
	 MazxeVcAGcFXulHnS4zRBgzZZuSLVG7x0bCw9KNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfJNNNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729752AbfJNNNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B2BDB302;
        Mon, 14 Oct 2019 13:13:10 +0000 (UTC)
Date:   Mon, 14 Oct 2019 15:13:08 +0200
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
Subject: Re: [PATCH v2 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191014131308.GG317@dhcp22.suse.cz>
References: <20191010223318.28115-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010223318.28115-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 00:33:18, Uladzislau Rezki (Sony) wrote:
> Get rid of preempt_disable() and preempt_enable() when the
> preload is done for splitting purpose. The reason is that
> calling spin_lock() with disabled preemtion is forbidden in
> CONFIG_PREEMPT_RT kernel.

I think it would be really helpful to describe why the preemption was
disabled in that path. Some of that is explained in the comment but the
changelog should mention that explicitly.
 
> Therefore, we do not guarantee that a CPU is preloaded, instead
> we minimize the case when it is not with this change.
> 
> For example i run the special test case that follows the preload
> pattern and path. 20 "unbind" threads run it and each does
> 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> not preloaded. So it can happen but the number is negligible.
> 
> V1 -> V2:
>   - move __this_cpu_cmpxchg check when spin_lock is taken,
>     as proposed by Andrew Morton
>   - add more explanation in regard of preloading
>   - adjust and move some comments
> 
> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 50 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e92ff5f7dd8b..f48cd0711478 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -969,6 +969,19 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  			 * There are a few exceptions though, as an example it is
>  			 * a first allocation (early boot up) when we have "one"
>  			 * big free space that has to be split.
> +			 *
> +			 * Also we can hit this path in case of regular "vmap"
> +			 * allocations, if "this" current CPU was not preloaded.
> +			 * See the comment in alloc_vmap_area() why. If so, then
> +			 * GFP_NOWAIT is used instead to get an extra object for
> +			 * split purpose. That is rare and most time does not
> +			 * occur.
> +			 *
> +			 * What happens if an allocation gets failed. Basically,
> +			 * an "overflow" path is triggered to purge lazily freed
> +			 * areas to free some memory, then, the "retry" path is
> +			 * triggered to repeat one more time. See more details
> +			 * in alloc_vmap_area() function.
>  			 */
>  			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);

This doesn't seem to have anything to do with the patch. Have you
considered to make it a patch on its own? Btw. I find this comment very
useful!

>  			if (!lva)
> @@ -1078,31 +1091,34 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
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
> +	 * It can happen because of migration, because there is a race
> +	 * until the below spinlock is taken.

s@migration@cpu migration@ because migration without on its own is quite
ambiguous, especially in the MM code where it usually refers to memory.

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

-- 
Michal Hocko
SUSE Labs
