Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298E720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfDPIU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:20:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbfDPIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:20:29 -0400
X-UUID: e6fa0494077c4f54bf6c241b6378b75d-20190416
X-UUID: e6fa0494077c4f54bf6c241b6378b75d-20190416
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 843081156; Tue, 16 Apr 2019 16:20:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:20:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:20:20 +0800
Message-ID: <1555402820.11519.6.camel@mtksdaap41>
Subject: Re: [PATCH v2 20/25] drm/mediatek: add ovl0/ovl0_2l usecase
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Tue, 16 Apr 2019 16:20:20 +0800
In-Reply-To: <1553667561-25447-21-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-21-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: D68842F30C2C648042C0CC41937EAAE749373DA8BAE550AA7CE1E7C7F05966A42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add ovl0/ovl0_2l usecase
> in ovl->ovl0_2l direct link usecase:
> 1. the crtc support layer number will 4+2
> 2. ovl0_2l background color input select ovl0 when crtc init
> and disable it when crtc finish
> 3. config ovl0_2l layer, if crtc config layer number is
> bigger than ovl0 support layers(max is 4)
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 +++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 11e3404..0f97ee3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -283,6 +283,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>  		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
> +		enum mtk_ddp_comp_id prev;
> +
> +		if (i > 0)
> +			prev = mtk_crtc->ddp_comp[i - 1]->id;
> +		else
> +			prev = DDP_COMPONENT_ID_MAX;
> +		mtk_ddp_comp_bgclr_in_on(comp, prev);
>  
>  		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
>  		mtk_ddp_comp_start(comp);
> @@ -292,9 +299,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane = &mtk_crtc->planes[i];
>  		struct mtk_plane_state *plane_state;
> +		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +		unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +		unsigned int local_layer;
>  
>  		plane_state = to_mtk_plane_state(plane->state);
> -		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
> +
> +		if (i >= comp_layer_nr) {
> +			comp = mtk_crtc->ddp_comp[1];
> +			local_layer = i - comp_layer_nr;
> +                } else
> +			local_layer = i;
> +		mtk_ddp_comp_layer_config(comp , local_layer,
>  					  plane_state);
>  	}
>  
> @@ -320,6 +336,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
>  					   mtk_crtc->ddp_comp[i]->id);
>  	mtk_disp_mutex_disable(mtk_crtc->mutex);
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
> +		mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
>  		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
>  					      mtk_crtc->mmsys_reg_data,
>  					      mtk_crtc->ddp_comp[i]->id,
> @@ -340,6 +357,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>  	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>  	unsigned int i;
> +	unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +	unsigned int local_layer;
>  
>  	/*
>  	 * TODO: instead of updating the registers here, we should prepare
> @@ -362,7 +381,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  			plane_state = to_mtk_plane_state(plane->state);
>  
>  			if (plane_state->pending.config) {
> -				mtk_ddp_comp_layer_config(comp, i, plane_state);
> +				if (i >= comp_layer_nr) {
> +					comp = mtk_crtc->ddp_comp[1];
> +					local_layer = i - comp_layer_nr;
> +                                } else
> +					local_layer = i;
> +
> +				mtk_ddp_comp_layer_config(comp, local_layer,
> +							  plane_state);
>  				plane_state->pending.config = false;
>  			}
>  		}
> @@ -604,6 +630,14 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  	}
>  
>  	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> +        if (mtk_crtc->ddp_comp_nr > 1) {
> +		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[1];
> +		enum mtk_ddp_comp_type comp_type;
> +
> +		comp_type = mtk_ddp_comp_get_type(comp->id);
> +		if (comp_type == MTK_DISP_OVL || comp_type == MTK_DISP_OVL_2L)

I think you need not to invent the function mtk_ddp_comp_get_type() to
get the type. Only the component implementing bgclr_in_on() has the
ability to the extend the ovl layer, so you could judge bgclr_in_on()
exist or not to extend the ovl layer.

Regards,
CK

> +			mtk_crtc->layer_nr += mtk_ddp_comp_layer_nr(comp);
> +        }
>  	mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
>  					sizeof(struct drm_plane),
>  					GFP_KERNEL);


