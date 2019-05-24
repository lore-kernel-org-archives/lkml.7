Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9B20851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MoBiL3dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391369AbfEXLxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:53:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51080 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391213AbfEXLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:53:33 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so5346154itg.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Olx2jUMn/p0zQfx9VbNrApHdYhy6zkwcJXQoeocFQb8=;
        b=MoBiL3ddbsJrj17WcHnA4+ze9RABw2LzS6+ivRupprW8n1YeamkxcTk8CXQ/eto63K
         TeO4g4ktSISM0I8CckGu5lRLojZRFU0x9Vss5ZSkJdt7W94z+8zBT5J74B+JNvvct+pa
         cu4jvHL1oLKR6HR6YsvP5SbNVxam7JAcr0WMQBHGi/jxvg6Ohh7uae4SgTWcea4riz/B
         m0i5Tfe6mlwk7bjY/xfp9X9Z5ZBBw6g81Kdz5PQ6uK2joWmrQGunA0h6ng72IZSy9/CN
         fzixtXNDW7GNxRXbjHcvu7Pzb+7paoqadr/dgeO4q49+BVth5EctcHNWRps8yHwrJEXY
         FqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Olx2jUMn/p0zQfx9VbNrApHdYhy6zkwcJXQoeocFQb8=;
        b=MiJnbXguk3yXuvYLF8LbxTQqz4UBlQnlJZEufjtI8wDW3WDObCWkV/4SQqV9YIJfSK
         vGbz/MmadqmOJgkJmQbMzACQLN7P1+jZ1j6YkiffcVswIPxlhCcbJ5FCjVF3VDdIXYhb
         dGKSZVZX+2hkQns5wTrSlG1K42qwprU8cwvF4JxQJcAJ/2EelNRr/nzcWqLdaFxcHIYX
         foBKUg6be8R0xWowoWIBKDXhrOgG3M3eZffcW1QduU9BHWNF6MB9RnWxmei9QhdoICxh
         BoScTDpLREYlj3XJvHrRFKvdS2gs4jo9vQruUD5MBVbhh3Fkzoj+eTGYU0rqdozj8YCu
         4oxQ==
X-Gm-Message-State: APjAAAXgOmYgH1KGQ0dooaE8tRJ2ihf3+nFM1SZQVb1GWJHUl6IzPuLY
        J9m2ctCB3s+rPeDk4MQzJ8IF7HpXejm1nJJgouWtVg==
X-Google-Smtp-Source: APXvYqzpj4QOr+2E0/Kw8ZTTTywyV/qjgDzRh20/3JB/k2G6bL4hRaKd8ZgC/goDdnzC8/JPglJL7Lp9nSlnPDzFpG0=
X-Received: by 2002:a05:660c:917:: with SMTP id s23mr17056377itj.166.1558698812088;
 Fri, 24 May 2019 04:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190523125813.29506-1-brgl@bgdev.pl> <20190523125813.29506-2-brgl@bgdev.pl>
 <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org> <CAMRc=MfUFE_yBSqS-s4fVcU9W11Amgeer-eXWNBrkG0Z7KD4tA@mail.gmail.com>
 <5f513fdc-7768-43b8-9d0c-56f07a60768f@linaro.org>
In-Reply-To: <5f513fdc-7768-43b8-9d0c-56f07a60768f@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 24 May 2019 13:53:20 +0200
Message-ID: <CAMRc=MeFMQ9rz-=8GktGtaQm1j-X66RsCBTqR3-mofc4Bju8-w@mail.gmail.com>
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

