Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673AAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4467C215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfH2NPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:15:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24065 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbfH2NPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:15:16 -0400
X-UUID: 95ae08a863bb4e6e83b096b647869ae8-20190829
X-UUID: 95ae08a863bb4e6e83b096b647869ae8-20190829
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1782353988; Thu, 29 Aug 2019 21:15:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Aug
 2019 21:15:14 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 21:15:14 +0800
Message-ID: <1567084508.30648.4.camel@mhfsdcap03>
Subject: Re: [PATCH v4, 23/33] drm/mediatek: add ovl0/ovl_2l0 usecase
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 29 Aug 2019 21:15:08 +0800
In-Reply-To: <1563346064.29169.24.camel@mtksdaap41>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-24-git-send-email-yongqiang.niu@mediatek.com>
         <1563346064.29169.24.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 14:47 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Tue, 2019-07-09 at 06:34 +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > This patch add ovl0/ovl_2l0 usecase
> > in ovl->ovl_2l0 direct link usecase:
> > 1. the crtc support layer number will 4+2
> > 2. ovl_2l0 background color input select ovl0 when crtc init
> > and disable it when crtc finish
> > 3. config ovl_2l0 layer, if crtc config layer number is
> > bigger than ovl0 support layers(max is 4)
> > 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 +++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 5eac376..9ee9ce2 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -282,6 +282,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
> >  
> >  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
> >  		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
> > +		enum mtk_ddp_comp_id prev;
> > +
> > +		if (i > 0)
> > +			prev = mtk_crtc->ddp_comp[i - 1]->id;
> > +		else
> > +			prev = DDP_COMPONENT_ID_MAX;
> > +
> > +		if (prev == DDP_COMPONENT_OVL0)
> > +			mtk_ddp_comp_bgclr_in_on(comp);
> 
> I does not like to use a specific component id to check, that is not
> general. For now, you could simply call mtk_ddp_comp_bgclr_in_on(comp);
> for all component because only ovl_2l has implemented it.
> 
> Regards,
> CK
> 

both OVL0 and OVL_2L0 has the function mtk_ddp_comp_bgclr_in_on

> >  
> >  		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
> >  		mtk_ddp_comp_start(comp);
> > @@ -291,9 +300,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
> >  	for (i = 0; i < mtk_crtc->layer_nr; i++) {
> >  		struct drm_plane *plane = &mtk_crtc->planes[i];
> >  		struct mtk_plane_state *plane_state;
> > +		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> > +		unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> > +		unsigned int local_layer;
> >  
> >  		plane_state = to_mtk_plane_state(plane->state);
> > -		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
> > +
> > +		if (i >= comp_layer_nr) {
> > +			comp = mtk_crtc->ddp_comp[1];
> > +			local_layer = i - comp_layer_nr;
> > +		} else
> > +			local_layer = i;
> > +		mtk_ddp_comp_layer_config(comp , local_layer,
> >  					  plane_state);
> >  	}
> >  
> > @@ -319,6 +337,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
> >  					   mtk_crtc->ddp_comp[i]->id);
> >  	mtk_disp_mutex_disable(mtk_crtc->mutex);
> >  	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
> > +		mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
> >  		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
> >  					      mtk_crtc->mmsys_reg_data,
> >  					      mtk_crtc->ddp_comp[i]->id,
> > @@ -339,6 +358,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
> >  	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
> >  	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> >  	unsigned int i;
> > +	unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> > +	unsigned int local_layer;
> >  
> >  	/*
> >  	 * TODO: instead of updating the registers here, we should prepare
> > @@ -361,7 +382,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
> >  			plane_state = to_mtk_plane_state(plane->state);
> >  
> >  			if (plane_state->pending.config) {
> > -				mtk_ddp_comp_layer_config(comp, i, plane_state);
> > +				if (i >= comp_layer_nr) {
> > +					comp = mtk_crtc->ddp_comp[1];
> > +					local_layer = i - comp_layer_nr;
> > +				} else
> > +					local_layer = i;
> > +
> > +				mtk_ddp_comp_layer_config(comp, local_layer,
> > +							  plane_state);
> >  				plane_state->pending.config = false;
> >  			}
> >  		}
> > @@ -592,6 +620,12 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  	}
> >  
> >  	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> > +	if (mtk_crtc->ddp_comp_nr > 1) {
> > +		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[1];
> > +
> > +		if (comp->funcs->bgclr_in_on)
> > +			mtk_crtc->layer_nr += mtk_ddp_comp_layer_nr(comp);
> > +	}
> >  	mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
> >  					sizeof(struct drm_plane),
> >  					GFP_KERNEL);
> 
> 


