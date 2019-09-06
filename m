Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A67C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7E20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392485AbfIFWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:51:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfIFWvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:51:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFEA1570;
        Fri,  6 Sep 2019 15:51:01 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846473F67D;
        Fri,  6 Sep 2019 15:50:59 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
 <87d0ge3n85.fsf@arm.com> <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com>
 <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
 <f4d28328-973c-4b94-334d-a68c958f6cc4@linux.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e2ad3cdf-5fc6-c443-b805-06c65bc0f863@arm.com>
Date:   Fri, 6 Sep 2019 23:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f4d28328-973c-4b94-334d-a68c958f6cc4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 18:10, Parth Shah wrote:
> Right, CPU capacity can solve the problem of indicating the thermal throttle to the scheduler.
> AFAIU, the patchset from Thara changes CPU capacity to reflect Thermal headroom of the CPU.
> This is a nice mitigation but,
> 1. Sometimes a single task is responsible for the Thermal heatup of the core, reducing the
>    CPU capacity of all the CPUs in the core is not optimal when just moving such single
>    task to other core can allow us to remain within thermal headroom. This is important
>    for the servers especially where there are upto 8 threads.> 2. Given the implementation in the patches and its integration with EAS, it seems difficult
>    to adapt to servers, where CPU capacity itself is in doubt.
>    https://lkml.org/lkml/2019/5/15/1402
> 

I'd nuance this to *SMT* capacity (which isn't just servers). The thing is
that it's difficult to come up with a sensible scheme to describe the base
capacity of a single logical CPU. But yeah, valid point.

>>
>> For active balance, we actually already have a condition that moves a task
>> to a less capacity-pressured CPU (although it is somewhat specific). So if
>> thermal pressure follows that task (e.g. it's doing tons of vector/float),
>> it will be rotated around.
> 
> Agree. But this should break in certain conditions like when we have multiple tasks
> in a core with almost equal utilization among which one is just doing vector operations.
> LB can pick and move any task with equal probability if the capacity is reduced here.
> 

Right, if/when we get things like per-unit signals (wasn't there something
about tracking AVX a few months back?) then we'll be able to make
more informed decisions, for now we'll need some handholding (read: task
classification).

>>
>> However there should be a point made on latency vs throughput. If you
>> care about latency you probably do not want to active balance your task. If
> 
> Can you please elaborate on why not to consider active balance for latency sensitive tasks?
> Because, sometimes finding a thermally cool core is beneficial when Turbo frequency
> range is around 20% above rated ones.
> 

This goes back to my reply to Patrick further up the thread.

Right now active balance can happen just because we've been imbalanced for
some time and repeatedly failed to migrate anything. After 3 (IIRC) successive
failed attempts, we'll active balance the running task of the remote rq we
decided was busiest.

If that happens to be a latency sensitive task, that's not great - active
balancing means stopping that task's execution, so we're going to add some
latency to this latency-sensitive task. My proposal was to further ratelimit
active balance (e.g. require more failed attempts) when the task that would be
preempted is latency-sensitive.

My point is: if that task is doing fine where it is, why preempt it? That's
just introducing latency IMO (keeping in mind that those balance attempts
could happen despite not having any thermal pressure).

If you care about performance (e.g. a minimum level of throughput), to me
that is a separate (though perhaps not entirely distinct) property.

>> you care about throughput, it should be specified in some way (util-clamp
>> says hello!).
>>
> 
> yes I do care for latency and throughput both. :-)

Don't we all!

> but I'm wondering how uclamp can solve the problem for throughput.
> If I make the thermally hot tasks to appear bigger than other tasks then reducing
> CPU capacity can allow such tasks to move around the chip.
> But this will require the utilization value to be relatively large compared to the other
> tasks in the core. Or other task's uclamp.max can be lowered to make such task rotate.
> If I got it right, then this will be a difficult UCLAMP usecase from user perspective, right?
> I feel like I'm missing something here.
> 

Hmm perhaps I was jumping the gun here. What I was getting to is if you have
something like misfit that migrates tasks to CPUs of higher capacity than the
one they are on, you could use uclamp to flag them.

You could translate your throughput requirement as a uclamp.min of e.g. 80%,
and if the CPU capacity goes below that (or close within a margin) then you'd
try to migrate the task to a CPU of higher capacity (i.e. not or less 
thermally pressured).

This doesn't have to involve your less throughput-sensitive tasks, since you
would only tag and take action for your throughput-sensitive tasks.
