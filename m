Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE74C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C7A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLJSf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:35:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfLJSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:35:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932A31FB;
        Tue, 10 Dec 2019 10:35:56 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E6F3F6CF;
        Tue, 10 Dec 2019 10:35:55 -0800 (PST)
Subject: Re: [PATCH v2 4/4] sched/fair: Make feec() consider uclamp
 restrictions
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-5-valentin.schneider@arm.com>
 <f15b639d-edb2-4b9d-8983-5589590ac41e@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <035f4ff1-3303-c855-13fd-2ab03bef82a8@arm.com>
Date:   Tue, 10 Dec 2019 18:35:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f15b639d-edb2-4b9d-8983-5589590ac41e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 18:23, Dietmar Eggemann wrote:
> On 03/12/2019 16:59, Valentin Schneider wrote:
> 
> Could you replace feec (find_energy_efficient_cpu) with EAS wakeup path
> in the subject line? The term EAS is described in
> Documentation/scheduler/sched-energy.rst so its probably easier to match
> the patch to functionality.
> 

Will do.

>> We've just made task_fits_capacity() uclamp-aware, and
>> find_energy_efficient_cpu() needs to go through the same treatment.
>> Things are somewhat different here however - we can't directly use
>> the now uclamp-aware task_fits_capacity(). Consider the following setup:
>>
>>   rq.cpu_capacity_orig = 512
>>   rq.util_avg = 200
>>   rq.uclamp.max = 768
>>
>>   p.util_est = 600
>>   p.uclamp.max = 256
>>
>>   (p not yet enqueued on rq)
>>
>> Using task_fits_capacity() here would tell us that p fits on the above CPU.
>> However, enqueuing p on that CPU *will* cause it to become overutilized
>> since rq clamp values are max-aggregated, so we'd remain with
> 
> I assume it doesn't harm to explicitly mention that this rq.uclamp.max =
> 768 value comes from another task already enqueued on a cfs_rq of this
> rq. This gives same substance to the term max-aggregated here.
> 

I've changed the setup example to:

  The target runqueue, rq:
    rq.cpu_capacity_orig = 512
    rq.cfs.avg.util_avg = 200
    rq.uclamp.max = 768 // the max p.uclamp.max of all enqueued p's is 768

  The waking task, p (not yet enqueued on rq):
    p.util_est = 600
    p.uclamp.max = 100


I'll also flesh out the rest.

>>   rq.uclamp.max = 768
>>
>> Thus we could reach a high enough frequency to reach beyond 0.8 * 512
>> utilization (== overutilized). What feec() needs here is
> 
> s/feec()/find_energy_efficient_cpu() ?
> 

Will do.

>> uclamp_rq_util_with() which lets us peek at the future utilization
>> landscape, including rq-wide uclamp values.
>>
>> Make find_energy_efficient_cpu() use uclamp_rq_util_with() for its
>> fits_capacity() check. This is in line with what compute_energy() ends up
>> using for estimating utilization.
> 
> This is also aligned with schedutil_cpu_util() (you do mention this in
> the code later in this patch.
> 

That's what I imply with compute_energy() (which ends up calling
schedutil_cpu_util()).

> [...]
> 
