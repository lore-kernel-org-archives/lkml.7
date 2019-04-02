Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F470C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134292177E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GTeJO027"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfDBM2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:28:35 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38540 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbfDBM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:28:35 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so4834292ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a4ZCAN0lEso2B2ukIQtRNarFPVhBH0Kvs6Q+6vaVLkU=;
        b=GTeJO027XXN8sClbvdpt2oECGOdABSNlBnhdvb8ym2/2o/0A3CuJNQEonq0evlUEbi
         rvXAq539/fIetiLsWvctILgOjFevHTfw2/0qryD3MHrNt2bIX6oFJPaoU+NKAc0XtAKC
         LT0C/AmcO82J7KPi3TJtHi+ZHtYsESGvpXpvSj0x/C7pGW7gn8IBuyZXmyvBxHAQM/De
         VNNbH32a4RYZRIZR/efDFvcuBhp90LJeiBdQuaz7LS/KD7oNlqVqJSkC+nbG5XBh3MBL
         e2NUguOD2WYgrZPmP9Wl8dAAO+xB329+h4Z6JLyaK2Wsinwq5eQ0JqHwdnOPxmUz0vYJ
         VwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a4ZCAN0lEso2B2ukIQtRNarFPVhBH0Kvs6Q+6vaVLkU=;
        b=P1eo2GXhi7AUZO4GKFcubN1rjPUHXsRdZpumIC9FmjM6d2yzHLHZzS6qAHIPWcKPA1
         BBXEisReZQyMJcgyI6pYSltt3qPATaD3jBDoimxRiZhkeu2TJBN232X345D46+wJ+FPk
         RaqTjxWATAJ6Wr6F1Z5msDISPq9Iyhu0G5VQt7eUtoriUctUv2sjXefBMNF+TJcMDrro
         mWzfbcf82CfoDidmkY2As3EXuica/VUXcRBBXkBkdJWMfH8jLoZx+LB6+EiBuZXW/i3G
         +zj8yZGZR9VrhizYqYbGH4rHGS2R+j80/eLZSSBoXAqxtCGt7pW8vsyO6qN1fM4Mcckm
         B+TQ==
X-Gm-Message-State: APjAAAVO0/bHMmpk2l3+pJZtdfF6SImQk6gAbhXqZzX5s+p7R5ZqSLdC
        huckUD6a0Pxdp6TH3Zf9x7C2bCWdffTDD/a+lBr5Lw==
X-Google-Smtp-Source: APXvYqxW4PAQ27VEkolA3j1AkJmPvG7y6mHkM6/Zp4z+MhuzMsibba17fokPcRlEQQ8S/to10qHYZ92YaiA4DuYCd1c=
X-Received: by 2002:a02:c955:: with SMTP id u21mr7872306jao.105.1554208114181;
 Tue, 02 Apr 2019 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190318121100.28132-1-brgl@bgdev.pl> <20190318121100.28132-2-brgl@bgdev.pl>
 <63e3371d-e1d6-101f-0768-4a5d65c4bff6@linaro.org>
In-Reply-To: <63e3371d-e1d6-101f-0768-4a5d65c4bff6@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Apr 2019 14:28:23 +0200
Message-ID: <CAMRc=Mfj2saWQeuEgT0-1KpLJjU34gVV7z-B7_g6+ZGeNcz6qg@mail.gmail.com>
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

