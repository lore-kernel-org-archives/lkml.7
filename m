Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D4C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F220693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0sVU6Zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfDOMgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:36:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40014 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfDOMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:36:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so20371758wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+9SvSXgAtl/2CAFXsrdY5akT9tvybhjeyRAQfcN16s=;
        b=K0sVU6Zszxcqf0HwQFT4rRrbyxl4kprovp0SWiAUVgwKqqKFPSO9niwftV/aNyvIHk
         mhcXDMn8SqsgjT9Id4s1nA2yI60ekL3Wf/ZRNfjjFwuemBnwAZ7x/q7k7nuhyVIVqVbI
         GJankaT1kYDL+Oh6PWMuDEVp6Wk0HrWsK3V2RQgrouT2DvxfzeSE5gfvXdOaxc/QS4Og
         +F2jm1dhiRKRtevZVUiW0sALXfiOULTtcY0SXu5GQRYIYzoX1rUhf2rEMR6MqzDjsaC/
         5La0kjSmWpDfyPUP+MjNOnL8DaA7P/QG06ZQTpz5b6gazzPmo/xE77ZH2XSykMWZtp8R
         S3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+9SvSXgAtl/2CAFXsrdY5akT9tvybhjeyRAQfcN16s=;
        b=gsJDqDZ4YwkYNdvZsIG9hB4/awAY+WIV245yW/vqZHwsy3oD4nxxGSlnJSWg4WywZP
         jC/AT4mAAMHwg9h7r4IyDRwRZbpkQafFr4qK7r7dga9cFpevugKcsxxcS6+IhZK4ncv6
         TViRibImcfjeLkXNHfcIwvCxJpt+5Epsol+Bdl2dX1+DschmbzHo4AdpLPvpuE8YnLFg
         u5HgW8lJ3KFB2mjJbYn0XLIrcPECV5sqf9Q5OeH83BoqPnBItchI9F9J1HU0+ycUB8LN
         PHZgP/JlFVZGo9h3cdhNybwOlQVF9LyR/Hi0JDX2CvB4Xs6s9xKBexRTqXdescxgv40s
         aboQ==
X-Gm-Message-State: APjAAAWmhRQof1unTYTxPh4ROLAo9bFNNBzdK+SE7Pqp3DITV1E1iXK7
        k0inCGM7h2cONKJ65tkETqlF8A==
X-Google-Smtp-Source: APXvYqy6fXvjz5kLMDbLblVMhy0bg9hpBZVULVeeodXi4RLGv5wUEuSrYwsRTJKKGZGaaQAteI9MPw==
X-Received: by 2002:a1c:cf46:: with SMTP id f67mr21484965wmg.98.1555331801914;
        Mon, 15 Apr 2019 05:36:41 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id y125sm27394001wmc.39.2019.04.15.05.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 05:36:41 -0700 (PDT)
Subject: Re: [PATCH v4 01/11] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318121100.28132-1-brgl@bgdev.pl>
 <20190318121100.28132-2-brgl@bgdev.pl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d3d05858-966b-cd4a-3286-97e7d7bde0bc@linaro.org>
Date:   Mon, 15 Apr 2019 14:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190318121100.28132-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 13:10, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the clocksource and clockevent support for davinci platforms
> lives in mach-davinci. It hard-codes many things, uses global variables,
> implements functionalities unused by any platform and has code fragments
> scattered across many (often unrelated) files.
> 
> Implement a new, modern and simplified timer driver and put it into
> drivers/clocksource. We still need to support legacy board files so
> export a config structure and a function that allows machine code to
> register the timer.
> 
> We don't bother freeing resources on errors in davinci_timer_register()
> as the system won't boot without a timer anyway.

Can you give a quick description of the timer hardware and how it works?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---
>  drivers/clocksource/Kconfig         |   5 +
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-davinci.c | 438 ++++++++++++++++++++++++++++
>  include/clocksource/timer-davinci.h |  44 +++
>  4 files changed, 488 insertions(+)
>  create mode 100644 drivers/clocksource/timer-davinci.c
>  create mode 100644 include/clocksource/timer-davinci.h
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 171502a356aa..08b1f539cfc4 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -42,6 +42,11 @@ config BCM_KONA_TIMER
>  	help
>  	  Enables the support for the BCM Kona mobile timer driver.
>  
> +config DAVINCI_TIMER
> +	bool "Texas Instruments DaVinci timer driver"

