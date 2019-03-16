Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BB2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C0A218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCPLho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:37:44 -0400
Received: from mailoutvs6.siol.net ([185.57.226.197]:44281 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfCPLhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 83D96521010;
        Sat, 16 Mar 2019 12:37:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QbPUHw8mLtVA; Sat, 16 Mar 2019 12:37:38 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 09C7F521015;
        Sat, 16 Mar 2019 12:37:38 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 397D9521010;
        Sat, 16 Mar 2019 12:37:37 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] dmaengine: sun6i: Add support for H6 DMA
Date:   Sat, 16 Mar 2019 12:37:35 +0100
Message-ID: <5341987.B6qKFIFFIv@jernej-laptop>
In-Reply-To: <20190316111324.GI5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net> <20190307165829.9086-6-jernej.skrabec@siol.net> <20190316111324.GI5348@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 16. marec 2019 ob 12:13:24 CET je Vinod Koul napisal(a):
> On 07-03-19, 17:58, Jernej Skrabec wrote:
> > H6 DMA has more than 32 supported DRQs, which means that configuration
> > register is slightly rearranged. It also needs additional clock to be
> > enabled.
> 
> Okay how many register are rearraged in the new IP block. If there are
> large changes, consider using regmap_fields to abstract the register and
> bit differences..

Only one, config register. Regmap unfortunately is not an option here, because 
how DMA peripheral works. Register values are actually stored in linked list 
somewhere in RAM and when current DMA request is finished, DMA peripheral auto 
loads next set of registers from memory.

> 
> > Add support for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 42 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 6a37f8bb39b1..eceedd139651 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -69,14 +69,19 @@
> > 
> >  #define DMA_CHAN_CUR_CFG	0x0c
> >  #define DMA_CHAN_MAX_DRQ_A31		0x1f
> > 
> > +#define DMA_CHAN_MAX_DRQ_H6		0x3f
> > 
> >  #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
> > 
> > +#define DMA_CHAN_CFG_SRC_DRQ_H6(x)	((x) & DMA_CHAN_MAX_DRQ_H6)
> > 
> >  #define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
> > 
> > +#define DMA_CHAN_CFG_SRC_MODE_H6(x)	(((x) & 0x1) << 8)
> > 
> >  #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
> >  #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
> >  #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
> >  
> >  #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 
16)
> > 
> > +#define DMA_CHAN_CFG_DST_DRQ_H6(x)	(DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16)
> > 
> >  #define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 
16)
> > 
> > +#define DMA_CHAN_CFG_DST_MODE_H6(x)	(DMA_CHAN_CFG_SRC_MODE_H6(x) << 16)
> > 
> >  #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) <<
> >  16)
> >  #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 
16)
> >  #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
> > 
> > @@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8
> > src_drq, s8 dst_drq)> 
> >  		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
> >  
> >  }
> > 
> > +static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
> > +{
> > +	*p_cfg |= DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
> > +		  DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
> > +}
> > +
> > 
> >  static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> >  {
> >  
> >  	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
> >  	
> >  		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
> >  
> >  }
> > 
> > +static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> > +{
> > +	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
> > +		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
> > +}
> > +
> > 
> >  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> >  {
> >  
> >  	struct sun6i_desc *txd = pchan->desc;
> > 
> > @@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg =
> > {> 
> >  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> >  
> >  };
> > 
> > +/*
> > + * The H6 binding uses the number of dma channels from the
> > + * device tree node.
> > + */
> > +static struct sun6i_dma_config sun50i_h6_dma_cfg = {
> > +	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
> > +	.set_burst_length = sun6i_set_burst_length_h3,
> > +	.set_drq          = sun6i_set_drq_h6,
> > +	.set_mode         = sun6i_set_mode_h6,
> > +	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> > +	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> > +	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +	.mbus_clk = true,
> > +};
> > +
> > 
> >  /*
> >  
> >   * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
> >   * and a total of 24 usable source and destination endpoints.
> > 
> > @@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[] =
> > {> 
> >  	{ .compatible = "allwinner,sun8i-h3-dma", .data = 
&sun8i_h3_dma_cfg },
> >  	{ .compatible = "allwinner,sun8i-v3s-dma", .data = 
&sun8i_v3s_dma_cfg },
> >  	{ .compatible = "allwinner,sun50i-a64-dma", .data = 
&sun50i_a64_dma_cfg
> >  	},
> > 
> > +	{ .compatible = "allwinner,sun50i-h6-dma", .data = 
&sun50i_h6_dma_cfg },
> > 
> >  	{ /* sentinel */ }
> >  
> >  };
> >  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> > 
> > @@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device
> > *pdev)> 
> >  	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
> >  	if (ret && !sdc->max_request) {
> >  	
> >  		dev_info(&pdev->dev, "Missing dma-requests, using %u.
\n",
> > 
> > -			 DMA_CHAN_MAX_DRQ_A31);
> > -		sdc->max_request = DMA_CHAN_MAX_DRQ_A31;
> > +			 DMA_CHAN_MAX_DRQ_H6);
> > +		sdc->max_request = DMA_CHAN_MAX_DRQ_H6;
> > 
> >  	}
> >  	
> >  	/*




