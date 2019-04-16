Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB128206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BeXVKhiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfDPQwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:52:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51700 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfDPQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:52:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so26299758wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71SzAmW7a+qNOgggz8HL1zDFy+lLP5ZPJLe5Alcl3VE=;
        b=BeXVKhiDsELfVNUdywRLspQmRKwK6fESTDBZHq6ZH+Sxe9mMupaMG3o4V9GmeNWfkf
         WrQVW7RColVXeYmUlPaWm2v4n3nfDfP1aHw7IYyOz9TDY0zD8r5ZvqTVBj7v2mUwdIVG
         i1DBv6woSwGVS4NMEu8/nJiFBCaXxZ5j6vIEs1FmqkAVBTtFwZHh3IB0hEMwHpGg6qWy
         7K69e92lIXeUA0mKrrQEYIv03ZBalJCqV415sG/sX5aUlhOSBP6srts9Jw7lG4SMcCst
         ldP8KhjrAWir3TrCorsZO4zaxgt8JpWGUdd5fi7zs2SSOZRIzOHFqJUOQW9wR7Y4FDvu
         Vaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71SzAmW7a+qNOgggz8HL1zDFy+lLP5ZPJLe5Alcl3VE=;
        b=gnX5ikMc7IijOgNQArd8IRrzooUV5pffvYeXyMBPS5YAcqnW/ngjK7EnhVTUJ51PDM
         7vFtOwlku0Ofw5YE0Ce11I9+DL2ccUnjvdIXUfzku782iWydopZPBbifcBCwu4uE6OZS
         GnLuONaZ9eaBmWgtu3CSRbzIcgZPka623LUTVclMlK0RkW04JXOYtoQLS3Q6UcXDokhp
         WOMAioW8ATozCLIj+s9PtfVXJXY1+5Zvbgnu8MgtUuVkdRaBGqxZ6XvLrvr9eDwZEufa
         XCRXwczdvX0oZW/EF94+pMH8iLpVqJnx2VypWsV4jCAdScWYYB/oeJMbbOAF3rONelTp
         fgdg==
X-Gm-Message-State: APjAAAXKe6Fu3wkrt60STMW4BGX0pKUFl8fPQQCSQi5SYpjupSPU13jC
        TmlmR77+NyXmequG7LPsqX12ctp3BWs=
X-Google-Smtp-Source: APXvYqxthysPcpyZ1JRP7ZmhkhozRyyZy0iA+o694GAPqQrV4ZqpHEvNU0Si9Te4ecjOGNXl+vxD1A==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr26619296wmb.65.1555433560374;
        Tue, 16 Apr 2019 09:52:40 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id q8sm24798921wmq.35.2019.04.16.09.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:52:39 -0700 (PDT)
Subject: Re: [PATCH v4 07/12] thermal: qoriq: Convert driver to use
 devm_ioremap()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-8-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0d8055cb-61d8-ba45-4b21-6dd4d82584d9@linaro.org>
Date:   Tue, 16 Apr 2019 18:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-8-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Convert driver to use devm_ioremap() to simplify memory deallocation
> and error handling code. No functional change intended.
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
>  drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 0b6937bbc7d0..64cad6d4c1d7 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -175,6 +175,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> +	struct resource *io;
>  
>  	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
> @@ -183,7 +184,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
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
>  	if (!data->regs) {
>  		dev_err(dev, "Failed to get memory region\n");
>  		return -ENODEV;
> @@ -193,23 +200,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
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
> -		goto err_tmu;
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
> @@ -219,7 +220,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
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

