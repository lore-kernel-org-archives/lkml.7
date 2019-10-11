Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA0ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C07214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V+/1YHgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfJKAKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:10:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46158 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfJKAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:10:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id 89so6461877oth.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CuWkKPMdB1z+o+XfUfQqodALV/gMtOa1+iT3xGY2djM=;
        b=V+/1YHgBwaJ9G2xcvRbf0wcjQADYe+tc7H7ZIRB7G1sOOk836UV02AeFA/O5/6uGBT
         9nDajgKdzPf7ZRtDvF31VQ/FHVVJPLSPoOv22VRoezeLKolwFKGjdfKlG+IlwzA2e8n2
         0BW9sJtbOq5sGr4eL8Jh8x9OwG5s2bJ0qO7A9RjB3P3Lz0K+nT2EsqZ2QL3ADcDUbv2P
         sdm0g5BsD4mHrgJT8Br7uZ9O2tAWROQhhddwUZnJlGb/AC0vtckBaGv9BJqIJXfa4Huc
         SJNgdhq8vYH/xOX+be8gAGhR7ND7CBqEAEVlFn72LIH0B3Hv8u1e94R8e+YZnU3QUU3d
         TWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CuWkKPMdB1z+o+XfUfQqodALV/gMtOa1+iT3xGY2djM=;
        b=tnn6WxzO68e9SMaJUqoRQRybjRiQuoNirXJU2IYtr8zKEqUln3/swCHN1gEi/2AnSc
         uD5AkYDIKO5XVljcAoAmbpFWnLr1A7nFyHcf/B1KQT+CjuTDyS8D0nzNQr6iCgUa9nfb
         bVt1OYarT4QDXPgRFfb44iaLPdUX90nhoAGsQA5H+T9k4wzhfEAin9kzPp97t9WmrO5E
         OVV1mZ0DpsOmaJ4w+p5za4Dj1R76C0aAK6IkdOwwE3/V3acXk51rPolSbCsdagpzqLlI
         OHKB+FvLzbSFFa8lgrnzrfW9QJSXf84GoT/pOnDbmODnmrEwB3X93YoAJUC2oBRqH7OL
         mPvw==
X-Gm-Message-State: APjAAAXWJiEXPNJZ0iPr/JosON4lCMoP+kJ9ygeZrM9aYj6NS/NS/UkC
        +JYVhJRoiDM1ZM1mg+JcaY4RpIMRHApOdw+uSozFkg==
X-Google-Smtp-Source: APXvYqxZtpd1aw+WFgfMgVMfM/xQ2kYk0LHsr36Je/tEarbEcU93KFwlv3DkanirryaTd1tkYOZSPT3ZJwWCtI5udb4=
X-Received: by 2002:a05:6830:1685:: with SMTP id k5mr10285631otr.250.1570752651991;
 Thu, 10 Oct 2019 17:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023205.8071-1-hui.song_1@nxp.com>
In-Reply-To: <20191010023205.8071-1-hui.song_1@nxp.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 11 Oct 2019 02:10:41 +0200
Message-ID: <CAMpxmJXyoMu-Z0E0wejLSrgW3aE73fHxHxS3kANBoVY+FhfmGg@mail.gmail.com>
Subject: Re: [PATCH v7] gpio/mpc8xxx: change irq handler from chained to normal
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 10 pa=C5=BA 2019 o 04:42 Hui Song <hui.song_1@nxp.com> napisa=C5=82(a=
):
>
> From: Song Hui <hui.song_1@nxp.com>
>
> More than one gpio controllers can share one interrupt, change the
> driver to request shared irq.
>
> While this will work, it will mess up userspace accounting of the number
> of interrupts per second in tools such as vmstat.  The reason is that
> for every GPIO interrupt, /proc/interrupts records the count against GIC
> interrupt 68 or 69, as well as the GPIO itself.  So, for every GPIO
> interrupt, the total number of interrupts that the system has seen
> increments by two.
>
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@nxp.com>
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>
> ---
> Changes in v7:
>         - make unsigned int convert to unsigned long.
> Changes in v6:
>         - change request_irq to devm_request_irq and add commit message.
> Changes in v5:
>         - add traverse every bit function.
> Changes in v4:
>         - convert 'pr_err' to 'dev_err'.
> Changes in v3:
>         - update the patch description.
> Changes in v2:
>         - delete the compatible of ls1088a.
>  drivers/gpio/gpio-mpc8xxx.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 16a47de..5a0f030 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -22,6 +22,7 @@
>  #include <linux/irq.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/bitops.h>
> +#include <linux/interrupt.h>
>
>  #define MPC8XXX_GPIO_PINS      32
>
> @@ -127,20 +128,20 @@ static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc=
, unsigned offset)
>                 return -ENXIO;
>  }
>
> -static void mpc8xxx_gpio_irq_cascade(struct irq_desc *desc)
> +static irqreturn_t mpc8xxx_gpio_irq_cascade(int irq, void *data)
>  {
> -       struct mpc8xxx_gpio_chip *mpc8xxx_gc =3D irq_desc_get_handler_dat=
a(desc);
> -       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +       struct mpc8xxx_gpio_chip *mpc8xxx_gc =3D data;
>         struct gpio_chip *gc =3D &mpc8xxx_gc->gc;
> -       unsigned int mask;
> +       unsigned long mask;
> +       int i;
>
>         mask =3D gc->read_reg(mpc8xxx_gc->regs + GPIO_IER)
>                 & gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR);
> -       if (mask)
> +       for_each_set_bit(i, &mask, 32)
>                 generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
> -                                                    32 - ffs(mask)));
> -       if (chip->irq_eoi)
> -               chip->irq_eoi(&desc->irq_data);
> +                                                    31 - i));

This will now fit in 80 characters.

Bart

> +
> +       return IRQ_HANDLED;
>  }
>
>  static void mpc8xxx_irq_unmask(struct irq_data *d)
> @@ -409,8 +410,16 @@ static int mpc8xxx_probe(struct platform_device *pde=
v)
>         if (devtype->gpio_dir_in_init)
>                 devtype->gpio_dir_in_init(gc);
>
> -       irq_set_chained_handler_and_data(mpc8xxx_gc->irqn,
> -                                        mpc8xxx_gpio_irq_cascade, mpc8xx=
x_gc);
> +       ret =3D devm_request_irq(&pdev->dev, mpc8xxx_gc->irqn,
> +                              mpc8xxx_gpio_irq_cascade,
> +                              IRQF_NO_THREAD | IRQF_SHARED, "gpio-cascad=
e",
> +                              mpc8xxx_gc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "%s: failed to devm_request_irq(%d), =
ret =3D %d\n",
> +                       np->full_name, mpc8xxx_gc->irqn, ret);
> +               goto err;
> +       }
> +
>         return 0;
>  err:
>         iounmap(mpc8xxx_gc->regs);
> --
> 2.9.5
>
