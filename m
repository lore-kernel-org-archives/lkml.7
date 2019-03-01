Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ADD2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfCAO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:26:10 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39927 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbfCAO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:26:09 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A823FE000D;
        Fri,  1 Mar 2019 14:26:02 +0000 (UTC)
Date:   Fri, 1 Mar 2019 15:26:02 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Brian Brooks <brian.brooks@linaro.org>,
        David Miller <davem@davemloft.net>, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20190301142602.GC3554@kwain>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
 <20180827135524.fv4mxkwjn5bv7p5e@di3>
 <20180827154843.GA25821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180827154843.GA25821@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I saw you sent this patch as part of another series back in August, but
it seems it was never applied and I can't find it even in -next. We made
some tests and this patch is helping a lot the PPv2 engine driver in
improving its performances.

Do you plan on re-sending it, or reworking it? Are there current issues
with it that prevent it from being merged upstream? Can we help in any
way?

Thanks!
Antoine

On Mon, Aug 27, 2018 at 08:48:43AM -0700, Christoph Hellwig wrote:
> WE should basically never have dev->dma_mask = &dev->coherent_dma_mask,
> so until that is the case you are doctoring around the symptoms and
> not the problem.
> 
> Does the patch below help your case?
> 
> ----
> From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 27 Aug 2018 17:23:24 +0200
> Subject: driver core: initialize a default DMA mask for platform device
> 
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/platform.c         | 15 +++++++++++++--
>  include/linux/platform_device.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..baf4b06cf2d9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -225,6 +225,17 @@ struct platform_object {
>  	char name[];
>  };
>  
> +static void setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dma_mask)
> +		pdev->dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dma_mask;
> +	arch_setup_pdev_archdata(pdev);
> +};
> +
>  /**
>   * platform_device_put - destroy a platform device
>   * @pdev: platform device to free
> @@ -271,7 +282,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>  		pa->pdev.id = id;
>  		device_initialize(&pa->pdev.dev);
>  		pa->pdev.dev.release = platform_device_release;
> -		arch_setup_pdev_archdata(&pa->pdev);
> +		setup_pdev_archdata(&pa->pdev);
>  	}
>  
>  	return pa ? &pa->pdev : NULL;
> @@ -472,7 +483,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>  int platform_device_register(struct platform_device *pdev)
>  {
>  	device_initialize(&pdev->dev);
> -	arch_setup_pdev_archdata(pdev);
> +	setup_pdev_archdata(pdev);
>  	return platform_device_add(pdev);
>  }
>  EXPORT_SYMBOL_GPL(platform_device_register);
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 1a9f38f27f65..d84ec1de6022 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -25,6 +25,7 @@ struct platform_device {
>  	int		id;
>  	bool		id_auto;
>  	struct device	dev;
> +	dma_addr_t	dma_mask;
>  	u32		num_resources;
>  	struct resource	*resource;
>  
> -- 
> 2.18.0
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
