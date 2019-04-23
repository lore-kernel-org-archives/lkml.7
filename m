Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F903C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E096218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcbA5WVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfDWWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:38:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38711 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:38:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so18109147qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=B7VoHDQyrAF8aaybRD4S2NtHu7O5loR8kyubxlS1twM=;
        b=AcbA5WVsJ1qws2qqoC6p3R/johDNop1WJF5YxM/jpFZL5mjKtkxwImj0nuSfZ569wx
         72D4ulK0FBGnSexTZBrxwRL+2P0Uyg+8t0+GFj1LkAwUeAHFpZbxxn9XfyuQN0G0GYtP
         kDZi0HiOZWUy09tB+411Su/71ZuM9LEvcPdDqsQMTzb+rSYD+BWGh8+TaDWr/eZ6N1Gk
         /qKeUrqTelJnVAS0E2t0+VW3t0n/5netEZ5UcURLY2Uxi0q9n/BtJod8eIGT1ZBmmcfy
         W3naOFH/SMLtpuAKFKciX90AT9GHHlvuilgrNmydrHknmESdxqwD95NhcCwY3SADsm9b
         OcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=B7VoHDQyrAF8aaybRD4S2NtHu7O5loR8kyubxlS1twM=;
        b=bGaTO03uOwS+x5Zfu9kLSRZp8q2t4BngNinyTmbTPkAOuDKIDnoJHOpACuCERjdW52
         rIYsEdfnU/8w05kwS+nJjCil6l4Gxv+V6lbHq5lbC8vtgydfl32rYEXrjPEj8E4ERCF0
         2KYkSyb4+W826RHsyLlkHS2vdrxfOa5oQg0au73c95cYB8921ANoVnUWf4pZFpzy3guM
         /64XJ4l2Cvnrl1aFgh8XWFklgnFMYZ2OsGJyZM8ZK1aEV6KiwhKHDoBBJMHneY3+2kb+
         PvOf96uDHgO9a6dvfJTDEzcQxhYu4UeK2+QKXEQBXDLVYdazlsKd2lC92wzXaHJnIxOo
         Uu0A==
X-Gm-Message-State: APjAAAWfOBIsEtouuRtydpbrZDykV8U/h+Kvg44xlRGkesjPHhO2gpky
        TM4zrbJBXflbO05xrvY8xyuT5Q==
X-Google-Smtp-Source: APXvYqxC4xxysfcPHI9Kis59soe3R2cGbiNoXBk27nTuqqse/uvvA1TSIuNswOeK4EPCSVD4luPZ9w==
X-Received: by 2002:ac8:2d62:: with SMTP id o31mr9721491qta.318.1556059128840;
        Tue, 23 Apr 2019 15:38:48 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id v58sm10842707qtv.66.2019.04.23.15.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:38:48 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Quentin Perret <quentin.perret@arm.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CBF93F6.8000109@linaro.org>
Date:   Tue, 23 Apr 2019 18:38:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190418094833.owlobrx6x5gclvhy@queper01-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 05:48 AM, Quentin Perret wrote:
> On Tuesday 16 Apr 2019 at 15:38:41 (-0400), Thara Gopinath wrote:
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> @@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>>  
>>  		if (policy->max > clipped_freq)
>>  			cpufreq_verify_within_limits(policy, 0, clipped_freq);
>> +
>> +		sched_update_thermal_pressure(policy->cpus,
>> +				policy->max, policy->cpuinfo.max_freq);
> 
> Is this something we could do this CPUFreq ? Directly in
> cpufreq_verify_within_limits() perhaps ?
> 
> That would re-define the 'thermal pressure' framework in a more abstract
> way and make the scheduler look at 'frequency capping' events,
> regardless of the reason for capping.
> 
> That would reflect user-defined frequency constraint into cpu_capacity,
> in addition to the thermal stuff. I'm not sure if there is another use
> case for frequency capping ?
Hi Quentin,
Thanks for the review. Sorry for the delay in response as I was on
vacation for the past few days.
I think there is one major difference between user-defined frequency
constraints and frequency constraints due to thermal events in terms of
the time period the system spends in the the constraint state.
Typically, a user constraint lasts for seconds if not minutes and I
think in this case cpu_capacity_orig should reflect this constraint and
not cpu_capacity like this patch set. Also, in case of the user
constraint, there is possibly no need to accumulate and average the
capacity constraints and instantaneous values can be directly applied to
cpu_capacity_orig. On the other hand thermal pressure is more spiky and
sometimes in the order of ms and us requiring the accumulating and
averaging.
> 
> Perhaps the Intel boost stuff could be factored in there ? That is,
> at times when the boost freq is not reachable capacity_of() would appear
> smaller ... Unless this wants to be reflected instantaneously ?
Again, do you think intel boost is more applicable to be reflected in
cpu_capacity_orig and not cpu_capacity?
> 
> Thoughts ?
> Quentin
> 


-- 
Regards
Thara
