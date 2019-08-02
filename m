Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1013EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CAA2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfHBKtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:49:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHBKtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:49:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2454344;
        Fri,  2 Aug 2019 03:49:08 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A613E3F71F;
        Fri,  2 Aug 2019 03:49:07 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] sched/fair: use utilization to select misfit task
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
 <22ba6771-8bde-8c6e-65e0-4ab2ebc6e018@arm.com>
 <CAKfTPtApKzWZvD83QKwd4ZKhfsCyFMZffkyAOB5oYNgck5jbPw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <61b1cabc-13ad-6ee0-df0c-72f3b11d368d@arm.com>
Date:   Fri, 2 Aug 2019 11:49:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtApKzWZvD83QKwd4ZKhfsCyFMZffkyAOB5oYNgck5jbPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 09:29, Vincent Guittot wrote:
>> However what would be *even* better IMO would be:
>>
>> -----8<-----
>> @@ -8853,6 +8853,7 @@ voluntary_active_balance(struct lb_env *env)
>>                         return 1;
>>         }
>>
>> +       /* XXX: make sure current is still a misfit task? */
>>         if (env->balance_type == migrate_misfit)
>>                 return 1;
>>
>> @@ -8966,6 +8967,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>         env.src_rq = busiest;
>>
>>         ld_moved = 0;
>> +
>> +       /*
>> +        * Misfit tasks are only misfit if they are currently running, see
>> +        * update_misfit_status().
>> +        *
>> +        * - If they're not running, we'll get an opportunity at wakeup to
>> +        *   migrate them to a bigger CPU.
>> +        * - If they're running, we need to active balance them to a bigger CPU.
>> +        *
>> +        * Do the smart thing and go straight for active balance.
>> +        */
>> +       if (env->balance_type == migrate_misfit)
>> +               goto active_balance;
>> +
> 
> This looks ugly and add a new bypass which this patchset tries to remove
> This doesn't work if your misfit task has been preempted by another
> one during the load balance and waiting for the runqueue

I won't comment on aesthetics, but when it comes to preempted misfit tasks
do consider that a task *has* to have a utilization >= 80% of its CPU's
capacity to be flagged as misfit.
If it's a busy loop, it can only be preempted ~20% of the time to still be
flagged as a misfit task, so going straight for active balance will be the
right thing to do in the majority of cases.

What we gain from doing that is we save ourselves from (potentially
needlessly) iterating over the rq's tasks. That's less work and less rq
lock contention.

To put a bit of contrast on this, Qais did some profiling of usual mobile
workloads on a regular 4+4 big.LITTLE smartphone and IIRC the rq depth rose
very rarely above 5, although the tail did reach ~100 tasks. So most of the
time it would be fine to go through the detach_tasks() path.

This all deserves some actual benchmarking, I'll give it a shot.

>>         if (busiest->nr_running > 1) {
>>                 /*
>>                  * Attempt to move tasks. If find_busiest_group has found
>> @@ -9074,7 +9089,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                         goto out_all_pinned;
>>                 }
>>         }
>> -
>> +active_balance:
>>         if (!ld_moved) {
>>                 schedstat_inc(sd->lb_failed[idle]);
>>                 /*
>> ----->8-----
