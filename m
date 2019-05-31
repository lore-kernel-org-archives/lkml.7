Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFBD268AD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rQIZSniU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEaMVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:21:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55155 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:21:16 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so15330295itk.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ie7nzOQWgvSP+rjuV9XzGj5tstN5Qnh4DhU7fJJh8c0=;
        b=rQIZSniUyBRaDoAa9OhgSc1XyFTI58cakDgH6W8i+kUSGDh+TNyA7wC8Xg0Rlk1KrC
         srejZxR0uYC0BQTwaggq9g4QicSZ1tIIWcmKeAXqr3hX6ZRh2ZEar5psFp/5FTNgnoKA
         yIZqmLlCQE1wuFvOxPBVwmoxquC84TeX8oOiab9OqXrH/djZ/TqBtkaAAyUjuRQDS8ZI
         JlIGDy8Ps+iKr9yjoD57sdcKFsAJnLwStanNzfggWCM90LGKRHXQruDDUY2fmjT3lS0Y
         pQihMvCbbGKihIG/wDTbRyV3rMr8IOvMc4aqrGTIA84d4GWjaJiqvFfH4Kp5j3of5ISG
         WYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ie7nzOQWgvSP+rjuV9XzGj5tstN5Qnh4DhU7fJJh8c0=;
        b=tapeiWAhdFRVu8uVeMJmrxt26CGX1UO/Rqe508e/FoIeaciCFOqMdZ2Zo5FpX9u7Fx
         icqiutc+hNZZLO3TI4QoXz7EyESAYZs1J13UKQJ8hWf3CCOTgIXKbdu+hGprOuIDVft+
         AGz6WvJAyHybAQmMI4LfX45Np1E8uOSxY11ZiAsg1tPvvSylaopO8eevAj1a6lcWECKH
         qP4lLcVTvV1UrUO6js4HWDeTpl1JDjQAVqkKFV/m7FRTEmeBtNc1z7ICfm6MKZp5JEb5
         3LhFkf17Mkb1124y0T3Ci9/yyBO4WvPZfApl4vTIAWTGUb6jZCL8hxRuybFPZyUIrDL7
         HrtQ==
X-Gm-Message-State: APjAAAWpDqCN47N/aqvHOZonYrkDrjzHLK165F5cK5mwShL42tGhbzj5
        UBam9VdEkzu7cOErzGqY17lARbUPHvTvIHHcfMbhAA==
X-Google-Smtp-Source: APXvYqydN8y5filaWrzf90A7dtZQbs0qp1udvwSLh7dvuWYQgis5GNJFEIU73UB7H6j0jyK7fSPmiqgY4Vy+3/pMAdw=
X-Received: by 2002:a24:edcd:: with SMTP id r196mr1838889ith.139.1559305275651;
 Fri, 31 May 2019 05:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190523125813.29506-1-brgl@bgdev.pl> <20190523125813.29506-2-brgl@bgdev.pl>
 <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org> <CAMRc=MfUFE_yBSqS-s4fVcU9W11Amgeer-eXWNBrkG0Z7KD4tA@mail.gmail.com>
 <5f513fdc-7768-43b8-9d0c-56f07a60768f@linaro.org> <CAMRc=MeFMQ9rz-=8GktGtaQm1j-X66RsCBTqR3-mofc4Bju8-w@mail.gmail.com>
 <a4585f30-5fa7-7fde-bbbd-c32464c0f060@linaro.org> <CAMRc=Mcx55yJ2HmTi7ui4sxa5L+Fwgudra-chaxgYccgg8Vtfw@mail.gmail.com>
In-Reply-To: <CAMRc=Mcx55yJ2HmTi7ui4sxa5L+Fwgudra-chaxgYccgg8Vtfw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 31 May 2019 14:21:04 +0200
Message-ID: <CAMRc=Mfsy4hScgXAAnKT7yi7k6RObC7of6BH6Fg8TKBajaUqvw@mail.gmail.com>
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

