Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C4C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77612081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng5Uk4LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfLDMn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:43:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39401 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLDMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:43:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so3136688plk.6;
        Wed, 04 Dec 2019 04:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rroQt6MWI6gXv5LyOkAfcaRFmaX8lqvLShAzpXM9Ft8=;
        b=ng5Uk4LKFFOh1mK0Ub9D1oVeuP5KRHZ0rkKuV3FtsnaGVOX2rqT+LueF1mQM8pCnDs
         F/AafqRuEk3R4mCNu7nmM3L/MeU0VfQd14QLxj+QXV9rdq7WqdqwnveBP0YBRb44rbJV
         wZoYP8+6WodwkTMoX+RrMRVtUAkNqMDqEzuprwvBdBggrpWXmvY5t5OTwfoTO1Pl/S9f
         7Z5UPWH4K6GKvLfRHkI0BzL3zzEM/OPLHy+3wkto0x4ye0/0aExQtmXtWdBAV9YhPA6g
         QCWOBvt4UnxewjKbbeKmdaDfnxG2ECopbS4CRGHV9oEgbONYt1pnJGrqNrDjQ9cMJcDU
         mbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rroQt6MWI6gXv5LyOkAfcaRFmaX8lqvLShAzpXM9Ft8=;
        b=qEbUXljZ4uBBrk9sSQNCiOJ3iQK2jx4rfwpulFLbSOW6pXyGI8kwtyx8sLBgI5O89M
         0mdcgVLrh4MOVzir77ftKlCUxzPrGLsSQnprEgMEdhAtKEda2bY5BJ6VJlkIf2taI7IG
         5WO5Lfp2z6m78gB8kxUIdqFw0ThN1YJy/WL3U3JRV9r2igikq8r2Jf5t/W1ozAB5/rE/
         mNawQkM4g5uoG2x9GFZ8N+c+uIaFYTu9YnRM7GGrO2iO4Ckmbr2cdZW1g3JSOYS02u5f
         RzJ4dLMLF2hgl2mD/IYQ3dpwpeeK/5jGJHlLouxnreqaNf3pZDFGLGn2Jyhj0b/a/6Mg
         096Q==
X-Gm-Message-State: APjAAAWCwO5sike00u51AKOeoyElwPcVLv1ROTpRJXA9E7o9Lr2QflAK
        OX9dkLIVbaTRoTe7WKlnWow7PoANywqQdanayaYV9Vtk
X-Google-Smtp-Source: APXvYqz7AaBnpNMIJzne2dUq7oVvam/+4QrlvzHjQUCxAK3jUCAWujCihCWQIAOys66hOcMU+4f5alZ4AnA/TpY24Ho=
X-Received: by 2002:a17:90a:c68f:: with SMTP id n15mr3156655pjt.20.1575463406708;
 Wed, 04 Dec 2019 04:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20191204101042.4275-5-cleger@kalray.eu>
In-Reply-To: <20191204101042.4275-5-cleger@kalray.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Dec 2019 14:43:16 +0200
Message-ID: <CAHp75VdQ6VooLVAfA1z98-bBcfQuR7AomaO8F19AGRjeBtByEQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: dw: add pinctrl support for dwapb gpio driver
To:     Clement Leger <cleger@kalray.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:12 PM Clement Leger <cleger@kalray.eu> wrote:
>
> Synopsys designware gpio controller also has pinmuxing functionnality.

DesignWare
pin muxing
functionality

(Please, run a spell checker)

> Pinmuxing allows to choose between software and hardware mode. When

Pin muxing

> using hardware mode, an external signal controls the pin output.
>
> This patch adds support for pinctrl framework in the gpio driver. This

GPIO

> support is conditionned by the snps,has-pinctrl device tree property.

conditioned

> Indeed, the functionnality can be detected only if the gpio IP has been

functionality

> configured using paremeters encoding which is not always present. If

parameters

> property is present, then the pinctrl will be registered and will

> allow switching to the "hw" functionnality and hence enable the

functionality

> alternate function.

> +static const struct pinctrl_pin_desc dwapb_pins[] = {
...
> +       DWAPB_PINCTRL_PIN(31)

Keep comma in such cases.

> +};

Can't you split adding pin control data to a separate patch?

> +/* One pin per group */
> +static const char * const dwapb_gpio_groups[] = {
...
> +       "pin31"

Keep comma here.

> +};

Can't we generate these lists dynamically?

> +       dev_info(gpio->dev, "Setting func %s on pin %d",
> +               dwapb_gpio_functions[selector], group);

Noise!

> +       ret = pinctrl_enable(port->pctl);
> +       if (ret) {
> +               dev_err(gpio->dev, "pinctrl enable failed\n");
> +               return ret;
> +       }

Not sure why it's needed at all.

> +       range = &port->range;
> +       range->name = dev_name(gpio->dev);
> +       range->id = port->idx;
> +       range->pin_base = 0;
> +       range->base = port->gc.base;
> +       range->npins = pp->ngpio;
> +       range->gc = &port->gc;
> +
> +       pinctrl_add_gpio_range(port->pctl, range);

Can you use new callback for this?

> -               .name   = "gpio-dwapb",
> +               .name   = "pinctrl-dwapb",

This will break existing users.

-- 
With Best Regards,
Andy Shevchenko
