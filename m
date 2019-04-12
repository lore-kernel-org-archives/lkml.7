Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F41C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E01206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="s7YgT5EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfDLMMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:12:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50283 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfDLMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:12:48 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so209526itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iCZlPziWJiQaKtwiXHrfTEPKeCtsRQH3Jd3O98iuC1s=;
        b=s7YgT5EP3rQu2Cg6C7wN73bmRQ0ScfW/3NpVUCK8c06tKLBPXP9Nhk7uUeOQXkjRuq
         ePmaVlc45YI/UfZ48VmQIlC30LxwvkhB990mxwJiVqyI9AVwDazUVlwlq9JdBawEDvG+
         wjvTSmXMk+5jy3SsfeZCYbY5UPsHUFRpRsGwX85OoYctHMEvfHs2FTtAvO+F8xwHlWoR
         HoB6IN+UMVoHRssip6iQKtE29yRzqJTWPk3mB7jPhMSRDxnJGyPU3/um+Eepn24tdQmJ
         B/QfCX4O5ODwlNWyTic2KKbthRbw7z0K11ZmXw9DGKG0YH+2a6oPGKOGTjct9RU9VWnp
         Yq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCZlPziWJiQaKtwiXHrfTEPKeCtsRQH3Jd3O98iuC1s=;
        b=b1zVfIHJo/ICSClZgZCkNNNEIXElPbjbqiT77eL7m1jkx0lIynZmYRpvTKmKXGqBbM
         rsyqG+pjQPLmYjaKIqy5xDsBUIrVrsQvCiWUWghxzHGXOJRDX4kHruWWjnFr/6HMSwFf
         1NpcncOHSJQbeAwprPOjpu+kkFtBkjXDK3V+tnDvsOJu7wCvC4BwzRMbYxCbdGziJSAt
         lJxkql4UF3orZc9UbESIxyFfRO2DhUEIlOgiWm4cpmC+gWRnffTCBUsoYX4K4MUjP3Ip
         bs8SUbCkqIdp7NMEzxkll65VrULyXz0fUY3sBU13sBD3Z/2BneM3fxpNJBjl7souYja5
         YrLg==
X-Gm-Message-State: APjAAAWB8pMC78IjYLRMMfKjOhnGksNMF7+Dcix9xJ3GdkGjnWDk8aOW
        fUHYG3H1KENg6ZHbe3o0QWKfeNJ7x7Rezfjv22v3OA==
X-Google-Smtp-Source: APXvYqzOHP+IYJxFiCwQ0uzLbJSpgkERuycBCcso7Q1Mpqb3aKN0E4n6TYgyw1AUpdKF2eUmZiBHTVGYB6+JXaaqmTA=
X-Received: by 2002:a24:ad2:: with SMTP id 201mr12217784itw.26.1555071167191;
 Fri, 12 Apr 2019 05:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411093024.23555-1-brgl@bgdev.pl> <20190411093024.23555-4-brgl@bgdev.pl>
 <4a022050-73ad-cbed-bf30-416abb2196e0@ti.com>
In-Reply-To: <4a022050-73ad-cbed-bf30-416abb2196e0@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 14:12:36 +0200
Message-ID: <CAMRc=MeCxEM+q2m55_2LV6C9kLxJqZqtQytNrsdO5AiV6rT8gA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] usb: ohci-da8xx: disable the regulator if the
 overcurrent irq fired
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 kwi 2019 o 12:39 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bartosz,
>
> On 11/04/19 3:00 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Historically the power supply management in this driver has been handle=
d
> > in two separate places in parallel. Device-tree users simply defined an
> > appropriate regulator, while two boards with no DT support (da830-evm a=
nd
> > omapl138-hawk) passed functions defined in their respective board files
> > over platform data. These functions simply used legacy GPIO calls to
> > watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
> > fires.
> >
> > Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> > updated these GPIO calls to the modern API and moved them inside the
> > driver.
> >
> > This however is not the optimal solution for the vbus GPIO which should
> > be modeled as a fixed regulator that can be controlled with a GPIO.
> >
> > In order to keep the overcurrent protection available once we move the
> > board files to using fixed regulators we need to disable the enable_reg
> > regulator when the overcurrent indicator interrupt fires. Since we
> > cannot call regulator_disable() from interrupt context, we need to
> > switch to using a oneshot threaded interrupt.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I thought a bit on whether it makes sense to merge this patch into 6/6
> since that is modifying some code you introduce here. But I think its
> probably better to keep it separate like you have it now.
>
> 6/6 is about dropping support for vbus gpio, where as here you are
> letting regulator be used for handing overcurrent detected using oci gpio=
.
>
> Having it separate makes it possible to revert dropping support for vbus
> gpio while keeping this functionality ;)
>

These two changes were together in v1, but I too think that having it
separate keeps the series bisectable.

Bart

> > -static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
> > +static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
> >  {
> >       struct da8xx_ohci_hcd *da8xx_ohci =3D data;
> > +     struct device *dev =3D da8xx_ohci->hcd->self.controller;
> > +     int ret;
> >
> > -     if (gpiod_get_value(da8xx_ohci->oc_gpio))
> > -             gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
> > +     if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
> > +             if (da8xx_ohci->vbus_gpio) {
> > +                     gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0=
);
> > +             } else if (da8xx_ohci->vbus_reg) {
> > +                     ret =3D regulator_disable(da8xx_ohci->vbus_reg);
> > +                     if (ret)
> > +                             dev_err(dev,
> > +                                     "Failed to disable regulator: %d\=
n",
> > +                                     ret);
> > +             }
> > +
>
> Unnecessary empty line here, that too one that introduces white space
> error. Please drop.
>
> Thanks,
> Sekhar
