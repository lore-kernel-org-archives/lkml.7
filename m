Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BFC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfGKLRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:17:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfGKLRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:17:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF801337;
        Thu, 11 Jul 2019 04:17:21 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4785D3F71F;
        Thu, 11 Jul 2019 04:17:19 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
To:     Peter Zijlstra <peterz@infradead.org>,
        luca abeni <luca.abeni@santannapisa.it>
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
 <20190709134200.GD3402@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dac4462d-7384-cf8a-6619-2781c16caa89@arm.com>
Date:   Thu, 11 Jul 2019 13:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709134200.GD3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 3:42 PM, Peter Zijlstra wrote:
> On Tue, Jul 09, 2019 at 03:24:36PM +0200, luca abeni wrote:
>> Hi Peter,
>>
>> On Mon, 8 Jul 2019 15:55:36 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Mon, May 06, 2019 at 06:48:33AM +0200, Luca Abeni wrote:
>>>> @@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
>>>>  			dl_se->dl_overrun = 1;
>>>>  
>>>>  		__dequeue_task_dl(rq, curr, 0);
>>>> -		if (unlikely(dl_se->dl_boosted
>>>> || !start_dl_timer(curr)))
>>>> +		if (unlikely(dl_se->dl_boosted
>>>> || !start_dl_timer(curr))) { enqueue_task_dl(rq, curr,
>>>> ENQUEUE_REPLENISH); +#ifdef CONFIG_SMP
>>>> +		} else if (dl_se->dl_adjust) {
>>>> +			if (rq->migrating_task == NULL) {
>>>> +				queue_balance_callback(rq,
>>>> &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);  
>>>
>>> I'm not entirely sure about this one.
>>>
>>> That is, we only do those callbacks from:
>>>
>>>   schedule_tail()
>>>   __schedule()
>>>   rt_mutex_setprio()
>>>   __sched_setscheduler()
>>>
>>> and the above looks like it can happen outside of those.
>>
>> Sorry, I did not know the constraints or requirements for using
>> queue_balance_callback()...
>>
>> I used it because I wanted to trigger a migration from
>> update_curr_dl(), but invoking double_lock_balance() from this function
>> obviously resulted in a warning. So, I probably misunderstood the
>> purpose of the balance callback API, and I misused it.
>>
>> What would have been the "right way" to trigger a migration for a task
>> when it is throttled?
> 
> I'm thinking we'll end up in schedule() pretty soon after a throttle to
> make 'current' go away, right? We could put the queue_balance_callback()
> in dequeue_task_dl() or something.

Is this what you are concerned about?

(2 Cpus (CPU1, CPU2), 4 deadline task (thread0-X)) with 

@@ -1137,6 +1137,13 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
        rf->cookie = lockdep_pin_lock(&rq->lock);
 
 #ifdef CONFIG_SCHED_DEBUG
+#ifdef CONFIG_SMP
+       /*
+        * There should not be pending callbacks at the start of rq_lock();
+        * all sites that handle them flush them at the end.
+        */
+       WARN_ON_ONCE(rq->balance_callback);
+#endif


[   87.251233] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-2 3626] on CPU1
[   87.251237] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-3 3627] on CPU2
[   87.251261] WARNING: CPU: 2 PID: 3627 at kernel/sched/sched.h:1145 __schedule+0x56c/0x690
[   87.259173] WARNING: CPU: 1 PID: 3626 at kernel/sched/sched.h:1145 try_to_wake_up+0x68c/0x778
[   87.615871] WARNING: CPU: 1 PID: 3626 at kernel/sched/sched.h:1145 scheduler_tick+0x110/0x118
[   87.615882] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 task_rq_lock+0xe8/0xf0
[   88.012571] WARNING: CPU: 1 PID: 3626 at kernel/sched/sched.h:1145 update_blocked_averages+0x924/0x998
[   88.176844] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x4d0/0xbc0
[   88.381905] WARNING: CPU: 2 PID: 3616 at kernel/sched/sched.h:1145 load_balance+0x7d8/0xbc0
[   88.586991] *** ---> migrate_dl_task() p=[thread0-3 3627] to CPU1
[   88.587008] *** ---> migrate_dl_task() p=[thread0-2 3626] to CPU1
[   89.335307] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-0 3624] on CPU2
[   89.343252] *** ---> migrate_dl_task() p=[thread0-0 3624] to CPU1
[   89.379309] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-1 3625] on CPU2
[   89.387249] *** ---> migrate_dl_task() p=[thread0-1 3625] to CPU1
[   89.591323] *** <--- queue_balance_callback(migrate_dl_task) p=[thread0-3 3627] on CPU2
[   89.599263] *** ---> migrate_dl_task() p=[thread0-3 3627] to CPU2
