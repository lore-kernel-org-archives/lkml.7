Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8AFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E95624430
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfE3CST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:18:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3869 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726311AbfE3CSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:18:18 -0400
X-UUID: a31b93e34ffa48d98dd6601f83dabafe-20190530
X-UUID: a31b93e34ffa48d98dd6601f83dabafe-20190530
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 108718663; Thu, 30 May 2019 10:17:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 30 May 2019 10:17:58 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 May 2019 10:17:58 +0800
Message-ID: <1559182678.6868.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 2/4] drm: mediatek: unbind components in
 mtk_drm_unbind()
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
Date:   Thu, 30 May 2019 10:17:58 +0800
In-Reply-To: <20190529102555.251579-3-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
         <20190529102555.251579-3-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Wed, 2019-05-29 at 18:25 +0800, Hsin-Yi Wang wrote:
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

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v1->v2:
> * separate another 2 fixes to other patches.
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 57ce4708ef1b..e7362bdafa82 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -397,6 +397,7 @@ static void mtk_drm_unbind(struct device *dev)
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  
>  	drm_dev_unregister(private->drm);
> +	mtk_drm_kms_deinit(private->drm);
>  	drm_dev_put(private->drm);
>  	private->drm = NULL;
>  }
> @@ -568,13 +569,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
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


