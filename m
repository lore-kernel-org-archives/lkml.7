Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F27C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91112133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDKLBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:01:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40637 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbfDKLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:01:23 -0400
X-UUID: c2c7b295e387456dbb5d0f87b239a639-20190411
X-UUID: c2c7b295e387456dbb5d0f87b239a639-20190411
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1999337745; Thu, 11 Apr 2019 19:01:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 19:01:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 19:01:15 +0800
Message-ID: <1554980474.27008.6.camel@mtksdaap41>
Subject: Re: [PATCH v2 15/25] drm/mediatek: add function to background color
 input select for ovl/ovl_2l direct link
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 11 Apr 2019 19:01:14 +0800
In-Reply-To: <1553667561-25447-16-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-16-git-send-email-yongqiang.niu@mediatek.com>
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
> This patch add function to background color input select for ovl/ovl_2l direct link
> for ovl/ovl_2l direct link usecase, we need set background color
> input select for these hardware.
> this is preparation patch for ovl/ovl_2l usecase
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index b76b663..20e8061 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -92,6 +92,9 @@ struct mtk_ddp_comp_funcs {
>  			     struct mtk_plane_state *state);
>  	void (*gamma_set)(struct mtk_ddp_comp *comp,
>  			  struct drm_crtc_state *state);
> +        void (*bgclr_in_on)(struct mtk_ddp_comp *comp,
> +			    enum mtk_ddp_comp_id prev);
> +        void (*bgclr_in_off)(struct mtk_ddp_comp *comp);
>  };
>  
>  struct mtk_ddp_comp {
> @@ -173,6 +176,19 @@ static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
>  		comp->funcs->gamma_set(comp, state);
>  }
>  
> +static inline void mtk_ddp_comp_bgclr_in_on(struct mtk_ddp_comp *comp,
> +					    enum mtk_ddp_comp_id prev)
> +{
> +        if (comp->funcs && comp->funcs->bgclr_in_on)
> +                comp->funcs->bgclr_in_on(comp, prev);
> +}
> +
> +static inline void mtk_ddp_comp_bgclr_in_off(struct mtk_ddp_comp *comp)
> +{
> +        if (comp->funcs && comp->funcs->bgclr_in_off)
> +                comp->funcs->bgclr_in_off(comp);

I think you should use a 'tab' to replace 8 white space.

Regards,
CK

> +}
> +
>  int mtk_ddp_comp_get_id(struct device_node *node,
>  			enum mtk_ddp_comp_type comp_type);
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,


