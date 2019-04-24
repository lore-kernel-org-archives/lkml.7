Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478A920878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx5JpxXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfDXJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:31:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfDXJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:31:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so4013767wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zPRnHJyP7MBAi9zOcZR0+ZD+ek4HtjO6VwtIfrnPTfw=;
        b=fx5JpxXZTKESXUcytCv2F5A2xeKMFyzC6c1QwdfROnEGMgD2nVWBuEmh79BtaojYws
         Tw3O+9/yAI5OFJDo4oDBG83RTcfymvuAP2YDYG5V9zd/39PBbiMlg+LV/RJB/ulihKi3
         9OfcvWk31VHOL6hb+k6KJAvRSFGACmsO2Nc4V63ffjvrIciCj1PyfmxskkuGlxDhCpkx
         ifPQRTEQ3gCe3sV4zNhee1isWqGY/RSKes2rakAG+wiiGevhi9/Rpoqt/vTyh7J3yHvL
         YiAEwBQeigoKGnZYg727n8LWTm/6p//DO02Dxc0QdjsIxkWISQI0r7jqg9oZfZ3gclaf
         W7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPRnHJyP7MBAi9zOcZR0+ZD+ek4HtjO6VwtIfrnPTfw=;
        b=OqyEAIFinyXzTmYtcmnNI0verx0QPyBm/zFI4cLTquecEE1DKZZkiOeHFvWQdABJUW
         mD3IP3QLQ3tk6ipadMWHx1KARmnAg76WhQUPS6LTAF0RKEpV7y/ZoX1ax4/2zQNN6N0J
         hYVQXl657yzAztKcpfJ7T6Dl8FIUIMqvQB73RA65NsAbrs0oRWS286xE9f3iE4PIIQXy
         vgrr3IXgGMbrphPm4qRMltcmUsgn4KO3DqNg96V+jDNw5wzigKnk9PJFt8W7LdDmcNFF
         oHw/gqiwiBpafbQIEoYvtsAtQrnKpidrp7w+3YDVdwGTgL6tBGYgk79/pz0OQaaGf/zZ
         Okgg==
X-Gm-Message-State: APjAAAWYjxY7AesyyM1LskyILgkZRfjdLxrqo4rrZgfph3doUuCNxiP8
        lHu1kEtf99b+tAAXnY6FgLBkfg==
X-Google-Smtp-Source: APXvYqwZAjf0D1iWvVHNuv6Q7OFzvz22Em3JLPty9j9ul50KVvYUE3lwV/ti8BrbBS81XLmO4USSmQ==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr5979658wmk.103.1556098307752;
        Wed, 24 Apr 2019 02:31:47 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id g132sm16149811wme.3.2019.04.24.02.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:31:47 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] thermal: rcar_gen3_thermal: fix interrupt type
To:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se,
        geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
        marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com,
        hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com,
        dien.pham.ry@renesas.com, biju.das@bp.renesas.com,
        erosca@de.adit-jv.com, george_davis@mentor.com,
        joshua_frkuska@mentor.com
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-2-jiada_wang@mentor.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1bdc45cd-12fb-e607-1ab5-f06a022b263e@linaro.org>
Date:   Wed, 24 Apr 2019 11:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424051145.23072-2-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2019 07:11, Jiada Wang wrote:
> Currently IRQF_SHARED type interrupt line is allocated, but it
> is not appropriate, as the interrupt line isn't shared between
> different devices, instead IRQF_ONESHOT is the proper type.
> 
> By changing interrupt type to IRQF_ONESHOT, now irq handler is
> no longer needed, as clear of interrupt status can be done in
> threaded interrupt context.
> 
> Because IRQF_ONESHOT type interrupt line is kept disabled until
> the threaded handler has been run, so there is no need to protect
> read/write of REG_GEN3_IRQSTR with lock.
> 
> Fixes: 7d4b269776ec6 ("enable hardware interrupts for trip points")
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 38 +++++------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..065e16f53285 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -14,7 +14,6 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/spinlock.h>
>  #include <linux/sys_soc.h>
>  #include <linux/thermal.h>
>  
> @@ -82,7 +81,6 @@ struct rcar_gen3_thermal_tsc {
>  struct rcar_gen3_thermal_priv {
>  	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
>  	unsigned int num_tscs;
> -	spinlock_t lock; /* Protect interrupts on and off */
>  	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
>  };
>  
> @@ -232,38 +230,16 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_gen3_thermal_priv *priv = data;
>  	u32 status;
> -	int i, ret = IRQ_HANDLED;
> +	int i;
>  
> -	spin_lock(&priv->lock);
>  	for (i = 0; i < priv->num_tscs; i++) {
>  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
>  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
>  		if (status)
> -			ret = IRQ_WAKE_THREAD;
> +			thermal_zone_device_update(priv->tscs[i]->zone,
> +						   THERMAL_EVENT_UNSPECIFIED);
>  	}
>  
> -	if (ret == IRQ_WAKE_THREAD)
> -		rcar_thermal_irq_set(priv, false);
> -
> -	spin_unlock(&priv->lock);
> -
> -	return ret;
> -}
> -
> -static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
> -{
> -	struct rcar_gen3_thermal_priv *priv = data;
> -	unsigned long flags;
> -	int i;
> -
> -	for (i = 0; i < priv->num_tscs; i++)
> -		thermal_zone_device_update(priv->tscs[i]->zone,
> -					   THERMAL_EVENT_UNSPECIFIED);
> -
> -	spin_lock_irqsave(&priv->lock, flags);
> -	rcar_thermal_irq_set(priv, true);
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -
>  	return IRQ_HANDLED;
>  }
>  
> @@ -371,8 +347,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	if (soc_device_match(r8a7795es1))
>  		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
>  
> -	spin_lock_init(&priv->lock);
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	/*
> @@ -390,9 +364,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (!irqname)
>  			return -ENOMEM;
>  
> -		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
> -						rcar_gen3_thermal_irq_thread,
> -						IRQF_SHARED, irqname, priv);
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						rcar_gen3_thermal_irq,
> +						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
>  			return ret;
>  	}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

