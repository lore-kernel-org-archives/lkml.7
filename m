Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5117C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7610621841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="M2zwUP29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfEXH2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:28:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45695 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfEXH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:28:44 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so1628933iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wXMcfGKu+xKOuQrLoog+hBL5EqJCb7KC+/9qq7qlpEc=;
        b=M2zwUP29OgmCU4K+gTQsWyHUZxIqjF7I7j8YKWBRgJA8J6JBdoEDlZd6u6BcC82P6X
         SPtW3l8iRzm4068kVZ+XOVf+qHv06B5za1+Ng79psFS3XFaKN5zEA+cglgmChXRTREwf
         4ZCFHsT+gIvdPUkvWORHeWlozTsvjM8rtM4lzyuScmDofqfE9mIxvH+pMyD6dNCaQ8Jg
         PM8t2nyyjq1So03YMN2qzWRxyg6w1RKKGghm4LikRkx1c/ETS2CgEbtt2GmGDyv5Qt9/
         6OdpFV9wVkhP/K6r6RgfEABLwXwDfD65WUWGE6pL6pe+JI5bpeYjBw9A/rRYxd8C/bwP
         AoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wXMcfGKu+xKOuQrLoog+hBL5EqJCb7KC+/9qq7qlpEc=;
        b=o8LRYeUpZEju34hPPPiLrADhyFHD1zbdwYdPNC8inKkbIyYKMQc+LCqJ88lU+RkeeB
         e7yXTKvDVDQwET/bsR2SH0sHIs/S+bFo1dSuViqhZR5QFpbMGFFFJI1EZOUT1cKknrpe
         4Zz+MYXOXWRmKvRtqILKnp68zixxCHVmW0Zdyq5zF/iEGUhkTfGIoVBPNBuw8pKGo3O4
         xyX1NKjUyRJtE0PthuEfGjqvJ1YkFEJCB4aId1uXDyMHaSHuhVdqoOEaw7uJpg11R5hr
         pkrbuG0utd5DO19iOJjMaUhLANEc2KT4BhCCz+8w9+RUPkYMP8U3E83HN7b3DtPKJPVM
         +swQ==
X-Gm-Message-State: APjAAAXAWg0Ys7bve3vlbuUy82iQvxJKjeD/LPzqlGXunu9aQHeg4AZJ
        QU+mIPP7F0VUzXDXveqjVqXf9Iu7xtHyzmN275XwPQ==
X-Google-Smtp-Source: APXvYqzw0InAh7JGjvMdPPCJdKSyaPLoGVJmCU7dlP/6nj77W9QuX6RT6k6PYo8Glc+smsZIAp+Rouz1XpdctlDixa4=
X-Received: by 2002:a5d:9cc9:: with SMTP id w9mr58558081iow.287.1558682923038;
 Fri, 24 May 2019 00:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190523125813.29506-1-brgl@bgdev.pl> <20190523125813.29506-2-brgl@bgdev.pl>
 <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org>
