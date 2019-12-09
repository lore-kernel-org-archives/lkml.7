Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14200C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669D2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPBtLytE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLIREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:04:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLIREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:04:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so90501wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5KbRRQYo8Wz6D8lPuA2WupVsNR33GV1HjXa7cdEhmB8=;
        b=GPBtLytEPZPl5uX37kYYaLj1kxCMr0+Ah9xLG3sMgpvofNNP4ec3dgMIkKWdMiHimn
         /nCOZylJ+br7JfVRrt9rCtqGSYfN8bKmoIioXitYHKwvFaoJZBOrtF0K7Wq0dgZfGIFL
         afA2KCMdKrZMo5XYeekHfYNGLiyBS66HkugHjkBSfY4jwxcenRPRaTqoJRif4CXqCsuW
         EOGBmLp1aW1EeuerLVBoYaVgXjbBRTr96c0x4Rjjfidt1cbdPCQvcbdnkJ4Te67qvkbU
         xSGmd7GuSqk8jGxRwjwpHyGrDlq0/v+IcLsweaHgrcnW+ohyY2O1JoJMz+DKEQ87JGYh
         NPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5KbRRQYo8Wz6D8lPuA2WupVsNR33GV1HjXa7cdEhmB8=;
        b=RJAe+Hjh4ZD+iW5K/KX7uLOkD+Ibtv2on8+2cgSC8mXETPoIGN2tTsDoIXqAiCTTx+
         GOihQN47MDdmVsmi/UtYAIh6CFw6dVw2mnwZeCYXfrsuZwxiv5VpyRebnqFQmAR851+1
         xRYVsDIA5wj1hHSblKNOCLqc7p+46336xsRfAM6YFHeoQHSM7PSKsH+pAHMHYT1VZygi
         aM0Y0s7RlQYBi33YdmMVcvmUh+mkEmzz02PB16yr/Bj8ipqabvez50hn3HGaf16wKfrN
         XRIh+duYWt/3j3JDL8oZDjPkQIgmLC+31S8glzl9ZYnaXh2ZY1pHJcsQVTD5ZM8bnU7u
         J43w==
X-Gm-Message-State: APjAAAU351O2PnfktT/5z3K5qumbSm/fKYsEkgwhj3/BjnvXL0EWRegk
        We4WZqpi1Z98XrPmH+MxA3A3+a4P79k=
X-Google-Smtp-Source: APXvYqywi6HFbl42PNcw0xKj1+BHvjh93SpPK8a68ik2vCIiu+bhzcb8OEoV4aeZCd63WAhU/ynTJA==
X-Received: by 2002:a05:600c:2509:: with SMTP id d9mr34488wma.148.1575911058362;
        Mon, 09 Dec 2019 09:04:18 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id d6sm287wmb.6.2019.12.09.09.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:04:17 -0800 (PST)
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        tglx@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1575470549-702-1-git-send-email-claudiu.beznea@microchip.com>
 <1575470549-702-3-git-send-email-claudiu.beznea@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <19796bfc-144c-8129-2e06-07d882e5e9f5@linaro.org>
