Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5965214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/5Ztrm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCLItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:49:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37468 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfCLItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:49:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id u2so1413521lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFIEefMYnz1eemiwQEU5sKowNj5kyBHW5KbGr+EN4CQ=;
        b=Y/5Ztrm3MS9rVgo+BfJmMu8Fo7o+/oRpvHNGPt3kVNyVg095W+pOogu1v8sE1kdG8A
         7po9LLqNcDJFkHUsULP5IECHGjLzJr8GQzQcppS5ZDAxzmHX3nA3IiMxOBZqBQlGdrLg
         X4x85HOC41crMY9pujPWFgd+MhvNkhIlYKsoTj/46978QugWcPCb8I65Uzk5zqKvkIBm
         ZKe/QmmYQL3pQ7Fpyi6zZMSaVkAw9nVFsFlnb/1TvWzyKNqglHN60MTGpNUHIg0PnxFZ
         XB1TkHbm9T/J6y66GNHGlgUAq21RCTn4Dz/RwxwrG6uaQxqh3ftcPezFMwHXhZ2nt1HH
         tm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFIEefMYnz1eemiwQEU5sKowNj5kyBHW5KbGr+EN4CQ=;
        b=d1KcTuPpq665Im/+dfF+eGUVy4c8EGYL69buUjWhcd4ULaLFFjFYAHZmY33BKriwu8
         hwdW8u4BS16EKEFMk8hCzcIDepCv7Rikm0M+8BTIg4v3RnW0IoJM9LvKodKxLtIt3wiP
         cseAxiXCIO0XICDdnLk4c0mHWn0jFtR+Sg0duHPGRGU6KZgeiSLqqxT/ukwjfbMN+xNN
         4m3C2m6HxK7p16Lzv/y6MetxAMuw2t1Vgo2jdc4lZIlEj3m8ERHToN+Dcrfk1q8/sa5n
         xwIbemi28s1kIwQKMZ4To1ryVtWlNr1f/fEUoKSwo8LE5ZxxEQXhzBSSGFbpnRnk7i3G
         mxdQ==
X-Gm-Message-State: APjAAAW/H9cvLwD09jV8CVK+JFLn5yEByykmjdaP7+YIzAvFckB9BCmi
        dCNDOui9eYWl8jJZeQ7Hj5cY4QacGaFlcmT/W+AsvQ==
X-Google-Smtp-Source: APXvYqyIYNaXm2HsY7Ep9/U9iPJtwISrRyaPyUxCgTKn7cvyK+a1Zba6KxcZQJcLtjaJYcNUZm5PyJ67qn71LVk1upg=
X-Received: by 2002:ac2:5638:: with SMTP id b24mr3365165lff.18.1552380558638;
 Tue, 12 Mar 2019 01:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <AMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
 <1552378134-3678-1-git-send-email-info@metux.net>
In-Reply-To: <1552378134-3678-1-git-send-email-info@metux.net>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Mar 2019 16:49:07 +0800
Message-ID: <CAMz4kuJaFtsmk1sWw_cSc+b0tdNabt_1jZB8hjrJrOgdQkqzmA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 at 16:08, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index f0223ce..462cdf4 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>         const struct sprd_eic_variant_data *pdata;
>         struct gpio_irq_chip *irq;
>         struct sprd_eic *sprd_eic;
> -       struct resource *res;
>         int ret, i;
>
>         pdata = of_device_get_match_data(&pdev->dev);
> @@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>                  * have one bank EIC, thus base[1] and base[2] can be
>                  * optional.
>                  */
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -               if (!res)
> -                       continue;
> -
> -               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +               sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, i);
>                 if (IS_ERR(sprd_eic->base[i]))
> -                       return PTR_ERR(sprd_eic->base[i]);
> +                       continue;
>         }

I still do not think the new API is suitable for this case. Since we
can have optional multiple IO resources, so the original code will not
return errors if we did not get the IO resources, but we must cast
errors if we failed to do ioremap. But you ignore the errors of
ioremap, which is not good.

-- 
Baolin Wang
Best Regards