wt., 2 kwi 2019 o 11:21 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 18/03/2019 13:10, Bartosz Golaszewski wrote:
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
> > We don't bother freeing resources on errors in davinci_timer_register()
> > as the system won't boot without a timer anyway.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: David Lechner <david@lechnology.com>
> > ---
> >  drivers/clocksource/Kconfig         |   5 +
> >  drivers/clocksource/Makefile        |   1 +
> >  drivers/clocksource/timer-davinci.c | 438 ++++++++++++++++++++++++++++
> >  include/clocksource/timer-davinci.h |  44 +++
> >  4 files changed, 488 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-davinci.c
> >  create mode 100644 include/clocksource/timer-davinci.h
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 171502a356aa..08b1f539cfc4 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -42,6 +42,11 @@ config BCM_KONA_TIMER
> >       help
> >         Enables the support for the BCM Kona mobile timer driver.
> >
> > +config DAVINCI_TIMER
> > +     bool "Texas Instruments DaVinci timer driver"
> > +     help
> > +       Enables the support for the TI DaVinci timer driver.
> > +
>
> Please make it a silence option only visible with COMPILE_TEST or
> EXPERT, examples here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/Kconfig#n45
>
> or second format:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/Kconfig#n459
>
> >  config DIGICOLOR_TIMER
> >       bool "Digicolor timer driver" if COMPILE_TEST
> >       select CLKSRC_MMIO
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
> > index be6e0fbc7489..3c73d0e58b45 100644
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
> > index 000000000000..46dfc4d457fc
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-davinci.c
> > @@ -0,0 +1,438 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// TI DaVinci clocksource driver
> > +//
> > +// Copyright (C) 2019 Texas Instruments
> > +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +// (with some parts adopted from code by Kevin Hilman <khilman@baylibr=
e.com>)
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/err.h>
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
> > +/* Shift depends on timer. */
> > +#define DAVINCI_TIMER_ENAMODE_MASK           GENMASK(1, 0)
> > +#define DAVINCI_TIMER_ENAMODE_DISABLED               0x00
> > +#define DAVINCI_TIMER_ENAMODE_ONESHOT                BIT(0)
> > +#define DAVINCI_TIMER_ENAMODE_PERIODIC               BIT(1)
> > +
> > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM12    6
> > +#define DAVINCI_TIMER_ENAMODE_SHIFT_TIM34    22
> > +
> > +#define DAVINCI_TIMER_MIN_DELTA                      0x01
> > +#define DAVINCI_TIMER_MAX_DELTA                      0xfffffffe
> > +
> > +#define DAVINCI_TIMER_CLKSRC_BITS            32
> > +
> > +#define DAVINCI_TIMER_TGCR_DEFAULT \
> > +             (DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UN=
RESET)
> > +
> > +enum {
> > +     DAVINCI_TIMER_MODE_DISABLED =3D 0,
> > +     DAVINCI_TIMER_MODE_ONESHOT,
> > +     DAVINCI_TIMER_MODE_PERIODIC,
> > +};
> > +
> > +struct davinci_timer_data;
> > +
> > +typedef void (*davinci_timer_set_period_func)(struct davinci_timer_dat=
a *,
> > +                                           unsigned int period);
> > +
> > +/**
> > + * struct davinci_timer_regs - timer-specific register offsets
> > + *
> > + * @tim_off: timer counter register
> > + * @prd_off: timer period register
> > + * @enamode_shift: left bit-shift of the enable register associated
> > + *                 with this timer in the TCR register
> > + */
> > +struct davinci_timer_regs {
> > +     unsigned int tim_off;
> > +     unsigned int prd_off;
> > +     unsigned int enamode_shift;
> > +};
> > +
> > +struct davinci_timer_data {
> > +     void __iomem *base;
> > +     const struct davinci_timer_regs *regs;
> > +     unsigned int mode;
> > +     davinci_timer_set_period_func set_period;
> > +     unsigned int cmp_off;
> > +};
> > +
> > +struct davinci_timer_clockevent {
> > +     struct clock_event_device dev;
> > +     unsigned int tick_rate;
> > +     struct davinci_timer_data timer;
> > +};
>
> The timer-of API provides the functions and the common structures for
> the usual operations. Please use them instead of redefining your own
> structures.
>

Hi Daniel,

do you have any suggestion about where to put the information about
register offsets I'm now storing in struct davinci_timer_regs? I
thought about having specialized wrappers around all relevant
functions that access the registers, but that seems like an overkill.
For instance we'd have:

davinci_timer_set_period_std()

and two specialized variants:

davinci_timer_set_period_std_tim12() and davinci_timer_set_period_std_tim34=
()

The former would take struct davinci_timer_regs as argument while two
latter routines would fit the callback format. We'd then need the same
for three more routines.

Alternatively struct timer_of could be packed together with struct
davinci_timer_regs in another structure and accessed in callbacks via
container_of.

Do you have a preference or a different idea?

Bartosz

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
