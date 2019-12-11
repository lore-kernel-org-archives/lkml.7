Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B928C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16CC2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NPdllIBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfLKJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:30:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35344 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfLKJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:30:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id s8so5710621qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2BC+9/TiZfps/b95kJW4uBoQA4KaDxSNdYTJBUn4gCs=;
        b=NPdllIBA+bj+UStDT7bl1Rv1PclFC4OqrdpoNdXo7cz0Mj3FkjxI7pucjAVFANaogi
         NffE55LMj+mJ4LTVFm3bo448ejF9005PtfGOKoL+yTsoq5GKf6d0nGG27QNWKnRCeR0N
         p9x0u0eR+7IbL+Q6djt0iTdnKLCIC3O6fdu2+FXFF20Ghki/CCvNgGlK2G6q7JTApE73
         it0Wf6/UpiTErJcyhUgIPY4BHonA5IkzXb9j2/d0yRW8o99nrsbIYRxYpNzgVy0E6A/3
         vTglo5Mm4bq6+Ay6AKQU8yPUea8RGK3cdIxqXAqKlbCktXdNOBxZxzbzJB8yfqSQnjrL
         j5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2BC+9/TiZfps/b95kJW4uBoQA4KaDxSNdYTJBUn4gCs=;
        b=eO9CFYw0L7OAVYjoKPIurOT8fKiB31IYDU2eEpFYTk6zIaydevyicAsc3r/CbdO12R
         m7dgUbHX4OjDpNkjXyMwZP2Onpj4LxcudZ5zUj1nLwKYJRwqnOWrUS1q5Pyv7w9Vsd1z
         VbdMN9yW4cwxuCg5cJJQ1xjAg0e18EoP4cpIaDtgG1el8rxjhNtNF0smeiH4nfxnD9Li
         +qVlBtXGfGyGDUgrFLI74SujJNSXRh5hYBUFp0c9nxy7YtsqZXgfReqZkFNsk9+UbRVa
         SeNW0i5F+HtsbdnF4O7htqZdGH5Tqyy4kM4JGmyxNyx6ANjFlizGD2K/XOPZ3XmR/Zwg
         jdpg==
X-Gm-Message-State: APjAAAVy/Mdt/h560HFTmXB6ihzM7SweWFVz502t2XD2OqbNPtf9jYTF
        jNICcy9DGexN7nSJDJEtHuEyegePuxnkxAuXPOf7Xg==
X-Google-Smtp-Source: APXvYqxaTP18w6zc4VO5j7KsdsiDxibQ8t/74TgQNa6gYF+g7p5dJRc/VEErwcCQJiSS7ym4scFbWgWHFE2Li4AvAc4=
X-Received: by 2002:ac8:6691:: with SMTP id d17mr1791217qtp.57.1576056643909;
 Wed, 11 Dec 2019 01:30:43 -0800 (PST)
MIME-Version: 1.0
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com> <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
In-Reply-To: <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:30:33 +0100
Message-ID: <CAMpxmJWMSnTB6JF8vOCmQzE3swWhbx8uwNEzU=qf49L26QCDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 11:09 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of
> > device trees) to determine the count of available interrupts. So
> > use this instead.
> >
> > As platform_irq_count() might return an error code (which
> > of_irq_count doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  Use %pe
>
> Great. Note that with %pe there is a dependency on commit 57f5677e535b
> ("printf: add support for printing symbolic error names") which was
> applied during the current merge window.
>

Why would %pe be better in this case? The function returned an int -
why convert it to a pointer?

Bart

> > V2:
> >  Update commit log, and add err handling
> >  Not tested, just code inspection
> >
> >
> >  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.=
c
> > index 4122683eb1f9..baee8c3f06ad 100644
> > --- a/drivers/gpio/gpio-bcm-kona.c
> > +++ b/drivers/gpio/gpio-bcm-kona.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/io.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/of_device.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/chained_irq.h>
> > @@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_de=
vice *pdev)
> >
> >       kona_gpio->gpio_chip =3D template_chip;
> >       chip =3D &kona_gpio->gpio_chip;
> > -     kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > -     if (kona_gpio->num_bank =3D=3D 0) {
> > +     ret =3D platform_irq_count(pdev);
> > +     if (!ret) {
> >               dev_err(dev, "Couldn't determine # GPIO banks\n");
> >               return -ENOENT;
> > +     } else if (ret < 0) {
> > +             if (ret !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Couldn't determine GPIO banks: (%pe=
)\n",
> > +                             ERR_PTR(ret));
>
> I'd say drop either the colon or the parenthesis.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