In-Reply-To: <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 24 May 2019 09:28:31 +0200
Message-ID: <CAMRc=MfUFE_yBSqS-s4fVcU9W11Amgeer-eXWNBrkG0Z7KD4tA@mail.gmail.com>
Subject: Re: [RFC v2 1/2] clocksource: davinci-timer: add support for clockevents
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 maj 2019 o 18:38 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently the clocksource and clockevent support for davinci platforms
> > lives in mach-davinci. It hard-codes many things, uses global variables=
,
> > implements functionalities unused by any platform and has code fragment=
s
> > scattered across many (often unrelated) files.
> >
> > Implement a new, modern and simplified timer driver and put it into
> > drivers/clocksource. We still need to support legacy board files so
> > export a config structure and a function that allows machine code to
> > register the timer.
> >
> > The timer we're using is 64-bit but can be programmed in dual 32-bit
> > mode (both chained and unchained). We're using dual 32-bit mode to
> > have separate counters for clockevents and clocksource.
> >
> > This patch contains the core code and support for clockevent. The
> > clocksource code will be included in a subsequent patch.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/clocksource/Kconfig         |   5 +
> >  drivers/clocksource/Makefile        |   1 +
> >  drivers/clocksource/timer-davinci.c | 285 ++++++++++++++++++++++++++++
> >  include/clocksource/timer-davinci.h |  44 +++++
> >  4 files changed, 335 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-davinci.c
> >  create mode 100644 include/clocksource/timer-davinci.h
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 6bcaa4e2e72c..32dee6abd54a 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -42,6 +42,11 @@ config BCM_KONA_TIMER
> >       help
> >         Enables the support for the BCM Kona mobile timer driver.
> >
> > +config DAVINCI_TIMER
> > +     bool "Texas Instruments DaVinci timer driver" if COMPILE_TEST
> > +     help
> > +       Enables the support for the TI DaVinci timer driver.
> > +
> >  config DIGICOLOR_TIMER
> >       bool "Digicolor timer driver" if COMPILE_TEST
> >       select CLKSRC_MMIO
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
> > index 236858fa7fbf..021831bcc567 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)  +=3D sh_tmu.o
> >  obj-$(CONFIG_EM_TIMER_STI)   +=3D em_sti.o
> >  obj-$(CONFIG_CLKBLD_I8253)   +=3D i8253.o
> >  obj-$(CONFIG_CLKSRC_MMIO)    +=3D mmio.o
> > +obj-$(CONFIG_DAVINCI_TIMER)  +=3D timer-davinci.o
> >  obj-$(CONFIG_DIGICOLOR_TIMER)        +=3D timer-digicolor.o
> >  obj-$(CONFIG_OMAP_DM_TIMER)  +=3D timer-ti-dm.o
> >  obj-$(CONFIG_DW_APB_TIMER)   +=3D dw_apb_timer.o
> > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/=
timer-davinci.c
> > new file mode 100644
> > index 000000000000..a8fc7b3805c9
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-davinci.c
> > @@ -0,0 +1,285 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * TI DaVinci clocksource driver
> > + *
> > + * Copyright (C) 2019 Texas Instruments
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + * (with tiny parts adopted from code by Kevin Hilman <khilman@baylibr=
e.com>)
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/sched_clock.h>
> > +
> > +#include <clocksource/timer-davinci.h>
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "%s: " fmt "\n", __func__
> > +
> > +#define DAVINCI_TIMER_REG_TIM12                      0x10
> > +#define DAVINCI_TIMER_REG_TIM34                      0x14
> > +#define DAVINCI_TIMER_REG_PRD12                      0x18
> > +#define DAVINCI_TIMER_REG_PRD34                      0x1c
> > +#define DAVINCI_TIMER_REG_TCR                        0x20
> > +#define DAVINCI_TIMER_REG_TGCR                       0x24
> > +
> > +#define DAVINCI_TIMER_TIMMODE_MASK           GENMASK(3, 2)
> > +#define DAVINCI_TIMER_RESET_MASK             GENMASK(1, 0)
> > +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED        BIT(2)
> > +#define DAVINCI_TIMER_UNRESET                        GENMASK(1, 0)
> > +
> > +#define DAVINCI_TIMER_ENAMODE_MASK           GENMASK(1, 0)
> > +#define DAVINCI_TIMER_ENAMODE_DISABLED               0x00
> > +#define DAVINCI_TIMER_ENAMODE_ONESHOT                BIT(0)
> > +
> > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12    6
> > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34    22
> > +
> > +#define DAVINCI_TIMER_MIN_DELTA                      0x01
> > +#define DAVINCI_TIMER_MAX_DELTA                      0xfffffffe
> > +
> > +#define DAVINCI_TIMER_TGCR_DEFAULT \
> > +             (DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UN=
RESET)
> > +
> > +/* Cache the TCR register value. */
> > +static unsigned int davinci_tcr;
> > +
> > +struct davinci_clockevent {
> > +     struct clock_event_device dev;
> > +     void __iomem *base;
> > +
> > +     unsigned int tim_off;
> > +     unsigned int prd_off;
> > +     unsigned int cmp_off;
> > +
> > +     unsigned int enamode_disabled;
> > +     unsigned int enamode_oneshot;
> > +     unsigned int enamode_mask;
> > +};
> > +
> > +static struct davinci_clockevent *
> > +to_davinci_clockevent(struct clock_event_device *clockevent)
> > +{
> > +     return container_of(clockevent, struct davinci_clockevent, dev);
> > +}
> > +
> > +static unsigned int
> > +davinci_clockevent_read(struct davinci_clockevent *clockevent,
> > +                     unsigned int reg)
> > +{
> > +     return readl_relaxed(clockevent->base + reg);
> > +}
> > +
> > +static void davinci_clockevent_write(struct davinci_clockevent *clocke=
vent,
> > +                                  unsigned int reg, unsigned int val)
> > +{
> > +     writel_relaxed(val, clockevent->base + reg);
> > +}
> > +
> > +static void davinci_tcr_update(void __iomem *base,
> > +                            unsigned int mask, unsigned int val)
> > +{
> > +     davinci_tcr &=3D ~mask;
> > +     davinci_tcr |=3D val & mask;
>
>
> I don't see when the davinci_tcr is initialized.
>

It's set to 0x0 by the compiler and we're setting the register to 0x0
in davinci_timer_init().

Bart

> > +     writel_relaxed(davinci_tcr, base + DAVINCI_TIMER_REG_TCR);
> > +}
> > +
> > +static int davinci_clockevent_shutdown(struct clock_event_device *dev)
> > +{
> > +     struct davinci_clockevent *clockevent;
> > +
> > +     clockevent =3D to_davinci_clockevent(dev);
> > +
> > +     davinci_tcr_update(clockevent->base,
> > +                        clockevent->enamode_mask,
> > +                        clockevent->enamode_disabled);
> > +
> > +     return 0;
> > +}
> > +
> > +static int davinci_clockevent_set_oneshot(struct clock_event_device *d=
ev)
> > +{
> > +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent(d=
ev);
> > +
> > +     davinci_clockevent_write(clockevent, clockevent->tim_off, 0x0);
> > +
> > +     davinci_tcr_update(clockevent->base,
> > +                        clockevent->enamode_mask,
> > +                        clockevent->enamode_oneshot);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +davinci_clockevent_set_next_event_std(unsigned long cycles,
> > +                                   struct clock_event_device *dev)
> > +{
> > +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent(d=
ev);
> > +
> > +     davinci_clockevent_shutdown(dev);
> > +
> > +     davinci_clockevent_write(clockevent, clockevent->tim_off, 0x0);
> > +     davinci_clockevent_write(clockevent, clockevent->prd_off, cycles)=
;
> > +
> > +     davinci_clockevent_set_oneshot(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +davinci_clockevent_set_next_event_cmp(unsigned long cycles,
> > +                                   struct clock_event_device *dev)
> > +{
> > +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent(d=
ev);
> > +     unsigned int curr_time;
> > +
> > +     curr_time =3D davinci_clockevent_read(clockevent, clockevent->tim=
_off);
> > +     davinci_clockevent_write(clockevent,
> > +                              clockevent->cmp_off, curr_time + cycles)=
;
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
> > +{
> > +     struct davinci_clockevent *clockevent =3D data;
> > +
> > +     if (!clockevent_state_oneshot(&clockevent->dev))
> > +             davinci_tcr_update(clockevent,
> > +                                clockevent->enamode_mask,
> > +                                clockevent->enamode_disabled);
> > +
> > +     clockevent->dev.event_handler(&clockevent->dev);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void davinci_timer_init(void __iomem *base)
> > +{
> > +     /* Set clock to internal mode and disable it. */
> > +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TCR);
> > +     /*
> > +      * Reset both 32-bit timers, set no prescaler for timer 34, set t=
he
> > +      * timer to dual 32-bit unchained mode, unreset both 32-bit timer=
s.
> > +      */
> > +     writel_relaxed(DAVINCI_TIMER_TGCR_DEFAULT,
> > +                    base + DAVINCI_TIMER_REG_TGCR);
> > +     /* Init both counters to zero. */
> > +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
> > +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
> > +}
> > +
> > +int __init davinci_timer_register(struct clk *clk,
> > +                               const struct davinci_timer_cfg *timer_c=
fg)
> > +{
> > +     struct davinci_clockevent *clockevent;
> > +     unsigned int tick_rate, shift;
> > +     void __iomem *base;
> > +     int rv;
> > +
> > +     rv =3D clk_prepare_enable(clk);
> > +     if (rv) {
> > +             pr_err("Unable to prepare and enable the timer clock");
> > +             return rv;
> > +     }
> > +
> > +     base =3D request_mem_region(timer_cfg->reg.start,
> > +                               resource_size(&timer_cfg->reg),
> > +                               "davinci-timer");
> > +     if (!base) {
> > +             pr_err("Unable to request memory region");
> > +             return -EBUSY;
> > +     }
> > +
> > +     base =3D ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->=
reg));
> > +     if (!base) {
> > +             pr_err("Unable to map the register range");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     davinci_timer_init(base);
> > +     tick_rate =3D clk_get_rate(clk);
> > +
> > +     clockevent =3D kzalloc(sizeof(*clockevent), GFP_KERNEL);
> > +     if (!clockevent) {
> > +             pr_err("Error allocating memory for clockevent data");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     clockevent->dev.name =3D "tim12";
> > +     clockevent->dev.features =3D CLOCK_EVT_FEAT_ONESHOT;
> > +     clockevent->dev.cpumask =3D cpumask_of(0);
> > +
> > +     clockevent->base =3D base;
> > +     clockevent->tim_off =3D DAVINCI_TIMER_REG_TIM12;
> > +     clockevent->prd_off =3D DAVINCI_TIMER_REG_PRD12;
> > +
> > +     shift =3D DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
> > +     clockevent->enamode_disabled =3D DAVINCI_TIMER_ENAMODE_DISABLED <=
< shift;
> > +     clockevent->enamode_oneshot =3D DAVINCI_TIMER_ENAMODE_ONESHOT << =
shift;
> > +     clockevent->enamode_mask =3D DAVINCI_TIMER_ENAMODE_MASK << shift;
> > +
> > +     clockevent->dev.set_state_shutdown =3D davinci_clockevent_shutdow=
n;
> > +     clockevent->dev.set_state_oneshot =3D davinci_clockevent_set_ones=
hot;
> > +
> > +     if (timer_cfg->cmp_off) {
> > +             clockevent->cmp_off =3D timer_cfg->cmp_off;
> > +             clockevent->dev.set_next_event =3D
> > +                             davinci_clockevent_set_next_event_cmp;
> > +     } else {
> > +             clockevent->dev.set_next_event =3D
> > +                             davinci_clockevent_set_next_event_std;
> > +     }
> > +
> > +     rv =3D request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].s=
tart,
> > +                      davinci_timer_irq_timer, IRQF_TIMER,
> > +                      "clockevent", clockevent);
> > +     if (rv) {
> > +             pr_err("Unable to request the clockevent interrupt");
> > +             return rv;
> > +     }
> > +
> > +     clockevents_config_and_register(&clockevent->dev, tick_rate,
> > +                                     DAVINCI_TIMER_MIN_DELTA,
> > +                                     DAVINCI_TIMER_MAX_DELTA);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init of_davinci_timer_register(struct device_node *np)
> > +{
> > +     struct davinci_timer_cfg timer_cfg =3D { };
> > +     struct clk *clk;
> > +     int rv;
> > +
> > +     rv =3D of_address_to_resource(np, 0, &timer_cfg.reg);
> > +     if (rv) {
> > +             pr_err("Unable to get the register range for timer");
> > +             return rv;
> > +     }
> > +
> > +     rv =3D of_irq_to_resource_table(np, timer_cfg.irq,
> > +                                   DAVINCI_TIMER_NUM_IRQS);
> > +     if (rv !=3D DAVINCI_TIMER_NUM_IRQS) {
> > +             pr_err("Unable to get the interrupts for timer");
> > +             return rv;
> > +     }
> > +
> > +     clk =3D of_clk_get(np, 0);
> > +     if (IS_ERR(clk)) {
> > +             pr_err("Unable to get the timer clock");
> > +             return PTR_ERR(clk);
> > +     }
> > +
> > +     rv =3D davinci_timer_register(clk, &timer_cfg);
> > +     if (rv)
> > +             clk_put(clk);
> > +
> > +     return rv;
> > +}
> > +TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_reg=
ister);
> > diff --git a/include/clocksource/timer-davinci.h b/include/clocksource/=
timer-davinci.h
> > new file mode 100644
> > index 000000000000..1dcc1333fbc8
> > --- /dev/null
> > +++ b/include/clocksource/timer-davinci.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * TI DaVinci clocksource driver
> > + *
> > + * Copyright (C) 2019 Texas Instruments
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + */
> > +
> > +#ifndef __TIMER_DAVINCI_H__
> > +#define __TIMER_DAVINCI_H__
> > +
> > +#include <linux/clk.h>
> > +#include <linux/ioport.h>
> > +
> > +enum {
> > +     DAVINCI_TIMER_CLOCKEVENT_IRQ,
> > +     DAVINCI_TIMER_CLOCKSOURCE_IRQ,
> > +     DAVINCI_TIMER_NUM_IRQS,
> > +};
> > +
> > +/**
> > + * struct davinci_timer_cfg - davinci clocksource driver configuration=
 struct
> > + * @reg:        register range resource
> > + * @irq:        clockevent and clocksource interrupt resources
> > + * @cmp_off:    if set - it specifies the compare register used for cl=
ockevent
> > + *
> > + * Note: if the compare register is specified, the driver will use the=
 bottom
> > + * clock half for both clocksource and clockevent and the compare regi=
ster
> > + * to generate event irqs. The user must supply the correct compare re=
gister
> > + * interrupt number.
> > + *
> > + * This is only used by da830 the DSP of which uses the top half. The =
timer
> > + * driver still configures the top half to run in free-run mode.
> > + */
> > +struct davinci_timer_cfg {
> > +     struct resource reg;
> > +     struct resource irq[DAVINCI_TIMER_NUM_IRQS];
> > +     unsigned int cmp_off;
> > +};
> > +
> > +int __init davinci_timer_register(struct clk *clk,
> > +                               const struct davinci_timer_cfg *data);
> > +
> > +#endif /* __TIMER_DAVINCI_H__ */
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
