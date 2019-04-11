Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C94BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCDC217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDKKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:42:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35133 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbfDKKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:42:29 -0400
X-UUID: 5ad9e892682646cf9e14b192987f9891-20190411
X-UUID: 5ad9e892682646cf9e14b192987f9891-20190411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 180670226; Thu, 11 Apr 2019 18:42:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 18:42:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 18:42:01 +0800
Message-ID: <1554979321.31912.9.camel@mtksdaap41>
Subject: Re: [PATCH v2 09/25] drm/mediatek: add mmsys private data for ddp
 path config
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 18:42:01 +0800
In-Reply-To: <1553667561-25447-10-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-10-git-send-email-yongqiang.niu@mediatek.com>
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
> This patch add mmsys private data for ddp path config
> all these register offset and value will be different in future SOC
> add these define into mmsys private data
> 	u32 ovl0_mout_en;
> 	u32 rdma0_sout_sel_in;
> 	u32 rdma0_sout_color0;
> 	u32 rdma1_sout_sel_in;
> 	u32 rdma1_sout_dpi0;
> 	u32 rdma1_sout_dsi0;
> 	u32 dpi0_sel_in;
> 	u32 dpi0_sel_in_rdma1;
> 	u32 dsi0_sel_in;
> 	u32 dsi0_sel_in_rdma1;
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |   4 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 103 ++++++++++++++++++++++++++------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  10 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  11 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   4 ++
>  5 files changed, 113 insertions(+), 19 deletions(-)

[snip]

>  
> +const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id)
> +{
> +	const struct mtk_mmsys_reg_data *data = NULL;
> +
> +	switch (id) {
> +	case MMSYS_MT2701:
> +		data = &mt2701_mmsys_reg_data;
> +		break;
> +	case MMSYS_MT2712:
> +		data = &mt8173_mmsys_reg_data;
> +		break;
> +	case MMSYS_MT8173:
> +		data = &mt8173_mmsys_reg_data;
> +		break;
> +	default:
> +		pr_info("mtk drm not support mmsys id %d\n",
> +			id);
> +		break;
> +	}
> +
> +	return data;
> +}
> +
>  struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned int id)
>  {
>  	struct mtk_ddp *ddp = dev_get_drvdata(dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> index f9a7991..ed2b702 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
> @@ -19,11 +19,21 @@
>  struct regmap;
>  struct device;
>  struct mtk_disp_mutex;
> +struct mtk_mmsys_reg_data;
> +enum mtk_mmsys_id {
> +	MMSYS_MT2701,
> +	MMSYS_MT2712,
> +	MMSYS_MT8173,
> +	MMSYS_MAX,
> +};
>  
> +const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id);
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> +			      const struct mtk_mmsys_reg_data *reg_data,
>  			      enum mtk_ddp_comp_id cur,
>  			      enum mtk_ddp_comp_id next);
>  void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
> +				   const struct mtk_mmsys_reg_data *reg_data,
>  				   enum mtk_ddp_comp_id cur,
>  				   enum mtk_ddp_comp_id next);
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cf59ea9..356853c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -196,6 +196,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
>  	.ext_path = mt2701_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
> +	.mmsys_id = MMSYS_MT2701,
>  	.shadow_register = true,
>  };
>  
> @@ -206,6 +207,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
>  	.third_path = mt2712_mtk_ddp_third,
>  	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> +	.mmsys_id = MMSYS_MT2712,
>  };
>  
>  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> @@ -213,6 +215,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
>  	.ext_path = mt8173_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> +	.mmsys_id = MMSYS_MT8173,
>  };
>  
>  static int mtk_drm_kms_init(struct drm_device *drm)
> @@ -461,6 +464,14 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
> +	private->reg_data = mtk_ddp_get_mmsys_data(private->data->mmsys_id);

Why do you create a function to select reg_data, I think you could just
add reg_data in struct mtk_mmsys_driver_data so you don't need a
function to select it.

Regards,
CK

> +	if (IS_ERR(private->reg_data)) {
> +		ret = PTR_ERR(private->config_regs);
> +		pr_info("Failed to get mmsys register data: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	private->config_regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(private->config_regs)) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index ecc00ca..11de7f8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -15,6 +15,7 @@
>  #define MTK_DRM_DRV_H
>  
>  #include <linux/io.h>
> +#include "mtk_drm_ddp.h"
>  #include "mtk_drm_ddp_comp.h"
>  
>  #define MAX_CRTC	3
> @@ -36,6 +37,8 @@ struct mtk_mmsys_driver_data {
>  	const enum mtk_ddp_comp_id *third_path;
>  	unsigned int third_len;
>  
> +	enum mtk_mmsys_id mmsys_id;
> +
>  	bool shadow_register;
>  };
>  
> @@ -48,6 +51,7 @@ struct mtk_drm_private {
>  	struct device_node *mutex_node;
>  	struct device *mutex_dev;
>  	void __iomem *config_regs;
> +	const struct mtk_mmsys_reg_data *reg_data;
>  	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
>  	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
>  	const struct mtk_mmsys_driver_data *data;


