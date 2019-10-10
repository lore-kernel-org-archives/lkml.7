Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC7ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF35321848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfJJCVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfJJCR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:17:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9E0206C0;
        Thu, 10 Oct 2019 02:17:27 +0000 (UTC)
Date:   Wed, 9 Oct 2019 22:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <20191009221725.0b83151e@oasis.local.home>
In-Reply-To: <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
References: <20191009164934.10166-1-urezki@gmail.com>
        <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 15:19:01 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed,  9 Oct 2019 18:49:34 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > Get rid of preempt_disable() and preempt_enable() when the
> > preload is done for splitting purpose. The reason is that
> > calling spin_lock() with disabled preemtion is forbidden in
> > CONFIG_PREEMPT_RT kernel.
> > 
> > Therefore, we do not guarantee that a CPU is preloaded, instead
> > we minimize the case when it is not with this change.
> > 
> > For example i run the special test case that follows the preload
> > pattern and path. 20 "unbind" threads run it and each does
> > 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> > not preloaded thus. So it can happen but the number is rather
> > negligible.
> >
> > ...
> >  
> 
> A few questions about the resulting alloc_vmap_area():
> 
> : static struct vmap_area *alloc_vmap_area(unsigned long size,
> : 				unsigned long align,
> : 				unsigned long vstart, unsigned long vend,
> : 				int node, gfp_t gfp_mask)
> : {
> : 	struct vmap_area *va, *pva;
> : 	unsigned long addr;
> : 	int purged = 0;
> : 
> : 	BUG_ON(!size);
> : 	BUG_ON(offset_in_page(size));
> : 	BUG_ON(!is_power_of_2(align));
> : 
> : 	if (unlikely(!vmap_initialized))
> : 		return ERR_PTR(-EBUSY);
> : 
> : 	might_sleep();
> : 
> : 	va = kmem_cache_alloc_node(vmap_area_cachep,
> : 			gfp_mask & GFP_RECLAIM_MASK, node);
> 
> Why does this use GFP_RECLAIM_MASK?  Please add a comment explaining
> this.
> 
> : 	if (unlikely(!va))
> : 		return ERR_PTR(-ENOMEM);
> : 
> : 	/*
> : 	 * Only scan the relevant parts containing pointers to other objects
> : 	 * to avoid false negatives.
> : 	 */
> : 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
> : 
> : retry:
> : 	/*
> : 	 * Preload this CPU with one extra vmap_area object. It is used
> : 	 * when fit type of free area is NE_FIT_TYPE. Please note, it
> : 	 * does not guarantee that an allocation occurs on a CPU that
> : 	 * is preloaded, instead we minimize the case when it is not.
> : 	 * It can happen because of migration, because there is a race
> : 	 * until the below spinlock is taken.
> : 	 *
> : 	 * The preload is done in non-atomic context, thus it allows us
> : 	 * to use more permissive allocation masks to be more stable under
> : 	 * low memory condition and high memory pressure.
> : 	 *
> : 	 * Even if it fails we do not really care about that. Just proceed
> : 	 * as it is. "overflow" path will refill the cache we allocate from.
> : 	 */
> : 	if (!this_cpu_read(ne_fit_preload_node)) {
> 
> Readability nit: local `pva' should be defined here, rather than having
> function-wide scope.
> 
> : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> 
> Why doesn't this honour gfp_mask?  If it's not a bug, please add
> comment explaining this.
> 
> The kmem_cache_alloc() in adjust_va_to_fit_type() omits the caller's
> gfp_mask also.  If not a bug, please document the unexpected behaviour.
> 

These questions appear to be for the code that this patch touches, not
for the patch itself.

> : 
> : 		if (this_cpu_cmpxchg(ne_fit_preload_node, NULL,
> pva)) { : 			if (pva)
> : 				kmem_cache_free(vmap_area_cachep,
> pva); : 		}
> : 	}
> : 
> : 	spin_lock(&vmap_area_lock);
> : 
> : 	/*
> : 	 * If an allocation fails, the "vend" address is
> : 	 * returned. Therefore trigger the overflow path.
> : 	 */
> 
> As for the intent of this patch, why not preallocate the vmap_area
> outside the spinlock and use it within the spinlock?  Does spin_lock()
> disable preemption on RT?  I forget, but it doesn't matter much anyway

spin_lock() does not disable preemption on RT. But it does disable
migration (thus the task should remain on the current CPU).

> - doing this will make the code better in the regular kernel I think? 
> Something like this:
> 
> 	struct vmap_area *pva = NULL;
> 
> 	...
> 
> 	if (!this_cpu_read(ne_fit_preload_node))
> 		pva = kmem_cache_alloc_node(vmap_area_cachep, ...);
> 
> 	spin_lock(&vmap_area_lock);
> 
> 	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
> 		kmem_cache_free(vmap_area_cachep, pva);
> 


This looks fine to me.

-- Steve
