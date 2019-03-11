Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A13C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D653A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326207;
	bh=nnw29lDV7iyGZ6cbqrF99eWRaONiPTLulwLheulOVGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=egLJqLmdv5hcZtbqgFkVxA7Xmmkn/2HxSw6rpjl3uVvz2ogdpX3rOM7aRJhrxQaFv
	 ARhTTUfeok8/8MnGeYSAMRWA3edrt6i2kfCAdnPsjW9TWADgOk79SEolCmpAJt5L8J
	 ELnsEb5xRofmVlIX8qiBtBl0Qb+X0Tw5rsKG/Obk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfCKRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:43:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfCKRnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:43:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7142CAF49;
        Mon, 11 Mar 2019 17:43:22 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:43:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311174320.GC5721@dhcp22.suse.cz>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310203403.27915-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 10-03-19 13:34:03, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> This is a complete low memory killer solution for Android that is small
> and simple. It kills the largest, least-important processes it can find
> whenever a page allocation has completely failed (right after direct
> reclaim). Processes are killed according to the priorities that Android
> gives them, so that the least important processes are always killed
> first. Killing larger processes is preferred in order to free the most
> memory possible in one go.
> 
> Simple LMK is integrated deeply into the page allocator in order to
> catch exactly when a page allocation fails and exactly when a page is
> freed. Failed page allocations that have invoked Simple LMK are placed
> on a queue and wait for Simple LMK to satisfy them. When a page is about
> to be freed, the failed page allocations are given priority over normal
> page allocations by Simple LMK to see if they can immediately use the
> freed page.
> 
> Additionally, processes are continuously killed by failed small-order
> page allocations until they are satisfied.

I am sorry but we are not going to maintain two different OOM
implementations in the kernel. From a quick look the implementation is
quite a hack which is not really suitable for anything but a very
specific usecase. E.g. reusing a freed page for a waiting allocation
sounds like an interesting idea but it doesn't really work for many
reasons. E.g. any NUMA affinity is broken, zone protection doesn't work
either. Not to mention how the code hooks into the allocator hot paths.
This is simply no no.

Last but not least people have worked really hard to provide means (PSI)
to do what you need in the userspace.
 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  drivers/android/Kconfig      |  28 ++++
