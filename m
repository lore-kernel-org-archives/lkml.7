Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1021850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfGZOB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:01:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGZOB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:01:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71582337;
        Fri, 26 Jul 2019 07:01:56 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647233F694;
        Fri, 26 Jul 2019 07:01:55 -0700 (PDT)
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
 <4d3a67f5-c9c4-6397-7405-6f0efbd49d5c@arm.com>
 <CAKfTPtBE5fzycHk33rf7Bky-tYSeCXaKd9oGR5cgaghzbL2TvA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <aff49e6a-b4d3-baae-9124-3d5bb5abdbfe@arm.com>
Date:   Fri, 26 Jul 2019 15:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBE5fzycHk33rf7Bky-tYSeCXaKd9oGR5cgaghzbL2TvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 13:30, Vincent Guittot wrote:
>> We can avoid this entirely by going straight for an active balance when
>> we are balancing misfit tasks (which we really should be doing TBH).
> 
> but your misfit task might not be the running one anymore when
> load_balance effectively happens
> 

We could add a check in the active balance bits to make sure the current
task is still a misfit task (albeit not necessarily the one we wanted to
migrate, since we can't really differentiate them).

Misfit migration shouldn't go through detach_tasks() - if the misfit task
is still the running task, we want to go for active balance anyway, and if
it's not the running task anymore then we should try to detect it and give
up - there's not much else we can do. From a rq's perspective, a task can
only ever be misfit if it's currently running.

The current code can totally active balance the wrong task if the load
balancer saw a misfit task in update_sd_lb_stats() but it moved away in the
meantime, so making misfit balancing skip detach_tasks() would be a straight
improvement IMO: we can still get some active balance collaterals, but at
least we don't wrongfully detach a non-running task that happened to have
the right load shape.

>>
>> If we *really* want to be surgical about misfit migration, we could track
>> the task itself via a pointer to its task_struct, but IIRC Morten
> 
> I thought about this but task can have already die at that time and
> the pointer is no more relevant.
> Or we should parse the list of task still attached to the cpu and
> compare them with the saved pointer but then it's not scalable and
> will consume a lot of time
> 
>> purposely avoided this due to all the fun synchronization issues that
>> come with it.
>>
>> With that out of the way, I still believe we should maximize the migrated
>> load when dealing with several misfit tasks - there's not much else you can
>> look at anyway to make a decision.
> 
> But you can easily select a task that is not misfit so what is the best/worst ?
> select a fully wrong task or at least one of the real misfit tasks
> 

Utilization can't help you select a "best" misfit task amongst several 
since the utilization of misfit tasks is by definition meaningless.

I do agree that looking at utilization when detaching the task prevents
picking a non-misfit task, but those are two different issues:

1) Among several rqs/groups with misfit tasks, pick the busiest one
   (this is where I'm arguing we should use load)
2) When detaching a task, make sure it's a misfit task (this is where
   you're arguing we should use utilization).

> I'm fine to go back and use load instead of util but it's not robust IMO.
> 

[...]
>> What if there is spare capacity but no idle CPUs? In scenarios like this
>> we should balance utilization. We could wait for a newidle balance to
> 
> why should we balance anything ? all tasks have already enough running time.
> It's better to wait for a cpu to become idle instead of trying to
> predict which one will be idle first and migrate task uselessly
> because other tasks can easily wakeup in the meantime
> 

I probably need to play with this and create some synthetic use cases.

What I had in mind is something like 2 CPUs, CPU0 running a 20% task and
CPU1 running 6 10% tasks.

If CPU0 runs the load balancer, balancing utilization would mean pulling
2 tasks from CPU1 to reach the domain-average of 40%. The good side of this
is that we could save ourselves from running some newidle balances, but
I'll admit that's all quite "finger in the air".

>> happen, but it'd be a shame to repeatedly do this when we could
>> preemptively balance utilization.
>>
