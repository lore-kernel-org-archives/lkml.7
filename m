Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC115C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A8C206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfIRPqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:46:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfIRPqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:46:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4933337;
        Wed, 18 Sep 2019 08:46:22 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B2F3F59C;
        Wed, 18 Sep 2019 08:46:20 -0700 (PDT)
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com> <87woe51ydd.fsf@arm.com> <CAKfTPtAF1WM6tCktgyyj=SLfJGT0qT5e_2Fu+SVheyfrJ-pg2A@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Parth Shah <parth@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: Usecases for the per-task latency-nice attribute
In-reply-to: <CAKfTPtAF1WM6tCktgyyj=SLfJGT0qT5e_2Fu+SVheyfrJ-pg2A@mail.gmail.com>
Date:   Wed, 18 Sep 2019 16:46:18 +0100
Message-ID: <87v9tp1ub9.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Sep 18, 2019 at 16:22:32 +0100, Vincent Guittot wrote...

> On Wed, 18 Sep 2019 at 16:19, Patrick Bellasi <patrick.bellasi@arm.com> wrote:

[...]

>> $> Wakeup path tunings
>> ==========================
>>
>> Some additional possible use-cases was already discussed in [3]:
>>
>>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>>    depending on crossing certain pre-configured threshold of latency
>>    niceness.
>>
>>  - dynamically bias the vruntime updates we do in place_entity()
>>    depending on the actual latency niceness of a task.
>>
>>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
>>    bit there."
>
> I agree with Peter that we can easily break the fairness if we bias vruntime

Just to be more precise here and also to better understand, here I'm
talking about turning the tweaks we already have for:

 - START_DEBIT
 - GENTLE_FAIR_SLEEPERS

a bit more parametric and proportional to the latency-nice of a task.

In principle, if a task declares a positive latency niceness, could we
not read this also as "I accept to be a bit penalised in terms of
fairness at wakeup time"?

Whatever tweaks we do there should affect anyway only one sched_latency
period... although I'm not yet sure if that's possible and how.

>>  - bias the decisions we take in check_preempt_tick() still depending
>>    on a relative comparison of the current and wakeup task latency
>>    niceness values.
>
> This one seems possible as it will mainly enable a task to preempt
> "earlier" the running task but will not break the fairness
> So the main impact will be the number of context switch between tasks
> to favor or not the scheduling latency

Preempting before is definitively a nice-to-have feature.

At the same time it's interesting a support where a low latency-nice
task (e.g. TOP_APP) RUNNABLE on a CPU has better chances to be executed
up to completion without being preempted by an high latency-nice task
(e.g. BACKGROUND) waking up on its CPU.

For that to happen, we need a mechanism to "delay" the execution of a
less important RUNNABLE task up to a certain period.

It's impacting the fairness, true, but latency-nice in this case will
means that we want to "complete faster", not just "start faster".

Is this definition something we can reason about?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
