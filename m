Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69054C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C94A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1Jsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:48:32 -0400
Received: from foss.arm.com ([217.140.101.70]:41178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfC1Jsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3962715AB;
        Thu, 28 Mar 2019 02:48:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D623F59C;
        Thu, 28 Mar 2019 02:48:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:48:24 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/4] cpufreq: schedutil: Simplify iowait boosting
Message-ID: <20190328094823.y6gyfb6ldq43gojw@queper01-lin>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
 <2864116.v8IU97Resm@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2864116.v8IU97Resm@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tuesday 26 Mar 2019 at 12:18:00 (+0100), Rafael J. Wysocki wrote:
> @@ -13,6 +13,8 @@
>  #include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>  
> +#define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
> +
>  struct sugov_tunables {
>  	struct gov_attr_set	attr_set;
>  	unsigned int		rate_limit_us;
> @@ -51,7 +53,6 @@ struct sugov_cpu {
>  	u64			last_update;
>  
>  	unsigned long		bw_dl;
> -	unsigned long		min;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -303,7 +304,7 @@ static bool sugov_iowait_reset(struct sua

The comment above this function needs updating I think.

>  	if (delta_ns <= TICK_NSEC)
>  		return false;
>  
> -	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
> +	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
>  	sg_cpu->iowait_boost_pending = set_iowait_boost;
>  
>  	return true;
> @@ -349,7 +350,7 @@ static void sugov_iowait_boost(struct su

Ditto.

>  	}
>  
>  	/* First wakeup after IO: start with minimum boost */
> -	sg_cpu->iowait_boost = sg_cpu->min;
> +	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
>  }
>  
>  /**
> @@ -389,7 +390,7 @@ static unsigned long sugov_iowait_apply(
>  		 * No boost pending; reduce the boost value.
>  		 */
>  		sg_cpu->iowait_boost >>= 1;
> -		if (sg_cpu->iowait_boost < sg_cpu->min) {
> +		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>  			sg_cpu->iowait_boost = 0;
>  			return util;
>  		}
> @@ -826,9 +827,6 @@ static int sugov_start(struct cpufreq_po
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu			= cpu;
>  		sg_cpu->sg_policy		= sg_policy;
> -		sg_cpu->min			=
> -			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> -			policy->cpuinfo.max_freq;
>  	}
>  
>  	for_each_cpu(cpu, policy->cpus) {
> 

Other than that, I tried a backport of this on a Pixel 3 with Snapdragon
845 (which is relevant because it has tons of OPPs, so starting at 128
makes it ramp up faster) to check the impact on power, but the only
differences appeared to be in the noise margin, so it's all good :)

Full test results available at [1]. Note that I did enable the iowait
boost feature for these tests -- it is disabled by default on P3 ...

Thanks,
Quentin

---
[1] https://nbviewer.jupyter.org/gist/qperret/69c9bde13aad2d783689e78c9ba2d9bc
