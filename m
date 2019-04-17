Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D3C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655DF20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AazDcyvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfDQVlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:41:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:41:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so151892pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ9SeRh+I92cdeR9Te1IKI13XPUurU8AmNT0L6J6l2w=;
        b=AazDcyvOSGwA8SDsYtFFXnJ/yiaj4PyxS4h943e8NaOM/znrvtUHVXUlC436zH7kPU
         snJaIOuZjzriu3VXFMAdmzkg82LOKP6fL7YD8yb/5dmLI9prQBjOxZlL/3SJCva4pEix
         kz0Q3GLPL9YlxGNQzMnhew2t2hOBHplbkgRxYhaKhOulpo7e+VLvaRXwsSYXFLQ5Mx1L
         g8CJr0ajy/ccK4IyCugnJCyWCVMQoUOFFSr/GuU+4ElxMv2g/7U14smifbaiPJl8be/x
         Wgoit2DaBL79s9X33hFxdCGdVEBLZi3fbCtaNB0w9Ej5ZQR9vomfu9lwkaJ4m55KGFAE
         qBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ9SeRh+I92cdeR9Te1IKI13XPUurU8AmNT0L6J6l2w=;
        b=Y8sGDqsSyUxMfVwGqrtZB5CWF5K8kbqjsC3VOuBE5qjRn+gOuU8VNfVtIm9KVvC5VL
         kfEDLN4lxE3dq4/yt27H06G+4zUo/e8CdEsYNXB9vx03hIx9goVe8HraZwIRpNenSWrs
         jqVt7jR6nbwNNqf5Y1KPD78lW0VseowI1pTI8VR9Xs+CdTHdVg4076gFtqKXt0GtLiGa
         nrukXnxJm153qMEYMBWBonkFbZvWyePcVfsuoMpT2yoo3iHMxEbFzTworDrVtbwY818E
         4e2CcJF8PysMx/NsO47AbdpobGPElr9ZvbJgXHKt/xajT+Uoqa2yBxAcESx2sRB9Xtgo
         ZOKA==
X-Gm-Message-State: APjAAAVTzLrK87Gs2XUVc8BmwoisuuzMAoD7xym1g8ePNmbHoBUKFL16
        exR7e8dLSYWnwD6tZr2OimcCAA==
X-Google-Smtp-Source: APXvYqwtI0/zVunq/pSmVDxSCRBW5aK+JP1iUbpjsluC8AzIc5NsNcYQGenpKUugOxpGKQism88Vlg==
X-Received: by 2002:a65:6649:: with SMTP id z9mr5907536pgv.392.1555537306100;
        Wed, 17 Apr 2019 14:41:46 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 6sm174760pfp.143.2019.04.17.14.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:41:45 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:41:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 10/36] coresight: tpiu: Clean up device specific data
Message-ID: <20190417214143.GE14163@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-11-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:53PM +0100, Suzuki K Poulose wrote:
> Switch to using the coresight device instead of the parent
> amba device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 4977467..96af7d5 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -54,7 +54,6 @@
>   */
>  struct tpiu_drvdata {
>  	void __iomem		*base;
> -	struct device		*dev;

Please cleanup structure documentation.  With that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  };
> @@ -74,7 +73,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
>  
>  	tpiu_enable_hw(drvdata);
>  
> -	dev_dbg(drvdata->dev, "TPIU enabled\n");
> +	dev_dbg(&csdev->dev, "TPIU enabled\n");
>  	return 0;
>  }
>  
> @@ -100,7 +99,7 @@ static void tpiu_disable(struct coresight_device *csdev)
>  
>  	tpiu_disable_hw(drvdata);
>  
> -	dev_dbg(drvdata->dev, "TPIU disabled\n");
> +	dev_dbg(&csdev->dev, "TPIU disabled\n");
>  }
>  
>  static const struct coresight_ops_sink tpiu_sink_ops = {
> @@ -134,7 +133,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
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
