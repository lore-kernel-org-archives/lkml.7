Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E12C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32702070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hyAuaiUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfJCI0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:26:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37186 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfJCI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:26:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id k32so1545659otc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2c98XkJu8f9CQph7lE9mYoT3U28m3fbSZG87BXYweWo=;
        b=hyAuaiUIgUINQ2HlGxD7FJuXbHjaazCjzREZ2O6AfkdZ2gV0NBavHq0XpectMWdXfO
         Z1gqdovS9uuubkqC+klDZYciVL74TruAeMnCpc9I2fn7bfzoi3pLDmOr+e9KeMlcEDjG
         t2GYDllybVdBlPCbgv7MOQ7jFR7bkpnvJKyOBd6ebmLTpSbNvFc1jRLJb8kGQcIm+JMg
         gtUlXwjlSKJEpCsr+7DefI690WQLgsBhAz3CjTwTFB8guRx0BFCKOm4VVSbj8YfejGEV
         H3UWlZZLn/ZhAAngswiY0YVJh3+eLLdIwumnIZGk2SwWol1p4cDnHID+u/YTdLyc2HJm
         Lq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2c98XkJu8f9CQph7lE9mYoT3U28m3fbSZG87BXYweWo=;
        b=cto8dPxic37TJbwIdo8vzCwbeelzsPtBF780C7dpCCoX3LSFs1kZJ4k3K78mQ1Fcxk
         nPdFlOfLbY2RT5iSSAsNDBQavftCPj/uKNaTZm+5Qcjw9Sb/7RhstM+eJjFx3aGqb6SG
         bZx1Jfv1EDdWMZ9/pi1m4cPhV/LJt/rbOK7hLPwQ25P3zQNLXKNJfn8a4+wQEksihWqG
         8SBiFq1jJ3CXFs5PoA2Zd2soCtGo6pobkogC9tLbKng88bn9j4ENX/VzVuTgPmrKMHc2
         6cz2gDGvnu8d50yBoJiQFCKU8W8yEyshQ2pqqNAdp8swdYdinJ4aUchM2s76OZb1vFR0
         6zwQ==
X-Gm-Message-State: APjAAAWlLDKjXLtD60PidaqSbuxGgWGRHAlPy9a9K9Gy4VsG7wxXXHwQ
        0TJVxkiht4FUmHHcjZ8Y9Rr1RidzBx8XxifYb6jTHQ==
X-Google-Smtp-Source: APXvYqzaGO//p033scVor+Rm1MJUTv/9y8tZQ2JRZEl1af11sCWJOXG9hNjus15aykiTXT3AftX+WLQrFrEXQ/3Y42E=
X-Received: by 2002:a05:6830:5a:: with SMTP id d26mr5687769otp.256.1570091188336;
 Thu, 03 Oct 2019 01:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190927100407.1863293-1-paul.kocialkowski@bootlin.com> <20190927100407.1863293-6-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190927100407.1863293-6-paul.kocialkowski@bootlin.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Oct 2019 10:26:17 +0200
Message-ID: <CAMpxmJWQ9iuNj8Nfhf0hVzP6piNPrb8_e7ucth0rmg8KwT4HdA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] gpio: syscon: Add support for the Xylon LogiCVC GPIOs
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

just two nits:

pt., 27 wrz 2019 o 12:04 Paul Kocialkowski
<paul.kocialkowski@bootlin.com> napisa=C5=82(a):
>
> The LogiCVC display hardware block comes with GPIO capabilities
> that must be exposed separately from the main driver (as GPIOs) for
> use with regulators and panels. A syscon is used to share the same
> regmap across the two drivers.
>
> Since the GPIO capabilities are pretty simple, add them to the syscon
> GPIO driver.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpio/gpio-syscon.c | 68 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 05c537ed73f1..cdcb913b8f0c 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -190,6 +190,70 @@ static const struct syscon_gpio_data keystone_dsp_gp=
io =3D {
>         .set            =3D keystone_gpio_set,
>  };
>
> +#define LOGICVC_CTRL_REG               0x40
> +#define LOGICVC_CTRL_GPIO_SHIFT                11
> +#define LOGICVC_CTRL_GPIO_BITS         5
> +
> +#define LOGICVC_POWER_CTRL_REG         0x78
> +#define LOGICVC_POWER_CTRL_GPIO_SHIFT  0
> +#define LOGICVC_POWER_CTRL_GPIO_BITS   4
> +
> +static void logicvc_gpio_offset(struct syscon_gpio_priv *priv,
> +                               unsigned offset, unsigned int *reg,
> +                               unsigned int *bit)
> +{
> +       if (offset >=3D LOGICVC_CTRL_GPIO_BITS) {
> +               *reg =3D LOGICVC_POWER_CTRL_REG;
> +
> +               /* To the (virtual) power ctrl offset. */
> +               offset -=3D LOGICVC_CTRL_GPIO_BITS;
> +               /* To the actual bit offset in reg. */
> +               offset +=3D LOGICVC_POWER_CTRL_GPIO_SHIFT;
> +       } else {
> +               *reg =3D LOGICVC_CTRL_REG;
> +
> +               /* To the actual bit offset in reg. */
> +               offset +=3D LOGICVC_CTRL_GPIO_SHIFT;
> +       }
> +
> +       *bit =3D BIT(offset);
> +}
> +
> +static int logicvc_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct syscon_gpio_priv *priv =3D gpiochip_get_data(chip);
> +       unsigned int reg;
> +       unsigned int bit;
> +       unsigned int value;

Can you put these on a single line?

> +       int ret;
> +
> +       logicvc_gpio_offset(priv, offset, &reg, &bit);
> +
> +       ret =3D regmap_read(priv->syscon, reg, &value);
> +       if (ret)
> +               return ret;
> +
> +       return !!(value & bit);
> +}
> +
> +static void logicvc_gpio_set(struct gpio_chip *chip, unsigned offset, in=
t val)
> +{
> +       struct syscon_gpio_priv *priv =3D gpiochip_get_data(chip);
> +       unsigned int reg;
> +       unsigned int bit;

Same here.

Bart

> +
> +       logicvc_gpio_offset(priv, offset, &reg, &bit);
> +
> +       regmap_update_bits(priv->syscon, reg, bit, val ? bit : 0);
> +}
> +
> +static const struct syscon_gpio_data logicvc_gpio =3D {
> +       .flags          =3D GPIO_SYSCON_FEAT_OUT,
> +       .bit_count      =3D LOGICVC_CTRL_GPIO_BITS + LOGICVC_POWER_CTRL_G=
PIO_BITS,
> +       .get            =3D logicvc_gpio_get,
> +       .set            =3D logicvc_gpio_set,
> +};
> +
>  static const struct of_device_id syscon_gpio_ids[] =3D {
>         {
>                 .compatible     =3D "cirrus,ep7209-mctrl-gpio",
> @@ -203,6 +267,10 @@ static const struct of_device_id syscon_gpio_ids[] =
=3D {
>                 .compatible     =3D "rockchip,rk3328-grf-gpio",
>                 .data           =3D &rockchip_rk3328_gpio_mute,
>         },
> +       {
> +               .compatible     =3D "xylon,logicvc-3.02.a-gpio",
> +               .data           =3D &logicvc_gpio,
> +       },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
> --
> 2.23.0
>
