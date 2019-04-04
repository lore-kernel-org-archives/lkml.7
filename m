Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B4620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xutuAmIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDDDLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:11:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDDDLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:11:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so463990pgj.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdh9mGXHnXYT9F3uIHg/+7R8Fqq4m80F5IRzDmY0wdM=;
        b=xutuAmIstZu2v83PXYHjkAQ6aqP49H0W4M/bmtaJJqq1zLQyHi74Z2+w4ZZef6IAHl
         I7n+agGMSFPsoGjM3/akwvawPEpn6mPXOC+cF0o0C+8HfSQy4Ix7WMpXZM83YnOE6md3
         cVx3po+aJoruTjT3doradeg9pd1WPpM2TNOKB4G9N3VWWUX+kMPf8s20pVhRIvcJkF3c
         Z4zcqG/MMEzQAjFElUj6iIk6AoifEPGfVLnz/kgME0jv5tR56nMk44FYLFsnuZMaABRc
         evoneSHdMxh4WjyW/v/QQE6PWodEDQFeIvlwe9MagW3yZxOZUDLEyX0m+Vub9nd4YGHF
         fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdh9mGXHnXYT9F3uIHg/+7R8Fqq4m80F5IRzDmY0wdM=;
        b=UA1JebB7JgCYH9a1+co3Tyjab1U1tRyh1kYKY6DaUNJMvr1G/ocutwgM/3q6tWumrx
         dtVj9/y5YareVRWkKOHremy/yTAU4D2HsswYvk8Uf6E4UcfgjPU1mU5ya5ZKeTTePDnY
         9A6n3KKOkj0FS292pjiLx3teABppi1gD/9PxDsrdGCnSZGmprMS2hCaEpebyxNtzcagd
         dy81K+uhN9z3fyKq1+rPE/+vXGSAzLQUdA/KMrii4xigXbK6b6zDSHyqPJKB9R9f6T+R
         eV0Xrj3o7leuU1d8ZCnBNRaQpblg/PHJBvgO/wv0PWvoKxP8u0Pv+OfJhDPeEjhszj14
         LIoA==
X-Gm-Message-State: APjAAAXhDRMCCMzg8fHVUdISmlEV5XIi6BLhaozzaPQR1BOnhynTK+E2
        6vfZLVxX/JYLO+IYqlVxL08hmnVXmyqIbw==
X-Google-Smtp-Source: APXvYqxgJw4K1flSj8LU5SN9MoC67WoN2lWX5ofOZbW+2088vXR7Aw1KdSgce1FU0pcTr496Fi6amg==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr3217444pgm.160.1554347509225;
        Wed, 03 Apr 2019 20:11:49 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id v20sm21333947pfe.118.2019.04.03.20.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:11:48 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] thermal: qoriq: Add local struct device pointer
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-3-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e748759e-66e6-4acc-ea23-1e337ed53535@linaro.org>
Date:   Thu, 4 Apr 2019 05:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Use a local "struct device *dev" for brevity. No functional change
> intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/qoriq_thermal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 7b364933bfb1..91f9f49d2776 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	int ret;
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
>  
> -	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
> +	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> @@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
> -		dev_err(&pdev->dev, "Failed to get memory region\n");
> +		dev_err(dev, "Failed to get memory region\n");
>  		ret = -ENODEV;
>  		goto err_iomap;
>  	}
> @@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	ret = qoriq_tmu_register_tmu_zone(pdev);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to register sensors\n");
> +		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
>  		goto err_iomap;
>  	}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

