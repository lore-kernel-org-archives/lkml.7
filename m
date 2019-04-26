Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8561206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuQ0J8wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfDZKYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:24:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45213 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZKYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:24:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id b3so3407799qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fbB5VwXRbKN5aHn+nrmOUtiXQH3CVjSw+YoopfaaQoQ=;
        b=GuQ0J8wKmcJNJdK+UA+Mc8PosdUdbWpGHD+xuDWr6pvRATLyx9LJSW/rEEtkkrpBjF
         tW+JbWWnE5V+oYLCyS4KQkAl9UJUzJkJsiJ6oyDTL5pmFhBckkdcIO7/XvrZZJDVS2x8
         Mc51kuyqIijKAq4cGyKfrCO6bpbxviQ2Gzk49OryaVf2++N+Yvqarc0XAMq7NYVRLEgf
         WQgC7tiXzFxb7ncuYiIy8L9kOfZ0qU5Q8uzPzF4CkX2KTnfuLlmCrc4xOk0DoPU2IAGe
         /h8GSrycPNK280wb6cbFAwsoXHd1IM5Q06YKI5ANroUqxqsLcDcfx6yCIus2BguEkZ/D
         QwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fbB5VwXRbKN5aHn+nrmOUtiXQH3CVjSw+YoopfaaQoQ=;
        b=hRvoVi3ncDQIXmPCvgpQQ5be3zJWltlwRgZLkOBlYsqdUtZpCcrxB9XCVu9dhZJqeo
         BipHlcDpZex8+Eeghoxdjtg+l5XmX+7wNw1fiz5A+HQ26enMfpiibXCFRXw2f9YTXSGz
         9x9wYYT2bvvA/zB97R3xhkzfgpBnU4zb/PoUxFoZ9Clxm8PCLKZnwppK7xCF1BuHChKx
         oYSVh6dVodQhI0lixmSuskUdXAS8w3plDI7CvmkM5qTHJ2NMYbJSJL2m2XCvVLh1D4Gx
         BfkzuZbgGlt6vxZPdNYHhnETd/FCTyUaPrD7AEAkzENXGCPkwrHediQGnVvJf33u749D
         kVQg==
X-Gm-Message-State: APjAAAVKITt6MuAr232HYYnU7EzEUamZ/nwZ05icnFK7eWuEVsjPgTml
        20j6og1xvH/SJRquvbMI9bxGzw==
X-Google-Smtp-Source: APXvYqwM3vqC7kdD6Ma/eA9Tl4SxLqdJHsWastrRmTA1eUji7vjm2AMIleQiLr6sa3lmfXvipFt6GA==
X-Received: by 2002:a0c:d78c:: with SMTP id z12mr26368485qvi.55.1556274260517;
        Fri, 26 Apr 2019 03:24:20 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id h10sm988768qkk.69.2019.04.26.03.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:24:19 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin> <5CBF93F6.8000109@linaro.org>
 <84e64cb1-db2d-6519-e0c4-97779079d96d@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC2DC51.9030908@linaro.org>
