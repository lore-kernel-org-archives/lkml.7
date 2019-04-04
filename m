Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134E3C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594C20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiuN158Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfDDJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:50:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42863 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfDDIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id f15so879816vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaRqkLICECpnp6i7UhmqnYU8106nFA+94RKUdLSMYIU=;
        b=hiuN158ZtbTKG6FJjHSanlt2JCh63XHx+7nxoiHVWXIJ+EXSAeWjiXvDXj+vjJ2tJL
         Bo4xt5+1SyGvGJpBpLgfP/I80TNyucVzb+9+v78/g/EQSwDrFDQaj6n61glP/cM2MBrP
         YsZJjUpSNWklqeRqmhFBNAmRv2n0vyFVPT8ClDMAU20ozf2Hc/5KGTRtFQuK+glbV4c7
         +0cnokwxUhrSYpptRuAivx5FXkxIrDakPOf9xwmGAk5geeEC/NzhcpPK7ZAKdBsx3H71
         KzT2wCQg+fMkynJEHYwaHmDinwg7ZmB0C9TUUbeKC6aBZrM7kSwQsO4VCBgQCJfXj4h6
         MrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaRqkLICECpnp6i7UhmqnYU8106nFA+94RKUdLSMYIU=;
        b=q13I28xwWyUt5Ij27H933+HhcaPsMfQpqFdyClM8m8Twzdpe5l63Q+nanCded0vWc2
         xVy6LnY/4g7wR6MtyaRWZV9pEZZMYQ9AfFw5d/76RrRecOCSsujB89KNwAJNqZtkiB0+
         4LfT0EeNyJbOw6VD8j0FDoE/f8tNapmBM7iEydw0R0MZCRxtgafZ3gJTyceFkRO1LSoE
         JVqWAorGAoXVXCinlFIUnOKrBLRpNVp0/c4X/Su2ShQ71kzmyQ84E6aWlgUx6qySB0ET
         oSHR3hm7obs9xMjWbWJGaQ+dGw26hshsj4dd59D3kP0YVitp8YoXo1OEbplslMQa8bvx
         8eaA==
X-Gm-Message-State: APjAAAX3TvecrdikE4SB6VdtPTWnrvcoY1UBaiJ+QA2nkbalXwY9CqGr
        ZIpFjSBGJnK7jl2ZUf0EGJnYEwLd+r8qlvSwV6cvGQ==
X-Google-Smtp-Source: APXvYqwbiaLKa3Km0LdGtv2PGPvX3mvN6OdoCTCdnBPesX3xd78BXnBnNqyR3pF4MqdPgRqs/IX0+PZG7T4Tj/eH2X0=
X-Received: by 2002:a67:fa04:: with SMTP id i4mr3319732vsq.18.1554368123396;
 Thu, 04 Apr 2019 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190320103927.21227-1-geert+renesas@glider.be>
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Apr 2019 10:54:45 +0200
Message-ID: <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-gpio@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 11:39, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
>
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note that I don't really need this on the Renesas Ebisu-4D board, as
> there is no regulator or PM Domain controlling power to the GPIO
> expander on that board.  I did want to have all wake-up path processing
> implemented in the driver for completeness, and did test its behavior
> with gpio-keys configured as a wake-up source.

All above makes perfect sense to me.

>
> However, while this approach is known to work fine on other boards, with
> other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> device suspend ordering.
>
> The proper ordering is:
>   1. When gpio-keys is suspended, its suspend handler calls
>      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
>      pca953x_chip.wakeup_path to be incremented,
>   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
>      and marks the device to be part of the wake-up path.

Right.

>
> However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> scheme :-(

Would it make sense to fixup the ordering issue via creating a
parent/child relationship or setting up a device link?

>
> So depending on topology, this may work, or not...
> ---
>  drivers/gpio/gpio-pca953x.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 88c94d155e218535..349d0ccb5285a6c4 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -153,6 +153,7 @@ struct pca953x_chip {
>         u8 irq_trig_fall[MAX_BANK];
>         struct irq_chip irq_chip;
>  #endif
> +       atomic_t wakeup_path;
>
>         struct i2c_client *client;
>         struct gpio_chip gpio_chip;
> @@ -581,6 +582,11 @@ static int pca953x_irq_set_wake(struct irq_data *d, unsigned int on)
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>         struct pca953x_chip *chip = gpiochip_get_data(gc);
>
> +       if (on)
> +               atomic_inc(&chip->wakeup_path);
> +       else
> +               atomic_dec(&chip->wakeup_path);
> +
>         return irq_set_irq_wake(chip->client->irq, on);
>  }
>
> @@ -1100,7 +1106,10 @@ static int pca953x_suspend(struct device *dev)
>
>         regcache_cache_only(chip->regmap, true);
>
> -       regulator_disable(chip->regulator);
> +       if (atomic_read(&chip->wakeup_path))
> +               device_set_wakeup_path(dev);
> +       else
> +               regulator_disable(chip->regulator);
>
>         return 0;
>  }
> @@ -1110,10 +1119,12 @@ static int pca953x_resume(struct device *dev)
>         struct pca953x_chip *chip = dev_get_drvdata(dev);
>         int ret;
>
> -       ret = regulator_enable(chip->regulator);
> -       if (ret != 0) {
> -               dev_err(dev, "Failed to enable regulator: %d\n", ret);
> -               return 0;
> +       if (!atomic_read(&chip->wakeup_path)) {
> +               ret = regulator_enable(chip->regulator);
> +               if (ret != 0) {
> +                       dev_err(dev, "Failed to enable regulator: %d\n", ret);
> +                       return 0;
> +               }
>         }
>
>         regcache_cache_only(chip->regmap, false);
> --
> 2.17.1
>

Looks good to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
