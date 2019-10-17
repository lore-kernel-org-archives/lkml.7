Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F26FA3732
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D56214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408408AbfJQI5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:57:44 -0400
Received: from [217.140.110.172] ([217.140.110.172]:35926 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2408397AbfJQI5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:57:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF68B15BF;
        Thu, 17 Oct 2019 01:57:23 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E296E3F718;
        Thu, 17 Oct 2019 01:57:21 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/6] sched/cpufreq: Attach perf domain to sugov
 policy
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-3-douglas.raillard@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4ebf6419-c8e0-3998-41e0-3f7b49b34084@arm.com>
Date:   Thu, 17 Oct 2019 10:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011134500.235736-3-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 15:44, Douglas RAILLARD wrote:

[...]

> @@ -66,6 +70,38 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +static void sugov_policy_attach_pd(struct sugov_policy *sg_policy)
> +{
> +	struct em_perf_domain *pd;
> +	struct cpufreq_policy *policy = sg_policy->policy;

Shouldn't always order local variable declarations from longest to
shortest line?

> +
> +	sg_policy->pd = NULL;
> +	pd = em_cpu_get(policy->cpu);
> +	if (!pd)
> +		return;
> +
> +	if (cpumask_equal(policy->related_cpus, to_cpumask(pd->cpus)))
> +		sg_policy->pd = pd;
> +	else
> +		pr_warn("%s: Not all CPUs in schedutil policy %u share the same perf domain, no perf domain for that policy will be registered\n",
> +			__func__, policy->cpu);

Maybe {} because of 2 lines?

> +}
> +
> +static struct em_perf_domain *sugov_policy_get_pd(
> +						struct sugov_policy *sg_policy)


Maybe this way? This format is already used in this file.

static struct em_perf_domain *
sugov_policy_get_pd(struct sugov_policy *sg_policy)


> +{
> +	return sg_policy->pd;
> +}
> +#else /* CONFIG_ENERGY_MODEL */
> +static void sugov_policy_attach_pd(struct sugov_policy *sg_policy) {}
> +static struct em_perf_domain *sugov_policy_get_pd(
> +						struct sugov_policy *sg_policy)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_ENERGY_MODEL */
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  {
>  	s64 delta_ns;
> @@ -859,6 +895,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>  							sugov_update_shared :
>  							sugov_update_single);
>  	}
> +
> +	sugov_policy_attach_pd(sg_policy);
> +
>  	return 0;
>  }

A sugov_policy_detach_pd() called from sugov_stop() (doing for instance
the g_policy->pd = NULL) is not needed?
