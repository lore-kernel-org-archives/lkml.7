Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D56721473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiGxLKNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDHMfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:35:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55476 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfDHMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:35:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so14133268wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M7zRJg+PBLKE0GeNK/99x3gHx/GcYNdK/4jD8kY5bxg=;
        b=YiGxLKNVEB8xE42zmO6PiHK7d/Wc3U2ttwqnDwmQ7x5T9V+3prvu25hi44aHxPvx5R
         NxXHrFE+ERUU+hrRZ2oMAvaKeXZqphG9fOkDtXEva+l1E80EhIWQBqdm0tgz/P77rP9q
         r2jBDK/3RcO96wUb5KtXSpE7erkYcZndFlNwaUIIgafzgfXLkWthpyu53fH94kiJylti
         gK3Om7rj4Fn7iKcsXnmw9AeAEgiMXGKS00qvKaTDJ7xlGeMpUXom/AhGtpETPnl8UqHl
         pn171ORUertyr0WjsbZHrMPsB1euZtrWiltOFzolOvGNdKosPcuio6CY/Trm7/hrHH7Y
         QhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7zRJg+PBLKE0GeNK/99x3gHx/GcYNdK/4jD8kY5bxg=;
        b=BPtINbY/U1KKuL3b2w5ijGcQ62LzdePECUudSZvT4XN14iiL2dggcRz4LyO1YGB5f7
         C2/Aj0bl3C6cO9wQLabQsDQfyvcP3O3BRIMu5uydMe7UA9kHksBosiBRlgLMWRbhi+NI
         aNxW6zRLQdmqrds1osjWKztrB1iGGiCJLdlirhc5rMo3t+RZ1eL4DlwoIKzGGGAoTnvX
         2qvVgTiOUhY72wMCZsbLqUHUq8IiYBKPvsif0EHW0R0U9faaMRWxSc1M/Z0zkiA92Ab3
         URXMPtaW4Mx6i/tyjMrOK63gTS6kpitMtXvPfq2FwfCUCRpjQMBHUeSi5hjFDT30Np+q
         AiTg==
X-Gm-Message-State: APjAAAVEThmvNmamHsf1HYDy5y+qlUHmZjXw1gT5SNL7MiaP9c0l0gsX
        lHhLWpnu7Eq8ND5NQkcEKq5mZRZ+FBg=
X-Google-Smtp-Source: APXvYqzcgje8W5zEXsNQL+Mb5fAgyCQ6+DULZlQUvLHw6z3nIoEO5OsLBXQ10sR8wMNDuziYZE8ANg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr16549539wma.53.1554726907546;
        Mon, 08 Apr 2019 05:35:07 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v6sm34760134wrt.56.2019.04.08.05.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:35:06 -0700 (PDT)
Subject: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
 <a738fce5-1108-34d7-d255-dfcb86f51c56@linaro.org>
 <20190408121141.GK7480@piout.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ce42bb5f-c77e-e882-0579-2bbf95d7b1a5@linaro.org>
Date:   Mon, 8 Apr 2019 14:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408121141.GK7480@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 14:11, Alexandre Belloni wrote:
> Hi Daniel,
> 
> On 08/04/2019 10:43:26+0200, Daniel Lezcano wrote:
>> Hi Claudiu,
>>
>> On 14/03/2019 17:26, Claudiu.Beznea@microchip.com wrote:
>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>
>>> Add driver for Microchip PIT64B timer. Timer could be used in continuous
>>> mode or oneshot mode. The hardware has 2x32 bit registers for period
>>> emulating a 64 bit timer. The LSB_PR and MSB_PR registers are used to set
>>> the period value (compare value). TLSB and TMSB keeps the current value
>>> of the counter. After a compare the TLSB and TMSB register resets. Apart
>>> from this the hardware has SMOD bit in mode register that allow to
>>> reconfigure the timer without reset and start commands (start command
>>> while timer is active is ignored).
>>> The driver uses PIT64B timer as clocksource or clockevent. First requested
>>> timer would be registered as clockevent, second one would be registered as
>>> clocksource.
>>
>> Even if that was done this way before, assuming the DT describes the
>> clockevent at the first place and then the clocksource, it is a fragile
>> approach.
>>
>> What about using one of these approach?
>>
>> eg.
>>
>> arch/arm/boot/dts/at91sam9261ek.dts
>>
>> chosen {
>> 	bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs rw";
>>                 stdout-path = "serial0:115200n8";
>>
>> 	clocksource {
>> 		timer = <&timer0>;
>> 	};
>>
>>         clockevent {
>> 		timer = <&timer1>;
>>         };
>> };
>>
> 
> I suggested and implemented exactly that back in 2017 and it was shot
> down by both Rob and Mark:
> 
> https://lore.kernel.org/lkml/20171213185313.20017-1-alexandre.belloni@free-electrons.com/
> 
> At the time, you didn't do *anything* to get it accepted, you stayed
> silent.

