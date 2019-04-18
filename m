Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ACE20821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfDRJsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:48:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733049AbfDRJsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:48:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F237515AB;
        Thu, 18 Apr 2019 02:48:39 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862993F68F;
        Thu, 18 Apr 2019 02:48:37 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:48:35 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20190418094833.owlobrx6x5gclvhy@queper01-lin>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Apr 2019 at 15:38:41 (-0400), Thara Gopinath wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> @@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  
>  		if (policy->max > clipped_freq)
>  			cpufreq_verify_within_limits(policy, 0, clipped_freq);
> +
> +		sched_update_thermal_pressure(policy->cpus,
> +				policy->max, policy->cpuinfo.max_freq);

Is this something we could do this CPUFreq ? Directly in
cpufreq_verify_within_limits() perhaps ?

That would re-define the 'thermal pressure' framework in a more abstract
way and make the scheduler look at 'frequency capping' events,
regardless of the reason for capping.

That would reflect user-defined frequency constraint into cpu_capacity,
in addition to the thermal stuff. I'm not sure if there is another use
case for frequency capping ?

Perhaps the Intel boost stuff could be factored in there ? That is,
at times when the boost freq is not reachable capacity_of() would appear
smaller ... Unless this wants to be reflected instantaneously ?

Thoughts ?
Quentin
