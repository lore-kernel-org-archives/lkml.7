Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09241C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C472075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zKh+qjvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfC0IlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:41:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32987 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0IlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:41:07 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so13334698iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8yr20mcDrJ1OwLMyCdOxBeIierIiTMt4qXHt0vrJxnE=;
        b=zKh+qjvjaOsY3t1d72qGFHHiVC+c8U2fpS7r+K92YdF8hkh6ycP+lKmJ7YlR7XgRrr
         M/ozBZTMib+esSrmqR+mSb9nAqiZKRMxI8p9Y4cvbq39RikzLG2fNU0cOQOVHmgbEHv0
         GIv1+uUeyGnUsF6aqhZ+xbWWVqqjwEZBRwn/qBEcQPV6Qlj0VOugN3IHBQy8fB6F1oQV
         cpnu8skUogTOPUCs6oItyjFrxNt7QrGp8xPoKu67EZQ0gK+UEVx75iLmcGtaRhCSp0he
         sOzVBiSkGg8z6g/RyBOQ4sSe5/SWwBiyOYDUOsGCUfqrQTXymP0m4CXUJvbbfMDmMi85
         VKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8yr20mcDrJ1OwLMyCdOxBeIierIiTMt4qXHt0vrJxnE=;
        b=KwoFSnTdtsP/iWBC/wayXW99AazysSCKgmRm+vVZqAOEqENPFEZyWQpqusK8Onkb+R
         8sGRsUA84Sm3aIshBEZA6l6lZCXk8wfKXExGhRSEtmdDiB2tk7ZeYDZ3Nt0XjKSCUBPC
         c1wSRbpSgre/DUUA4nIX0MKobIwhkcQX8qNi9rcd7oxawxoKoA3CHoWJFcD9T3moKDzf
         qmHGKnXIQA9Mgc8yaetPGzAtcobYg0rJt6BV+v/gVvvPE6p9wgAe15Djqmv7sS0M1kke
         ZhAKcAM0LmBlVKM/siAr0acJHWqIJgX1cRPnSic+y8Ibjpm6e+MQvYb0iOIDcu5haAsu
         KdUg==
X-Gm-Message-State: APjAAAWTrJUjIXB5C6Tw8vxSE1aOQTaXifEg7NDb+gebO+zHq5dq8rt3
        6bkqMQOrg0diGBpfILctZGZqTNrirRFb2wz+ANEHzA==
X-Google-Smtp-Source: APXvYqzMWaBL2+qEra7vsvzwVJAyeNXdOV2GXBdVfJDKNjcrRaNzQ6Ln16GDCr+9hoPvneFO3cEZaG4QOiiLCQs9C3U=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr11949637iog.187.1553676066529;
 Wed, 27 Mar 2019 01:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190326044954.18671-1-andrew@aj.id.au> <CAMpxmJWvL2q9+yExAwv7jZ+g9psv5-_p8B89gk_pzvHbHMdO+w@mail.gmail.com>
In-Reply-To: <CAMpxmJWvL2q9+yExAwv7jZ+g9psv5-_p8B89gk_pzvHbHMdO+w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Mar 2019 09:40:55 +0100
Message-ID: <CAMRc=Mep9GNhOsO8jyxS4vHuPi3jgRbg_88Zqi1vRnw5hEXUCQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: use new gpio_set_config() helper in more places"
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
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

