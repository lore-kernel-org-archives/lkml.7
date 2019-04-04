Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4A4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIPI7Cxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDDIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:12:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45918 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfDDIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:12:05 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so1204198iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n45OYcrFpx1qiRvlaQvKn69aJR93KsXOFg0o6CuxzB0=;
        b=MIPI7CxcgETI1m9EgMI8dKg21CUWsGxdbZCyNaHhpN7k+2E0NgS63+rqc0ypgICxp2
         hegbyPpgm43BewsiHMx5+lyDJdIPNmygbx0sHIkaOaZn+rj8OrEVCTBz7e78seK728Du
         loP+XqWq21Yz1vaf4X0VrGNQfp64Aiwtf8Fs5tLQXL3b0h0jCBmgfUgy8MHH1UJHypYs
         +UEnNIOC1kwqrqW4Xybun+7miMWclxgtNYRxWuA8kDB8kt9icIFBUhqq614WwUYjVJDc
         04UAb7q4fpJxnGNQC6amBq4Q38ZieePvRkoQja4sjizrSbMbh+ILGQk03NqXQPRjg2Cy
         fzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n45OYcrFpx1qiRvlaQvKn69aJR93KsXOFg0o6CuxzB0=;
        b=t9msOrNrxc4g5wEq9ZUVEGNxLSLkSbmuvf69R3bT/GmXjTOunFiFA5h9Oyz++yJUuv
         6RPTyUQXBO/g/jKPPlqSDs60qYPYUQ3PwUeXVQ1D1QbifujGF6c+/bymBf018J8k9vlq
         aGpuHBw30v1bNfWk639nkVzF4oywwttSa1z0qXgnFo9zWGUSU6LHpIspbKPhzHkuAirO
         0Jr539P62Lrt+RKB+ewvIFGaLGl5irhRQmsEb2EmnM1mQKXCqrlZzoaGJy1wMkcTK2qB
         18Fazvy3nHves39qFiILrVYsBxTlQxGFGmHBOqsiQAsEJfg34fwbu+P30nlHXUPHuUgc
         r+xg==
X-Gm-Message-State: APjAAAUlk5LdCcao1TNwWy6JOQTJ1p9tP4RhIe0x25Laq27cxuVMomUJ
        MhTEjvsvIkU82Dm2uQbozSO+s7nzQBzzNw==
X-Google-Smtp-Source: APXvYqwIyh0SOK9FSL4tQEZ7YD0YbhV1OFWXsoduyDEwIgibXGcJVulyXBHuRiAFTblHkQ+h7XjVgA==
X-Received: by 2002:a6b:7108:: with SMTP id q8mr3254631iog.85.1554365524561;
        Thu, 04 Apr 2019 01:12:04 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id w184sm9514397ita.9.2019.04.04.01.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:12:03 -0700 (PDT)
Subject: Re: [PATCH v3 07/13] thermal: qoriq: Pass data to
 qoriq_tmu_calibration() directly
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-8-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa3cf0ac-1015-4031-8cd4-cd5270e39fc7@linaro.org>
Date:   Thu, 4 Apr 2019 10:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-8-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> We can simplify error cleanup code if instead of passing a "struct
> platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
> pointers from it, we pass those pointers directly. This way we won't
> be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
> and consequently would be able to drop the "err_iomap" error path.
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
>  drivers/thermal/qoriq_thermal.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 24a2a57f61c9..a3ddb55740e4 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -139,16 +139,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
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
> @@ -160,7 +160,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
>  
>  	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>  	if (calibration == NULL || len % 8) {
> -		dev_err(&pdev->dev, "invalid calibration data.\n");
> +		dev_err(dev, "invalid calibration data.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -198,20 +198,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
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
> @@ -222,14 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  		goto err_iomap;

s/goto err_iomap/goto err_tmu/ ?

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

