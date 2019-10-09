Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C34ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24FF20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJIJdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:33:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55964 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729616AbfJIJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:33:19 -0400
X-UUID: 0e8421c2b3e34bbbb6cd22a040af7cdb-20191009
X-UUID: 0e8421c2b3e34bbbb6cd22a040af7cdb-20191009
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 796119464; Wed, 09 Oct 2019 17:33:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:33:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:33:07 +0800
Message-ID: <1570613589.7713.12.camel@mtksdaap41>
Subject: Re: [PATCH v5, 09/32] drm/mediatek: add mutex sof into ddp private
 data
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
Date:   Wed, 9 Oct 2019 17:33:09 +0800
In-Reply-To: <1567090254-15566-10-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-10-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: C0AA72460010C5BE3943F938EECDB74D9C19DE5296EAE6A11046F9A37BD29F432000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mutex sof will be ddp private data
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 43 +++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index ae22e21..9bdbd8d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -141,8 +141,19 @@ struct mtk_disp_mutex {
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
> +};
> +
>  struct mtk_ddp_data {
>  	const unsigned int *mutex_mod;
> +	const unsigned int *mutex_sof;
>  	const unsigned int mutex_mod_reg;
>  };
>  
> @@ -201,18 +212,31 @@ struct mtk_ddp {
>  	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>  
> +static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
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
>  };
>  
>  static const struct mtk_ddp_data mt2712_ddp_driver_data = {
>  	.mutex_mod = mt2712_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
>  };
>  
>  static const struct mtk_ddp_data mt8173_ddp_driver_data = {
>  	.mutex_mod = mt8173_mutex_mod,
> +	.mutex_sof = mt2712_mutex_sof,
>  	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
>  };
>  
> @@ -454,28 +478,29 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
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
> @@ -493,7 +518,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  		return;
>  	}
>  
> -	writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +	writel_relaxed(ddp->data->mutex_sof[sof_id],
> +		       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
>  }
>  
>  void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
> @@ -514,7 +540,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DPI0:
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
> -			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
> +			       ddp->regs +
> +			       DISP_REG_MUTEX_SOF(mutex->id));
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {


