Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6EDECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA12206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1g4svc2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfJGSJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:09:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46358 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfJGSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:09:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id b8so2332576pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GeChysEpyXENIdkz70FTwZQNrGJAliQm6LKcOJ4pwgg=;
        b=1g4svc2i2jhyiyQgS7H2WqaqlY4rawaEfSSoyLIcO9cblF0u1gFFqp/KTw35+0FZfc
         MwzkbFI30GsMRmv2OloegWaVbSjb8KDnm+dfMEbweYWsOm1wGCxZsUSg/z+13uH3xzh1
         RupL3Su0rST4Jq9HoZjj9nGm9XoyTwDep1/8UQyx/IVu9uLc6qpUfKWUlHyLvUMgJXNW
         aB2X3gCDtmoi4cYwtVghiMaLgJrHmdzn/5lss3HRCyoE4uQU4faG8oZ0vBV7mGtmCjn5
         1yBEDl3LzEuJXvBb0Jp2SepKw/cROrKcSFBMbcUwB1odwRJ0Wn5DcdTOh2g1tJhlI8t4
         bchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GeChysEpyXENIdkz70FTwZQNrGJAliQm6LKcOJ4pwgg=;
        b=h0n8l18oj0xaVB6OntcZ3dfIEfmWnolidoOglqpb3NFaDBxg+SmW2gpOpW2Qns5Dmh
         obfT6C0FnpWidx0BTKAZXJBZl8atJ75Qu1ashnN44FMw79rM3JcBQVMxlKUypmoBNGWk
         EJZDXG5aldFym62U3EVULhlqs38OMf5yIVxP0a9nSu4yUuIetI1nb7OuCs8nqHUN7+rv
         VcNMIJf6+Oi1VpPcMqcy6aMG0pM8XIU0Le47gRUnAdxFFpxGWoC7E0dDeKUuOvaoAvph
         aJB9cf+RkVPZDtjpNmD+cKwyAvYFqMd1JHSxzZl/Xj9cjUrDW4AcHSC+mCJ0T+0szUxM
         2Gqw==
X-Gm-Message-State: APjAAAUxxlUD99SxarIgPEPeXCtpUo3af70JMw9TbDb4nhmZWI80+Q2k
        KPdTp+PYshCwWZz+ZJdKJjF73w==
X-Google-Smtp-Source: APXvYqyCq2Sjyl//q7G2IzZThRFyehP3F/3geHI2eKnTCZnkHRsOjKjZK4tPTO1jHMEhvfanawQuGw==
X-Received: by 2002:a65:688a:: with SMTP id e10mr31994989pgt.221.1570471756657;
        Mon, 07 Oct 2019 11:09:16 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:bd18:5fe6:bf81:d473])
        by smtp.gmail.com with ESMTPSA id s73sm155793pjb.15.2019.10.07.11.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 11:09:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     YueHaibing <yuehaibing@huawei.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, joel@jms.id.au, andrew@aj.id.au,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linus.walleij@linaro.org, baruch@tkos.co.il, paul@crapouillou.net,
        vz@mleia.com, slemieux.tyco@gmail.com, eddie.huang@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        patrice.chotard@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mripard@kernel.org, wens@csie.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux@prisktech.co.nz, michal.simek@xilinx.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next 16/34] rtc: meson: use devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-17-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com> <20191006102953.57536-17-yuehaibing@huawei.com>
Date:   Mon, 07 Oct 2019 11:09:15 -0700
Message-ID: <7hk19gfmwk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/rtc/rtc-meson.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
> index e08b981..9bd8478 100644
> --- a/drivers/rtc/rtc-meson.c
> +++ b/drivers/rtc/rtc-meson.c
> @@ -292,7 +292,6 @@ static int meson_rtc_probe(struct platform_device *pdev)
>  	};
>  	struct device *dev = &pdev->dev;
>  	struct meson_rtc *rtc;
> -	struct resource *res;
>  	void __iomem *base;
>  	int ret;
>  	u32 tm;
> @@ -312,8 +311,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
>  	rtc->rtc->ops = &meson_rtc_ops;
>  	rtc->rtc->range_max = U32_MAX;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -- 
> 2.7.4