What about commit 51f0aeb2d21f1 ?


Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Wed Jun 8 17:08:57 2016 +0200

    ARM: dts: at91: at91sam9261ek: use TCB0 as timers

    Use tcb0 for timers as selected in at91_dt_defconfig.

    Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts
b/arch/arm/boot/dts/at91sam9261ek.dts
index 9733db3f739b..a29fc0494076 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -15,6 +15,14 @@
        chosen {
                bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs rw";
                stdout-path = "serial0:115200n8";
+
+               clocksource {
+                       timer = <&timer0>;
+               };
+
+               clockevent {
+                       timer = <&timer1>;
+               };
        };

        memory {
@@ -125,6 +133,18 @@
                };

                apb {
+                       tcb0: timer@fffa0000 {
+                               timer0: timer@0 {
+                                       compatible = "atmel,tcb-timer";
+                                       reg = <0>, <1>;
+                               };
+
+                               timer1: timer@2 {
+                                       compatible = "atmel,tcb-timer";
+                                       reg = <2>;
+                               };
+                       };
+
                        usb1: gadget@fffa4000 {
                                atmel,vbus-gpio = <&pioB 29
GPIO_ACTIVE_HIGH>;
                                status = "okay";



>  I can respin the series but then I see two options:
>  - either you back up the series and really push for it
>  - or you simply take this driver as it is. There is nothing in it that
>    couldn't be reworked later once you reached a conclusion with the DT
> maintainers.
> 
>> or
>>
>> arch/arm/boot/dts/integratorap.dts
>>
>> aliases {
>> 	arm,timer-primary = &timer2;
>> 	arm,timer-secondary = &timer1;
>> };
>>
>> So we can have control of what is the clocksource or the clockevent.
>> That is particulary handy in case of multiple channels.
>>
>> Not sure if we can replace the 'arm,timer_primary' to 'clocksource'.
>>
>> Rob? What is your opinion?
>>
>>> Individual PIT64B hardware resources were used for clocksource
>>> and clockevent to be able to support high resolution timers with this
>>> hardware implementation.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>  drivers/clocksource/Kconfig                  |   6 +
>>>  drivers/clocksource/Makefile                 |   1 +
>>>  drivers/clocksource/timer-microchip-pit64b.c | 464 +++++++++++++++++++++++++++
>>>  3 files changed, 471 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-microchip-pit64b.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 5d93e580e5dc..2ad6f881a0bb 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -448,6 +448,12 @@ config OXNAS_RPS_TIMER
>>>  config SYS_SUPPORTS_SH_CMT
>>>          bool
>>>  
>>> +config MICROCHIP_PIT64B
>>> +	bool "Microchip PIT64B support"
>>> +	depends on OF || COMPILE_TEST
>>> +	help
>>> +	  This option enables Microchip PIT64B timer.
>>> +
>>>  config MTK_TIMER
>>>  	bool "Mediatek timer driver" if COMPILE_TEST
>>>  	depends on HAS_IOMEM
>>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>>> index c4a8e9ef932a..c53fa12b9b94 100644
>>> --- a/drivers/clocksource/Makefile
>>> +++ b/drivers/clocksource/Makefile
>>> @@ -35,6 +35,7 @@ obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
>>>  obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
>>>  obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
>>>  obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
>>> +obj-$(CONFIG_MICROCHIP_PIT64B)	+= timer-microchip-pit64b.o
>>>  obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
>>>  obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
>>>  obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
>>> diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
>>> new file mode 100644
>>> index 000000000000..6787aa98ef01
>>> --- /dev/null
>>> +++ b/drivers/clocksource/timer-microchip-pit64b.c
>>> @@ -0,0 +1,464 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// Copyright (C) 2019 Microchip Technology Inc.
>>> +// Copyright (C) 2019 Claudiu Beznea (claudiu.beznea@microchip.com)
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/clockchips.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/sched_clock.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define MCHP_PIT64B_CR		0x00	/* Control Register */
>>> +#define MCHP_PIT64B_CR_START	BIT(0)
>>> +#define MCHP_PIT64B_CR_SWRST	BIT(8)
>>> +
>>> +#define MCHP_PIT64B_MR		0x04	/* Mode Register */
>>> +#define MCHP_PIT64B_MR_CONT	BIT(0)
>>> +#define MCHP_PIT64B_MR_SGCLK	BIT(3)
>>> +#define MCHP_PIT64B_MR_SMOD	BIT(4)
>>> +#define MCHP_PIT64B_MR_PRES	GENMASK(11, 8)
>>> +
>>> +#define MCHP_PIT64B_LSB_PR	0x08	/* LSB Period Register */
>>> +
>>> +#define MCHP_PIT64B_MSB_PR	0x0C	/* MSB Period Register */
>>> +
>>> +#define MCHP_PIT64B_IER		0x10	/* Interrupt Enable Register */
>>> +#define MCHP_PIT64B_IER_PERIOD	BIT(0)
>>> +
>>> +#define MCHP_PIT64B_ISR		0x1C	/* Interrupt Status Register */
>>> +#define MCHP_PIT64B_ISR_PERIOD	BIT(0)
>>> +
>>> +#define MCHP_PIT64B_TLSBR	0x20	/* Timer LSB Register */
>>> +
>>> +#define MCHP_PIT64B_TMSBR	0x24	/* Timer MSB Register */
>>> +
>>> +#define MCHP_PIT64B_PRES_MAX	0x10
>>> +#define MCHP_PIT64B_DEF_FREQ	2500000UL	/* 2.5 MHz */
>>> +#define MCHP_PIT64B_LSBMASK	GENMASK_ULL(31, 0)
>>> +#define MCHP_PIT64B_PRESCALER(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
>>> +
>>> +#define MCHP_PIT64B_NAME	"pit64b"
>>> +
>>> +struct mchp_pit64b_common_data {
>>> +	void __iomem *base;
>>> +	struct clk *pclk;
>>> +	struct clk *gclk;
>>> +	u64 cycles;
>>> +	u8 pres;
>>> +};
>>> +
>>> +struct mchp_pit64b_clksrc_data {
>>> +	struct clocksource *clksrc;
>>> +	struct mchp_pit64b_common_data *cd;
>>> +};
>>> +
>>> +struct mchp_pit64b_clkevt_data {
>>> +	struct clock_event_device *clkevt;
>>> +	struct mchp_pit64b_common_data *cd;
>>> +};
>>> +
>>> +static struct mchp_pit64b_data {
>>> +	struct mchp_pit64b_clksrc_data *csd;
>>> +	struct mchp_pit64b_clkevt_data *ced;
>>> +} data;
>>> +
>>> +static inline u32 mchp_pit64b_read(void __iomem *base, u32 offset)
>>> +{
>>> +	return readl_relaxed(base + offset);
>>> +}
>>> +
>>> +static inline void mchp_pit64b_write(void __iomem *base, u32 offset, u32 val)
>>> +{
>>> +	writel_relaxed(val, base + offset);
>>> +}
>>> +
>>> +static inline u64 mchp_pit64b_get_period(void __iomem *base)
>>> +{
>>> +	u32 lsb, msb;
>>> +
>>> +	/* LSB must be read first to guarantee an atomic read of the 64 bit
>>> +	 * timer.
>>> +	 */
>>> +	lsb = mchp_pit64b_read(base, MCHP_PIT64B_TLSBR);
>>> +	msb = mchp_pit64b_read(base, MCHP_PIT64B_TMSBR);
>>> +
>>> +	return (((u64)msb << 32) | lsb);
>>> +}
>>> +
>>> +static inline void mchp_pit64b_set_period(void __iomem *base, u64 cycles)
>>> +{
>>> +	u32 lsb, msb;
>>> +
>>> +	lsb = cycles & MCHP_PIT64B_LSBMASK;
>>> +	msb = cycles >> 32;
>>> +
>>> +	/* LSB must be write last to guarantee an atomic update of the timer
>>> +	 * even when SMOD=1.
>>> +	 */
>>> +	mchp_pit64b_write(base, MCHP_PIT64B_MSB_PR, msb);
>>> +	mchp_pit64b_write(base, MCHP_PIT64B_LSB_PR, lsb);
>>> +}
>>> +
>>> +static inline void mchp_pit64b_reset(struct mchp_pit64b_common_data *data,
>>> +				     u32 mode, bool irq_ena)
>>> +{
>>> +	mode |= MCHP_PIT64B_PRESCALER(data->pres);
>>> +	if (data->gclk)
>>> +		mode |= MCHP_PIT64B_MR_SGCLK;
>>> +
>>> +	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_SWRST);
>>> +	mchp_pit64b_write(data->base, MCHP_PIT64B_MR, mode);
>>> +	mchp_pit64b_set_period(data->base, data->cycles);
>>> +	if (irq_ena)
>>> +		mchp_pit64b_write(data->base, MCHP_PIT64B_IER,
>>> +				  MCHP_PIT64B_IER_PERIOD);
>>> +	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_START);
>>> +}
>>> +
>>> +static u64 mchp_pit64b_read_clk(struct clocksource *cs)
>>> +{
>>> +	return mchp_pit64b_get_period(data.csd->cd->base);
>>> +}
>>> +
>>> +static u64 mchp_sched_read_clk(void)
>>> +{
>>> +	return mchp_pit64b_get_period(data.csd->cd->base);
>>> +}
>>> +
>>> +static struct clocksource mchp_pit64b_clksrc = {
>>> +	.name = MCHP_PIT64B_NAME,
>>> +	.mask = CLOCKSOURCE_MASK(64),
>>> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
>>> +	.rating = 210,
>>> +	.read = mchp_pit64b_read_clk,
>>> +};
>>> +
>>> +static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
>>> +{
>>> +	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
>>> +			  MCHP_PIT64B_CR_SWRST);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
>>> +{
>>> +	mchp_pit64b_reset(data.ced->cd, MCHP_PIT64B_MR_CONT, true);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
>>> +{
>>> +	mchp_pit64b_reset(data.ced->cd, MCHP_PIT64B_MR_SMOD, true);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
>>> +					     struct clock_event_device *cedev)
>>> +{
>>> +	mchp_pit64b_set_period(data.ced->cd->base, evt);
>>> +	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
>>> +			  MCHP_PIT64B_CR_START);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
>>> +{
>>> +	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
>>> +			  MCHP_PIT64B_CR_SWRST);
>>> +	if (data.ced->cd->gclk)
>>> +		clk_disable_unprepare(data.ced->cd->gclk);
>>> +	clk_disable_unprepare(data.ced->cd->pclk);
>>> +}
>>> +
>>> +static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
>>> +{
>>> +	u32 mode = MCHP_PIT64B_MR_SMOD;
>>> +
>>> +	clk_prepare_enable(data.ced->cd->pclk);
>>> +	if (data.ced->cd->gclk)
>>> +		clk_prepare_enable(data.ced->cd->gclk);
>>> +
>>> +	if (clockevent_state_periodic(data.ced->clkevt))
>>> +		mode = MCHP_PIT64B_MR_CONT;
>>> +
>>> +	mchp_pit64b_reset(data.ced->cd, mode, true);
>>> +}
>>> +
>>> +static struct clock_event_device mchp_pit64b_clkevt = {
>>> +	.name = MCHP_PIT64B_NAME,
>>> +	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
>>> +	.rating = 150,
>>> +	.set_state_shutdown = mchp_pit64b_clkevt_shutdown,
>>> +	.set_state_periodic = mchp_pit64b_clkevt_set_periodic,
>>> +	.set_state_oneshot = mchp_pit64b_clkevt_set_oneshot,
>>> +	.set_next_event = mchp_pit64b_clkevt_set_next_event,
>>> +	.suspend = mchp_pit64b_clkevt_suspend,
>>> +	.resume = mchp_pit64b_clkevt_resume,
>>> +};
>>> +
>>> +static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
>>> +{
>>> +	struct mchp_pit64b_clkevt_data *irq_data = dev_id;
>>> +
>>> +	if (data.ced != irq_data)
>>> +		return IRQ_NONE;
>>> +
>>> +	if (mchp_pit64b_read(irq_data->cd->base, MCHP_PIT64B_ISR) &
>>> +	    MCHP_PIT64B_ISR_PERIOD) {
>>> +		irq_data->clkevt->event_handler(irq_data->clkevt);
>>> +		return IRQ_HANDLED;
>>> +	}
>>> +
>>> +	return IRQ_NONE;
>>> +}
>>> +
>>> +static int __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
>>> +					   u32 max_rate)
>>> +{
>>> +	u32 tmp;
>>> +
>>> +	for (*pres = 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
>>> +		tmp = clk_rate / (*pres + 1);
>>> +		if (tmp <= max_rate)
>>> +			break;
>>> +	}
>>> +
>>> +	if (*pres == MCHP_PIT64B_PRES_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __init mchp_pit64b_pres_prepare(struct mchp_pit64b_common_data *cd,
>>> +					   unsigned long max_rate)
>>> +{
>>> +	unsigned long pclk_rate, diff = 0, best_diff = ULONG_MAX;
>>> +	long gclk_round = 0;
>>> +	u32 pres, best_pres;
>>> +	int ret = 0;
>>> +
>>> +	pclk_rate = clk_get_rate(cd->pclk);
>>> +	if (!pclk_rate)
>>> +		return -EINVAL;
>>> +
>>> +	if (cd->gclk) {
>>> +		gclk_round = clk_round_rate(cd->gclk, max_rate);
>>> +		if (gclk_round < 0)
>>> +			goto pclk;
>>> +
>>> +		if (pclk_rate / gclk_round < 3)
>>> +			goto pclk;
>>> +
>>> +		ret = mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
>>> +		if (ret)
>>> +			best_diff = abs(gclk_round - max_rate);
>>> +		else
>>> +			best_diff = abs(gclk_round / (pres + 1) - max_rate);
>>> +		best_pres = pres;
>>> +	}
>>> +
>>> +pclk:
>>> +	/* Check if requested rate could be obtained using PCLK. */
>>> +	ret = mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
>>> +	if (ret)
>>> +		diff = abs(pclk_rate - max_rate);
>>> +	else
>>> +		diff = abs(pclk_rate / (pres + 1) - max_rate);
>>> +
>>> +	if (best_diff > diff) {
>>> +		/* Use PCLK. */
>>> +		cd->gclk = NULL;
>>> +		best_pres = pres;
>>> +	} else {
>>> +		clk_set_rate(cd->gclk, gclk_round);
>>> +	}
>>> +
>>> +	cd->pres = best_pres;
>>> +
>>> +	pr_info("PIT64B: using clk=%s with prescaler %u, freq=%lu [Hz]\n",
>>> +		cd->gclk ? "gclk" : "pclk", cd->pres,
>>> +		cd->gclk ? gclk_round / (cd->pres + 1)
>>> +			 : pclk_rate / (cd->pres + 1));
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __init mchp_pit64b_dt_init_clksrc(struct mchp_pit64b_common_data *cd)
>>> +{
>>> +	struct mchp_pit64b_clksrc_data *csd;
>>> +	unsigned long clk_rate;
>>> +	int ret;
>>> +
>>> +	csd = kzalloc(sizeof(*csd), GFP_KERNEL);
>>> +	if (!csd)
>>> +		return -ENOMEM;
>>> +
>>> +	csd->cd = cd;
>>> +
>>> +	if (csd->cd->gclk)
>>> +		clk_rate = clk_get_rate(csd->cd->gclk);
>>> +	else
>>> +		clk_rate = clk_get_rate(csd->cd->pclk);
>>> +
>>> +	clk_rate = clk_rate / (cd->pres + 1);
>>> +	csd->cd->cycles = ULLONG_MAX;
>>> +	mchp_pit64b_reset(csd->cd, MCHP_PIT64B_MR_CONT, false);
>>> +
>>> +	data.csd = csd;
>>> +
>>> +	csd->clksrc = &mchp_pit64b_clksrc;
>>> +
>>> +	ret = clocksource_register_hz(csd->clksrc, clk_rate);
>>> +	if (ret) {
>>> +		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
>>> +		goto free;
>>> +	}
>>> +
>>> +	sched_clock_register(mchp_sched_read_clk, 64, clk_rate);
>>> +
>>> +	return 0;
>>> +
>>> +free:
>>> +	kfree(csd);
>>> +	data.csd = NULL;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int __init mchp_pit64b_dt_init_clkevt(struct mchp_pit64b_common_data *cd,
>>> +					     u32 irq)
>>> +{
>>> +	struct mchp_pit64b_clkevt_data *ced;
>>> +	unsigned long clk_rate;
>>> +	int ret;
>>> +
>>> +	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
>>> +	if (!ced)
>>> +		return -ENOMEM;
>>> +
>>> +	ced->cd = cd;
>>> +
>>> +	if (ced->cd->gclk)
>>> +		clk_rate = clk_get_rate(ced->cd->gclk);
>>> +	else
>>> +		clk_rate = clk_get_rate(ced->cd->pclk);
>>> +
>>> +	clk_rate = clk_rate / (ced->cd->pres + 1);
>>> +	ced->cd->cycles = DIV_ROUND_CLOSEST(clk_rate, HZ);
>>> +
>>> +	ret = request_irq(irq, mchp_pit64b_interrupt, IRQF_TIMER, "pit64b_tick",
>>> +			  ced);
>>> +	if (ret) {
>>> +		pr_debug("clkevt: Failed to setup PIT64B IRQ\n");
>>> +		goto free;
>>> +	}
>>> +
>>> +	data.ced = ced;
>>> +
>>> +	/* Set up and register clockevents. */
>>> +	ced->clkevt = &mchp_pit64b_clkevt;
>>> +	ced->clkevt->cpumask = cpumask_of(0);
>>> +	ced->clkevt->irq = irq;
>>> +	clockevents_config_and_register(ced->clkevt, clk_rate, 1, ULONG_MAX);
>>> +
>>> +	return 0;
>>> +
>>> +free:
>>> +	kfree(ced);
>>> +	data.ced = NULL;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int __init mchp_pit64b_dt_init(struct device_node *node)
>>> +{
>>> +	struct mchp_pit64b_common_data *cd;
>>> +	u32 irq, freq = MCHP_PIT64B_DEF_FREQ;
>>> +	int ret;
>>> +
>>> +	if (data.csd && data.ced)
>>> +		return -EBUSY;
>>> +
>>> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
>>> +	if (!cd)
>>> +		return -ENOMEM;
>>> +
>>> +	cd->pclk = of_clk_get_by_name(node, "pclk");
>>> +	if (IS_ERR(cd->pclk)) {
>>> +		ret = PTR_ERR(cd->pclk);
>>> +		goto free;
>>> +	}
>>> +
>>> +	cd->gclk = of_clk_get_by_name(node, "gclk");
>>> +	if (IS_ERR(cd->gclk))
>>> +		cd->gclk = NULL;
>>> +
>>> +	ret = of_property_read_u32(node, "clock-frequency", &freq);
>>> +	if (ret)
>>> +		pr_debug("PIT64B: failed to read clock frequency. Using default!\n");
>>> +
>>> +	ret = mchp_pit64b_pres_prepare(cd, freq);
>>> +	if (ret)
>>> +		goto free;
>>> +
>>> +	cd->base = of_iomap(node, 0);
>>> +	if (!cd->base) {
>>> +		pr_debug("%s: Could not map PIT64B address!\n",
>>> +			 MCHP_PIT64B_NAME);
>>> +		ret = -ENXIO;
>>> +		goto free;
>>> +	}
>>> +
>>> +	ret = clk_prepare_enable(cd->pclk);
>>> +	if (ret)
>>> +		goto unmap;
>>> +
>>> +	if (cd->gclk) {
>>> +		ret = clk_prepare_enable(cd->gclk);
>>> +		if (ret)
>>> +			goto pclk_unprepare;
>>> +	}
>>> +
>>> +	if (!data.ced) {
>>> +		irq = irq_of_parse_and_map(node, 0);
>>> +		if (!irq) {
>>> +			pr_debug("%s: Failed to get PIT64B clockevent IRQ!\n",
>>> +				 MCHP_PIT64B_NAME);
>>> +			ret = -ENODEV;
>>> +			goto gclk_unprepare;
>>> +		}
>>> +		ret = mchp_pit64b_dt_init_clkevt(cd, irq);
>>> +		if (ret)
>>> +			goto irq_unmap;
>>> +	} else {
>>> +		ret = mchp_pit64b_dt_init_clksrc(cd);
>>> +		if (ret)
>>> +			goto gclk_unprepare;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +irq_unmap:
>>> +	irq_dispose_mapping(irq);
>>> +gclk_unprepare:
>>> +	if (cd->gclk)
>>> +		clk_disable_unprepare(cd->gclk);
>>> +pclk_unprepare:
>>> +	clk_disable_unprepare(cd->pclk);
>>> +unmap:
>>> +	iounmap(cd->base);
>>> +free:
>>> +	kfree(cd);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +TIMER_OF_DECLARE(mchp_pit64b_clksrc, "microchip,sam9x60-pit64b",
>>> +		 mchp_pit64b_dt_init);
>>>
>>
>>
>> -- 
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

