Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7411AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A71215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfIBILs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:11:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:30705 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729951AbfIBILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:11:48 -0400
X-UUID: e1c8a8710539490baa26de53d105abfe-20190902
X-UUID: e1c8a8710539490baa26de53d105abfe-20190902
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 143190679; Mon, 02 Sep 2019 16:11:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 2 Sep 2019 16:11:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 2 Sep 2019 16:11:34 +0800
Message-ID: <1567411892.5812.4.camel@mtksdaap41>
Subject: Re: [PATCH v5, 22/32] drm/mediatek: add ovl0/ovl_2l0 usecase
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
Date:   Mon, 2 Sep 2019 16:11:32 +0800
In-Reply-To: <1567144708.5942.14.camel@mtksdaap41>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-23-git-send-email-yongqiang.niu@mediatek.com>
         <1567144708.5942.14.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 8DEBCB9E9240A11796BAA4C58301C88141C950438EF9BB1DF055A5834AA80B812000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Fri, 2019-08-30 at 13:58 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
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
> > index c63ff2b..b55970a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -270,6 +270,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
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
> Even though both OVL and OVL_2L implement this function, I think we
> could still call this function for OVL and OVL_2L, and in
> mtk_ovl_bgclr_in_on(), to judge it's OVL or OVL_2L.

As internal discussion, you mention that OVL and OVL_2L both has
bgclr_in function, so I think we should keep bgclr_in function for both
OVL and OVL_2L. And in crtc, always enable bgclr_in for comp[1], so code
here could be

if (i == 1)
	mtk_ddp_comp_bgclr_in_on(comp);

Regards,
CK

> 
> Regards,
> CK
> 
> >  
> >  		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
> >  		mtk_ddp_comp_start(comp);
> > @@ -279,9 +288,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
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
> > +		mtk_ddp_comp_layer_config(comp, local_layer,
> >  					  plane_state);
> >  	}
> >  
> > @@ -307,6 +325,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
> >  					   mtk_crtc->ddp_comp[i]->id);
> >  	mtk_disp_mutex_disable(mtk_crtc->mutex);
> >  	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
> > +		mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
> >  		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
> >  					      mtk_crtc->mmsys_reg_data,
> >  					      mtk_crtc->ddp_comp[i]->id,
> > @@ -327,6 +346,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
> >  	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
> >  	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> >  	unsigned int i;
> > +	unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> > +	unsigned int local_layer;
> >  
> >  	/*
> >  	 * TODO: instead of updating the registers here, we should prepare
> > @@ -349,7 +370,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
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
> > @@ -572,6 +600,12 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
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