niedz., 26 maj 2019 o 10:16 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> sob., 25 maj 2019 o 16:16 Daniel Lezcano <daniel.lezcano@linaro.org> napi=
sa=C5=82(a):
> >
> > On 24/05/2019 13:53, Bartosz Golaszewski wrote:
> > > pt., 24 maj 2019 o 10:59 Daniel Lezcano <daniel.lezcano@linaro.org> n=
apisa=C5=82(a):
> > >>
> > >> On 24/05/2019 09:28, Bartosz Golaszewski wrote:
> > >>> czw., 23 maj 2019 o 18:38 Daniel Lezcano <daniel.lezcano@linaro.org=
> napisa=C5=82(a):
> > >>>>
> > >>>> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
> > >>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>>>>
> > >>>>> Currently the clocksource and clockevent support for davinci plat=
forms
> > >>>>> lives in mach-davinci. It hard-codes many things, uses global var=
iables,
> > >>>>> implements functionalities unused by any platform and has code fr=
agments
> > >>>>> scattered across many (often unrelated) files.
> > >>>>>
> > >>>>> Implement a new, modern and simplified timer driver and put it in=
to
> > >>>>> drivers/clocksource. We still need to support legacy board files =
so
> > >>>>> export a config structure and a function that allows machine code=
 to
> > >>>>> register the timer.
> > >>>>>
> > >>>>> The timer we're using is 64-bit but can be programmed in dual 32-=
bit
> > >>>>> mode (both chained and unchained). We're using dual 32-bit mode t=
o
> > >>>>> have separate counters for clockevents and clocksource.
> > >>>>>
> > >>>>> This patch contains the core code and support for clockevent. The
> > >>>>> clocksource code will be included in a subsequent patch.
> > >>>>>
> >
> > [ ... ]
> >
> > >>>>> +static unsigned int
> > >>>>> +davinci_clockevent_read(struct davinci_clockevent *clockevent,
> > >>>>> +                     unsigned int reg)
> > >>>>> +{
> > >>>>> +     return readl_relaxed(clockevent->base + reg);
> > >>>>> +}
> > >>>>> +
> > >>>>> +static void davinci_clockevent_write(struct davinci_clockevent *=
clockevent,
> > >>>>> +                                  unsigned int reg, unsigned int=
 val)
> > >>>>> +{
> > >>>>> +     writel_relaxed(val, clockevent->base + reg);
> > >>>>> +}
> > >>>>> +
> > >>>>> +static void davinci_tcr_update(void __iomem *base,
> > >>>>> +                            unsigned int mask, unsigned int val)
> > >>>>> +{
> > >>>>> +     davinci_tcr &=3D ~mask;
> > >>>>> +     davinci_tcr |=3D val & mask;
> > >>>>
> > >>>>
> > >>>> I don't see when the davinci_tcr is initialized.
> > >>>>
> > >>>
> > >>> It's set to 0x0 by the compiler and we're setting the register to 0=
x0
> > >>> in davinci_timer_init().
> > >>
> > >> Why did you need to readl before in the previous version? The idea o=
f
> > >> caching the value was to save an extra readl.
> > >>
> > >> If it is always zero, then we don't need this variable neither the r=
ead,
> > >> just doing:
> > >>
> > >> writel_relaxed(val & mask, base + DAVINCI_TIMER_REG_TCR);
> > >>
> > >> should work no ?
> > >
> > > It's not always zero. Its reset value is zero and we write 0 to it at
> > > init time just to make sure, but then we modify it according to the
> > > configuration. The single TCR register controls both halves of the
> > > timer, so we do need an actual update, not a simple write.
> >
> > Ok but the driver can be oneshot or disabled in the code (mutually
> > exclusive), no ?
> >
> > So doing
> >
> >  - writel(oneshot, base);
> >  - writel(disabled, base);
> >
> > works without any mask computation, no?
> >
> > Well the above assumes other part of the register aren't changed by
> > other subsystems (or by the timer itself).
> >
> >
>
> I'm not sure I understand. You can be using two timers. Both
> controlled by a single TCR register. In your example oneshot can equal
> (0x00, or 0x01) and either be shifted left by 6 or 22 for TIM12 and
> TIM34 respectively. If you do writel(oneshot-for-time12, base) you'll
> set tim34 to disabled.
>
> Bart

Gentle ping.

Bart
