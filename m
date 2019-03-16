Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B60C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB37218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552734485;
	bh=AbjBJ5sWAyUjg39D2wZ1vnphsgx/cTYbfPLM8YpPTeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yw07yLr5DAOiuYByBgedwrfrqyJ4k8MQ16OK6Dy1CKNrpnmQrDaJ8JE1HP4faGff6
	 pN71+Bycos5BlbVzo7bdGx+Co9cj60z0HuG1mdSMEI0Tpg610+JN7urlqaq1B/Cz6K
	 NSOnNrUyBY95uZCBS6oFefLi4ipOjWtJ/O5vLzGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCPLIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfCPLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:08:04 -0400
Received: from localhost (unknown [122.167.125.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF091218AC;
        Sat, 16 Mar 2019 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552734482;
        bh=AbjBJ5sWAyUjg39D2wZ1vnphsgx/cTYbfPLM8YpPTeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqyHHjXFpYWqcHCenLIXsiKtZCKLXMARXad+XW4tqBfD6zDvNHkmBqosOkJbDBfGh
         fgEbNikwuJukvwLJc+2/v8FCu/HBwQymDOZnIQQCguo16WhT4Qted/bPWSiJYnf+jH
         XZ0nnJKKkRzsNODoOWiA1EPB8f3f4aGIOwX3bp58=
Date:   Sat, 16 Mar 2019 16:37:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus
 clock
Message-ID: <20190316110753.GH5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165829.9086-3-jernej.skrabec@siol.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-19, 17:58, Jernej Skrabec wrote:
> H6 DMA controller needs additional mbus clock to be enabled.
> 
> Add a quirk for it and handle it accordingly.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 0cd13f17fc11..761555080325 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -129,6 +129,7 @@ struct sun6i_dma_config {
>  	u32 dst_burst_lengths;
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
> +	bool mbus_clk;
>  };
>  
>  /*
> @@ -182,6 +183,7 @@ struct sun6i_dma_dev {
>  	struct dma_device	slave;
>  	void __iomem		*base;
>  	struct clk		*clk;
> +	struct clk		*clk_mbus;

So rather than have mbus_clk and then a ptr, why not use the ptr and use
NULL value to check for..?

>  	int			irq;
>  	spinlock_t		lock;
>  	struct reset_control	*rstc;
> @@ -1208,6 +1210,14 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  		return PTR_ERR(sdc->clk);
>  	}
>  
> +	if (sdc->cfg->mbus_clk) {

where is the populated? I was expecting this to be set based on DT!

> +		sdc->clk_mbus = devm_clk_get(&pdev->dev, "mbus");
> +		if (IS_ERR(sdc->clk_mbus)) {
> +			dev_err(&pdev->dev, "No mbus clock specified\n");
> +			return PTR_ERR(sdc->clk_mbus);
> +		}
> +	}
> +
>  	sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
>  	if (IS_ERR(sdc->rstc)) {
>  		dev_err(&pdev->dev, "No reset controller specified\n");
> @@ -1312,11 +1322,19 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  		goto err_reset_assert;
>  	}
>  
> +	if (sdc->cfg->mbus_clk) {
> +		ret = clk_prepare_enable(sdc->clk_mbus);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Couldn't enable mbus clock\n");
> +			goto err_clk_disable;
> +		}
> +	}
> +
>  	ret = devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 0,
>  			       dev_name(&pdev->dev), sdc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Cannot request IRQ\n");
> -		goto err_clk_disable;
> +		goto err_mbus_clk_disable;
>  	}
>  
>  	ret = dma_async_device_register(&sdc->slave);
> @@ -1341,6 +1359,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(&sdc->slave);
>  err_irq_disable:
>  	sun6i_kill_tasklet(sdc);
> +err_mbus_clk_disable:
> +	clk_disable_unprepare(sdc->clk_mbus);
>  err_clk_disable:
>  	clk_disable_unprepare(sdc->clk);
>  err_reset_assert:
> @@ -1359,6 +1379,7 @@ static int sun6i_dma_remove(struct platform_device *pdev)
>  
>  	sun6i_kill_tasklet(sdc);
>  
> +	clk_disable_unprepare(sdc->clk_mbus);
>  	clk_disable_unprepare(sdc->clk);
>  	reset_control_assert(sdc->rstc);
>  
> -- 
> 2.21.0

-- 
~Vinod