wt., 26 mar 2019 o 19:06 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> wt., 26 mar 2019 o 05:50 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82(a)=
:
> >
> > gpio-aspeed implements support for PIN_CONFIG_INPUT_DEBOUNCE. As of
> > v5.1-rc1 we're seeing the following when booting a Romulus BMC kernel:
> >
> > > [   21.373137] ------------[ cut here ]------------
> > > [   21.374545] WARNING: CPU: 0 PID: 1 at drivers/gpio/gpio-aspeed.c:8=
34 unregister_allocated_timer+0x38/0x94
> > > [   21.376181] No timer allocated to offset 74
> > > [   21.377672] CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-rc1-dirt=
y #6
> > > [   21.378800] Hardware name: Generic DT based system
> > > [   21.379965] Backtrace:
> > > [   21.381024] [<80107d44>] (dump_backtrace) from [<80107f78>] (show_=
stack+0x20/0x24)
> > > [   21.382713]  r7:8038b720 r6:00000009 r5:00000000 r4:87897c64
> > > [   21.383815] [<80107f58>] (show_stack) from [<80656398>] (dump_stac=
k+0x20/0x28)
> > > [   21.385042] [<80656378>] (dump_stack) from [<80115f1c>] (__warn.pa=
rt.3+0xb4/0xdc)
> > > [   21.386253] [<80115e68>] (__warn.part.3) from [<80115fb0>] (warn_s=
lowpath_fmt+0x6c/0x90)
> > > [   21.387471]  r6:00000342 r5:807f8758 r4:80a07008
> > > [   21.388278] [<80115f48>] (warn_slowpath_fmt) from [<8038b720>] (un=
register_allocated_timer+0x38/0x94)
> > > [   21.389809]  r3:0000004a r2:807f8774
> > > [   21.390526]  r7:00000000 r6:0000000a r5:60000153 r4:0000004a
> > > [   21.391601] [<8038b6e8>] (unregister_allocated_timer) from [<8038b=
aac>] (aspeed_gpio_set_config+0x330/0x48c)
> > > [   21.393248] [<8038b77c>] (aspeed_gpio_set_config) from [<803840b0>=
] (gpiod_set_debounce+0xe8/0x114)
> > > [   21.394745]  r10:82ee2248 r9:00000000 r8:87b63a00 r7:00001388 r6:8=
7947320 r5:80729310
> > > [   21.396030]  r4:879f64a0
> > > [   21.396499] [<80383fc8>] (gpiod_set_debounce) from [<804b4350>] (g=
pio_keys_probe+0x69c/0x8e0)
> > > [   21.397715]  r7:845d94b8 r6:00000001 r5:00000000 r4:87b63a1c
> > > [   21.398618] [<804b3cb4>] (gpio_keys_probe) from [<8040eeec>] (plat=
form_dev_probe+0x44/0x80)
> > > [   21.399834]  r10:00000003 r9:80a3a8b0 r8:00000000 r7:00000000 r6:8=
0a7f9dc r5:80a3a8b0
> > > [   21.401163]  r4:8796bc10
> > > [   21.401634] [<8040eea8>] (platform_drv_probe) from [<8040d0d4>] (r=
eally_probe+0x208/0x3dc)
> > > [   21.402786]  r5:80a7f8d0 r4:8796bc10
> > > [   21.403547] [<8040cecc>] (really_probe) from [<8040d7a4>] (driver_=
probe_device+0x130/0x170)
> > > [   21.404744]  r10:0000007b r9:8093683c r8:00000000 r7:80a07008 r6:8=
0a3a8b0 r5:8796bc10
> > > [   21.405854]  r4:80a3a8b0
> > > [   21.406324] [<8040d674>] (driver_probe_device) from [<8040da8c>] (=
device_driver_attach+0x68/0x70)
> > > [   21.407568]  r9:8093683c r8:00000000 r7:80a07008 r6:80a3a8b0 r5:00=
000000 r4:8796bc10
> > > [   21.408877] [<8040da24>] (device_driver_attach) from [<8040db14>] =
(__driver_attach+0x80/0x150)
> > > [   21.410327]  r7:80a07008 r6:8796bc10 r5:00000001 r4:80a3a8b0
> > > [   21.411294] [<8040da94>] (__driver_attach) from [<8040b20c>] (bus_=
for_each_dev+0x80/0xc4)
> > > [   21.412641]  r7:80a07008 r6:8040da94 r5:80a3a8b0 r4:87966f30
> > > [   21.413580] [<8040b18c>] (bus_for_each_dev) from [<8040dc0c>] (dri=
ver_attach+0x28/0x30)
> > > [   21.414943]  r7:00000000 r6:87b411e0 r5:80a33fc8 r4:80a3a8b0
> > > [   21.415927] [<8040dbe4>] (driver_attach) from [<8040bbf0>] (bus_ad=
d_driver+0x14c/0x200)
> > > [   21.417289] [<8040baa4>] (bus_add_driver) from [<8040e2b4>] (drive=
r_register+0x84/0x118)
> > > [   21.418652]  r7:80a60ae0 r6:809226b8 r5:80a07008 r4:80a3a8b0
> > > [   21.419652] [<8040e230>] (driver_register) from [<8040fc28>] (__pl=
atform_driver_register+0x3c/0x50)
> > > [   21.421193]  r5:80a07008 r4:809525f8
> > > [   21.421990] [<8040fbec>] (__platform_driver_register) from [<80922=
6d8>] (gpio_keys_init+0x20/0x28)
> > > [   21.423447] [<809226b8>] (gpio_keys_init) from [<8090128c>] (do_on=
e_initcall+0x80/0x180)
> > > [   21.424886] [<8090120c>] (do_one_initcall) from [<80901538>] (kern=
el_init_freeable+0x1ac/0x26c)
> > > [   21.426354]  r8:80a60ae0 r7:80a60ae0 r6:8093685c r5:00000008 r4:80=
9525f8
> > > [   21.427579] [<8090138c>] (kernel_init_freeable) from [<8066d9a0>] =
(kernel_init+0x18/0x11c)
> > > [   21.428819]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:0=
0000000 r5:8066d988
> > > [   21.429947]  r4:00000000
> > > [   21.430415] [<8066d988>] (kernel_init) from [<801010e8>] (ret_from=
_fork+0x14/0x2c)
> > > [   21.431666] Exception stack(0x87897fb0 to 0x87897ff8)
> > > [   21.432877] 7fa0:                                     00000000 000=
00000 00000000 00000000
> > > [   21.434446] 7fc0: 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000
> > > [   21.436052] 7fe0: 00000000 00000000 00000000 00000000 00000013 000=
00000
> > > [   21.437308]  r5:8066d988 r4:00000000
> > > [   21.438102] ---[ end trace d7d7ac3a80567d0e ]---
> >
> > We only hit unregister_allocated_timer() if the argument to
> > aspeed_gpio_set_config() is 0, but we can't be calling through
> > gpiod_set_debounce() from gpio_keys_probe() unless the gpio-keys button=
 has a