Date:   Mon, 9 Dec 2019 18:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575470549-702-3-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 15:42, Claudiu Beznea wrote:
> Add driver for Microchip PIT64B timer. Timer could be used in continuous
> mode or oneshot mode. The hardware has 2x32 bit registers for period
> emulating a 64 bit timer. The LSB_PR and MSB_PR registers are used to
> set the period value (compare value). TLSB and TMSB keeps the current
> value of the counter. After a compare the TLSB and TMSB register resets.
> The driver uses PIT64B timer for clocksource or clockevent. First
> requested timer would be registered as clockevent, second one would be
> registered as clocksource. Individual PIT64B hardware resources were used
> for clocksource and clockevent to be able to support high resolution
> timers with this hardware implementation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Changes in v3:
> - rework data structures:
> 	- timer related data structure is called now mchp_pit64b_timer embedding
> 	  base iomem, clocks, interrupt, prescaler value
> 	- introduced struct mchp_pit64b_clksrc and struct mchp_pit64b_clkevt
> 	  instead of mchp_pit64b_clksrc_data and mchp_pit64b_clkevt_data
> 	- use container_of() to retrieve mchp_pit64b_timer objects on
> 	  clocksource/clockevent specific APIs
> 	- document data structures
> - use raw_local_irq_save()/raw_local_irq_restore() when reading
>   MCHP_PIT64B_TLSBR and MCHP_PIT64B_TMSBR in mchp_pit64b_get_period()
> - get rid of mchp_pit64b_read(), mchp_pit64b_write() and use instead
>   readl_relaxed(), writel_relaxed()
> - get rid of mchp_pit64b_set_period() and inlined its instructions in
>   mchp_pit64b_reset()
> - mchp_pit64b_reset() gets now as arguments an object of type
>   struct mchp_pit64b_timer, cycles to program and mode
> - remove static struct clocksource mchp_pit64b_clksrc and
>   static struct clock_event_device mchp_pit64b_clkevt and instead allocate
>   and fill them in mchp_pit64b_dt_init_clksrc() and
>   mchp_pit64b_dt_init_clkevt()
> - call mchp_pit64b_reset() in mchp_pit64b_clkevt_set_next_event() and
>   program clockevent timer with SMOD=0; if SMOD=1 the timer's period could
>   be reprogrammed also if writting TLSB, TMSB if it is running. In cases
>   were its period expired START bit still has to be set in control register.
>   In case the programming sequence is like in v2, with SMOD=1:
> 	- program MSB_PR
> 	- program LSB_PR
> 	- program START bit in control register
>   for short programmed periods we may start the timer twice with this
>   programming sequence, 1st time after LSB_PR is updated (and due to SMOD=1),
>   2nd time after programming START bit in control register and in case
>   programmed period already expire
> - simplify mchp_pit64b_interrupt() by just reading ISR register, to clear the
>   received interrupt, and just call irq_data->clkevt->event_handler(irq_data->clkevt);
> - in mchp_pit64b_pres_compute() chose the bigest prescaler in case a good
>   one not found
> - document mchp_pit64b_pres_prepare() and simplified it a bit
> - enforce gclk as mandatory
> - introduce mchp_pit64b_timer_init() and mchp_pit64b_timer_cleanup()
> - keep the clocksource timer base address in a mchp_pit64b_cs_base variable so
>   that it could be used by mchp_pit64b_sched_read_clk()
> - rework mchp_pit64b_dt_init() and return -EINVAL in case it was called
>   more than two times: one for initialization of clockevent, one for
>   initialization of clocksource
> - introduce MCHP_PIT64B_MR_ONE_SHOT define
> - move the new lines introduced in Makefile and Kconfig at the end of files
> - collect Rob's Reviewed-by tag on patch 1/2
> - review the commit message of patch 2/2
> 
> Changes in v2:
> - remove clock-frequency DT binding and hardcoded it in the driver
> - initialize best_pres variable in mchp_pit64b_pres_prepare()
> - remove MCHP_PIT64B_DEF_FREQ 
> - get rid of patches 3-5 from v1 [1] since there is no entry in MAINTAINERS file
>   for this entry. It was removed in
>   commit 44015a8181a5 ("MAINTAINERS: at91: remove the TC entry")
> 
> [1] https://lore.kernel.org/lkml/1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com/
> 
>  drivers/clocksource/Kconfig                  |   6 +
>  drivers/clocksource/Makefile                 |   1 +
>  drivers/clocksource/timer-microchip-pit64b.c | 501 +++++++++++++++++++++++++++
>  3 files changed, 508 insertions(+)
>  create mode 100644 drivers/clocksource/timer-microchip-pit64b.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5fdd76cb1768..eaadbc42ce4a 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -697,4 +697,10 @@ config INGENIC_TIMER
>  	help
>  	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>  
> +config MICROCHIP_PIT64B
> +	bool "Microchip PIT64B support"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  This option enables Microchip PIT64B timer.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 4dfe4225ece7..713686faa549 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
> +obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
> diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
> new file mode 100644
> index 000000000000..293e1ab39729
> --- /dev/null
> +++ b/drivers/clocksource/timer-microchip-pit64b.c
> @@ -0,0 +1,501 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 64-bit Periodic Interval Timer driver
> + *
> + * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +
> +#define MCHP_PIT64B_CR			0x00	/* Control Register */
> +#define MCHP_PIT64B_CR_START		BIT(0)
> +#define MCHP_PIT64B_CR_SWRST		BIT(8)
> +
> +#define MCHP_PIT64B_MR			0x04	/* Mode Register */
> +#define MCHP_PIT64B_MR_CONT		BIT(0)
> +#define MCHP_PIT64B_MR_ONE_SHOT		(0)
> +#define MCHP_PIT64B_MR_SGCLK		BIT(3)
> +#define MCHP_PIT64B_MR_PRES		GENMASK(11, 8)
> +
> +#define MCHP_PIT64B_LSB_PR		0x08	/* LSB Period Register */
> +
> +#define MCHP_PIT64B_MSB_PR		0x0C	/* MSB Period Register */
> +
> +#define MCHP_PIT64B_IER			0x10	/* Interrupt Enable Register */
> +#define MCHP_PIT64B_IER_PERIOD		BIT(0)
> +
> +#define MCHP_PIT64B_ISR			0x1C	/* Interrupt Status Register */
> +#define MCHP_PIT64B_ISR_PERIOD		BIT(0)
> +
> +#define MCHP_PIT64B_TLSBR		0x20	/* Timer LSB Register */
> +
> +#define MCHP_PIT64B_TMSBR		0x24	/* Timer MSB Register */
> +
> +#define MCHP_PIT64B_PRES_MAX		0x10
> +#define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
> +#define MCHP_PIT64B_PRESCALER(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
> +#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
> +#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
> +
> +#define MCHP_PIT64B_NAME		"pit64b"
> +
> +/**
> + * struct mchp_pit64b_timer - PIT64B timer data structure
> + * @base: base address of PIT64B hardware block
> + * @pclk: PIT64B's peripheral clock
> + * @gclk: PIT64B's generic clock
> + * @cycles: timer's number of cycles
> + * @irq: PIT64B's Linux IRQ number
> + * @pres: prescaler value for the chosen clock
> + */
> +struct mchp_pit64b_timer {
> +	void __iomem	*base;
> +	struct clk	*pclk;
> +	struct clk	*gclk;
> +	u64		cycles;
> +	u32		irq;

irq is not needed, a local variable is enough to setup the timer.


> +	u8		pres;
> +};

