Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FAEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDKLPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:15:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45322 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726517AbfDKLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:15:34 -0400
X-UUID: 8a95690d9ef04b0e97aaef039f788acd-20190411
X-UUID: 8a95690d9ef04b0e97aaef039f788acd-20190411
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1834034331; Thu, 11 Apr 2019 19:15:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 19:15:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 19:15:19 +0800
Message-ID: <1554981319.31170.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 16/25] drm/mediatek: add ddp write register common api
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 19:15:19 +0800
In-Reply-To: <1553667561-25447-17-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-17-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 4E69FC553BCEE32A74450CFBB64481A06BC9D0C54E487B007EA3E378B139BF762000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add ddp write register common api
> this is preparation patch for ovl/ovl_2l direct link
> usecase.
> in that case, we need this funtion to set one bit of ovl_2l
> register

The reason is so strange. You could grep 'readl' in mediatek drm driver,
and you would find that many place need this function. 

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 11 +++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index afd6ca2..72288b4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -84,6 +84,17 @@
>  #define DITHER_ADD_LSHIFT_G(x)			(((x) & 0x7) << 4)
>  #define DITHER_ADD_RSHIFT_G(x)			(((x) & 0x7) << 0)
>  
> +void mtk_ddp_write_mask(unsigned int value,
> +			struct mtk_ddp_comp *comp,
> +			unsigned int offset,
> +			unsigned int mask)
> +{
> +	unsigned int tmp = readl(comp->regs + offset);
> +
> +	tmp = (tmp & ~mask) | (value & mask);

Why not just place this calculation into writel()?

Regards,
CK

> +	writel(tmp, comp->regs + offset);
> +}
> +
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>  		    unsigned int CFG)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 20e8061..ed715ff 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -198,5 +198,9 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
>  void mtk_ddp_comp_unregister(struct drm_device *drm, struct mtk_ddp_comp *comp);
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>  		    unsigned int CFG);
> +void mtk_ddp_write_mask(unsigned int value,
> +			struct mtk_ddp_comp *comp,
> +			unsigned int offset,
> +			unsigned int mask);
>  
>  #endif /* MTK_DRM_DDP_COMP_H */


