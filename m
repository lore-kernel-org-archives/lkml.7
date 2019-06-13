Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08695C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3EA20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392288AbfFMQfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:35:13 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:37098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730732AbfFMHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:45:12 -0400
X-UUID: 24f7185cfd0b495fabdabdc1f2ca9ce8-20190613
X-UUID: 24f7185cfd0b495fabdabdc1f2ca9ce8-20190613
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 666765796; Thu, 13 Jun 2019 15:45:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Jun 2019 15:45:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Jun 2019 15:45:03 +0800
Message-ID: <1560411902.27582.0.camel@mtksdaap41>
Subject: Re: [PATCH v3, 09/27] drm/mediatek: add mutex sof register offset
 into ddp private data
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
Date:   Thu, 13 Jun 2019 15:45:02 +0800
In-Reply-To: <1559734986-7379-10-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
         <1559734986-7379-10-git-send-email-yongqiang.niu@mediatek.com>
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

On Wed, 2019-06-05 at 19:42 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mutex sof register offset will be private data of ddp
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index e1a510f..717609d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -42,12 +42,13 @@
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
>  #define MT2701_DISP_MUTEX0_MOD0			0x2c
> +#define MT2701_DISP_MUTEX0_SOF0			0x2c

0x30?

Regards,
CK

>  
>  #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
>  #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
>  #define DISP_REG_MUTEX_MOD(mutex_mod_reg, n)	(mutex_mod_reg + 0x20 * (n))
> -#define DISP_REG_MUTEX_SOF(n)			(0x30 + 0x20 * (n))
> +#define DISP_REG_MUTEX_SOF(mutex_sof_reg, n)	(mutex_sof_reg + 0x20 * (n))
>  #define DISP_REG_MUTEX_MOD2(n)			(0x34 + 0x20 * (n))
>  
>  #define INT_MUTEX				BIT(1)
> @@ -164,6 +165,7 @@ struct mtk_ddp_data {
>  	const unsigned int *mutex_mod;
>  	const unsigned int *mutex_sof;
>  	const unsigned int mutex_mod_reg;
> +	const unsigned int mutex_sof_reg;
>  };
>  
>  struct mtk_ddp {
> @@ -235,18 +237,21 @@ struct mtk_ddp {
>  	.mutex_mod = mt2701_mutex_mod,
>  	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static const struct mtk_ddp_data mt2712_ddp_driver_data = {
>  	.mutex_mod = mt2712_mutex_mod,
>  	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static const struct mtk_ddp_data mt8173_ddp_driver_data = {
>  	.mutex_mod = mt8173_mutex_mod,
>  	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>  
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> @@ -528,7 +533,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  	}
>  
>  	writel_relaxed(ddp->data->mutex_sof[sof_id],
> -		       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +		       ddp->regs +
> +		       DISP_REG_MUTEX_SOF(ddp->data->mutex_sof_reg, mutex->id));
>  }
>  
>  void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
> @@ -550,7 +556,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
>  			       ddp->regs +
> -			       DISP_REG_MUTEX_SOF(mutex->id));
> +			       DISP_REG_MUTEX_SOF(ddp->data->mutex_sof_reg,
> +						  mutex->id));
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {


