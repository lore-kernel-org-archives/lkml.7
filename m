Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749A8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD8D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3JOMLxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfJaQqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:46:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42280 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfJaQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so9394213qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8BDA+jxLbxMZRyBhT+Sh/HKotUNzXD/MuC8g+IfML58=;
        b=k3JOMLxlQv49waYHbMD9TzpPf4vveDi3Ra3C+Te93aiGVb9/FtlhZrCKC8mX34zYMk
         eFYxHC5idpfdQ7yO8hE/2dZAw9MIZHkOFc6rbwFjeG+wCbSfTbX3vGxpF6vdvrADqGVu
         +YI9Al6BtD42TOaVSGo30lI4iAunxzwHZQR6neRmPUJIznd/1J8MKidvdqVb4Nrzu6M6
         RNfwtG4l8F+KHd8vgU0rjUpUAVI04i0JqlU08t1I/AD5Xq6cIwhLA3nFTx+jlJvF3N0q
         WiX3NtvJD6FVqEAfQCZKc6QoY+xmnAHYPkfrH1bP84/sJq2iGVSzjjQNgodDDi+eCmbr
         NZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8BDA+jxLbxMZRyBhT+Sh/HKotUNzXD/MuC8g+IfML58=;
        b=LR6AGomT90kfQCVQ4eqf30mseE64i5aXZVCYbt/gIp6G3azSsxXiTbiK9263BX+C1Q
         of/ykk29RVx9YYVsmex6cSGkcnWFPqL2Ri+f9V+bhIvvwyAQucMHSnTflxvJ2M3GErCF
         qHTAhaCTCzQubwz4p2c+eXkf4Fk4jjPv6eqbeTd0CH9f8JlhZSyT/H37281LM/YtQPnI
         IGOY8xWiF7N3CQeiXnc3AARPHDVeyc7JzmR+U3bjy0yM4ZCpINplwPwZZehUS72p99Mz
         aN2mqCN+lD+dSL6QzmX35O6fbYcrykI/R5zIWZzLA8KpsquaRtaoOpA4HPQaIpxPH1DU
         GKjw==
X-Gm-Message-State: APjAAAWHpvC7LK5PZQa7c3LPQXPmSzcmQNONf+hqlPl6oIUhWbhpiz+s
        IPuU4UHm/61X5PeVLHsndrvONA==
X-Google-Smtp-Source: APXvYqxvRyD6STzUiJHaqvckuJ+Bj7OXy4bur6BbnH1h/Ujq9cD7R4bwjaNpVgTVqxRQufjvyvBMuQ==
X-Received: by 2002:ac8:35c4:: with SMTP id l4mr201801qtb.151.1572540373845;
        Thu, 31 Oct 2019 09:46:13 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 11sm2431439qkv.131.2019.10.31.09.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:46:13 -0700 (PDT)
