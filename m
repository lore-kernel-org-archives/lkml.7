Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2962C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B71821924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKHQFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:05:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:05:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0908E46A;
        Fri,  8 Nov 2019 08:05:33 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63B4D3F71A;
        Fri,  8 Nov 2019 08:05:31 -0800 (PST)
Subject: Re: [PATCH 1/7] sched: Fix pick_next_task() vs change pattern race
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        qais.yousef@arm.com, ktkhai@virtuozzo.com
References: <20191108131553.027892369@infradead.org>
 <20191108131909.428842459@infradead.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e19c566b-dc14-a5aa-de4f-c67cdb17620c@arm.com>
Date:   Fri, 8 Nov 2019 16:05:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108131909.428842459@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 13:15, Peter Zijlstra wrote:
> Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I've been running the same reproducer as Quentin's for a similar length of
time (~3h) and it's still going strong, so FWIW:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/core.c      |   21 +++++++++++++++------
>  kernel/sched/deadline.c  |   40 ++++++++++++++++++++--------------------
>  kernel/sched/fair.c      |   15 ++++++++++++---
>  kernel/sched/idle.c      |    9 ++++++++-
>  kernel/sched/rt.c        |   37 +++++++++++++++++++------------------
>  kernel/sched/sched.h     |   30 +++++++++++++++++++++++++++---
>  kernel/sched/stop_task.c |   18 +++++++++++-------
>  7 files changed, 112 insertions(+), 58 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3929,13 +3929,22 @@ pick_next_task(struct rq *rq, struct tas
>  	}
>  
>  restart:
> +#ifdef CONFIG_SMP

I suppose we could dump that in a core balance_prev_task() to avoid the
inline #ifdeffery, but eh...

>  	/*
> -	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> -	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> +	 * We must do the balancing pass before put_next_task(), such
> +	 * that when we release the rq->lock the task is in the same
> +	 * state as before we took rq->lock.
> +	 *
> +	 * We can terminate the balance pass as soon as we know there is
> +	 * a runnable task of @class priority or higher.
>  	 */
> -	prev->sched_class->put_prev_task(rq, prev, rf);
> -	if (!rq->nr_running)
> -		newidle_balance(rq, rf);
> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +
> +	put_prev_task(rq, prev);
>  
>  	for_each_class(class) {
>  		p = class->pick_next_task(rq, NULL, NULL);

> @@ -1469,6 +1469,22 @@ static void check_preempt_equal_prio(str
>  	resched_curr(rq);
>  }
>  
> +static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
> +{
> +	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
> +		/*
> +		 * This is OK, because current is on_cpu, which avoids it being
> +		 * picked for load-balance and preemption/IRQs are still
> +		 * disabled avoiding further scheduler activity on it and we've
> +		 * not yet started the picking loop.
> +		 */
> +		rq_unpin_lock(rq, rf);
> +		pull_rt_task(rq);
> +		rq_repin_lock(rq, rf);
> +	}
> +
> +	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);

So we already have some dependencies on the class ordering (e.g. fair->idle),
but I'm wondering if would it make sense to have these runnable functions be
defined as sched_class callbacks?

e.g.

  rt_sched_class.runnable = rt_runnable

w/ rt_runnable() just being a non-inlined sched_rt_runnable() you define
further down the patch (or a wrapper to it). The balance return pattern could
then become:

  for_class_range(class, sched_class_highest, rt_sched_class->next)
  	if (class->runnable(rq))
		return true;
  return false;

(and replace rt_sched_class by whatever class' balance callback this is)

It's a bit neater, but I'm pretty sure it's going to run worse :/
The only unaffected one would be fair, since newidle_balance() already does
that "for free".

> +}
>  #endif /* CONFIG_SMP */
>  
>  /*
