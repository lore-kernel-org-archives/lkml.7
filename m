Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEEB21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYCBpQ1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfKAVEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:04:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45601 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:04:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id x21so14697007qto.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rU5awjd7OsKi+MjPz5zkPNthALUjS34IGcuRf1byb3I=;
        b=MYCBpQ1yJWfqeAl1zazCgHUNVBCXOVbAupu9Tw5PyPCacB7oBlTchC+5QEcSDSlppj
         xU1s2TD9NiUvV0wRfn8w5/y8ORls+UnEa6UFaTeaYv5PxNRJGCBu0+zRHLTAB2Ki21kd
         F/CtsFIi+9D8qtT2ulNspJyKgFjpWUg7SF84r7Rm64mNPsNjUiCE0tY/DBjRsbaK5XOa
         qcxyoS0SN4+e6QCbAMpMhNXbhj88EYc9nE31tM4wQZ1DIdXJDAppjsd8z7eqmnHo9o5L
         pKxEZyvxuLSpd26KccAHKSd1dH3j68JElsuenkCbt+ZQuOj7o5G7MgwpJTRHIlIv1xJY
         kHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rU5awjd7OsKi+MjPz5zkPNthALUjS34IGcuRf1byb3I=;
        b=ERucYt7bCEHLcg/Dtj51PtBdFycP++uimixaNgbYS1u9sFd1dM7Mzh306ThRtaYX6t
         LHOfWXl06sM9WuvrAAboCDfiS7Fo+L9GU3ENGmK+9fXPtz47GVe+ieKrSqT2UfRJwDGx
         K7hGNzfDSRaHXNy7WfzPSNR8YlyRSrfceQea+233AsFcAGI3nbQ12tmpWs4V+jeTchE+
         lEdIu/Zerm4Ygsg5X0J5v/vSfn+KQ85HApV4fQUcY87L/ByZMV5j3muT+KY1ZWMe6eOr
         m7L4Wo25Iif/nyNAyBM0nV1KOAXr9JKMuYeNVcndCPpxz0RO4eKVGNOeBuvRVpcvGlaT
         yDeQ==
X-Gm-Message-State: APjAAAU2xheg9cOwqvHl/0VTpx+bh8z6V6lQRRwcd93Va6W4h8DLJdCX
        VIqOrwLU7oPZC+wuJX+MFvOnrQ==
X-Google-Smtp-Source: APXvYqwvyAPbFpJuUv1dfrJ/A+79dw3z2gl+2zURReuAUE5ys0OWiM8VNmKPnAhjSZwpoofSSurXvg==
X-Received: by 2002:aed:2ec6:: with SMTP id k64mr1475272qtd.61.1572642289403;
        Fri, 01 Nov 2019 14:04:49 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c17sm4165329qkm.37.2019.11.01.14.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 14:04:48 -0700 (PDT)
Subject: Re: [Patch v4 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
 <2b19d7da-412c-932f-7251-110eadbef3e3@arm.com>
 <CAKfTPtCpZq61gQVpATtTdg5hDA+tP4bF6xPMsvHYUMoY+H-6FQ@mail.gmail.com>
 <20191101154612.GA4884@e108754-lin>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBC9DEF.6030007@linaro.org>
Date:   Fri, 1 Nov 2019 17:04:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191101154612.GA4884@e108754-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2019 11:47 AM, Ionela Voinescu wrote:
> Hi guys,
> 
> On Thursday 31 Oct 2019 at 17:38:25 (+0100), Vincent Guittot wrote:
>> On Thu, 31 Oct 2019 at 17:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 22.10.19 22:34, Thara Gopinath wrote:
>>>> Thermal governors can request for a cpu's maximum supported frequency
>>>> to be capped in case of an overheat event. This in turn means that the
>>>> maximum capacity available for tasks to run on the particular cpu is
>>>> reduced. Delta between the original maximum capacity and capped
>>>> maximum capacity is known as thermal pressure. Enable cpufreq cooling
>>>> device to update the thermal pressure in event of a capped
>>>> maximum frequency.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>> ---
>>>>  drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>>>> index 391f397..2e6a979 100644
>>>> --- a/drivers/thermal/cpu_cooling.c
>>>> +++ b/drivers/thermal/cpu_cooling.c
>>>> @@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>>>>  }
>>>>
>>>>  /**
>>>> + * update_sched_max_capacity - update scheduler about change in cpu
>>>> + *                                   max frequency.
>>>> + * @policy - cpufreq policy whose max frequency is capped.
>>>> + */
>>>> +static void update_sched_max_capacity(struct cpumask *cpus,
>>>> +                                   unsigned int cur_max_freq,
>>>> +                                   unsigned int max_freq)
>>>> +{
>>>> +     int cpu;
>>>> +     unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
>>>> +                               max_freq;
>>>> +
>>>> +     for_each_cpu(cpu, cpus)
>>>> +             update_thermal_pressure(cpu, capacity);
>>>> +}
>>>> +
>>>> +/**
>>>>   * get_load() - get load for a cpu since last updated
>>>>   * @cpufreq_cdev:    &struct cpufreq_cooling_device for this cpu
>>>>   * @cpu:     cpu number
>>>> @@ -320,6 +337,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>>>                                unsigned long state)
>>>>  {
>>>>       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>>>> +     int ret;
>>>>
>>>>       /* Request state should be less than max_level */
>>>>       if (WARN_ON(state > cpufreq_cdev->max_level))
>>>> @@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>>>>
>>>>       cpufreq_cdev->cpufreq_state = state;
>>>>
>>>> -     return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
>>>> -                             cpufreq_cdev->freq_table[state].frequency);
>>>> +     ret = dev_pm_qos_update_request
>>>> +                             (&cpufreq_cdev->qos_req,
>>>> +                              cpufreq_cdev->freq_table[state].frequency);
>>>> +
>>>> +     if (ret > 0)
>>>> +             update_sched_max_capacity
>>>> +                             (cpufreq_cdev->policy->cpus,
>>>> +                              cpufreq_cdev->freq_table[state].frequency,
>>>> +                              cpufreq_cdev->policy->cpuinfo.max_freq);
>>>> +
>>>> +     return ret;
>>>>  }
>>>>
>>>>  /**
>>>>
>>>
>>> Why not getting rid of update_sched_max_capacity() entirely and call
>>> update_thermal_pressure() in cpu_cooling.c directly? Saves one level in
>>> the call chain and would mean less code for this feature.
>>
>> But you add complexity in update_thermal_pressure which now has to
>> deal with a cpumask and to compute some frequency ratio
>> IMHO, it's cleaner to keep update_thermal_pressure simple as it is now
>>
> 
> How about removing update_thermal_pressure altogether and doing all the
> work in update_sched_max_capacity? That is, have
> update_sched_max_capacity compute the capped_freq_ratio, do the
> normalization, and set it per_cpu for all CPUs in the frequency domain.
> You'll save some calculations that you're now doing in
> update_thermal_pressure for each cpu and you avoid shifting back and
> forth.

Yes.  I can pass the delta to update_thermal_pressure. I will still want
to keep update_thermal_pressure and a per cpu variable in fair.c to
store this.
> 
> If you're doing so it would be worth renaming update_sched_max_capacity
> to something like update_sched_thermal_pressure.
Will do.


-- 
Warm Regards
Thara
