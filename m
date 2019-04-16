Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32098C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01323206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwumSBs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfDPQvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:51:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54121 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfDPQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:51:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so26290405wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dzBYZ6U7LJKOrJ8NQ1oOnzmvpmYp2QXciCTaYNIJU70=;
        b=iwumSBs5CFQOuqNeSBprIx03CnTiyQIOPW2fQ8qZwcc8T/bDS15v0aqDUK2I3gfAIU
         Rlh7YihZ4QX8CBZ69oHQMAloIZC7OQXnVDqkpdwv1cFJW1dcgkQi2QiH90JMZYje/KgG
         qUYJWC8K2mNJfxvO7x2MmJ3DoKv8wd3LI8qZqskHszrtHv7pDUXFp5caG3bMRZ33tb/u
         Vl7WwLbN5Wjyw7AD9dJtM8Ir4hWeeSDf3Agjt98S4E16+AQraE8ud/K/hnnRc5jKJuWn
         iPys07nr/KkdZY3cpRgjB0k7Bo4WB2Nk6Q0GFxGPP3AElfM1rh2RH8EYH7uLInMSpzEI
         c+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzBYZ6U7LJKOrJ8NQ1oOnzmvpmYp2QXciCTaYNIJU70=;
        b=bYgPl4d6l11024qBnB6n09QGQ80Gn67Axs6rSuNpRHR/n0ldhrFhqs824R5VzQeOu0
         vJMjB02/yYyUntCRgZgl/wxcSyHqTu2GXfWVhSzCPl6KUH9AkAwRaFPYc/vaSZandf65
         CnghkaRkkPGR9Ll2ljVYZibbrEK19DovWc5/XTb3rTsMBnnEamBxS6+9d2iDyAUGzdRT
         sVViwlWb5WyW7SSllvvEjNdKPX2cQ2qFoGBfD1QNMlwFHs1gFwAous95WVFYNHkgXnOs
         yaWnGVEFkw9CUGLg9ms5jwwcUIm4TG3f4xOGZDYhtPLKPc4OPd1hwPxEVuaRr6OV2/Jc
         MZEQ==
X-Gm-Message-State: APjAAAXPVYcwIUftLrGZhae24Jf3aamrCMHOmFT5Q7r1vCHd0ePhir+k
        qmfhxXTjFhS6+i+MNGbZ7bWPQYX4pcU=
X-Google-Smtp-Source: APXvYqy7gQ5N4zohV/Xx57Z1UvKgUw/Mh8DvXgMKu/TXGe8H1SBp6dc61C1ciiipMbswYEU/PAm3Ug==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr29043851wmj.0.1555433512058;
        Tue, 16 Apr 2019 09:51:52 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id o15sm53210742wrj.59.2019.04.16.09.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:51:51 -0700 (PDT)
Subject: Re: [PATCH v4 06/12] thermal: qoriq: Pass data to
 qoriq_tmu_calibration() directly
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-7-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <74c4f677-c586-45de-3a38-feb627757193@linaro.org>
Date:   Tue, 16 Apr 2019 18:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-7-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> We can simplify error cleanup code if instead of passing a "struct
> platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
> pointers from it, we pass those pointers directly. This way we won't
> be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
> and consequently would be able to drop the "err_iomap" error path.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/thermal/qoriq_thermal.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 3419505a2f0a..0b6937bbc7d0 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -122,16 +122,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  	return 0;
>  }
>  
> -static int qoriq_tmu_calibration(struct platform_device *pdev)
> +static int qoriq_tmu_calibration(struct device *dev,
> +				 struct qoriq_tmu_data *data)
>  {
>  	int i, val, len;
>  	u32 range[4];
>  	const u32 *calibration;
> -	struct device_node *np = pdev->dev.of_node;
> -	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> +	struct device_node *np = dev->of_node;
>  
>  	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
> -		dev_err(&pdev->dev, "missing calibration range.\n");
> +		dev_err(dev, "missing calibration range.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -143,7 +143,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
>  
>  	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>  	if (calibration == NULL || len % 8) {
> -		dev_err(&pdev->dev, "invalid calibration data.\n");
> +		dev_err(dev, "invalid calibration data.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -181,20 +181,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, data);
> -
>  	data->little_endian = of_property_read_bool(np, "little-endian");
>  
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
>  		dev_err(dev, "Failed to get memory region\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> +		return -ENODEV;
>  	}
>  
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>  
> -	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
> +	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>  	if (ret < 0)
>  		goto err_tmu;
>  
> @@ -202,17 +199,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
> -		goto err_iomap;
> +		goto err_tmu;
>  	}
>  
> +	platform_set_drvdata(pdev, data);
> +
>  	return 0;
>  
>  err_tmu:
>  	iounmap(data->regs);
>  
> -err_iomap:
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return ret;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

