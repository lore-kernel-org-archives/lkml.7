Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA214C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F2218BE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562311927;
	bh=JpmYmVJdeyOKL4gwfK9NXbgVVN4HNKQ6CivC20fWqqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCQZnYaT7lbXbqPa9y5lYehbHn8t15E/jsAtfpdgA0IDzaDsyRsH+hKJAcL0VXCR+
	 WdgDIUaciRnxassfyB56WFw8eqOQnlNGSYqs/emozpTIdSC1qj67JtSu2UNSc0bOjk
	 jHsOvPuUZP8N1MJPZKrDtzNHZQfeABLsSNZRAYLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfGEHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfGEHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:32:06 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CCF3218BC;
        Fri,  5 Jul 2019 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562311924;
        bh=JpmYmVJdeyOKL4gwfK9NXbgVVN4HNKQ6CivC20fWqqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnLFo2FLjiZCzplwEuXBb7HQqUmixvzRudP2KPjeGnfV8x4I0jsHtDQv/lsAFHipF
         MAnfumrro3iJ4+cc8iIPA3TlbhTv17V/+pT+tDVkPJwaoX4qk21v108RuSZOi5V6XR
         IO/qXGYfvW1qP5de/j1w2S4gsX4vTuHkwnZQHLBg=
Date:   Fri, 5 Jul 2019 12:58:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error
 path
Message-ID: <20190705072847.GA2911@vkoul-mobl>
References: <20190624140731.24080-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624140731.24080-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 10:07, Sven Van Asbroeck wrote:
> If probe() fails anywhere beyond the point where
> sdma_get_firmware() is called, then a kernel oops may occur.
> 
> Problematic sequence of events:
> 1. probe() calls sdma_get_firmware(), which schedules the
>    firmware callback to run when firmware becomes available,
>    using the sdma instance structure as the context
> 2. probe() encounters an error, which deallocates the
>    sdma instance structure
> 3. firmware becomes available, firmware callback is
>    called with deallocated sdma instance structure
> 4. use after free - kernel oops !
> 
> Solution: only attempt to load firmware when we're certain
> that probe() will succeed. This guarantees that the firmware
> callback's context will remain valid.
> 
> Note that the remove() path is unaffected by this issue: the
> firmware loader will increment the driver module's use count,
> ensuring that the module cannot be unloaded while the
> firmware callback is pending or running.
> 
> To: Robin Gong <yibin.gong@nxp.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/dma/imx-sdma.c | 48 ++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 99d9f431ae2c..3f0f41d16e1c 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2096,27 +2096,6 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (pdata && pdata->script_addrs)
>  		sdma_add_scripts(sdma, pdata->script_addrs);
>  
> -	if (pdata) {
> -		ret = sdma_get_firmware(sdma, pdata->fw_name);
> -		if (ret)
> -			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
> -	} else {
> -		/*
> -		 * Because that device tree does not encode ROM script address,
> -		 * the RAM script in firmware is mandatory for device tree
> -		 * probe, otherwise it fails.
> -		 */
> -		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
> -					      &fw_name);
> -		if (ret)
> -			dev_warn(&pdev->dev, "failed to get firmware name\n");
> -		else {
> -			ret = sdma_get_firmware(sdma, fw_name);
> -			if (ret)
> -				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> -		}
> -	}
> -
>  	sdma->dma_device.dev = &pdev->dev;
>  
>  	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
> @@ -2161,6 +2140,33 @@ static int sdma_probe(struct platform_device *pdev)
>  		of_node_put(spba_bus);
>  	}
>  
> +	/*
> +	 * Kick off firmware loading as the very last step:
> +	 * attempt to load firmware only if we're not on the error path, because
> +	 * the firmware callback requires a fully functional and allocated sdma
> +	 * instance.
> +	 */
> +	if (pdata) {
> +		ret = sdma_get_firmware(sdma, pdata->fw_name);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
> +	} else {
> +		/*
> +		 * Because that device tree does not encode ROM script address,
> +		 * the RAM script in firmware is mandatory for device tree
> +		 * probe, otherwise it fails.
> +		 */
> +		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
> +					      &fw_name);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to get firmware name\n");

if should have braces!

> +		else {
> +			ret = sdma_get_firmware(sdma, fw_name);
> +			if (ret)
> +				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> +		}
> +	}
> +
>  	return 0;
>  
>  err_register:
> -- 
> 2.17.1

Applied after fixing braces!


-- 
~Vinod
