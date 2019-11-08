Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36896FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12547206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKHRD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:03:26 -0500
Received: from foss.arm.com ([217.140.110.172]:47070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKHRDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:03:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D8831B;
        Fri,  8 Nov 2019 09:03:24 -0800 (PST)
Received: from e107158-lin (unknown [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5244F3F71A;
        Fri,  8 Nov 2019 09:03:23 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:03:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH 1/7] sched: Fix pick_next_task() vs change pattern race
Message-ID: <20191108170320.ckvvwqa2f45v2trv@e107158-lin>
References: <20191108131553.027892369@infradead.org>
 <20191108131909.428842459@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108131909.428842459@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/19 14:15, Peter Zijlstra wrote:
> Commit 67692435c411 ("sched: Rework pick_next_task() slow-path")
> inadvertly introduced a race because it changed a previously
> unexplored dependency between dropping the rq->lock and
> sched_class::put_prev_task().
> 
> The comments about dropping rq->lock, in for example
> newidle_balance(), only mentions the task being current and ->on_cpu
> being set. But when we look at the 'change' pattern (in for example
> sched_setnuma()):
> 
> 	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
> 	running = task_current(rq, p); /* rq->curr == p */
> 
> 	if (queued)
> 		dequeue_task(...);
> 	if (running)
> 		put_prev_task(...);
> 
> 	/* change task properties */
> 
> 	if (queued)
> 		enqueue_task(...);
> 	if (running)
> 		set_next_task(...);
> 
> It becomes obvious that if we do this after put_prev_task() has
> already been called on @p, things go sideways. This is exactly what
> the commit in question allows to happen when it does:
> 
> 	prev->sched_class->put_prev_task(rq, prev, rf);
> 	if (!rq->nr_running)
> 		newidle_balance(rq, rf);
> 
> The newidle_balance() call will drop rq->lock after we've called
> put_prev_task() and that allows the above 'change' pattern to
> interleave and mess up the state.
> 
> Furthermore, it turns out we lost the RT-pull when we put the last DL
> task.
> 
> Fix both problems by extracting the balancing from put_prev_task() and
> doing a multi-class balance() pass before put_prev_task().
> 
> Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

This feels more fluent and less delicate than the previous approach for sure.

Spinning the whole series in my reproducer at the minute.

Thinking ahead, can we do something to help us debug/spot this in a better way
in the future?

I'm thinking maybe something like

	save_rq_state();
	rq_unlock();

	.
	.
	.

	rq_lock();
	assert_rq_state(); /* Bug here if something we don't expect has changed
			      when the lock wasn't held */

might help us verify no one has tried to change the state of the rq when the
lock wasn't held.

At least this will help us catch races like this closer to the point where
things go wrong.

We might as well annotate the functions that modify the state of the rq to help
debug the sequence of events?

Happy to carry out the work if there's anything sensible that we can actually
do.

Cheers

--
Qais Yousef
