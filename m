Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20E22397
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xgX5rhfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfDPN4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:56:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45888 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:56:38 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so17654605iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3EBrOSNOaQkcV/3XjthO4fBVGnoe9AW/r9xUsOE/fU=;
        b=xgX5rhfLETlCS6snknRB2McwT+AVgd2tdlabXrdXoYKjWnF6rtSdB9OlMC4eyp2ooS
         3m0nBJee6jCRPColA+KcTDMClobMbS/rvBoJwDTrH9KcCtsBm2Qu3NOB4LkV1+pW4mB4
         71nriOeqyYDzO8h5Ih7gGIRoi189biR6CFgVNM/upHm0UV6K4xSfKGdVv1SnewFtg2Yu
         Vw6+VKTteZ9X2PWyfxDeMrd/FfPLm1sF1ruwEAcRiJvF5a31GL3NWxUikW57bVRwFJxw
         RxerXfTbAwOgCNERSY4hZbfwVv/h23o7XR2I7F8zEN67UwxLRkoIY95q65cpLsre4PaA
         9scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3EBrOSNOaQkcV/3XjthO4fBVGnoe9AW/r9xUsOE/fU=;
        b=iQsKxqKFq6So+qUriWNaDIvJGCprq/yoaG0b1mJ3wBuzhVFNXR3oFKYKYf6By9c/BK
         MhaQ4bYf88JsRgErLd/Jd1/2YtzMU3YsKxnxq2yof5sXCxBC8bL3bOKeo7tZC/8lcMxr
         5vvIfm+/Wc3m8gthdSVSX00SQYP9DKBlH1St6rbeXTpup1WaPH4MrsUoj1UeExwh7Lau
         CKiVfSpuVMZDmAOU74E4taQ/QFO5ngKAiyOAZG8LKclJkV3vIKESbAAyllgcW+4eMFqY
         iqFcavEzh8xpKDZLAO53rfdEyaoDIb63rowo6GXUeecusY40ct7duldXGzCUklXkBRMm
         826w==
X-Gm-Message-State: APjAAAUf4SygjSuF3rVEtD69WxNzRzqGCDBXnQ6Hd8qGoqyqdgCRRNF+
        Yd2Mpr+0/KBic6+ZKQZYPfb3611YkMqK/rUS6qscD1kO
X-Google-Smtp-Source: APXvYqxRwpTxinGuzdVvHDj2d/AEAcr28xcGyfy6UyV+A3Shm3PrpAewWgVk9oj/0Jkk6u8qtRIb4VfC/IwJLyiWjP0=
X-Received: by 2002:a6b:3b43:: with SMTP id i64mr51648138ioa.121.1555422997004;
 Tue, 16 Apr 2019 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190318121100.28132-1-brgl@bgdev.pl> <20190318121100.28132-2-brgl@bgdev.pl>
 <d3d05858-966b-cd4a-3286-97e7d7bde0bc@linaro.org> <CAMRc=Mek-6x3_YYN4SYnx4Fbx0apQJTxKWOOJhkXwv3oG-hFXQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mek-6x3_YYN4SYnx4Fbx0apQJTxKWOOJhkXwv3oG-hFXQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Apr 2019 15:56:26 +0200
Message-ID: <CAMRc=MeQDXOf+mYH88PGMjbFG95o91oM5nq+rM+F31DUYSdR+A@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] clocksource: davinci-timer: new driver
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

