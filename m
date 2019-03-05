Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04393C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99F3206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCELnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:43:00 -0500
Received: from foss.arm.com ([217.140.101.70]:47316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfCELnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:43:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89553A78;
        Tue,  5 Mar 2019 03:42:57 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B4A3F71D;
        Tue,  5 Mar 2019 03:42:56 -0800 (PST)
Date:   Tue, 5 Mar 2019 11:42:54 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Update max frequency on
 global turbo changes
Message-ID: <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
 <258653930.nEdAsQ7rt7@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258653930.nEdAsQ7rt7@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Mar 2019 at 11:42:06 (+0100), Rafael J. Wysocki wrote:
> +static void intel_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
> +	struct cpufreq_policy new_policy;
> +	struct cpudata *cpudata;
> +
> +	if (!policy)
> +		return;
> +
> +	cpudata = all_cpu_data[cpu];
> +	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
> +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;

I'm not too familiar with how the Intel turbo stuff so bear with me but
is this 'pstate.turbo_freq' constant ?

Why not just write it unconditionally into cpuinfo.max_freq ? It's not
guaranteed to always be reachable anyways no ? So maybe that's OK to always
report that one regardless of the boost availability ?

> +	memcpy(&new_policy, policy, sizeof(*policy));
> +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> +
> +	cpufreq_set_policy(policy, &new_policy);
> +
> +	cpufreq_cpu_release(policy);
> +}

Thanks,
Quentin
