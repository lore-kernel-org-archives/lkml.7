Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36353C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6E720836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eacPMb3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGBJHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:07:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35149 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:07:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so107463wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4HxjVvwI55coPU+osq21qWtWbtvr2h0ZIAaAI4JjGc=;
        b=eacPMb3RtzXRp0MoZuWr+7eXy8QPTEQUq8PzIf4QEBQB6z/a9RyRz4oZQMpc8ucKbb
         8N/OCmMMFbtAStQng3VxWPIUI8ToXUBzNpWT0m4ldAx4DFUhpC/gujPXqTrx2W0hO500
         2Q911NwCnUViWlewXOykBBvnLyfnZQQf1axOcn5ggoVomi5YHcOvkQvohaaN+WSqpeem
         RY7525xh3th6HNIFxZMRkfozh5fGl+9pI9LGhzicDPoUDnqSjwJerulSv3n5mWeR1YUz
         MVCg+Q1nQLPqA58SV5IZbX+KN5aGux/PZkAIbbx3m1tEzBNadIwaMoF35DtReDLGAn04
         FVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V4HxjVvwI55coPU+osq21qWtWbtvr2h0ZIAaAI4JjGc=;
        b=ZIG34K9e+f9vP7iXnwXRx+3iINaqHRW6E0SFVJ9h0jrtSLHsZXTLekHypiQzQtL0Yf
         brTdwIeDeS6wJxuzAHItCGqoFSs4EcRHbiCby+0Vr1EI/a6kkpC0gAxYI5NZ6b+McWpA
         zDqT5TjLRHgHyKuU7PIAN9nK1NYVcGVx/VubZiG0vdxlFG6QbEO0ZPQJU6f75iGm9yLx
         tZxP85CPeBF1RNiwcq1vrpt0nqfANz5qIqjxfxfTB87Dnncri5ffss+JaPvyMUcvtHC1
         FLlt4j56Iyvks81k5FmUPBxJX3KwE6nfJzGkw65CbcKrW1L0p+2syQOmzhYfeWt4A1Ls
         EATA==
X-Gm-Message-State: APjAAAVmOTJBdQOWIt/BLnbSPt4k5g4f7mQ21jqMV76FkZQu7PuMn1ya
        vmP0VLSbGoLCD1HrUloQHvyUOQ==
X-Google-Smtp-Source: APXvYqyn3uOazHwJTQdZXGCSxlU7zGJstVqFVi8qJ6rrSXzE+pfr7rjZWbLXpcnnEWduyGPZuMOtFw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr2808751wme.113.1562058463367;
        Tue, 02 Jul 2019 02:07:43 -0700 (PDT)
Received: from [192.168.0.41] (132.97.130.77.rev.sfr.net. [77.130.97.132])
        by smtp.googlemail.com with ESMTPSA id u1sm2426957wml.14.2019.07.02.02.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 02:07:42 -0700 (PDT)
Subject: Re: [PATCH RESEND V4 1/5] clocksource: timer-of: Support getting
 clock frequency from DT
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <20190702075513.17451-1-Anson.Huang@nxp.com>
 <c7ff76e5-d73d-e71e-c3f4-445bdd2c5b93@linaro.org>
 <DB3PR0402MB39166F04BAF9BA9D6C75B3A8F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0540a255-93e5-d68f-5bf5-31f9043fb3ad@linaro.org>
Date:   Tue, 2 Jul 2019 11:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39166F04BAF9BA9D6C75B3A8F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2019 11:03, Anson Huang wrote:
> Hi, Daniel
> 
>> Hi Anson,
>>
>> why did you resend the series?
> 
> Previous patch series has build warning and I did NOT notice, sorry for that,
> 
> drivers/clocksource/timer-of.c: In function ‘timer_of_init’:
> drivers/clocksource/timer-of.c:185:30: warning: suggest parentheses around comparison in operand of ‘&’ [-Wparentheses]
>   if (to->flags & clock_flags == clock_flags)
>                               ^
> 
> so I resend the patch series with below, sorry for missing mention of the changes in resent patch series.
> 
>  +	if ((to->flags & clock_flags) == clock_flags)
> 
> Sorry for mail storm...

No problem at all, I prefer this caught and fixed early :)

Next time just send a V5 because 'resend' means there is no change but
there was a problem with the email (could be also interpreted as a
gentle ping).