The field pres and cycles are needed to reset the clockevent, is it
really mandatory to set them again and again from the value stored?

> +
> +/**
> + * mchp_pit64b_clksrc - PIT64B clocksource data structure
> + * @timer: PIT64B timer
> + * @clksrc: clocksource
> + */
> +struct mchp_pit64b_clksrc {
> +	struct mchp_pit64b_timer	timer;
> +	struct clocksource		clksrc;
> +};

clksrc would be not needed here if you use the function:
	clocksource_mmio_init()

> +#define clksrc_to_mchp_pit64b_timer(x) \
> +	(&(container_of(x, struct mchp_pit64b_clksrc, clksrc))->timer)

No dereference should happen here. We should end up with a single structure:

struct mchp_pit64b_timer {
	void *__iomem			*base;
	struct clk			*pclk;
	struct clk			*gclk;
	struct clock_event_device	clkevt
};

> + * mchp_pit64b_clkevt - PIT64B clockevent data structure
> + * @timer: PIT64B timer
> + * @clkevt: clockevent
> + */
> +struct mchp_pit64b_clkevt {
> +	struct mchp_pit64b_timer	timer;
> +	struct clock_event_device	clkevt;
> +};
> +
> +#define clkevt_to_mchp_pit64b_timer(x) \
> +	(&(container_of(x, struct mchp_pit64b_clkevt, clkevt))->timer)

Same comment.

> +> +static void __iomem *mchp_pit64b_cs_base;
>
> +static inline u64 mchp_pit64b_get_period(void __iomem *base)

The 'get_period' name is confusing. Can you replace that by 'get_counter'?

Also, the 'high' part change may be checked, like:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/drivers/clocksource/timer-imx-sysctr.c?h=bleeding-edge#n51

You should consider if using only the first 32bits wouldn't be enough
(max duration before wrapping up). Using the 64bits here has a
significant impact on the performances. Up to you to decide.

