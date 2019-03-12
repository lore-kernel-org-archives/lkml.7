Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dr3Q7Yn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCLJhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:37:52 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35584 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfCLJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:37:52 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2C9bc4N025734;
        Tue, 12 Mar 2019 18:37:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2C9bc4N025734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552383459;
        bh=ZwNetbz2Pt1VbQ3sMujgqlvUPKsyRAIvytTsSjSWouY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dr3Q7Yn1oNl49u/CWFr5IdWcu4r4s5pvb2/u814G+6EtmzRJedwPGe7lGC0RakaCp
         3U5G67m+Cwb3aaOz4febmp9/XhM9hmtm07RBtjoIdbt4Ocy8cNzLP5Yy2118r2OnI4
         NbeWRCgJ+Pjqi8k2MgbYlEmcDXcGjyidyxQJ3tPIv0q9YIQM6fwhu8ucyx1WkArOTY
         VEzZJJp33OiTK+sL/t2NpSBNMeLZIoW7b414DLIYaATms1l0yzWfIGMFu+sC/wG/Ix
         J90PR6dU8PbVxff9QpiBZ1wFtrYfLF+nUi7Jt47H1DfqA3fxU1Np2OuNXPhVWO8JBG
         Rah/xiRjE8Bsw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id z6so1083050vsc.0;
        Tue, 12 Mar 2019 02:37:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWWYpBYktxvfJOmD0jGUfSV8SzcvQBVFVEnh3Bqz9lJncns+i2e
        1GGw8hjrozOk4Qz5JqZiylrK+GBZIoHzfw0naQs=
X-Google-Smtp-Source: APXvYqy0GicoiUjDHQPqr1bMylqGHRqWqoA0oMZbk7/8fXwYnNrtllNOICoxvo0jKZ/OXa0yDHocHqFcjfqoo4XqoPQ=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr1878298vso.179.1552383458248;
 Tue, 12 Mar 2019 02:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-36-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-36-git-send-email-info@metux.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 18:37:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPyZVpN2JVT8v6qzXUNfu-dLqcwwSc-eZL+yMyMEFXCg@mail.gmail.com>
Message-ID: <CAK7LNASPyZVpN2JVT8v6qzXUNfu-dLqcwwSc-eZL+yMyMEFXCg@mail.gmail.com>
Subject: Re: [PATCH 36/42] drivers: gpio: uniphier: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        andrew@aj.id.au, Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:57 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/gpio/gpio-uniphier.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 0f662b2..93cdcc4 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -346,7 +346,6 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
>         struct uniphier_gpio_priv *priv;
>         struct gpio_chip *chip;
>         struct irq_chip *irq_chip;
> -       struct resource *regs;
>         unsigned int nregs;
>         u32 ngpios;
>         int ret;
> @@ -370,8 +369,7 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
>
> -       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->regs = devm_ioremap_resource(dev, regs);
> +       priv->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->regs))
>                 return PTR_ERR(priv->regs);
>
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
