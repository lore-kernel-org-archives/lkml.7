Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C513C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA31F214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v2htyT6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDHNtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:49:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40208 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDHNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:49:16 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so21008704itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggPF+m+QIaiMRPbjAh8cWsCraSg3hZOeTiDNkgeN/f8=;
        b=v2htyT6fZjMPglSOhhezp0+PnpkmZC5dJKMpXgW5vdfw4dVVtiydaDdtqAGZM91ArG
         WRYlCUJeloFfzBITeQx4CaoUS66qaus6Ff5pvIP6NFWQV6cFMFaktZuNWv0C7rMo5WEQ
         eHuP5cqIm9bAz23b7UdQAa6RY4oBnq9FRjep1vdd09nBUe/mwpC9hqCXpH6335FVgTpn
         eJLnR/QIIgtiiIgYX3ZBOJCs0OKOZxwL2WdkCLHcx5ogk8EPXQ3ZiPBZ1nN4l4Yt/kWS
         BdCTwFOosZd7cydNHXCL8We7Emsb85hVtukTX9S+ALgVMYBGJ3fNf+Z9TarVN6azOP/T
         jXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggPF+m+QIaiMRPbjAh8cWsCraSg3hZOeTiDNkgeN/f8=;
        b=N+adi+RcTMBhW5WewkQGDZ6Hzo5MBtXaterTXwk0PC5O2Tvit7q+UvEyCTkrmvRlOQ
         mNqEzkwFMxu77o/6TjAuXpu9VMNziDKWXumxWWDhOTbkEbHuRZZS8V5xaDQksZy6/cnk
         Jfx0Ph5z1s3hg869pP4hl7Qw3K+5A1KG+Wc6SlBdwxogBIXm5xIWjlb6Aei09J8spIwn
         X3rFId9zK7isy4NjLNSt49LTgaJviRrs/jp5SKXWCqiNTEjo/V+YhfR1Y8Q3oy4eqhvF
         L6sLCeo5YblU2YNYFQS3qvJaEeGJO5wSg3wAYtrrvQJWo7GyiaVasnAYwBM++vCtqICT
         oCSQ==
X-Gm-Message-State: APjAAAXAacn2hkNswp6UAaP8V+WQDe98jsEpb0kWyCHhWJ2RxpIilDQr
        gSurmUPkp6JQ2gN6Y8PuKVwHuOiNgSPCAGm+xgE7BA==
X-Google-Smtp-Source: APXvYqzp8Ea5/fanLRD597J2Ay7lOOsVWF7URKXt2C+6+h7v/eAuFvPr11mnLn8hj0I0iifB5Lveq1UnvP8WAz/dF5E=
X-Received: by 2002:a24:351:: with SMTP id e78mr18683727ite.160.1554731354796;
 Mon, 08 Apr 2019 06:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190318121100.28132-1-brgl@bgdev.pl> <20190318121100.28132-2-brgl@bgdev.pl>
 <63e3371d-e1d6-101f-0768-4a5d65c4bff6@linaro.org>
In-Reply-To: <63e3371d-e1d6-101f-0768-4a5d65c4bff6@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 8 Apr 2019 15:49:03 +0200
Message-ID: <CAMRc=MezSr4YCz_V=KMKiZTZDuT01T+Es4nAHDES=07qcYysrQ@mail.gmail.com>
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

After giving it another thought, I don't think we can use timer-of in
this driver easily.

It's meant to work both for board files and device-tree. The solution
with the least code duplication is to take the device_node on DT
systems and put all relevant properties into the custom structure used
by board files users. Timer-of maps the memory, enables the clock and
requests interrupts directly from the device_node. I'd have to do the
same for board files manually anyway. I think it's better to have a
single point of entry for the initialization code.

Even if I were just to reuse the timer-of structures without reusing
the actual code - they are still missing certain fields. We're using
32-bit "halves" of timers that are actually 64 bits - the 32-bit
control register deals with both by using the same layout of bit
fields but shifted. This is what the struct davinci_timer_regs is for.
Reusing those structures would also be confusing because of the of_
prefix in the naming.

I'd prefer to leave it as it is. Let me know what you think.

Bart
