Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B452075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="WrMiBcck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5sgiIHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfC0Isi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:48:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58401 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732348AbfC0Ish (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:48:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CE152221E;
        Wed, 27 Mar 2019 04:48:36 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 27 Mar 2019 04:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=Orsnq
        R9o80rvC+KAcqOJbHwdwtj5JTe+vOpyqRcf4uE=; b=WrMiBcckPFoMIQbwcLB4o
        CMOih2zOLJBRf1DOXzCySMff9nwRH7waoBdi8DU4Ki10LsIbU76jgzcE5h1oMX8T
        rbjttM0lMEAE1SHdwRAfcxcBmJqWvGbBYIFmuauFBHa1T6H0FEH+XC5CxhvSKh8m
        RLMQWCxU6leyWoy++YXxTpI1J3x7pb97+BoWID+Z3RAwGaxuB7cP+DGd5N1PDgpJ
        ZxFY9DMiIutAnXtUIEodaYQGf+49iAAeto2I6SSJCcQKJLFiFqorZoLmj+t56EaR
        nOq+tUbI3O3NV3h73txuLWbiPPH6lWQtoVarO1UBc5Xu51opgaYcARegaNIw/QJ4
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=OrsnqR9o80rvC+KAcqOJbHwdwtj5JTe+vOpyqRcf4
        uE=; b=f5sgiIHW34lRD+oPtcNp0JH5lMpReCDHi2JInppS2POr7ttG2LOjwEBQi
        9u9/LvAK3YAX3Vb24VvTznJ0rg/DfcgsOACxssKiYJOvp0J52nJooa4lxKMExBtG
        kzaLNpAPGV8OjLmxl5so+vrKOjPQBSjGd2akf1f4NdPWYvtt1M/xm3SLzBuvkQrd
        w2b4gLccLH41+sLRkUDwo08t9pqVVAFQrRrcaXEssrClZpVjgK8KRe8N1AgS84Bz
        DggyxElNqz5VpQaRz5pv6mMxhP3qHIAALQdT7/Y5VH3azLUlHelbfrpfzpLxOD+A
        y6nj85R+c0s7XW1uKxfR0HXWcARDA==
X-ME-Sender: <xms:4zibXEObBmMNypQjNnloN8tUCh4uuUYDWAsFVgRkseWUJ4ZLMteu2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:4zibXGkTlOZoy6OIvFPbR-wp6M2q6esJ8QbgJY0QUUCEeyStvTOFUg>
    <xmx:4zibXNYw8Mi4wIq9NMUA7LXsNg8uCyHsazR9bwqKbkDf9HysGw9n_A>
    <xmx:4zibXLFf7aLvXWWbKbh0B1jehxh_jYQ9ZTkc2rq_ErcfneDsTyQX1g>
    <xmx:5DibXILfc_TOAVuYBaLmodKHwVSBRVspXpLmffi5VQ-6vIOoNA3jPA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1000C7C1B7; Wed, 27 Mar 2019 04:48:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-976-g376b1f3-fmstable-20190314v3
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <7cd197b9-5e3f-4c58-aea0-f05978b2c86d@www.fastmail.com>
In-Reply-To: <CAMRc=Mep9GNhOsO8jyxS4vHuPi3jgRbg_88Zqi1vRnw5hEXUCQ@mail.gmail.com>
References: <20190326044954.18671-1-andrew@aj.id.au>
 <CAMpxmJWvL2q9+yExAwv7jZ+g9psv5-_p8B89gk_pzvHbHMdO+w@mail.gmail.com>
 <CAMRc=Mep9GNhOsO8jyxS4vHuPi3jgRbg_88Zqi1vRnw5hEXUCQ@mail.gmail.com>
Date:   Wed, 27 Mar 2019 04:48:33 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_Revert_"gpio:_use_new_gpio=5Fset=5Fconfig()_helper?=
 =?UTF-8?Q?_in_more_places"?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Mar 2019, at 19:11, Bartosz Golaszewski wrote:
