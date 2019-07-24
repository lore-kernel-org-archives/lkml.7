Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97138C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A89218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfGXFtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:49:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfGXFtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:49:35 -0400
X-UUID: 7b0d746f9a1e43baa37d1ba9f08a1fb6-20190724
X-UUID: 7b0d746f9a1e43baa37d1ba9f08a1fb6-20190724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 758720907; Wed, 24 Jul 2019 13:49:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 13:49:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 13:49:27 +0800
Message-ID: <1563947367.1070.7.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: make imported PRIME buffers contiguous
From:   CK Hu <ck.hu@mediatek.com>
To:     Alexandre Courbot <acourbot@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 13:49:27 +0800
In-Reply-To: <20190723053421.179679-1-acourbot@chromium.org>
References: <20190723053421.179679-1-acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre:

On Tue, 2019-07-23 at 14:34 +0900, Alexandre Courbot wrote:
> This driver requires imported PRIME buffers to appear contiguously in
> its IO address space. Make sure this is the case by setting the maximum
> DMA segment size to a better value than the default 64K on the DMA
> device, and use said DMA device when importing PRIME buffers.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 47 ++++++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 95fdbd0fbcac..4ad4770fab13 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -213,6 +213,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	struct mtk_drm_private *private = drm->dev_private;
>  	struct platform_device *pdev;
>  	struct device_node *np;
> +	struct device *dma_dev;
>  	int ret;
>  
>  	if (!iommu_present(&platform_bus_type))
> @@ -275,7 +276,27 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  		goto err_component_unbind;
>  	}
>  
> -	private->dma_dev = &pdev->dev;
> +	dma_dev = &pdev->dev;
> +	private->dma_dev = dma_dev;
> +
> +	/*
> +	 * Configure the DMA segment size to make sure we get contiguous IOVA
> +	 * when importing PRIME buffers.
> +	 */
> +	if (!dma_dev->dma_parms) {
> +		private->dma_parms_allocated = true;
> +		dma_dev->dma_parms =
> +			devm_kzalloc(drm->dev, sizeof(*dma_dev->dma_parms),
> +				     GFP_KERNEL);
> +	}
> +	if (!dma_dev->dma_parms)
> +		goto err_component_unbind;

return with ret = 0?

> +
> +	ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(dma_dev, "Failed to set DMA segment size\n");
> +		goto err_unset_dma_parms;
> +	}
>  
>  	/*
>  	 * We don't use the drm_irq_install() helpers provided by the DRM
> @@ -285,13 +306,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	drm->irq_enabled = true;
>  	ret = drm_vblank_init(drm, MAX_CRTC);
>  	if (ret < 0)
> -		goto err_component_unbind;
> +		goto err_unset_dma_parms;
>  
>  	drm_kms_helper_poll_init(drm);
>  	drm_mode_config_reset(drm);
>  
>  	return 0;
>  
> +err_unset_dma_parms:
> +	if (private->dma_parms_allocated)
> +		dma_dev->dma_parms = NULL;
>  err_component_unbind:
>  	component_unbind_all(drm->dev, drm);
>  err_config_cleanup:
> @@ -302,9 +326,14 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  
>  static void mtk_drm_kms_deinit(struct drm_device *drm)
>  {
> +	struct mtk_drm_private *private = drm->dev_private;
> +
>  	drm_kms_helper_poll_fini(drm);
>  	drm_atomic_helper_shutdown(drm);
>  
> +	if (private->dma_parms_allocated)
> +		private->dma_dev->dma_parms = NULL;
> +
>  	component_unbind_all(drm->dev, drm);
>  	drm_mode_config_cleanup(drm);
>  }
> @@ -320,6 +349,18 @@ static const struct file_operations mtk_drm_fops = {
>  	.compat_ioctl = drm_compat_ioctl,
>  };
>  
> +/*
> + * We need to override this because the device used to import the memory is
> + * not dev->dev, as drm_gem_prime_import() expects.
> + */
> +struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
> +						struct dma_buf *dma_buf)
> +{
> +	struct mtk_drm_private *private = dev->dev_private;
> +
> +	return drm_gem_prime_import_dev(dev, dma_buf, private->dma_dev);
> +}
> +

I think this part should be an independent patch which fixup
119f5173628aa ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")

Regards,
CK

>  static struct drm_driver mtk_drm_driver = {
>  	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
>  			   DRIVER_ATOMIC,
> @@ -331,7 +372,7 @@ static struct drm_driver mtk_drm_driver = {
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>  	.gem_prime_export = drm_gem_prime_export,
> -	.gem_prime_import = drm_gem_prime_import,
> +	.gem_prime_import = mtk_drm_gem_prime_import,
>  	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
>  	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
>  	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 598ff3e70446..e03fea12ff59 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -51,6 +51,8 @@ struct mtk_drm_private {
>  	} commit;
>  
>  	struct drm_atomic_state *suspend_state;
> +
> +	bool dma_parms_allocated;
>  };
>  
>  extern struct platform_driver mtk_ddp_driver;


