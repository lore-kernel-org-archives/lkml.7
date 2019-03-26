Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FD42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQeFg1Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfCZVyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:54:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41683 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbfCZVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:54:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id y5so2253665plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CsfBGUZliIGBa11yqhYNq5TYER9Z49YakjKjtE6rJXQ=;
        b=PQeFg1ScNblxB6LLHwJ3dXTRL+iF1JHLldSxvU3M/q2yQYRsUoM2rvi4jrYJ/cuVWd
         QlVtItYaMxPAhaa5MipB7TqX9NPXVJafYqmG3nXt17ZbxCMAlalfktH+k/z/O1+9OOog
         6yFMkFLw7gxnRPCb4ItSMbAzcPYh4IgFyaHa8TBBsrnv6YTH5ykFijZovpWWvjs9eUX8
         nZBOAC836oO8tcNNptUCLBQhFVfM4GeSK7pNbV2/glzCg2Ln1QryjVyRFmo08mJYqG87
         sCUyVH7kZsBa/mNdKY/F8Pr+wISDQCUMuSkmFfGCQMeLRBMwqjI2MthAuCh4hVErx5hE
         ehcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsfBGUZliIGBa11yqhYNq5TYER9Z49YakjKjtE6rJXQ=;
        b=BBo7gxvTTtx1OAxcNiOh+JGUrDW6pedM2QjTjD2wMTuZ1NOCmnOIIei3C04t7a2oLr
         4NylonuAHpbiLymhSl2UsCVVV8Oyox88wwCLFbwdQ+LBnWJcYiw9OWYa9tGwAeJRZnll
         BUIPBOzLcZ8bLhuSZ0JBZReJRGiVXcWdbvQc5xh2NZ0vied6ggC05hBZKdz8LQHyeBcL
         qNEHHuGJE/nNMULwBwYmvQOkz8TGPh+gSMRCe5xr6zRWpfyBPrwXhdrjrF09YQT6fXOm
         wcWnCpLRFIimJoaYCHqzARxS3hAWYu5D5Wo28S54qEyZt+WZM7dDMIrDqlhTcFQmHYAh
         7Lxw==
X-Gm-Message-State: APjAAAU8ApAyWs6N3DOUq12AnElPJ7Axdm9c9WxleOHh4tZ2dHuP+PQg
        roy6jJtqhXRpg71aRas72Unx3w==
X-Google-Smtp-Source: APXvYqw8Vu64PhrCy0WmzRPkkHhZoPmwz5+0r1fWB5aJ+Dn0koiAMqyNVJ+i7SbQ17HIy8jSL7VFng==
X-Received: by 2002:a17:902:b40a:: with SMTP id x10mr25278857plr.231.1553637282826;
        Tue, 26 Mar 2019 14:54:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v20sm9843155pfn.116.2019.03.26.14.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 14:54:42 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:54:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
Subject: Re: [PATCH 10/25] coresight: tpiu: Clean up device specific data
Message-ID: <20190326215440.GB1658@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:27PM +0000, Suzuki K Poulose wrote:
> Switch to using the coresight device instead of the parent
> amba device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index b2f72a1..9763721 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -48,15 +48,13 @@
>  
>  /**
>   * @base:	memory mapped base address for this component.
> - * @dev:	the device entity associated to this component.
> + * @dev:	the coresight device entity associated to this component.
>   * @atclk:	optional clock for the core parts of the TPIU.
> - * @csdev:	component vitals needed by the framework.
>   */
>  struct tpiu_drvdata {
>  	void __iomem		*base;
>  	struct device		*dev;
>  	struct clk		*atclk;
> -	struct coresight_device	*csdev;

Here again I would get rid of @dev rather than @csdev to be consistent with what
was done previously.

Mathieu

>  };
>  
>  static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
> @@ -121,6 +119,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct tpiu_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> +	struct coresight_device *csdev;
>  	struct device_node *np = adev->dev.of_node;
>  
>  	if (np) {
> @@ -134,7 +133,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> @@ -160,9 +158,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &tpiu_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	drvdata->csdev = coresight_register(&desc);
> +	csdev = coresight_register(&desc);
> +	if (!IS_ERR(csdev))
> +		drvdata->dev = &csdev->dev;
>  
> -	return PTR_ERR_OR_ZERO(drvdata->csdev);
> +	return PTR_ERR_OR_ZERO(csdev);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.7.4
> 
