Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB27C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02D820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="etk7L6Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfHEIdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:33:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35810 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfHEIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:33:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so7789009otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SK2GcUNaPoshyb3rcnlaFPd6RDRmQQeILqNhYCzzkx8=;
        b=etk7L6SbSUwn9SEEG/ZzySoNLgioYjSs0sXFYocrQG5d7qCYs9n72q+LM2zjYkeP5X
         9MZc3qCQSqIuJeYeK/ERHWGeYt0p89nG/wRm881IPZz4u3lvud1WW43FhexJHDU1pyP5
         7TsYiqxJQQxCZsnwTRASur+1ASE1cFZ8a9iz9cwvI5GfGzVqOnplAlQn5+Ln8ozBri+M
         MOBbHw47pYxbyiHQRBeuK6X7FklvB2VBUpf2ew9oA1AeQs4wvV9nib/bjbNcwjdeV9iC
         sTjruAsLzXMc2TXcwF3uvmpCPdf6tL4aCkJQyZot0MoBlkcHL8KHsiRzxd15/G/HAigc
         shqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SK2GcUNaPoshyb3rcnlaFPd6RDRmQQeILqNhYCzzkx8=;
        b=Bgmo6EWBjTYAAvyZ8xOmHsOLJOIyX7sK5Q85RLZGZD+qBXQvRfST2Y1ITrp3GhF+sw
         YFfXgO26kW3To2Lc1r6AU5Go0eMUzGv7FaYI6bzfCniuTng3UavX8EMuF8Iq+GK4bFfN
         8I1VqRQ7roBbHvB1zRfEV0UVsv6XNwY0ZXvRYV38hkKFkVTW0HJgipn4SmcVPDpTeL19
         WSVg61VFL7fOAiyM96XVmnnrXN9Gv7tOSwOK68zq9w7L5IKbhCG0jGyhQvx8+gKQ4Dmk
         PyyUtQOYtt56jXx78aq6aMTXyAaxzr67HScJTvLOc6yitHdgcjTDvp94A58aPb1dPWvi
         XaQg==
X-Gm-Message-State: APjAAAVv9BFKwSjmQ5zm3crbeQLHT0NKrGLulEMa3bUBBFYzbHyu0Uda
        8+ckq1HvHVzUtFvhrbr9PEM8bVM8h1KsFbtcHLyijQ==
X-Google-Smtp-Source: APXvYqyhgJJWwu3uNj272/OydBU1ZLoQTCU8dHBG2fV5ZGtzG3CPqH+U3MZ3UzvVcA8tfQPN53esShIwlK5/3Z3NM7Q=
X-Received: by 2002:a05:6830:1291:: with SMTP id z17mr49091040otp.194.1564994023406;
 Mon, 05 Aug 2019 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190803133436.15016-1-rfried.dev@gmail.com>
