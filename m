Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97DECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CC421835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfJIJcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:32:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35765 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbfJIJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:32:48 -0400
X-UUID: 7e75eb430c4e48749a7d6101df136f4f-20191009
X-UUID: 7e75eb430c4e48749a7d6101df136f4f-20191009
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2095053244; Wed, 09 Oct 2019 17:32:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:32:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:32:37 +0800
Message-ID: <1570613559.7713.11.camel@mtksdaap41>
Subject: Re: [PATCH v5, 08/32] drm/mediatek: add mutex mod register offset
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
Date:   Wed, 9 Oct 2019 17:32:39 +0800
In-Reply-To: <1567090254-15566-9-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-9-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: F6B5DD69EC391BE372CBC5B543A24EB03A151202504F6FD4319AFF8479D0F03D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> mutex mod register offset will be private data of ddp.
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index b6cc3d8..ae22e21 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -33,12 +33,14 @@
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
>  #define DISP_REG_CONFIG_DPI_SEL			0x064
>  
> -#define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
> -#define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
> -#define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
> -#define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
> -#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
> -#define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
> +#define MT2701_DISP_MUTEX0_MOD0			0x2c
> +
> +#define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
> +#define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
> +#define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
> +#define DISP_REG_MUTEX_MOD(mutex_mod_reg, n)	(mutex_mod_reg + 0x20 * (n))
> +#define DISP_REG_MUTEX_SOF(n)			(0x30 + 0x20 * (n))
> +#define DISP_REG_MUTEX_MOD2(n)			(0x34 + 0x20 * (n))
>  
>  #define INT_MUTEX				BIT(1)
>  
> @@ -141,6 +143,7 @@ struct mtk_disp_mutex {
>  
>  struct mtk_ddp_data {
>  	const unsigned int *mutex_mod;
> +	const unsigned int mutex_mod_reg;
>  };
>  
>  struct mtk_ddp {
> @@ -200,14 +203,17 @@ struct mtk_ddp {
>  
>  static const struct mtk_ddp_data mt2701_ddp_driver_data = {
>  	.mutex_mod = mt2701_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
>  };
>  
>  static const struct mtk_ddp_data mt2712_ddp_driver_data = {
>  	.mutex_mod = mt2712_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
>  };
>  
>  static const struct mtk_ddp_data mt8173_ddp_driver_data = {
>  	.mutex_mod = mt8173_mutex_mod,
> +	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
>  };
>  
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> @@ -473,7 +479,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +			offset = DISP_REG_MUTEX_MOD(ddp->data->mutex_mod_reg,
> +						    mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
>  			reg |= 1 << ddp->data->mutex_mod[id];
>  			writel_relaxed(reg, ddp->regs + offset);
> @@ -511,7 +518,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  		break;
>  	default:
>  		if (ddp->data->mutex_mod[id] < 32) {
> -			offset = DISP_REG_MUTEX_MOD(mutex->id);
> +			offset = DISP_REG_MUTEX_MOD(ddp->data->mutex_mod_reg,
> +						    mutex->id);
>  			reg = readl_relaxed(ddp->regs + offset);
>  			reg &= ~(1 << ddp->data->mutex_mod[id]);
>  			writel_relaxed(reg, ddp->regs + offset);


