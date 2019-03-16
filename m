Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17755C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFDA218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfCPLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:23:56 -0400
Received: from mailoutvs63.siol.net ([185.57.226.254]:54362 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbfCPLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:23:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A996F520F70;
        Sat, 16 Mar 2019 12:23:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6SAXB4rc4Ekg; Sat, 16 Mar 2019 12:23:51 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 229AB520FB1;
        Sat, 16 Mar 2019 12:23:51 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id A9911520F70;
        Sat, 16 Mar 2019 12:23:49 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus clock
Date:   Sat, 16 Mar 2019 12:23:47 +0100
Message-ID: <2451376.qVWA8nfu3q@jernej-laptop>
In-Reply-To: <20190316110753.GH5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net> <20190307165829.9086-3-jernej.skrabec@siol.net> <20190316110753.GH5348@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 16. marec 2019 ob 12:07:53 CET je Vinod Koul napisal(a):
> On 07-03-19, 17:58, Jernej Skrabec wrote:
> > H6 DMA controller needs additional mbus clock to be enabled.
> > 
> > Add a quirk for it and handle it accordingly.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 0cd13f17fc11..761555080325 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -129,6 +129,7 @@ struct sun6i_dma_config {
> > 
> >  	u32 dst_burst_lengths;
> >  	u32 src_addr_widths;
> >  	u32 dst_addr_widths;
> > 
> > +	bool mbus_clk;
> > 
> >  };
> >  
> >  /*
> > 
> > @@ -182,6 +183,7 @@ struct sun6i_dma_dev {
> > 
> >  	struct dma_device	slave;
> >  	void __iomem		*base;
> >  	struct clk		*clk;
> > 
> > +	struct clk		*clk_mbus;
> 
> So rather than have mbus_clk and then a ptr, why not use the ptr and use
> NULL value to check for..?
> 

I'm not sure what you mean here. clk_mbus will hold a reference to a clock 
retrieved by devm_clk_get() so it has to be "struct clk *".

What I'm missing here?

> >  	int			irq;
> >  	spinlock_t		lock;
> >  	struct reset_control	*rstc;
> > 
> > @@ -1208,6 +1210,14 @@ static int sun6i_dma_probe(struct platform_device
> > *pdev)> 
> >  		return PTR_ERR(sdc->clk);
> >  	
> >  	}
> > 
> > +	if (sdc->cfg->mbus_clk) {
> 
> where is the populated? I was expecting this to be set based on DT!

Of course it is based on DT. Check patch 5, where quirks structure attached to 
H6 DMA compatible contains ".mbus_clk = true,". "sdc->cfg" points to this 
quirk structure.

> 
> > +		sdc->clk_mbus = devm_clk_get(&pdev->dev, "mbus");
> > +		if (IS_ERR(sdc->clk_mbus)) {
> > +			dev_err(&pdev->dev, "No mbus clock 
specified\n");
> > +			return PTR_ERR(sdc->clk_mbus);
> > +		}
> > +	}
> > +
> > 
> >  	sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
> >  	if (IS_ERR(sdc->rstc)) {
> >  	
> >  		dev_err(&pdev->dev, "No reset controller specified\n");
> > 
> > @@ -1312,11 +1322,19 @@ static int sun6i_dma_probe(struct platform_device
> > *pdev)> 
> >  		goto err_reset_assert;
> >  	
> >  	}
> > 
> > +	if (sdc->cfg->mbus_clk) {
> > +		ret = clk_prepare_enable(sdc->clk_mbus);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Couldn't enable mbus 
clock\n");
> > +			goto err_clk_disable;
> > +		}
> > +	}
> > +
> > 
> >  	ret = devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 
0,
> >  	
> >  			       dev_name(&pdev->dev), sdc);
> >  	
> >  	if (ret) {
> >  	
> >  		dev_err(&pdev->dev, "Cannot request IRQ\n");
> > 
> > -		goto err_clk_disable;
> > +		goto err_mbus_clk_disable;
> > 
> >  	}
> >  	
> >  	ret = dma_async_device_register(&sdc->slave);
> > 
> > @@ -1341,6 +1359,8 @@ static int sun6i_dma_probe(struct platform_device
> > *pdev)> 
> >  	dma_async_device_unregister(&sdc->slave);
> >  
> >  err_irq_disable:
> >  	sun6i_kill_tasklet(sdc);
> > 
> > +err_mbus_clk_disable:
> > +	clk_disable_unprepare(sdc->clk_mbus);
> > 
> >  err_clk_disable:
> >  	clk_disable_unprepare(sdc->clk);
> >  
> >  err_reset_assert:
> > @@ -1359,6 +1379,7 @@ static int sun6i_dma_remove(struct platform_device
> > *pdev)> 
> >  	sun6i_kill_tasklet(sdc);
> > 
> > +	clk_disable_unprepare(sdc->clk_mbus);
> > 
> >  	clk_disable_unprepare(sdc->clk);
> >  	reset_control_assert(sdc->rstc);




