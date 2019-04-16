Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0777C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giEVzNR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfDPTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:23:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42868 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:23:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so28619341wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDYx7epngbmP/CMeNw7L8ab8CPJ0bEuFj8yGq0twy/U=;
        b=giEVzNR0s6KH9lYbUhfbWWrwojgHNm2klF7m38ladJx3vj7Iap2KT98L5xRyD5lW15
         e1NOB8w7zJ51+kyM1bDjBf4CSYz0a7r+2j5VNaRcJtZfP/v/MrHgzlFVSuSKjrE7Suu2
         XyekDuEAREiG8+CFuSEfWnSbNck31nWKtm0LyWbKfcTx2lJu5C4fNu9eub+EdGkrnMap
         ayMNTl0yKLeiyLh1HZZ/YnSTXYZFRnE11Wsha3Iw/oXkRyh3xfeSc0aVdgiQcRfZ+t7a
         IVi6dzXTsADBr1Cui3yejy0YC8gJYkp1iHG9TCkTQLiUAdfU+pEn8k09yQaYBbKu86EU
         huVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDYx7epngbmP/CMeNw7L8ab8CPJ0bEuFj8yGq0twy/U=;
        b=VDbFO6Ol/obThmxER0gCGHFymrP4D+Yid+k7aaDS9Cvi2blibEtEtBl9B3nDj4FEG+
         HyUYUCU/NhJ1QI+DoGxoJ0N4amkgIK9dCaA6QKtz2ngzp1uZXYWkWOoSRgPNS7/Rd3UL
         0isLDau0UbkX8j5N5DDeJliIqY+ezFYLSap9df4dgrE12EL9QMHFN+yoGLPVaSql9zFr
         2qW7HJCYe66bxhhdM3M78yzlKl+mvlEKJMjde8ZLO3xEduc9OWvLwViMTb/FotSvVRwf
         GGiHuV5J1HdO0+ebaPen9RRHnl4Arh4bomcGJ91xZopqwH0khP2jBoDa7inTAPTz83I7
         4L3A==
X-Gm-Message-State: APjAAAWpJWTlOt6dNTWUFCE2jN4vzT/GC9mzwbZBczbabAy/WHCYNwi0
        V6ym3ZoxIKBEb1Pc6AvbkLf52NY2RnA=
X-Google-Smtp-Source: APXvYqwvSLzXRPVwl9wYnW4Skw66lF5zMamiO/JBxgEw1HuFsoc9L+JTNJjmf6oYmZtpX543MoVudg==
X-Received: by 2002:adf:e94d:: with SMTP id m13mr31626911wrn.141.1555442581433;
        Tue, 16 Apr 2019 12:23:01 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id s18sm202287wmc.41.2019.04.16.12.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:23:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
To:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411100352.15977-1-jiada_wang@mentor.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <92504666-9e17-4c6d-fc74-6cf68b9f017b@linaro.org>
Date:   Tue, 16 Apr 2019 21:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100352.15977-1-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 12:03, Jiada Wang wrote:
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> this patch by moving request of IRQ after device initialization to
> avoid this issue.

Why not disable the interrupt and clear the irq status in the .remove
callback, so the place is clean when probing again?


        struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);

        rcar_thermal_irq_set(priv, false);

should do the trick no ?

> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 48 ++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..4d095d7f9763 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -375,28 +375,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	/*
> -	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
> -	 * to trigger on the low and high trip points of the current
> -	 * temp window at this point.
> -	 */
> -	for (i = 0; i < 2; i++) {
> -		irq = platform_get_irq(pdev, i);
> -		if (irq < 0)
> -			return irq;
> -
> -		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> -					 dev_name(dev), i);
> -		if (!irqname)
> -			return -ENOMEM;
> -
> -		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
> -						rcar_gen3_thermal_irq_thread,
> -						IRQF_SHARED, irqname, priv);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -458,6 +436,32 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		goto error_unregister;
>  	}
>  
> +	/*
> +	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
> +	 * to trigger on the low and high trip points of the current
> +	 * temp window at this point.
> +	 */
> +	for (i = 0; i < 2; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			ret = irq;
> +			goto error_unregister;
> +		}
> +
> +		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> +					 dev_name(dev), i);
> +		if (!irqname) {
> +			ret = -ENOMEM;
> +			goto error_unregister;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
> +						rcar_gen3_thermal_irq_thread,
> +						IRQF_SHARED, irqname, priv);
> +		if (ret)
> +			goto error_unregister;
> +	}
> +
>  	rcar_thermal_irq_set(priv, true);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

