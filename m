Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40280C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9BF20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfGKPdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:33:08 -0400
Received: from foss.arm.com ([217.140.110.172]:47566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfGKPdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:33:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B429A2B;
        Thu, 11 Jul 2019 08:33:07 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB913F71F;
        Thu, 11 Jul 2019 08:33:04 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org,
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
 <20190709134200.GD3402@hirez.programming.kicks-ass.net>
 <dac4462d-7384-cf8a-6619-2781c16caa89@arm.com>
 <20190711120041.GA3402@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <aef12a88-a7c8-3cf6-1253-eca06d2d6555@arm.com>
Date:   Thu, 11 Jul 2019 17:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711120041.GA3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/19 2:00 PM, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 01:17:17PM +0200, Dietmar Eggemann wrote:
>> On 7/9/19 3:42 PM, Peter Zijlstra wrote:
> 
>>>>> That is, we only do those callbacks from:
>>>>>
>>>>>   schedule_tail()
>>>>>   __schedule()
>>>>>   rt_mutex_setprio()
>>>>>   __sched_setscheduler()
>>>>>
>>>>> and the above looks like it can happen outside of those.
> 
>> Is this what you are concerned about?
>>
>> (2 Cpus (CPU1, CPU2), 4 deadline task (thread0-X)) with 
>>
>> @@ -1137,6 +1137,13 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>>         rf->cookie = lockdep_pin_lock(&rq->lock);
>>  
>>  #ifdef CONFIG_SCHED_DEBUG
>> +#ifdef CONFIG_SMP
>> +       /*
>> +        * There should not be pending callbacks at the start of rq_lock();
>> +        * all sites that handle them flush them at the end.
>> +        */
>> +       WARN_ON_ONCE(rq->balance_callback);
>> +#endif
>>
>>
>> [   87.251237] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-3 3627] on CPU2
>> [   87.251261] WARNING: CPU: 2 PID: 3627 at kernel/sched/sched.h:1145 __schedule+0x56c/0x690
>> [   87.615882] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 task_rq_lock+0xe8/0xf0
>> [   88.176844] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x4d0/0xbc0
>> [   88.381905] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x7d8/0xbc0
> 
> I'm not sure how we get 4 warns, I was thinking that as soon as we exit
> __schedule() we'd procress the callback so further warns would be
> avoided.

Reducing the warning to only fire on CPU1 I got another test-run:

[ 6688.373607] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-3 4343] on CPU1
[ 6688.381557] WARNING: CPU: 1 PID: 4343 at kernel/sched/sched.h:1146 try_to_wake_up+0x614/0x788
...
[ 6688.505000]  try_to_wake_up+0x614/0x788
[ 6688.508794]  default_wake_function+0x34/0x48
[ 6688.513017]  autoremove_wake_function+0x3c/0x68
[ 6688.517497]  __wake_up_common+0x90/0x158
[ 6688.521374]  __wake_up_common_lock+0x88/0xd0
[ 6688.525595]  __wake_up+0x40/0x50
[ 6688.528787]  wake_up_klogd_work_func+0x4c/0x88
[ 6688.533184]  irq_work_run_list+0x8c/0xd8
[ 6688.537063]  irq_work_tick+0x48/0x60
[ 6688.540598]  update_process_times+0x44/0x60
[ 6688.544735]  tick_sched_handle.isra.5+0x44/0x68
[ 6688.549215]  tick_sched_timer+0x50/0xa0
[ 6688.553007]  __hrtimer_run_queues+0x11c/0x3d0
[ 6688.557316]  hrtimer_interrupt+0xd8/0x248
[ 6688.561282]  arch_timer_handler_phys+0x38/0x58
[ 6688.565678]  handle_percpu_devid_irq+0x90/0x2b8
[ 6688.570160]  generic_handle_irq+0x34/0x50
[ 6688.574124]  __handle_domain_irq+0x68/0xc0
[ 6688.578175]  gic_handle_irq+0x60/0xb0
...
[ 6688.589909] WARNING: CPU: 1 PID: 4343 at kernel/sched/sched.h:1146 scheduler_tick+0xe8/0x128
...
[ 6688.714463]  scheduler_tick+0xe8/0x128
[ 6688.718170]  update_process_times+0x48/0x60
[ 6688.722306]  tick_sched_handle.isra.5+0x44/0x68
[ 6688.726786]  tick_sched_timer+0x50/0xa0
[ 6688.730579]  __hrtimer_run_queues+0x11c/0x3d0
[ 6688.734887]  hrtimer_interrupt+0xd8/0x248
[ 6688.738852]  arch_timer_handler_phys+0x38/0x58
[ 6688.743246]  handle_percpu_devid_irq+0x90/0x2b8
[ 6688.747727]  generic_handle_irq+0x34/0x50
[ 6688.751692]  __handle_domain_irq+0x68/0xc0
[ 6688.755741]  gic_handle_irq+0x60/0xb0
...
[ 6688.767476] WARNING: CPU: 1 PID: 4343 at kernel/sched/sched.h:1146 task_rq_lock+0xc0/0x100
...
[ 6688.891511]  task_rq_lock+0xc0/0x100
[ 6688.895046]  dl_task_timer+0x48/0x2c8
[ 6688.898666]  __hrtimer_run_queues+0x11c/0x3d0
[ 6688.902975]  hrtimer_interrupt+0xd8/0x248
[ 6688.906939]  arch_timer_handler_phys+0x38/0x58
[ 6688.911334]  handle_percpu_devid_irq+0x90/0x2b8
[ 6688.915815]  generic_handle_irq+0x34/0x50
[ 6688.919779]  __handle_domain_irq+0x68/0xc0
[ 6688.923828]  gic_handle_irq+0x60/0xb0
...
[ 6688.944618] WARNING: CPU: 1 PID: 4343 at kernel/sched/sched.h:1146 update_blocked_averages+0x84c/0x9a0
...
[ 6689.071664]  update_blocked_averages+0x84c/0x9a0
[ 6689.076231]  run_rebalance_domains+0x74/0xb0
[ 6689.080452]  __do_softirq+0x154/0x3f0
[ 6689.084074]  irq_exit+0xf0/0xf8
[ 6689.087178]  __handle_domain_irq+0x6c/0xc0
[ 6689.091228]  gic_handle_irq+0x60/0xb0
...
[ 6689.303143] WARNING: CPU: 1 PID: 4343 at kernel/sched/sched.h:1146 __schedule+0x478/0x698
...
[ 6689.440861]  __schedule+0x478/0x698
[ 6689.444310]  schedule+0x38/0xc0
[ 6689.447416]  do_notify_resume+0x88/0x380
[ 6689.451294]  work_pending+0x8/0x14
...
[ 6689.459256] *** ---> migrate_dl_task() p=[thread0-3 4343] to CPU-1

> 
>> [   88.586991] *** ---> migrate_dl_task() p=[thread0-3 3627] to CPU1
> 
> But yes, something like this. Basucally I want to avoid calling
> queue_balance_callback() from a context where we'll not follow up with
> balance_callback().

Understood.
