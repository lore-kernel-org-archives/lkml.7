Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB52064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LdOpa9Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfJVJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:30:07 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43988 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfJVJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:30:07 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so14746994ilh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gRw/ujH5u+b+betdi1nevIIXphQLiCiSZDxUemHbO5Y=;
        b=LdOpa9KudKtIQ1kwtW9TBTIbnrBV/5NDwJYnFxW9fcRQouTABSwSE8KioMNdgsfG7N
         2PyMKz5c0JbgWMRUMjjnlK4ymZOGwR6QmDjnd+V/uOaVR0FN03WxSx4BcRDaEtUm3Hv9
         qlgI2ZOPms0DaZl5N9iumojS7tf8rYqvYTJh5+cE9cif3yFh9mG4aQNEH38it05RMUZk
         5VYiZP94/rSancG4fLtvR0W6zoO/dNeEjIo2xkxkte2BfBwWOs71csXFypYSQ5KCfgYD
         hT0Cm2eTZfzJuVaA7tBpcmz1V9OgffOifH5VOzcFYPkWpXVww1Qr2IiJBIbZNYOj5JYF
         mINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gRw/ujH5u+b+betdi1nevIIXphQLiCiSZDxUemHbO5Y=;
        b=FjrxpZondyIJKvrO7Ihg07UiFehYvpGNnz4Y8WagYJ4qtnx3y6bLxGvRMkltRjBswm
         cwmtBguoklCNJRGRTm97AQAOoEy1TJZXXUgPJb0A1uqo6cbV1YZRZOzAJ65eiPLgTin8
         5/PpI/BVLxD8CxTMhjFcFHlq3SKCn77h1b82mLHzp3oAecmN3QxasFFKTt4/FzWZPxBT
         fJm4JicFrM6FnacjlE2Jn71Z301MMV9/3UypGCd8X7LaQ+5LEEyA3/f7r7fBLTrRZ9Dt
         l5aACxPbn7GrtzaFu2hJa1HjF4NlE70Ais98P+SZmmp+l7uWkaGG45ayNYQlcD5WVkZM
         ofzA==
X-Gm-Message-State: APjAAAV1XKlquHZfIu1HshEESi4R4OK9449Lj+xDz+bnnmN4L2BVfxtF
        x/WUo+lLKbzVxP2eiBcUqZ0i5sN0j50wc3+2LvdD0g==
X-Google-Smtp-Source: APXvYqwTEhbQMpuSFs84r7ugo4qVLnztGVLVZqVacNzBI0++y9xiHUd6bZtP+cs8fky9bkg68mB86FgAHUkM9Po/7lo=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr31495749iln.6.1571736605168;
 Tue, 22 Oct 2019 02:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191022083630.28175-1-brgl@bgdev.pl>
In-Reply-To: <20191022083630.28175-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 22 Oct 2019 11:29:54 +0200
Message-ID: <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 22 pa=C5=BA 2019 o 10:36 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
>
> First two patches contain minor fixes. Third patch makes the driver
> explicitly drive the GPIO line. Fourth patch adds all necessary data
> structures to ecovec24. Patch 5/9 unifies much of the code for both
> pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> fields. Last two patches contain additional improvements for the GPIO
> backlight driver while we're already modifying it.
>
> I don't have access to this HW but hopefully this works. Only compile
> tested.
>
> [1] https://lkml.org/lkml/2019/6/25/900
>
> v1 -> v2:
> - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> - added additional two patches with minor improvements
>
> v2 -> v3:
> - in patch 7/7: used initializers to set values for pdata and dev local v=
ars
>
> v3 -> v4:
> - rebased on top of v5.4-rc1
> - removed changes that are no longer relevant after commit ec665b756e6f
>   ("backlight: gpio-backlight: Correct initial power state handling")
> - added patch 7/7
>
> v4 -> v5:
> - in patch 7/7: added a comment replacing the name of the function being
>   pulled into probe()
>
> v5 -> v6:
> - added a patch making the driver explicitly set the direction of the GPI=
O
>   to output
> - added a patch removing a redundant newline
>
> v6 -> v7:
> - renamed the function calculating the new GPIO value for status update
> - collected more tags
>
> Bartosz Golaszewski (9):
>   backlight: gpio: remove unneeded include
>   backlight: gpio: remove stray newline
>   backlight: gpio: explicitly set the direction of the GPIO
>   sh: ecovec24: add additional properties to the backlight device
>   backlight: gpio: simplify the platform data handling
>   sh: ecovec24: don't set unused fields in platform data
>   backlight: gpio: remove unused fields from platform data
>   backlight: gpio: use a helper variable for &pdev->dev
>   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
>
>  arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
>  drivers/video/backlight/gpio_backlight.c     | 128 +++++++------------
>  include/linux/platform_data/gpio_backlight.h |   3 -
>  3 files changed, 69 insertions(+), 95 deletions(-)
>
> --
> 2.23.0
>

Lee, Daniel, Jingoo,

Jacopo is travelling until November 1st and won't be able to test this
again before this date. Do you think you can pick it up and in case
anything's broken on SH, we can fix it after v5.5-rc1, so that it
doesn't miss another merge window?

Bart
