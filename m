Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A32C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28EB2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozWXkWyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKPPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:36:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfKPPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:36:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so14167660wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbnEz2iLp0S1UHHj6E2CggW0R84FXQGiB2UBE1fi4DM=;
        b=ozWXkWyG3A5cGq+w9YTKCVqzCTjQ8/pABQLRwTEnuJfl/Tp871sIjQmSrxnJGEh08Y
         YrRkxaBl5mLQmDGsDD+Z4bLJNvXWRzz4y+T/NmM6Ys+XlyCgjCwoG5ZuK55SzHUaITA4
         blWvky3lGUjj0bogjQfjkjd+Lwpm0nC75cIgsf3JUvR/CaWS0aIl9Icbi5uy+NrhJi3h
         +xXQ1dQs/EEJYNRm0wBFJ/HcFq6OpaP2w+OKLOeXWdQpIlg9I+DzElRS5whsbHO4p1Se
         AZdBF7jdJ7sbB/w/VA4PIZeIxwYy/jm37DHbEwlOLgdD1OB3262csK72wAYffMvZBY0a
         mQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbnEz2iLp0S1UHHj6E2CggW0R84FXQGiB2UBE1fi4DM=;
        b=WI2/qTEk94+3vgW9yb8wWP6shsDrEcissOJ8M0Kx/kD5Mc4u4WUSmBxFVle82akYsv
         OG17RvHS2AH5eQceSagfkK9nHWapBAwRZVuW3NGbAfihdIifSBRanKJgDalvbGV53YdR
         l+5i9y7L0wjCpZlfLqfYZK5om1wJ6OfvODT+INTG/sHwpEhDbSx94odC098ZLkvJLTno
         oIAk+woIZsbNw42S47uxcK4cAWgEZl3poLWAkSQQnmkTayD1XttW+X+X48S/dxnsWlf4
         RoVfm6iX+g3WJGXUSNw1asXR0ZlaxfF2NkbDEAlniyxp49lcnT/qK/LFbkQuV6zDgiic
         ruaw==
X-Gm-Message-State: APjAAAXg6VR7jNELUsW4mT1G1THFre6GV5s0XVwVGYK9biwNu9KL6XYD
        tsawE99aLINreoy6S8XQdgRc7vakd71iD8kC+/6ySQ==
X-Google-Smtp-Source: APXvYqxM2t9raNDMK+NqCtMfmH9YSp0S1xJvHcg9AcRqIffms5FAXbS0KfhTtU5aXbUuBpruq71GwhjlcLcahEQ2KiQ=
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr12115894wra.246.1573918565380;
 Sat, 16 Nov 2019 07:36:05 -0800 (PST)
MIME-Version: 1.0
References: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com> <CAKv+Gu_r2Cb3d3OXaOdYy+4V9noL6exJoK6pHevUm2WfPzsr1g@mail.gmail.com>
 <20191116104932.GT25745@shell.armlinux.org.uk>
In-Reply-To: <20191116104932.GT25745@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 16 Nov 2019 16:35:53 +0100
Message-ID: <CAKv+Gu-uTGi2YHdtWDcCi4n7KbVJ39X-s3OkQTxm6tDA_Q7Ahg@mail.gmail.com>
Subject: Re: rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2019 at 11:49, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Nov 16, 2019 at 10:26:27AM +0000, Ard Biesheuvel wrote:
> > (+ Arnd)
> >
> > On Sat, 16 Nov 2019 at 05:54, kernelci.org bot <bot@kernelci.org> wrote:
> > >
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > * This automated bisection report was sent to you on the basis  *
> > > * that you may be involved with the breaking commit it has      *
> > > * found.  No manual investigation has been done to verify it,   *
> > > * and the root cause of the problem may be somewhere else.      *
> > > *                                                               *
> > > * If you do send a fix, please include this trailer:            *
> > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > *                                                               *
> > > * Hope this helps!                                              *
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > >
> > > rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
> > >
> > > Summary:
> > >   Start:      b6c3c42cfda0 ARM: 8938/1: kernel: initialize broadcast hrtimer based clock event device
> > >   Details:    https://kernelci.org/boot/id/5dcf3f0359b514dc84cf54c8
> > >   Plain log:  https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.txt
> > >   HTML log:   https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.html
> > >   Result:     ea70bf6e92c5 ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
> > >
> >
> > OK, so this regression is caused by the fact that the 'armv7' cache
> > maintenance routines in the decompressor are also used for ARMv6 cores
> > if they implement the CPUID extension, which I failed to realise when
> > I sent this patch.
> >
> > There are roughly three ways to deal with this:
> > 1) add a mask/val match pair for ARM11MPcore and ARM1176 that hardwire
> > them to the ARMv6 routines, even though they implement the CPUID
> > extension. This would be very easy, but assumes that those two cores
> > are the only ones that are affected by this.
> > 2) modify the v7 routines to check for the L1Hvd MMFR1 attribute (in
> > the flush routine) and for the CP15BEN SCTLR bit (in the on/off
> > routines), and jump to the respective v6 variants if the CPU turns out
> > not to support the v7 one.
> > 3) revert the patch, and just enable the CP15 barriers (and issue a v7
> > barrier) in the v7 on() and flush() routines.
> >
> > I am leaning towards the latter, since it is the most straightforward,
> > even though it mixes v7 and cp15 barriers in the same function, but
> > that was mostly a cosmetic concern anyway.
>
> I'm going to drop the patches - if -rc8 is released tomorrow maybe we
> can have a go at solving it next week.
>

Fair enough.