wt., 16 kwi 2019 o 15:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> pon., 15 kwi 2019 o 14:36 Daniel Lezcano <daniel.lezcano@linaro.org> napi=
sa=C5=82(a):
> >
> > On 18/03/2019 13:10, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Currently the clocksource and clockevent support for davinci platform=
s
> > > lives in mach-davinci. It hard-codes many things, uses global variabl=
es,
> > > implements functionalities unused by any platform and has code fragme=
nts
> > > scattered across many (often unrelated) files.
> > >
> > > Implement a new, modern and simplified timer driver and put it into
> > > drivers/clocksource. We still need to support legacy board files so
> > > export a config structure and a function that allows machine code to
> > > register the timer.
> > >
> > > We don't bother freeing resources on errors in davinci_timer_register=
()
> > > as the system won't boot without a timer anyway.
> >
> > Can you give a quick description of the timer hardware and how it works=
?
> >
>
> Will do.
>
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > Reviewed-by: David Lechner <david@lechnology.com>
> > > ---
> > >  drivers/clocksource/Kconfig         |   5 +
> > >  drivers/clocksource/Makefile        |   1 +
> > >  drivers/clocksource/timer-davinci.c | 438 ++++++++++++++++++++++++++=
++
> > >  include/clocksource/timer-davinci.h |  44 +++
> > >  4 files changed, 488 insertions(+)
> > >  create mode 100644 drivers/clocksource/timer-davinci.c
> > >  create mode 100644 include/clocksource/timer-davinci.h
> > >
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> > > index 171502a356aa..08b1f539cfc4 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -42,6 +42,11 @@ config BCM_KONA_TIMER
> > >       help
> > >         Enables the support for the BCM Kona mobile timer driver.
> > >
> > > +config DAVINCI_TIMER
> > > +     bool "Texas Instruments DaVinci timer driver"
> >
> > Make the option silent (eg. if COMPILE_TEST)
> >
>
> Sure, I already did it locally after your last review.
>
> > > +     help
> > > +       Enables the support for the TI DaVinci timer driver.
> > > +
> > >  config DIGICOLOR_TIMER
> > >       bool "Digicolor timer driver" if COMPILE_TEST
> > >       select CLKSRC_MMIO
> > > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> > > index be6e0fbc7489..3c73d0e58b45 100644
> > > --- a/drivers/clocksource/Makefile
> > > +++ b/drivers/clocksource/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_SH_TIMER_TMU)  +=3D sh_tmu.o
> > >  obj-$(CONFIG_EM_TIMER_STI)   +=3D em_sti.o
> > >  obj-$(CONFIG_CLKBLD_I8253)   +=3D i8253.o
> > >  obj-$(CONFIG_CLKSRC_MMIO)    +=3D mmio.o
> > > +obj-$(CONFIG_DAVINCI_TIMER)  +=3D timer-davinci.o
> > >  obj-$(CONFIG_DIGICOLOR_TIMER)        +=3D timer-digicolor.o
> > >  obj-$(CONFIG_OMAP_DM_TIMER)  +=3D timer-ti-dm.o
> > >  obj-$(CONFIG_DW_APB_TIMER)   +=3D dw_apb_timer.o
> > > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksourc=
e/timer-davinci.c
> > > new file mode 100644
> > > index 000000000000..46dfc4d457fc
> > > --- /dev/null
> > > +++ b/drivers/clocksource/timer-davinci.c
> > > @@ -0,0 +1,438 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +//
> > > +// TI DaVinci clocksource driver
> > > +//
> > > +// Copyright (C) 2019 Texas Instruments
> > > +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > +// (with some parts adopted from code by Kevin Hilman <khilman@bayli=
bre.com>)
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/clockchips.h>
> > > +#include <linux/clocksource.h>
> > > +#include <linux/err.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/sched_clock.h>
> > > +
> > > +#include <clocksource/timer-davinci.h>
> > > +
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) "%s: " fmt "\n", __func__
> > > +
> > > +#define DAVINCI_TIMER_REG_TIM12                      0x10
> > > +#define DAVINCI_TIMER_REG_TIM34                      0x14
> > > +#define DAVINCI_TIMER_REG_PRD12                      0x18
> > > +#define DAVINCI_TIMER_REG_PRD34                      0x1c
> > > +#define DAVINCI_TIMER_REG_TCR                        0x20
> > > +#define DAVINCI_TIMER_REG_TGCR                       0x24
> > > +
> > > +#define DAVINCI_TIMER_TIMMODE_MASK           GENMASK(3, 2)
> > > +#define DAVINCI_TIMER_RESET_MASK             GENMASK(1, 0)
> > > +#define DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED        BIT(2)
> > > +#define DAVINCI_TIMER_UNRESET                        GENMASK(1, 0)
> > > +
> > > +/* Shift depends on timer. */
> > > +#define DAVINCI_TIMER_ENAMODE_MASK           GENMASK(1, 0)
> > > +#define DAVINCI_TIMER_ENAMODE_DISABLED               0x00
> > > +#define DAVINCI_TIMER_ENAMODE_ONESHOT                BIT(0)
> > > +#define DAVINCI_TIMER_ENAMODE_PERIODIC               BIT(1)
> > > +
> > > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12    6
> > > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34    22
> > > +
> > > +#define DAVINCI_TIMER_MIN_DELTA                      0x01
> > > +#define DAVINCI_TIMER_MAX_DELTA                      0xfffffffe
> > > +
> > > +#define DAVINCI_TIMER_CLKSRC_BITS            32
> > > +
> > > +#define DAVINCI_TIMER_TGCR_DEFAULT \
> > > +             (DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_=
UNRESET)
> > > +
> > > +enum {
> > > +     DAVINCI_TIMER_MODE_DISABLED =3D 0,
> > > +     DAVINCI_TIMER_MODE_ONESHOT,
> > > +     DAVINCI_TIMER_MODE_PERIODIC,
> > > +};
> >
> > This is replicating what is already available. Right after set_periodic
> > or set_oneshot are called, the timer state is changed to respectively
> > CLOCK_EVT_STATE_PERIODIC and CLOCK_EVT_STATE_ONESHOT. So it is useless
> > to define those enum again as what you want is to check the timer mode.
> >
>
> I did it like this because I'm reusing the code in
> davinci_timer_set_period_std() for both clocksource and clockevent
> timers. If you prefer it be split to reuse the clockevent accessors, I
> can do this (see below).
>
> >
> > [ ... ]
> >
> > > +
> > > +     clocksource =3D kzalloc(sizeof(*clocksource), GFP_KERNEL);
> > > +     if (!clocksource) {
> > > +             pr_err("Error allocating memory for clocksource data");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     clocksource->dev.rating =3D 300;
> > > +     clocksource->dev.read =3D davinci_timer_clksrc_read;
> > > +     clocksource->dev.mask =3D CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC=
_BITS);
> > > +     clocksource->dev.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
> >
> > >>>
> >
> > > +     clocksource->timer.set_period =3D davinci_timer_set_period_std;
> > > +     clocksource->timer.mode =3D DAVINCI_TIMER_MODE_PERIODIC;
> > > +     clocksource->timer.base =3D base;
> >
> > What for?
> >
>
> What am I assigning the timer for? In order to call
> davinci_timer_set_period() on it at the bottom of the init function.
> I'm not sure if it is a problem you're pointing out, but as I said
> above - I can configure the clocksource timer by hand in the init
> function, drop the davinci_timer_clocksource structure and use the
> clockevent accessors for checking the clock mode if you prefer it that
> way. Would that be fine?
>
> > <<<
> >
> > > +     if (timer_cfg->cmp_off) {
> > > +             clocksource->timer.regs =3D &davinci_timer_tim12_regs;
> > > +             clocksource->dev.name =3D "tim12";
> > > +     } else {
> > > +             clocksource->timer.regs =3D &davinci_timer_tim34_regs;
> > > +             clocksource->dev.name =3D "tim34";
> > > +     }
> > > +

Just to clarify for the above: I'll still need to account for these
lines here if I go that way. This again leads to code duplication IMO.

Bart

> > > +     rv =3D request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKSOURCE_IRQ=
].start,
> > > +                      davinci_timer_irq_freerun, IRQF_TIMER,
> > > +                      "free-run counter", clocksource);
> > > +     if (rv) {
> > > +             pr_err("Unable to request the clocksource interrupt");
> > > +             return rv;
> > > +     }
> >
> > Why do you have to request an interrupt to do nothing? Isn't possible t=
o
> > let the timer run and wrap without generating interrupts?
> >
>
> Yes it is, but the already existing DT bindings define two interrupts.
> It's true that nobody uses it, but I thought I'd stick with what was
> done before. If you prefer that, I can use a single interrupt - and
> just ignore the second one defined in DT (and also remove it from the
> config structure for board files).
>
> Thanks,
> Bartosz
>
> > [ ... ]
> >
> >
> >
> >
> > --
> >  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> >
