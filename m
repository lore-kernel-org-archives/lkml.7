Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D3C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fXFbSidY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfHPPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:48:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46016 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHPPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:48:34 -0400
Received: by mail-io1-f66.google.com with SMTP id t3so7073897ioj.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/rVwYCxqOr6nRrp3LvLIcdjfULOr8AyFlrBXkong6Uc=;
        b=fXFbSidYUWUDlCh4xn1T/uZ5jLY9vlVpMj5VEkuiqHXz+qMOCKxapObfLA3nEgPC7R
         vbKAhlMWcM4J+Eji7i5R6bwo4AeGu9fnIYkpCAzv8oSULwGLPD3LqKmsHrjooKwmPZlg
         CPFFPDdRWkrJe6ua3OTZ34Gz1O0O8vSQoh64ZKeWJzsOfIgCrQ5x1SjgRLt2BFPW6eno
         miP6aVQIgyGJOM2QklUITTu5iuxab7KfiAgaTBKrd+U5OvNlNtDzA+RPScqKLXahRxhU
         onl3wAUB2zIim3HOXqpJCz4CfO6R/P8hrD8OguzyI92HPBSdWK0xd3s2kHKgHsp4TiYl
         +oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/rVwYCxqOr6nRrp3LvLIcdjfULOr8AyFlrBXkong6Uc=;
        b=V473gJHokorx5V0o8nz4VFvIEoywfAFfSPhmmN3ynjtwhrmCNaV2J6/x5dm41N9Woq
         nKBcZAVSqkKn6vFjewnysDOTjZQjVV22UqfDglW5RP64iJVndghX9mgOxaPLgkkmnKOO
         G6CQI+Hr+1wfx/Cnwr4arzbvDF36dOZNkewSRLw+2lBozPUI+yj0OIHMOwUH5Vq+5iND
         7n10Y3RnVeNmnJnTz4kBaYJL098Hyg+zEXqzBRRL2pj70P/TEwLmYtpL721YPrX24/C6
         b7COvOo9JtggbXq6SYGE9N+1JaZxlwr9WQsM//VsBfVHpRylWigqY37ZZpguwIcS/SCN
         eXJw==
X-Gm-Message-State: APjAAAWifUWYebvjGYvqao11Y7PuEu5E+0vINod9FLu0POufF2NF93nq
        1KuzCVVDqTOJL7fFp13l/YJkZQg2VbaVps+optLxVA==
X-Google-Smtp-Source: APXvYqxDOUjXB1ulEsmlyPghWdRmlQ4HyP8nZKAkjmZq4xfy7xXlP40N1L/haF2XUbz+0fYOxJqch8oW/Je12YfPMR8=
X-Received: by 2002:a5d:8457:: with SMTP id w23mr472306ior.189.1565970513627;
 Fri, 16 Aug 2019 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190724082508.27617-1-brgl@bgdev.pl> <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Aug 2019 17:48:22 +0200
Message-ID: <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 8 sie 2019 o 10:17 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> =C5=9Br., 24 lip 2019 o 10:25 Bartosz Golaszewski <brgl@bgdev.pl> napisa=
=C5=82(a):
> >
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
> > Bartosz Golaszewski (7):
> >   sh: ecovec24: add additional properties to the backlight device
> >   backlight: gpio: simplify the platform data handling
> >   sh: ecovec24: don't set unused fields in platform data
> >   backlight: gpio: remove unused fields from platform data
> >   backlight: gpio: remove dev from struct gpio_backlight
> >   backlight: gpio: remove def_value from struct gpio_backlight
> >   backlight: gpio: use a helper variable for &pdev->dev
> >
> >  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
> >  drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
> >  include/linux/platform_data/gpio_backlight.h |  3 -
> >  3 files changed, 44 insertions(+), 74 deletions(-)
> >
> > --
> > 2.21.0
> >
>
> Hi Rich, Yoshinori,
>
> can you ack the sh patches in this series?
>
> Bart

Ping.
