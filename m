Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB57C2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DB52077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRzJQiVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfLLNkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:40:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfLLNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:40:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so2326894ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PbHPLSXQGj0yJrSH192TMtAaxNo5rw41NetJ/dcUfw=;
        b=DRzJQiVQg/nQ/ASUfL3q6cDwUxWJ56eQnZWGgR+JOoveYSxcv7+j9kjbi9XlxA1AEO
         A02/XOPXYlK843ecHoWeaRH53jfl/cx5u3XSjbfE6QXM6s9uUsm05zfWWRKxADesDQaV
         PnpOe4EYjBF5MZNs5FNBPAYxERQpmPL1TeloXm3jpv3+AB/lT3PvU4ZBj/VaARR4vYaR
         uJAZHSCgQIgMRkQV60ebT26TmXAs0cOXjT+DYySEPkfd4IKU4kJpTPp6/Mka/ayB4hXZ
         fNwhN8IIW0TkBhIE6JdShsrKJP3KtegCAZBZzOcTXVPJ7RuZIJLfrFV04K8VZIFI/qoI
         sOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PbHPLSXQGj0yJrSH192TMtAaxNo5rw41NetJ/dcUfw=;
        b=Pnp4M52SQhCaLcEyPKxyn66sSg8YtGCp2V6Rfh10HzbuaAT9Ajcxjzt6Xjm2KtqTTO
         yHVVPpShHp6iaLnXbjydYaz9Xt3mTmxJc37pX2lsPRR+xEm+/Od1K4eQqGV6IF+Bg44F
         8cBAj9LnYyrPk49byfZOac8qnhYTyh8/zon2q1m1vta01NRF2dDAJ6qMJe1x0xKel2Ai
         r9o+Ml+JG2DRfxXikPc+EObYznbsYGYoooDJgT4sTI7maUQegdEu+8LpuHanrxOGhttm
         IswlILMomVKqBUBoaMXnzCy9om4kcckip0+inbTd6XD9Wj9UVc170+JiaPR3C5M0mOXi
         4ycA==
X-Gm-Message-State: APjAAAV9JemHBrIBEinkiA+VQ5y5QDpHPcB7ncsnOyZd8Jh6KExke1Ia
        xlRDpw4vyaQWpDv+G8VNGoSY1wTtoXK/IRdBFTrlnQ==
X-Google-Smtp-Source: APXvYqz4WIPVD6RaEfzhjt2nRL8Q3ReinXWMfS2taUKWfU1ppqbKjrPvuAhDEVOow4IVqRo34vof7KNX/xH9rfQS/Dc=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr6024597ljk.77.1576158044254;
 Thu, 12 Dec 2019 05:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be> <20191127084253.16356-4-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-4-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 14:40:29 +0100
Message-ID: <CACRpkdZs0_VvfpE34bgrMtBVeamCsq6BaqfyJc1tyvWCornSUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] gpiolib: Add support for GPIO line table lookup
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

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
>
> Add support for looking them up by line name.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

OK I see what you want to do...

> +               if (p->chip_hwnum == (u16)-1) {

If you want to use this then use:

if (p->chip_hwnum == U16_MAX)

from <linux/limits.h>

> +                       desc = gpio_name_to_desc(p->chip_label);
> +                       if (desc) {
> +                               *flags = p->flags;
> +                               return desc;
> +                       }
> +
> +                       dev_warn(dev, "cannot find GPIO line %s, deferring\n",
> +                                p->chip_label);
> +                       return ERR_PTR(-EPROBE_DEFER);
> +               }
> +
>                 chip = find_chip_by_name(p->chip_label);
>
>                 if (!chip) {
> diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
> index 1ebe5be05d5f81fa..84c1c097e55eefaf 100644
> --- a/include/linux/gpio/machine.h
> +++ b/include/linux/gpio/machine.h
> @@ -31,7 +31,7 @@ enum gpio_lookup_flags {
>   */
>  struct gpiod_lookup {
>         const char *chip_label;
> -       u16 chip_hwnum;
> +       u16 chip_hwnum;                 /* if -1, chip_label is named line */

/* if U16_MAX then chip_label is the named line we are looking for */

But the member name "chip_label" is completely abused with this
setup, it should then be renamed as part of the patch set to something
like chip_label_or_line_name so it is clear what it is or
just name it "const char *key".

But I'm not entirely convinced about reusing the existing
struct gpio_lookup for this.

What about constructing a new lookup struct specifically for this?
I understand it is more work, but will that not be more
maintainable and readable?

Yours,
Linus Walleij
