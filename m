Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE762189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcNDm30c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGCPQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:16:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:16:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so3257064wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jmk3EaUMyH3o2q6hi4mDaqdjnaIaz/WrF9xrUY0fsnc=;
        b=tcNDm30c25aBara3PT9tDOeGo7Xwh3v1yWsIuGZ6cTG1sScl1UatJE729VVSHK8TPA
         vGuZJmArZTapZv0iPuCWanf2kU24WnZpMsuYaVBZbgZ+fPdIB1ixwyHlyVHAgxdBAECa
         eD8baDTWOb66f2qPi0V9OXrNGBW07QG/N9EsCeHbSWGHbFtmaRifM1AbJuZtdXws5/E4
         nVAIcGuy4YYqJiOkPRgEATQv3u+NiOovedieeG1DHaM2DctfhpEt9MjYpna7gKd0qrgS
         FM3xKljVOlUuSjAO0FxvWcm9rHM7veHIAUvzha9mOCIllpYxCkaDubFmKPq1H9QRWyaB
         kgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jmk3EaUMyH3o2q6hi4mDaqdjnaIaz/WrF9xrUY0fsnc=;
        b=TV0x7B+O6RIp2j6mic/nOk76ZXqnuL3Wsp5IL9I9BZd3JPVPFMxFNo0u1QQYD/+TI7
         ShmYhBfam0Zd7Uf21/gLlrB55TX1+REqXl5Qjx1iL8q2eEbICLLbp6SUI4Jg9BDYDxYS
         wh0pzsIaS57YooowOMRtoef7Q95wYGsJPS4dKAo9WntdEES5OG1J1J+z5O6NUPWfSdjr
         YBCfeNcFpJrg/rtCs7TtNe5T7GlmPkXOlKCcYmWbhXfnKrHoVgMcMAtZzmnjfku5dCK9
         ntnZpuYIJJKrgDLi0qLMooSPzeOG5xJd0ny18Qi+1eG5mb9sDQ+6CkXydGIvEOWEQi+O
         yu4A==
X-Gm-Message-State: APjAAAU4SHOzxgJxz5MzBbAI/ZCRdtV+0W9qlYSTgBp9YHPY36fJGVEj
        nu7C7xl65qfxaX19o/QbSfuFRA==
X-Google-Smtp-Source: APXvYqwIbZghG9qVYf/8aXWdLBQZCUAfkCyg1h+a3QxlW+26J8iqi9a3RFQw4XXHaTX4H8/kjL/YCg==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3mr14259408wrt.259.1562166974813;
        Wed, 03 Jul 2019 08:16:14 -0700 (PDT)
Received: from [192.168.0.41] (143.197.22.93.rev.sfr.net. [93.22.197.143])
        by smtp.googlemail.com with ESMTPSA id x20sm2289399wmc.1.2019.07.03.08.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 08:16:14 -0700 (PDT)
Subject: Re: [PATCH] cpuidle/drivers/mobile: Add new governor for
 mobile/embedded systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel@vger.kernel.org,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:CPU IDLE TIME MANAGEMENT FRAMEWORK'" 
        <linux-pm@vger.kernel.org>, rafael@kernel.org
References: <20190620115826.4897-1-daniel.lezcano@linaro.org>
 <000101d531aa$e00987e0$a01c97a0$@net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6589a058-c538-fbf3-7761-d43ab8434654@linaro.org>
Date:   Wed, 3 Jul 2019 17:16:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000101d531aa$e00987e0$a01c97a0$@net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Doug,

On 03/07/2019 16:23, Doug Smythies wrote:
> Hi Daniel,
> 
> I tried your "mobile" governor, albeit not on a mobile device.
> 
> On 2019.06.20 04:58 Daniel Lezcano wrote:
> 
> ...
> 
>> The mobile governor is a new governor targeting embedded systems
>> running on battery where the energy saving has a higher priority than
>> servers or desktops. This governor aims to save energy as much as
>> possible but with a performance degradation tolerance.
>>
>> In this way, we can optimize the governor for specific mobile workload
>> and more generally embedded systems without impacting other platforms.
> 
> I just wanted to observe the lower energy, accepting performance
> degradation. My workloads may have been inappropriate.

Thanks for trying the governor. It is still basic but will be improved
step by step regarding clearly identified workload and with more help
from the scheduler. This is the first phase of the governor providing
the base bricks.

>> +
>> +#define EMA_ALPHA_VAL		64
>> +#define EMA_ALPHA_SHIFT		7
>> +#define MAX_RESCHED_INTERVAL_MS	100
>> +
>> +static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
>> +
>> +static int mobile_ema_new(s64 value, s64 ema_old)
>> +{
>> +	if (likely(ema_old))
>> +		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
>> +				  EMA_ALPHA_SHIFT);
>> +	return value;
>> +}
> 
> Do you have any information as to why these numbers?
>
> Without any background, the filter seems overly new value weighted to me.
> It is an infinite impulse response type filter, currently at:
> 
> output = 0.5 * old + 0.5 * new.
> 
> I tried, but didn't get anything conclusive:
> 
> output = 0.875 * old + 0.125 * new.
> 
> I did it this way:
> 
> #define EMA_ALPHA_VAL           7
> #define EMA_ALPHA_SHIFT         3
> #define MAX_RESCHED_INTERVAL_MS 100

Ok, I will have a look at these values.

> static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
> 
> static int mobile_ema_new(s64 value, s64 ema_old)
> {
>         if (likely(ema_old))
>                 return ((ema_old * EMA_ALPHA_VAL) + value) >>
>                                   EMA_ALPHA_SHIFT;
>         return value;
> }
> 
> ...
> 
>> +	/*
>> +	 * Sum all the residencies in order to compute the total
>> +	 * duration of the idle task.
>> +	 */
>> +	residency = dev->last_residency - s->exit_latency;
> 
> What about when the CPU comes out of the idle state before it
> even gets fully into it? Under such conditions it seems to hold
> much too hard at idle states that are too deep, to the point
> where energy goes up while performance goes down.

I'm not sure there is something we can do here :/


> Anyway, I did a bunch of tests and such, but have deleted
> most from this e-mail, because it's just noise. I'll
> include just one set:
> 
> For a work load that would normally result in a lot of use
> of shallow idle states (single core pipe-test * 2 cores).

Can you share the tests and the command lines?


> I got (all kernel 5.2-rc5 + this patch):
> 
> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
> Processor package power: 40.4 watts; 4.9 uSec/loop
> 
> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
> Processor package power: 34 watts; 5.2 uSec/loop
> 
> Idle governor, mobile; CPU frequency scaling: intel-cpufreq/ondemand;
> Processor package power: 25.9 watts; 11.1 uSec/loop
> 
> Idle governor, menu; CPU frequency scaling: intel-cpufreq/ondemand;
> Processor package power: 34.2 watts; 5.23 uSec/loop
> 
> Idle governor, teo; CPU frequency scaling: intel-cpufreq/ondemand;
> Maximum CPU frequency limited to 73% to match mobile energy.
> Processor package power: 25.4 watts; 6.4 uSec/loop

Ok that's interesting. Thanks for the values.

The governor can be better by selecting the shallow states, the
scheduler has to interact with the governor to give clues about the
load, that is identified and will be the next step.

Is it possible to check with the schedutil governor instead?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

