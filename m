Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD05C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501220679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kxg1bZHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfFXMTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:19:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFXMTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A1g5jb0f1PT7FiwReN2bplW7lWOU5rCUs31n68KL20w=; b=Kxg1bZHppSq24QLamx0FSoPQ/
        Htn3DgKzISv3diNPTZPVcggPLdIvjgJjKuy4559+YFaHlQLpxXbRt73+Lt2t9MfeBDJXMJ6ri8f56
        XKQLTiXRALhpelESsM6eN1MmkysFQ/JZUPb1gmNui26wCtDzE+ESrQSHFRAzN1mvJijEeCQv87iRf
        Vl7l99AM3dyW3A8BuX0DzoxMn7bFe3UdD0iSUhateFoOLN7O9oGanMONE5DEIAH0W6ZXII1sdIfSs
        fpahCJboRCXV9GaB74PEAvBvgPQOS4xuPbCF4Hsm7DAuFgvw1D0sHIg0el58k6vUPxrCpE8shI3Rr
        oRGCkIMxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfNw8-0000Io-7B; Mon, 24 Jun 2019 12:19:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10317209C958D; Mon, 24 Jun 2019 14:19:02 +0200 (CEST)
Date:   Mon, 24 Jun 2019 14:19:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] perf: Paper over the hw.target problems
Message-ID: <20190624121902.GE3436@hirez.programming.kicks-ass.net>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <20190308155429.GB10860@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308155429.GB10860@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:54:29PM +0000, Mark Rutland wrote:
> Hi Alex,
> 
> On Thu, Feb 28, 2019 at 04:01:09PM +0200, Alexander Shishkin wrote:
> > First, we have a race between perf_event_release_kernel() and
> > perf_free_event(), which happens when parent's event is released while the
> > child's fork fails (because of a fatal signal, for example), that looks
> > like this:
> > 
> > cpu X                            cpu Y
> > -----                            -----
> >                                  copy_process() error path
> > perf_release(parent)             +->perf_event_free_task()
> > +-> lock(child_ctx->mutex)       |  |
> > +-> remove_from_context(child)   |  |
> > +-> unlock(child_ctx->mutex)     |  |
> > |                                |  +-> lock(child_ctx->mutex)
> > |                                |  +-> unlock(child_ctx->mutex)
> > |                                +-> free_task(child_task)
> > +-> put_task_struct(child_task)

I had a wee bit of bother following that, it's this, right?

	close()						clone()

							  copy_process()
							    perf_event_init_task()
							      perf_event_init_context()
							        mutex_lock(parent_ctx->mutex)
								inherit_task_group()
								  inherit_group()
								    inherit_event()
								      mutex_lock(event->child_mutex)
								      // expose event on child list
								      list_add_tail()
								      mutex_unlock(event->child_mutex)
							        mutex_unlock(parent_ctx->mutex)

							    ...
							    goto bad_fork_*

							  bad_fork_cleanup_perf:
							    perf_event_free_task()

	  perf_release()
	    perf_event_release_kernel()
	      list_for_each_entry()
		mutex_lock(ctx->mutex)
		mutex_lock(event->child_mutex)
		// event is from the failing inherit
		// on the other CPU
		perf_remove_from_context()
		list_move()
		mutex_unlock(event->child_mutex)
		mutex_unlock(ctx->mutex)

							      mutex_lock(ctx->mutex)
							      list_for_each_entry_safe()
							        // event already stolen
							      mutex_unlock(ctx->mutex)

							    delayed_free_task()
							      free_task()

	     list_for_each_entry_safe()
	       list_del()
	       free_event()
	         _free_event()
		   // and so event->hw.target
		   // is the already freed failed clone()
		   if (event->hw.target)
		     put_task_struct(event->hw.target)
		       // WHOOPSIE, already quite dead


Which puts the lie to the the comment on perf_event_free_task();
'unexposed, unused context' my ass.

