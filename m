Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F4C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0206207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J+vEfqs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgAGMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:42:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tNvA/ZnFUeVceHdwNAa5eO3T/shQN6WOfvB6s2kw0ec=; b=J+vEfqs3glC86B45f7JjTnfV2
        MYUYbTjyL2e6zVQnX2fuCZJl23TO6XY4X1Dof0LrLicZ6ECfwAvmTiQB/hjMTVFakIYDqtMyKJLdK
        AHD8x7Uu0T3YSBNVL6sZfaPiMbLygFOiseMKkOVmMdaErxGdqJRgqrXKuWs1T4opHZ8Uil55fdRjE
        WFXyHPpk8FYN/LfoOArBMyYruBIN3q7Cz5F6Hhj/RL8NDkeE5NO3JMjZ7WuWHuMJHbKjpNPUGC8Zj
        DOSdui/eeOTeaGtJgNJ39kvAocwqS0JBWEA7bnoU5jq7q4GQ6wQVsnxk1e+9fQeD490beYQRGtbi3
        v1qGCAo7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iooC7-0002Zn-1u; Tue, 07 Jan 2020 12:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68F0730025A;
        Tue,  7 Jan 2020 13:41:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9C4C2B26EAAF; Tue,  7 Jan 2020 13:42:44 +0100 (CET)
Date:   Tue, 7 Jan 2020 13:42:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Load balance aggressively for SCHED_IDLE CPUs
Message-ID: <20200107124244.GY2844@hirez.programming.kicks-ass.net>
References: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885b1be9af68d124f44a863f54e337f8eb6c4917.1577090998.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 10:43:30AM +0530, Viresh Kumar wrote:
> The fair scheduler performs periodic load balance on every CPU to check
> if it can pull some tasks from other busy CPUs. The duration of this
> periodic load balance is set to sd->balance_interval for the idle CPUs
> and is calculated by multiplying the sd->balance_interval with the
> sd->busy_factor (set to 32 by default) for the busy CPUs. The
> multiplication is done for busy CPUs to avoid doing load balance too
> often and rather spend more time executing actual task. While that is
> the right thing to do for the CPUs busy with SCHED_OTHER or SCHED_BATCH
> tasks, it may not be the optimal thing for CPUs running only SCHED_IDLE
> tasks.
> 
> With the recent enhancements in the fair scheduler around SCHED_IDLE
> CPUs, we now prefer to enqueue a newly-woken task to a SCHED_IDLE
> CPU instead of other busy or idle CPUs. The same reasoning should be
> applied to the load balancer as well to make it migrate tasks more
> aggressively to a SCHED_IDLE CPU, as that will reduce the scheduling
> latency of the migrated (SCHED_OTHER) tasks.
> 
> This patch makes minimal changes to the fair scheduler to do the next
> load balance soon after the last non SCHED_IDLE task is dequeued from a
> runqueue, i.e. making the CPU SCHED_IDLE. Also the sd->busy_factor is
> ignored while calculating the balance_interval for such CPUs. This is
> done to avoid delaying the periodic load balance by few hundred
> milliseconds for SCHED_IDLE CPUs.
> 
> This is tested on ARM64 Hikey620 platform (octa-core) with the help of
> rt-app and it is verified, using kernel traces, that the newly
> SCHED_IDLE CPU does load balancing shortly after it becomes SCHED_IDLE
> and pulls tasks from other busy CPUs.

Nothing seems really objectionable here; I have a few comments below.

Vincent?


> @@ -5324,6 +5336,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	struct sched_entity *se = &p->se;
>  	int task_sleep = flags & DEQUEUE_SLEEP;
>  	int idle_h_nr_running = task_has_idle_policy(p);
> +	bool was_sched_idle = sched_idle_rq(rq);
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> @@ -5370,6 +5383,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!se)
>  		sub_nr_running(rq, 1);
>  
> +	/* balance early to pull high priority tasks */
> +	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
> +		rq->next_balance = jiffies;
> +
>  	util_est_dequeue(&rq->cfs, p, task_sleep);
>  	hrtick_update(rq);
>  }

This can effectively set ->next_balance in the past, but given we only
tickle the balancer on every jiffy edge, that is of no concern. It just
made me stumble when reading this.

Not sure it even deserves a comment or not..

> @@ -9531,6 +9539,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  {
>  	int continue_balancing = 1;
>  	int cpu = rq->cpu;
> +	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
>  	unsigned long interval;
>  	struct sched_domain *sd;
>  	/* Earliest time when we have to do rebalance again */
> @@ -9567,7 +9576,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  			break;
>  		}
>  
> -		interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
> +		interval = get_sd_balance_interval(sd, busy);
>  
>  		need_serialize = sd->flags & SD_SERIALIZE;
>  		if (need_serialize) {
> @@ -9582,10 +9591,16 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  				 * env->dst_cpu, so we can't know our idle
>  				 * state even if we migrated tasks. Update it.
>  				 */
> -				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
> +				if (idle_cpu(cpu)) {
> +					idle = CPU_IDLE;
> +					busy = 0;
> +				} else {
> +					idle = CPU_NOT_IDLE;
> +					busy = !sched_idle_cpu(cpu);
> +				}

This is inconsistent vs the earlier code. That is, why not write it
like:

				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
				busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);

>  			}
>  			sd->last_balance = jiffies;
> -			interval = get_sd_balance_interval(sd, idle != CPU_IDLE);
> +			interval = get_sd_balance_interval(sd, busy);
>  		}
>  		if (need_serialize)
>  			spin_unlock(&balancing);