> wt., 26 mar 2019 o 19:06 Bartosz Golaszewski
> <bgolaszewski@baylibre.com> napisa=C5=82(a):
> >
> > wt., 26 mar 2019 o 05:50 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82=
(a):
> > >
> > > gpio-aspeed implements support for PIN_CONFIG_INPUT_DEBOUNCE. As o=
f
> > > v5.1-rc1 we're seeing the following when booting a Romulus BMC ker=
nel:
> > >
> > > > [   21.373137] ------------[ cut here ]------------
> > > > [   21.374545] WARNING: CPU: 0 PID: 1 at drivers/gpio/gpio-aspee=
d.c:834 unregister_allocated_timer+0x38/0x94
> > > > [   21.376181] No timer allocated to offset 74
> > > > [   21.377672] CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-rc1=
-dirty #6
> > > > [   21.378800] Hardware name: Generic DT based system
> > > > [   21.379965] Backtrace:
> > > > [   21.381024] [<80107d44>] (dump_backtrace) from [<80107f78>] (=
show_stack+0x20/0x24)
> > > > [   21.382713]  r7:8038b720 r6:00000009 r5:00000000 r4:87897c64
> > > > [   21.383815] [<80107f58>] (show_stack) from [<80656398>] (dump=
_stack+0x20/0x28)
> > > > [   21.385042] [<80656378>] (dump_stack) from [<80115f1c>] (__wa=
rn.part.3+0xb4/0xdc)
> > > > [   21.386253] [<80115e68>] (__warn.part.3) from [<80115fb0>] (w=
arn_slowpath_fmt+0x6c/0x90)
> > > > [   21.387471]  r6:00000342 r5:807f8758 r4:80a07008
> > > > [   21.388278] [<80115f48>] (warn_slowpath_fmt) from [<8038b720>=
] (unregister_allocated_timer+0x38/0x94)
> > > > [   21.389809]  r3:0000004a r2:807f8774
> > > > [   21.390526]  r7:00000000 r6:0000000a r5:60000153 r4:0000004a
> > > > [   21.391601] [<8038b6e8>] (unregister_allocated_timer) from [<=
8038baac>] (aspeed_gpio_set_config+0x330/0x48c)
> > > > [   21.393248] [<8038b77c>] (aspeed_gpio_set_config) from [<8038=
40b0>] (gpiod_set_debounce+0xe8/0x114)
> > > > [   21.394745]  r10:82ee2248 r9:00000000 r8:87b63a00 r7:00001388=
 r6:87947320 r5:80729310
> > > > [   21.396030]  r4:879f64a0
> > > > [   21.396499] [<80383fc8>] (gpiod_set_debounce) from [<804b4350=
>] (gpio_keys_probe+0x69c/0x8e0)
> > > > [   21.397715]  r7:845d94b8 r6:00000001 r5:00000000 r4:87b63a1c
> > > > [   21.398618] [<804b3cb4>] (gpio_keys_probe) from [<8040eeec>] =
(platform_dev_probe+0x44/0x80)
> > > > [   21.399834]  r10:00000003 r9:80a3a8b0 r8:00000000 r7:00000000=
 r6:80a7f9dc r5:80a3a8b0
> > > > [   21.401163]  r4:8796bc10
> > > > [   21.401634] [<8040eea8>] (platform_drv_probe) from [<8040d0d4=
>] (really_probe+0x208/0x3dc)
> > > > [   21.402786]  r5:80a7f8d0 r4:8796bc10
> > > > [   21.403547] [<8040cecc>] (really_probe) from [<8040d7a4>] (dr=
iver_probe_device+0x130/0x170)
> > > > [   21.404744]  r10:0000007b r9:8093683c r8:00000000 r7:80a07008=
 r6:80a3a8b0 r5:8796bc10
