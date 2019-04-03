Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613FA206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PhhWKAn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDCPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:36:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41753 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:36:18 -0400
Received: by mail-io1-f68.google.com with SMTP id v10so14427654iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1PqxlDSB/yup+I5RPK8mK9xg9Ow2LmDYOD8f7wc+SOM=;
        b=PhhWKAn3OFEsGp+QpuM2D2iyq/k9grlr4nUM54mq4DQf4N48/ltFnwRWcnxNigRBXe
         Eg+AeVrA4iieUnRDh/C9jNgyUq21WY4qGELpA5DThki6sWcNH0P52JdM1gqLwsV5Nsxo
         igNLHrc7QsC30ZhF6tTHPfbe3ojjGvVCwy8GIf4inGJOtjvmy6bQxWDg2lLJjaH/HmjD
         vSOXUeftMaAuSgKtxI/2dAFWuAz0+P5VVl6cADryy0OW4RRekR3MZJM4vkbm/vZORbma
         YmxXvbuzSGKe5sn2WkoLyuDJuerYKsKSER2ypVjHezpCFi6LTqCsxlj5fxOhY+gERqE5
         RQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1PqxlDSB/yup+I5RPK8mK9xg9Ow2LmDYOD8f7wc+SOM=;
        b=gfrm8/iU8mqrEXotwCHRdq29x4eAHnBx1Mf1+lZpGhI9+Gp/C2H2+mCtI+YkIMWARK
         wxspzC6NYHkZzWmtrcyudvdjtTLcQA+BTYd2s5Pfc5eZj3ZvWqK+2cHwTAcf/Km6ZsEJ
         KO2z0Wzu3ProT//Xhi9OcWTvJvH2mA9Ty6GcxqmBx/LkrdYFabUuvOhAGvJF2lp9A7Ov
         GB96IwsSrpBi3jEB8oNy455tH1TuW9Qg5j0F75KtO4nI4QVu66WqYt3ec1VmsZzUA59F
         zacObf/VjMbwl1WbHiFTygD6y4K/04XJWzzOz0oU0yIKFzxaAGlUoQ154rG99QrP3WY6
         U2BA==
X-Gm-Message-State: APjAAAXIx1kek6tLWH/jG5Yg0MPjKgJpxXaBgLwicAFMwXEKVxNmG5hU
        tU8OZNwyQ8eEY9ousQlW9oFJEFSeqGZedQWd3Z5LHg==
X-Google-Smtp-Source: APXvYqxNdeKHMKjobuOExFqdsiwU7ffR9fRBK0AKTrZ4Q82l5Xzy6Ne96PiERW631DXIhtgWUYgs3LqKbmjWnlpdGFU=
X-Received: by 2002:a6b:4e17:: with SMTP id c23mr555941iob.212.1554305777867;
 Wed, 03 Apr 2019 08:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190329093334.3885-1-brgl@bgdev.pl> <20190329093334.3885-4-brgl@bgdev.pl>
In-Reply-To: <20190329093334.3885-4-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 Apr 2019 17:36:07 +0200
Message-ID: <CAMRc=MdNxZ0L+j7VBz32y-nJgJmgN73-o0YWQct8DkWoyttFGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] usb: ohci-da8xx: disable the regulator if the
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

pt., 29 mar 2019 o 10:33 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
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
> ---
>  drivers/usb/host/ohci-da8xx.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.=
c
> index 9c6d1f03b871..35eb2cb96a8f 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -206,8 +206,25 @@ static irqreturn_t ohci_da8xx_oc_handler(int irq, vo=
id *data)
>  {
>         struct da8xx_ohci_hcd *da8xx_ohci =3D data;
>
> -       if (gpiod_get_value(da8xx_ohci->oc_gpio))
> -               gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
> +       if (gpiod_get_value(da8xx_ohci->oc_gpio)) {
> +               if (da8xx_ohci->vbus_gpio)
> +                       gpiod_set_value(da8xx_ohci->vbus_gpio, 0);
> +               else if (da8xx_ohci->vbus_reg)
> +                       return IRQ_WAKE_THREAD;
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ohci_da8xx_oc_thread(int irq, void *data)
> +{
> +       struct da8xx_ohci_hcd *da8xx_ohci =3D data;
> +       struct device *dev =3D da8xx_ohci->hcd->self.controller;
> +       int ret;
> +
> +       ret =3D regulator_disable(da8xx_ohci->vbus_reg);
> +       if (ret)
> +               dev_err(dev, "Failed to disable regulator: %d\n", ret);
>
>         return IRQ_HANDLED;
>  }
> @@ -434,9 +451,11 @@ static int ohci_da8xx_probe(struct platform_device *=
pdev)
>                 if (oc_irq < 0)
>                         goto err;
>
> -               error =3D devm_request_irq(dev, oc_irq, ohci_da8xx_oc_han=
dler,
> -                               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLIN=
G,
> -                               "OHCI over-current indicator", da8xx_ohci=
);
> +               error =3D devm_request_threaded_irq(dev, oc_irq,
> +                               ohci_da8xx_oc_handler, ohci_da8xx_oc_thre=
ad,
> +                               IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLIN=
G |
> +                               IRQF_ONESHOT, "OHCI over-current indicato=
r",
> +                               da8xx_ohci);

Ugh I noticed a problem with this patch if the module is built-in -
after calling devm_request_threaded_irq() any subsequent msleep() will
hang. This doesn't happen if the driver is built as a module. I'm not
sure what the reason is yet.

Bart

>                 if (error)
>                         goto err;
>         }
> --
> 2.21.0
>
