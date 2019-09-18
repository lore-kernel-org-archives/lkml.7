Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE48C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF10206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfIRPm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:42:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfIRPm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:42:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF17337;
        Wed, 18 Sep 2019 08:42:26 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39EAD3F59C;
        Wed, 18 Sep 2019 08:42:24 -0700 (PDT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Parth Shah <parth@linux.ibm.com>
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
 <87woe51ydd.fsf@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <77457d5b-185e-1548-4a5c-9b911b036cec@arm.com>
Date:   Wed, 18 Sep 2019 16:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87woe51ydd.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2019 15:18, Patrick Bellasi wrote:
>> 1. Name: What should be the name for such attr for all the possible usecases?
>> =============
>> Latency nice is the proposed name as of now where the lower value indicates
>> that the task doesn't care much for the latency
> 
> If by "lower value" you mean -19 (in the proposed [-20,19] range), then
> I think the meaning should be the opposite.
> 
> A -19 latency-nice task is a task which is not willing to give up
> latency. For those tasks for example we want to reduce the wake-up
> latency at maximum.
> 
> This will keep its semantic aligned to that of process niceness values
> which range from -20 (most favourable to the process) to 19 (least
> favourable to the process).
> 

I don't want to start a bikeshedding session here, but I agree with Parth
on the interpretation of the values.

I've always read niceness values as
-20 (least nice to the system / other processes)
+19 (most nice to the system / other processes)

So following this trend I'd see for latency-nice:
-20 (least nice to latency, i.e. sacrifice latency for throughput)
+19 (most nice to latency, i.e. sacrifice throughput for latency)

However...

>> But there seems to be a bit of confusion on whether we want biasing as well
>> (latency-biased) or something similar, in which case "latency-nice" may
>> confuse the end-user.
> 
> AFAIU PeterZ point was "just" that if we call it "-nice" it has to
> behave as "nice values" to avoid confusions to users. But, if we come up
> with a different naming maybe we will have more freedom.
> 

...just getting rid of the "-nice" would leave us free not to have to
interpret the values as "nice to / not nice to" :)

> Personally, I like both "latency-nice" or "latency-tolerant", where:
> 
>  - latency-nice:
>    should have a better understanding based on pre-existing concepts
> 
>  - latency-tolerant:
>    decouples a bit its meaning from the niceness thus giving maybe a bit
>    more freedom in its complete definition and perhaps avoid any
>    possible interpretation confusion like the one I commented above.
> 
> Fun fact: there was also the latency-nasty proposal from PaulMK :)
> 

[...]

> 
> $> Wakeup path tunings
> ==========================
> 
> Some additional possible use-cases was already discussed in [3]:
> 
>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>    depending on crossing certain pre-configured threshold of latency
>    niceness.
>   
>  - dynamically bias the vruntime updates we do in place_entity()
>    depending on the actual latency niceness of a task.
>   
>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
>    bit there."
>   
>  - bias the decisions we take in check_preempt_tick() still depending
>    on a relative comparison of the current and wakeup task latency
>    niceness values.

Aren't we missing the point about tweaking the sched domain scans (which
AFAIR was the original point for latency-nice)?

Something like default value is current behaviour and
- Being less latency-sensitive means increasing the scans (e.g. trending
  towards only going through the slow wakeup-path at the extreme setting)
- Being more latency-sensitive means reducing the scans (e.g. trending
  towards a fraction of the domain scanned in the fast-path at the extreme
  setting).

> 

$> Load balance tuning
======================

Already mentioned these in [4]:

- Increase (reduce) nr_balance_failed threshold when trying to active
  balance a latency-sensitive (non-latency-sensitive) task.

- Increase (decrease) sched_migration_cost factor in task_hot() for
  latency-sensitive (non-latency-sensitive) tasks.

>> References:
>> ===========
>> [1]. https://lkml.org/lkml/2019/8/30/829
>> [2]. https://lkml.org/lkml/2019/7/25/296
> 
>   [3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
>        https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
> 

[4]: https://lkml.kernel.org/r/3d3306e4-3a78-5322-df69-7665cf01cc43@arm.com

> 
> Best,
> Patrick
> 
