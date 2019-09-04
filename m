Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A667C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAEC208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzzsMJ3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfIDUoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:44:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42291 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbfIDUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:44:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so83216plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZGgKk8jeW8NM2wT+HTq6+KHx26Kcf2Hd/HdxeR6J0c=;
        b=TzzsMJ3gWG917Iis4NdDhBIHth4GqtK3/sv+X2gQXSJdeB0qEqMFs9o843HMPvOYUn
         vxtcCBUDaWeRrnOi1h22RIfgxWB3iIQod31jZJoOVeGfutT9zeffgawMOBlMyWm9nSwy
         YYRmz4yz3DSBRuxsOrQNDlVkq2BDtx9qG5bw/7teX4Y2Jiv+jUIX5DTvPqMzRVOzI9X5
         4aJ+GjJekgkZ7uptwZX/lTBColHi+7J8HLkvOOdJeAxLEmtHbAncsA81jTFaDEk/tFKN
         czMqG3CwBQQXU35NXerVTyXs4EAwGQjCKS5/StfvvxlCQdQ0G6qjrLlu6glTZVxMY3++
         m0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZGgKk8jeW8NM2wT+HTq6+KHx26Kcf2Hd/HdxeR6J0c=;
        b=Tn8Mf6mXWQ/XG1y7ngE3jtKxucuW5t4wEGFN9k+/JFouHTS6vFLHIV6WfbO2k+42Cx
         yJlb3REqPgPHcfUwWDLJaDpXxBychgIIGRhF1CwTpCiN35SSR8Dw8yiwoFHkAXuYxT2M
         6dVlL9v0qdF2vjMSoKNgm1kGmKGKkmkYbFgEFMXrHYgWc6m3hRwoq7qi3yGtT2O5ydgi
         1E6XGKNU0VvVtEnQrYH1r+xQgTkFCyLvRSCr0UfNvv/W1ePi8q4h1RkWcx29sDLLYwBI
         ybM1w8TPTBD0xPgihKuAgz13BaIkgLmR1wT/VKwe2Td31LFruETUNal4KSU7wAJ63MT6
         +IUw==
X-Gm-Message-State: APjAAAXhx9EV2CJmGIS67O0kQaOZa/fE4lnWbe4yQlAwfBZwZQ/n2fYk
        Z8ISH0L2sqUfnzPaVjzkDorouA==
X-Google-Smtp-Source: APXvYqx4qZrRLrrr0VmXx5Jsx7rH4OjMuKZvmx+AszzG5hedxbJVd30/b6Bg8l9gTJn3rOqOMRdQqA==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr41037414pll.250.1567629878103;
        Wed, 04 Sep 2019 13:44:38 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r187sm19257078pfc.105.2019.09.04.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:44:37 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:44:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, eric@anholt.net, wahrenst@gmx.net,
        shc_work@mail.ru, agross@kernel.org, khilman@baylibre.com,
        matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org, krzk@kernel.org,
        andi@etezian.org, palmer@sifive.com, paul.walmsley@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next 13/36] spi: spi-geni-qcom: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190904204433.GE580@tuxbook-pro>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-14-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904135918.25352-14-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Sep 06:58 PDT 2019, YueHaibing wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 242b6c8..6f3d64a 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -534,7 +534,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	int ret, irq;
>  	struct spi_master *spi;
>  	struct spi_geni_master *mas;
> -	struct resource *res;
>  	void __iomem *base;
>  	struct clk *clk;
>  
> @@ -542,8 +541,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -- 
> 2.7.4
> 
> 