Subject: Re: [Patch v4 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
 <2b19d7da-412c-932f-7251-110eadbef3e3@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBB0FD4.8000509@linaro.org>
Date:   Thu, 31 Oct 2019 12:46:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <2b19d7da-412c-932f-7251-110eadbef3e3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 12:29 PM, Dietmar Eggemann wrote:
> On 22.10.19 22:34, Thara Gopinath wrote:
>> Thermal governors can request for a cpu's maximum supported frequency
>> to be capped in case of an overheat event. This in turn means that the
>> maximum capacity available for tasks to run on the particular cpu is
>> reduced. Delta between the original maximum capacity and capped
>> maximum capacity is known as thermal pressure. Enable cpufreq cooling
>> device to update the thermal pressure in event of a capped
>> maximum frequency.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 391f397..2e6a979 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>>  }
>>  
>>  /**
>> + * update_sched_max_capacity - update scheduler about change in cpu
>> + *					max frequency.
>> + * @policy - cpufreq policy whose max frequency is capped.
>> + */
>> +static void update_sched_max_capacity(struct cpumask *cpus,
>> +				      unsigned int cur_max_freq,
>> +				      unsigned int max_freq)
>> +{
>> +	int cpu;
>> +	unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
>> +				  max_freq;
>> +
>> +	for_each_cpu(cpu, cpus)
>> +		update_thermal_pressure(cpu, capacity);
>> +}
>> +
>> +/**
>>   * get_load() - get load for a cpu since last updated
>>   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
>>   * @cpu:	cpu number
>> @@ -320,6 +337,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>  				 unsigned long state)
>>  {
>>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>> +	int ret;
>>  
>>  	/* Request state should be less than max_level */
>>  	if (WARN_ON(state > cpufreq_cdev->max_level))
>> @@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>  
>>  	cpufreq_cdev->cpufreq_state = state;
>>  
>> -	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
>> -				cpufreq_cdev->freq_table[state].frequency);
>> +	ret = dev_pm_qos_update_request
>> +				(&cpufreq_cdev->qos_req,
>> +				 cpufreq_cdev->freq_table[state].frequency);
>> +
>> +	if (ret > 0)
>> +		update_sched_max_capacity
>> +				(cpufreq_cdev->policy->cpus,
>> +				 cpufreq_cdev->freq_table[state].frequency,
>> +				 cpufreq_cdev->policy->cpuinfo.max_freq);
>> +
>> +	return ret;
>>  }
>>  
>>  /**
>>
> 
> Why not getting rid of update_sched_max_capacity() entirely and call
> update_thermal_pressure() in cpu_cooling.c directly? Saves one level in
> the call chain and would mean less code for this feature.

Hi Dietmar,
Thanks for the review.

I did not want the scheduler piece of code to loop through the cpus.
Do you feel strongly about this one ?

Warm Regards
Thara
> 
> Just compile tested on arm64:
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 3211b4d3a899..bf36995013b0 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -217,23 +217,6 @@ static u32 cpu_power_to_freq(struct
> cpufreq_cooling_device *cpufreq_cdev,
>         return freq_table[i - 1].frequency;
>  }
> 
> -/**
> - * update_sched_max_capacity - update scheduler about change in cpu
> - *                                     max frequency.
> - * @policy - cpufreq policy whose max frequency is capped.
> - */
> -static void update_sched_max_capacity(struct cpumask *cpus,
> -                                     unsigned int cur_max_freq,
> -                                     unsigned int max_freq)
> -{
> -       int cpu;
> -       unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
> -                                 max_freq;
> -
> -       for_each_cpu(cpu, cpus)
> -               update_thermal_pressure(cpu, capacity);
> -}
> -
>  /**
>   * get_load() - get load for a cpu since last updated
>   * @cpufreq_cdev:      &struct cpufreq_cooling_device for this cpu
> @@ -353,7 +336,7 @@ static int cpufreq_set_cur_state(struct
> thermal_cooling_device *cdev,
>                                 cpufreq_cdev->freq_table[state].frequency);
> 
>         if (ret > 0)
> -               update_sched_max_capacity
> +               update_thermal_pressure
>                                 (cpufreq_cdev->policy->cpus,
>                                  cpufreq_cdev->freq_table[state].frequency,
>                                  cpufreq_cdev->policy->cpuinfo.max_freq);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 55dfe9634f67..5707813c7621 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1985,9 +1985,9 @@ static inline void rseq_syscall(struct pt_regs *regs)
>  #endif
> 
>  #ifdef CONFIG_SMP
> -void update_thermal_pressure(int cpu, u64 capacity);
> +void update_thermal_pressure(struct cpumask *cpus, unsigned int cur,
> unsigned int max);
>  #else
> -static inline void update_thermal_pressure(int cpu, u64 capacity)
> +static inline void update_thermal_pressure(struct cpumask *cpus,
> unsigned int cur, unsigned int max);
>  {
>  }
>  #endif
> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> index 0da31e12a5ff..691bdd79597a 100644
> --- a/kernel/sched/thermal.c
> +++ b/kernel/sched/thermal.c
> @@ -43,17 +43,16 @@ static DEFINE_PER_CPU(unsigned long, delta_capacity);
>   * the arch_scale_cpu_capacity and capped capacity is stored in per cpu
>   * delta_capacity.
>   */
> -void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
> +void update_thermal_pressure(struct cpumask *cpus, unsigned int cur,
> unsigned int max)
>  {
> -       unsigned long __capacity, delta;
> +       int cpu;
> 
> -       /* Normalize the capped freq ratio */
> -       __capacity = (capped_freq_ratio * arch_scale_cpu_capacity(cpu)) >>
> -
> SCHED_CAPACITY_SHIFT;
> -       delta = arch_scale_cpu_capacity(cpu) -  __capacity;
> -       pr_debug("updating cpu%d thermal pressure to %lu\n", cpu, delta);
> +       for_each_cpu(cpu, cpus) {
> +               unsigned long scale_cap = arch_scale_cpu_capacity(cpu);
> +               unsigned long cur_cap = cur * scale_cap / max;
> 
> -       per_cpu(delta_capacity, cpu) = delta;
> +               per_cpu(delta_capacity, cpu) = scale_cap - cur_cap;
> +       }
>  }
> 


-- 
Warm Regards
Thara
