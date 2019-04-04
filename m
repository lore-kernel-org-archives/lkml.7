Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615B5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBqf5389"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfDDIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:23:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50297 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:23:35 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so2459194itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SnAAAcldaSNKA1PZVv5nOzLhPnIt5K9nqhd1kvy88fg=;
        b=HBqf5389DS4mKNVPU4YYkiGkth/NqHAdRhIfuJYkpMrm117ggThnJ2FQyx+mc0LfWb
         aYU9N9GPwO8+2T+CW3zjzWWWOHPtlZgtEr2ou1hitkvQSlHWaYxYP2AtBBNGW/XRgxSD
         Nl96GKKv4uCYqPjQvRwixxk3JPyyT4QWwClB3llgVuwGVE1NxdaX9s/rSjOthNeN0InZ
         LjYBsGjX/wlBim2dH8OnTzuhU1Ik2+iBdhVztNtFPd0t+iye2CEz/BZVD8cKBx8XRpsl
         78rIuRulTf5Pgp1khOH4FNkEDRtVG3nC3rEA7pKbQyYwevhQdmY1R/fcFisfpwiPlO/+
         W10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnAAAcldaSNKA1PZVv5nOzLhPnIt5K9nqhd1kvy88fg=;
        b=a+xxO8AAjPwNoxfb20MMYuOIMLICFjYzokAwAZSJkUziL2W9O10668gtT2WxQE/rDM
         5dHkW79qkQmUMk9IlVQHBWx5SWIbwrjdGJSCPMnWswFu5+BgKXS/4JSCWNsiKzWl6ShM
         vIELS+WIu4ohC1+FA0I7tgMWTcOLMcXeK5wMm5iDfNbaRQIuPV3flwi4MTFsDoPl6cK9
         fzWuIqsJSfaEhK2B09I7G8JCQZXdCm2aDHLKC8IDt5X8b8smXQuHrBrGS/A4LR0tJ2su
         RRYqeiQkGX8THOfXQLQwIeKKAYz37lYamI2trLQDGhYRI+yY3s9uTZ9YqdjxjXD8AOaF
         AbJw==
X-Gm-Message-State: APjAAAWga+iTCZr5p92CU2mBjgudpeVMioBNIBAb2BTt3s3UheZmUsCn
        dwDJjHNlsFX4Fa7hPcJjUhPhoBCZXA9EFA==
X-Google-Smtp-Source: APXvYqz5MK+RoOvDNT+lAgV5uaYIV72rKermh98Aq5IudDGIxhzAbr4J7d3qLewWUI1lyZasCGREdA==
X-Received: by 2002:a24:eb0e:: with SMTP id h14mr3711907itj.100.1554366214265;
        Thu, 04 Apr 2019 01:23:34 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id f14sm7597566ion.46.2019.04.04.01.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:23:33 -0700 (PDT)
Subject: Re: [PATCH v3 08/13] thermal: qoriq: Convert driver to use
 devm_ioremap()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-9-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4d17af42-9db4-685e-799d-7b7981344129@linaro.org>
Date:   Thu, 4 Apr 2019 10:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-9-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Convert driver to use devm_ioremap() to simplify memory deallocation
> and error handling code. No functional change intended.
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
>  drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index a3ddb55740e4..4f9a2543f9c3 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -192,6 +192,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> +	struct resource *io;
>  
>  	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
> @@ -200,7 +201,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	data->little_endian = of_property_read_bool(np, "little-endian");
>  
> -	data->regs = of_iomap(np, 0);
> +	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!io) {
> +		dev_err(dev, "Failed to get memory region\n");
> +		return -ENODEV;
> +	}
> +
> +	data->regs = devm_ioremap(dev, io->start, resource_size(io));


        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        base = devm_ioremap_resource(&pdev->dev, res);
?


>  	if (!data->regs) {
>  		dev_err(dev, "Failed to get memory region\n");
>  		return -ENODEV;
> @@ -210,23 +217,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>  	if (ret < 0)
> -		goto err_tmu;
> +		return ret;
>  
>  	ret = qoriq_tmu_register_tmu_zone(dev, data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> +		return -ENODEV;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> -
> -err_tmu:
> -	iounmap(data->regs);
> -
> -	return ret;
>  }
>  
>  static int qoriq_tmu_remove(struct platform_device *pdev)
> @@ -236,7 +237,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
>  	/* Disable monitoring */
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  
> -	iounmap(data->regs);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

