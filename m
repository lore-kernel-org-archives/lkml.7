Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26043C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9C820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfDPIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:24:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbfDPIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:24:56 -0400
X-UUID: 785d066f1e85426ebd844d50e6144782-20190416
X-UUID: 785d066f1e85426ebd844d50e6144782-20190416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 721998318; Tue, 16 Apr 2019 16:24:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:24:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:24:50 +0800
Message-ID: <1555403090.11519.7.camel@mtksdaap41>
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
Date:   Tue, 16 Apr 2019 16:24:50 +0800
In-Reply-To: <1553667561-25447-23-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-23-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: C20A49221A17F4645C353DCCE33E7FC4FE3F8AEC421024D5C67E4CC2E8201E312000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:19 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> display hardware clock will not unprepare when
> crtc is disable, until crtc is destroyed.
> with this patch, hard clock will disable and unprepare
> at the same time.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 0f97ee3..606c6e2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -195,7 +195,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
>  
>  	DRM_DEBUG_DRIVER("%s\n", __func__);
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
> -		ret = clk_enable(mtk_crtc->ddp_comp[i]->clk);
> +		ret = clk_prepare_enable(mtk_crtc->ddp_comp[i]->clk);
>  		if (ret) {
>  			DRM_ERROR("Failed to enable clock %d: %d\n", i, ret);
>  			goto err;
> @@ -205,7 +205,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
>  	return 0;
>  err:
>  	while (--i >= 0)
> -		clk_disable(mtk_crtc->ddp_comp[i]->clk);
> +		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
>  	return ret;
>  }
>  
> @@ -215,7 +215,7 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_drm_crtc *mtk_crtc)
>  
>  	DRM_DEBUG_DRIVER("%s\n", __func__);
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
> -		clk_disable(mtk_crtc->ddp_comp[i]->clk);
> +		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
>  }
>  
>  static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
> @@ -615,15 +615,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  		if (!comp) {
>  			dev_err(dev, "Component %pOF not initialized\n", node);
>  			ret = -ENODEV;
> -			goto unprepare;
> -		}
> -
> -		ret = clk_prepare(comp->clk);
> -		if (ret) {
> -			dev_err(dev,
> -				"Failed to prepare clock for component %pOF: %d\n",
> -				node, ret);
> -			goto unprepare;
> +			return ret;
>  		}
>  
>  		mtk_crtc->ddp_comp[i] = comp;
> @@ -649,23 +641,17 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  		ret = mtk_plane_init(drm_dev, &mtk_crtc->planes[zpos],
>  				     BIT(pipe), type);
>  		if (ret)
> -			goto unprepare;
> +			return ret;
>  	}
>  
>  	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
>  				mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
>  				NULL, pipe);
>  	if (ret < 0)
> -		goto unprepare;
> +		return ret;
>  	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
>  	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, MTK_LUT_SIZE);
>  	priv->num_pipes++;
>  
>  	return 0;
> -
> -unprepare:
> -	while (--i >= 0)
> -		clk_unprepare(mtk_crtc->ddp_comp[i]->clk);
> -
> -	return ret;
>  }