> > > > [   21.405854]  r4:80a3a8b0
> > > > [   21.406324] [<8040d674>] (driver_probe_device) from [<8040da8=
c>] (device_driver_attach+0x68/0x70)
> > > > [   21.407568]  r9:8093683c r8:00000000 r7:80a07008 r6:80a3a8b0 =
r5:00000000 r4:8796bc10
> > > > [   21.408877] [<8040da24>] (device_driver_attach) from [<8040db=
14>] (__driver_attach+0x80/0x150)
> > > > [   21.410327]  r7:80a07008 r6:8796bc10 r5:00000001 r4:80a3a8b0
> > > > [   21.411294] [<8040da94>] (__driver_attach) from [<8040b20c>] =
(bus_for_each_dev+0x80/0xc4)
> > > > [   21.412641]  r7:80a07008 r6:8040da94 r5:80a3a8b0 r4:87966f30
> > > > [   21.413580] [<8040b18c>] (bus_for_each_dev) from [<8040dc0c>]=
 (driver_attach+0x28/0x30)
> > > > [   21.414943]  r7:00000000 r6:87b411e0 r5:80a33fc8 r4:80a3a8b0
> > > > [   21.415927] [<8040dbe4>] (driver_attach) from [<8040bbf0>] (b=
us_add_driver+0x14c/0x200)
> > > > [   21.417289] [<8040baa4>] (bus_add_driver) from [<8040e2b4>] (=
driver_register+0x84/0x118)
> > > > [   21.418652]  r7:80a60ae0 r6:809226b8 r5:80a07008 r4:80a3a8b0
> > > > [   21.419652] [<8040e230>] (driver_register) from [<8040fc28>] =
(__platform_driver_register+0x3c/0x50)
> > > > [   21.421193]  r5:80a07008 r4:809525f8
> > > > [   21.421990] [<8040fbec>] (__platform_driver_register) from [<=
809226d8>] (gpio_keys_init+0x20/0x28)
> > > > [   21.423447] [<809226b8>] (gpio_keys_init) from [<8090128c>] (=
do_one_initcall+0x80/0x180)
> > > > [   21.424886] [<8090120c>] (do_one_initcall) from [<80901538>] =
(kernel_init_freeable+0x1ac/0x26c)
> > > > [   21.426354]  r8:80a60ae0 r7:80a60ae0 r6:8093685c r5:00000008 =
r4:809525f8
> > > > [   21.427579] [<8090138c>] (kernel_init_freeable) from [<8066d9=
a0>] (kernel_init+0x18/0x11c)
> > > > [   21.428819]  r10:00000000 r9:00000000 r8:00000000 r7:00000000=
 r6:00000000 r5:8066d988
