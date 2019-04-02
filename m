Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B620882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgbI1a2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfDBJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:21:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:21:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so6073865pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5wQ9BNbiYtLVNHNYdrbJ4Nx/HItvdJXlh3jzLGMQ1k=;
        b=cgbI1a2An1rTPSsGU3zbIW37PoNDUbSa/JyknSVuVpomlM8KS6iVYyem2d7XewSb20
         3a08Obve/Gl8RH7mwRlp9uZY+55qnQ9p2NRdBYLxCwPWXgowjbezv9c6AXVFmqdgLdT8
         beQdPugQNwdALzCzcHZf7LT4Udv+XK2CWnTrrBP62qQxmU1JKXyIzQCWz25CetkohMO9
         R+X1Cj0JWAiY/iI49wmrlOh/4cPHbARdNC9cwVWYo0esQHWzOEnCG9ofnWm9rIF8IDRy
         N66dSs4ChT84tdyqFoM5q+zpjzxDkEtgqa0IZanpsOwCy7SJrAWs7YXC35G+UGRwYSjS
         RWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5wQ9BNbiYtLVNHNYdrbJ4Nx/HItvdJXlh3jzLGMQ1k=;
        b=DOjZmsPLiGcXlqlJhbJcbf7NOl9qz3SFFq9E2RHgYl6tTvhBB1RNPRqRsaXR+p6c1g
         0dXOZYYAnU233RLOKS3DQ28sAkbT43qy3KxbI5LQiDY/NjkXJ9XwdiNSF98N9Nago3TW
         kVJM5bGsISqx67ehTynj3OLKDwyEPnRxMv77mfYoStIE1ppBmuzLhpYv8jPSC6MWUrl6
         OYcGNqDzyeS6wEmc6OzJLERkxa7RzzNKFpdsTBM3hOuSXFA1AZPIJ8zY7WA4D0RTW8OV
         rRoPD8KaIeP69gUOneZHMLd/OiaHQaEEI0TKP4UL8OEGsImkAb3ktHDYaRQEbaBGJNv1
         oXEA==
X-Gm-Message-State: APjAAAW1+D8kgjFrMHuatuFpfsfbwsoaNiS3bNO1/6L7RV6F5UvhUJAH
        tZ4hBXLyAZU/mr/yNQBis3G+Sg==
X-Google-Smtp-Source: APXvYqw7DAWRfZfmaaVnzu0YBGf3s6lu2TNz+c6gskQU5jMGvKJsIiwbu2yeEKNn30D50jbpOQ3Iyg==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr27390025pfh.187.1554196889877;
        Tue, 02 Apr 2019 02:21:29 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id z6sm22723832pgo.31.2019.04.02.02.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 02:21:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 01/11] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318121100.28132-1-brgl@bgdev.pl>
 <20190318121100.28132-2-brgl@bgdev.pl>
Message-ID: <63e3371d-e1d6-101f-0768-4a5d65c4bff6@linaro.org>
Date:   Tue, 2 Apr 2019 11:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
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
> 
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
> +	help
> +	  Enables the support for the TI DaVinci timer driver.
> +

Please make it a silence option only visible with COMPILE_TEST or
EXPERT, examples here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/Kconfig#n45

or second format:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/Kconfig#n459

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
> +
> +struct davinci_timer_data;
> +
> +typedef void (*davinci_timer_set_period_func)(struct davinci_timer_data *,
> +					      unsigned int period);
> +
> +/**
> + * struct davinci_timer_regs - timer-specific register offsets
> + *
> + * @tim_off: timer counter register
> + * @prd_off: timer period register
> + * @enamode_shift: left bit-shift of the enable register associated
> + *                 with this timer in the TCR register
> + */
> +struct davinci_timer_regs {
> +	unsigned int tim_off;
> +	unsigned int prd_off;
> +	unsigned int enamode_shift;
> +};
> +
> +struct davinci_timer_data {
> +	void __iomem *base;
> +	const struct davinci_timer_regs *regs;
> +	unsigned int mode;
> +	davinci_timer_set_period_func set_period;
> +	unsigned int cmp_off;
> +};
> +
> +struct davinci_timer_clockevent {
> +	struct clock_event_device dev;
> +	unsigned int tick_rate;
> +	struct davinci_timer_data timer;
> +};

The timer-of API provides the functions and the common structures for
the usual operations. Please use them instead of redefining your own
structures.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

