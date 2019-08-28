Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A788EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830932189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfH1OTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:19:06 -0400
Received: from foss.arm.com ([217.140.110.172]:60542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfH1OTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:19:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA5328;
        Wed, 28 Aug 2019 07:19:05 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E185E3F246;
        Wed, 28 Aug 2019 07:19:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
 <74bb33d7-3ba4-aabe-c7a2-3865d5759281@arm.com>
 <CAKfTPtA_=_ukj-8cQL4+5qU7bLHX5v4wuPODcGsX6a+o2HmBDQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a42542e5-8338-c00c-5d55-d30c0daf1701@arm.com>
Date:   Wed, 28 Aug 2019 15:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA_=_ukj-8cQL4+5qU7bLHX5v4wuPODcGsX6a+o2HmBDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2019 11:11, Vincent Guittot wrote:
>>> +     case group_fully_busy:
>>> +             /*
>>> +              * Select the fully busy group with highest avg_load.
>>> +              * In theory, there is no need to pull task from such
>>> +              * kind of group because tasks have all compute
>>> +              * capacity that they need but we can still improve the
>>> +              * overall throughput by reducing contention when
>>> +              * accessing shared HW resources.
>>> +              * XXX for now avg_load is not computed and always 0 so
>>> +              * we select the 1st one.
>>> +              */
>>
>> What's wrong with unconditionally computing avg_load in update_sg_lb_stats()?
> 
> removing useless division which can be expensive
> 

Seeing how much stuff we already do in just computing the stats, do we
really save that much by doing this? I'd expect it to be negligible with
modern architectures and all of the OoO/voodoo, but maybe I need a 
refresher course.

>> We already unconditionally accumulate group_load anyway.
> 
> accumulation must be done while looping on the group whereas computing
> avg_load can be done only when needed
> 
>>
>> If it's to make way for patch 6/8 (using load instead of runnable load),
>> then I think you are doing things in the wrong order. IMO in this patch we
>> should unconditionally compute avg_load (using runnable load), and then
>> you could tweak it up in a subsequent patch.
> 
> In fact, it's not link to patch 6/8.
> It's only that I initially wanted to used load only when overloaded
> but then I got this case and thought that comparing avg_load could be
> interesting but without any proof that it's worth.
> As mentioned in the comment, tasks in this group have enough capacity
> and there is no need to move task in theory. This is there mainly to
> trigger the discuss and keep in mind a possible area of improvement in
> a next step.
> I haven't run tests or done more study on this particular case to make
> sure that there would be some benefit to compare avg_load.
> 
> So in the future, we might end up always computing avg_load and
> comparing it for selecting busiest fully busy group
> 

Okay, that definitely wants testing then.

[...]
>>> +     if (busiest->group_type == group_misfit_task) {
>>> +             /* Set imbalance to allow misfit task to be balanced. */
>>> +             env->balance_type = migrate_misfit;
>>> +             env->imbalance = busiest->group_misfit_task_load;
>>
>> AFAICT we don't ever use this value, other than setting it to 0 in
>> detach_tasks(), so what we actually set it to doesn't matter (as long as
>> it's > 0).
> 
> not yet.
> it's only in patch 8/8 that we check if the tasks fits the cpu's
> capacity during the detach_tasks
> 

But that doesn't use env->imbalance, right? With that v3 patch it's just
the task util's, so AFAICT my comment still stands.

>>
>> I'd re-suggest folding migrate_misfit into migrate_task, which is doable if
>> we re-instore lb_env.src_grp_type (or rather, not delete it in this patch),
>> though it makes some other places somewhat uglier. The good thing is that
>> it actually does end up being implemented as a special kind of task
>> migration, rather than being loosely related.
> 
> I prefer to keep it separate instead of adding a sub case in migrate_task
> 

My argument here is that ideally they shouldn't be separated, since the misfit
migration is a subcase of task migration (or an extension of it - in any
case, they're related). I haven't found a nicer way to express it though,
and I agree that the special casing in detach_tasks()/fbq()/etc is meh.

[...]
>>> @@ -8765,7 +8942,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>>       env.src_rq = busiest;
>>>
>>>       ld_moved = 0;
>>> -     if (busiest->cfs.h_nr_running > 1) {
>>> +     if (busiest->nr_running > 1) {
>>
>> Shouldn't that stay h_nr_running ? We can't do much if those aren't CFS
>> tasks.
> 
> There is the case raised by srikar where we have for example 1 RT task
> and 1 CFS task. cfs.h_nr_running==1 but we don't need active balance
> because CFS is not the running task
> 
>>
>>>               /*
>>>                * Attempt to move tasks. If find_busiest_group has found
>>>                * an imbalance but busiest->nr_running <= 1, the group is
>>>