>  drivers/android/Makefile     |   1 +
>  drivers/android/simple_lmk.c | 301 +++++++++++++++++++++++++++++++++++
>  include/linux/sched.h        |   3 +
>  include/linux/simple_lmk.h   |  11 ++
>  kernel/fork.c                |   3 +
>  mm/page_alloc.c              |  13 ++
>  7 files changed, 360 insertions(+)
>  create mode 100644 drivers/android/simple_lmk.c
>  create mode 100644 include/linux/simple_lmk.h
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2abe4..7469d049d 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,34 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  exhaustively with combinations of various buffer sizes and
>  	  alignments.
>  
> +config ANDROID_SIMPLE_LMK
> +	bool "Simple Android Low Memory Killer"
> +	depends on !MEMCG
> +	---help---
> +	  This is a complete low memory killer solution for Android that is
> +	  small and simple. It is integrated deeply into the page allocator to
> +	  know exactly when a page allocation hits OOM and exactly when a page
> +	  is freed. Processes are killed according to the priorities that
> +	  Android gives them, so that the least important processes are always
> +	  killed first.
> +
> +if ANDROID_SIMPLE_LMK
> +
> +config ANDROID_SIMPLE_LMK_MINFREE
> +	int "Minimum MiB of memory to free per reclaim"
> +	default "64"
> +	help
> +	  Simple LMK will free at least this many MiB of memory per reclaim.
> +
> +config ANDROID_SIMPLE_LMK_KILL_TIMEOUT
> +	int "Kill timeout in milliseconds"
> +	default "50"
> +	help
> +	  Simple LMK will only perform memory reclaim at most once per this
> +	  amount of time.
> +
> +endif # if ANDROID_SIMPLE_LMK
> +
>  endif # if ANDROID
>  
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c7856e320..7c91293b6 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -3,3 +3,4 @@ ccflags-y += -I$(src)			# needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_ANDROID_SIMPLE_LMK)	+= simple_lmk.o
> diff --git a/drivers/android/simple_lmk.c b/drivers/android/simple_lmk.c
> new file mode 100644
> index 000000000..8a441650a
> --- /dev/null
> +++ b/drivers/android/simple_lmk.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Sultan Alsawaf <sultan@kerneltoast.com>.
> + */
> +
> +#define pr_fmt(fmt) "simple_lmk: " fmt
> +
> +#include <linux/mm.h>
> +#include <linux/moduleparam.h>
> +#include <linux/oom.h>
> +#include <linux/sched.h>
> +#include <linux/sizes.h>
> +#include <linux/sort.h>
> +
> +#define MIN_FREE_PAGES (CONFIG_ANDROID_SIMPLE_LMK_MINFREE * SZ_1M / PAGE_SIZE)
> +
> +struct oom_alloc_req {
> +	struct page *page;
> +	struct completion done;
> +	struct list_head lh;
> +	unsigned int order;
> +	int migratetype;
> +};
> +
> +struct victim_info {
> +	struct task_struct *tsk;
> +	unsigned long size;
> +};
> +
> +enum {
> +	DISABLED,
> +	STARTING,
> +	READY,
> +	KILLING
> +};
> +
> +/* Pulled from the Android framework */
> +static const short int adj_prio[] = {
> +	906, /* CACHED_APP_MAX_ADJ */
> +	905, /* Cached app */
> +	904, /* Cached app */
> +	903, /* Cached app */
> +	902, /* Cached app */
> +	901, /* Cached app */
> +	900, /* CACHED_APP_MIN_ADJ */
> +	800, /* SERVICE_B_ADJ */
> +	700, /* PREVIOUS_APP_ADJ */
> +	600, /* HOME_APP_ADJ */
> +	500, /* SERVICE_ADJ */
> +	400, /* HEAVY_WEIGHT_APP_ADJ */
> +	300, /* BACKUP_APP_ADJ */
> +	200, /* PERCEPTIBLE_APP_ADJ */
> +	100, /* VISIBLE_APP_ADJ */
> +	0    /* FOREGROUND_APP_ADJ */
> +};
> +
> +/* Make sure that PID_MAX_DEFAULT isn't too big, or these arrays will be huge */
> +static struct victim_info victim_array[PID_MAX_DEFAULT];
> +static struct victim_info *victim_ptr_array[ARRAY_SIZE(victim_array)];
> +static atomic_t simple_lmk_state = ATOMIC_INIT(DISABLED);
> +static atomic_t oom_alloc_count = ATOMIC_INIT(0);
> +static unsigned long last_kill_expires;
> +static unsigned long kill_expires;
> +static DEFINE_SPINLOCK(oom_queue_lock);
> +static LIST_HEAD(oom_alloc_queue);
> +
> +static int victim_info_cmp(const void *lhs, const void *rhs)
> +{
> +	const struct victim_info **lhs_ptr = (typeof(lhs_ptr))lhs;
> +	const struct victim_info **rhs_ptr = (typeof(rhs_ptr))rhs;
> +
> +	if ((*lhs_ptr)->size > (*rhs_ptr)->size)
> +		return -1;
> +
> +	if ((*lhs_ptr)->size < (*rhs_ptr)->size)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static unsigned long scan_and_kill(int min_adj, int max_adj,
> +				   unsigned long pages_needed)
> +{
> +	unsigned long pages_freed = 0;
> +	unsigned int i, vcount = 0;
> +	struct task_struct *tsk;
> +
> +	rcu_read_lock();
> +	for_each_process(tsk) {
> +		struct task_struct *vtsk;
> +		unsigned long tasksize;
> +		short oom_score_adj;
> +
> +		/* Don't commit suicide or kill kthreads */
> +		if (same_thread_group(tsk, current) || tsk->flags & PF_KTHREAD)
> +			continue;
> +
> +		vtsk = find_lock_task_mm(tsk);
> +		if (!vtsk)
> +			continue;
> +
> +		/* Don't kill tasks that have been killed or lack memory */
> +		if (vtsk->slmk_sigkill_sent ||
> +		    test_tsk_thread_flag(vtsk, TIF_MEMDIE)) {
> +			task_unlock(vtsk);
> +			continue;
> +		}
> +
> +		oom_score_adj = vtsk->signal->oom_score_adj;
> +		if (oom_score_adj < min_adj || oom_score_adj > max_adj) {
> +			task_unlock(vtsk);
> +			continue;
> +		}
> +
> +		tasksize = get_mm_rss(vtsk->mm);
> +		task_unlock(vtsk);
> +		if (!tasksize)
> +			continue;
> +
> +		/* Store this potential victim away for later */
> +		get_task_struct(vtsk);
> +		victim_array[vcount].tsk = vtsk;
> +		victim_array[vcount].size = tasksize;
> +		victim_ptr_array[vcount] = &victim_array[vcount];
> +		vcount++;
> +
> +		/* The victim array is so big that this should never happen */
> +		if (unlikely(vcount == ARRAY_SIZE(victim_array)))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	/* No potential victims for this adj range means no pages freed */
> +	if (!vcount)
> +		return 0;
> +
> +	/*
> +	 * Sort the victims in descending order of size in order to target the
> +	 * largest ones first.
> +	 */
> +	sort(victim_ptr_array, vcount, sizeof(victim_ptr_array[0]),
> +	     victim_info_cmp, NULL);
> +
> +	for (i = 0; i < vcount; i++) {
> +		struct victim_info *victim = victim_ptr_array[i];
> +		struct task_struct *vtsk = victim->tsk;
> +
> +		if (pages_freed >= pages_needed) {
> +			put_task_struct(vtsk);
> +			continue;
> +		}
> +
> +		pr_info("killing %s with adj %d to free %lu MiB\n",
> +			vtsk->comm, vtsk->signal->oom_score_adj,
> +			victim->size * PAGE_SIZE / SZ_1M);
> +
> +		if (!do_send_sig_info(SIGKILL, SEND_SIG_PRIV, vtsk, true))
> +			pages_freed += victim->size;
> +
> +		/* Unconditionally mark task as killed so it isn't reused */
> +		vtsk->slmk_sigkill_sent = true;
> +		put_task_struct(vtsk);
> +	}
> +
> +	return pages_freed;
> +}
> +
> +static void kill_processes(unsigned long pages_needed)
> +{
> +	unsigned long pages_freed = 0;
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(adj_prio); i++) {
> +		pages_freed += scan_and_kill(adj_prio[i], adj_prio[i - 1],
> +					     pages_needed - pages_freed);
> +		if (pages_freed >= pages_needed)
> +			break;
> +	}
> +}
> +
> +static void do_memory_reclaim(void)
> +{
> +	/* Only one reclaim can occur at a time */
> +	if (atomic_cmpxchg(&simple_lmk_state, READY, KILLING) != READY)
> +		return;
> +
> +	if (time_after_eq(jiffies, last_kill_expires)) {
> +		kill_processes(MIN_FREE_PAGES);
> +		last_kill_expires = jiffies + kill_expires;
> +	}
> +
> +	atomic_set(&simple_lmk_state, READY);
> +}
> +
> +static long reclaim_once_or_more(struct completion *done, unsigned int order)
> +{
> +	long ret;
> +
> +	/* Don't allow costly allocations to do memory reclaim more than once */
> +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +		do_memory_reclaim();
> +		return wait_for_completion_killable(done);
> +	}
> +
> +	do {
> +		do_memory_reclaim();
> +		ret = wait_for_completion_killable_timeout(done, kill_expires);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +struct page *simple_lmk_oom_alloc(unsigned int order, int migratetype)
> +{
> +	struct oom_alloc_req page_req = {
> +		.done = COMPLETION_INITIALIZER_ONSTACK(page_req.done),
> +		.order = order,
> +		.migratetype = migratetype
> +	};
> +	long ret;
> +
> +	if (atomic_read(&simple_lmk_state) <= STARTING)
> +		return NULL;
> +
> +	spin_lock(&oom_queue_lock);
> +	list_add_tail(&page_req.lh, &oom_alloc_queue);
> +	spin_unlock(&oom_queue_lock);
> +
> +	atomic_inc(&oom_alloc_count);
> +
> +	/* Do memory reclaim and wait */
> +	ret = reclaim_once_or_more(&page_req.done, order);
> +	if (ret == -ERESTARTSYS) {
> +		/* Give up since this process is dying */
> +		spin_lock(&oom_queue_lock);
> +		if (!page_req.page)
> +			list_del(&page_req.lh);
> +		spin_unlock(&oom_queue_lock);
> +	}
> +
> +	atomic_dec(&oom_alloc_count);
> +
> +	return page_req.page;
> +}
> +
> +bool simple_lmk_page_in(struct page *page, unsigned int order, int migratetype)
> +{
> +	struct oom_alloc_req *page_req;
> +	bool matched = false;
> +	int try_order;
> +
> +	if (atomic_read(&simple_lmk_state) <= STARTING ||
> +	    !atomic_read(&oom_alloc_count))
> +		return false;
> +
> +	/* Try to match this free page with an OOM allocation request */
> +	spin_lock(&oom_queue_lock);
> +	for (try_order = order; try_order >= 0; try_order--) {
> +		list_for_each_entry(page_req, &oom_alloc_queue, lh) {
> +			if (page_req->order == try_order &&
> +			    page_req->migratetype == migratetype) {
> +				matched = true;
> +				break;
> +			}
> +		}
> +
> +		if (matched)
> +			break;
> +	}
> +
> +	if (matched) {
> +		__ClearPageBuddy(page);
> +		page_req->page = page;
> +		list_del(&page_req->lh);
> +		complete(&page_req->done);
> +	}
> +	spin_unlock(&oom_queue_lock);
> +
> +	return matched;
> +}
> +
> +/* Enable Simple LMK when LMKD in Android writes to the minfree parameter */
> +static int simple_lmk_init_set(const char *val, const struct kernel_param *kp)
> +{
> +	if (atomic_cmpxchg(&simple_lmk_state, DISABLED, STARTING) != DISABLED)
> +		return 0;
> +
> +	/* Store the calculated kill timeout jiffies for frequent reuse */
> +	kill_expires = msecs_to_jiffies(CONFIG_ANDROID_SIMPLE_LMK_KILL_TIMEOUT);
> +	atomic_set(&simple_lmk_state, READY);
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops simple_lmk_init_ops = {
> +	.set = simple_lmk_init_set
> +};
> +
> +/* Needed to prevent Android from thinking there's no LMK and thus rebooting */
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "lowmemorykiller."
> +module_param_cb(minfree, &simple_lmk_init_ops, NULL, 0200);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1549584a1..d290f9ece 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1199,6 +1199,9 @@ struct task_struct {
>  	unsigned long			lowest_stack;
>  	unsigned long			prev_lowest_stack;
>  #endif
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	bool slmk_sigkill_sent;
> +#endif
>  
>  	/*
>  	 * New fields for task_struct should be added above here, so that
> diff --git a/include/linux/simple_lmk.h b/include/linux/simple_lmk.h
> new file mode 100644
> index 000000000..64c26368a
> --- /dev/null
> +++ b/include/linux/simple_lmk.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Sultan Alsawaf <sultan@kerneltoast.com>.
> + */
> +#ifndef _SIMPLE_LMK_H_
> +#define _SIMPLE_LMK_H_
> +
> +struct page *simple_lmk_oom_alloc(unsigned int order, int migratetype);
> +bool simple_lmk_page_in(struct page *page, unsigned int order, int migratetype);
> +
> +#endif /* _SIMPLE_LMK_H_ */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9dcd18aa2..162c45392 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1881,6 +1881,9 @@ static __latent_entropy struct task_struct *copy_process(
>  	p->sequential_io	= 0;
>  	p->sequential_io_avg	= 0;
>  #endif
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	p->slmk_sigkill_sent = false;
> +#endif
>  
>  	/* Perform scheduler related setup. Assign this task to a CPU. */
>  	retval = sched_fork(clone_flags, p);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3eb01dedf..fd0d697c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
>  #include <linux/psi.h>
> +#include <linux/simple_lmk.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -967,6 +968,11 @@ static inline void __free_one_page(struct page *page,
>  		}
>  	}
>  
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	if (simple_lmk_page_in(page, order, migratetype))
> +		return;
> +#endif
> +
>  	list_add(&page->lru, &zone->free_area[order].free_list[migratetype]);
>  out:
>  	zone->free_area[order].nr_free++;
> @@ -4427,6 +4433,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
>  		goto nopage;
>  
> +#ifdef CONFIG_ANDROID_SIMPLE_LMK
> +	page = simple_lmk_oom_alloc(order, ac->migratetype);
> +	if (page)
> +		prep_new_page(page, order, gfp_mask, alloc_flags);
> +	goto got_pg;
> +#endif
> +
>  	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
>  				 did_some_progress > 0, &no_progress_loops))
>  		goto retry;
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
