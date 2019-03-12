Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8939DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCLTBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:01:32 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46625 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfCLTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:01:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id b17so2252227vsr.13;
        Tue, 12 Mar 2019 12:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BZRbNIhNOurSroe/tJA+wYWjkSTRqpJteypzf8z5ZY=;
        b=GoimaU9CZqGAOHxMHTIzgU68W2H51+0Uor4nqte4KhaZ7tuv15m03DqVeGrTl09hlO
         yaKF2AaihO2tnNqk6Nk+3AAD7ap4CFhSOry6F1fxvGOUY0G42ykkG39A0ATMXNHifvlq
         09tfKwKI/tdZDck7ZBO72dOqS1gQfnzJ/qB7MBF/WZ1c67jsBO+M0/4ebXoQIHA8uX+N
         Pr8+AG6O0cKqY4qcoqQLlk7POx22gd0Eo4k5rgfqQxAEnuay7Mgv2eRxmmTtb0l7O0As
         Q1EdDQOyO10v62BsvlWecrdJu1tvfpKx/5hPghgn8KK3CSsSZjGudxzjNsNKWP1uyqAs
         EMfA==
X-Gm-Message-State: APjAAAWt1E8vIgzm12EaGQdOL3hvDGhIRS4uotMVr6PKdk13wR8d5kz0
        WqbuHCI2KCrsvJk6zYY3w1DD59MQ0Zwy8repErs=
X-Google-Smtp-Source: APXvYqxysHQXIqHYmdqvnbBM07paC9ZZ6c03m8bN64fTgyVkiDNpv4PX6cQML/O9ehxAVHB4/gq1norKxG+WwevEV8c=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr18640499vsc.96.1552417290536;
 Tue, 12 Mar 2019 12:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-27-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-27-git-send-email-info@metux.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 20:01:18 +0100
Message-ID: <CAMuHMdV4cT6rsA0DbGLRAzY8A6kXZ1C_2_GNjdXxamdXPA7_6w@mail.gmail.com>
Subject: Re: [PATCH 27/42] drivers: gpio: rcar: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com,
        vz@mleia.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-renesas-soc

On Mon, Mar 11, 2019 at 7:58 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -430,7 +430,7 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>  static int gpio_rcar_probe(struct platform_device *pdev)
>  {
>         struct gpio_rcar_priv *p;
> -       struct resource *io, *irq;
> +       struct resource *irq;
>         struct gpio_chip *gpio_chip;
>         struct irq_chip *irq_chip;
>         struct device *dev = &pdev->dev;
> @@ -461,8 +461,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>                 goto err0;
>         }
>
> -       io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       p->base = devm_ioremap_resource(dev, io);
> +       p->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(p->base)) {
>                 ret = PTR_ERR(p->base);
>                 goto err0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
