Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4CC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE2A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfE2JrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:47:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49002 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbfE2JrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:47:15 -0400
X-UUID: f85fc8ea1b0f475caaf9a63d093aef2e-20190529
X-UUID: f85fc8ea1b0f475caaf9a63d093aef2e-20190529
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 561493275; Wed, 29 May 2019 17:47:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 17:47:02 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 17:47:02 +0800
Message-ID: <1559123222.6582.2.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] drm: mediatek: unbind components in mtk_drm_unbind()
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 17:47:02 +0800
In-Reply-To: <20190527045054.113259-4-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
         <20190527045054.113259-4-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0D67655A3172A9E677B28064701E21555F16641623DFE39541481F10AB8379D22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> Unbinding components (i.e. mtk_dsi and mtk_disp_ovl/rdma/color) will
> trigger master(mtk_drm)'s .unbind(), and currently mtk_drm's unbind
> won't actually unbind components. During the next bind,
> mtk_drm_kms_init() is called, and the components are added back.
> 
> .unbind() should call mtk_drm_kms_deinit() to unbind components.
> 
> And since component_master_del() in .remove() will trigger .unbind(),
> which will also unregister device, it's fine to remove original functions
> called here.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 57ce4708ef1b..bbfe3a464aea 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -311,6 +311,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  static void mtk_drm_kms_deinit(struct drm_device *drm)
>  {
>  	drm_kms_helper_poll_fini(drm);
> +	drm_atomic_helper_shutdown(drm);

This looks not related to this patch. This patch is related to the
unbind timing. You could separate this to an independent patch.

>  
>  	component_unbind_all(drm->dev, drm);
>  	drm_mode_config_cleanup(drm);
> @@ -397,7 +398,9 @@ static void mtk_drm_unbind(struct device *dev)
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  
>  	drm_dev_unregister(private->drm);
> +	mtk_drm_kms_deinit(private->drm);
>  	drm_dev_put(private->drm);
> +	private->num_pipes = 0;

This looks not related to this patch. This patch is related to the
unbind timing. You could separate this to an independent patch.

Regards,
CK

>  	private->drm = NULL;
>  }
>  
> @@ -568,13 +571,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  static int mtk_drm_remove(struct platform_device *pdev)
>  {
>  	struct mtk_drm_private *private = platform_get_drvdata(pdev);
> -	struct drm_device *drm = private->drm;
>  	int i;
>  
> -	drm_dev_unregister(drm);
> -	mtk_drm_kms_deinit(drm);
> -	drm_dev_put(drm);
> -
>  	component_master_del(&pdev->dev, &mtk_drm_ops);
>  	pm_runtime_disable(&pdev->dev);
>  	of_node_put(private->mutex_node);


