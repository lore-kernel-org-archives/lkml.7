Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6080AC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A467215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iLsrJ7ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfFYIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:49:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfFYItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHuppSp/ZghuAvBBl8+jIRTry6/FzvqDEFCSJr4UlDU=; b=iLsrJ7ayLYr43BVsItan4uBkC
        8CdYzDlODzNlzNr+KJaMXa5EVC1N7+rihKOsW0MAjq+bvKSZmfGFwUnnb6Or83al25a+VNKRAwN7m
        F2c9EY7m7JH+5Ef+Eh4KO/lpW9N3sVMXohmf6kF7FzSFQKZcZJByFxJPoC71v326t998qSM9a85p6
        nsxSR+Xpt9zMrW+d64KxY0WNrxgsBrq/dyWsGwrpd5gig+aAOBydwTEGDdyHuqdCoX9aSvxefzJi6
        nroP0FPqeAjpaJkR21d7jhddc7laY7hBl4Xh3/wdRo/nHj6mxdL4MQ2KJZHeWlYtfE40YDxxuLhQy
        kNzUzE1qA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfh8V-0003qT-3U; Tue, 25 Jun 2019 08:49:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EA90209C9560; Tue, 25 Jun 2019 10:49:04 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:49:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] perf: Paper over the hw.target problems
Message-ID: <20190625084904.GY3463@hirez.programming.kicks-ass.net>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <20190308155429.GB10860@lakrids.cambridge.arm.com>
 <20190624121902.GE3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624121902.GE3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:19:02PM +0200, Peter Zijlstra wrote:
> 
> 	close()						clone()
> 
> 							  copy_process()
> 							    perf_event_init_task()
> 							      perf_event_init_context()
> 							        mutex_lock(parent_ctx->mutex)
> 								inherit_task_group()
> 								  inherit_group()
> 								    inherit_event()
> 								      mutex_lock(event->child_mutex)
> 								      // expose event on child list
> 								      list_add_tail()
> 								      mutex_unlock(event->child_mutex)
> 							        mutex_unlock(parent_ctx->mutex)
> 
> 							    ...
> 							    goto bad_fork_*
> 
> 							  bad_fork_cleanup_perf:
> 							    perf_event_free_task()
> 
> 	  perf_release()
> 	    perf_event_release_kernel()
> 	      list_for_each_entry()
> 		mutex_lock(ctx->mutex)
> 		mutex_lock(event->child_mutex)
> 		// event is from the failing inherit
> 		// on the other CPU
> 		perf_remove_from_context()
> 		list_move()
> 		mutex_unlock(event->child_mutex)
> 		mutex_unlock(ctx->mutex)
> 
> 							      mutex_lock(ctx->mutex)
> 							      list_for_each_entry_safe()
> 							        // event already stolen
> 							      mutex_unlock(ctx->mutex)
> 
> 							    delayed_free_task()
> 							      free_task()
> 
> 	     list_for_each_entry_safe()
> 	       list_del()
> 	       free_event()
> 	         _free_event()
> 		   // and so event->hw.target
> 		   // is the already freed failed clone()
> 		   if (event->hw.target)
> 		     put_task_struct(event->hw.target)
> 		       // WHOOPSIE, already quite dead
> 
> 
> Which puts the lie to the the comment on perf_event_free_task();
> 'unexposed, unused context' my ass.
> 
> Which is a 'fun' confluence of fail; copy_process() doing an
> unconditional free_task() and not respecting refcounts, and perf having
> creative locking. In particular:
> 
>   82d94856fa22 ("perf/core: Fix lock inversion between perf,trace,cpuhp")
> 
> seems to have overlooked this 'fun' parade.

The below seems to cure things; it uses the fact that detached events
still have a reference count on their context.

So perf_event_free_task() can detect when (child) events have gotten
stolen and wait for it.

The below (which includes a debug printk) confirms the reproducer
triggered the problem by printing a 2 (where a 1 is expected).

Thoughts?

---
 kernel/events/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 10c1dba9068c..e19d036125d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4463,12 +4463,16 @@ static void _free_event(struct perf_event *event)
 	if (event->destroy)
 		event->destroy(event);
 
-	if (event->ctx)
-		put_ctx(event->ctx);
-
+	/*
+	 * Must be after ->destroy(), due to uprobe_perf_close() using
+	 * hw.target, but before put_ctx() because of perf_event_free_task().
+	 */
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
 
+	if (event->ctx)
+		put_ctx(event->ctx);
+
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
 
@@ -4648,10 +4652,20 @@ int perf_event_release_kernel(struct perf_event *event)
 	mutex_unlock(&event->child_mutex);
 
 	list_for_each_entry_safe(child, tmp, &free_list, child_list) {
+		void *var = &child->ctx->refcount;
+
 		list_del(&child->child_list);
 		free_event(child);
+
+		/*
+		 * Wake any perf_event_free_task() waiting for this event to be
+		 * freed.
+		 */
+		smp_mb(); /* pairs with wait_var_event() */
+		wake_up_var(var);
 	}
 
+
 no_ctx:
 	put_event(event); /* Must be the 'last' reference */
 	return 0;
@@ -11546,7 +11560,19 @@ void perf_event_free_task(struct task_struct *task)
 			perf_free_event(event, ctx);
 
 		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
+
+		/*
+		 * perf_event_release_kernel() could've stolen some of our
+		 * child events and still have them on its free_list. In that
+		 * case it can do free_event() after the failing copy_process()
+		 * has already freed the task, and get a UaF on
+		 * event->hw.target.
+		 *
+		 * Wait for all events to drop their context reference.
+		 */
+		printk("%d\n", refcount_read(&ctx->refcount));
+		wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
+		put_ctx(ctx); /* must be last */
 	}
 }
 
