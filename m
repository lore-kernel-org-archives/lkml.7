Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF234C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E8217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xp1npuED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfDQUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:14:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42920 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:14:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so42229pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JC9yE9af9U2pjoW4U5FTdo35gfxjQacok5B8LzuugEg=;
        b=Xp1npuEDfQM5yQ8o38lrgZXhNchh+lFGixQKIsPhWNR4eYtjSFDoMZGiZfo7rAz1+Y
         iLypeviky4swWurmPF00UWhyRT1DnBvt4TiO5uJdhXPipKUMqOXUFSyUdXCZEzb37nS7
         C6cHUBb1/iPis0exByaGpw1Em+UZZbq09sHf7lATPqBDGC4r6xZvuLi/gGfjag8aTivg
         ayaoD20t+GflGDi0vF2oya6IIeVj/UcdLmUd0z6CrDxJsjOMfwjVJmQ4CQ2h7soYhscL
         CXowtbkGQnx5Wr9H8TuArXOMr1QABEbHHM5z0C4k/UIN0KgAGGgfETTufVmweI+OsKuT
         +abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JC9yE9af9U2pjoW4U5FTdo35gfxjQacok5B8LzuugEg=;
        b=m/rsL4ox1mwYNyKAo3rYx0ItAcYFDxN49soi5zRgjrk3Q1zIQjEv+cYlpvliSuN5ck
         jPTT8PILIXu0mPQAlb5q5mBUjkutuw+xztyitnjXakqGKFnw4BFzGJZtiWW5fAoFUUr2
         N+Q4x1EMl35uGX9grCzCUCk0p4crrY0p87G/fdhgBzdddXGO5WRq1uJL7szyeMhkAE93
         9v2Jc+/U+I2BAGCvXxNtVR1u4jg1lCEJNSDRvHAhfVtF4/BQWNJguCsRAmwkNciK1X/+
         KtMFwmUeZKWLf584UyZxgDh708/fEW7gq0j0Lcj5txRYNbgqIAH2rpht2U9e3UD+Go/Y
         vckw==
X-Gm-Message-State: APjAAAUhLLH2aDVKyJ7xHmFc5YX+IX0dcgJDKWt3nv0KexoJuSou6pmD
        6tL0YEe1VYGU1rfWrmnw8J3WIecVXMg=
X-Google-Smtp-Source: APXvYqyFgWSqZZj7Wgvce0yQqH+MvtD/uGa5qgRRsbnk/36/kOunYTaSzfgElO9q6jVDiU8t+1RnbQ==
X-Received: by 2002:a65:494b:: with SMTP id q11mr1663726pgs.444.1555532063782;
        Wed, 17 Apr 2019 13:14:23 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm31035pfp.70.2019.04.17.13.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:14:23 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:14:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 06/36] coresight: funnel: Clean up device book keeping
Message-ID: <20190417201421.GA14163@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:49PM +0100, Suzuki K Poulose wrote:
> In preparation to use a consistent device naming scheme,
> clean up the device link tracking in funnel driver.
> Use the "coresight" device instead of the "real" parent device
> for all internal purposes. All other requests (e.g, power management,
> DMA operations) must use the "real" device which is the parent device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 9279251..1085f31 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -37,7 +37,6 @@
>   */
>  struct funnel_drvdata {
>  	void __iomem		*base;
> -	struct device		*dev;

Please remove @dev from the structure documentation.

With that:
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  	unsigned long		priority;
> @@ -77,7 +76,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
>  	rc = funnel_enable_hw(drvdata, inport);
>  
>  	if (!rc)
> -		dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
> +		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
>  	return rc;
>  }
>  
> @@ -105,7 +104,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
>  
>  	funnel_disable_hw(drvdata, inport);
>  
> -	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
> +	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
>  }
>  
>  static const struct coresight_ops_link funnel_link_ops = {
> @@ -160,11 +159,11 @@ static ssize_t funnel_ctrl_show(struct device *dev,
>  	u32 val;
>  	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  
> -	pm_runtime_get_sync(drvdata->dev);
> +	pm_runtime_get_sync(dev->parent);
>  
>  	val = get_funnel_ctrl_hw(drvdata);
>  
> -	pm_runtime_put(drvdata->dev);
> +	pm_runtime_put(dev->parent);
>  
>  	return sprintf(buf, "%#x\n", val);
>  }
> @@ -199,7 +198,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> -- 
> 2.7.4
> 
