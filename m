Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9172075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0Y8HAOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfC0VjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:39:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfC0VjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:39:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so10588276pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBV2iWRa128NukJOca+ZJOE7a9nsnhgZrO3OcTK2QDQ=;
        b=U0Y8HAOxfokWlttEecHSPsLlhrxdx11ala0IGrN/CocsPjoo62RZHfoDBVhQ/5L6YS
         FWm19MxGeutCWxvup18/nJdRj/8zyUEsrnUqm9an2PMg+rXEIf145SOgVXTiTJimNz8e
         ZUKHiZPqNT70iIYIg6oKBTw18wz26EKsdgfT7I5hW2F4ie/Q98uuTFS0s7nuC0zQwgLW
         PuFMR6yHWxNw6RGiyFM3952t2ih+q3ZLKAM66m8qND+7L1BsNARJUxyotBmrxoh967J2
         NmCfuJkQS9+hxLPz861t0oT0YjjvSnScg+oNV2hAQ6TKUph4aT9EFt6d5ZvOoylI/tkw
         EiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBV2iWRa128NukJOca+ZJOE7a9nsnhgZrO3OcTK2QDQ=;
        b=kSecH7rFEVVW/9JjALqZ9aVnvscG4hrQgS7KjTYHL7pYSd1tY9/XD2qrw/2ZOzNPEi
         Y0eUfPnfAenuJiLdyIEv4kjG9viEjbcYYOM1DhptlPwALtrXWCEmAxnW7wgBnBX9WP7h
         eGwz6N/r1NYdNAhB5HDJEK2v/SHuX1zaZw1lS37S6QB+7uj8L0tqVhKn+8jEM3XVJGRN
         ORo2LkQoDqg0xSgbR1YEnrYcdnXjBzh/FtrEGsiycw9m0SAuhkHaTFSZpL2uFiUi5nWg
         0cyHD5t6wy4LhjAq592SEdYZbKHRSKW2IuXHPfvQdn35LlFySRcxz1Hww2aHZtwNr3ay
         ZfnQ==
X-Gm-Message-State: APjAAAUyAVk7KRfxX/Ml1bjDOfFiFHxkNwVgKtRDcatJya9iHcj6OvPF
        4VTHTRx3zSVGRPnjOk5NfUJkgA==
X-Google-Smtp-Source: APXvYqwThrNPLjybOVBMjw2KMgR3vvAYThS+zOpELeEMhDbRUQytn/3xZlbyFy8/U9kgFS8RYhW4KA==
X-Received: by 2002:aa7:8589:: with SMTP id w9mr37468920pfn.97.1553722746354;
        Wed, 27 Mar 2019 14:39:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v6sm13134721pgv.92.2019.03.27.14.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 14:39:05 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:39:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
Subject: Re: [PATCH 13/25] coresight: etb10: Clean up device specific data
Message-ID: <20190327213903.GA778@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:30PM +0000, Suzuki K Poulose wrote:
> Track the coresight device instead of the real device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 105782e..a471cbd 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -97,12 +97,12 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>  {
>  	u32 depth = 0;
>  
> -	pm_runtime_get_sync(drvdata->dev);
> +	pm_runtime_get_sync(drvdata->dev->parent);
>  
>  	/* RO registers don't need locking */
>  	depth = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
>  
> -	pm_runtime_put(drvdata->dev);
> +	pm_runtime_put(drvdata->dev->parent);
>  	return depth;
>  }
>  
> @@ -701,7 +701,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> @@ -740,6 +739,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(drvdata->csdev))
>  		return PTR_ERR(drvdata->csdev);
>  
> +	drvdata->dev = &drvdata->csdev->dev;

For patch 11, 12, 13 - same comment as earlier.  Let's use drvdata::csdev
and get rid of drvdata::dev.

>  	drvdata->miscdev.name = pdata->name;
>  	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	drvdata->miscdev.fops = &etb_fops;
> -- 
> 2.7.4
> 