Which is a 'fun' confluence of fail; copy_process() doing an
unconditional free_task() and not respecting refcounts, and perf having
creative locking. In particular:

  82d94856fa22 ("perf/core: Fix lock inversion between perf,trace,cpuhp")

seems to have overlooked this 'fun' parade.

> > Technically, we're still holding a reference to the task via
> > parent->hw.target, that's not stopping free_task(), so we end up poking at
> > free'd memory, as is pointed out by KASAN in the syzkaller report (see Link
> > below). The straightforward fix is to drop the hw.target reference while
> > the task is still around.

Right.

> > Therein lies the second problem: the users of hw.target (uprobe) assume
> > that it's around at ->destroy() callback time, where they use it for
> > context. So, in order to not break the uprobe teardown and avoid leaking
> > stuff, we need to call ->destroy() at the same time.
> 
> I had not spotted that case. That's rather horrid. :/

Such joy..

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 36b8320590e8..640695d114f8 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2105,6 +2105,27 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
> >  
> >  	event_function_call(event, __perf_remove_from_context, (void *)flags);
> >  
> > +	/*
> > +	 * This is as passable as any hw.target handling out there;
> > +	 * hw.target implies task context, therefore, no migration.
> > +	 * Which means that we can only get here at the teardown.
> > +	 */
> > +	if (event->hw.target) {
> > +		/*
> > +		 * Now, the problem with, say uprobes, is that they
> > +		 * use hw.target for context in their ->destroy()
> > +		 * callbacks. Supposedly, they may need to poke at
> > +		 * its contents, so better call it while we still
> > +		 * have the task.
> > +		 */
> > +		if (event->destroy) {
> > +			event->destroy(event);
> > +			event->destroy = NULL;
> > +		}
> > +		put_task_struct(event->hw.target);
> > +		event->hw.target = NULL;
> > +	}
> 
> We also use perf_remove_from_context() in perf_event_open() when we move
> events from a SW context to a HW context, so we can't destroy the event
> here.

Also perf_pmu_migrate_context(), and yes, we must not call ->destroy()
from remove_context, or rather, not unconditional. We could make it
conditional on DETACH_GROUP or better add another DETACH_ flags.

> I think we need something more like the below (untested), but I fear
> that it's not safe to call perf_event::destroy() in this context.

> ---->8----
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 26d6edab051a..b32f2cac5563 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4532,6 +4532,24 @@ static void put_event(struct perf_event *event)
>         _free_event(event);
>  }
>  
> +void perf_event_detach_target(struct perf_event *event)
> +{
> +       if (!event->hw.target)
> +               return;
> +
> +       /*
> +        * The uprobes perf_event::destroy() callback needs the target, so call
> +        * that while the target is still valid.
> +        */
> +       if (event->destroy) {
> +               event->destroy(event);
> +               event->destroy = NULL;
> +       }
> +
> +       put_task_struct(event->hw.target);
> +       event->hw.target = NULL;
> +}
> +
>  /*
>   * Kill an event dead; while event:refcount will preserve the event
>   * object, it will not preserve its functionality. Once the last 'user'
> @@ -4559,6 +4577,7 @@ int perf_event_release_kernel(struct perf_event *event)
>         ctx = perf_event_ctx_lock(event);
>         WARN_ON_ONCE(ctx->parent_ctx);
>         perf_remove_from_context(event, DETACH_GROUP);
> +       perf_event_detach_target(event);
>  
>         raw_spin_lock_irq(&ctx->lock);
>         /*
> @@ -4614,6 +4633,7 @@ int perf_event_release_kernel(struct perf_event *event)
>                                                struct perf_event, child_list);
>                 if (tmp == child) {
>                         perf_remove_from_context(child, DETACH_GROUP);
> +                       perf_event_detach_target(child);
>                         list_move(&child->child_list, &free_list);
>                         /*
>                          * This matches the refcount bump in inherit_event();

And doesn't this re-introduce the problem we fixed with 82d94856fa22 ?

By doing ->destroy() while holding ctx->mutex, we re-establish that
#5->#0 link and close the cycle again.

More thinking required...
