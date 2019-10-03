Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BBC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3DB222CE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbfJCQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:26:09 -0400
Received: from foss.arm.com ([217.140.110.172]:48920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390979AbfJCQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0722D1000;
        Thu,  3 Oct 2019 09:25:54 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C883F739;
        Thu,  3 Oct 2019 09:25:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7bd9506b-9930-0bf8-a024-8c7d7d8bf86e@arm.com>
Date:   Thu, 3 Oct 2019 18:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Steven Rostedt <rostedt@goodmis.org>]

On 29/08/2019 05:15, Jing-Ting Wu wrote:
> At original linux design, RT & CFS scheduler are independent.
> Current RT task placement policy will select the first cpu in
> lowest_mask, even if the first CPU is running a CFS task.
> This may put RT task to a running cpu and let CFS task runnable.
> 
> So we select idle cpu in lowest_mask first to avoid preempting
> CFS task.
> 
> Signed-off-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> ---
>  kernel/sched/rt.c |   42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a532558..626ca27 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1388,7 +1388,6 @@ static void yield_task_rt(struct rq *rq)
>  static int
>  select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
>  {
> -	struct task_struct *curr;
>  	struct rq *rq;
>  
>  	/* For anything but wake ups, just return the task_cpu */
> @@ -1398,33 +1397,15 @@ static void yield_task_rt(struct rq *rq)
>  	rq = cpu_rq(cpu);
>  
>  	rcu_read_lock();
> -	curr = READ_ONCE(rq->curr); /* unlocked access */
>  
>  	/*
> -	 * If the current task on @p's runqueue is an RT task, then
> -	 * try to see if we can wake this RT task up on another
> -	 * runqueue. Otherwise simply start this RT task
> -	 * on its current runqueue.
> -	 *
> -	 * We want to avoid overloading runqueues. If the woken
> -	 * task is a higher priority, then it will stay on this CPU
> -	 * and the lower prio task should be moved to another CPU.
> -	 * Even though this will probably make the lower prio task
> -	 * lose its cache, we do not want to bounce a higher task
> -	 * around just because it gave up its CPU, perhaps for a
> -	 * lock?
> -	 *
> -	 * For equal prio tasks, we just let the scheduler sort it out.
> -	 *
> -	 * Otherwise, just let it ride on the affined RQ and the
> -	 * post-schedule router will push the preempted task away
> -	 *
> -	 * This test is optimistic, if we get it wrong the load-balancer
> -	 * will have to sort it out.
> +	 * If the task p is allowed to put more than one CPU or
> +	 * it is not allowed to put on this CPU.
> +	 * Let p use find_lowest_rq to choose other idle CPU first,
> +	 * instead of choose this cpu and preempt curr cfs task.
>  	 */
> -	if (curr && unlikely(rt_task(curr)) &&
> -	    (curr->nr_cpus_allowed < 2 ||
> -	     curr->prio <= p->prio)) {
> +	if ((p->nr_cpus_allowed > 1) ||
> +	    (!cpumask_test_cpu(cpu, p->cpus_ptr))) {
>  		int target = find_lowest_rq(p);

I'm sure RT folks don't like the idea to change this condition.

I remember a similar approach and Steven Rostedt NAKed the idea back:

https://lore.kernel.org/r/1415099585-31174-2-git-send-email-pang.xunlei@linaro.org

Back then, Xunlei Pang even tried to create a lower mask of idle CPUs,
for find_lower_mask() to return:

https://lore.kernel.org/r/1415099585-31174-1-git-send-email-pang.xunlei@linaro.org

[...]