> > non-zero debounce interval.
> >
> > Commit 6581eaf0e890 ("gpio: use new gpio_set_config() helper in more pl=
aces")
> > spreads the use of gpio_set_config() to the debounce and transitory
> > state configuration paths. The implementation of gpio_set_config() is:
> >
> > > static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
> > >                          enum pin_config_param mode)
> > > {
> > >       unsigned long config =3D { PIN_CONF_PACKED(mode, 0) };
> > >
> > >       return gc->set_config ? gc->set_config(gc, offset, config) : -E=
NOTSUPP;
> > > }
> >
> > Here it packs its own config value with a fixed argument of 0; this is
> > incorrect behaviour for implementing the debounce and transitory functi=
ons, and
> > the debounce and transitory gpio_set_config() call-sites now have an un=
detected
> > type mismatch as they both already pack their own config parameter (i.e=
. what
> > gets passed is not an `enum pin_config_param`). Indeed this can be seen=
 in the
> > small diff for 6581eaf0e890:
> >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index de595fa31a1a..1f239aac43df 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -2725,7 +2725,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, =
unsigned debounce)
> > >         }
> > >
> > >         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE=
, debounce);
> > > -       return chip->set_config(chip, gpio_chip_hwgpio(desc), config)=
;
> > > +       return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
> > >  }
> > >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> > >
> > > @@ -2762,7 +2762,7 @@ int gpiod_set_transitory(struct gpio_desc *desc=
, bool transitory)
> > >         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
> > >                                           !transitory);
> > >         gpio =3D gpio_chip_hwgpio(desc);
> > > -       rc =3D chip->set_config(chip, gpio, packed);
> > > +       rc =3D gpio_set_config(chip, gpio, packed);
> > >         if (rc =3D=3D -ENOTSUPP) {
> > >                 dev_dbg(&desc->gdev->dev, "Persistence not supported =
for GPIO %d\n",
> > >                                 gpio);
> >
> > Revert commit 6581eaf0e890 ("gpio: use new gpio_set_config() helper in
> > more places") to restore correct behaviour for gpiod_set_debounce() and
> > gpiod_set_transitory().
> >
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/gpio/gpiolib.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 144af0733581..0495bf1d480a 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2776,7 +2776,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, un=
signed debounce)
> >         }
> >
> >         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, =
debounce);
> > -       return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
> > +       return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> >
> > @@ -2813,7 +2813,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, =
bool transitory)
> >         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
> >                                           !transitory);
> >         gpio =3D gpio_chip_hwgpio(desc);
> > -       rc =3D gpio_set_config(chip, gpio, packed);
> > +       rc =3D chip->set_config(chip, gpio, packed);
> >         if (rc =3D=3D -ENOTSUPP) {
> >                 dev_dbg(&desc->gdev->dev, "Persistence not supported fo=
r GPIO %d\n",
> >                                 gpio);
> > --
> > 2.19.1
> >
>
> Thanks for the detailed explanation of the problem. Can we check for
> special cases in gpiod_set_config() and possibly pass the config
> unchanged to the underlying driver in case of debounce and transitory
> options?
>
> Bart

After giving it a second thought and seeing that Thomas is ok with
reverting it, I applied the patch for fixes.

Bart
