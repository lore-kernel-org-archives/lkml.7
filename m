Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E62190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfJISV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfJISV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:21:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4957020B7C;
        Wed,  9 Oct 2019 18:21:27 +0000 (UTC)
Date:   Wed, 9 Oct 2019 14:21:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191009142125.22cf3b8c@gandalf.local.home>
In-Reply-To: <20191009164934.10166-1-urezki@gmail.com>
References: <20191009164934.10166-1-urezki@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 18:49:34 +0200
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Get rid of preempt_disable() and preempt_enable() when the
> preload is done for splitting purpose. The reason is that
> calling spin_lock() with disabled preemtion is forbidden in
> CONFIG_PREEMPT_RT kernel.
> 
> Therefore, we do not guarantee that a CPU is preloaded, instead
> we minimize the case when it is not with this change.
> 
> For example i run the special test case that follows the preload
> pattern and path. 20 "unbind" threads run it and each does
> 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> not preloaded thus. So it can happen but the number is rather
> negligible.

Thanks for the analysis.

> 
> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e92ff5f7dd8b..2ed6fef86950 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1078,9 +1078,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
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
>  	 *
>  	 * The preload is done in non-atomic context, thus it allows us
>  	 * to use more permissive allocation masks to be more stable under
> @@ -1089,20 +1092,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * Even if it fails we do not really care about that. Just proceed
>  	 * as it is. "overflow" path will refill the cache we allocate from.
>  	 */
> -	preempt_disable();
> -	if (!__this_cpu_read(ne_fit_preload_node)) {
> -		preempt_enable();

As the original code enables preemption here regardless, there's no
guarantee that the original patch would allocate the pva to the CPU in
question.

I agree with this patch, the preempt_disable() here only narrows an
already narrow window, with no real help in what it was doing.

> +	if (!this_cpu_read(ne_fit_preload_node)) {
>  		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);

If the memory allocation failed here, we still may not have a pva for
the current CPU's ne_fit_preload_node, rare as that may be.

> -		preempt_disable();
>  
> -		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
> +		if (this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {


Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  			if (pva)
>  				kmem_cache_free(vmap_area_cachep, pva);
>  		}
>  	}
>  
>  	spin_lock(&vmap_area_lock);
> -	preempt_enable();
>  
>  	/*
>  	 * If an allocation fails, the "vend" address is

