Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B2D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tNpuKDID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfFYKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:43:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfFYKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bX0AUbriIdW8uB8m351hBABxw7tgECbO9YEwMIEHwrQ=; b=tNpuKDIDuUrSdoDiaPT/u2qdB
        50hIvL2r50PbwNs1jQ99TRYSifU64HfISbwd29t+N4skDcrjviu9F4q2/0lGv2FPRSx1GHSPas/Me
        fgYZRFqB3IPcvw005nt0DHzQQ2g4E8gKPGUlQlHWT2fVuF8bqCCFARuqg06YHn3FizgTeW4+qtW3t
        uqxvNfljvOS+ayaHEPGfXgns0zb9ll+ThJxWjm/tx5tuqJfMRVXVYnvkABwYsXvtlaD2AmjdUECJL
        obZpiDUBQMW4uG/XtxD/DyyAVJyBKnhKX9vnL4HIMIBpZE9K15AFts80KqnswHQ8TVCD/lDE32JO5
        CCeB9zsFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfiv4-0006iT-NO; Tue, 25 Jun 2019 10:43:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FEAB20A0643C; Tue, 25 Jun 2019 12:43:20 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:43:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: [PATCH] perf: Fix race between close() and fork()
Message-ID: <20190625104320.GZ3463@hirez.programming.kicks-ass.net>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <20190308155429.GB10860@lakrids.cambridge.arm.com>
 <20190624121902.GE3436@hirez.programming.kicks-ass.net>
 <20190625084904.GY3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625084904.GY3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Syzcaller reported the following Use-after-Free issue:

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


Which puts the lie to the the comment on perf_event_free_task():
'unexposed, unused context' not so much.

Which is a 'fun' confluence of fail; copy_process() doing an
unconditional free_task() and not respecting refcounts, and perf having
creative locking. In particular:

  82d94856fa22 ("perf/core: Fix lock inversion between perf,trace,cpuhp")

seems to have overlooked this 'fun' parade.

Solve it by using the fact that detached events still have a reference
count on their (previous) context. With this perf_event_free_task()
can detect when events have escaped and wait for their destruction.

Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 82d94856fa22 ("perf/core: Fix lock inversion between perf,trace,cpuhp")
Reported-by: syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Debugged-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 10c1dba9068c..5302c19e9892 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4463,12 +4463,20 @@ static void _free_event(struct perf_event *event)
 	if (event->destroy)
 		event->destroy(event);
 
-	if (event->ctx)
-		put_ctx(event->ctx);
-
+	/*
+	 * Must be after ->destroy(), due to uprobe_perf_close() using
+	 * hw.target.
+	 */
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
 
+	/*
+	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
+	 * all task references must be cleaned up.
+	 */
+	if (event->ctx)
+		put_ctx(event->ctx);
+
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
 
@@ -4648,8 +4656,17 @@ int perf_event_release_kernel(struct perf_event *event)
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
 
 no_ctx:
@@ -11512,11 +11529,11 @@ static void perf_free_event(struct perf_event *event,
 }
 
 /*
- * Free an unexposed, unused context as created by inheritance by
- * perf_event_init_task below, used by fork() in case of fail.
+ * Free a context as created by inheritance by perf_event_init_task() below,
+ * used by fork() in case of fail.
  *
- * Not all locks are strictly required, but take them anyway to be nice and
- * help out with the lockdep assertions.
+ * Even though the task has never lived, the context and events have been
+ * exposed through the child_list, so we must take care tearing it all down.
  */
 void perf_event_free_task(struct task_struct *task)
 {
@@ -11546,7 +11563,23 @@ void perf_event_free_task(struct task_struct *task)
 			perf_free_event(event, ctx);
 
 		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
+
+		/*
+		 * perf_event_release_kernel() could've stolen some of our
+		 * child events and still have them on its free_list. In that
+		 * case we must wait for these events to have been freed (in
+		 * particular all their references to this task must've been
+		 * dropped).
+		 *
+		 * Without this copy_process() will unconditionally free this
+		 * task (irrespective of its reference count) and
+		 * _free_event()'s put_task_struct(event->hw.target) will be a
+		 * use-after-free.
+		 *
+		 * Wait for all events to drop their context reference.
+		 */
+		wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
+		put_ctx(ctx); /* must be last */
 	}
 }
 