> > > > [   21.429947]  r4:00000000
> > > > [   21.430415] [<8066d988>] (kernel_init) from [<801010e8>] (ret=
_from_fork+0x14/0x2c)
> > > > [   21.431666] Exception stack(0x87897fb0 to 0x87897ff8)
> > > > [   21.432877] 7fa0:                                     0000000=
0 00000000 00000000 00000000
> > > > [   21.434446] 7fc0: 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000 00000000
> > > > [   21.436052] 7fe0: 00000000 00000000 00000000 00000000 0000001=
3 00000000
> > > > [   21.437308]  r5:8066d988 r4:00000000
> > > > [   21.438102] ---[ end trace d7d7ac3a80567d0e ]---
> > >
> > > We only hit unregister_allocated_timer() if the argument to
> > > aspeed_gpio_set_config() is 0, but we can't be calling through
> > > gpiod_set_debounce() from gpio_keys_probe() unless the gpio-keys b=
utton has a
> > > non-zero debounce interval.
> > >
> > > Commit 6581eaf0e890 ("gpio: use new gpio_set_config() helper in mo=
re places")
> > > spreads the use of gpio_set_config() to the debounce and transitor=
y
> > > state configuration paths. The implementation of gpio_set_config()=
 is:
> > >
> > > > static int gpio_set_config(struct gpio_chip *gc, unsigned offset=
,
> > > >                          enum pin_config_param mode)
> > > > {
> > > >       unsigned long config =3D { PIN_CONF_PACKED(mode, 0) };
> > > >
> > > >       return gc->set_config ? gc->set_config(gc, offset, config)=
 : -ENOTSUPP;
> > > > }
> > >
> > > Here it packs its own config value with a fixed argument of 0; thi=
s is
> > > incorrect behaviour for implementing the debounce and transitory f=
unctions, and
> > > the debounce and transitory gpio_set_config() call-sites now have =
an undetected
> > > type mismatch as they both already pack their own config parameter=
 (i.e. what
> > > gets passed is not an `enum pin_config_param`). Indeed this can be=
 seen in the
> > > small diff for 6581eaf0e890:
> > >
> > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > index de595fa31a1a..1f239aac43df 100644
> > > > --- a/drivers/gpio/gpiolib.c
> > > > +++ b/drivers/gpio/gpiolib.c
> > > > @@ -2725,7 +2725,7 @@ int gpiod_set_debounce(struct gpio_desc *d=
esc, unsigned debounce)
> > > >         }
> > > >
> > > >         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEB=
OUNCE, debounce);
> > > > -       return chip->set_config(chip, gpio_chip_hwgpio(desc), co=
nfig);
> > > > +       return gpio_set_config(chip, gpio_chip_hwgpio(desc), con=
fig);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> > > >
> > > > @@ -2762,7 +2762,7 @@ int gpiod_set_transitory(struct gpio_desc =
*desc, bool transitory)
> > > >         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_S=
TATE,
> > > >                                           !transitory);
> > > >         gpio =3D gpio_chip_hwgpio(desc);
> > > > -       rc =3D chip->set_config(chip, gpio, packed);
> > > > +       rc =3D gpio_set_config(chip, gpio, packed);
> > > >         if (rc =3D=3D -ENOTSUPP) {
> > > >                 dev_dbg(&desc->gdev->dev, "Persistence not suppo=
rted for GPIO %d\n",
> > > >                                 gpio);
> > >
> > > Revert commit 6581eaf0e890 ("gpio: use new gpio_set_config() helpe=
r in
> > > more places") to restore correct behaviour for gpiod_set_debounce(=
) and
> > > gpiod_set_transitory().
> > >
> > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/gpio/gpiolib.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 144af0733581..0495bf1d480a 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -2776,7 +2776,7 @@ int gpiod_set_debounce(struct gpio_desc *des=
c, unsigned debounce)
> > >         }
> > >
> > >         config =3D pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOU=
NCE, debounce);
> > > -       return gpio_set_config(chip, gpio_chip_hwgpio(desc), confi=
g);
> > > +       return chip->set_config(chip, gpio_chip_hwgpio(desc), conf=
ig);
> > >  }
> > >  EXPORT_SYMBOL_GPL(gpiod_set_debounce);
> > >
> > > @@ -2813,7 +2813,7 @@ int gpiod_set_transitory(struct gpio_desc *d=
esc, bool transitory)
> > >         packed =3D pinconf_to_config_packed(PIN_CONFIG_PERSIST_STA=
TE,
> > >                                           !transitory);
> > >         gpio =3D gpio_chip_hwgpio(desc);
> > > -       rc =3D gpio_set_config(chip, gpio, packed);
> > > +       rc =3D chip->set_config(chip, gpio, packed);
> > >         if (rc =3D=3D -ENOTSUPP) {
> > >                 dev_dbg(&desc->gdev->dev, "Persistence not support=
ed for GPIO %d\n",
> > >                                 gpio);
> > > --
> > > 2.19.1
> > >
> >
> > Thanks for the detailed explanation of the problem. Can we check for=

> > special cases in gpiod_set_config() and possibly pass the config
> > unchanged to the underlying driver in case of debounce and transitor=
y
> > options?
> >
> > Bart
>=20
> After giving it a second thought and seeing that Thomas is ok with
> reverting it, I applied the patch for fixes.

Ok, thanks. Didn't get around to addressing your reply today, so that's =
one less thing on the todo list :)

Andrew

>=20
> Bart
>
