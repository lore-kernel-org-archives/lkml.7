Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9B5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB55F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfDRKOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:14:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRKOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:14:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 656EB15AB;
        Thu, 18 Apr 2019 03:14:24 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F20E53F59C;
        Thu, 18 Apr 2019 03:14:21 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:14:20 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190418101418.5kiw5hkxoflbsvlj@queper01-lin>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
> +/**
> + * Function to update thermal pressure from cooling device
> + * or any framework responsible for capping cpu maximum
> + * capacity.
> + */
> +void sched_update_thermal_pressure(struct cpumask *cpus,
> +				   unsigned long cap_max_freq,
> +				   unsigned long max_freq)
> +{
> +	int cpu;
> +	unsigned long flags = 0;
> +	struct thermal_pressure *cpu_thermal;
> +
> +	for_each_cpu(cpu, cpus) {

Is it actually required to do this for each CPU ? You could calculate
the whole thing once for the first CPU, and apply the result to all CPUs
in the policy no ? All CPUs in a policy are capped and uncapped
synchronously.

> +		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
> +		if (!cpu_thermal)
> +			return;
> +		spin_lock_irqsave(&cpu_thermal->lock, flags);
> +		thermal_pressure_update(cpu_thermal, cap_max_freq, max_freq, 1);
> +	}
> +}
