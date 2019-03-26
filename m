Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10742C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A522082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wm27p84C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfCZSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so12329744otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1f/wgHk1G0KMdN0zGlRW7w7SPBNS9OKMYj3xSW/FHOc=;
        b=wm27p84CfTnKS4qQJELdlF8EoxvU/SJHw6sOk+KzAqhhZrr4Zsq02P6JGAFkptUIqT
         nzq5mOU0/l3FCqrWS6URXqjvJLibgkz7mad/YIqGuMJto9V3x0O8UxN+92PiE8WmzCZz
         uNAEwGmqJ4b5SKYU3m1MiGdkJKRDRVBc5HBw5OUOURbrqMNHiFdoC7ZC6t8SY4eZ1Bs8
         44AqbDmE+iGIcCTa6pXYh+w2KO6aVK0m/jUh7IwV7rPLT/UaiKJTkbj3rDMkmWfVqNJV
         C5bSn9Ozzgdh9VvZUzAditbNM6LKAdKDdJDedj8XLGtC3tkkVsPF4oNE7GeiYmvjSmOo
         KdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1f/wgHk1G0KMdN0zGlRW7w7SPBNS9OKMYj3xSW/FHOc=;
        b=jY3wLkcUerc8KKRQckhML6YbjLAhmxd3TCn9X7KKnSq+MisQzNBRiXgKxtkcUOAMJk
         7HrCyj2dB64dJV8yGVw46CCal3ELMLlCIR4dRPdT8hMy+9ALM0PuOj9i7MPpLeX09OUd
         Pk2e5AMK/nMMBsmAFPCMb/m4JVPSFX0Sz+1BWjR9aKUdaglAVBtKXDx1xxQ3YUu5kGXS
         /dZEXEXcgrqWlexZCa+kNrx1tVjYWL53hM2S8Cq8L4+Dxi3gK2xAsf3uVEa6Qahm6Rvl
         Wx7td2T3NYYZwipa1zwdG3rAP5DPVWQODqs/fG66sIW8Zz0Pk9YMrJ5C9g1cr4BnjFCT
         BWNQ==
X-Gm-Message-State: APjAAAUoCHyxwhjTgYgJmzOXjF/GKME2wGlTgUxDuobMX0c7II9n89XO
        /xHL1OIGghon6Q5sObi6WHf+fFljuG4KURo6OWp/fA==
X-Google-Smtp-Source: APXvYqwsf+08eBcNlEbaC/jc/tENlTtO4Ahv2QZA85vbK/4vZ1ByUSZjBYRPzLLm5PFruuQWN3OEz1s2V31DHoyAP3M=
X-Received: by 2002:a9d:3635:: with SMTP id w50mr21679661otb.301.1553623585561;
 Tue, 26 Mar 2019 11:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190326044954.18671-1-andrew@aj.id.au>
In-Reply-To: <20190326044954.18671-1-andrew@aj.id.au>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 26 Mar 2019 19:06:14 +0100
Message-ID: <CAMpxmJWvL2q9+yExAwv7jZ+g9psv5-_p8B89gk_pzvHbHMdO+w@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: use new gpio_set_config() helper in more places"
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 mar 2019 o 05:50 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82(a):
>
> gpio-aspeed implements support for PIN_CONFIG_INPUT_DEBOUNCE. As of
> v5.1-rc1 we're seeing the following when booting a Romulus BMC kernel:
>
> > [   21.373137] ------------[ cut here ]------------
> > [   21.374545] WARNING: CPU: 0 PID: 1 at drivers/gpio/gpio-aspeed.c:834=
 unregister_allocated_timer+0x38/0x94