pt., 24 maj 2019 o 10:59 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 24/05/2019 09:28, Bartosz Golaszewski wrote:
> > czw., 23 maj 2019 o 18:38 Daniel Lezcano <daniel.lezcano@linaro.org> na=
pisa=C5=82(a):
> >>
> >> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> Currently the clocksource and clockevent support for davinci platform=
s
> >>> lives in mach-davinci. It hard-codes many things, uses global variabl=
es,
> >>> implements functionalities unused by any platform and has code fragme=
nts
> >>> scattered across many (often unrelated) files.
> >>>
> >>> Implement a new, modern and simplified timer driver and put it into
> >>> drivers/clocksource. We still need to support legacy board files so
> >>> export a config structure and a function that allows machine code to
> >>> register the timer.
> >>>
> >>> The timer we're using is 64-bit but can be programmed in dual 32-bit
> >>> mode (both chained and unchained). We're using dual 32-bit mode to
> >>> have separate counters for clockevents and clocksource.
> >>>
> >>> This patch contains the core code and support for clockevent. The
> >>> clocksource code will be included in a subsequent patch.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> ---
> >>>  drivers/clocksource/Kconfig         |   5 +
> >>>  drivers/clocksource/Makefile        |   1 +
> >>>  drivers/clocksource/timer-davinci.c | 285 ++++++++++++++++++++++++++=
++
> >>>  include/clocksource/timer-davinci.h |  44 +++++
> >>>  4 files changed, 335 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-davinci.c
> >>>  create mode 100644 include/clocksource/timer-davinci.h
> >>>
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> >>> index 6bcaa4e2e72c..32dee6abd54a 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -42,6 +42,11 @@ config BCM_KONA_TIMER
> >>>       help
> >>>         Enables the support for the BCM Kona mobile timer driver.
> >>>
> >>> +config DAVINCI_TIMER
> >>> +     bool "Texas Instruments DaVinci timer driver" if COMPILE_TEST
> >>> +     help
> >>> +       Enables the support for the TI DaVinci timer driver.
> >>> +
> >>>  config DIGICOLOR_TIMER
> >>>       bool "Digicolor timer driver" if COMPILE_TEST
> >>>       select CLKSRC_MMIO
> >>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> >>> index 236858fa7fbf..021831bcc567 100644
> >>> --- a/drivers/clocksource/Makefile
> >>> +++ b/drivers/clocksource/Makefile
> >>> @@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)  +=3D sh_tmu.o
> >>>  obj-$(CONFIG_EM_TIMER_STI)   +=3D em_sti.o
> >>>  obj-$(CONFIG_CLKBLD_I8253)   +=3D i8253.o
> >>>  obj-$(CONFIG_CLKSRC_MMIO)    +=3D mmio.o
> >>> +obj-$(CONFIG_DAVINCI_TIMER)  +=3D timer-davinci.o
> >>>  obj-$(CONFIG_DIGICOLOR_TIMER)        +=3D timer-digicolor.o
> >>>  obj-$(CONFIG_OMAP_DM_TIMER)  +=3D timer-ti-dm.o
> >>>  obj-$(CONFIG_DW_APB_TIMER)   +=3D dw_apb_timer.o
> >>> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksourc=
e/timer-davinci.c
> >>> new file mode 100644
> >>> index 000000000000..a8fc7b3805c9
> >>> --- /dev/null
> >>> +++ b/drivers/clocksource/timer-davinci.c
> >>> @@ -0,0 +1,285 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * TI DaVinci clocksource driver
> >>> + *
> >>> + * Copyright (C) 2019 Texas Instruments
> >>> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> + * (with tiny parts adopted from code by Kevin Hilman <khilman@bayli=
bre.com>)
> >>> + */
> >>> +
> >>> +#include <linux/clk.h>
> >>> +#include <linux/clockchips.h>
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/of_address.h>
> >>> +#include <linux/of_irq.h>
> >>> +#include <linux/sched_clock.h>
> >>> +
> >>> +#include <clocksource/timer-davinci.h>
> >>> +
> >>> +#undef pr_fmt
> >>> +#define pr_fmt(fmt) "%s: " fmt "\n", __func__
> >>> +
> >>> +#define DAVINCI_TIMER_REG_TIM12                      0x10
> >>> +#define DAVINCI_TIMER_REG_TIM34                      0x14
> >>> +#define DAVINCI_TIMER_REG_PRD12                      0x18
> >>> +#define DAVINCI_TIMER_REG_PRD34                      0x1c
> >>> +#define DAVINCI_TIMER_REG_TCR                        0x20
> >>> +#define DAVINCI_TIMER_REG_TGCR                       0x24
> >>> +
> >>> +#define DAVINCI_TIMER_TIMMODE_MASK           GENMASK(3, 2)
> >>> +#define DAVINCI_TIMER_RESET_MASK             GENMASK(1, 0)
> >>> +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED        BIT(2)
> >>> +#define DAVINCI_TIMER_UNRESET                        GENMASK(1, 0)
> >>> +
> >>> +#define DAVINCI_TIMER_ENAMODE_MASK           GENMASK(1, 0)
> >>> +#define DAVINCI_TIMER_ENAMODE_DISABLED               0x00
> >>> +#define DAVINCI_TIMER_ENAMODE_ONESHOT                BIT(0)
> >>> +
> >>> +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12    6
> >>> +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34    22
> >>> +
> >>> +#define DAVINCI_TIMER_MIN_DELTA                      0x01
> >>> +#define DAVINCI_TIMER_MAX_DELTA                      0xfffffffe
> >>> +
> >>> +#define DAVINCI_TIMER_TGCR_DEFAULT \
> >>> +             (DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_=
UNRESET)
> >>> +
> >>> +/* Cache the TCR register value. */
> >>> +static unsigned int davinci_tcr;
> >>> +
> >>> +struct davinci_clockevent {
> >>> +     struct clock_event_device dev;
> >>> +     void __iomem *base;
> >>> +
> >>> +     unsigned int tim_off;
> >>> +     unsigned int prd_off;
> >>> +     unsigned int cmp_off;
> >>> +
> >>> +     unsigned int enamode_disabled;
> >>> +     unsigned int enamode_oneshot;
> >>> +     unsigned int enamode_mask;
> >>> +};
> >>> +
> >>> +static struct davinci_clockevent *
> >>> +to_davinci_clockevent(struct clock_event_device *clockevent)
> >>> +{
> >>> +     return container_of(clockevent, struct davinci_clockevent, dev)=
;
> >>> +}
> >>> +
> >>> +static unsigned int
> >>> +davinci_clockevent_read(struct davinci_clockevent *clockevent,
> >>> +                     unsigned int reg)
> >>> +{
> >>> +     return readl_relaxed(clockevent->base + reg);
> >>> +}
> >>> +
> >>> +static void davinci_clockevent_write(struct davinci_clockevent *cloc=
kevent,
> >>> +                                  unsigned int reg, unsigned int val=
)
> >>> +{
> >>> +     writel_relaxed(val, clockevent->base + reg);
> >>> +}
> >>> +
> >>> +static void davinci_tcr_update(void __iomem *base,
> >>> +                            unsigned int mask, unsigned int val)
> >>> +{
> >>> +     davinci_tcr &=3D ~mask;
> >>> +     davinci_tcr |=3D val & mask;
> >>
> >>
> >> I don't see when the davinci_tcr is initialized.
> >>
> >
> > It's set to 0x0 by the compiler and we're setting the register to 0x0
> > in davinci_timer_init().
>
> Why did you need to readl before in the previous version? The idea of
> caching the value was to save an extra readl.
>
> If it is always zero, then we don't need this variable neither the read,
> just doing:
>
> writel_relaxed(val & mask, base + DAVINCI_TIMER_REG_TCR);
>
> should work no ?

It's not always zero. Its reset value is zero and we write 0 to it at
init time just to make sure, but then we modify it according to the
configuration. The single TCR register controls both halves of the
timer, so we do need an actual update, not a simple write.

Bart

>
>
> >>> +     writel_relaxed(davinci_tcr, base + DAVINCI_TIMER_REG_TCR);
> >>> +}
> >>> +
> >>> +static int davinci_clockevent_shutdown(struct clock_event_device *de=
v)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent;
> >>> +
> >>> +     clockevent =3D to_davinci_clockevent(dev);
> >>> +
> >>> +     davinci_tcr_update(clockevent->base,
> >>> +                        clockevent->enamode_mask,
> >>> +                        clockevent->enamode_disabled);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int davinci_clockevent_set_oneshot(struct clock_event_device =
*dev)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent=
(dev);
> >>> +
> >>> +     davinci_clockevent_write(clockevent, clockevent->tim_off, 0x0);
> >>> +
> >>> +     davinci_tcr_update(clockevent->base,
> >>> +                        clockevent->enamode_mask,
> >>> +                        clockevent->enamode_oneshot);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int
> >>> +davinci_clockevent_set_next_event_std(unsigned long cycles,
> >>> +                                   struct clock_event_device *dev)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent=
(dev);
> >>> +
> >>> +     davinci_clockevent_shutdown(dev);
> >>> +
> >>> +     davinci_clockevent_write(clockevent, clockevent->tim_off, 0x0);
> >>> +     davinci_clockevent_write(clockevent, clockevent->prd_off, cycle=
s);
> >>> +
> >>> +     davinci_clockevent_set_oneshot(dev);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int
> >>> +davinci_clockevent_set_next_event_cmp(unsigned long cycles,
> >>> +                                   struct clock_event_device *dev)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent =3D to_davinci_clockevent=
(dev);
> >>> +     unsigned int curr_time;
> >>> +
> >>> +     curr_time =3D davinci_clockevent_read(clockevent, clockevent->t=
im_off);
> >>> +     davinci_clockevent_write(clockevent,
> >>> +                              clockevent->cmp_off, curr_time + cycle=
s);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent =3D data;
> >>> +
> >>> +     if (!clockevent_state_oneshot(&clockevent->dev))
> >>> +             davinci_tcr_update(clockevent,
> >>> +                                clockevent->enamode_mask,
> >>> +                                clockevent->enamode_disabled);
> >>> +
> >>> +     clockevent->dev.event_handler(&clockevent->dev);
> >>> +
> >>> +     return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +static void davinci_timer_init(void __iomem *base)
> >>> +{
> >>> +     /* Set clock to internal mode and disable it. */
> >>> +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TCR);
> >>> +     /*
> >>> +      * Reset both 32-bit timers, set no prescaler for timer 34, set=
 the
> >>> +      * timer to dual 32-bit unchained mode, unreset both 32-bit tim=
ers.
> >>> +      */
> >>> +     writel_relaxed(DAVINCI_TIMER_TGCR_DEFAULT,
> >>> +                    base + DAVINCI_TIMER_REG_TGCR);
> >>> +     /* Init both counters to zero. */
> >>> +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
> >>> +     writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
> >>> +}
> >>> +
> >>> +int __init davinci_timer_register(struct clk *clk,
> >>> +                               const struct davinci_timer_cfg *timer=
_cfg)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent;
> >>> +     unsigned int tick_rate, shift;
> >>> +     void __iomem *base;
> >>> +     int rv;
> >>> +
> >>> +     rv =3D clk_prepare_enable(clk);
> >>> +     if (rv) {
> >>> +             pr_err("Unable to prepare and enable the timer clock");
> >>> +             return rv;
> >>> +     }
> >>> +
> >>> +     base =3D request_mem_region(timer_cfg->reg.start,
> >>> +                               resource_size(&timer_cfg->reg),
> >>> +                               "davinci-timer");
> >>> +     if (!base) {
> >>> +             pr_err("Unable to request memory region");
> >>> +             return -EBUSY;
> >>> +     }
> >>> +
> >>> +     base =3D ioremap(timer_cfg->reg.start, resource_size(&timer_cfg=
->reg));
> >>> +     if (!base) {
> >>> +             pr_err("Unable to map the register range");
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     davinci_timer_init(base);
> >>> +     tick_rate =3D clk_get_rate(clk);
> >>> +
> >>> +     clockevent =3D kzalloc(sizeof(*clockevent), GFP_KERNEL);
> >>> +     if (!clockevent) {
> >>> +             pr_err("Error allocating memory for clockevent data");
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     clockevent->dev.name =3D "tim12";
> >>> +     clockevent->dev.features =3D CLOCK_EVT_FEAT_ONESHOT;
> >>> +     clockevent->dev.cpumask =3D cpumask_of(0);
> >>> +
> >>> +     clockevent->base =3D base;
> >>> +     clockevent->tim_off =3D DAVINCI_TIMER_REG_TIM12;
> >>> +     clockevent->prd_off =3D DAVINCI_TIMER_REG_PRD12;
> >>> +
> >>> +     shift =3D DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
> >>> +     clockevent->enamode_disabled =3D DAVINCI_TIMER_ENAMODE_DISABLED=
 << shift;
> >>> +     clockevent->enamode_oneshot =3D DAVINCI_TIMER_ENAMODE_ONESHOT <=
< shift;
> >>> +     clockevent->enamode_mask =3D DAVINCI_TIMER_ENAMODE_MASK << shif=
t;
> >>> +
> >>> +     clockevent->dev.set_state_shutdown =3D davinci_clockevent_shutd=
own;
> >>> +     clockevent->dev.set_state_oneshot =3D davinci_clockevent_set_on=
eshot;
> >>> +
> >>> +     if (timer_cfg->cmp_off) {
> >>> +             clockevent->cmp_off =3D timer_cfg->cmp_off;
> >>> +             clockevent->dev.set_next_event =3D
> >>> +                             davinci_clockevent_set_next_event_cmp;
> >>> +     } else {
> >>> +             clockevent->dev.set_next_event =3D
> >>> +                             davinci_clockevent_set_next_event_std;
> >>> +     }
> >>> +
> >>> +     rv =3D request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ]=
.start,
> >>> +                      davinci_timer_irq_timer, IRQF_TIMER,
> >>> +                      "clockevent", clockevent);
> >>> +     if (rv) {
> >>> +             pr_err("Unable to request the clockevent interrupt");
> >>> +             return rv;
> >>> +     }
> >>> +
> >>> +     clockevents_config_and_register(&clockevent->dev, tick_rate,
> >>> +                                     DAVINCI_TIMER_MIN_DELTA,
> >>> +                                     DAVINCI_TIMER_MAX_DELTA);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int __init of_davinci_timer_register(struct device_node *np)
> >>> +{
> >>> +     struct davinci_timer_cfg timer_cfg =3D { };
> >>> +     struct clk *clk;
> >>> +     int rv;
> >>> +
> >>> +     rv =3D of_address_to_resource(np, 0, &timer_cfg.reg);
> >>> +     if (rv) {
> >>> +             pr_err("Unable to get the register range for timer");
> >>> +             return rv;
> >>> +     }
> >>> +
> >>> +     rv =3D of_irq_to_resource_table(np, timer_cfg.irq,
> >>> +                                   DAVINCI_TIMER_NUM_IRQS);
> >>> +     if (rv !=3D DAVINCI_TIMER_NUM_IRQS) {
> >>> +             pr_err("Unable to get the interrupts for timer");
> >>> +             return rv;
> >>> +     }
> >>> +
> >>> +     clk =3D of_clk_get(np, 0);
> >>> +     if (IS_ERR(clk)) {
> >>> +             pr_err("Unable to get the timer clock");
> >>> +             return PTR_ERR(clk);
> >>> +     }
> >>> +
> >>> +     rv =3D davinci_timer_register(clk, &timer_cfg);
> >>> +     if (rv)
> >>> +             clk_put(clk);
> >>> +
> >>> +     return rv;
> >>> +}
> >>> +TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_r=
egister);
> >>> diff --git a/include/clocksource/timer-davinci.h b/include/clocksourc=
e/timer-davinci.h
> >>> new file mode 100644
> >>> index 000000000000..1dcc1333fbc8
> >>> --- /dev/null
> >>> +++ b/include/clocksource/timer-davinci.h
> >>> @@ -0,0 +1,44 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only */
> >>> +/*
> >>> + * TI DaVinci clocksource driver
> >>> + *
> >>> + * Copyright (C) 2019 Texas Instruments
> >>> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> + */
> >>> +
> >>> +#ifndef __TIMER_DAVINCI_H__
> >>> +#define __TIMER_DAVINCI_H__
> >>> +
> >>> +#include <linux/clk.h>
> >>> +#include <linux/ioport.h>
> >>> +
> >>> +enum {
> >>> +     DAVINCI_TIMER_CLOCKEVENT_IRQ,
> >>> +     DAVINCI_TIMER_CLOCKSOURCE_IRQ,
> >>> +     DAVINCI_TIMER_NUM_IRQS,
> >>> +};
> >>> +
> >>> +/**
> >>> + * struct davinci_timer_cfg - davinci clocksource driver configurati=
on struct
> >>> + * @reg:        register range resource
> >>> + * @irq:        clockevent and clocksource interrupt resources
> >>> + * @cmp_off:    if set - it specifies the compare register used for =
clockevent
> >>> + *
> >>> + * Note: if the compare register is specified, the driver will use t=
he bottom
> >>> + * clock half for both clocksource and clockevent and the compare re=
gister
> >>> + * to generate event irqs. The user must supply the correct compare =
register
> >>> + * interrupt number.
> >>> + *
> >>> + * This is only used by da830 the DSP of which uses the top half. Th=
e timer
> >>> + * driver still configures the top half to run in free-run mode.
> >>> + */
> >>> +struct davinci_timer_cfg {
> >>> +     struct resource reg;
> >>> +     struct resource irq[DAVINCI_TIMER_NUM_IRQS];
> >>> +     unsigned int cmp_off;
> >>> +};
> >>> +
> >>> +int __init davinci_timer_register(struct clk *clk,
> >>> +                               const struct davinci_timer_cfg *data)=
;
> >>> +
> >>> +#endif /* __TIMER_DAVINCI_H__ */
> >>>
> >>
> >>
> >> --
> >>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
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