Make the option silent (eg. if COMPILE_TEST)

> +	help
> +	  Enables the support for the TI DaVinci timer driver.
> +
>  config DIGICOLOR_TIMER
>  	bool "Digicolor timer driver" if COMPILE_TEST
>  	select CLKSRC_MMIO
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index be6e0fbc7489..3c73d0e58b45 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
>  obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
>  obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
>  obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
> +obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
>  obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
>  obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
>  obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> new file mode 100644
> index 000000000000..46dfc4d457fc
> --- /dev/null
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// TI DaVinci clocksource driver
> +//
> +// Copyright (C) 2019 Texas Instruments
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +// (with some parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +
> +#include <clocksource/timer-davinci.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "%s: " fmt "\n", __func__
> +
> +#define DAVINCI_TIMER_REG_TIM12			0x10
> +#define DAVINCI_TIMER_REG_TIM34			0x14
> +#define DAVINCI_TIMER_REG_PRD12			0x18
> +#define DAVINCI_TIMER_REG_PRD34			0x1c
> +#define DAVINCI_TIMER_REG_TCR			0x20
> +#define DAVINCI_TIMER_REG_TGCR			0x24
> +
> +#define DAVINCI_TIMER_TIMMODE_MASK		GENMASK(3, 2)
> +#define DAVINCI_TIMER_RESET_MASK		GENMASK(1, 0)
> +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED	BIT(2)
> +#define DAVINCI_TIMER_UNRESET			GENMASK(1, 0)
> +
> +/* Shift depends on timer. */
> +#define DAVINCI_TIMER_ENAMODE_MASK		GENMASK(1, 0)
> +#define DAVINCI_TIMER_ENAMODE_DISABLED		0x00
> +#define DAVINCI_TIMER_ENAMODE_ONESHOT		BIT(0)
> +#define DAVINCI_TIMER_ENAMODE_PERIODIC		BIT(1)
> +
> +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12	6
> +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34	22
> +
> +#define DAVINCI_TIMER_MIN_DELTA			0x01
> +#define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
> +
> +#define DAVINCI_TIMER_CLKSRC_BITS		32
> +
> +#define DAVINCI_TIMER_TGCR_DEFAULT \
> +		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
> +
> +enum {
> +	DAVINCI_TIMER_MODE_DISABLED = 0,
> +	DAVINCI_TIMER_MODE_ONESHOT,
> +	DAVINCI_TIMER_MODE_PERIODIC,
> +};

This is replicating what is already available. Right after set_periodic
or set_oneshot are called, the timer state is changed to respectively
CLOCK_EVT_STATE_PERIODIC and CLOCK_EVT_STATE_ONESHOT. So it is useless
to define those enum again as what you want is to check the timer mode.


[ ... ]

> +
> +	clocksource = kzalloc(sizeof(*clocksource), GFP_KERNEL);
> +	if (!clocksource) {
> +		pr_err("Error allocating memory for clocksource data");
> +		return -ENOMEM;
> +	}
> +
> +	clocksource->dev.rating = 300;
> +	clocksource->dev.read = davinci_timer_clksrc_read;
> +	clocksource->dev.mask = CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
> +	clocksource->dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;

>>>

> +	clocksource->timer.set_period = davinci_timer_set_period_std;
> +	clocksource->timer.mode = DAVINCI_TIMER_MODE_PERIODIC;
> +	clocksource->timer.base = base;

What for?

<<<

> +	if (timer_cfg->cmp_off) {
> +		clocksource->timer.regs = &davinci_timer_tim12_regs;
> +		clocksource->dev.name = "tim12";
> +	} else {
> +		clocksource->timer.regs = &davinci_timer_tim34_regs;
> +		clocksource->dev.name = "tim34";
> +	}
> +
> +	rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKSOURCE_IRQ].start,
> +			 davinci_timer_irq_freerun, IRQF_TIMER,
> +			 "free-run counter", clocksource);
> +	if (rv) {
> +		pr_err("Unable to request the clocksource interrupt");
> +		return rv;
> +	}

Why do you have to request an interrupt to do nothing? Isn't possible to
let the timer run and wrap without generating interrupts?

[ ... ]




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

