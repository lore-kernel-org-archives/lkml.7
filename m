Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E4920731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUM4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:56:50 -0500
Received: from foss.arm.com ([217.140.110.172]:55778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:56:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D365DA7;
        Thu, 21 Nov 2019 04:56:49 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023513F703;
        Thu, 21 Nov 2019 04:56:47 -0800 (PST)
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
Date:   Thu, 21 Nov 2019 12:56:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121115602.GA213296@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 11:56, Quentin Perret wrote:
> On Wednesday 20 Nov 2019 at 17:55:33 (+0000), Valentin Schneider wrote:
>> +static inline
>> +unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)
> 
> This 'util' parameter is always task_util_est(p) right ? You might want
> to remove it.
> 

I went with copying uclamp_rq_util()'s API, but you're right in that I don't
see what other value (than util_est) would make sense for this helper. If
there is no objections I'll kill the parameter for v2.

>> +{
>> +	return clamp(util,
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
>> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
>> +}
> 
> Thanks,
> Quentin
> 

Another thing I realized overnight; tell me what you think:

> @@ -6274,6 +6274,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (!fits_capacity(util, cpu_cap))
>  				continue;
>  
> +			/*
> +			 * Skip CPUs that don't satisfy uclamp requests. Note
> +			 * that the above already ensures the CPU has enough
> +			 * spare capacity for the task; this is only really for
> +			 * uclamp restrictions.
> +			 */
> +			if (!task_fits_capacity(p, capacity_orig_of(cpu)))
> +				continue;

This is partly redundant with the above, I think. What we really want here
is just

fits_capacity(uclamp_eff_value(p, UCLAMP_MIN), capacity_orig_of(cpu))

but this would require some inline #ifdeffery.

> +
>  			/* Always use prev_cpu as a candidate. */
>  			if (cpu == prev_cpu) {
>  				prev_delta = compute_energy(p, prev_cpu, pd);
