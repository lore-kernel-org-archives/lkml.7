Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5339B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S6CB0Alw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfKDPch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:32:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42015 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:32:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id b16so14712856otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UCa5z4wM9ujAZVKxuB1XurT7/b8EmjpHqxtKJ4ezjzc=;
        b=S6CB0AlwooUoRSw6ziiydGxesCarlK3ax1IvdUt042v+6e7vu0MQQuEccP2x9Vmclg
         lZcw0d/CojZZSHzppk4d1uYymb7/ChgJPHYHyD5WBHfqu79a6C5A5gRjtt1FQMx3+NCi
         lQmgg4xvQ4rmhxpCyli3Or/D9vilHfamW1yXIE6G2p0O5SAb1aP4hHjp6+VyCuFeteaa
         xykIUmKfU+b0UEhM4RRfki5flpCaA4OtNWbAgiNOEc+tBrSjefz4IgJzquklqdt23tsT
         7syHbrRvCyIsNb7l1POjVBDt9ivyzvCe+AYr7qgcJ/DauV4KvteEm+5E5tmlQxArEreO
         vblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UCa5z4wM9ujAZVKxuB1XurT7/b8EmjpHqxtKJ4ezjzc=;
        b=E/bSNEuE1xlosk2tjzFrIW9Tpd0nlxsvwYWpUMpQ5eTNtiYvi5K2wTKKzBGhYt6nA8
         cCnw/DNW23nWQZjM+Lsg1Bi+lq/wLrn47bSk3C/60JoAV7tmPOHOUkv//wdwVbDuwbyr
         JNM2RS3UqWEv53ibwGTkEFPx5hpzwAs6T97DkTDsVAfajFejQEx8IbceQVsRNIN80sIh
         06WZ55tuh2V77Y5ZVbi5aojT6AynXKdTNv8hFQeen/F7b8QS5PJJwLI08aCUpwsfvscV
         5MsVdjeEnD0eGMt4yX/gD5dOKN+ZMtrl8QRzW0hbkgPdK6Uvwqaazu38qVVy5ApQaDwF
         qP9w==
X-Gm-Message-State: APjAAAXCdDS1qAloZQIOt20klqg2eO4zVZK8SLysRmrchmTuk8Hp6Gqh
        aXHe1ilvW1dhRPgUyS4GAW8RFxjPz+bGPoVkmE+3Pw==
X-Google-Smtp-Source: APXvYqyJQLIZzGfgeSsHwKjl/BQkyaU13SkRdn65mcF4t2kAdW4LPVlJR3+Qis/y4aioE3UYq3en5DM0CHajAdOQFO0=
X-Received: by 2002:a05:6830:22ef:: with SMTP id t15mr3195246otc.256.1572881555374;
 Mon, 04 Nov 2019 07:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
 <20191015163055.0d8f44e5@xps13> <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
 <20191104161103.64995b8a@xps13>
In-Reply-To: <20191104161103.64995b8a@xps13>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Nov 2019 16:32:23 +0100
Message-ID: <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 4 lis 2019 o 16:11 Miquel Raynal <miquel.raynal@bootlin.com> napisa=
=C5=82(a):
>
> Hi Linus,
>
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 15 Oct 2019
> 17:55:33 +0300:
>
> > On Tue, Oct 15, 2019 at 5:30 PM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Andy,
> > >
> > > Thanks for the feedback.
> > >
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Mon, 14 Oct 2019
> > > 20:59:01 +0300:
> > >
> > > > On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > >
> > > > > The MAX7313 chip is fully compatible with the PCA9535 on its basi=
c
> > > > > functions but can also manage the intensity on each of its ports =
with
> > > > > PWM. Each output is independent and may be tuned with 16 values (=
4
> > > > > bits per output). The period is always 32kHz, only the duty-cycle=
 may
> > > > > be changed. One can use any output as GPIO or PWM.
> > > >
> > > > Can we rather not contaminate driver with this?
> > > >
> > > > Just register a separate PWM driver and export its functionality to
> > > > GPIO, or other way around (in the latter case we actually have PCA8=
685
> > > > which provides a GPIO fgunctionality).
> > > >
> > >
> > > I understand your concern but I am not sure to understand which
> > > solution you have in mind. In the former case, could you explain a bi=
t
> > > more what you are thinking about? Would linking the PWM support with
> > > the GPIO driver (code would be located in another .c file) work for
> > > you? Or maybe you would prefer an MFD on top of the GPIO driver?
> > >
> > > As for the later case, I am not willing to re-implement GPIO support =
in
> > > an alternate driver for an already supported chip, it is too much wor=
k
> > > for the time I can spend on it.
> >
> >
> > drivers/pwm/pwm-max7313.c:
> >
> > probe(platform_device)
> > {
> >   struct regmap =3D pdata;
> >   ...
> > }
> >
> > --- 8< --- 8< ---
> > drivers/gpio/gpio-pca953x.c:
> >
> > probe()
> > {
> >   struct regmap rm;
> > ...
> >   if (dev_has_pwm)
> >    pca953x_register_pwm_driver(rm);
> > ...
> > }
> >
> > In the above regmap may be replaced with some (shared) container.
> >
> > Or other way around. PWM registers GPIO (which actually I prefer since
> > we have PCA9685 case where PWM provides GPIO functionality, though via
> > different means)
> >
>
> Can I have your input on this proposal?
>
> On one hand I agree that the GPIO driver is already quite big due to
> its genericity and the amount of controllers it supports, on the other
> hand:
> 1/ Registering a PWM driver from the GPIO core seems strange. Maybe
> registering a platform device could do the trick but I am not convinced
> it is worth the trouble.
> 2/ Putting the PWM logic in the drivers/pwm/ directory is not very
> convenient as the object file will have to be embedded within the GPIO
> one; this line in drivers/gpio/Makefile would be horrible:
> ... +=3D gpio-pca953x.o ../pwm/pwm-max7313.o (not even sure it works)
> 3/ In any cases, the regmap's ->readable_reg(), ->writable_reg()
> callbacks shall be tweaked to turn the PWM registers accessible, so we
> would still have PWM related code in the PCA953x GPIO driver.
>
> In the end, I wonder if keeping everything in one file is not better?
> Eventually I can create a separate file and fill it with just the PWM
> helpers/hooks. Please advise on the better solution for you, I'll wait
> your feedback before addressing Thierry Reding's other review and
> resubmit.
>

I'm not sure if this has been discussed, but is it possible to create
an MFD driver for this chip and conditionally plug in the GPIO part
from pca953x? I don't like the idea of having PWM functionality in a
GPIO driver either.

Bart

>
> Thanks,
> Miqu=C3=A8l
