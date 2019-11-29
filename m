Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12AFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A7215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9W84uLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2Jqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:46:54 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:41552 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2Jqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:46:52 -0500
Received: by mail-lf1-f50.google.com with SMTP id m30so20292363lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GlpRjYHbCH1VLhj1GGbDkK8pDGEyIE6EbAHuHd+GZA=;
        b=q9W84uLv7pjhogvkXqLbP/k5nxHNBpWq9J1QjYHlsAr1SFbL+qp30+lBeclfsb/GzZ
         j7pClPaq9SlMppvVUpXjCmtCNEwrGoPO7X1xsF/i4+kLzC3fzAUbUQJjkeHDDwuhH/zb
         NjR8gfdn7+c/YRq6rBQLXSS36nm1bX6tVM7DIwbv2Oj5ufdzxD9DkfX4vDBNVFdF/26K
         f1TMGaa0TpcNMNU8fV/8CnayLEIpr4vL6pKJKVht0A5WLCT7cQk+CJp6qvu7o1+h6wjj
         auQPw2boB6djmP9DWrxwW2UPKlavniRkXEUE+y2ARzrlBbmipOQ8v22yJ9OwNpfnm6WL
         qxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GlpRjYHbCH1VLhj1GGbDkK8pDGEyIE6EbAHuHd+GZA=;
        b=O4ICsASA85JeE99StzuUAdhBHGuAtf1Rx+IsX+K/74NW/1tMTpQp8jEcESlFVyS4k4
         gWbvRdKE1e/RPEZo3F3eHIQlMqwyFgpHmm6J0fWArryuqT2OEmRc8hwC48VU3iLprjGl
         vAQzGWEL1gxpna4UNo80eD0dSTIdIuRRFVLm+T2uNrkf2MXlMWey9yrYNxGl3Y9qRBYH
         +CSMSDZdeBMpiRHiYmgPo6SFoZSe1wOxnUTuc9V62d57iwsqZMkwStBQj57BZzP8KiZH
         xycv+JPLXHvyA6EsZNyv6RKiqVBNaK4+ntxCfMqy2m1f6/oR1Mw9GwGAzQIqXJDNdFiE
         6FhA==
X-Gm-Message-State: APjAAAW/5cDXn6BdJrly1c7UHQLRjjtv+p+O8n/gfWJ4lGvsLBpLOG+b
        QgIFBxDUqbVKSSrJzzBXlwZtpdpDCBfAr2pRNcUq/Q==
X-Google-Smtp-Source: APXvYqziak5rpAuJX+vyu6qoveI3kiclrpYm4tORoy1TjnqQ83VK/QoRTXCkFn8M+I0SFBq2G39fwcQfBRg8TsYn9Ug=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr7739875lfi.135.1575020810861;
 Fri, 29 Nov 2019 01:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20191129085336.15968-1-yuehaibing@huawei.com>
In-Reply-To: <20191129085336.15968-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 10:46:39 +0100
Message-ID: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
Subject: Re: [PATCH -next] gpiolib: of: Make of_gpio_spi_cs_get_count static
To:     YueHaibing <yuehaibing@huawei.com>, Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 9:53 AM YueHaibing <yuehaibing@huawei.com> wrote:

> Fix sparse warning:
>
> drivers/gpio/gpiolib-of.c:35:5: warning: symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Mark merged my patch causing this warning into the SPI tree,
would you mind resending it to him including my Reviewed-by tag
and a note to apply it to the SPI tree?

Yours,
Linus Walleij
