Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCCB208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfE1Ffi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:35:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42827 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfE1Ffh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:35:37 -0400
X-UUID: be5130a6a2bb477e8ab994be11f10e88-20190528
X-UUID: be5130a6a2bb477e8ab994be11f10e88-20190528
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 649026001; Tue, 28 May 2019 13:35:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 28 May 2019 13:35:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 13:35:29 +0800
Message-ID: <1559021729.15879.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 22/25] drm/mediatek: adjust ddp clock control flow
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Tue, 28 May 2019 13:35:29 +0800
In-Reply-To: <1555403090.11519.7.camel@mtksdaap41>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-23-git-send-email-yongqiang.niu@mediatek.com>
         <1555403090.11519.7.camel@mtksdaap41>
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

On Tue, 2019-04-16 at 16:24 +0800, CK Hu wrote:
> Hi, Yongqiang:
> 
> On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > display hardware clock will not unprepare when
> > crtc is disable, until crtc is destroyed.
> > with this patch, hard clock will disable and unprepare
> > at the same time.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

This patch looks independent, so I've applied it to
mediatek-drm-fixes-5.2 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.2

Regards,
CK
> 
> > 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 ++++++--------------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 0f97ee3..606c6e2 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -195,7 +195,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
> >  
> >  	DRM_DEBUG_DRIVER("%s\n", __func__);
> >  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
> > -		ret = clk_enable(mtk_crtc->ddp_comp[i]->clk);
> > +		ret = clk_prepare_enable(mtk_crtc->ddp_comp[i]->clk);
> >  		if (ret) {
> >  			DRM_ERROR("Failed to enable clock %d: %d\n", i, ret);
> >  			goto err;
> > @@ -205,7 +205,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
> >  	return 0;
> >  err:
> >  	while (--i >= 0)
> > -		clk_disable(mtk_crtc->ddp_comp[i]->clk);
> > +		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
> >  	return ret;
> >  }
> >  
> > @@ -215,7 +215,7 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_drm_crtc *mtk_crtc)
> >  
> >  	DRM_DEBUG_DRIVER("%s\n", __func__);
> >  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
> > -		clk_disable(mtk_crtc->ddp_comp[i]->clk);
> > +		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
> >  }
> >  
> >  static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
> > @@ -615,15 +615,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  		if (!comp) {
> >  			dev_err(dev, "Component %pOF not initialized\n", node);
> >  			ret = -ENODEV;
> > -			goto unprepare;
> > -		}
> > -
> > -		ret = clk_prepare(comp->clk);
> > -		if (ret) {
> > -			dev_err(dev,
> > -				"Failed to prepare clock for component %pOF: %d\n",
> > -				node, ret);
> > -			goto unprepare;
> > +			return ret;
> >  		}
> >  
> >  		mtk_crtc->ddp_comp[i] = comp;
> > @@ -649,23 +641,17 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  		ret = mtk_plane_init(drm_dev, &mtk_crtc->planes[zpos],
> >  				     BIT(pipe), type);
> >  		if (ret)
> > -			goto unprepare;
> > +			return ret;
> >  	}
> >  
> >  	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> >  				mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
> >  				NULL, pipe);
> >  	if (ret < 0)
> > -		goto unprepare;
> > +		return ret;
> >  	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
> >  	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, MTK_LUT_SIZE);
> >  	priv->num_pipes++;
> >  
> >  	return 0;
> > -
> > -unprepare:
> > -	while (--i >= 0)
> > -		clk_unprepare(mtk_crtc->ddp_comp[i]->clk);
> > -
> > -	return ret;
> >  }
> 


