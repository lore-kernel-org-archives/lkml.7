Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DDC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70972184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnEFc1Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfGBIGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34847 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfGBIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id c27so8932297wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Uf+doeO5VtjdYVajvd6K1kZS8kG10W1FFm+PhtOBRg=;
        b=gnEFc1YtN21E7WYDMG8pTDp6oCGt2jPIS3ZMtgDDYPm48OAHD2ZhMajQAsRwk7CZxn
         jeQkIjU08B/AJuKHubmRUTtoB+8uHgRe7y77cuVyKLvxf3/TqHxk+d3PBmV4NnFolUCL
         2DQQ3Cs8sNv94OyZZvZ/Ey0mU4PzuiWEpZSfCBMlekkOWwUqKA+ul+wkVkq3x7GQUqiC
         pOaoLxusEfLn5Iuykn4MUmhC6VjYwcWXxWRaQy3p/hFF0yqOh6RVrwmkSZ6mWNFv84iu
         zpIaBynXnOMnLlomqNpm4zauTeorutV8cx5VwaoyyoOVB847Cv8l2irNdaOol4pMGqzr
         GrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3Uf+doeO5VtjdYVajvd6K1kZS8kG10W1FFm+PhtOBRg=;
        b=fDGH/tWoZ96DW1ChAZYwhTry8tPxHAdeh/yFuV2K0yg7Yk0K7Twi4Bxf/5Pb+o13Oh
         wc3kiGR90OGHhKL1Sn/UJHLmKCukTpFlqVfTPmiSvkBpAqVxzYw/liPxkvLgKY2kIxoR
         KfDquxeUMsSBVo8teL9PwH1PLveEci5bimORd6ckK+cf56smys74FytIcEbrnYKuoOWV
         zztu8i3Hq5ASjpW1hD8dKcnLjuX9qZkW9qeZvbKWVcGXFFl1MRrOPIX1vzOV+wga1AI+
         ejD0jJvdPmUHQMs6aZSU0KJ+9989Z50fdHrL8cm8p7GMGkzcmr0UTYRCEKuZ7mtGq2oG
         v8kA==
X-Gm-Message-State: APjAAAUHibIz+w8NCNj3RL7cpyhYnBfxqcWdUOouF1rjK0WIBNqle2I9
        k1CMo2qhQfYOMUC5n6cFWIIhtw==
X-Google-Smtp-Source: APXvYqzdZ545A3N7T9K2xF2eUZix4M/zpqfeQzEl2jnLUgzNiOHY7TU3bxPID739k8UGfyVsl6CdJg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr22916612wrq.28.1562054808004;
        Tue, 02 Jul 2019 01:06:48 -0700 (PDT)
Received: from [192.168.0.41] (132.97.130.77.rev.sfr.net. [77.130.97.132])
        by smtp.googlemail.com with ESMTPSA id o14sm10152987wrp.77.2019.07.02.01.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:06:47 -0700 (PDT)
Subject: Re: [PATCH RESEND V4 1/5] clocksource: timer-of: Support getting
 clock frequency from DT
To:     Anson.Huang@nxp.com, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
References: <20190702075513.17451-1-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c7ff76e5-d73d-e71e-c3f4-445bdd2c5b93@linaro.org>
Date:   Tue, 2 Jul 2019 10:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702075513.17451-1-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

why did you resend the series?


On 02/07/2019 09:55, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> More and more platforms use platform driver model for clock driver,
> so the clock driver is NOT ready during timer initialization phase,
> it will cause timer initialization failed.
> 
> To support those platforms with upper scenario, introducing a new
> flag TIMER_OF_CLOCK_FREQUENCY which is mutually exclusive with
> TIMER_OF_CLOCK flag to support getting timer clock frequency from
> DT's timer node, the property name should be "clock-frequency",
> then of_clk operations can be skipped.
> 
> User needs to select either TIMER_OF_CLOCK_FREQUENCY or TIMER_OF_CLOCK
> flag if want to use timer-of driver to initialize the clock rate.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- use hardcoded "clock-frequency" instead of adding new variable prop_name;
> 	- add pre-condition check for TIMER_OF_CLOCK and TIMER_OF_CLOCK_FREQUENCY, they MUST be exclusive.
> ---
>  drivers/clocksource/timer-of.c | 29 +++++++++++++++++++++++++++++
>  drivers/clocksource/timer-of.h |  7 ++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index 8054228..858f684 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -161,11 +161,30 @@ static __init int timer_of_base_init(struct device_node *np,
>  	return 0;
>  }
>  
> +static __init int timer_of_clk_frequency_init(struct device_node *np,
> +					      struct of_timer_clk *of_clk)
> +{
> +	int ret;
> +	u32 rate;
> +
> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
> +	if (!ret) {
> +		of_clk->rate = rate;
> +		of_clk->period = DIV_ROUND_UP(rate, HZ);
> +	}
> +
> +	return ret;
> +}
> +
>  int __init timer_of_init(struct device_node *np, struct timer_of *to)
>  {
> +	unsigned long clock_flags = TIMER_OF_CLOCK | TIMER_OF_CLOCK_FREQUENCY;
>  	int ret = -EINVAL;
>  	int flags = 0;
>  
> +	if ((to->flags & clock_flags) == clock_flags)
> +		return ret;
> +
>  	if (to->flags & TIMER_OF_BASE) {
>  		ret = timer_of_base_init(np, &to->of_base);
>  		if (ret)
> @@ -180,6 +199,13 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>  		flags |= TIMER_OF_CLOCK;
>  	}
>  
> +	if (to->flags & TIMER_OF_CLOCK_FREQUENCY) {
> +		ret = timer_of_clk_frequency_init(np, &to->of_clk);
> +		if (ret)
> +			goto out_fail;
> +		flags |= TIMER_OF_CLOCK_FREQUENCY;
> +	}
> +
>  	if (to->flags & TIMER_OF_IRQ) {
>  		ret = timer_of_irq_init(np, &to->of_irq);
>  		if (ret)
> @@ -201,6 +227,9 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>  	if (flags & TIMER_OF_CLOCK)
>  		timer_of_clk_exit(&to->of_clk);
>  
> +	if (flags & TIMER_OF_CLOCK_FREQUENCY)
> +		to->of_clk.rate = 0;
> +
>  	if (flags & TIMER_OF_BASE)
>  		timer_of_base_exit(&to->of_base);
>  	return ret;
> diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
> index a5478f3..a08e108 100644
> --- a/drivers/clocksource/timer-of.h
> +++ b/drivers/clocksource/timer-of.h
> @@ -4,9 +4,10 @@
>  
>  #include <linux/clockchips.h>
>  
> -#define TIMER_OF_BASE	0x1
> -#define TIMER_OF_CLOCK	0x2
> -#define TIMER_OF_IRQ	0x4
> +#define TIMER_OF_BASE			0x1
> +#define TIMER_OF_CLOCK			0x2
> +#define TIMER_OF_IRQ			0x4
> +#define TIMER_OF_CLOCK_FREQUENCY	0x8
>  
>  struct of_timer_irq {
>  	int irq;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

