Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6DC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB41206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uMSa9ByB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfIQHyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:54:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43161 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfIQHyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:54:46 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so5297095iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MfI2BUn+6tqfZ16hSgU4bHuPAnYWosgljP1K/jNAUk=;
        b=uMSa9ByBd5dZn3HsLuGCW9jH2ynOvuqc23ArZOwf1C/HIYpOHrBluhzFD8ADkdFMXz
         6eK4kgbEp8EleCubq0fuMB8+TN9Z6jXgudV9sh9FiGXJRkU6cONyLwhb1sdkzctHfmwS
         vn5bbrOIuwN7fQPHJ8GE4IwGJwW1AS5MD9ymqcpDE/Kl6aGzvuAgojp5qXBGPkTy381b
         bT+dtwnV3I+2eHpueB2qB45h2GiMFjVbHyXfyJCz1M0vP/3hyD5iHrBKMqtynSf16Lvr
         njj4zxLBH3o8Hn38PgmMS/XL7i/G4KGkWxZ+S+iJAUyYer70u3Une0N0F+33PIhSlWpf
         ks8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MfI2BUn+6tqfZ16hSgU4bHuPAnYWosgljP1K/jNAUk=;
        b=UnlZ+xm+oqldi8Vms+AeEgP7vPT6EVKKQSYUENOBQYcQDexGwQUpRAddPaBEF7FC0P
         tYz4FTx4vBnABZKEZ/BgowN7p1AJWZFehYYYfuZ0Ba/FXcMoxYzw62bY86E5BV6ZFojt
         jtVRumvBl9K5HH3rUyq5cIHbkmN7gEu71E/ppErJIn3S2c2rDyWKAc2ZfxOAh7H0dTw4
         5a0CxOdE+qWcjCycUEOUKrYHIK4GwWsDNckt8Antw9O/bJ0Y3TwhrA1HcVlIx5IwAa/r
         S+/nhkHo75EbVMyGPL0vHOzWfLDJwdS408ZmDQp/Y2ycb0gVzpUfd1mjkftOUSbiErQx
         0Eog==
X-Gm-Message-State: APjAAAUrftpHKes9lusNAnNg58KxtCR7iH2YwCMECICZrD4epEp8ZHxI
        XeClK7yEU9m9impxPDMB+158Nfo51fK0NHLIWNyVtg==
X-Google-Smtp-Source: APXvYqzfQRdRcLd1AmR8/Xf9ghepmEm4SZPhipAhHDDsodyVeRELgDj/x9aWD3G9GvAhm9/RLC+GNr8XU2CDUKFGF84=
X-Received: by 2002:a5e:a812:: with SMTP id c18mr2251967ioa.220.1568706885178;
 Tue, 17 Sep 2019 00:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190910082138.30193-1-brgl@bgdev.pl>
In-Reply-To: <20190910082138.30193-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Sep 2019 09:54:34 +0200
Message-ID: <CAMRc=MdtN9E7dP1eSgC52oa7eQ_2HTo6gf9s1cgoxS=j57CK-Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't clear FLAG_IS_OUT when emulating open-drain/open-source
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 wrz 2019 o 10:22 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When emulating open-drain/open-source by not actively driving the output
> lines - we're simply changing their mode to input. This is wrong as it
> will then make it impossible to change the value of such line - it's now
> considered to actually be in input mode. If we want to still use the
> direction_input() callback for simplicity then we need to set FLAG_IS_OUT
> manually in gpiod_direction_output() and not clear it in
> gpio_set_open_drain_value_commit() and
> gpio_set_open_source_value_commit().
>
> Fixes: c663e5f56737 ("gpio: support native single-ended hardware drivers"=
)
> Cc: stable@vger.kernel.org
> Reported-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpiolib.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cca749010cd0..6bb4191d3844 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2769,8 +2769,10 @@ int gpiod_direction_output(struct gpio_desc *desc,=
 int value)
>                 if (!ret)
>                         goto set_output_value;
>                 /* Emulate open drain by not actively driving the line hi=
gh */
> -               if (value)
> -                       return gpiod_direction_input(desc);
> +               if (value) {
> +                       ret =3D gpiod_direction_input(desc);
> +                       goto set_output_flag;
> +               }
>         }
>         else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
>                 ret =3D gpio_set_config(gc, gpio_chip_hwgpio(desc),
> @@ -2778,8 +2780,10 @@ int gpiod_direction_output(struct gpio_desc *desc,=
 int value)
>                 if (!ret)
>                         goto set_output_value;
>                 /* Emulate open source by not actively driving the line l=
ow */
> -               if (!value)
> -                       return gpiod_direction_input(desc);
> +               if (!value) {
> +                       ret =3D gpiod_direction_input(desc);
> +                       goto set_output_flag;
> +               }
>         } else {
>                 gpio_set_config(gc, gpio_chip_hwgpio(desc),
>                                 PIN_CONFIG_DRIVE_PUSH_PULL);
> @@ -2787,6 +2791,17 @@ int gpiod_direction_output(struct gpio_desc *desc,=
 int value)
>
>  set_output_value:
>         return gpiod_direction_output_raw_commit(desc, value);
> +
> +set_output_flag:
> +       /*
> +        * When emulating open-source or open-drain functionalities by no=
t
> +        * actively driving the line (setting mode to input) we still nee=
d to
> +        * set the IS_OUT flag or otherwise we won't be able to set the l=
ine
> +        * value anymore.
> +        */
> +       if (ret =3D=3D 0)
> +               set_bit(FLAG_IS_OUT, &desc->flags);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_direction_output);
>
> @@ -3147,8 +3162,6 @@ static void gpio_set_open_drain_value_commit(struct=
 gpio_desc *desc, bool value)
>
>         if (value) {
>                 err =3D chip->direction_input(chip, offset);
> -               if (!err)
> -                       clear_bit(FLAG_IS_OUT, &desc->flags);
>         } else {
>                 err =3D chip->direction_output(chip, offset, 0);
>                 if (!err)
> @@ -3178,8 +3191,6 @@ static void gpio_set_open_source_value_commit(struc=
t gpio_desc *desc, bool value
>                         set_bit(FLAG_IS_OUT, &desc->flags);
>         } else {
>                 err =3D chip->direction_input(chip, offset);
> -               if (!err)
> -                       clear_bit(FLAG_IS_OUT, &desc->flags);
>         }
>         trace_gpio_direction(desc_to_gpio(desc), !value, err);
>         if (err < 0)
> --
> 2.21.0
>

Queued for fixes.

Bart
