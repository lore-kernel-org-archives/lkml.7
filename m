Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD89218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552734817;
	bh=z5Exqi4TeyYAuZw8+v0Q0pSSJT4jA7B75Z9mnIzr9DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pzOsyTNCZJCCsltc7YtNGP5u+gKPZFKKDkSwyXZbcnU6UbYzTr+UJc9GZsEJzkK22
	 gqsNm25ukVNLS77kthA043CP5xBcSOiQbw0xmX9tjciWJjaTw8QFCR3VU7IGyPyTgS
	 LDz+XKdScYm+XdE1CgOjHTu9/lyvGdeNfjVwpzeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCPLNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPLNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:13:35 -0400
Received: from localhost (unknown [122.167.125.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B18218D0;
        Sat, 16 Mar 2019 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552734813;
        bh=z5Exqi4TeyYAuZw8+v0Q0pSSJT4jA7B75Z9mnIzr9DU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcH5UNUxP8qVPkjzO/JDSgHLW2BYyvYFowjm/tAmfoZO+Thr+3j1Qfq59CDzsZTpk
         6adTYZ2Y3+7KfjsddwfhnuDJp0dWG1uJ/nmITO3CknRly7ijk2jfkNHSc1q7soKvuM
         HRZDZlYhbPR/FSRg+CQOUCVmlpt0a8yyCjjraVkk=
Date:   Sat, 16 Mar 2019 16:43:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/6] dmaengine: sun6i: Add support for H6 DMA
Message-ID: <20190316111324.GI5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165829.9086-6-jernej.skrabec@siol.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-19, 17:58, Jernej Skrabec wrote:
> H6 DMA has more than 32 supported DRQs, which means that configuration
> register is slightly rearranged. It also needs additional clock to be
> enabled.

Okay how many register are rearraged in the new IP block. If there are
large changes, consider using regmap_fields to abstract the register and
bit differences..

> 
> Add support for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 6a37f8bb39b1..eceedd139651 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -69,14 +69,19 @@
>  
>  #define DMA_CHAN_CUR_CFG	0x0c
>  #define DMA_CHAN_MAX_DRQ_A31		0x1f
> +#define DMA_CHAN_MAX_DRQ_H6		0x3f
>  #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
> +#define DMA_CHAN_CFG_SRC_DRQ_H6(x)	((x) & DMA_CHAN_MAX_DRQ_H6)
>  #define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
> +#define DMA_CHAN_CFG_SRC_MODE_H6(x)	(((x) & 0x1) << 8)
>  #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
>  #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
>  #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
>  
>  #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
> +#define DMA_CHAN_CFG_DST_DRQ_H6(x)	(DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16)
>  #define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16)
> +#define DMA_CHAN_CFG_DST_MODE_H6(x)	(DMA_CHAN_CFG_SRC_MODE_H6(x) << 16)
>  #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << 16)
>  #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16)
>  #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
> @@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq, s8 dst_drq)
>  		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
>  }
>  
> +static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
> +{
> +	*p_cfg |= DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
> +		  DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
> +}
> +
>  static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
>  {
>  	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
>  		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
>  }
>  
> +static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> +{
> +	*p_cfg |= DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
> +		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>  	struct sun6i_desc *txd = pchan->desc;
> @@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  };
>  
> +/*
> + * The H6 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun50i_h6_dma_cfg = {
> +	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
> +	.set_burst_length = sun6i_set_burst_length_h3,
> +	.set_drq          = sun6i_set_drq_h6,
> +	.set_mode         = sun6i_set_mode_h6,
> +	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.mbus_clk = true,
> +};
> +
>  /*
>   * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
>   * and a total of 24 usable source and destination endpoints.
> @@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[] = {
>  	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
>  	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
> +	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> @@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
>  	if (ret && !sdc->max_request) {
>  		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> -			 DMA_CHAN_MAX_DRQ_A31);
> -		sdc->max_request = DMA_CHAN_MAX_DRQ_A31;
> +			 DMA_CHAN_MAX_DRQ_H6);
> +		sdc->max_request = DMA_CHAN_MAX_DRQ_H6;
>  	}
>  
>  	/*
> -- 
> 2.21.0

-- 
~Vinod
