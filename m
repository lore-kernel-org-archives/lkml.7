Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E05C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5E2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:44:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGIOob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:44:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED8D228;
        Tue,  9 Jul 2019 07:44:30 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68C7B3F246;
        Tue,  9 Jul 2019 07:44:24 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
To:     luca abeni <luca.abeni@santannapisa.it>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
 <20190708135536.GK3402@hirez.programming.kicks-ass.net>
 <20190709152436.51825f98@luca64>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <88792079-925f-d334-0fc5-ee11458a7608@arm.com>
Date:   Tue, 9 Jul 2019 16:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709152436.51825f98@luca64>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 3:24 PM, luca abeni wrote:
> Hi Peter,
> 
> On Mon, 8 Jul 2019 15:55:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Mon, May 06, 2019 at 06:48:33AM +0200, Luca Abeni wrote:
>>> @@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
>>>  			dl_se->dl_overrun = 1;
>>>  
>>>  		__dequeue_task_dl(rq, curr, 0);
>>> -		if (unlikely(dl_se->dl_boosted
>>> || !start_dl_timer(curr)))
>>> +		if (unlikely(dl_se->dl_boosted
>>> || !start_dl_timer(curr))) { enqueue_task_dl(rq, curr,
>>> ENQUEUE_REPLENISH); +#ifdef CONFIG_SMP
>>> +		} else if (dl_se->dl_adjust) {
>>> +			if (rq->migrating_task == NULL) {
>>> +				queue_balance_callback(rq,
>>> &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);  
>>
>> I'm not entirely sure about this one.
>>
>> That is, we only do those callbacks from:
>>
>>   schedule_tail()
>>   __schedule()
>>   rt_mutex_setprio()
>>   __sched_setscheduler()
>>
>> and the above looks like it can happen outside of those.
> 
> Sorry, I did not know the constraints or requirements for using
> queue_balance_callback()...
> 
> I used it because I wanted to trigger a migration from
> update_curr_dl(), but invoking double_lock_balance() from this function
> obviously resulted in a warning. So, I probably misunderstood the
> purpose of the balance callback API, and I misused it.
> 
> What would have been the "right way" to trigger a migration for a task
> when it is throttled?
> 
> 
>>
>> The pattern in those sites is:
>>
>> 	rq_lock();
>> 	... do crap that leads to queue_balance_callback()
>> 	rq_unlock()
>> 	if (rq->balance_callback) {
>> 		raw_spin_lock_irqsave(rq->lock, flags);
>> 		... do callbacks
>> 		raw_spin_unlock_irqrestore(rq->lock, flags);
>> 	}
>>
>> So I suppose can catch abuse of this API by doing something like the
>> below; can you validate?
> 
> Sorry; right now I cannot run tests on big.LITTLE machines... 
> Maybe Dietmar (added in cc), who is working on mainlining this patcset,
> can test?

I do see this one triggering (on ARM64 (Juno, 2 big/4 LITTLE,
performance CPUfreq gov, CPU_IDLE disabled):

1 deadline tasks (12000, 100000, 100000)

but the warnings come out of the pi, CFS and tick code?

[   70.190812] WARNING: CPU: 0 PID: 3550 at kernel/sched/sched.h:1145
task_rq_lock+0xe8/0xf0
...
[   70.310931] Call trace:
[   70.313352]  task_rq_lock+0xe8/0xf0
[   70.316808]  inactive_task_timer+0x48/0x4f0
[   70.320951]  __hrtimer_run_queues+0x11c/0x3d0
[   70.325265]  hrtimer_interrupt+0xd8/0x248
[   70.329236]  arch_timer_handler_phys+0x38/0x58
[   70.333637]  handle_percpu_devid_irq+0x90/0x2b8
[   70.338123]  generic_handle_irq+0x34/0x50
[   70.342093]  __handle_domain_irq+0x68/0xc0
[   70.346149]  gic_handle_irq+0x60/0xb0
[   70.349773]  el1_irq+0xbc/0x180
[   70.352884]  _raw_spin_unlock_irqrestore+0x64/0x90
[   70.357629]  rt_mutex_adjust_pi+0x4c/0xb0
[   70.361599]  __sched_setscheduler+0x49c/0x830
[   70.365912]  _sched_setscheduler+0x98/0xc0
[   70.369967]  do_sched_setscheduler+0xb4/0x118
[   70.374281]  __arm64_sys_sched_setscheduler+0x28/0x40
[   70.379285]  el0_svc_common.constprop.0+0x7c/0x178
[   70.384029]  el0_svc_handler+0x34/0x90
[   70.387739]  el0_svc+0x8/0xc
...
[   70.395177] WARNING: CPU: 4 PID: 43 at kernel/sched/sched.h:1145
update_blocked_averages+0x924/0x998
...
[   70.523815] Call trace:
[   70.526236]  update_blocked_averages+0x924/0x998
[   70.530807]  update_nohz_stats+0x78/0xa0
[   70.534690]  find_busiest_group+0x5f0/0xc18
[   70.538831]  load_balance+0x174/0xbc0
[   70.542456]  pick_next_task_fair+0x34c/0x740
[   70.546683]  __schedule+0x130/0x690
[   70.550136]  schedule+0x38/0xc0
[   70.553246]  worker_thread+0xc8/0x458
[   70.556872]  kthread+0x130/0x138
[   70.560067]  ret_from_fork+0x10/0x1c
...
[   70.568191] WARNING: CPU: 0 PID: 3550 at kernel/sched/sched.h:1145
scheduler_tick+0x110/0x118
...
[   70.690607] Call trace:
[   70.693029]  scheduler_tick+0x110/0x118
[   70.696826]  update_process_times+0x48/0x60
[   70.700968]  tick_sched_handle.isra.5+0x44/0x68
[   70.705451]  tick_sched_timer+0x50/0xa0
[   70.709249]  __hrtimer_run_queues+0x11c/0x3d0
[   70.713562]  hrtimer_interrupt+0xd8/0x248
[   70.717531]  arch_timer_handler_phys+0x38/0x58
[   70.721930]  handle_percpu_devid_irq+0x90/0x2b8
[   70.726416]  generic_handle_irq+0x34/0x50
[   70.730385]  __handle_domain_irq+0x68/0xc0
[   70.734439]  gic_handle_irq+0x60/0xb0
[   70.738063]  el1_irq+0xbc/0x180
[   70.741172]  _raw_spin_unlock_irqrestore+0x64/0x90
[   70.745916]  rt_mutex_adjust_pi+0x4c/0xb0
[   70.749885]  __sched_setscheduler+0x49c/0x830
[   70.754198]  _sched_setscheduler+0x98/0xc0
[   70.758253]  do_sched_setscheduler+0xb4/0x118
[   70.762567]  __arm64_sys_sched_setscheduler+0x28/0x40
[   70.767569]  el0_svc_common.constprop.0+0x7c/0x178
[   70.772312]  el0_svc_handler+0x34/0x90
[   70.776022]  el0_svc+0x8/0xc