>> On 02/07/2019 09:55, Anson.Huang@nxp.com wrote:
>>> From: Anson Huang <Anson.Huang@nxp.com>
>>>
>>> More and more platforms use platform driver model for clock driver, so
>>> the clock driver is NOT ready during timer initialization phase, it
>>> will cause timer initialization failed.
>>>
>>> To support those platforms with upper scenario, introducing a new flag
>>> TIMER_OF_CLOCK_FREQUENCY which is mutually exclusive with
>>> TIMER_OF_CLOCK flag to support getting timer clock frequency from DT's
>>> timer node, the property name should be "clock-frequency", then of_clk
>>> operations can be skipped.
>>>
>>> User needs to select either TIMER_OF_CLOCK_FREQUENCY or
>> TIMER_OF_CLOCK
>>> flag if want to use timer-of driver to initialize the clock rate.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> Changes since V3:
>>> 	- use hardcoded "clock-frequency" instead of adding new variable
>> prop_name;
>>> 	- add pre-condition check for TIMER_OF_CLOCK and
>> TIMER_OF_CLOCK_FREQUENCY, they MUST be exclusive.
>>> ---
>>>  drivers/clocksource/timer-of.c | 29 +++++++++++++++++++++++++++++
>>> drivers/clocksource/timer-of.h |  7 ++++---
>>>  2 files changed, 33 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-of.c
>>> b/drivers/clocksource/timer-of.c index 8054228..858f684 100644
>>> --- a/drivers/clocksource/timer-of.c
>>> +++ b/drivers/clocksource/timer-of.c
>>> @@ -161,11 +161,30 @@ static __init int timer_of_base_init(struct
>> device_node *np,
>>>  	return 0;
>>>  }
>>>
>>> +static __init int timer_of_clk_frequency_init(struct device_node *np,
>>> +					      struct of_timer_clk *of_clk) {
>>> +	int ret;
>>> +	u32 rate;
>>> +
>>> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
>>> +	if (!ret) {
>>> +		of_clk->rate = rate;
>>> +		of_clk->period = DIV_ROUND_UP(rate, HZ);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  int __init timer_of_init(struct device_node *np, struct timer_of *to)
>>> {
>>> +	unsigned long clock_flags = TIMER_OF_CLOCK |
>>> +TIMER_OF_CLOCK_FREQUENCY;
>>>  	int ret = -EINVAL;
>>>  	int flags = 0;
>>>
>>> +	if ((to->flags & clock_flags) == clock_flags)
>>> +		return ret;
>>> +
>>>  	if (to->flags & TIMER_OF_BASE) {
>>>  		ret = timer_of_base_init(np, &to->of_base);
>>>  		if (ret)
>>> @@ -180,6 +199,13 @@ int __init timer_of_init(struct device_node *np,
>> struct timer_of *to)
>>>  		flags |= TIMER_OF_CLOCK;
>>>  	}
>>>
>>> +	if (to->flags & TIMER_OF_CLOCK_FREQUENCY) {
>>> +		ret = timer_of_clk_frequency_init(np, &to->of_clk);
>>> +		if (ret)
>>> +			goto out_fail;
>>> +		flags |= TIMER_OF_CLOCK_FREQUENCY;
>>> +	}
>>> +
>>>  	if (to->flags & TIMER_OF_IRQ) {
>>>  		ret = timer_of_irq_init(np, &to->of_irq);
>>>  		if (ret)
>>> @@ -201,6 +227,9 @@ int __init timer_of_init(struct device_node *np,
>> struct timer_of *to)
>>>  	if (flags & TIMER_OF_CLOCK)
>>>  		timer_of_clk_exit(&to->of_clk);
>>>
>>> +	if (flags & TIMER_OF_CLOCK_FREQUENCY)
>>> +		to->of_clk.rate = 0;
>>> +
>>>  	if (flags & TIMER_OF_BASE)
>>>  		timer_of_base_exit(&to->of_base);
>>>  	return ret;
>>> diff --git a/drivers/clocksource/timer-of.h
>>> b/drivers/clocksource/timer-of.h index a5478f3..a08e108 100644
>>> --- a/drivers/clocksource/timer-of.h
>>> +++ b/drivers/clocksource/timer-of.h
>>> @@ -4,9 +4,10 @@
>>>
>>>  #include <linux/clockchips.h>
>>>
>>> -#define TIMER_OF_BASE	0x1
>>> -#define TIMER_OF_CLOCK	0x2
>>> -#define TIMER_OF_IRQ	0x4
>>> +#define TIMER_OF_BASE			0x1
>>> +#define TIMER_OF_CLOCK			0x2
>>> +#define TIMER_OF_IRQ			0x4
>>> +#define TIMER_OF_CLOCK_FREQUENCY	0x8
>>>
>>>  struct of_timer_irq {
>>>  	int irq;


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

