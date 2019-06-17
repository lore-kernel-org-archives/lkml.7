Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398AFC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5562084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTfnykgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfFQOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:04:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33302 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:04:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so55832wme.0;
        Mon, 17 Jun 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BuqClaap0w5GHctpIDrpMGvsw7n1c6lqu80Oeh7+HF4=;
        b=LTfnykgvaXHiqXM050U7gKRlj3j8cKCyF4O+eKf+23gaHgsXH96Ha2qmlkHDQul9eK
         L3lZXvdIrwiwr0SVuAmxVmr0vFvnv1GxCItel0zmvH9uUr/QXXeqGiqyCafyOd7vsfo5
         yZ85msUx+Qmwmhz1KJuerPVq3h5ucE0IbLVL0k5sEApEiaFSOHetWqvbcBVIJcz1cww5
         MCtF0TDQ6AtM83Pieg6VeqQbAPa6Xiwa4BrXcGQOGhGXirebkQaz8EL4vOZjEgsZZ6B8
         C6yakwuJFTRWZPiGPU8yOk8qKhxBLG3cT6gIoYP9cvGVuWvclGHqZAU6xM8p8G34h5m1
         rJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BuqClaap0w5GHctpIDrpMGvsw7n1c6lqu80Oeh7+HF4=;
        b=ty8zGFUgZEtnfKKiaQe5cBYiv0M6LVVrrUWD/JWKODTGhds24kZ05uDyeS6Y69DtXb
         UrtFDAMCcL/Xh8h2w6VPUsd+CtM7aeHShFRS4FTkQP9282zPY5j9lkr34n+qtFguAKKq
         XyoRPyhu3AI8SkeEA89F08i595XHxyXZgfaMTSzoL0W8IOFreHT2kTkY/ailLI3XTrqi
         iEi1TaZOEQLa4LuxMqW2zEGSuUOWNGIWTVVVEcu0UbcI0+TDfvhq0MGvgps02HDmy/Nz
         eQDWcvdN8zdN2xz87fpp2A+kkYpqm3UdEvEWcgD0wWWrVEX7n1SpiJe590G9EZ/IT+oI
         rvGw==
X-Gm-Message-State: APjAAAXEVdznCJBgCu3xT3IXsHbKqGfzpE30bLGrjF6zhlBDPlmr1oIo
        MT1yW5ZB8aodK4nFV3+taR8TUCQF
X-Google-Smtp-Source: APXvYqxGKvhJt9PMQ8eRA08hSnu0dr+vzetCPAfysG3aTTP0mlDqN83vTBvZuTwkyKKsfokZrSQ61w==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr18157057wmh.132.1560780263321;
        Mon, 17 Jun 2019 07:04:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id e11sm11378596wrc.9.2019.06.17.07.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 07:04:22 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e0e1b708-7dd4-a58a-7906-05bf3065cbda@gmail.com>
Date:   Mon, 17 Jun 2019 17:04:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <660f3645-3fa6-175c-75a6-3fcc79e972ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 13:51, Jon Hunter пишет:
> 
> On 14/06/2019 17:45, Dmitry Osipenko wrote:
>> 14.06.2019 18:48, Jon Hunter пишет:
>>>
>>> On 10/06/2019 17:43, Dmitry Osipenko wrote:
>>>> The of_clk structure has a period field that is set up initially by
>>>> timer_of_clk_init(), that period value need to be adjusted for a case of
>>>> TIMER1-9 that are running at a fixed rate that doesn't match the clock's
>>>> rate. Note that the period value is currently used only by some of the
>>>> clocksource drivers internally and hence this is just a minor cleanup
>>>> change that doesn't fix anything.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/clocksource/timer-tegra.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>>>> index 810b4e7435cf..646b3530c2d2 100644
>>>> --- a/drivers/clocksource/timer-tegra.c
>>>> +++ b/drivers/clocksource/timer-tegra.c
>>>> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
>>>>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>>>>  {
>>>>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>>>> +	unsigned long period = timer_of_period(to_timer_of(evt));
>>>>  
>>>> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
>>>> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
>>>> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>>>>  		       reg_base + TIMER_PTV);
>>>>  
>>>>  	return 0;
>>>> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>>>  		cpu_to->clkevt.rating = rating;
>>>>  		cpu_to->clkevt.cpumask = cpumask_of(cpu);
>>>>  		cpu_to->of_base.base = timer_reg_base + base;
>>>> +		cpu_to->of_clk.period = DIV_ROUND_UP(rate, HZ);
>>>
>>> Any reason you made this a round-up?
>>
>> That's what timer_of_clk_init() does, I assume it should be a more correct variant.
> 
> Sounds to me like this should be 2 patches, because you are changing the
> value. This is not just purely cleanup IMO.

Indeed, that could be at least mentioned in the commit message. Probably I just
assumed that this is such a minor change that not worth anything. A hundred of
microseconds is hardly noticeable.

I'm not really sure if this really worth a re-spin at this point. Jon, are you insisting?

Also, I now see that some drivers use DIV_ROUND_CLOSEST(), maybe it will be even
better? Not sure.. given that this is still a microseconds difference.
