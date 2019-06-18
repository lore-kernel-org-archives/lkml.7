Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA215C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A4220873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFRMOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:14:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:45269 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbfFRMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:14:34 -0400
X-UUID: 5ed4167e3f424974af35e92c0dcd0c96-20190618
X-UUID: 5ed4167e3f424974af35e92c0dcd0c96-20190618
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1630706520; Tue, 18 Jun 2019 20:14:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Jun
 2019 20:14:25 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Jun 2019 20:14:24 +0800
Message-ID: <1560860064.9531.0.camel@mhfsdcap03>
Subject: Re: [PATCH v2 08/12] drm/mediatek: Get rid of mtk_smi_larb_get/put
From:   Yong Wu <yong.wu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
Date:   Tue, 18 Jun 2019 20:14:24 +0800
In-Reply-To: <1560839719.3736.0.camel@mtksdaap41>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
         <1560171313-28299-9-git-send-email-yong.wu@mediatek.com>
         <1560839719.3736.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 14:35 +0800, CK Hu wrote:
> Hi, Yong:
> 
> On Mon, 2019-06-10 at 20:55 +0800, Yong Wu wrote:
> > MediaTek IOMMU has already added the device_link between the consumer
> > and smi-larb device. If the drm device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> > 
> > CC: CK Hu <ck.hu@mediatek.com>
> > CC: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 11 -----------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 26 --------------------------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
> >  3 files changed, 38 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index acad088..3a21a48 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -18,7 +18,6 @@
> >  #include <drm/drm_probe_helper.h>
> >  #include <linux/clk.h>
> >  #include <linux/pm_runtime.h>
> > -#include <soc/mediatek/smi.h>
> >  
> >  #include "mtk_drm_drv.h"
> >  #include "mtk_drm_crtc.h"
> > @@ -371,20 +370,12 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> >  				       struct drm_crtc_state *old_state)
> >  {
> >  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> > -	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> >  	int ret;
> >  
> >  	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
> >  
> > -	ret = mtk_smi_larb_get(comp->larb_dev);
> > -	if (ret) {
> > -		DRM_ERROR("Failed to get larb: %d\n", ret);
> > -		return;
> > -	}
> > -
> >  	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
> >  	if (ret) {
> > -		mtk_smi_larb_put(comp->larb_dev);
> >  		return;
> >  	}
> 
> Remove {}.

Thanks. I will fix in next version.

> 
> Regards,
> CK
> 
> >  
> > @@ -396,7 +387,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >  					struct drm_crtc_state *old_state)
> >  {
> >  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> > -	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> >  	int i;
> >  
> >  	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
> > @@ -419,7 +409,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> >  
> >  	drm_crtc_vblank_off(crtc);
> >  	mtk_crtc_ddp_hw_fini(mtk_crtc);
> > -	mtk_smi_larb_put(comp->larb_dev);
> >  
> >  	mtk_crtc->enabled = false;
> >  }
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 54ca794..ede15c9 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -265,8 +265,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
> >  		      const struct mtk_ddp_comp_funcs *funcs)
> >  {
> >  	enum mtk_ddp_comp_type type;
> > -	struct device_node *larb_node;
> > -	struct platform_device *larb_pdev;
> >  
> >  	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
> >  		return -EINVAL;
> > @@ -296,30 +294,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
> >  	if (IS_ERR(comp->clk))
> >  		return PTR_ERR(comp->clk);
> >  
> > -	/* Only DMA capable components need the LARB property */
> > -	comp->larb_dev = NULL;
> > -	if (type != MTK_DISP_OVL &&
> > -	    type != MTK_DISP_RDMA &&
> > -	    type != MTK_DISP_WDMA)
> > -		return 0;
> > -
> > -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> > -	if (!larb_node) {
> > -		dev_err(dev,
> > -			"Missing mediadek,larb phandle in %pOF node\n", node);
> > -		return -EINVAL;
> > -	}
> > -
> > -	larb_pdev = of_find_device_by_node(larb_node);
> > -	if (!larb_pdev) {
> > -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> > -		of_node_put(larb_node);
> > -		return -EPROBE_DEFER;
> > -	}
> > -	of_node_put(larb_node);
> > -
> > -	comp->larb_dev = &larb_pdev->dev;
> > -
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 8399229..b8dc17e 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -91,7 +91,6 @@ struct mtk_ddp_comp {
> >  	struct clk *clk;
> >  	void __iomem *regs;
> >  	int irq;
> > -	struct device *larb_dev;
> >  	enum mtk_ddp_comp_id id;
> >  	const struct mtk_ddp_comp_funcs *funcs;
> >  };
> 
> 


