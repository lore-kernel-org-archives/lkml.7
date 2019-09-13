Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CF2205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbfIMNbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:31:03 -0400
Received: from foss.arm.com ([217.140.110.172]:43714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388620AbfIMNbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:31:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BAD1000;
        Fri, 13 Sep 2019 06:30:59 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DAB23F67D;
        Fri, 13 Sep 2019 06:30:58 -0700 (PDT)
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
References: <20190903103329.24961-1-qais.yousef@arm.com>
 <20190904072524.09de28aa@oasis.local.home>
 <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
Date:   Fri, 13 Sep 2019 14:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 4:40 PM, Qais Yousef wrote:
> On 09/04/19 07:25, Steven Rostedt wrote:
>> On Tue,  3 Sep 2019 11:33:29 +0100
>> Qais Yousef <qais.yousef@arm.com> wrote:

[...]

>>> @@ -1614,7 +1660,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>>>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>>>  {
>>>  	if (!task_running(rq, p) &&
>>> -	    cpumask_test_cpu(cpu, p->cpus_ptr))
>>> +	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
>>> +	    rt_task_fits_capacity(p, cpu))
>>
>> Hmm, so if a CPU goes idle, and looks for CPUS with more than one RT
>> task queued (overloaded), it will skip pulling RT tasks if they are
>> below capacity. Is that the desired effect? I think we could end up
>> with a small idle CPUs with RT tasks waiting to run.
> 
> The intention was not to pull this task that doesn't fit. But not to abort the
> whole pull operation. pick_highest_pushable_task() should still iterate through
> the remaining tasks, or did I miss something?

On a big.LITTLE system (6 CPUs with [446 1024 1024 446 466 466] CPU
capacity vector) I try to trace the handling of the 3rd big task
(big2-2, util_min: 800, util_max: 1024) of an rt-app workload running 3
of them.

rt_task_fits_capacity() call in:

tag 1: select_task_rq_rt(), 3-7: 1st till 5th in find_lowest_rq()

[   37.505325] rt_task_fits_capacity: CPU3 tag=1 [big2-2 285] ret=0
[   37.505882] find_lowest_rq: CPU3 [big2-2 285] tag=1 find_lowest_rq
[   37.506509] CPU3 [big2-2 285] lowest_mask=0,3-5
[   37.507971] rt_task_fits_capacity: CPU3 tag=3 [big2-2 285] ret=0
[   37.508200] rt_task_fits_capacity: CPU3 tag=4 [big2-2 285] ret=0
[   37.509486] rt_task_fits_capacity: CPU0 tag=5 [big2-2 285] ret=0
[   37.510191] rt_task_fits_capacity: CPU3 tag=5 [big2-2 285] ret=0
[   37.511334] rt_task_fits_capacity: CPU4 tag=5 [big2-2 285] ret=0
[   37.512194] rt_task_fits_capacity: CPU5 tag=5 [big2-2 285] ret=0
[   37.513210] rt_task_fits_capacity: CPU0 tag=6 [big2-2 285] ret=0
[   37.514085] rt_task_fits_capacity: CPU3 tag=7 [big2-2 285] ret=0
[   37.514732] --> select_task_rq_rt: CPU3 [big2-2 285] cpu=0

Since CPU 0,3-5 can't run big2-2, it takes up to the test that the
fitness hasn't changed. In case a capacity-aware (with fallback CPU)
cpupri_find() would have returned a suitable lowest_mask, less work
would have been needed.

The snippet is repeating itself for the whole run of the workload since
all the rt-tasks run for the same time and I'm only faking big.LITTLE on
qemu.

[...]

>>>  	rcu_read_lock();
>>>  	for_each_domain(cpu, sd) {
>>> @@ -1692,11 +1747,15 @@ static int find_lowest_rq(struct task_struct *task)
>>>  				return this_cpu;
>>>  			}
>>>  
>>> -			best_cpu = cpumask_first_and(lowest_mask,
>>> -						     sched_domain_span(sd));
>>> -			if (best_cpu < nr_cpu_ids) {
>>> -				rcu_read_unlock();
>>> -				return best_cpu;
>>> +			for_each_cpu_and(best_cpu, lowest_mask,
>>> +					 sched_domain_span(sd)) {
>>> +				if (best_cpu >= nr_cpu_ids)
>>
>> Can that happen in this loop?
> 
> I kept the condition that was originally here but inverted the logic so we
> don't mindlessly iterate through the rest of the CPUs. IOW, tried to retain the
> original behavior of `if (best_cpu < nr_cpu_ids)` logic.
> 
> Whether we can remove this check I don't know to be honest. Similar check exist
> below and I did wonder under what conditions this could happen but didn't try
> to follow the thread.
> 
> The only case I can think about is if we set nr_cpu_ids through command line
> to a lower value. Then if cpu_possible_mask and family aren't updated
> accordingly then yeah this check will protect against scheduling on cpus the
> users said they don't want to use? Just guessing.

Why don't you build the capacity awareness into cpupri_find(...,
lowest_mask)?
You would have to add a fallback strategy in case p doesn't fit on any
CPUs cpupri_find() returns today as lowest_mask. (return the CPU with
the max capacity).

Luca proposed something like this for SCHED_DEADLINE in "[RFC PATCH 0/6]
Capacity awareness for SCHED_DEADLINE" (patch 2/6 and 5/6)

https://lkml.kernel.org/r/20190506044836.2914-1-luca.abeni@santannapisa.it

In this case you could get rid of all the newly introduced
rt_task_fits_capacity() logic in find_lowest_rq().

---

I can't see the

for_each_domain(cpu, sd) {
	for_each_cpu_and(best_cpu, lowest_mask, sched_domain_span(sd)) {
                ...
	}
}

other than we want to pick a CPU from the lowest_mask first which is
closer to task_cpu(task).

Qemu doesn't give me cluster:

# cat /proc/sys/kernel/sched_domain/cpu0/domain*/name
MC

[...]