> > [   21.376181] No timer allocated to offset 74
> > [   21.377672] CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-rc1-dirty =
#6
> > [   21.378800] Hardware name: Generic DT based system
> > [   21.379965] Backtrace:
> > [   21.381024] [<80107d44>] (dump_backtrace) from [<80107f78>] (show_st=
ack+0x20/0x24)
> > [   21.382713]  r7:8038b720 r6:00000009 r5:00000000 r4:87897c64
> > [   21.383815] [<80107f58>] (show_stack) from [<80656398>] (dump_stack+=
0x20/0x28)
> > [   21.385042] [<80656378>] (dump_stack) from [<80115f1c>] (__warn.part=
.3+0xb4/0xdc)
> > [   21.386253] [<80115e68>] (__warn.part.3) from [<80115fb0>] (warn_slo=
wpath_fmt+0x6c/0x90)
> > [   21.387471]  r6:00000342 r5:807f8758 r4:80a07008
> > [   21.388278] [<80115f48>] (warn_slowpath_fmt) from [<8038b720>] (unre=
gister_allocated_timer+0x38/0x94)
> > [   21.389809]  r3:0000004a r2:807f8774
> > [   21.390526]  r7:00000000 r6:0000000a r5:60000153 r4:0000004a
> > [   21.391601] [<8038b6e8>] (unregister_allocated_timer) from [<8038baa=
c>] (aspeed_gpio_set_config+0x330/0x48c)
> > [   21.393248] [<8038b77c>] (aspeed_gpio_set_config) from [<803840b0>] =
(gpiod_set_debounce+0xe8/0x114)
> > [   21.394745]  r10:82ee2248 r9:00000000 r8:87b63a00 r7:00001388 r6:879=
47320 r5:80729310
> > [   21.396030]  r4:879f64a0
> > [   21.396499] [<80383fc8>] (gpiod_set_debounce) from [<804b4350>] (gpi=
o_keys_probe+0x69c/0x8e0)
> > [   21.397715]  r7:845d94b8 r6:00000001 r5:00000000 r4:87b63a1c
> > [   21.398618] [<804b3cb4>] (gpio_keys_probe) from [<8040eeec>] (platfo=
rm_dev_probe+0x44/0x80)
> > [   21.399834]  r10:00000003 r9:80a3a8b0 r8:00000000 r7:00000000 r6:80a=
7f9dc r5:80a3a8b0
> > [   21.401163]  r4:8796bc10
> > [   21.401634] [<8040eea8>] (platform_drv_probe) from [<8040d0d4>] (rea=
lly_probe+0x208/0x3dc)
> > [   21.402786]  r5:80a7f8d0 r4:8796bc10
> > [   21.403547] [<8040cecc>] (really_probe) from [<8040d7a4>] (driver_pr=
obe_device+0x130/0x170)
> > [   21.404744]  r10:0000007b r9:8093683c r8:00000000 r7:80a07008 r6:80a=
3a8b0 r5:8796bc10
> > [   21.405854]  r4:80a3a8b0
> > [   21.406324] [<8040d674>] (driver_probe_device) from [<8040da8c>] (de=
vice_driver_attach+0x68/0x70)
> > [   21.407568]  r9:8093683c r8:00000000 r7:80a07008 r6:80a3a8b0 r5:0000=
0000 r4:8796bc10
> > [   21.408877] [<8040da24>] (device_driver_attach) from [<8040db14>] (_=
_driver_attach+0x80/0x150)
> > [   21.410327]  r7:80a07008 r6:8796bc10 r5:00000001 r4:80a3a8b0
> > [   21.411294] [<8040da94>] (__driver_attach) from [<8040b20c>] (bus_fo=
r_each_dev+0x80/0xc4)
> > [   21.412641]  r7:80a07008 r6:8040da94 r5:80a3a8b0 r4:87966f30
> > [   21.413580] [<8040b18c>] (bus_for_each_dev) from [<8040dc0c>] (drive=
r_attach+0x28/0x30)
> > [   21.414943]  r7:00000000 r6:87b411e0 r5:80a33fc8 r4:80a3a8b0
> > [   21.415927] [<8040dbe4>] (driver_attach) from [<8040bbf0>] (bus_add_=
driver+0x14c/0x200)
> > [   21.417289] [<8040baa4>] (bus_add_driver) from [<8040e2b4>] (driver_=
register+0x84/0x118)
> > [   21.418652]  r7:80a60ae0 r6:809226b8 r5:80a07008 r4:80a3a8b0
> > [   21.419652] [<8040e230>] (driver_register) from [<8040fc28>] (__plat=
form_driver_register+0x3c/0x50)
> > [   21.421193]  r5:80a07008 r4:809525f8
> > [   21.421990] [<8040fbec>] (__platform_driver_register) from [<809226d=
8>] (gpio_keys_init+0x20/0x28)
> > [   21.423447] [<809226b8>] (gpio_keys_init) from [<8090128c>] (do_one_=
initcall+0x80/0x180)
> > [   21.424886] [<8090120c>] (do_one_initcall) from [<80901538>] (kernel=
_init_freeable+0x1ac/0x26c)
> > [   21.426354]  r8:80a60ae0 r7:80a60ae0 r6:8093685c r5:00000008 r4:8095=
25f8
> > [   21.427579] [<8090138c>] (kernel_init_freeable) from [<8066d9a0>] (k=
ernel_init+0x18/0x11c)
> > [   21.428819]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:000=
00000 r5:8066d988
> > [   21.429947]  r4:00000000
> > [   21.430415] [<8066d988>] (kernel_init) from [<801010e8>] (ret_from_f=
ork+0x14/0x2c)
> > [   21.431666] Exception stack(0x87897fb0 to 0x87897ff8)
> > [   21.432877] 7fa0:                                     00000000 00000=
000 00000000 00000000
> > [   21.434446] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> > [   21.436052] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [   21.437308]  r5:8066d988 r4:00000000
> > [   21.438102] ---[ end trace d7d7ac3a80567d0e ]---
>
> We only hit unregister_allocated_timer() if the argument to
> aspeed_gpio_set_config() is 0, but we can't be calling through
> gpiod_set_debounce() from gpio_keys_probe() unless the gpio-keys button h=
as a
> non-zero debounce interval.
>
> Commit 6581eaf0e890 ("gpio: use new gpio_set_config() helper in more plac=
es")
> spreads the use of gpio_set_config() to the debounce and transitory
> state configuration paths. The implementation of gpio_set_config() is:
>
> > static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
> >                          enum pin_config_param mode)
> > {
> >       unsigned long config =3D { PIN_CONF_PACKED(mode, 0) };
> >
> >       return gc->set_config ? gc->set_config(gc, offset, config) : -ENO=
TSUPP;
> > }
>
> Here it packs its own config value with a fixed argument of 0; this is
> incorrect behaviour for implementing the debounce and transitory function=
s, and
> the debounce and transitory gpio_set_config() call-sites now have an unde=
tected
> type mismatch as they both already pack their own config parameter (i.e. =
what
> gets passed is not an `enum pin_config_param`). Indeed this can be seen i=
n the
> small diff for 6581eaf0e890:
>
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index de595fa31a1a..1f239aac43df 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2725,7 +2725,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, un=
signed debounce)
> >         }
> >
> >         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, =
debounce);
> > -       return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> > +       return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> >
> > @@ -2762,7 +2762,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, =
bool transitory)
> >         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
> >                                           !transitory);
> >         gpio =3D gpio_chip_hwgpio(desc);
> > -       rc =3D chip->set_config(chip, gpio, packed);
> > +       rc =3D gpio_set_config(chip, gpio, packed);
> >         if (rc =3D=3D -ENOTSUPP) {
> >                 dev_dbg(&desc->gdev->dev, "Persistence not supported fo=
r GPIO %d\n",
> >                                 gpio);
>
> Revert commit 6581eaf0e890 ("gpio: use new gpio_set_config() helper in
> more places") to restore correct behaviour for gpiod_set_debounce() and
> gpiod_set_transitory().
>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/gpio/gpiolib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 144af0733581..0495bf1d480a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2776,7 +2776,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsi=
gned debounce)
>         }
>
>         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, de=
bounce);
> -       return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
> +       return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
>
> @@ -2813,7 +2813,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bo=
ol transitory)
>         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
>                                           !transitory);
>         gpio =3D gpio_chip_hwgpio(desc);
> -       rc =3D gpio_set_config(chip, gpio, packed);
> +       rc =3D chip->set_config(chip, gpio, packed);
>         if (rc =3D=3D -ENOTSUPP) {
>                 dev_dbg(&desc->gdev->dev, "Persistence not supported for =
GPIO %d\n",
>                                 gpio);
> --
> 2.19.1
>

Thanks for the detailed explanation of the problem. Can we check for
special cases in gpiod_set_config() and possibly pass the config
unchanged to the underlying driver in case of debounce and transitory
options?

Bart
