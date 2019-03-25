Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA31C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8632084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCYNbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:31:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44741 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCYNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:31:01 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C9CC41BF218;
        Mon, 25 Mar 2019 13:30:57 +0000 (UTC)
Message-ID: <dcefd039adb4c336c6a2ba63ea575da975c08e81.camel@bootlin.com>
Subject: Re: [PATCH 5/7] drm/vc4: Disable V3D interactions if the v3d
 component didn't probe.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Mon, 25 Mar 2019 14:30:56 +0100
In-Reply-To: <20190220210343.28157-5-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
         <20190220210343.28157-5-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-02-20 at 13:03 -0800, Eric Anholt wrote:
> One might want to use the VC4 display stack without using Mesa.
> Similar to the debugfs fixes for not having all of the possible
> display bits enabled, make sure you can't oops in vc4 if v3d isn't
> enabled.

See a comment below.

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/vc4/vc4_drv.c     | 11 +++++++++++
>  drivers/gpu/drm/vc4/vc4_gem.c     | 10 ++++++++++
>  drivers/gpu/drm/vc4/vc4_irq.c     |  9 +++++++++
>  drivers/gpu/drm/vc4/vc4_perfmon.c | 18 ++++++++++++++++++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 1927d1b756f5..de1d0ce11831 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -72,6 +72,9 @@ static int vc4_get_param_ioctl(struct drm_device *dev, void *data,
>  	if (args->pad != 0)
>  		return -EINVAL;
>  
> +	if (!vc4->v3d)
> +		return -EINVAL;
> +
>  	switch (args->param) {
>  	case DRM_VC4_PARAM_V3D_IDENT0:
>  		ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> @@ -251,6 +254,7 @@ static int vc4_drm_bind(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct drm_device *drm;
>  	struct vc4_dev *vc4;
> +	struct device_node *node;
>  	int ret = 0;
>  
>  	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> @@ -259,6 +263,13 @@ static int vc4_drm_bind(struct device *dev)
>  	if (!vc4)
>  		return -ENOMEM;
>  
> +	/* If VC4 V3D is missing, don't advertise render nodes. */
> +	node = of_find_compatible_node(NULL, NULL, "brcm,bcm2835-v3d");

It looks like we support more compatibles than this one, so it could be
worth having a separate helper to check if we can find a v3d-compatible 
node. It could certainly reuse the platform driver's of_match_table;

With that fixed, this is:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> +	if (node)
> +		of_node_put(node);
> +	else
> +		vc4_drm_driver.driver_features &= ~DRIVER_RENDER;
> +
>  	drm = drm_dev_alloc(&vc4_drm_driver, dev);
>  	if (IS_ERR(drm))
>  		return PTR_ERR(drm);
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index 5ee5bf7fedf7..8d816e5ed762 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -74,6 +74,11 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
>  	u32 i;
>  	int ret = 0;
>  
> +	if (!vc4->v3d) {
> +		DRM_DEBUG("VC4_GET_HANG_STATE with no VC4 V3D probed\n");
> +		return -EINVAL;
> +	}
> +
>  	spin_lock_irqsave(&vc4->job_lock, irqflags);
>  	kernel_state = vc4->hang_state;
>  	if (!kernel_state) {
> @@ -1124,6 +1129,11 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
>  	struct dma_fence *in_fence;
>  	int ret = 0;
>  
> +	if (!vc4->v3d) {
> +		DRM_DEBUG("VC4_SUBMIT_CL with no VC4 V3D probed\n");
> +		return -EINVAL;
> +	}
> +
>  	if ((args->flags & ~(VC4_SUBMIT_CL_USE_CLEAR_COLOR |
>  			     VC4_SUBMIT_CL_FIXED_RCL_ORDER |
>  			     VC4_SUBMIT_CL_RCL_ORDER_INCREASING_X |
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index 4cd2ccfe15f4..ffd0a4388752 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -229,6 +229,9 @@ vc4_irq_preinstall(struct drm_device *dev)
>  {
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  
> +	if (!vc4->v3d)
> +		return;
> +
>  	init_waitqueue_head(&vc4->job_wait_queue);
>  	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
>  
> @@ -243,6 +246,9 @@ vc4_irq_postinstall(struct drm_device *dev)
>  {
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  
> +	if (!vc4->v3d)
> +		return 0;
> +
>  	/* Enable both the render done and out of memory interrupts. */
>  	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
>  
> @@ -254,6 +260,9 @@ vc4_irq_uninstall(struct drm_device *dev)
>  {
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  
> +	if (!vc4->v3d)
> +		return;
> +
>  	/* Disable sending interrupts for our driver's IRQs. */
>  	V3D_WRITE(V3D_INTDIS, V3D_DRIVER_IRQS);
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> index 495150415020..6562d3d30b20 100644
> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> @@ -100,12 +100,18 @@ void vc4_perfmon_close_file(struct vc4_file *vc4file)
>  int vc4_perfmon_create_ioctl(struct drm_device *dev, void *data,
>  			     struct drm_file *file_priv)
>  {
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  	struct vc4_file *vc4file = file_priv->driver_priv;
>  	struct drm_vc4_perfmon_create *req = data;
>  	struct vc4_perfmon *perfmon;
>  	unsigned int i;
>  	int ret;
>  
> +	if (!vc4->v3d) {
> +		DRM_DEBUG("Creating perfmon no VC4 V3D probed\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Number of monitored counters cannot exceed HW limits. */
>  	if (req->ncounters > DRM_VC4_MAX_PERF_COUNTERS ||
>  	    !req->ncounters)
> @@ -146,10 +152,16 @@ int vc4_perfmon_create_ioctl(struct drm_device *dev, void *data,
>  int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>  			      struct drm_file *file_priv)
>  {
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  	struct vc4_file *vc4file = file_priv->driver_priv;
>  	struct drm_vc4_perfmon_destroy *req = data;
>  	struct vc4_perfmon *perfmon;
>  
> +	if (!vc4->v3d) {
> +		DRM_DEBUG("Destroying perfmon no VC4 V3D probed\n");
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&vc4file->perfmon.lock);
>  	perfmon = idr_remove(&vc4file->perfmon.idr, req->id);
>  	mutex_unlock(&vc4file->perfmon.lock);
> @@ -164,11 +176,17 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>  int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>  				 struct drm_file *file_priv)
>  {
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  	struct vc4_file *vc4file = file_priv->driver_priv;
>  	struct drm_vc4_perfmon_get_values *req = data;
>  	struct vc4_perfmon *perfmon;
>  	int ret;
>  
> +	if (!vc4->v3d) {
> +		DRM_DEBUG("Getting perfmon no VC4 V3D probed\n");
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&vc4file->perfmon.lock);
>  	perfmon = idr_find(&vc4file->perfmon.idr, req->id);
>  	vc4_perfmon_get(perfmon);
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

