Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F27C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362A923407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH3Od6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:33:58 -0400
Received: from foss.arm.com ([217.140.110.172]:33226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3Od5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:33:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1532344;
        Fri, 30 Aug 2019 07:33:56 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A76793F703;
        Fri, 30 Aug 2019 07:33:55 -0700 (PDT)
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
 <a42542e5-8338-c00c-5d55-d30c0daf1701@arm.com>
 <CAKfTPtAnHSZ9Lb+JUktA8Z_90V9egzU=M5ErrE=PUGy8qUWLBQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6d7bac10-03c4-8825-2e4d-c775b0b88cfb@arm.com>
Date:   Fri, 30 Aug 2019 15:33:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAnHSZ9Lb+JUktA8Z_90V9egzU=M5ErrE=PUGy8qUWLBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 15:26, Vincent Guittot wrote:
[...]
>> Seeing how much stuff we already do in just computing the stats, do we
>> really save that much by doing this? I'd expect it to be negligible with
>> modern architectures and all of the OoO/voodoo, but maybe I need a
>> refresher course.
> 
> We are not only running on top/latest architecture
> 

I know, and I'm not going to argue for a mere division either. I think I
made my point.

[...]>>>>> +     if (busiest->group_type == group_misfit_task) {
>>>>> +             /* Set imbalance to allow misfit task to be balanced. */
>>>>> +             env->balance_type = migrate_misfit;
>>>>> +             env->imbalance = busiest->group_misfit_task_load;
>>>>
>>>> AFAICT we don't ever use this value, other than setting it to 0 in
>>>> detach_tasks(), so what we actually set it to doesn't matter (as long as
>>>> it's > 0).
>>>
>>> not yet.
>>> it's only in patch 8/8 that we check if the tasks fits the cpu's
>>> capacity during the detach_tasks
>>>
>>
>> But that doesn't use env->imbalance, right? With that v3 patch it's just
>> the task util's, so AFAICT my comment still stands.
> 
> no, misfit case keeps using load and imbalance like the current
> implementation in this patch.
> The modifications on the way to handle misfit task are all in patch 8
> 
Right, my reply was a bit too terse. What I meant is that with patch 8 the
value of env->imbalance is irrelevant when dealing with misfit tasks - we
only check the task's utilization in detach_tasks(), we don't do any
comparison of the task's signals with env->imbalance.

Whether we set the imbalance to the load value and set it to 0 in
detach_tasks() or set it to 1 and decrement it in detach_tasks() gives the
same result. That's why I was saying it conceptually fits with the
migrate_task logic, since we can set the imbalance to 1 (we only want to
migrate one task).

