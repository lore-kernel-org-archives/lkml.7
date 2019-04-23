Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA73C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04760218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vx4afLro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfDWWfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:35:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33823 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:35:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so16550746wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTybR1aW4eMZpVM1uldf9iC6bC/GBH50ffUN3hamtG0=;
        b=Vx4afLro/WD83P4uJyKAb7v/cxOSWu4BWx4YIAx+LBji7NIgSkt6kOcy3JngCCvxfv
         ic9xr0YOmE60cQj08JNUKIn922CoGXcO67ZN6k4zgUq9KiXSP+Rv3ztvgN1AnUi4xVVH
         y5Sh6mSlUft9f8fSGSKj+hNqYRKKWAiA0QOzjkz2qdAWEHPUANZ2uhTLXE9JVWkL/e8N
         mYSy1s3lO4ADJd+Jm7dWmQ3tsYTj7gg1YROR42YX9mbj7JYGm5ykWrf26HZLak1HbXvK
         105DyNSsUYtZdtz4kvE8YerUgXhuq+MANXL2fNK9BD8cZ3o3CiUSV0UEB5Owtey11gvz
         lP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTybR1aW4eMZpVM1uldf9iC6bC/GBH50ffUN3hamtG0=;
        b=gTD5o6OGmILFc6WMn/SPkvhTZ5v5v0mB1mAr4bpX/Gg1VBjV+j5BwVf+KD9XnQzbOE
         vCDaNkwAInPXA8oyGH3FuEtsjxhYNOS7GkwlWR7Iu6YIMb7JpOR3pRxCanmN/lySAd6N
         SLSnJfExe+4zVqTG1XV0dkFXZ38N5vK7pn0AslYkgb+raOMktBlxJ53nglV4IM7SDuqQ
         d1hdfDLc/2JzIKaLIdN9Fz0kmO2vYGS6Yl9SGL2Hn5N1Ww3GxPoh1RMWNJaSNr/BjgW4
         0tM75B/vNVb9TJ39InQ5Mcf3GHe0syECYIs3TqYCT8N3wqcfH0G1XdxM2xAqxHu5GN3w
         KOOQ==
X-Gm-Message-State: APjAAAV52gxWr9Xhh+5M8RI1Vv/GHnTC8A1tuZm3FMTSxcDXBP75zAjG
        mvvcGL7pCejHNSJVLstCfD69gQ==
X-Google-Smtp-Source: APXvYqzO6ItVlv+jOBS7oMAObK1iiVAYVVl5ns4bMXuZsJgxjdMMjG8Nv11QymMvslkH+J7MV9NF8g==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr19592026wrn.187.1556058930029;
        Tue, 23 Apr 2019 15:35:30 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u189sm21269883wme.25.2019.04.23.15.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:35:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] thermal: rcar_gen3_thermal: fix interrupt type
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
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-2-jiada_wang@mentor.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a8e7d5d8-056c-a130-bf89-c3a29e982821@linaro.org>
Date:   Wed, 24 Apr 2019 00:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423141414.24264-2-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 16:14, Jiada Wang wrote:
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
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Fixes: 7d4b269776ec6 ("enable hardware interrupts for trip points")
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>





> ---
>  drivers/thermal/rcar_gen3_thermal.c | 34 +++++------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..ebbaef5a3cf1 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -231,39 +231,17 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
>  static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_gen3_thermal_priv *priv = data;
> +	int i;
>  	u32 status;
> -	int i, ret = IRQ_HANDLED;
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
> @@ -390,9 +368,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
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

