Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED9920637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLJSXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:23:42 -0500
Received: from foss.arm.com ([217.140.110.172]:53058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfLJSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:23:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA3B1FB;
        Tue, 10 Dec 2019 10:23:41 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EFAB3F6CF;
        Tue, 10 Dec 2019 10:23:40 -0800 (PST)
Subject: Re: [PATCH v2 4/4] sched/fair: Make feec() consider uclamp
 restrictions
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-5-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f15b639d-edb2-4b9d-8983-5589590ac41e@arm.com>
Date:   Tue, 10 Dec 2019 19:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203155907.2086-5-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 16:59, Valentin Schneider wrote:

Could you replace feec (find_energy_efficient_cpu) with EAS wakeup path
in the subject line? The term EAS is described in
Documentation/scheduler/sched-energy.rst so its probably easier to match
the patch to functionality.

> We've just made task_fits_capacity() uclamp-aware, and
> find_energy_efficient_cpu() needs to go through the same treatment.
> Things are somewhat different here however - we can't directly use
> the now uclamp-aware task_fits_capacity(). Consider the following setup:
> 
>   rq.cpu_capacity_orig = 512
>   rq.util_avg = 200
>   rq.uclamp.max = 768
> 
>   p.util_est = 600
>   p.uclamp.max = 256
> 
>   (p not yet enqueued on rq)
> 
> Using task_fits_capacity() here would tell us that p fits on the above CPU.
> However, enqueuing p on that CPU *will* cause it to become overutilized
> since rq clamp values are max-aggregated, so we'd remain with

I assume it doesn't harm to explicitly mention that this rq.uclamp.max =
768 value comes from another task already enqueued on a cfs_rq of this
rq. This gives same substance to the term max-aggregated here.

>   rq.uclamp.max = 768
> 
> Thus we could reach a high enough frequency to reach beyond 0.8 * 512
> utilization (== overutilized). What feec() needs here is

s/feec()/find_energy_efficient_cpu() ?

> uclamp_rq_util_with() which lets us peek at the future utilization
> landscape, including rq-wide uclamp values.
> 
> Make find_energy_efficient_cpu() use uclamp_rq_util_with() for its
> fits_capacity() check. This is in line with what compute_energy() ends up
> using for estimating utilization.

This is also aligned with schedutil_cpu_util() (you do mention this in
the code later in this patch.

[...]
