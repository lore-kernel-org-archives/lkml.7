Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9BF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SdSulqDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfH0UkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42075 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0UkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so154776wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LVY+aGgV5phVkgMSXjfnQV4zLurQzKqT7u/u8Bbhqn4=;
        b=SdSulqDQhvJQaCl/gqpRI29PMKcIigY1c472uiQr0zBUH0suP/3zID/TWaFKLGGxt6
         wJU4/jiPdnLLZ98QU2A5JBMHijilc4FRAF9U1kvjapIdUhWELzGMNFxpZJT2qx3bai4t
         XnCyR06QWZxXtqEDbK+YC3i+qsylW9SxNrCTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LVY+aGgV5phVkgMSXjfnQV4zLurQzKqT7u/u8Bbhqn4=;
        b=WjCSRGSurjPDK2u0pTRQC9LMFvGF9JByuLXGT6tjO1T/5B10atjSK3VQ6sZ05qhTSa
         HJqsbE44vzdOwWhVj3mx2+Vkj2tvXURul8Nm++UG3q/QP1HYOaNHDW0uY2sI9dKT/tgb
         xMZO3vsqLYtr5PeEec/ZCuDFRxIcMp+KORHoBk4gES7S1aEzTgk9g8RtN0qHi+TzgwSQ
         wEzr+SAMhvjQGrbhePzI6GsSk0bH8upJ8pv2Vd/UiE2ye2JEmjIvSt8v8VQxf5pUpLBz
         b96mjsBd9nceerGD/YEUGhb6da42DyzK2hhW+6tOjOioc7fw2S6sMN7VYK/UBMECZq8l
         CB9w==
X-Gm-Message-State: APjAAAWrfiPjHKU7UnsPgTBC1R1lEmQr7WUahXP78YhO4hP+NeMkAxai
        poILK59AWVVB7fZXq016CMMOw8rLgdA73eghQya2xnB3npNNGgHFIktwcXNRL33s/Sst4URdZnt
        f+uUhGHKcdwJrUs/zBwuQAjohs/Bz4PHSIELFBHclUyELPZFYdT/o/WhMTqRaYixec8mm5CnEKc
        CE
X-Google-Smtp-Source: APXvYqw2S8S1S6srBLnhNXgrsUaeESkm3bBtz02xDGo7Ut/x/S+256UHwPqj2L8/y9Wugysbq7pyJQ==
X-Received: by 2002:adf:ce81:: with SMTP id r1mr133139wrn.114.1566938414417;
        Tue, 27 Aug 2019 13:40:14 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d69sm189454wmd.4.2019.08.27.13.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:40:13 -0700 (PDT)
Subject: Re: [PATCH net-next] phy: mdio-bcm-iproc: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190827134616.11396-1-yuehaibing@huawei.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <27e43388-bc8f-6a36-5696-beb3b8d140d4@broadcom.com>
Date:   Tue, 27 Aug 2019 13:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827134616.11396-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-27 6:46 a.m., YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/net/phy/mdio-bcm-iproc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio-bcm-iproc.c b/drivers/net/phy/mdio-bcm-iproc.c
> index 7d0f388..7e9975d 100644
> --- a/drivers/net/phy/mdio-bcm-iproc.c
> +++ b/drivers/net/phy/mdio-bcm-iproc.c
> @@ -123,15 +123,13 @@ static int iproc_mdio_probe(struct platform_device *pdev)
>   {
>   	struct iproc_mdio_priv *priv;
>   	struct mii_bus *bus;
> -	struct resource *res;
>   	int rc;
>   
>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(&pdev->dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base)) {
>   		dev_err(&pdev->dev, "failed to ioremap register\n");
>   		return PTR_ERR(priv->base);
> 

Looks good to me. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
