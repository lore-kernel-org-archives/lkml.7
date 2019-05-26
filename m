Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F6C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E22075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 08:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YUGEq/ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfEZIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 04:16:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33197 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEZIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 04:16:47 -0400
Received: by mail-it1-f196.google.com with SMTP id j17so14689071itk.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xjDVW4ItsMdn0KgPfwxOYy40rJX/wc+PFxqfPBiNPQ=;
        b=YUGEq/caM4ivcKxNRTadkbp2V83qUOwbxQvgGaMOGoJpyfhGFhA7KfDstIXJtlPg6Q
         UPaiJEsQA5CsVs2CCvz023dOEMnKq1XNAHXCFDRKNNcG+d7CG65oAYgX2+gR2JaCEpMr
         kv0rABKTgWxEvPxnie65Hk97liwFL+jeNme/rnHg/B48F+K0vqn5RMNIkayFKpEmVW/R
         XNkb4dT0JFEFIPsmAsPCTmQPTE4o6N469KWbHslvipqCrjTgxfxcBRfPbNcEm5nymVma
         JBipPCJa4MCkDnzafeO6e4NsHWUz92gpsmSCgVRi5gui510jBNLmvAH4H0HCzy5KEEO4
         ndWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xjDVW4ItsMdn0KgPfwxOYy40rJX/wc+PFxqfPBiNPQ=;
        b=Zob81wXfeRIgngF0q+EIOvQpdFn7/9G6CJ4rgols+NTOqXoiEfxiVASzsSKpIBi7d+
         Ug/W3OVCg+MYybmUg/+DCxR/q321GuM+Ld860lN5nBReRu8fj2HUjZ0KX5iMQP+CZgmu
         3kp9xGq1x/wv5gnLbmYCH3oMrVgM3OmKCj1w1PFKAX56BWvvX2scZhvsVEpjvfvbDf4H
         KZueV6WYXXxrT0L3E7zciIHXpcBHQEpXj7C+kEPYb9EfLCu/vqQ0Bj85Foh2nWS5K7Br
         CFDaXmu9fX0UFZOz9qMfMj/bYpMT1sric/3On5JEULCd6srjVpwg11ZDmFBJQ+bjl1ty
         5viA==
X-Gm-Message-State: APjAAAWS4JVjd2tvHyjcdkGprh4luL+sA+EcdKylV9u22LPZ0DEXQpeI
        NUlJql6Wsy4bq86J3sbGb7Vj1Q6DRttIMErX9b+9NA==
X-Google-Smtp-Source: APXvYqwBjd6nuMsqoYDspPt3JLyslN/KOvPirQqYRZlPd9BEe17+YaYcLbclALwDs1PeN3fYdZ3o8N6iFxazetw3K/w=
X-Received: by 2002:a02:1986:: with SMTP id b128mr75479151jab.136.1558858605958;
 Sun, 26 May 2019 01:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190523125813.29506-1-brgl@bgdev.pl> <20190523125813.29506-2-brgl@bgdev.pl>
 <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org> <CAMRc=MfUFE_yBSqS-s4fVcU9W11Amgeer-eXWNBrkG0Z7KD4tA@mail.gmail.com>
 <5f513fdc-7768-43b8-9d0c-56f07a60768f@linaro.org> <CAMRc=MeFMQ9rz-=8GktGtaQm1j-X66RsCBTqR3-mofc4Bju8-w@mail.gmail.com>
 <a4585f30-5fa7-7fde-bbbd-c32464c0f060@linaro.org>
In-Reply-To: <a4585f30-5fa7-7fde-bbbd-c32464c0f060@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 26 May 2019 10:16:34 +0200
Message-ID: <CAMRc=Mcx55yJ2HmTi7ui4sxa5L+Fwgudra-chaxgYccgg8Vtfw@mail.gmail.com>
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

