Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309862082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A5spJEAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfDLMiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:38:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37557 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDLMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:38:16 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so15217824itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ane6YKMR1pWYkffJSXuaHDPMnOw6zUnYRWo0YgeFabk=;
        b=A5spJEARDHhg9TLZ56N9kutO1OdLDEXHb/Wc25z/xeeLcP0hptI0VLx5u8EHT/juFE
         Yp4Ixg5U9sB5T/gfFmPbEiptZ7xDP3ZCA1HhELF7/MGAkqQKsWOgkFqQUv/GhdCTqCkJ
         tmj99PFjWjhJuHvsI22gmTXH1Q4+XhrYiowj44XltGns0V2kAOIbFWQYS8uHYtNeRP6Y
         4QOFbdf83zhBApokqkheMm16IEYntGfnrxAzWvHnLAd6y7a08W6K188Bjv4dzIaA+OeW
         +TKs5sB52EuT+TRMxFt/aznvxBabE8HaBDupnPZM10X/zRxzHr7qhndGEGGMIK26E7nd
         gRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ane6YKMR1pWYkffJSXuaHDPMnOw6zUnYRWo0YgeFabk=;
        b=IluM4nMTuQL+1P6x3KvQxvPtZsQVtX4cL7KyCkfnzNk3h51sieVPEgSXBJBOFC60jo
         6Rdt+k4vieu8kW2w6FXI3XXkOUZC4++bYvPzI1HUgsz/6Qc8Haxq08s5n8SKVyNp3Di7
         /daVuYGOiRIcC7F6Ifpg5cDPuip2zW736A50a0Ay4oOtxwyAuK1JJ1czUQEcT6CuVib4
         ZfutAJwKUaGmUVwODcvYlvsxUb9KXwzJkoQhJVIHmQKQvnsKb8ESlneaa3pz7iImDx9+
         4q/gTy1dwkRTs7KCBmoT5UKNgnxeedudA0tTwIOb4znJNLhPVELvCElksrk3By90SPbX
         qiZQ==
X-Gm-Message-State: APjAAAVKoiOTNpJJEpxb7CQaQt4u+SEnBIS3OT3d5bOPO4VBWTYC/ktI
        AGECihGR6oyknMfBMuDACNB76jPIYlGbaBpVttoGnu88Wok=
X-Google-Smtp-Source: APXvYqzyFb1u2GzJeIRUCa3Hs5/nKTmq+A4x5q3ZS7iCdOkJnVD3M0QcWjj4x/hIQD+0M2yKx7BShrlGNMAAbi05Fnk=
X-Received: by 2002:a24:ad2:: with SMTP id 201mr12314477itw.26.1555072695236;
 Fri, 12 Apr 2019 05:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190412123640.11437-1-brgl@bgdev.pl> <20190412123640.11437-4-brgl@bgdev.pl>
In-Reply-To: <20190412123640.11437-4-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 14:38:03 +0200
Message-ID: <CAMRc=MeoXotnKNrEmDb1_UnttGBRsh4Xj4Kjw0tand5kscx9bw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] usb: ohci-da8xx: disable the regulator if the
 overcurrent irq fired
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 12 kwi 2019 o 14:36 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Historically the power supply management in this driver has been handled
> in two separate places in parallel. Device-tree users simply defined an
> appropriate regulator, while two boards with no DT support (da830-evm and
> omapl138-hawk) passed functions defined in their respective board files
> over platform data. These functions simply used legacy GPIO calls to
> watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
> fires.
>
> Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> updated these GPIO calls to the modern API and moved them inside the
> driver.
>
> This however is not the optimal solution for the vbus GPIO which should
> be modeled as a fixed regulator that can be controlled with a GPIO.
>
> In order to keep the overcurrent protection available once we move the
> board files to using fixed regulators we need to disable the enable_reg
> regulator when the overcurrent indicator interrupt fires. Since we
> cannot call regulator_disable() from interrupt context, we need to
> switch to using a oneshot threaded interrupt.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Sekhar,

I forgot to include Alan's ack for v4:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ohci-da8xx.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.=
c
> index 209a262b5565..f69b339d45e5 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -202,12 +202,23 @@ static int ohci_da8xx_regulator_event(struct notifi=
er_block *nb,
>         return 0;
>  }
>
> -static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
> +static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
>  {
>         struct da8xx_ohci_hcd *da8xx_ohci =3D data;
> +       struct device *dev =3D da8xx_ohci->hcd->self.controller;
> +       int ret;
>
> -       if (gpiod_get_value(da8xx_ohci->oc_gpio))
> -               gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
> +       if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio)) {
> +               if (da8xx_ohci->vbus_gpio) {
> +                       gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0=
);
> +               } else if (da8xx_ohci->vbus_reg) {
> +                       ret =3D regulator_disable(da8xx_ohci->vbus_reg);
> +                       if (ret)
> +                               dev_err(dev,
> +                                       "Failed to disable regulator: %d\=
n",
> +                                       ret);
> +               }
> +       }
>
>         return IRQ_HANDLED;
>  }
> @@ -434,8 +445,9 @@ static int ohci_da8xx_probe(struct platform_device *p=
dev)
>                 if (oc_irq < 0)
>                         goto err;
>
> -               error =3D devm_request_irq(dev, oc_irq, ohci_da8xx_oc_han=
dler,
> -                               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLIN=
G,
> +               error =3D devm_request_threaded_irq(dev, oc_irq, NULL,
> +                               ohci_da8xx_oc_thread, IRQF_TRIGGER_RISING=
 |
> +                               IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>                                 "OHCI over-current indicator", da8xx_ohci=
);
>                 if (error)
>                         goto err;
> --
> 2.21.0
>
