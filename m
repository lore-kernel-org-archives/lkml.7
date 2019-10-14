Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64964C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392C220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JK9+D8JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJNIQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:16:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43915 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfJNIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:16:05 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so36058020iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t44CqyvdXypuwtzNTJ7ymJovfCkTaCpIACjq52B13FE=;
        b=JK9+D8JY6bxWRDbYtmDx//zrK7L0P5ZaJiOA1u2JTy/ek0rC1FVjF5jbx8SF6OPnwM
         y36p/5at+welqaHGrpeciApYazXiC0HEwjfvfqfT75fnauattpvVQgA5+JjHIIw5Epe+
         BFm5EzGuJgp3mNjZOZTQrvS0bqwWhoOVOOhDa7eYnntod0vH1L3sRwunV3OTS7MhWLLR
         bdBgCHLnxqmC6n+VjUzcb/2EDArfWypGehE2YtuxWMKu51XpQg4M8+T5JmjUUPVxT/eV
         scRYIVaE5rhUNQtV8KHYgGmvdShVcQqKfqdI907x6Kf447HKopmeuc22GHcH8S+3lmxp
         6hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t44CqyvdXypuwtzNTJ7ymJovfCkTaCpIACjq52B13FE=;
        b=fhsr0Maud5uGwIBEw+hRh+v3tZLoZnKWvjo3xd07n3Sm+AYoX9CWfQml8lrJMC+PUa
         EJ5qwACvngjgjhOdz7tOcntixbXj9NFQteXHaFRN/4PJhPaeZeGHGo8N77XWyRXbsDdV
         40pjAQRlYSyTVN6p7E9JCmDo0ee6VFPyccFPTb5RU0vzZb3feKBzjWBWva18BaAbaK5f
         UXQ4Ijsjm6GeEkN29QrjdHIf8DRfVKNOJhFJf9djhdOWWvX90ZsbDg9NA3aMiH5gWIe7
         kDrwSzxVxABl/lRnAOw5Orqtzad9Aj94SIPHh5t+wwdDzeMQlwhxYbJTlCfwFE/K3cp4
         yB4w==
X-Gm-Message-State: APjAAAVFEEW0Z7OqDrRGUaZ8skGwh7/W9nsVQUUr3uvtzypfjI1yRWhP
        w9L95D+woyq9KUAPy2yFZr+zGfLPrEzCcCUdsCUGpQ==
X-Google-Smtp-Source: APXvYqwLQ8EL+87kFnJZAnOI6uFthuTZJqtrvmnMJN6wDA31bnQPrVHdctZs00tKOaFLcdTgP9uegvfD+UtrZuLktaY=
X-Received: by 2002:a05:6602:248e:: with SMTP id g14mr19829138ioe.6.1571040964440;
 Mon, 14 Oct 2019 01:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191007033200.13443-1-brgl@bgdev.pl> <20191014081220.GK4545@dell>
In-Reply-To: <20191014081220.GK4545@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Oct 2019 10:15:53 +0200
Message-ID: <CAMRc=MfSiJY-85ZHM_aSxUDc6LkbG1FidRFgTHtbZy6hHiQ+iw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
To:     Lee Jones <lee.jones@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 pa=C5=BA 2019 o 10:12 Lee Jones <lee.jones@linaro.org> napisa=C5=
=82(a):
>
> On Mon, 07 Oct 2019, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While working on my other series related to gpio-backlight[1] I noticed
> > that we could simplify the driver if we made the only user of platform
> > data use GPIO lookups and device properties. This series tries to do
> > that.
> >
> > The first patch adds all necessary data structures to ecovec24. Patch
> > 2/7 unifies much of the code for both pdata and non-pdata cases. Patche=
s
> > 3-4/7 remove unused platform data fields. Last three patches contain
> > additional improvements for the GPIO backlight driver while we're alrea=
dy
> > modifying it.
> >
> > I don't have access to this HW but hopefully this works. Only compile
> > tested.
> >
> > [1] https://lkml.org/lkml/2019/6/25/900
> >
> > v1 -> v2:
> > - rebased on top of v5.3-rc1 and adjusted to the recent changes from An=
dy
> > - added additional two patches with minor improvements
> >
> > v2 -> v3:
> > - in patch 7/7: used initializers to set values for pdata and dev local=
 vars
> >
> > v3 -> v4:
> > - rebased on top of v5.4-rc1
> > - removed changes that are no longer relevant after commit ec665b756e6f
> >   ("backlight: gpio-backlight: Correct initial power state handling")
> > - added patch 7/7
> >
> > v4 ->V5:
> > - in patch 7/7: added a comment replacing the name of the function bein=
g
> >   pulled into probe()
> >
> > Bartosz Golaszewski (7):
> >   backlight: gpio: remove unneeded include
> >   sh: ecovec24: add additional properties to the backlight device
> >   backlight: gpio: simplify the platform data handling
> >   sh: ecovec24: don't set unused fields in platform data
> >   backlight: gpio: remove unused fields from platform data
> >   backlight: gpio: use a helper variable for &pdev->dev
> >   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
> >
> >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
>
> I guess we're just waiting for the SH Acks now?
>

We've been waiting for them for a couple months now - the sh patches
haven't changed since v1...

Rich, Yoshinori - could you ack this so that it can go in for v5.5?

Thanks,
Bartosz

> >  drivers/video/backlight/gpio_backlight.c     | 108 +++++--------------
> >  include/linux/platform_data/gpio_backlight.h |   3 -
> >  3 files changed, 53 insertions(+), 91 deletions(-)
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
