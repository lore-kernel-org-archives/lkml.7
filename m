Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BAC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3575C2341C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbfIEHRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:17:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14230 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730937AbfIEHRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:17:12 -0400
X-UUID: 3b9078d1f656403595c90e2d5a2d920d-20190905
X-UUID: 3b9078d1f656403595c90e2d5a2d920d-20190905
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1231942085; Thu, 05 Sep 2019 15:17:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 15:17:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 15:17:00 +0800
Message-ID: <1567667821.13819.4.camel@mtksdaap41>
Subject: Re: [PATCH v5, 32/32] drm/mediatek: add support for mediatek SOC
 MT8183
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 Sep 2019 15:17:01 +0800
In-Reply-To: <1567090254-15566-33-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-33-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: A078703D18D9193C9F0C35DE28409BAA8C2142B2EC58B78B2141B9C80BE227792000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add support for mediatek SOC MT8183
> 1.ovl_2l share driver with ovl
> 2.rdma1 share drive with rdma0, but fifo size is different
> 3.add mt8183 mutex private data, and mmsys private data
> 4.add mt8183 main and external path module for crtc create
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 18 +++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 27 ++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c   | 69 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h   |  1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 47 ++++++++++++++++++++++
>  5 files changed, 161 insertions(+), 1 deletion(-)
> 

[snip]

> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 9a6f0a2..24945fe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -62,6 +62,7 @@ struct mtk_disp_rdma {
>  	struct mtk_ddp_comp		ddp_comp;
>  	struct drm_crtc			*crtc;
>  	const struct mtk_disp_rdma_data	*data;
> +	u32				fifo_size;
>  };
>  
>  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> @@ -130,10 +131,16 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	unsigned int threshold;
>  	unsigned int reg;
>  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> +	u32 rdma_fifo_size;
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
>  
> +	if (rdma->fifo_size)
> +		rdma_fifo_size = rdma->fifo_size;
> +	else
> +		rdma_fifo_size = RDMA_FIFO_SIZE(rdma);

I think the fifo size part should be an independent patch because it has
no strong relation with MT8183.

> +
>  	/*
>  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
>  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> @@ -142,7 +149,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	 */
>  	threshold = width * height * vrefresh * 4 * 7 / 1000000;
>  	reg = RDMA_FIFO_UNDERFLOW_EN |
> -	      RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> +	      RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>  	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
> @@ -284,6 +291,18 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>  		return comp_id;
>  	}
>  
> +	if (of_find_property(dev->of_node, "mediatek,rdma_fifo_size", &ret)) {
> +		ret = of_property_read_u32(dev->of_node,
> +					   "mediatek,rdma_fifo_size",
> +					   &priv->fifo_size);
> +		if (ret) {
> +			dev_err(dev, "Failed to get rdma fifo size\n");
> +			return ret;
> +		}
> +
> +		priv->fifo_size *= SZ_1K;
> +	}
> +
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>  				&mtk_disp_rdma_funcs);
>  	if (ret) {
> @@ -328,11 +347,17 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
>  	.fifo_size = SZ_8K,
>  };
>  

[snip]

> @@ -514,6 +558,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  		 */
>  		if (comp_type == MTK_DISP_COLOR ||
>  		    comp_type == MTK_DISP_OVL ||
> +		    comp_type == MTK_DISP_OVL_2L ||

I think this should be squashed into "[v5,15/32] drm/mediatek: add
commponent OVL_2L0'.

Regards,
CK

>  		    comp_type == MTK_DISP_RDMA ||
>  		    comp_type == MTK_DSI ||
>  		    comp_type == MTK_DPI) {
 


