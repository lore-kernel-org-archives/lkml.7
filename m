Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C272067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKURWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:22:21 -0500
Received: from foss.arm.com ([217.140.110.172]:59898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKURWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:22:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402DD328;
        Thu, 21 Nov 2019 09:22:20 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDAEF3F52E;
        Thu, 21 Nov 2019 09:22:18 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191121115602.GA213296@google.com>
 <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
 <20191121133043.GA46904@google.com>
 <09e234a2-ea65-4d09-5215-9b0fe4ec09fe@arm.com>
 <20191121153029.GA105938@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <203f730b-b45f-b926-aeb4-7a0c14ae4c99@arm.com>
Date:   Thu, 21 Nov 2019 17:22:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121153029.GA105938@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 15:30, Quentin Perret wrote:
>> uclamp_util_with() (or uclamp_rq_util_with() ;)) picks the max between the
>> rq-aggregated clamps and the task clamps, which isn't what we want. If the
>> task has a low-ish uclamp.max (e.g. the 300 example from above) but the
>> rq-wide max-aggregated uclamp.max is ~800, we'd clamp using that 800. It
>> makes sense for frequency selection, but not for task placement IMO.
> 
> Right, but you could argue that this is in fact a correct behaviour.
> What we want to know is 'is this CPU big enough to meet the capacity
> request if I enqueue p there ?'. And the 'capacity request' is the
> aggregated rq-wide clamped util, IMO.
> 
> If enqueuing 'p' on a given CPU will cause the rq-wide clamped util to
> go above the CPU capacity, we want to skip that CPU.
> 
> The obvious case is if p's min_clamp is larger than the CPU capacity.

Right, so far we get that with task_fits_capacity().

> 
> But similarly, if p's max_clamp is going to be ignored because of
> another task with a larger max_clamp on the same rq, this is relevant
> information too --  the resulting capacity request might be above the
> CPU capacity if p's util_avg is large, so we should probably skip the
> CPU too no ?
> 

Hmph thinking is hard but I think I agree with you.


Say you have

  rq.cpu_capacity_orig = 1024
  rq.util_avg = 300
  rq.uclamp.max = 600

  p.util_est = 600
  p.uclamp.max = 300

If we enqueue p on that rq, we shouldn't go above 600 util (or something
close, depending on the frequency this lets us select). But, AFAICT,
cpu_util_next() will see this as going to 900 util and we'll thus skip this
CPU for this task (because that would make us overutilized). With your
suggested change, we wouldn't skip this CPU. Plus this is what we end up
using in compute_energy(), so this would keep both ends aligned.


I think we have a similar problem for downmigration (with the current patch),
say you have:

  rq.cpu_capacity_orig = 462
  rq.util_avg = 50
  rq.uclamp.max = 100

  p.util_est = 512
  p.uclamp.max = 200

In this case I think we should get 200 cpu util, but we first do

  /* Skip CPUs that will be overutilized. */                                                         
  util = cpu_util_next(cpu, p, cpu);                                                                 
  cpu_cap = capacity_of(cpu);                                                                        
  if (!fits_capacity(util, cpu_cap))                                                                 
          continue;                    

which *doesn't* look at the clamps, so we would see ~562 util which doesn't
fit on that small CPU, so we'd skip it. With your approach we would correctly
clamp this to 200 and carry on.


One thing I'd like to point out is if we have tasks with default clamp values
(.min=0, .max=1024) enqueued, we won't "throttle" tasks with low uclamp.max.
So something to keep in mind.

One last thing: this makes CPU selection slightly different from what
wake_cap() will do (that latter only uses uclamp_task_util()), but I think
that is fine.

> Are we gaining anything if we decide to not align the EAS path and the
> sugov path ?
> 
> Thanks,
> Quentin
> 
