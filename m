Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03819CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE122080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfJ3L5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:57:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfJ3L5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:57:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABDA51F1;
        Wed, 30 Oct 2019 04:57:12 -0700 (PDT)
Received: from [172.16.30.112] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25B213F71E;
        Wed, 30 Oct 2019 04:57:11 -0700 (PDT)
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20191009104611.15363-1-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <39c08971-5d07-8018-915b-9c6284f89d5d@arm.com>
Date:   Wed, 30 Oct 2019 12:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.19 12:46, Qais Yousef wrote:

[...]

> Changes in v2:
> 	- Use cpupri_find() to check the fitness of the task instead of
> 	  sprinkling find_lowest_rq() with several checks of
> 	  rt_task_fits_capacity().
> 
> 	  The selected implementation opted to pass the fitness function as an
> 	  argument rather than call rt_task_fits_capacity() capacity which is
> 	  a cleaner to keep the logical separation of the 2 modules; but it
> 	  means the compiler has less room to optimize rt_task_fits_capacity()
> 	  out when it's a constant value.

I would prefer exporting rt_task_fits_capacity() sched-internally via
kernel/sched/sched.h. Less code changes and the indication whether
rt_task_fits_capacity() has to be used in cpupri_find() is already given
by lowest_mask being !NULL or NULL.

[...]

> +inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> +{
> +	unsigned int min_cap;
> +	unsigned int max_cap;
> +	unsigned int cpu_cap;

Nit picking. Since we discussed it already,

I found this "Also please try to aggregate variables of the same type
into a single line. There is no point in wasting screen space::" ;-)

https://lore.kernel.org/r/20181107171149.165693799@linutronix.de

[...]

> @@ -2223,7 +2273,10 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (task_on_rq_queued(p) && rq->curr != p) {
>  #ifdef CONFIG_SMP
> -		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
> +		bool need_to_push = rq->rt.overloaded ||
> +				    !rt_task_fits_capacity(p, cpu_of(rq));
> +
> +		if (p->nr_cpus_allowed > 1 && need_to_push)
>  			rt_queue_push_tasks(rq);
>  #endif /* CONFIG_SMP */
>  		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
What happens to a always running CFS task which switches to RT? Luca
introduced a special migrate callback (next to push and pull)
specifically to deal with this scenario. A lot of new infrastructure for
this one use case, but still, do we care for it in RT as well?

https://lore.kernel.org/r/20190506044836.2914-4-luca.abeni@santannapisa.it

