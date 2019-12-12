Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80429C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D40721655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSsBUJhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfLLNU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:20:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41297 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfLLNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:20:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so2254699ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 05:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg7Wl/6CET3pvbTGNm/tGvdeGMQk6gSudBEEyfBygCo=;
        b=SSsBUJhxA1aRWawSyAxOR8XEmSe8IeDhUogI22JjnRdTk3guoUUCNE18wU5spaIBSN
         Tge40xKNTf2c46f/Ct3PtBV62vLDyTgN2F3kU/LEPoq1BJ2nnzBXF8JYtD2eEX1mqIJz
         rW7wDkFNi5MxHljIDydZyIjHe6qK9dZp/ZzKZFTU8OzgxhvVNWUmlr/+DUAbJCPCYqdT
         SZmfh20Q3fi5Bhn0MuHL9ePyN6uLVtDrP1daGTkTkZZvu5ew56B9/mLwobAy+2/ftSrB
         0Q9aN+TRxhkjgCuoZ7lNHssuUGfAJkwH65uRfr9oM3Du3HhN0ra9yv9gV/v3pVzTcRo0
         0k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg7Wl/6CET3pvbTGNm/tGvdeGMQk6gSudBEEyfBygCo=;
        b=TLnWKAxtR2Sig7qwL/uTSl9LcTgYXQWvi5MfbIqroWfRV/zqpK5FElC3Kf/8gJcsSY
         aksTkKd7fYDCuDKZ+CvaIAW63u4fct2ftzuedlWfIk+bCiCQ9d7PF6SSClWkWsaVxwfU
         ajKn9U5vqJmhv6NuH7L9nnQg4oeAcaoLrnsGlOVQJLTqtMbLJ1lmZgISll+8pzUwYw+O
         YsXLEfD08GNUauAj7PF2vZ4oipBXHu1LYgLzCRktIj05OTAKvt4pztepjYy3u8RWaVDj
         //O+1qnvdXDEz9XqnKJcT171CfdrJXdQ2vzFrX+Tk9S8I2U41U6PB+bLj5768FRPvM6l
         E0NQ==
X-Gm-Message-State: APjAAAXTg91AFeXsSCOG/rVE0+1umUPRBSeQ1NNV+0GACj0uZr0VuH86
        Ii2ZS+xnpxSoHWV2mGO525cVkVnQNy8klPIQM1yapw==
X-Google-Smtp-Source: APXvYqw5fhzsAgc+HL+XC84iHcSjemi0g8V+vxBZMQOSmUPecN5cY5o5jyiYAB8ZURwvkZwuG5+myIg9qUaLJdi8vHI=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr5871004ljh.183.1576156856527;
 Thu, 12 Dec 2019 05:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be> <20191127084253.16356-3-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-3-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 14:20:45 +0100
Message-ID: <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table lookup
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIO controllers can only be referred to by label in GPIO
> lookup tables.
>
> Add support for looking them up by "gpiochipN" name, with "N" either the
> corresponding GPIO device's ID number, or the GPIO controller's first
> GPIO number.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

What the commit message is missing is a rationale, why is this needed?

> If this is rejected, the GPIO Aggregator documentation must be updated.
>
> The second variant is currently used by the legacy sysfs interface only,
> so perhaps the chip->base check should be dropped?

Anything improving the sysfs is actively discouraged by me.
If it is just about staying compatible it is another thing.

> +static int gpiochip_match_id(struct gpio_chip *chip, void *data)
> +{
> +       int id = (uintptr_t)data;
> +
> +       return id == chip->base || id == chip->gpiodev->id;
> +}
>  static struct gpio_chip *find_chip_by_name(const char *name)
>  {
> -       return gpiochip_find((void *)name, gpiochip_match_name);
> +       struct gpio_chip *chip;
> +       int id;
> +
> +       chip = gpiochip_find((void *)name, gpiochip_match_name);
> +       if (chip)
> +               return chip;
> +
> +       if (!str_has_prefix(name, GPIOCHIP_NAME))
> +               return NULL;
> +
> +       if (kstrtoint(name + strlen(GPIOCHIP_NAME), 10, &id))
> +               return NULL;
> +
> +       return gpiochip_find((void *)(uintptr_t)id, gpiochip_match_id);

Isn't it easier to just  augment the existing match function to
check like this:

static int gpiochip_match_name(struct gpio_chip *chip, void *data)
{
        const char *name = data;

        if (!strcmp(chip->label, name))
               return 0;
        return !strcmp(dev_name(&chip->gpiodev->dev), name);
}

We should I guess also add some kerneldoc to say we first
match on the label and second on dev_name().

Yours,
Linus Walleij
