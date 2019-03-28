Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD772206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfC1BeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:34:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28723 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbfC1BeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:34:13 -0400
X-UUID: 71dab298e99d4d86bd3e9a12cf0649a9-20190328
X-UUID: 71dab298e99d4d86bd3e9a12cf0649a9-20190328
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 506651829; Thu, 28 Mar 2019 09:33:58 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 09:33:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 09:33:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 09:33:56 +0800
Message-ID: <1553736836.18612.12.camel@mtksdaap41>
Subject: Re: [PATCH v2 03/25] drm/mediatek: add mutex mod into ddp private
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
Date:   Thu, 28 Mar 2019 09:33:56 +0800
In-Reply-To: <1553667561-25447-4-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-4-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-TM-SNTS-SMTP: 3BD0937EDF0A096093BE3129E414CD3FB90C532BB3F76686E1DB805A105437902000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:18 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mutex0 MOD register offset not always 0x2C.
> for mt8183, that offset will be 0x30,
> add this regsiter offset into private data
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 53 +++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 579ce28..7f0d46e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -41,10 +41,12 @@
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
> +#define MT2701_DISP_MUTEX0_MOD0 0x2C

Lower case, 0x2c.

> +
>  #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
>  #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
> -#define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
> +#define DISP_REG_MUTEX_MOD(data, n)	((data)->mutex_mod_reg + 0x20 * (n))

Why not just define as:

#define DISP_REG_MUTEX_MOD(mutex_mod_reg, n)	(mutex_mod_reg + 0x20 *
(n))

The mutex_mod_reg inside a structure or not is decided by the caller.

>  #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
>  #define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
>  
> @@ -147,12 +149,17 @@ struct mtk_disp_mutex {
>  	bool claimed;
>  };
>  
> +struct mtk_ddp_data {
> +	const unsigned int *mutex_mod;
> +	unsigned int mutex_mod_reg;

const

Regards,
cK

> +};
> +
>  struct mtk_ddp {
>  	struct device			*dev;
>  	struct clk			*clk;
>  	void __iomem			*regs;
>  	struct mtk_disp_mutex		mutex[10];
> -	const unsigned int		*mutex_mod;
> +	const struct mtk_ddp_data	*data;
>  };
>  
>  static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -202,6 +209,21 @@ struct mtk_ddp {
>  	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>  
> +static const struct mtk_ddp_data mt2701_ddp_driver_data = {
> +	.mutex_mod = mt2701_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +};
> +
> +static const struct mtk_ddp_data mt2712_ddp_driver_data = {
> +	.mutex_mod = mt2712_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +};
> +
> +static const struct mtk_ddp_data mt8173_ddp_driver_data = {
> +	.mutex_mod = mt8173_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +};
> +
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  				    enum mtk_ddp_comp_id next,
>  				    unsigned int *addr)
> @@ -464,15 +486,15 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  		reg = MUTEX_SOF_DPI1;
>  		break;
>  	default:
> -		if (ddp->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +		if (ddp->data->mutex_mod[id] < 32) {
> +			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg |= 1 << ddp->mutex_mod[id];
> +			reg |= 1 << ddp->data->mutex_mod[id];
>  			writel_relaxed(reg, ddp->regs + offset);
>  		} else {
>  			offset = DISP_REG_MUTEX_MOD2(mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg |= 1 << (ddp->mutex_mod[id] - 32);
> +			reg |= 1 << (ddp->data->mutex_mod[id] - 32);
>  			writel_relaxed(reg, ddp->regs + offset);
>  		}
>  		return;
> @@ -502,15 +524,15 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
>  		break;
>  	default:
> -		if (ddp->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +		if (ddp->data->mutex_mod[id] < 32) {
> +			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg &= ~(1 << ddp->mutex_mod[id]);
> +			reg &= ~(1 << ddp->data->mutex_mod[id]);
>  			writel_relaxed(reg, ddp->regs + offset);
>  		} else {
>  			offset = DISP_REG_MUTEX_MOD2(mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
> -			reg &= ~(1 << (ddp->mutex_mod[id] - 32));
> +			reg &= ~(1 << (ddp->data->mutex_mod[id] - 32));
>  			writel_relaxed(reg, ddp->regs + offset);
>  		}
>  		break;
> @@ -585,7 +607,7 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  		return PTR_ERR(ddp->regs);
>  	}
>  
> -	ddp->mutex_mod = of_device_get_match_data(dev);
> +	ddp->data = of_device_get_match_data(dev);
>  
>  	platform_set_drvdata(pdev, ddp);
>  
> @@ -598,9 +620,12 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ddp_driver_dt_match[] = {
> -	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> -	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
> -	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> +	{ .compatible = "mediatek,mt2701-disp-mutex",
> +	  .data = &mt2701_ddp_driver_data},
> +	{ .compatible = "mediatek,mt2712-disp-mutex",
> +	  .data = &mt2712_ddp_driver_data},
> +	{ .compatible = "mediatek,mt8173-disp-mutex",
> +	  .data = &mt8173_ddp_driver_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);


