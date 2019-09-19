Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC22C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D29217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbfISSHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:07:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391305AbfISSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:07:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C87128;
        Thu, 19 Sep 2019 11:07:22 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE27A3F59C;
        Thu, 19 Sep 2019 11:07:19 -0700 (PDT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com, mingo@redhat.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <87woe51ydd.fsf@arm.com> <77457d5b-185e-1548-4a5c-9b911b036cec@arm.com>
 <dc0712e4-f66f-a92b-fbf9-a3a84cf982a6@linux.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <37d12346-4249-d699-70b7-fc24a5774fb3@arm.com>
Date:   Thu, 19 Sep 2019 19:07:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc0712e4-f66f-a92b-fbf9-a3a84cf982a6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 17:41, Parth Shah wrote:
> So jotting down separately, in case if we think to have "latency-nice"
> terminology, then we might need to select one of the 2 interpretation:
> 
> 1).
>> -20 (least nice to latency, i.e. sacrifice latency for throughput)
>> +19 (most nice to latency, i.e. sacrifice throughput for latency)
>>
> 
> 2).
> -20 (least nice to other task in terms of sacrificing latency, i.e.
> latency-sensitive)
> +19 (most nice to other tasks in terms of sacrificing latency, i.e.
> latency-forgoing)
> 
> 

I'd vote for 1 (duh) but won't fight for it, if it comes to it I'd be
happy with a random draw :D

>> Aren't we missing the point about tweaking the sched domain scans (which
>> AFAIR was the original point for latency-nice)?
>>
>> Something like default value is current behaviour and
>> - Being less latency-sensitive means increasing the scans (e.g. trending
>>   towards only going through the slow wakeup-path at the extreme setting)
>> - Being more latency-sensitive means reducing the scans (e.g. trending
>>   towards a fraction of the domain scanned in the fast-path at the extreme
>>   setting).
>>
> 
> Correct. But I was pondering upon the values required for this case.
> Is having just a range from [-20,19] even for larger system sufficient enough?
> 

As I said in the original thread by Subhra, this range should be plenty
enough IMO. You get ~5% deltas in each direction after all.

>>>
>>
>> $> Load balance tuning
>> ======================
>>
>> Already mentioned these in [4]:
>>
>> - Increase (reduce) nr_balance_failed threshold when trying to active
>>   balance a latency-sensitive (non-latency-sensitive) task.
>>
>> - Increase (decrease) sched_migration_cost factor in task_hot() for
>>   latency-sensitive (non-latency-sensitive) tasks.
>>
> 
> Thanks for listing down your ideas.
> 
> These are pretty useful optimization in general. But one may wonder if we
> reduce the search scans for idle-core in wake-up path and by-chance selects
> the busy core, then one would expect load balancer to move the task to idle
> core.
> 
> If I got it correct, the in such cases, the sched_migration_cost should be
> carefully increased, right?
> 

IIUC you're describing a scenario where we fail to find an idle core due to
a wakee being latency-sensitive (thus shorter scan), and place it on a rq
that already has runnable tasks (despite idle rqs being available).

In this case yes, we could potentially have a balance attempt trying to pull
from that rq. We'd try to pull the non-running tasks first, and if a
latency-sensitive task happens to be one of them we should be careful with
what we do - a migration could lead to unwanted latency.

It might be a bit more clear when you're balancing between busy cores - 
overall I think you should try to migrate the non-latency-sensitive
tasks first. Playing with task_hot() could be one of the ways to do that, but
it's just a suggestion at this time.

> 
>>>> References:
>>>> ===========
>>>> [1]. https://lkml.org/lkml/2019/8/30/829
>>>> [2]. https://lkml.org/lkml/2019/7/25/296
>>>
>>>   [3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
>>>        https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
>>>
>>
>> [4]: https://lkml.kernel.org/r/3d3306e4-3a78-5322-df69-7665cf01cc43@arm.com
>>
>>>
>>> Best,
>>> Patrick
>>>
> 
> Thanks,
> Parth
> 
