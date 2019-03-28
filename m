Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124502075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfC1DCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:02:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62523 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbfC1DCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:02:12 -0400
X-UUID: 83d7e8a1f6d1409488d79412e91c5c3f-20190328
X-UUID: 83d7e8a1f6d1409488d79412e91c5c3f-20190328
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1031486163; Thu, 28 Mar 2019 11:02:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 11:02:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 11:02:00 +0800
Message-ID: <1553742120.14682.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 04/25] drm/mediatek: add mutex sof into ddp private
 data
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 28 Mar 2019 11:02:00 +0800
In-Reply-To: <1553667561-25447-5-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-5-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 4E81A3F3A8CD4F7ED1DED19A6623192235DAC338F85C570E3E1EA5F03183FBFD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mutex0 SOF register offset not always 0x30.
> for mt8183, that offset will be 0x2C,
> add this regsiter offset into private data

I think you do two things in this patch. One is mutex0 SOF register
offset, and another is making sof value variable. So please split this
into two patches.

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 51 ++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 7f0d46e..495ebc5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -42,12 +42,13 @@
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
>  #define MT2701_DISP_MUTEX0_MOD0 0x2C
> +#define MT2701_DISP_MUTEX0_SOF0  0x30
>  
>  #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
>  #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
>  #define DISP_REG_MUTEX_MOD(data, n)	((data)->mutex_mod_reg + 0x20 * (n))
> -#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
> +#define DISP_REG_MUTEX_SOF(data, n)	((data)->mutex_sof_reg + 0x20 * (n))

Even though previous patch's indent is not aligned, I would like you to
align this indent.

Regards,
CK

>  #define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
>  
>  #define INT_MUTEX				BIT(1)
> @@ -149,9 +150,22 @@ struct mtk_disp_mutex {
>  	bool claimed;
>  };
>  
> +enum mtk_ddp_mutex_sof_id {
> +	DDP_MUTEX_SOF_SINGLE_MODE,
> +	DDP_MUTEX_SOF_DSI0,
> +	DDP_MUTEX_SOF_DSI1,
> +	DDP_MUTEX_SOF_DPI0,
> +	DDP_MUTEX_SOF_DPI1,
> +	DDP_MUTEX_SOF_DSI2,
> +	DDP_MUTEX_SOF_DSI3,
> +	DDP_MUTEX_SOF_MAX,
> +};
> +
>  struct mtk_ddp_data {
>  	const unsigned int *mutex_mod;
> +	const unsigned int *mutex_sof;
>  	unsigned int mutex_mod_reg;
> +	unsigned int mutex_sof_reg;
>  };
>  
>  struct mtk_ddp {
> @@ -209,19 +223,35 @@ struct mtk_ddp {
>  	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>  
> +static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
> +	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> +	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> +	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
> +	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
> +	[DDP_MUTEX_SOF_DPI1] = MUTEX_SOF_DPI1,
> +	[DDP_MUTEX_SOF_DSI2] = MUTEX_SOF_DSI2,
> +	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
> +};
> +
>  static const struct mtk_ddp_data mt2701_ddp_driver_data = {
>  	.mutex_mod = mt2701_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static const struct mtk_ddp_data mt2712_ddp_driver_data = {
>  	.mutex_mod = mt2712_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static const struct mtk_ddp_data mt8173_ddp_driver_data = {
>  	.mutex_mod = mt8173_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> @@ -462,28 +492,29 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
>  					   mutex[mutex->id]);
>  	unsigned int reg;
> +	unsigned int sof_id;
>  	unsigned int offset;
>  
>  	WARN_ON(&ddp->mutex[mutex->id] != mutex);
>  
>  	switch (id) {
>  	case DDP_COMPONENT_DSI0:
> -		reg = MUTEX_SOF_DSI0;
> +		sof_id = DDP_MUTEX_SOF_DSI0;
>  		break;
>  	case DDP_COMPONENT_DSI1:
> -		reg = MUTEX_SOF_DSI0;
> +		sof_id = DDP_MUTEX_SOF_DSI0;
>  		break;
>  	case DDP_COMPONENT_DSI2:
> -		reg = MUTEX_SOF_DSI2;
> +		sof_id = DDP_MUTEX_SOF_DSI2;
>  		break;
>  	case DDP_COMPONENT_DSI3:
> -		reg = MUTEX_SOF_DSI3;
> +		sof_id = DDP_MUTEX_SOF_DSI3;
>  		break;
>  	case DDP_COMPONENT_DPI0:
> -		reg = MUTEX_SOF_DPI0;
> +		sof_id = DDP_MUTEX_SOF_DPI0;
>  		break;
>  	case DDP_COMPONENT_DPI1:
> -		reg = MUTEX_SOF_DPI1;
> +		sof_id = DDP_MUTEX_SOF_DPI1;
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {
> @@ -500,7 +531,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  		return;
>  	}
>  
> -	writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +	writel_relaxed(ddp->data->mutex_sof[sof_id],
> +		       ddp->regs + DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
>  }
>  
>  void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
> @@ -521,7 +553,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DPI0:
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
> -			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +			       ddp->regs +
> +			       DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {


