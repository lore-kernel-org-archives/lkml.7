Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF427CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B411D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yqzJO5yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfJUMVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:21:34 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38636 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:21:34 -0400
Received: by mail-il1-f194.google.com with SMTP id y5so11770439ilb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wnGtB4lj7QZakI4bXBl4LOnjDVuoS6i9juH0AaPHUsI=;
        b=yqzJO5yrEuZ0AujBs35LlMVgp6QrGyJjIObeyazkPjRn1j5wQVKWq6ySSs5n6N4uiw
         w7AvSYJxB4dwHnN4Ik35WPXIfmBuhe7CsdcgDCSBhAMZJYWjhfy5dXSqH5XFQGMRCiL7
         IDZuf7KHDhV7oNVgFuYj4nLiL3qZQdEK4nrMHqRbpO0nMszqcZGhHNGy/GBtrkmkYzAL
         yXeyd+jUgvOFi1sZvsBGEwDj2CQv2SACk7Dp90Yp6dxMObXcSZ58Nk2OSFEIQIPF4hSy
         Xtzxus/dbLmFmsv9pIP40s+WzRnsGXN55Dx17Z3AwLupEnMqRwCTVQozron87CbKuu/n
         mb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wnGtB4lj7QZakI4bXBl4LOnjDVuoS6i9juH0AaPHUsI=;
        b=F+E7uy5ig1cRr8xXTWJwy7l1WW+5HU3ZvwkQbj1acBpfXHDcMSxQNJsnOXkD3/zK9o
         4g/6GO8ALVezCYbtj7KL98BsvbMNhH7VZi1cVfd5+WF7dLMDuS55BCRVLdRYWwsG1GwL
         5t5DOemihOgOyprDI/6Wv8Hwh5zJ5wXfwb9znVntdRhAsWZA/hNqPJOGnqejWBtpQQy7
         Jtu24nVjla71NL0Z3qtXFvGsiIhlv3k/vZ45f2NgFobR1uiSLzH2eQXUg4oe/uIioByT
         fWdPQPP1E6Vk6rB0r2xF47vkCmFFwmWrmHWVKgOHqV2GDUvjhPYtSixCkrpMWgmQgr94
         0Eeg==
X-Gm-Message-State: APjAAAUhueUCE61+qG594h5CuOBx5AIURuu2RU/pfsWBBYeXexOgC8ZT
        GXwpHIhln9AqRLUPopCBwCCr7aeic+y3OuT86owb/A==
X-Google-Smtp-Source: APXvYqxYqbLQZbfxUfYl5IZ0yaJHH03rYbBNlFarkoXOb5pIu+StSQSkslvJykiuWugAbTzjBnKJwDiNY2bcVyEpgSA=
X-Received: by 2002:a92:410c:: with SMTP id o12mr25941800ila.287.1571660492888;
 Mon, 21 Oct 2019 05:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191019083556.19466-1-brgl@bgdev.pl> <20191019083556.19466-4-brgl@bgdev.pl>
 <20191021104509.p2bsll3rwe7ica6t@holly.lan>
In-Reply-To: <20191021104509.p2bsll3rwe7ica6t@holly.lan>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Oct 2019 14:21:21 +0200
Message-ID: <CAMRc=Md99q+67FAduiixQQs6BVtLXNrC=KbicsuBsB2Jp4O7dw@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] backlight: gpio: explicitly set the direction of
 the GPIO
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
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

pon., 21 pa=C5=BA 2019 o 12:45 Daniel Thompson <daniel.thompson@linaro.org>
napisa=C5=82(a):
>
> On Sat, Oct 19, 2019 at 10:35:50AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The GPIO backlight driver currently requests the line 'as is', without
> > acively setting its direction. This can lead to problems: if the line
> > is in input mode by default, we won't be able to drive it later when
> > updating the status and also reading its initial value doesn't make
> > sense for backlight setting.
> >
> > Request the line 'as is' initially, so that we can read its value
> > without affecting it but then change the direction to output explicitly
> > when setting the initial brightness.
> >
> > Also: check the current direction and only read the value if it's outpu=
t.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Intent looks good to me but...
>
> > ---
> >  drivers/video/backlight/gpio_backlight.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/b=
acklight/gpio_backlight.c
> > index 3955b513f2f8..a36ac3a45b81 100644
> > --- a/drivers/video/backlight/gpio_backlight.c
> > +++ b/drivers/video/backlight/gpio_backlight.c
> > @@ -25,9 +25,8 @@ struct gpio_backlight {
> >       int def_value;
> >  };
> >
> > -static int gpio_backlight_update_status(struct backlight_device *bl)
> > +static int gpio_backlight_get_curr_brightness(struct backlight_device =
*bl)
>
> This function does not get the current brightness (e.g. what the
> hardware is currently doing). Given we've just nuked the function that
> *did* get the current brightness from the hardware this isn't an
> acceptable name.
>
> Would like something like calc_brightness() or get_next_brightness().
>

Fair enough, the latter sounds good in this case.

Bart
