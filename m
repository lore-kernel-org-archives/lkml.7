Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13E8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9713321880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGZKlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:41:21 -0400
Received: from foss.arm.com ([217.140.110.172]:41070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZKlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:41:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6792D344;
        Fri, 26 Jul 2019 03:41:20 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8063F71A;
        Fri, 26 Jul 2019 03:41:19 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <d55f906e-6e91-9f49-5c2c-7ec2e6bd68b0@arm.com>
 <CAKfTPtD2hDxnHSaa5C_Jrtabb_ogJSgkLE=5UPyystKZqUmzWA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4d3a67f5-c9c4-6397-7405-6f0efbd49d5c@arm.com>
Date:   Fri, 26 Jul 2019 11:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD2hDxnHSaa5C_Jrtabb_ogJSgkLE=5UPyystKZqUmzWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 10:01, Vincent Guittot wrote:
>> Huh, interesting. Why go for utilization?
> 
> Mainly because that's what is used to detect a misfit task and not the load
> 
>>
>> Right now we store the load of the task and use it to pick the "biggest"
>> misfit (in terms of load) when there are more than one misfit tasks to
>> choose:
> 
> But having a big load doesn't mean that you have a big utilization
> 
> so you can trig the misfit case because of task A with a big
> utilization that doesn't fit to its local cpu. But then select a task
> B in detach_tasks that has a small utilization but a big weight and as
> a result a higher load
> And task B will never trig the misfit UC by itself and should not
> steal the pulling opportunity of task A
> 

We can avoid this entirely by going straight for an active balance when
we are balancing misfit tasks (which we really should be doing TBH).

If we *really* want to be surgical about misfit migration, we could track
the task itself via a pointer to its task_struct, but IIRC Morten
purposely avoided this due to all the fun synchronization issues that
come with it.

With that out of the way, I still believe we should maximize the migrated
load when dealing with several misfit tasks - there's not much else you can
look at anyway to make a decision.

It sort of makes sense when e.g. you have two misfit tasks stuck on LITTLE
CPUs and you finally have a big CPU being freed, it would seem fair to pick
the one that's been "throttled" the longest - at equal niceness, that would
be the one with the highest load.

>>
>> update_sd_pick_busiest():
>> ,----
>> | /*
>> |  * If we have more than one misfit sg go with the biggest misfit.
>> |  */
>> | if (sgs->group_type == group_misfit_task &&
>> |     sgs->group_misfit_task_load < busiest->group_misfit_task_load)
>> |       return false;
>> `----
>>
>> I don't think it makes much sense to maximize utilization for misfit tasks:
>> they're over the capacity margin, which exactly means "I can't really tell
>> you much on that utilization other than it doesn't fit".
>>
>> At the very least, this rq field should be renamed "misfit_task_util".
> 
> yes. I agree that i should rename the field
> 
>>
>> [...]
>>
>>> @@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>>>  enum fbq_type { regular, remote, all };
>>>
>>>  enum group_type {
>>> -     group_other = 0,
>>> +     group_has_spare = 0,
>>> +     group_fully_busy,
>>>       group_misfit_task,
>>> +     group_asym_capacity,
>>>       group_imbalanced,
>>>       group_overloaded,
>>>  };
>>>
>>> +enum group_migration {
>>> +     migrate_task = 0,
>>> +     migrate_util,
>>> +     migrate_load,
>>> +     migrate_misfit,
>>
>> Can't we have only 3 imbalance types (task, util, load), and make misfit
>> fall in that first one? Arguably it is a special kind of task balance,
>> since it would go straight for the active balance, but it would fit a
>> `migrate_task` imbalance with a "go straight for active balance" flag
>> somewhere.
> 
> migrate_misfit uses its own special condition to detect the task that
> can be pulled compared to the other ones
> 

Since misfit is about migrating running tasks, a `migrate_task` imbalance
with a flag that goes straight to active balancing should work, no?

[...]
>> Rather than filling the local group, shouldn't we follow the same strategy
>> as for load, IOW try to reach an average without pushing local above nor
>> busiest below ?
> 
> But we don't know if this will be enough to make the busiest group not
> overloaded anymore
> 
> This is a transient state:
> a group is overloaded, another one has spare capacity
> How to balance the system will depend of how much overload if in the
> group and we don't know this value.
> The only solution is to:
> - try to pull as much task as possible to fill the spare capacity
> - Is the group still overloaded ? use avg_load to balance the system
> because both group will be overloaded
> - Is the group no more overloaded ? balance the number of idle cpus
> 
>>
>> We could build an sds->avg_util similar to sds->avg_load.
> 
> When there is spare capacity, we balances the number of idle cpus
> 

What if there is spare capacity but no idle CPUs? In scenarios like this
we should balance utilization. We could wait for a newidle balance to
happen, but it'd be a shame to repeatedly do this when we could
preemptively balance utilization.