> +{
> +	unsigned long	flags;
> +	u32		low, high;
> +
> +	raw_local_irq_save(flags);
> +	/*
> +	 * When using a 64 bit period TLSB must be read first, followed by the
> +	 * read of TMSB. This sequence generates an atomic read of the 64 bit
> +	 * timer value whatever the lapse of time between the accesses.
> +	 */
> +	low = readl_relaxed(base + MCHP_PIT64B_TLSBR);
> +	high = readl_relaxed(base + MCHP_PIT64B_TMSBR);

Add line for clarity.

> +	raw_local_irq_restore(flags);
> +
> +	return (((u64)high << 32) | low);
> +}
> +
> +static inline void mchp_pit64b_reset(struct mchp_pit64b_timer *timer,
> +				     u64 cycles, u32 mode)
> +{
> +	u32 low, high;
> +
> +	low = cycles & MCHP_PIT64B_LSBMASK;
> +	high = cycles >> 32;
> +
> +	mode |= MCHP_PIT64B_PRESCALER(timer->pres);
> +	if (timer->gclk)
> +		mode |= MCHP_PIT64B_MR_SGCLK;

Why not pre-compute 'mode', make it a field of the timer struct and
change the value at init time and in set_periodic and set_oneshot?

> +	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
> +	writel_relaxed(mode, timer->base + MCHP_PIT64B_MR);
> +	writel_relaxed(high, timer->base + MCHP_PIT64B_MSB_PR);
> +	writel_relaxed(low, timer->base + MCHP_PIT64B_LSB_PR);
> +	if (timer->irq) {

Clocksource reset is only needed at init time, it can be done separetely
and this function will be called for the clockevent only, hence the
check won't be necessary.

> +		writel_relaxed(MCHP_PIT64B_IER_PERIOD,
> +			       timer->base + MCHP_PIT64B_IER);
> +	}
> +	writel_relaxed(MCHP_PIT64B_CR_START, timer->base + MCHP_PIT64B_CR);
> +}
> +
> +static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
> +{
> +	struct mchp_pit64b_timer *timer = clksrc_to_mchp_pit64b_timer(cs);
> +
> +	return mchp_pit64b_get_period(timer->base);
> +}
> +
> +static u64 mchp_pit64b_sched_read_clk(void)
> +{
> +	return mchp_pit64b_get_period(mchp_pit64b_cs_base);
> +}
> +
> +static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +
> +	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
> +
> +	return 0;
> +}
> +
> +static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +
> +	mchp_pit64b_reset(timer, timer->cycles, MCHP_PIT64B_MR_CONT);
> +
> +	return 0;
> +}
> +
> +static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +
> +	mchp_pit64b_reset(timer, timer->cycles, MCHP_PIT64B_MR_ONE_SHOT);
> +
> +	return 0;
> +}
> +
> +static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
> +					     struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +
> +	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT);
> +
> +	return 0;
> +}
> +
> +static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +
> +	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
> +	if (timer->gclk)
> +		clk_disable_unprepare(timer->gclk);
> +	clk_disable_unprepare(timer->pclk);
> +}
> +
> +static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
> +{
> +	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
> +	u32 mode = MCHP_PIT64B_MR_ONE_SHOT;
> +
> +	clk_prepare_enable(timer->pclk);
> +	if (timer->gclk)
> +		clk_prepare_enable(timer->gclk);
> +
> +	if (clockevent_state_periodic(cedev))
> +		mode = MCHP_PIT64B_MR_CONT;
> +
> +	mchp_pit64b_reset(timer, timer->cycles, mode);
> +}
> +
> +static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
> +{
> +	struct mchp_pit64b_clkevt *irq_data = dev_id;
> +
> +	/* Need to clear the interrupt. */
> +	readl_relaxed(irq_data->timer.base + MCHP_PIT64B_ISR);
> +
> +	irq_data->clkevt.event_handler(&irq_data->clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
> +					    u32 max_rate)
> +{
> +	u32 tmp;
> +
> +	for (*pres = 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
> +		tmp = clk_rate / (*pres + 1);
> +		if (tmp <= max_rate)
> +			break;
> +	}
> +
> +	/* Use the bigest prescaler if we didn't match one. */
> +	if (*pres == MCHP_PIT64B_PRES_MAX)
> +		*pres = MCHP_PIT64B_PRES_MAX - 1;
> +}
> +
> +/**
> + * mchp_pit64b_pres_prepare - prepare PIT64B clocks and internal prescaler
> + *
> + * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
> + * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
> + * could be changed via clock APIs. The chosen clock (pclk or gclk) could be
> + * divided by the internal PIT64B's divider.
> + *
> + * This function, first tries to use GCLK by requesting the desired rate from
> + * PMC and then using the internal PIT64B prescaller, if any, to reach the
> + * requested rate. If PCLK/GCLK < 3 (condition requested by PIT64B hardware)
> + * then the function falls back on using PCLK as clock source for PIT64B timer
> + * choosing the highest prescaler in case it doesn't locate one to match the
> + * requested frequency.
> + *
> + * Below is presented the PIT64B block in relation with PMC:
> + *
> + *                                PIT64B
> + *  PMC             +------------------------------------+
> + * +----+           |   +-----+                          |
> + * |    |-->gclk -->|-->|     |    +---------+  +-----+  |
> + * |    |           |   | MUX |--->| Divider |->|timer|  |
> + * |    |-->pclk -->|-->|     |    +---------+  +-----+  |
> + * +----+           |   +-----+                          |
> + *                  |      ^                             |
> + *                  |     sel                            |
> + *                  +------------------------------------+
> + *
> + * Where:
> + *	- gclk rate <= pclk rate/3
> + *	- gclk rate could be requested from PMC
> + *	- pclk rate is fixed (cannot be requested from PMC)
> + */
> +static int __init mchp_pit64b_pres_prepare(struct mchp_pit64b_timer *timer,
> +					   unsigned long max_rate)
> +{
> +	unsigned long pclk_rate, diff = 0, best_diff = ULONG_MAX;
> +	long gclk_round = 0;
> +	u32 pres, best_pres = 0;
> +
> +	pclk_rate = clk_get_rate(timer->pclk);
> +	if (!pclk_rate)
> +		return -EINVAL;
> +
> +	/* Try using GCLK. */
> +	gclk_round = clk_round_rate(timer->gclk, max_rate);
> +	if (gclk_round < 0)
> +		goto pclk;
> +
> +	if (pclk_rate / gclk_round < 3)
> +		goto pclk;
> +
> +	mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
> +	best_diff = abs(gclk_round / (pres + 1) - max_rate);
> +	best_pres = pres;
> +
> +	if (!best_diff)
> +		goto done;
> +
> +pclk:
> +	/* Check if requested rate could be obtained using PCLK. */
> +	mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
> +	diff = abs(pclk_rate / (pres + 1) - max_rate);
> +
> +	if (best_diff > diff) {
> +		/* Use PCLK. */
> +		timer->gclk = NULL;
> +		best_pres = pres;
> +	} else {
> +		/* Use GCLK. */
> +		clk_set_rate(timer->gclk, gclk_round);
> +	}
> +
> +done:
> +	timer->pres = best_pres;
> +	pr_info("PIT64B: using clk=%s with prescaler %u, freq=%lu [Hz]\n",
> +		timer->gclk ? "gclk" : "pclk", timer->pres,
> +		timer->gclk ? gclk_round / (timer->pres + 1)
> +			    : pclk_rate / (timer->pres + 1));
> +
> +	return 0;
> +}
> +
> +static int __init mchp_pit64b_timer_init(struct device_node *node,
> +					 struct mchp_pit64b_timer *timer,
> +					 u32 freq, bool is_clkevt)
> +{
> +	int ret;
> +
> +	timer->pclk = of_clk_get_by_name(node, "pclk");
> +	if (IS_ERR(timer->pclk))
> +		return PTR_ERR(timer->pclk);
> +
> +	timer->gclk = of_clk_get_by_name(node, "gclk");
> +	if (IS_ERR(timer->gclk))
> +		return PTR_ERR(timer->gclk);
> +
> +	timer->base = of_iomap(node, 0);
> +	if (!timer->base)
> +		return -ENXIO;
> +
> +	if (is_clkevt) {
> +		timer->irq = irq_of_parse_and_map(node, 0);
> +		if (!timer->irq) {
> +			ret = -ENODEV;
> +			goto io_unmap;
> +		}
> +	}
> +
> +	ret = mchp_pit64b_pres_prepare(timer, freq);
> +	if (ret)
> +		goto irq_unmap;
> +
> +	ret = clk_prepare_enable(timer->pclk);
> +	if (ret)
> +		goto irq_unmap;
> +
> +	if (timer->gclk) {
> +		ret = clk_prepare_enable(timer->gclk);
> +		if (ret)
> +			goto pclk_unprepare;
> +	}
> +
> +	return 0;
> +
> +pclk_unprepare:
> +	clk_disable_unprepare(timer->pclk);
> +irq_unmap:
> +	irq_dispose_mapping(timer->irq);
> +io_unmap:
> +	iounmap(timer->base);
> +
> +	return ret;
> +}
> +
> +static void __init mchp_pit64b_timer_cleanup(struct mchp_pit64b_timer *timer)
> +{
> +	if (timer->gclk)
> +		clk_disable_unprepare(timer->gclk);
> +	clk_disable_unprepare(timer->pclk);
> +	irq_dispose_mapping(timer->irq);
> +	iounmap(timer->base);
> +}
> +
> +static int __init mchp_pit64b_dt_init_clksrc(struct device_node *node)
> +{
> +	struct mchp_pit64b_clksrc *cs;
> +	unsigned long clk_rate;
> +	int ret;
> +
> +	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
> +	if (!cs)
> +		return -ENOMEM;
> +
> +	ret = mchp_pit64b_timer_init(node, &cs->timer, MCHP_PIT64B_DEF_CS_FREQ,
> +				     false);
> +	if (ret)
> +		goto free;
> +
> +	if (cs->timer.gclk)
> +		clk_rate = clk_get_rate(cs->timer.gclk);
> +	else
> +		clk_rate = clk_get_rate(cs->timer.pclk);
> +
> +	clk_rate = clk_rate / (cs->timer.pres + 1);
> +	cs->timer.cycles = ULLONG_MAX;
> +	mchp_pit64b_reset(&cs->timer, cs->timer.cycles, MCHP_PIT64B_MR_CONT);
> +
> +	cs->clksrc.name = MCHP_PIT64B_NAME;
> +	cs->clksrc.mask = CLOCKSOURCE_MASK(64);
> +	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +	cs->clksrc.rating = 210;
> +	cs->clksrc.read = mchp_pit64b_clksrc_read;
> +
> +	ret = clocksource_register_hz(&cs->clksrc, clk_rate);
> +	if (ret) {
> +		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
> +		goto timer_cleanup;
> +	}
> +
> +	mchp_pit64b_cs_base = cs->timer.base;
> +	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
> +
> +	return 0;
> +
> +timer_cleanup:
> +	mchp_pit64b_timer_cleanup(&cs->timer);
> +free:
> +	kfree(cs);
> +	return ret;
> +}
> +
> +static int __init mchp_pit64b_dt_init_clkevt(struct device_node *node)
> +{
> +	struct mchp_pit64b_clkevt *ce;
> +	unsigned long clk_rate;
> +	int ret;
> +
> +	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
> +	if (!ce)
> +		return -ENOMEM;
> +
> +	ret = mchp_pit64b_timer_init(node, &ce->timer, MCHP_PIT64B_DEF_CE_FREQ,
> +				     true);
> +	if (ret)
> +		goto free;
> +
> +	if (ce->timer.gclk)
> +		clk_rate = clk_get_rate(ce->timer.gclk);
> +	else
> +		clk_rate = clk_get_rate(ce->timer.pclk);
> +
> +	clk_rate = clk_rate / (ce->timer.pres + 1);
> +	ce->timer.cycles = DIV_ROUND_CLOSEST(clk_rate, HZ);
> +
> +	ce->clkevt.name = MCHP_PIT64B_NAME;
> +	ce->clkevt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC;
> +	ce->clkevt.rating = 150;
> +	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
> +	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
> +	ce->clkevt.set_state_oneshot = mchp_pit64b_clkevt_set_oneshot;
> +	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
> +	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
> +	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
> +	ce->clkevt.cpumask = cpumask_of(0);
> +	ce->clkevt.irq = ce->timer.irq;
> +
> +	ret = request_irq(ce->timer.irq, mchp_pit64b_interrupt, IRQF_TIMER,
> +			  "pit64b_tick", ce);
> +	if (ret) {
> +		pr_debug("clkevt: Failed to setup PIT64B IRQ\n");
> +		goto timer_cleanup;
> +	}
> +
> +	clockevents_config_and_register(&ce->clkevt, clk_rate, 1, ULONG_MAX);
> +
> +	return 0;
> +
> +timer_cleanup:
> +	mchp_pit64b_timer_cleanup(&ce->timer);
> +free:
> +	kfree(ce);
> +	return ret;
> +}
> +
> +static int __init mchp_pit64b_dt_init(struct device_node *node)
> +{
> +	static int inits;
> +
> +	switch (inits++) {
> +	case 0:
> +		/* 1st request, register clockevent. */
> +		return mchp_pit64b_dt_init_clkevt(node);
> +	case 1:
> +		/* 2nd request, register clocksource. */
> +		return mchp_pit64b_dt_init_clksrc(node);
> +	}
> +
> +	/* The rest, don't care. */
> +	return -EINVAL;
> +}
> +
> +TIMER_OF_DECLARE(mchp_pit64b, "microchip,sam9x60-pit64b", mchp_pit64b_dt_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