sob., 25 maj 2019 o 16:16 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 24/05/2019 13:53, Bartosz Golaszewski wrote:
> > pt., 24 maj 2019 o 10:59 Daniel Lezcano <daniel.lezcano@linaro.org> nap=
isa=C5=82(a):
> >>
> >> On 24/05/2019 09:28, Bartosz Golaszewski wrote:
> >>> czw., 23 maj 2019 o 18:38 Daniel Lezcano <daniel.lezcano@linaro.org> =
napisa=C5=82(a):
> >>>>
> >>>> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
> >>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>>
> >>>>> Currently the clocksource and clockevent support for davinci platfo=
rms
> >>>>> lives in mach-davinci. It hard-codes many things, uses global varia=
bles,
> >>>>> implements functionalities unused by any platform and has code frag=
ments
> >>>>> scattered across many (often unrelated) files.
> >>>>>
> >>>>> Implement a new, modern and simplified timer driver and put it into
> >>>>> drivers/clocksource. We still need to support legacy board files so
> >>>>> export a config structure and a function that allows machine code t=
o
> >>>>> register the timer.
> >>>>>
> >>>>> The timer we're using is 64-bit but can be programmed in dual 32-bi=
t
> >>>>> mode (both chained and unchained). We're using dual 32-bit mode to
> >>>>> have separate counters for clockevents and clocksource.
> >>>>>
> >>>>> This patch contains the core code and support for clockevent. The
> >>>>> clocksource code will be included in a subsequent patch.
> >>>>>
>
> [ ... ]
>
> >>>>> +static unsigned int
> >>>>> +davinci_clockevent_read(struct davinci_clockevent *clockevent,
> >>>>> +                     unsigned int reg)
> >>>>> +{
> >>>>> +     return readl_relaxed(clockevent->base + reg);
> >>>>> +}
> >>>>> +
> >>>>> +static void davinci_clockevent_write(struct davinci_clockevent *cl=
ockevent,
> >>>>> +                                  unsigned int reg, unsigned int v=
al)
> >>>>> +{
> >>>>> +     writel_relaxed(val, clockevent->base + reg);
> >>>>> +}
> >>>>> +
> >>>>> +static void davinci_tcr_update(void __iomem *base,
> >>>>> +                            unsigned int mask, unsigned int val)
> >>>>> +{
> >>>>> +     davinci_tcr &=3D ~mask;
> >>>>> +     davinci_tcr |=3D val & mask;
> >>>>
> >>>>
> >>>> I don't see when the davinci_tcr is initialized.
> >>>>
> >>>
> >>> It's set to 0x0 by the compiler and we're setting the register to 0x0
> >>> in davinci_timer_init().
> >>
> >> Why did you need to readl before in the previous version? The idea of
> >> caching the value was to save an extra readl.
> >>
> >> If it is always zero, then we don't need this variable neither the rea=
d,
> >> just doing:
> >>
> >> writel_relaxed(val & mask, base + DAVINCI_TIMER_REG_TCR);
> >>
> >> should work no ?
> >
> > It's not always zero. Its reset value is zero and we write 0 to it at
> > init time just to make sure, but then we modify it according to the
> > configuration. The single TCR register controls both halves of the
> > timer, so we do need an actual update, not a simple write.
>
> Ok but the driver can be oneshot or disabled in the code (mutually
> exclusive), no ?
>
> So doing
>
>  - writel(oneshot, base);
>  - writel(disabled, base);
>
> works without any mask computation, no?
>
> Well the above assumes other part of the register aren't changed by
> other subsystems (or by the timer itself).
>
>

I'm not sure I understand. You can be using two timers. Both
controlled by a single TCR register. In your example oneshot can equal
(0x00, or 0x01) and either be shifted left by 6 or 22 for TIM12 and
TIM34 respectively. If you do writel(oneshot-for-time12, base) you'll
set tim34 to disabled.

Bart

>
>
>
>
>
>
>
>
>
> -- :
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