In-Reply-To: <20190803133436.15016-1-rfried.dev@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 5 Aug 2019 10:33:32 +0200
Message-ID: <CAMpxmJWk+HOPTkQ8B1pw1RfkN1Ffan4+PJ9D_J-D6aUy44fR2Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Take MUX usage into account
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 3 sie 2019 o 15:34 Ramon Fried <rfried.dev@gmail.com> napisa=C5=82(a)=
:
>
> From: Stefan Wahren <stefan.wahren@i2se.com>
>
> The user space like gpioinfo only see the GPIO usage but not the
> MUX usage (e.g. I2C or SPI usage) of a pin. As a user we want to know whi=
ch
> pin is free/safe to use. So take the MUX usage of strict pinmux controlle=
rs
> into account to get a more realistic view for ioctl GPIO_GET_LINEINFO_IOC=
TL.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Tested-By: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> Sending Stefan's RFC as patch, as I tested it and it seems to work,
> additionally, an accompanying fix was made by me to gpiolibd to fix a
> display error of the actual result:
> https://patchwork.ozlabs.org/patch/1139923/
>
>  drivers/gpio/gpiolib.c           |  3 ++-
>  drivers/pinctrl/core.c           | 23 +++++++++++++++++++++++
>  drivers/pinctrl/pinmux.c         | 18 ++++++++++++++++++
>  drivers/pinctrl/pinmux.h         |  7 +++++++
>  include/linux/pinctrl/consumer.h |  6 ++++++
>  5 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e013d417a936..2fd9eee0b98c 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1082,7 +1082,8 @@ static long gpio_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
>                     test_bit(FLAG_IS_HOGGED, &desc->flags) ||
>                     test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
>                     test_bit(FLAG_EXPORT, &desc->flags) ||
> -                   test_bit(FLAG_SYSFS, &desc->flags))
> +                   test_bit(FLAG_SYSFS, &desc->flags) ||
> +                   pinctrl_gpio_is_in_use(chip->base + lineinfo.line_off=
set))
>                         lineinfo.flags |=3D GPIOLINE_FLAG_KERNEL;
>                 if (test_bit(FLAG_IS_OUT, &desc->flags))
>                         lineinfo.flags |=3D GPIOLINE_FLAG_IS_OUT;
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index a64849a9d1b0..0dd00c175eed 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -759,6 +759,29 @@ int pinctrl_get_group_selector(struct pinctrl_dev *p=
ctldev,
>         return -EINVAL;
>  }
>
> +bool pinctrl_gpio_is_in_use(unsigned gpio)
> +{
> +       struct pinctrl_dev *pctldev;
> +       struct pinctrl_gpio_range *range;
> +       bool result;
> +       int pin;
> +
> +       if (pinctrl_get_device_gpio_range(gpio, &pctldev, &range))
> +               return false;
> +
> +       mutex_lock(&pctldev->mutex);
> +
> +       /* Convert to the pin controllers number space */
> +       pin =3D gpio_to_pin(range, gpio);
> +
> +       result =3D pinmux_is_in_use(pctldev, pin);
> +
> +       mutex_unlock(&pctldev->mutex);
> +
> +       return result;
> +}
> +EXPORT_SYMBOL_GPL(pinctrl_gpio_is_in_use);
> +
>  /**
>   * pinctrl_gpio_request() - request a single pin to be used as GPIO
>   * @gpio: the GPIO pin number from the GPIO subsystem number space
> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
> index 020e54f843f9..02d2751a4884 100644
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -70,6 +70,24 @@ int pinmux_validate_map(const struct pinctrl_map *map,=
 int i)
>         return 0;
>  }
>
> +bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin)
> +{
> +       struct pin_desc *desc =3D pin_desc_get(pctldev, pin);
> +       const struct pinmux_ops *ops =3D pctldev->desc->pmxops;
> +
> +       if (!desc) {
> +               dev_err(pctldev->dev,
> +                       "pin %u is not registered so it cannot be request=
ed\n",
> +                       pin);
> +               return false;
> +       }
> +
> +       if (ops->strict && desc->mux_usecount)
> +               return true;
> +
> +       return ops->strict && !!desc->gpio_owner;
> +}
> +
>  /**
>   * pin_request() - request a single pin to be muxed in, typically for GP=
IO
>   * @pin: the pin number in the global pin space
> diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
> index 794cb3a003ff..24ae61136803 100644
> --- a/drivers/pinctrl/pinmux.h
> +++ b/drivers/pinctrl/pinmux.h
> @@ -15,6 +15,8 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev);
>
>  int pinmux_validate_map(const struct pinctrl_map *map, int i);
>
> +bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin);
> +
>  int pinmux_request_gpio(struct pinctrl_dev *pctldev,
>                         struct pinctrl_gpio_range *range,
>                         unsigned pin, unsigned gpio);
> @@ -42,6 +44,11 @@ static inline int pinmux_validate_map(const struct pin=
ctrl_map *map, int i)
>         return 0;
>  }
>
> +static inline bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigne=
d pin)
> +{
> +       return false;
> +}
> +
>  static inline int pinmux_request_gpio(struct pinctrl_dev *pctldev,
>                         struct pinctrl_gpio_range *range,
>                         unsigned pin, unsigned gpio)
> diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/con=
sumer.h
> index 86720a5a384f..d26826b057a1 100644
> --- a/include/linux/pinctrl/consumer.h
> +++ b/include/linux/pinctrl/consumer.h
> @@ -24,6 +24,7 @@ struct device;
>  #ifdef CONFIG_PINCTRL
>
>  /* External interface to pin control */
> +extern bool pinctrl_gpio_is_in_use(unsigned gpio);
>  extern int pinctrl_gpio_request(unsigned gpio);
>  extern void pinctrl_gpio_free(unsigned gpio);
>  extern int pinctrl_gpio_direction_input(unsigned gpio);
> @@ -61,6 +62,11 @@ static inline int pinctrl_pm_select_idle_state(struct =
device *dev)
>
>  #else /* !CONFIG_PINCTRL */
>
> +static inline bool pinctrl_gpio_is_in_use(unsigned gpio)
> +{
> +       return 0;
> +}
> +
>  static inline int pinctrl_gpio_request(unsigned gpio)
>  {
>         return 0;
> --
> 2.22.0
>

Looks good to me.

Linus: do you see any issues with that? If not, I can pick it up.

Bart
