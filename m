Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2114D2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YYadS9fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfEWPec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:34:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52117 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:34:31 -0400
Received: by mail-it1-f196.google.com with SMTP id m3so10458832itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4KPzzFsdGcBdAr5bNG6JKh38d9/uHM4E4WIv1LXSx4=;
        b=YYadS9fNuoSsvmLh28CLlcNFOR4c0CO8CCadSPs02K2zUwG2Cov8aiLX/U+yGOAYGb
         R0KBvuagNFrO3HD3wgaOQmMm7OmGrpBAQIXWnTCLJHVsCCfbxaCPWs4UY9IihyiTZ9AV
         uBcmQrLpB4/R7JKLsgyCs+fsVwWCPv4y//sJAxbmyMXQ+LUs5zjs32+s55uwg0ecp9nQ
         F7Wim0HYNflr/5CcCtu/014icVLBvPbutqSzx0vGItbbaCLKx426zzLOFgd8n2W4sjk5
         qjrsJirsR3I42TOvUNtsBdkmd/5nLzCTshPBzcfQvDpnqGk6fNBgrMY8tda01I3Xolk1
         XT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4KPzzFsdGcBdAr5bNG6JKh38d9/uHM4E4WIv1LXSx4=;
        b=QyZceRCMWCbnN04Id4yWq88N/W5XxjRsfGNZVXE1h1Lq9BhkadnXap5/EWrefc9fGZ
         l7heVtTOkoGcsSeSBrqxmwK5Y+q/1aovXNUB1D7XtRJWvzc4r2rxdWuhaTAdzJnV/H6z
         ho4g/Nj0leGqlFWaxcxYaDn2416jNgxAGdjzXokI2YVIJ/vkdvI1YRIiUsTcm39Wr9Vz
         1cMKMYsnxvrZqyFHwl6LYG0y5HVVCyPzpjdVADXP/TYAHUpDmLbzVwupDEnsM+xuyvSl
         Fo7G+fXeGk4PT0225uHLSV1pc9PU12AfhmB309+tKzsQ0k7mqejGZtVU/PavjuACGZKq
         6MwA==
X-Gm-Message-State: APjAAAWbrjTJ0T/DsDH4EY50RgfM/UHt6TsS+Zmq6SU3oIpaeRbb0o/9
        K9vcbKyhKPM3usVdiB3ugnDZiTXRSQ+Bw3Rku9ucNQ==
X-Google-Smtp-Source: APXvYqwOyTiWj7DRNZuwkOCP8cSldAHhrwF14HATAzXUOruWpcjC64EzkCng07uLWqWchLgSG8+SA02W9UGBjHjD4ik=
X-Received: by 2002:a24:e409:: with SMTP id o9mr14808892ith.4.1558625670960;
 Thu, 23 May 2019 08:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190417144709.19588-1-brgl@bgdev.pl> <20190417144709.19588-2-brgl@bgdev.pl>
 <187fdcd8-4cc8-3871-ee66-1ebd7408b1fe@linaro.org> <CAMRc=MdQ_GORGaw1szwvBRqKzkZQCZNnEcwkNzmGduEbiDR4Lw@mail.gmail.com>
 <ca00f49f-0fa2-1907-feac-ba798dce365b@linaro.org>
In-Reply-To: <ca00f49f-0fa2-1907-feac-ba798dce365b@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 May 2019 17:34:20 +0200
Message-ID: <CAMRc=Mf37TZZO00tbXhAyxzNBYx9C-farKNQ=9vmVWZY59KC2w@mail.gmail.com>
Subject: Re: [RFC 1/2] clocksource: davinci-timer: add support for clockevents
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

czw., 23 maj 2019 o 15:25 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
>
> Hi Bartosz,
>
>
>
> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
>
> [ ... ]
>
> >>> +++ b/drivers/clocksource/timer-davinci.c
> >>> @@ -0,0 +1,272 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +//
> >>> +// TI DaVinci clocksource driver
> >>> +//
> >>> +// Copyright (C) 2019 Texas Instruments
> >>> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> +// (with tiny parts adopted from code by Kevin Hilman <khilman@bayli=
bre.com>)
> >>
> >> The header format is wrong, it should be:
> >>
> >> // SPDX-License-Identifier: GPL-2.0-only
> >> /*
> >>  * TI DaVinci clocksource driver
> >>  *
> >>  * ...
> >>  * ...
> >>  *
> >>  */
> >
> > It's not wrong. It looks like it's at the maintainers discretion and
> > I've been asked to use both forms by different maintainers. Seems you
> > just can't get it right. :) I've changed it in v2 though.
>
> Right, I've been through the documentation but it is still unclear for
> me. So let's stick to whatever you want for now.
>
> [ ... ]
>
> >>> +static int
> >>> +davinci_clockevent_set_next_event_std(unsigned long cycles,
> >>> +                                   struct clock_event_device *dev)
> >>> +{
> >>> +     struct davinci_clockevent *clockevent;
> >>> +     unsigned int enamode;
> >>> +
> >>> +     clockevent =3D to_davinci_clockevent(dev);
> >>> +     enamode =3D clockevent->enamode_disabled;
> >>> +
> >>> +     davinci_clockevent_update(clockevent, DAVINCI_TIMER_REG_TCR,
> >>> +                               clockevent->enamode_mask,
> >>> +                               clockevent->enamode_disabled);
> >>
> >> What is for this function with the DAVINCI_TIMER_REG_TCR parameter?
> >
> > I'm not sure I understand the question. :(
>
> I meant davinci_clockevent_update is always called with the
> DAVINCI_TIMER_REG_TCR parameter.
>
> So it can be changed to:
> static void davinci_clockevent_update(struct davinci_clockevent
>                                                 *clockevent,
>                                         unsigned int mask,
>                                         unsigned int val)
> {
>         davinci_reg_update(clockevent->base, DAVINCI_TIMER_REG_TCR,
>                                  mask, val);
> }
>

Yes, this is pretty much what I did in v2.

>
> Alternatively davinci_clockevent_update can be replaced by a direct call
> to davinci_reg_update.
>
> [ ... ]
>
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
> >>> +     clockevent->enamode_periodic =3D DAVINCI_TIMER_ENAMODE_PERIODIC=
 << shift;
> >>> +     clockevent->enamode_mask =3D DAVINCI_TIMER_ENAMODE_MASK << shif=
t;
> >>
> >> I don't see where 'shift' can be different from TIM12 here neither in
> >> the second patch for those values. Why create these fields instead of
> >> pre-computed macros?
> >>
> >
> > The variable 'shift' here is only to avoid breaking the lines (just a h=
elper).
> >
> > The shift itself can be different though in the second patch -
> > specifically when calling davinci_clocksource_init().
> >
> > If I were to use predefined values for clockevent, we'd still need
> > another set of values for clocksource. I think it's clearer the way it
> > is.
>
> Ah yes, I see, it is passed as parameter. Ok, let's keep it this way if
> you prefer.
>
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
> >>
> >> May be replace "clockevent" by eg. "tim12"?
> >>
> >
> > I don't think this is a good idea. Now if you look at /proc/interrupts
> > you can tell immediately what the interrupt is for ("clockevent").
> > With "tim12" it's no longer that clear.
>
> Yes, "tim12" can be confusing. However, it is good practice to add a
> device name aside with its purpose in case there are several timers
> defined on the system. "clockevent" is a kernel internal representation
> of a timer, so may be a name like "timer/tim12" or something in the same
> spirit would be more adequate.
>

I'll wait for your comments on v2 before changing it in the final submissio=
n.

Thanks,
Bart

>
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
