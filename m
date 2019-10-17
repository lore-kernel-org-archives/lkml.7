Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE72FA3732
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F60214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408420AbfJQI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:57:48 -0400
Received: from [217.140.110.172] ([217.140.110.172]:35942 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2408397AbfJQI5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:57:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0970B165C;
        Thu, 17 Oct 2019 01:57:26 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF2B3F718;
        Thu, 17 Oct 2019 01:57:24 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-5-douglas.raillard@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <87e6ce4f-af41-c585-7b48-81b5c7f45ef0@arm.com>
Date:   Thu, 17 Oct 2019 10:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011134500.235736-5-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 15:44, Douglas RAILLARD wrote:

[...]

> @@ -181,6 +185,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>  	}
>  }
>  
> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
> +{
> +	return READ_ONCE(sg_cpu->ramp_boost);
> +}
> +
> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
> +{
> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util_est_enqueued;
> +	unsigned long util_avg;
> +	unsigned long boost = 0;
> +
> +	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
> +	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
> +
> +	/*
> +	 * Boost when util_avg becomes higher than the previous stable
> +	 * knowledge of the enqueued tasks' set util, which is CPU's
> +	 * util_est_enqueued.
> +	 *
> +	 * We try to spot changes in the workload itself, so we want to
> +	 * avoid the noise of tasks being enqueued/dequeued. To do that,
> +	 * we only trigger boosting when the "amount of work' enqueued

s/"amount of work'/"amount of work" or 'amount of work'

[...]

> @@ -552,6 +593,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  		unsigned long j_util, j_max;
>  
>  		j_util = sugov_get_util(j_sg_cpu);
> +		if (j_sg_cpu == sg_cpu)
> +			sugov_cpu_ramp_boost_update(sg_cpu);

Can you not call this already in sugov_update_shared(), like in the
sugov_update_single() case?

diff --git a/kernel/sched/cpufreq_schedutil.c
b/kernel/sched/cpufreq_schedutil.c
index e35c20b42780..4c53f63a537d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -595,8 +595,6 @@ static unsigned int sugov_next_freq_shared(struct
sugov_cpu *sg_cpu, u64 time)
                unsigned long j_util, j_max;

                j_util = sugov_get_util(j_sg_cpu);
-               if (j_sg_cpu == sg_cpu)
-                       sugov_cpu_ramp_boost_update(sg_cpu);
                j_max = j_sg_cpu->max;
                j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);

@@ -625,6 +623,7 @@ sugov_update_shared(struct update_util_data *hook,
u64 time, unsigned int flags)
        ignore_dl_rate_limit(sg_cpu, sg_policy);

        if (sugov_should_update_freq(sg_policy, time)) {
+               sugov_cpu_ramp_boost_update(sg_cpu);
                next_f = sugov_next_freq_shared(sg_cpu, time);

[...]
