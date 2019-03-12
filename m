Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E720C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBAD214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDP2aBYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCLCkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:40:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46780 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfCLCkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:40:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so864156ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 19:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVaTFBG0+lQoQppWGKUSe0AwIDjJIeYxpQN8IhuEwUQ=;
        b=uDP2aBYOzeTRbd4vVVBgOag7L67Y9vF0yY5RrEmvgHp/Vt+ygZm4EB56IApnZhO/O2
         NEJ3pfN2C5btCTA1Wunew3n1u1aI0Ew0pyXd3ezFrPFOWK1ZHYm+wqyjqqjwdm5GOFJ6
         2rnnrMAlTr8jZQamzrClUAgjylj6taKKkshpZ6A9dSYJCKuAzG84hrUh+/70oF6i0q/T
         R0Rhy+isJxx+1Aq2mpoxtksvgdRfdw6FR6cfKitil5vNYh9iY058U0DXwYztgRHJUinQ
         ZAVLcQ4NqpRUcq5MmqkBkLXfXoCDaiSFItlEkjPZdNHpmXobTVSiqUXcI143Itm0vT0U
         Yz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVaTFBG0+lQoQppWGKUSe0AwIDjJIeYxpQN8IhuEwUQ=;
        b=alIwhxprqedBsjs0+2P0yyejwhIOT9uoSgtoFmDXShNydyjvgzlWFbYFHpEQyiz+mg
         w/8010GS3FIEPC4l63BY8jaduQyrdt7+F91UuFvadRpw6UTEyo9QHdrXG049j38ZVzmY
         JLYdgbl1mk62z9gZQGYIZ+8c9lMPWfKSc+u0oH/VFA1Ei2zmrAfIkEZ6+oLH6apkSzZy
         1cz5kqEyglTjET8SK1Hn2Uaw95lc13vPeFGu3CfBKwntvLol55TW4ijYCQjXcDRTiRcz
         5fNvoUEdtTEqHq71HR8DAoYzxPmnU3C/3EIGE51fR/urE6ThFdHEtP9NiVKY5LXQVcAc
         UQnQ==
X-Gm-Message-State: APjAAAWawljTtLPEIlCbb4cL3KU7T0sPYsn8KElZQF26dZ/oX6P2BjMU
        XounlsHF2CmX/gprx2oKMBoP4THusuJQOwRJtDz5eg==
X-Google-Smtp-Source: APXvYqz8iOn0nbtO8Wf5JA1qwDfaiGkpBSz8wl8k6/NS570b7wKSQILQxCqxFafS0z3amA9SenJK26morYvYMsl+vao=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr19205946ljc.97.1552358415132;
 Mon, 11 Mar 2019 19:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-29-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-29-git-send-email-info@metux.net>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Mar 2019 10:40:03 +0800
Message-ID: <CAMz4kuJECc9uvJ-z9A+b1H2u6-XEOxrBQiQ-=YQy0jeAbm8wvw@mail.gmail.com>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com,
        vz@mleia.com, matthias.bgg@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        ssantosh@kernel.org, khilman@kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        jun.nie@linaro.org, shawnguo@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 12 Mar 2019 at 02:57, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-sprd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index 55072d2..f5c8b3a 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>  {
>         struct gpio_irq_chip *irq;
>         struct sprd_gpio *sprd_gpio;
> -       struct resource *res;
>         int ret;
>
>         sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
> @@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>                 return sprd_gpio->irq;
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
> +       sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sprd_gpio->base))
>                 return PTR_ERR(sprd_gpio->base);
>

Thanks for your patch.

Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
