Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F32CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUNli2l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437830AbfJXGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:53:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404388AbfJXGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:53:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so13886057wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8khYaTOw9WAVn5r1hqt1nVZGPqpu5gb6+8NwKqGMFe8=;
        b=BUNli2l6Fa25AdE0ZSWmeiiCbkMITuhVBf0luWAEV5g4Dm4/cIj62LYP/VKo2c+v9R
         K/oB+nqJfpCqgkRLmdoEv8r4E1gJom+I3ZY2D1t0IQUZL9+UlNk+FYY4RSXQ1P+sTBUP
         EmUoKzUQalCiS3o8nu3dUHm8oxHaASXdcESR/hIeM7djjAvOGU7uHI4DkWu7W/b7Y8yu
         oYwhsy+1ECYgLY27ogRRs6YzGpOcwwcnEyHjJy0ELTqDxn1YUkR/xEWK4ToCfoyEH4Fy
         j431j/y9T/3acv/UwKu/ZnQveJw8qBnxxEjPLnfwcSKN3CxKHbvwEK3OhxwKBqkcr/6f
         HfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8khYaTOw9WAVn5r1hqt1nVZGPqpu5gb6+8NwKqGMFe8=;
        b=HX5Mw+ysiwjo6BGScT7sFvJEvDkTpv4NrEk2G9QeWJeXR9IF+HX+3HWkMhmyyRPXLt
         /1wkIud0oxR0lh4p5CrsY4OuEjJZf7kST9yAT/iiL1svAFDN2W36gW7PG0M8Y3lFA7gp
         U7DIlmRZlUsYch7M27d4F655NhVYb+cANfJ2+rTCYO4RH1ksFWiCZCjtoCZst4a8Agf5
         U9NY+fdVpHoYwAyrRFzHMpuyxixFeqSe8jXjruVwitApQSbHSHdEVwc9xVrncUpeg7Nq
         GY/11XeFiZ92aEIvK1fzER3IVrogh+mBZIiT9zqH9dyc5j88hHbRyoymZQBWQFv67/6p
         4A7g==
X-Gm-Message-State: APjAAAVEQ/PMezeCUPz3nO6lQbgZO2vuuGSczoGZCrr00uGWStf11fmp
        cmfEMYBNvrQ79nulvXB43RokjA==
X-Google-Smtp-Source: APXvYqzgRjFnh49B9qjfb0Oi6euoaQE0DPniUq07LuFqd+7EURts2SUbVXZSdndQQkgO1PMosZc66g==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2117890wru.136.1571900005726;
        Wed, 23 Oct 2019 23:53:25 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id d199sm1783744wmd.35.2019.10.23.23.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 23:53:25 -0700 (PDT)
Date:   Thu, 24 Oct 2019 07:53:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH RESEND] mfd: mt6397: Use PLATFORM_DEVID_NONE macro
 instead of -1
Message-ID: <20191024065323.GD15843@dell>
References: <20191020150720.2752-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191020150720.2752-1-fparent@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2019, Fabien Parent wrote:

> Use the correct macro when adding the MFD devices instead of using
> directly '-1' value.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/mfd/mt6397-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch didn't apply, but I fixed it up and applied it.

Let me know if anything look wrong to you.

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index b2c325ead1c8..0437c858d115 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -189,16 +189,16 @@ static int mt6397_probe(struct platform_device *pdev)
 
 	switch (pmic->chip_id) {
 	case MT6323_CHIP_ID:
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
-					   ARRAY_SIZE(mt6323_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6323_devs, ARRAY_SIZE(mt6323_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	case MT6391_CHIP_ID:
 	case MT6397_CHIP_ID:
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
-					   ARRAY_SIZE(mt6397_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6397_devs, ARRAY_SIZE(mt6397_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	default:

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 310dae26ddff..9b19dfeeb797 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -171,9 +171,9 @@ static int mt6397_probe(struct platform_device *pdev)
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
> -					   ARRAY_SIZE(mt6323_devs), NULL,
> -					   0, pmic->irq_domain);
> +		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +					   mt6323_devs, ARRAY_SIZE(mt6323_devs),
> +					   NULL, 0, pmic->irq_domain);
>  		break;
>  
>  	case MT6391_CHIP_ID:
> @@ -186,9 +186,9 @@ static int mt6397_probe(struct platform_device *pdev)
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> -					   ARRAY_SIZE(mt6397_devs), NULL,
> -					   0, pmic->irq_domain);
> +		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +					   mt6397_devs, ARRAY_SIZE(mt6397_devs),
> +					   NULL, 0, pmic->irq_domain);
>  		break;
>  
>  	default:

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
