Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5775C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B82221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcxbJRv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfDRQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:50:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45922 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:50:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so1355737pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckm25HFpHOCsBiC4iTMsYZI+aUwZkDKtbZRGsrwYOGY=;
        b=BcxbJRv6bqPOZjAjmxBZ08bJwvlqhWPaZXkRxdoPHKMscTjaEFiudDSzehDwWy5J/X
         n7Ol4ETdWQhIdbbtF2BiBKGuwKVbkKU2vsfsR/sNiXhD3B6DkmJVq3UwpUIayRWkSuKQ
         Bh8IbFTaATjjCH7HDmUNvOSXkiWr5YA8B/obt95zdf3T/yVfuVSbQMEuBvc0LXFGQvYu
         MiUs7tFGCmbh3tLlx+LN/VBnN7iAqiC0LLbjHBdzY5JWbPciLwsveVx6xs5OWl88mp9J
         yGb5ZFRAKteWmS82/yQv7VGKN/1PArallj44TmFoNYI1zqwMDhBLoSSuPRU4zyHFHdZX
         eZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckm25HFpHOCsBiC4iTMsYZI+aUwZkDKtbZRGsrwYOGY=;
        b=ZrsEqYcy4sx0dN3llO94GJ/bC8DdQy+85K1y2Y79MNESgJ/NmZHMq890cSuyKKFF3f
         Naow6cya/LOePYjNSBxFKnyq4Id9ToCtit6rXT72oQmRik0Je5EhBcl6Ef8M5V5VApuR
         D0H5WFcr6AkZKsxK8+Je4CtuG9+4zuBif8U9HCwBjD1GF+8CSmoHM5xN0XRl55Yw1y6y
         Xch8InPHHohN2qkRm96Ek1eB6wT/GW2bgmbBQ0yDYRrhl5QRw1Tw0kUTzV07YEVyWici
         NgWVMsCXC7saqt0C9LLRsyaSyJzeKdicADuVta2XK2aZE4I8SuJwB0yocDRXicbM8JRS
         XBIw==
X-Gm-Message-State: APjAAAVil9GEzLwqwKklwxY2b7pOUe4t5dHvVhDtqPWTezPrMhf9LB91
        1thZSxr6Ef4sB4ljfwabadGNag==
X-Google-Smtp-Source: APXvYqxzYiVKlNqGtj3DgSJB6XN2U81bkT7crEERUhx5M8IDR3cEeY1W1oEOgF0j2cQTBx3mR0k6wQ==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr88126788pgd.255.1555606234093;
        Thu, 18 Apr 2019 09:50:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a9sm3554035pfo.17.2019.04.18.09.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 09:50:32 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:50:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 11/36] coresight: stm: Cleanup device specific data
Message-ID: <20190418165030.GA10675@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-12-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-12-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:54PM +0100, Suzuki K Poulose wrote:
> Keep track of the STM coresight device which is a child device
> of the AMBA device. Since we can get to the coresight_device
> from the "device" instance, remove the explicit field.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 9f8a844..8f50484 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -110,7 +110,6 @@ struct channel_space {
>  /**
>   * struct stm_drvdata - specifics associated to an STM component
>   * @base:		memory mapped base address for this component.
> - * @dev:		the device entity associated to this component.
>   * @atclk:		optional clock for the core parts of the STM.
>   * @csdev:		component vitals needed by the framework.
>   * @spinlock:		only one at a time pls.
> @@ -128,7 +127,6 @@ struct channel_space {
>   */
>  struct stm_drvdata {
>  	void __iomem		*base;
> -	struct device		*dev;
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  	spinlock_t		spinlock;
> @@ -205,13 +203,13 @@ static int stm_enable(struct coresight_device *csdev,
>  	if (val)
>  		return -EBUSY;
>  
> -	pm_runtime_get_sync(drvdata->dev);
> +	pm_runtime_get_sync(csdev->dev.parent);
>  
>  	spin_lock(&drvdata->spinlock);
>  	stm_enable_hw(drvdata);
>  	spin_unlock(&drvdata->spinlock);
>  
> -	dev_dbg(drvdata->dev, "STM tracing enabled\n");
> +	dev_dbg(&csdev->dev, "STM tracing enabled\n");
>  	return 0;
>  }
>  
> @@ -271,10 +269,10 @@ static void stm_disable(struct coresight_device *csdev,
>  		/* Wait until the engine has completely stopped */
>  		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
>  
> -		pm_runtime_put(drvdata->dev);
> +		pm_runtime_put(csdev->dev.parent);
>  
>  		local_set(&drvdata->mode, CS_MODE_DISABLED);
> -		dev_dbg(drvdata->dev, "STM tracing disabled\n");
> +		dev_dbg(&csdev->dev, "STM tracing disabled\n");
>  	}
>  }
>  
> @@ -763,9 +761,10 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
>  	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
>  }
>  
> -static void stm_init_generic_data(struct stm_drvdata *drvdata)
> +static void stm_init_generic_data(struct stm_drvdata *drvdata,
> +				  const char *name)
>  {
> -	drvdata->stm.name = dev_name(drvdata->dev);
> +	drvdata->stm.name = name;
>  
>  	/*
>  	 * MasterIDs are assigned at HW design phase. As such the core is
> @@ -807,7 +806,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> @@ -848,7 +846,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	spin_lock_init(&drvdata->spinlock);
>  
>  	stm_init_default_data(drvdata);
> -	stm_init_generic_data(drvdata);
> +	stm_init_generic_data(drvdata, dev_name(dev));
>  
>  	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
>  		dev_info(dev,
> @@ -870,7 +868,8 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	pm_runtime_put(&adev->dev);
>  
> -	dev_info(dev, "%s initialized\n", (char *)coresight_get_uci_data(id));
> +	dev_info(&drvdata->csdev->dev, "%s initialized\n",
> +		 (char *)coresight_get_uci_data(id));
>  	return 0;
>  
>  stm_unregister:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
