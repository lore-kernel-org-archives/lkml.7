Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB450C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9870F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH1IhA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:37:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34014 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Ig7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:36:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so1992378otp.1;
        Wed, 28 Aug 2019 01:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Erove1KI2K6GKd3UFaZlGI+A1u6CspqOGbjftwYs2o=;
        b=RsOVHUV2rRGqeecVWFLG9J8HlcIjMgja8ncvY9XZYMOmqj2KbuMsTXW6ref0ZZpP8y
         O2sS5+di2RzdaHXQYtEIPQb5ok7KmnTxE3WKc4YceBZgbDRxCwsqoq0gCMFk2+jnnuzf
         l1HryWSif65yXT4d8xZATRsz/zGG6fWJOtq2S+VUBcWK8qh9ev9g/5dBjeChYh7nWdAx
         xFWy3iKBPVB2c73orPP7ivNKWHm4Ts4fH4rZY8D1D5vcT/uJbFuGmAisv3rbUaUmtWUR
         9d+C2SVBB6T3NfoMRVg4YmMWEx3YAsmlz3VNuX/ishcTDSlSWXSRGyu9lYshArLxZVa8
         g01Q==
X-Gm-Message-State: APjAAAVE0IS7InGjjN4TWjbhmOlxt6SEVZurGt01g+nMsCroWmPz4IbA
        1dj4tqQ5L0OwnGwsQLqPLQCAmPTAcBrYmb/QZig=
X-Google-Smtp-Source: APXvYqwTqVVwndN/cmFOt6L70c8aRtBjQJbRXGGSl1zhN+C4xJfXzPvGeTsPdgjseoyM2bIW2gDueQGp86hfFZCk314=
X-Received: by 2002:a9d:2cc:: with SMTP id 70mr2261989otl.145.1566981418736;
 Wed, 28 Aug 2019 01:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190724082508.27617-1-brgl@bgdev.pl> <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
 <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com> <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
In-Reply-To: <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Aug 2019 10:36:47 +0200
Message-ID: <CAMuHMdV3obGtQ7qohNedQNgpvZvyL9xjH0HUiBKD6b8Ou5F+XA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC the pour soul with the ecovec board.

On Wed, Aug 28, 2019 at 9:33 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> pt., 16 sie 2019 o 17:48 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > czw., 8 sie 2019 o 10:17 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > śr., 24 lip 2019 o 10:25 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > While working on my other series related to gpio-backlight[1] I noticed
> > > > that we could simplify the driver if we made the only user of platform
> > > > data use GPIO lookups and device properties. This series tries to do
> > > > that.
> > > >
> > > > The first patch adds all necessary data structures to ecovec24. Patch
> > > > 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> > > > 3-4/7 remove unused platform data fields. Last three patches contain
> > > > additional improvements for the GPIO backlight driver while we're already
> > > > modifying it.
> > > >
> > > > I don't have access to this HW but hopefully this works. Only compile
> > > > tested.
> > > >
> > > > [1] https://lkml.org/lkml/2019/6/25/900
> > > >
> > > > v1 -> v2:
> > > > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > > > - added additional two patches with minor improvements
> > > >
> > > > v2 -> v3:
> > > > - in patch 7/7: used initializers to set values for pdata and dev local vars
> > > >
> > > > Bartosz Golaszewski (7):
> > > >   sh: ecovec24: add additional properties to the backlight device
> > > >   backlight: gpio: simplify the platform data handling
> > > >   sh: ecovec24: don't set unused fields in platform data
> > > >   backlight: gpio: remove unused fields from platform data
> > > >   backlight: gpio: remove dev from struct gpio_backlight
> > > >   backlight: gpio: remove def_value from struct gpio_backlight
> > > >   backlight: gpio: use a helper variable for &pdev->dev
> > > >
> > > >  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
> > > >  drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
> > > >  include/linux/platform_data/gpio_backlight.h |  3 -
> > > >  3 files changed, 44 insertions(+), 74 deletions(-)
> > > >
> > > > --
> > > > 2.21.0
> > > >
> > >
> > > Hi Rich, Yoshinori,
> > >
> > > can you ack the sh patches in this series?
> > >
> > > Bart
> >
> > Ping.
>
> Hi,
>
> any chance of getting this reviewed for sh?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
