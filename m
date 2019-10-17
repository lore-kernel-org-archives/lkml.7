Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEECFA3732
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C521848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439394AbfJQJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:21:49 -0400
Received: from [217.140.110.172] ([217.140.110.172]:36454 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJQJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:21:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 059EF1684;
        Thu, 17 Oct 2019 02:21:24 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9B13F718;
        Thu, 17 Oct 2019 02:21:22 -0700 (PDT)
Subject: Re: [RFC PATCH v3 5/6] sched/cpufreq: Boost schedutil frequency ramp
 up
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-6-douglas.raillard@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4235a01d-26ee-418c-b78a-6c6109deda1d@arm.com>
Date:   Thu, 17 Oct 2019 11:21:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011134500.235736-6-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 15:44, Douglas RAILLARD wrote:

[...]

> @@ -539,6 +543,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	unsigned long util, max;
>  	unsigned int next_f;
>  	bool busy;
> +	unsigned long ramp_boost = 0;

Shouldn't always order local variable declarations from longest to
shortest line?

>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
> @@ -552,10 +557,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
>  
>  	util = sugov_get_util(sg_cpu);
> -	sugov_cpu_ramp_boost_update(sg_cpu);
> +	ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu);
>  	max = sg_cpu->max;
>  	util = sugov_iowait_apply(sg_cpu, time, util, max);
> -	next_f = get_next_freq(sg_policy, util, max);
> +	next_f = get_next_freq(sg_policy, util, max, ramp_boost);
>  	/*
>  	 * Do not reduce the frequency if the CPU has not been idle
>  	 * recently, as the reduction is likely to be premature then.
> @@ -587,6 +592,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned long util = 0, max = 1;
>  	unsigned int j;
> +	unsigned long ramp_boost = 0;
> +	unsigned long j_ramp_boost = 0;

Shouldn't always order local variable declarations from longest to
shortest line?

>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> @@ -594,7 +601,11 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  
>  		j_util = sugov_get_util(j_sg_cpu);
>  		if (j_sg_cpu == sg_cpu)
> -			sugov_cpu_ramp_boost_update(sg_cpu);
> +			j_ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu);
> +		else
> +			j_ramp_boost = sugov_cpu_ramp_boost(j_sg_cpu);
> +		ramp_boost = max(ramp_boost, j_ramp_boost);

Ah, that's why you call sugov_cpu_ramp_boost_update() from
sugov_next_freq_shared() in 4/6. So sugov_cpu_ramp_boost_update() is
more a sugov_cpu_ramp_boost(..., int update)? Minor detail though.

[...]
