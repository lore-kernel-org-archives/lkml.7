Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C152BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FC920830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjfay6NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDJT4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:56:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38224 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDJT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:56:35 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so3279936ioj.5;
        Wed, 10 Apr 2019 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUErJlnKhaAAi5cili2B6BxIZXm5dTTk/ZatlWe6NaE=;
        b=Pjfay6NJMcz59gLPKho+URVlMA1xvGMvnCsO5wtQI5kucO7W15Xxhbx/aG0ZEayTAV
         Qytk5kDSs4nuW6OMLY2ckRj7Y9YzS8DnPizLWWx6m9EdOgA13Yt3isAiNwGNH/hw8ZIp
         SaoXTwLz6cxW3OKN9+yBsNjscOqxa1bYkRWuIS/qJPMYKf7H8M4E5sYr7EtEhenE/7b5
         eWjhfNNdkbmUtiWg78hM45tq9DXNY7ufOvA3UCWgQuOOS0J38y56vpAbfOmbm32T2IKJ
         VdcvZDtB6Kc4kXM+yzTT8is+Q0HcNFzNXpLZjw3R13OVz8Hi+0xqNGeToC3D1forVk+F
         dl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUErJlnKhaAAi5cili2B6BxIZXm5dTTk/ZatlWe6NaE=;
        b=oHBmFXjUz/Qy3xdJfsBnXRUAEhsmrmfryMIOQzek5Qw3gIcwTMUOek1LOTqKPy5ZPF
         u0tqznCsA9ThmcEjDmcquawik36nPtCYq4Fm2nwSSRAQ+0DT1yZMfODUtz9hOasfFZ2h
         qi0MAGF8qmJbyf+NFZiT4hDXQkxOWtty1FofoOP++RtwNVmm9JJqvETknSMuHsMpV7PC
         Hyamagq+PjhwcirvPU0p1LQUHkokqp/TjDVyx9IvGRr/hyXTILaasmTl2ezY79sa0k1x
         zWNe7cvx8CP+czNil9oiD+H33zVo3BXbXB2mcuoKIM6I+ibwmAPCKAWrks6og0n2hWU0
         HElQ==
X-Gm-Message-State: APjAAAVGXquVwjqmyIlRq55yisG+Zma+8AIc/BDCd/sp45zNPrImYZc7
        dq04M5wicFuE2c3LIGbg5xHPv7l1KAZWiOXLoGU=
X-Google-Smtp-Source: APXvYqwKjmtEgr653hsCRJulsXCr908GkhWW7XEY1zFeZlQSBgpRPjNetA9RDrR3gvii5k1ocHFiN+4h39A07IFqToQ=
X-Received: by 2002:a5d:8597:: with SMTP id f23mr17737961ioj.148.1554926194571;
 Wed, 10 Apr 2019 12:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410084558.35160-1-yuehaibing@huawei.com>
In-Reply-To: <20190410084558.35160-1-yuehaibing@huawei.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 10 Apr 2019 12:56:23 -0700
Message-ID: <CAJx26kWQq2tz9Q87RBMogMUoZq_npey03hmX5Zsuqwp+eCMRgg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7950: Fix build error without CONFIG_GPIOLIB
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        stefan.popa@analog.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:47 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> When building with CONFIG_GPIOLIB is not set
> gcc warns this:
>
> drivers/iio/adc/ti-ads7950.c:75:19: error: field chip has incomplete type
>   struct gpio_chip chip;
>                    ^~~~
> drivers/iio/adc/ti-ads7950.c: In function ti_ads7950_set:
> drivers/iio/adc/ti-ads7950.c:409:32: error: implicit declaration of function gpiochip_get_data; did you mean acpi_get_data? [-Werror=implicit-function-declaration]
>   struct ti_ads7950_state *st = gpiochip_get_data(chip);
>                                 ^~~~~~~~~~~~~~~~~
>                                 acpi_get_data
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Justin Chen <justinpopo6@gmail.com>

Thanks,
Justin
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 846c7ac..f760269 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -968,7 +968,7 @@ config TI_ADS1015
>
>  config TI_ADS7950
>         tristate "Texas Instruments ADS7950 ADC driver"
> -       depends on SPI
> +       depends on SPI && GPIOLIB
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
> --
> 2.7.4
>
>
