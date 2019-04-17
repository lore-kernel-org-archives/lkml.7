Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772BEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A88F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2UHl/a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfDQUeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:34:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33191 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:34:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so85339pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Txu2pNwANmfIrqpmFvCs7lHKfCWV4hN8q26eEPlsULM=;
        b=m2UHl/a0zRHzYjIjkehNNLc9RD1K4Qks1O0DClAbh/KDXihByze+3vPSXM3H8I27rt
         xuka8Wqo3/s32QGkMTdPJjvRzrRYN1duQu8i7CwIp3dnjVd+i0m/zMNBBByc7rFlTau6
         QfGnhI5WZ0dGs4jNPNI3KaMhXEY9hv4sv8B9dbGh2jnyx7p4dulkxopb0XdvhiA6Axox
         M5HRJ+Hwus8oPJKLsH3YsypGmuLrIaMEKbi4axIbZRUvgU5w4UgA4eGG1JsA9NNOpE7U
         /YK/5JAyfN7GJTyIyvaWs+/Xj/mmTN5gJd/awMs761N0nmlri+cuI/Ot0uxvmPdcigLj
         0TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Txu2pNwANmfIrqpmFvCs7lHKfCWV4hN8q26eEPlsULM=;
        b=hPqIkxA5QsXf5X4vChgWOdK1TkwAs11okHk3QpPAYvn7uhUWJgdc7CpMaTc4vFW/mK
         bMAZEsqBiWvSocV78mkXjl8Lr+wygr0U1KczLccS/0ZoIiwaBKdD2GX5HNLwY7uETz8s
         aQVFsUw8lhPU9ru9vs7hyQOB9Fg7QwGXP1aQ+zTlOq7e9LeZzM7FyX6Kxo3YF2JGFRqc
         9AcBDS6VtNf+AOuApNTIQK9IOcZ2Le3SZbkwioqKLYhnCY8WbU6tbkXGSdhvcANn3kWf
         /aGxZO6utoH9c3azRBU1bJWsaxz7NADGe8a+4iOjDtH7sM4WxRLu1cFsqJsIP+WVDsQZ
         65NQ==
X-Gm-Message-State: APjAAAU2KtYDFShHgObAZOCK2OnBMu8iRUy08C4mCjig+JOFMes3quFj
        6muV2s13wZ2YQBpGQfw7vh159w==
X-Google-Smtp-Source: APXvYqzPbbF17LVnv2ToEEEsHdn78FUhFyenHDucdW+I/Sjw5d2WaSPEQOIoYNl3/fDhf/RD0Gd/CQ==
X-Received: by 2002:a62:b602:: with SMTP id j2mr92744764pff.68.1555533261716;
        Wed, 17 Apr 2019 13:34:21 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o68sm49732pfi.140.2019.04.17.13.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:34:20 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:34:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 07/36] coresight: replicator: Cleanup device tracking
Message-ID: <20190417203418.GB14163@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-8-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-8-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:50PM +0100, Suzuki K Poulose wrote:
> In preparation to use a consistent device naming scheme,
> clean up the device link tracking in replicator driver.
> Use the "coresight" device instead of the "real" parent device
> for all internal purposes. All other requests (e.g, power management,
> DMA operations) must use the "real" device which is the parent device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 4e0da85..8bbb008 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -26,13 +26,11 @@
>   * struct replicator_drvdata - specifics associated to a replicator component
>   * @base:	memory mapped base address for this component. Also indicates
>   *		whether this one is programmable or not.
> - * @dev:	the device entity associated with this component
>   * @atclk:	optional clock for the core parts of the replicator.
>   * @csdev:	component vitals needed by the framework
>   */
>  struct replicator_drvdata {
>  	void __iomem		*base;
> -	struct device		*dev;
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  };
> @@ -100,7 +98,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  	if (drvdata->base)
>  		rc = dynamic_replicator_enable(drvdata, inport, outport);
>  	if (!rc)
> -		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
> +		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
>  	return rc;
>  }
>  
> @@ -139,7 +137,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  
>  	if (drvdata->base)
>  		dynamic_replicator_disable(drvdata, inport, outport);
> -	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
> +	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
>  }
>  
>  static const struct coresight_ops_link replicator_link_ops = {
> @@ -193,7 +191,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = dev;
>  	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
