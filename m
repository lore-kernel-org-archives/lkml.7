Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387AFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1200D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDKGsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:48:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49343 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726137AbfDKGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:48:19 -0400
X-UUID: 37be5c5e31104f359f34af3a0b1c53e0-20190411
X-UUID: 37be5c5e31104f359f34af3a0b1c53e0-20190411
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2140443891; Thu, 11 Apr 2019 14:48:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 14:48:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 14:48:11 +0800
Message-ID: <1554965291.4768.10.camel@mtksdaap41>
Subject: Re: [PATCH v2 13/25] drm/mediatek: add gmc_bits for ovl private data
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 14:48:11 +0800
In-Reply-To: <1553667561-25447-14-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-14-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add gmc_bits for ovl private data
> GMC register was set RDMA ultra and pre-ultra threshold.
> 10bit GMC register define is different with other SOC, gmc_thrshd_l not
> used.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 28d1911..afb313c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -39,7 +39,9 @@
>  #define DISP_REG_OVL_ADDR_MT8173		0x0f40
>  #define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
>  
> -#define	OVL_RDMA_MEM_GMC	0x40402020
> +#define GMC_THRESHOLD_BITS	16
> +#define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
> +#define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
>  
>  #define OVL_CON_BYTE_SWAP	BIT(24)
>  #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> @@ -57,6 +59,7 @@
>  
>  struct mtk_disp_ovl_data {
>  	unsigned int addr;
> +	unsigned int gmc_bits;
>  	bool fmt_rgb565_is_0;
>  };
>  
> @@ -140,9 +143,23 @@ static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
>  {
>  	unsigned int reg;
> +	unsigned int gmc_thrshd_l;
> +	unsigned int gmc_thrshd_h;
> +	unsigned int gmc_value;
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>  
>  	writel(0x1, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
> -	writel(OVL_RDMA_MEM_GMC, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
> +
> +	gmc_thrshd_l = GMC_THRESHOLD_LOW >>
> +		      (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +	gmc_thrshd_h = GMC_THRESHOLD_HIGH >>
> +		      (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +	if (ovl->data->gmc_bits == 10)
> +		gmc_value = gmc_thrshd_h | gmc_thrshd_h << 16;
> +	else
> +		gmc_value = gmc_thrshd_l | gmc_thrshd_l << 8 |
> +			    gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
> +	writel(gmc_value, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
>  
>  	reg = readl(comp->regs + DISP_REG_OVL_SRC_CON);
>  	reg = reg | BIT(idx);
> @@ -324,11 +341,13 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT2701,
> +	.gmc_bits = 8,
>  	.fmt_rgb565_is_0 = false,
>  };
>  
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
> +	.gmc_bits = 8,
>  	.fmt_rgb565_is_0 = true,
>  };
>  


