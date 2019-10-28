Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1ADCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432EE21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d/JN3eUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfJ1PdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:33:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ1PdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zQuvBEiQv7/Ur7mCHVSdKJIemOFk01eQ56PkcAWxYvo=; b=d/JN3eUoLJaDDhpwAP87uijIB
        KwTsU4dw78A51c+/o2xGh0VkNePm6IAWBOLYcQMMgsMqAefslZY4ORtUlhMkE6uXhlpS7q+N1H443
        eEjrNkugb/xqmCVjdp5GPKI1EF0DOpskr/9k4bKsEzoJHMtxd+JqgnQDoLMQgyLDR3mHY9tnMIzhR
        JUut/QFBiRf8cqM1df0uCiQ8x90UCqWXYWpGCoVViLz33FgolZAbxV8TyuY0tOUE1QJYGI4A7ZCrp
        8TmxqGAY+T7eLk0OC7zacbDpnGjaQarO/D2onOJ8ju59XpWOcCmDIe7YGOGtBegcGtxnvcAwCrgu1
        V2KNKTLvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP719-000346-2j; Mon, 28 Oct 2019 15:33:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AE05300EBF;
        Mon, 28 Oct 2019 16:32:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7E682B4468CB; Mon, 28 Oct 2019 16:33:13 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:33:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20191028153313.GF4097@hirez.programming.kicks-ass.net>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:34:24PM -0400, Thara Gopinath wrote:
> Thermal governors can request for a cpu's maximum supported frequency
> to be capped in case of an overheat event. This in turn means that the
> maximum capacity available for tasks to run on the particular cpu is
> reduced. Delta between the original maximum capacity and capped
> maximum capacity is known as thermal pressure. Enable cpufreq cooling
> device to update the thermal pressure in event of a capped
> maximum frequency.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 391f397..2e6a979 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  }
>  
>  /**
> + * update_sched_max_capacity - update scheduler about change in cpu
> + *					max frequency.
> + * @policy - cpufreq policy whose max frequency is capped.

Uhm, this function doesn't have a @policy argument.

> + */
> +static void update_sched_max_capacity(struct cpumask *cpus,
> +				      unsigned int cur_max_freq,
> +				      unsigned int max_freq)
> +{
> +	int cpu;
> +	unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
> +				  max_freq;

check your types and ranges. What units is _freq in and does 'freq *
SCHED_CAPACITY' fit in 'unsigned int'? If so, why do you assign it to an
'unsigned long'?

> +
> +	for_each_cpu(cpu, cpus)
> +		update_thermal_pressure(cpu, capacity);
> +}

> @@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  
>  	cpufreq_cdev->cpufreq_state = state;
>  
> -	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
> -				cpufreq_cdev->freq_table[state].frequency);
> +	ret = dev_pm_qos_update_request
> +				(&cpufreq_cdev->qos_req,
> +				 cpufreq_cdev->freq_table[state].frequency);
> +
> +	if (ret > 0)
> +		update_sched_max_capacity
> +				(cpufreq_cdev->policy->cpus,
> +				 cpufreq_cdev->freq_table[state].frequency,
> +				 cpufreq_cdev->policy->cpuinfo.max_freq);

Codingstyle wants that in { }.

> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.1.4
> 
