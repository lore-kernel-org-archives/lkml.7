Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF11C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AD21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8JmPNQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfKFR2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:28:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36583 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:28:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so27759960qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cildnkHAtGFk9PcADnAUYpXqpMdvERaifSTi5Re4C1E=;
        b=e8JmPNQIn3OcXe73t3eo7VctwhRryMluL5BtAqrtacun6RshyM5iCavFCKS5W6luDd
         sYd1R2eN5ePxpk8FCJBZqTKZkYY/GBJ61ETJhV5h8SoOb8JZHqEjb/7ApqKL+6P1UPVo
         FSWZJktvRxR2oish2p/wjvNmUf+EiCbbxzWmuM32WMJOHpktA6WzBt3oQTBbW5vC7MAz
         VAcP8I922IumPI5bzbY6YC9j7YLs5xHMbL7ght6i6XYg4LJ+Kq1KrpeNxqnOjMHRncWf
         FktbX1mYsWjVw1tFfrj4PviEDgdfgUPAXxZMxf6ouZDbTmOQwvtICcE2QCNTIFeY7ANd
         H9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cildnkHAtGFk9PcADnAUYpXqpMdvERaifSTi5Re4C1E=;
        b=D/Sd3WQbHZHk7jfWMh6bMwQdcYLxD/UoWEtEv39AvMMS5KUUZPdOlQ7CRDwXbXmEz8
         CQznfAgPFkxf4GsR0P1ZdXOIbvB7tEHo64FWHcBqrkr70h0VkiZ6rdl3wAKCCuw0lwlU
         2hlk/E/fIMGeo3apeK4KJ3dnm0iCap6x/mrFMOIL2DeJlrIu0MjyHF6o0H89XTxbNbWm
         b75+HJKa9DqLn/aTcxkF9pYZ7Lw2pGsWcSdcaYNgzMrHW8/xBBwbQqO2nQxZ2P66m/uN
         Ij+uKt9HFjMTI2Jj4XE4RZbkB661c9rfpCZQVUQ7h8gt+jZt05qufYNCpzgEJmvNAFV5
         zVXA==
X-Gm-Message-State: APjAAAWDfrj7fa5s6aTz/+7wVMqvvNhqr+/RFOc2g6q764kOdglGgn/V
        HbHcNTUisISjqev753YwPhxPuw==
X-Google-Smtp-Source: APXvYqwadXiXnTiY1dy8mveDTjtySgKJMzVQtFxOO1mQsDfXi29cATEpsbrRSIqdu4c4wp/uYa3JXw==
X-Received: by 2002:aed:22b7:: with SMTP id p52mr3507800qtc.289.1573061313058;
        Wed, 06 Nov 2019 09:28:33 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id u130sm11733026qka.49.2019.11.06.09.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:28:32 -0800 (PST)
Subject: Re: [Patch v5 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-6-git-send-email-thara.gopinath@linaro.org>
 <05c53b6f-fd16-3e8b-e8da-ea56325cec33@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC302BF.8060101@linaro.org>
Date:   Wed, 6 Nov 2019 12:28:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <05c53b6f-fd16-3e8b-e8da-ea56325cec33@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
> On 05/11/2019 19:49, Thara Gopinath wrote:
> 
> [...]
> 
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 391f397..c65b7c4 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -218,6 +218,27 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>>  }
>>  
>>  /**
>> + * update_sched_max_capacity - update scheduler about change in cpu
>> + *				max frequency.
>> + * @cpus: list of cpus whose max capacity needs udating in scheduler.
>> + * @cur_max_freq: current maximum frequency.
>> + * @max_freq: highest possible frequency.
>> + */
>> +static void update_sched_max_capacity(struct cpumask *cpus,
>> +				      unsigned int cur_max_freq,
>> +				      unsigned int max_freq)
>> +{
>> +	int cpu;
>> +	unsigned long capacity;
>> +
>> +	for_each_cpu(cpu, cpus) {
>> +		capacity = cur_max_freq * arch_scale_cpu_capacity(cpu);
>> +		capacity /= max_freq;
>> +		update_thermal_pressure(cpu, capacity);
>> +	}
>> +}
>> +
>> +/**
> 
> Have you seen
> https://lore.kernel.org/r/2b19d7da-412c-932f-7251-110eadbef3e3@arm.com ?
Yes and have you seen this
https://lore.kernel.org/lkml/CAKfTPtCpZq61gQVpATtTdg5hDA+tP4bF6xPMsvHYUMoY+H-6FQ@mail.gmail.com/

this
https://lore.kernel.org/lkml/5DBB0FD4.8000509@linaro.org/

and this from Ionela (which is the basis for v5)
https://lore.kernel.org/lkml/20191101154612.GA4884@e108754-lin/

I stand by what I said earlier that I see no reason to take parsing of
the cpus into fair.c for this feature (this way this solution is more
generic and can be used from any other entity capping maximum cpu frequency)

> 
> Also the naming 'update_thermal_pressure()' is not really suitable for
> an external task scheduler interface. If I see this called in the
> cooling device code, I wouldn't guess that this is a task scheduler
> interface.

Do you have a name suggestion? When you say you don't like a name do
suggest a name so that I have an idea of what is it you are expecting.

> 
> [...]
> 


-- 
Warm Regards
Thara
