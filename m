Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12CFC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfJh/Lv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfFGOXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:23:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46852 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbfFGOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8BZurWN5noKI/9IXnmPT/gb9mEzJQ8dX7lvEoO1HhTU=; b=IfJh/Lv7pwWNCCj3t156wPCtZ
        R4u9ktCYkNG0VPE3JJ0oCDWm6cZbGx6qAT/S5KDdFRg42oxtgcubdJ6UXAh6qJBsgA6WYf+2vYDqi
        A6g6E8rhYByaq2+SiJTPJSEgGYx5jAHaCmliTYMk9wC2JdjxEycTezJ6pydHOXKGMSweMpP7KWW0R
        hfDmdIv7Xa0+V0riPI+Xi7q7eb0GGaqE7DRdYndXS8lF9AbJ5TqDBage5UXo21RZef5RIdU4YmJ5o
        yOaa/SsjedwPYhfSUwF3/wVMAs8C0XMNHDmlUKaf8IzslU8alOFHtsq2IS0E7CGm6jwR8fiecNIKT
        K13hDQNtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZFmI-0001mu-M0; Fri, 07 Jun 2019 14:23:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03295202CD6B2; Fri,  7 Jun 2019 16:23:32 +0200 (CEST)
Date:   Fri, 7 Jun 2019 16:23:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190607142332.GF3463@hirez.programming.kicks-ass.net>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:35:41PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 05, 2019 at 09:04:02AM -0600, Jens Axboe wrote:
> > How about the following plan - if folks are happy with this sched patch,
> > we can queue it up for 5.3. Once that is in, I'll kill the block change
> > that special cases the polled task wakeup. For 5.2, we go with Oleg's
> > patch for the swap case.
> 
> OK, works for me. I'll go write a proper patch.

I now have the below; I'll queue that after the long weekend and let
0-day chew on it for a while and then push it out to tip or something.


---
Subject: sched: Optimize try_to_wake_up() for local wakeups
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Jun 7 15:39:49 CEST 2019

Jens reported that significant performance can be had on some block
workloads (XXX numbers?) by special casing local wakeups. That is,
wakeups on the current task before it schedules out. Given something
like the normal wait pattern:

	for (;;) {
		set_current_state(TASK_UNINTERRUPTIBLE);

		if (cond)
			break;

		schedule();
	}
	__set_current_state(TASK_RUNNING);

Any wakeup (on this CPU) after set_current_state() and before
schedule() would benefit from this.

Normal wakeups take p->pi_lock, which serializes wakeups to the same
task. By eliding that we gain concurrency on:

 - ttwu_stat(); we already had concurrency on rq stats, this now also
   brings it to task stats. -ENOCARE

 - tracepoints; it is now possible to get multiple instances of
   trace_sched_waking() (and possibly trace_sched_wakeup()) for the
   same task. Tracers will have to learn to cope.

Furthermore, p->pi_lock is used by set_special_state(), to order
against TASK_RUNNING stores from other CPUs. But since this is
strictly CPU local, we don't need the lock, and set_special_state()'s
disabling of IRQs is sufficient.

After the normal wakeup takes p->pi_lock it issues
smp_mb__after_spinlock(), in order to ensure the woken task must
observe prior stores before we observe the p->state. If this is CPU
local, this will be satisfied with a compiler barrier, and we rely on
try_to_wake_up() being a funcation call, which implies such.

Since, when 'p == current', 'p->on_rq' must be true, the normal wakeup
would continue into the ttwu_remote() branch, which normally is
concerned with exactly this wakeup scenario, except from a remote CPU.
IOW we're waking a task that is still running. In this case, we can
trivially avoid taking rq->lock, all that's left from this is to set
p->state.

This then yields an extremely simple and fast path for 'p == current'.

Cc: Qian Cai <cai@lca.pw>
Cc: mingo@redhat.com
Cc: akpm@linux-foundation.org
Cc: hch@lst.de
Cc: gkohli@codeaurora.org
Cc: oleg@redhat.com
Reported-by: Jens Axboe <axboe@kernel.dk>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1991,6 +1991,28 @@ try_to_wake_up(struct task_struct *p, un
 	unsigned long flags;
 	int cpu, success = 0;
 
+	if (p == current) {
+		/*
+		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
+		 * == smp_processor_id()'. Together this means we can special
+		 * case the whole 'p->on_rq && ttwu_remote()' case below
+		 * without taking any locks.
+		 *
+		 * In particular:
+		 *  - we rely on Program-Order guarantees for all the ordering,
+		 *  - we're serialized against set_special_state() by virtue of
+		 *    it disabling IRQs (this allows not taking ->pi_lock).
+		 */
+		if (!(p->state & state))
+			return false;
+
+		success = 1;
+		trace_sched_waking(p);
+		p->state = TASK_RUNNING;
+		trace_sched_wakeup(p);
+		goto out;
+	}
+
 	/*
 	 * If we are going to wake up a thread waiting for CONDITION we
 	 * need to ensure that CONDITION=1 done by the caller can not be
@@ -2000,7 +2022,7 @@ try_to_wake_up(struct task_struct *p, un
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
 	if (!(p->state & state))
-		goto out;
+		goto unlock;
 
 	trace_sched_waking(p);
 
@@ -2030,7 +2052,7 @@ try_to_wake_up(struct task_struct *p, un
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
-		goto stat;
+		goto unlock;
 
 #ifdef CONFIG_SMP
 	/*
@@ -2090,10 +2112,11 @@ try_to_wake_up(struct task_struct *p, un
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
-stat:
-	ttwu_stat(p, cpu, wake_flags);
-out:
+unlock:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+out:
+	if (success)
+		ttwu_stat(p, cpu, wake_flags);
 
 	return success;
 }
