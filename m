Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A324648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rohax8+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfLEQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:24:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfLEQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:24:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id y23so7734899wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/iUpNQSehsWiAsCyu1lIopep1wl7J00yoEEiWF1qjNo=;
        b=rohax8+wapGP8khtkuu1uay5xXRQwiIkV1cxSPwIwJyBLvg8W0/KUPklpZO2D5uHim
         FOfGVxqL61yBlscGe/+bwgc3sWY47bOIvfYbIpM4Iro9WK4HJhd2kZjTN43mJzPZy5GN
         Gjq3HMK42zvQxtSKym6dbBaHfH/EwFAEY8rzlb34Lem8hIRZng5gUjHR0XXAtpq9szAe
         aPngYKuKZRbyy9iSREclgNP4BSPnvo1KvkJvF503+hZ8S2Gnt4Uuc51LUva894HDPf5h
         wfakM4Hl90uI2xUf5sbZ84A0liSUgLc4Sd4+FruBaJZdYV2K56jLj5iemypPDeZMSGL9
         visw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/iUpNQSehsWiAsCyu1lIopep1wl7J00yoEEiWF1qjNo=;
        b=ZCgmJr54KGtv3Mv8R1+3Ww0UZquITRGCYpCMOf5us8BFFyiNeAOoBtNKEfmBlNB0F9
         WZK2l79qvfvB5sWeDoUTQsfqcXdau2PZjizSZYZ0glPUIaqIfVvgTabwFxeNSG/JoNe8
         mT02Cgserrubp71VUn1aBQwmA1JeijB7lH6w+YAOgJJH7cVWa0NtOGCPIaCzmq6X7H65
         UiYsQ8NVunMcoG0m//q2UIIttqvgSrlKANWBQKm4i7Rb7uigmfvcKSv+50wakY6ilTrZ
         wob2OI8DCaQc48v06PYPOU4qfvnvWrMa7QUdoqJvD79p5yUJRwAB2ZT7TdBG98CDkkkI
         VhYA==
X-Gm-Message-State: APjAAAVkypKXzQ/nLFcatUomrFVrt+3uvt03GDw87fWpwOf4W1gZQmFf
        IRKeFCKPWnS1stG5aLqaziiEvVijibU=
X-Google-Smtp-Source: APXvYqwSOKMT3nnmqzN1dnucnXr9St1oHMMK/XifljrL5PPAGEslXlS/Yj7cAWSwvznV9CY1GAZaqw==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr5883721wmi.118.1575563070835;
        Thu, 05 Dec 2019 08:24:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6? ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.googlemail.com with ESMTPSA id x10sm12878522wrv.60.2019.12.05.08.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 08:24:30 -0800 (PST)
Subject: Re: [PATCH] drivers: clocksource: Use ttc driver as platform driver
To:     Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
 <BYAPR02MB40555C1884AA318D9E79EFFEB7450@BYAPR02MB4055.namprd02.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2ffe4baf-1de1-3f0e-311f-dd1fdaf1cee8@linaro.org>
Date:   Thu, 5 Dec 2019 17:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB40555C1884AA318D9E79EFFEB7450@BYAPR02MB4055.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2019 12:53, Rajan Vaja wrote:
> Request for review.

Waiting from Michal Simek review ...


>> -----Original Message-----
>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>> Sent: 07 November 2019 04:06 PM
>> To: Michal Simek <michals@xilinx.com>; daniel.lezcano@linaro.org;
>> tglx@linutronix.de
>> Cc: linux-arm-kernel@lists.infradead.org; Jolly Shah <JOLLYS@xilinx.com>; linux-
>> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
>> Subject: [PATCH] drivers: clocksource: Use ttc driver as platform driver
>>
>> Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
>> that, TTC driver may be initialized before other clock drivers. If
>> TTC driver is dependent on that clock driver then initialization of
>> TTC driver will failed.
>>
>> So use TTC driver as platform driver instead of using
>> TIMER_OF_DECLARE.
>>
>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>> ---
>>  drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++++--------
>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-
>> cadence-ttc.c
>> index 88fe2e9..38858e1 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -15,6 +15,8 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/slab.h>
>>  #include <linux/sched_clock.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>>
>>  /*
>>   * This driver configures the 2 16/32-bit count-up timers as follows:
>> @@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>  	return 0;
>>  }
>>
>> -/**
>> - * ttc_timer_init - Initialize the timer
>> - *
>> - * Initializes the timer hardware and register the clock source and clock event
>> - * timers with Linux kernal timer framework
>> - */
>> -static int __init ttc_timer_init(struct device_node *timer)
>> +static int __init ttc_timer_probe(struct platform_device *pdev)
>>  {
>>  	unsigned int irq;
>>  	void __iomem *timer_baseaddr;
>> @@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
>>  	static int initialized;
>>  	int clksel, ret;
>>  	u32 timer_width = 16;
>> +	struct device_node *timer = pdev->dev.of_node;
>>
>>  	if (initialized)
>>  		return 0;
>> @@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
>>  	return 0;
>>  }
>>
>> -TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
>> +static const struct of_device_id ttc_timer_of_match[] = {
>> +	{.compatible = "cdns,ttc"},
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
>> +
>> +static struct platform_driver ttc_timer_driver = {
>> +	.driver = {
>> +		.name	= "cdns_ttc_timer",
>> +		.of_match_table = ttc_timer_of_match,
>> +	},
>> +};
>> +builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
>> --
>> 2.7.4
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

