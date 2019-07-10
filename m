Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32598C606D3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2E120651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mstsLCtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGJJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:47:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34845 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfGJJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:47:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so1141909oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzV97ZdiERZ42rZWsWCb0hOAee1RiY7/NGaFmcVPNbo=;
        b=mstsLCtHadyks31Z9lCGNHdmPIycOBkJOxqQ5UkKwFgG9lMmu0w9BPn9D0HPMZ3pm2
         mOjKgMR7/aBkKvMue+fDtVvZYHlidhvGfkYHFnNv8JbHIDL5t29vnLkw/TU63aMhrzXq
         z4SWpOhnjBibihvBajL0LC4cl0UnpJ5h+2c8nvhq48ZSb/yalpK5eo6iE0iX/P/LRfPg
         aDPSZMxdnHc9KgzwPR8tGtKJG6JpPAodrmvGicGP2c6tdC37mwqj4OYZZN5WarddV1RO
         Hi6yP3DlQFxeF/y6paTYMsVxwo0f32bmcDJ+vTDTBth1O8khr/viW7UXy21EXlknraqO
         jbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzV97ZdiERZ42rZWsWCb0hOAee1RiY7/NGaFmcVPNbo=;
        b=BuKI1J5plVXFKryE3p1p3XoNrGqw2UhSq9/gfNG+BtyWBhbTmZhNWMkAfPf5eJ9FQG
         oYZMMuTnBQanG06HWOFPInCt7Vkt5PxsJx+QqPREBQFhVosHFaVsroNawIv6hGbANzxF
         d0kgsUXM6dWKJ5XJZ7xoFQ4Ibw+IT/W9XrlHb6z+rTQmzJ0M+1QPh/pu6yePxAwgXv1/
         FM075V5MtFX1IXDEoihj5TPt2VYlVElxRyaFlA4ALmtdXUTfYrMknDSWUcf0N/n/lBWP
         J5OsvVaz2KM/B328z6veF4+mjOF7YI2E2iJQGWRliJQSsy/xdv/F41BlF4jL1d4aowN2
         7lqg==
X-Gm-Message-State: APjAAAXuP2Mw0HMsVuh0dmq28R8Q0YZTRV1qBbPfEs/SjH2B0c+v/dHR
        cI8xnfd1dEom2/aVOb/gMW64w2WBJxj6erFvZYIVBQ==
X-Google-Smtp-Source: APXvYqznfFks6r5S5buZ9JmChEVpkgAFdEaVMCeevNK+H6vq3wW6vKxhG9d1P9GI7IKoNPDDVwjFdqGtsDhlz2syNG4=
X-Received: by 2002:aca:b06:: with SMTP id 6mr2926203oil.175.1562752049415;
 Wed, 10 Jul 2019 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190710090852.9239-1-brgl@bgdev.pl> <510f14c9-fc3b-734c-53ff-cbf4a7579e32@electromag.com.au>
In-Reply-To: <510f14c9-fc3b-734c-53ff-cbf4a7579e32@electromag.com.au>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 10 Jul 2019 11:47:18 +0200
Message-ID: <CAMpxmJUFEoVZOL++SxshUr3rH0pCzML_at0dji8smqVtpGpqsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: em: remove the gpiochip before removing the irq domain
To:     Phil Reid <preid@electromag.com.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 10 lip 2019 o 11:37 Phil Reid <preid@electromag.com.au> napisa=C5=
=82(a):
>
> G'day Bartosz,
>
> One comment below
>
> On 10/07/2019 17:08, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > In commit 8764c4ca5049 ("gpio: em: use the managed version of
> > gpiochip_add_data()") we implicitly altered the ordering of resource
> > freeing: since gpiochip_remove() calls gpiochip_irqchip_remove()
> > internally, we now can potentially use the irq_domain after it was
> > destroyed in the remove() callback (as devm resources are freed after
> > remove() has returned).
> >
> > Use devm_add_action() to keep the ordering right and entirely kill
> > the remove() callback in the driver.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 8764c4ca5049 ("gpio: em: use the managed version of gpiochip_add=
_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/gpio/gpio-em.c | 35 +++++++++++++++++------------------
> >   1 file changed, 17 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
> > index b6af705a4e5f..c88028ac66f2 100644
> > --- a/drivers/gpio/gpio-em.c
> > +++ b/drivers/gpio/gpio-em.c
> > @@ -259,6 +259,13 @@ static const struct irq_domain_ops em_gio_irq_doma=
in_ops =3D {
> >       .xlate  =3D irq_domain_xlate_twocell,
> >   };
> >
> > +static void em_gio_irq_domain_remove(void *data)
> > +{
> > +     struct irq_domain *domain =3D data;
> > +
> > +     irq_domain_remove(domain);
> > +}
> > +
> >   static int em_gio_probe(struct platform_device *pdev)
> >   {
> >       struct em_gio_priv *p;
> > @@ -333,39 +340,32 @@ static int em_gio_probe(struct platform_device *p=
dev)
> >               return -ENXIO;
> >       }
> >
> > +     ret =3D devm_add_action(&pdev->dev,
> > +                           em_gio_irq_domain_remove, p->irq_domain);
>
> Could devm_add_action_or_reset be used?
>

Of course it could and it should. :)

I'll resend tomorrow to not spam the mailing list.

Thanks,
Bart

> > +     if (ret) {
> > +             irq_domain_remove(p->irq_domain);
> > +             return ret;
> > +     }
> > +
> >       if (devm_request_irq(&pdev->dev, irq[0]->start,
> >                            em_gio_irq_handler, 0, name, p)) {
> >               dev_err(&pdev->dev, "failed to request low IRQ\n");
> > -             ret =3D -ENOENT;
> > -             goto err1;
> > +             return -ENOENT;
> >       }
> >
> >       if (devm_request_irq(&pdev->dev, irq[1]->start,
> >                            em_gio_irq_handler, 0, name, p)) {
> >               dev_err(&pdev->dev, "failed to request high IRQ\n");
> > -             ret =3D -ENOENT;
> > -             goto err1;
> > +             return -ENOENT;
> >       }
> >
> >       ret =3D devm_gpiochip_add_data(&pdev->dev, gpio_chip, p);
> >       if (ret) {
> >               dev_err(&pdev->dev, "failed to add GPIO controller\n");
> > -             goto err1;
> > +             return ret;
> >       }
> >
> >       return 0;
> > -
> > -err1:
> > -     irq_domain_remove(p->irq_domain);
> > -     return ret;
> > -}
> > -
> > -static int em_gio_remove(struct platform_device *pdev)
> > -{
> > -     struct em_gio_priv *p =3D platform_get_drvdata(pdev);
> > -
> > -     irq_domain_remove(p->irq_domain);
> > -     return 0;
> >   }
> >
> >   static const struct of_device_id em_gio_dt_ids[] =3D {
> > @@ -376,7 +376,6 @@ MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
> >
> >   static struct platform_driver em_gio_device_driver =3D {
> >       .probe          =3D em_gio_probe,
> > -     .remove         =3D em_gio_remove,
> >       .driver         =3D {
> >               .name   =3D "em_gio",
> >               .of_match_table =3D em_gio_dt_ids,
> >
>
>
> --
> Regards
> Phil Reid
>
