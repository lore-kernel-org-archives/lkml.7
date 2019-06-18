Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21E9206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcm1rElK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfFRJlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:41:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfFRJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:41:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so8706552lfh.13;
        Tue, 18 Jun 2019 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MVp7uympEdUunNVgJnVCM8FJZvV7BtdVx8tqs/H/PPc=;
        b=Tcm1rElKSu2AXmKY3bgAORWiNuozrZpdUzuD2KMmKdOG807fDr4wfEE9i52rZRM4QP
         D3baVumWo4nawXVpXM9bNiykJLKUztcT8S0ATutAHrMrIMZPB3+vYROGj/lx2YR90L3p
         QNmR/z5JoqJOGMf9S94A7XtsecHatn6tIQGvEOSpjSPvm7m0yHqTotV3k7Ly1S7hxmT7
         TCQe8whs2LZbbfJxXwBPlT76gdVB14F3wWt8QSGBW67Bf64rSpwZVPEGBXuLyjpxQe6T
         5Q49ifK23fPpjoLIRxznFszSOeslVgl93MY5oivExoDqHCSd5ucnwto737YVudHVQHF9
         eeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVp7uympEdUunNVgJnVCM8FJZvV7BtdVx8tqs/H/PPc=;
        b=nS62tzdHL4uA3RFXMxPJWe3SFgNJ4gD4kyyGbpHkrWyNkKzEqpXwraqZYBdXZn7YDm
         EjtIoDAwZ1GYm9+3kGFWYVtdTvuRkXMOOKxipF8m2f/GSrOEyhOaHCwGuUNyBi1zUX/f
         ZGTUh5EaspXKH+BaPHTEi8GnDyvMwvgICup4TodkdB9cPhCqy0pkHSOBcrCMu5T5I3ad
         zPNN+qJvfcWCP69kIBltXy0+GBlhtDdbtD+bZLsl5LY0FqgkHf8dgR2s6Qog0hImdKl5
         b2lTcP+MyuuhEw+r54LngB+CxjuUGVo3yIlvABnCYOzfRMSOPXk4Ds8qKtWZ9ixvxP/h
         pzAw==
X-Gm-Message-State: APjAAAVxCuhOKR+q7tituOtT8pV4hipJZ6c7TxYz1vmsfpAgoED6iJjA
        ap9rdImnn0EjVaGPUXAYrLQLwb8E
X-Google-Smtp-Source: APXvYqy2yyl2RzaShriV89SD/3IORxwh3Lb9X7kcV8Wl5tFoofYvIRSjKruCjwOr5z24186ix3dnYQ==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr10535640lfn.75.1560850876582;
        Tue, 18 Jun 2019 02:41:16 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id b11sm2511093ljf.8.2019.06.18.02.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 02:41:15 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] clocksource/drivers/tegra: Set and use timer's
 period
To:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-4-digetx@gmail.com>
 <ac8a1da8-9b82-3d5a-5fa6-0c1cc7f627f1@nvidia.com>
 <3e941c50-ac62-719e-aac1-7072e9a3bcd0@gmail.com>
 <660f3645-3fa6-175c-75a6-3fcc79e972ad@nvidia.com>
 <e0e1b708-7dd4-a58a-7906-05bf3065cbda@gmail.com>
 <b92383e6-31e4-0797-1e7a-76410ebfba6c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <af97341c-f787-2e35-eb63-e6b3138df8a9@gmail.com>
Date:   Tue, 18 Jun 2019 12:41:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <b92383e6-31e4-0797-1e7a-76410ebfba6c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2019 11:40, Jon Hunter пишет:
> 
> On 17/06/2019 15:04, Dmitry Osipenko wrote:
>> 17.06.2019 13:51, Jon Hunter пишет:
>>>
>>> On 14/06/2019 17:45, Dmitry Osipenko wrote:
>>>> 14.06.2019 18:48, Jon Hunter пишет:
>>>>>
>>>>> On 10/06/2019 17:43, Dmitry Osipenko wrote:
>>>>>> The of_clk structure has a period field that is set up initially by
>>>>>> timer_of_clk_init(), that period value need to be adjusted for a case of
>>>>>> TIMER1-9 that are running at a fixed rate that doesn't match the clock's
>>>>>> rate. Note that the period value is currently used only by some of the
>>>>>> clocksource drivers internally and hence this is just a minor cleanup
>>>>>> change that doesn't fix anything.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  drivers/clocksource/timer-tegra.c | 5 +++--
>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>>>>>> index 810b4e7435cf..646b3530c2d2 100644
>>>>>> --- a/drivers/clocksource/timer-tegra.c
>>>>>> +++ b/drivers/clocksource/timer-tegra.c
>>>>>> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
>>>>>>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>>>>>  {
>>>>>>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>>>>>> +	unsigned long period = timer_of_period(to_timer_of(evt));
>>>>>>  
>>>>>> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
>>>>>> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
>>>>>> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>>>>>>  		       reg_base + TIMER_PTV);
>>>>>>  
>>>>>>  	return 0;
>>>>>> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>>>>>  		cpu_to->clkevt.rating = rating;
>>>>>>  		cpu_to->clkevt.cpumask = cpumask_of(cpu);
>>>>>>  		cpu_to->of_base.base = timer_reg_base + base;
>>>>>> +		cpu_to->of_clk.period = DIV_ROUND_UP(rate, HZ);
>>>>>
>>>>> Any reason you made this a round-up?
>>>>
>>>> That's what timer_of_clk_init() does, I assume it should be a more correct variant.
>>>
>>> Sounds to me like this should be 2 patches, because you are changing the
>>> value. This is not just purely cleanup IMO.
>>
>> Indeed, that could be at least mentioned in the commit message. Probably I just
>> assumed that this is such a minor change that not worth anything. A hundred of
>> microseconds is hardly noticeable.
>>
>> I'm not really sure if this really worth a re-spin at this point. Jon, are you insisting?
> 
> At a minimum the changelog needs to be udpated to reflect what is going
> on here. Yes it may not be a massive difference, but I prefer not to
> change things without any rationale.

Okay, I'll respin this series and probably will just drop the round-up. I'll also
append the other two new patches "cycles can't be 0" and "max limit correction" to
this series.

Daniel, I'll also correct the "Fixes" tag to satisfy the linux-next patch checker.