Date:   Fri, 26 Apr 2019 06:24:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <84e64cb1-db2d-6519-e0c4-97779079d96d@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2019 11:56 AM, Ionela Voinescu wrote:
> Hi guys,
> 
> On 23/04/2019 23:38, Thara Gopinath wrote:
>> On 04/18/2019 05:48 AM, Quentin Perret wrote:
>>> On Tuesday 16 Apr 2019 at 15:38:41 (-0400), Thara Gopinath wrote:
>>>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>>>> @@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>>>>  
>>>>  		if (policy->max > clipped_freq)
>>>>  			cpufreq_verify_within_limits(policy, 0, clipped_freq);
>>>> +
>>>> +		sched_update_thermal_pressure(policy->cpus,
>>>> +				policy->max, policy->cpuinfo.max_freq);
>>>
>>> Is this something we could do this CPUFreq ? Directly in
>>> cpufreq_verify_within_limits() perhaps ?
>>>
>>> That would re-define the 'thermal pressure' framework in a more abstract
>>> way and make the scheduler look at 'frequency capping' events,
>>> regardless of the reason for capping.
>>>
>>> That would reflect user-defined frequency constraint into cpu_capacity,
>>> in addition to the thermal stuff. I'm not sure if there is another use
>>> case for frequency capping ?
>> Hi Quentin,
>> Thanks for the review. Sorry for the delay in response as I was on
>> vacation for the past few days.
>> I think there is one major difference between user-defined frequency
>> constraints and frequency constraints due to thermal events in terms of
>> the time period the system spends in the the constraint state.
>> Typically, a user constraint lasts for seconds if not minutes and I
>> think in this case cpu_capacity_orig should reflect this constraint and
>> not cpu_capacity like this patch set. Also, in case of the user
>> constraint, there is possibly no need to accumulate and average the
>> capacity constraints and instantaneous values can be directly applied to
>> cpu_capacity_orig. On the other hand thermal pressure is more spiky and
>> sometimes in the order of ms and us requiring the accumulating and
>> averaging.
> 
> I think we can't make any assumptions in regards to the intentions of
> the user when restricting the OPP range though the cpufreq interface,
> but it would still be nice to do something and reflecting it as thermal
> pressure would be a good start. It might not be due to thermal, but it
> is a capacity restriction that would have the same result. Also, if the
> user has the ability to tune the decay period he has the control over
> the behavior of the signal. Given that currently there isn't a smarter
> mechanism (modifying capacity orig, re-normalising the capacity range)
> for long-term capping, even treating it as short-term capping is a good
> start. But this is a bigger exercise and it needs thorough
> consideration, so it could be skipped, in my opinion, for now.. 
> 
> Also, if we want to stick with the "definition", userspace would still
> be able to reflect thermal pressure though the thermal limits interface
> by setting the cooling device state, which will be reflected in this
> update as well. So userspace would have a mechanism to reflect thermal
> pressure.

Yes, target_state under cooling devices can be set and this will reflect
as thermal pressure.

> 
> One addition.. I like that the thermal pressure framework is not tied to
> cpufreq. There are firmware solutions that do not bother informing
> cpufreq of limits being changed, and therefore all of this could be
> skipped. But any firmware driver could call sched_update_thermal_pressure
> on notifications for limits changing from firmware, which is an
> important feature.

For me, I am open to discussion on the best place to call
sched_update_thermal_pressure from. Seeing the discussion and different
opinions, I am wondering should there be a SoC or platform specific hook
provided for better abstraction.

Regards
Thara

> 
>>>
>>> Perhaps the Intel boost stuff could be factored in there ? That is,
>>> at times when the boost freq is not reachable capacity_of() would appear
>>> smaller ... Unless this wants to be reflected instantaneously ?
>> Again, do you think intel boost is more applicable to be reflected in
>> cpu_capacity_orig and not cpu_capacity?
>>>
>>> Thoughts ?
>>> Quentin
>>>
>>
> 
> The changes here would happen even faster than thermal capping, same as
> other restrictions imposed by firmware, so it would not seem right to me
> to reflect it in capacity_orig. Reflecting it as thermal pressure is
> another matter, which I'd say it should be up to the client. The big
> disadvantage I'd see for this is coping with decisions made while being
> capped, when you're not capped any longer, and the other way around. I
> believe these changes would happen too often and they will not happen in
> a ramp-up/ramp-down behavior that we expect from thermal mitigation.
> That's why I believe averaging/regulation of the signal works well in
> this case, and it might not for power related fast restrictions.
> 
> But given these three cases above, it might be that the ideal solution
> is for this framework to be made more generic and for each client to be
> able to obtain and configure a pressure signal to be reflected
> separately in the capacity of each CPU.
> 
> My two pennies' worth,
> Ionela.
> 
> 
> 


-- 
Regards
Thara
