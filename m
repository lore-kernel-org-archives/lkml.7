Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989022190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCVKsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:48:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47877 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfCVKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:48:05 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C32F72001C;
        Fri, 22 Mar 2019 10:48:03 +0000 (UTC)
Message-ID: <eec66692543e7dee94b3af111b87c9935d11ee6f.camel@bootlin.com>
Subject: Re: [PATCH 6/7] drm/vc4: Add helpers for pm get/put.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Fri, 22 Mar 2019 11:48:03 +0100
In-Reply-To: <20190220210343.28157-6-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
         <20190220210343.28157-6-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 20 février 2019 à 13:03 -0800, Eric Anholt a écrit :
> This makes sure the vc4_reset doesn't hit an obscure race with the
> GET_PARAM ioctl, fixes a decrement outside of the lock, and prevents
> future code from making mistakes with the weird return value of
> pm_runtime_get_sync().

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/vc4/vc4_drv.c | 21 +++++++++------------
>  drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
>  drivers/gpu/drm/vc4/vc4_gem.c | 21 +++++----------------
>  drivers/gpu/drm/vc4/vc4_v3d.c | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index de1d0ce11831..f95891a61d52 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -77,28 +77,25 @@ static int vc4_get_param_ioctl(struct drm_device *dev, void *data,
>  
>  	switch (args->param) {
>  	case DRM_VC4_PARAM_V3D_IDENT0:
> -		ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> -		if (ret < 0)
> +		ret = vc4_v3d_pm_get(vc4);
> +		if (ret)
>  			return ret;
>  		args->value = V3D_READ(V3D_IDENT0);
> -		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
> -		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
> +		vc4_v3d_pm_put(vc4);
>  		break;
>  	case DRM_VC4_PARAM_V3D_IDENT1:
> -		ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> -		if (ret < 0)
> +		ret = vc4_v3d_pm_get(vc4);
> +		if (ret)
>  			return ret;
>  		args->value = V3D_READ(V3D_IDENT1);
> -		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
> -		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
> +		vc4_v3d_pm_put(vc4);
>  		break;
>  	case DRM_VC4_PARAM_V3D_IDENT2:
> -		ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> -		if (ret < 0)
> +		ret = vc4_v3d_pm_get(vc4);
> +		if (ret)
>  			return ret;
>  		args->value = V3D_READ(V3D_IDENT2);
> -		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
> -		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
> +		vc4_v3d_pm_put(vc4);
>  		break;
>  	case DRM_VC4_PARAM_SUPPORTS_BRANCHES:
>  	case DRM_VC4_PARAM_SUPPORTS_ETC1:
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 495c5a13a948..c71988b270bc 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -809,6 +809,8 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
>  /* vc4_v3d.c */
>  extern struct platform_driver vc4_v3d_driver;
>  int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
> +int vc4_v3d_pm_get(struct vc4_dev *vc4);
> +void vc4_v3d_pm_put(struct vc4_dev *vc4);
>  
>  /* vc4_validate.c */
>  int
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index 8d816e5ed762..4544a478f106 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -969,12 +969,7 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
>  	/* Release the reference we had on the perf monitor. */
>  	vc4_perfmon_put(exec->perfmon);
>  
> -	mutex_lock(&vc4->power_lock);
> -	if (--vc4->power_refcount == 0) {
> -		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
> -		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
> -	}
> -	mutex_unlock(&vc4->power_lock);
> +	vc4_v3d_pm_put(vc4);
>  
>  	kfree(exec);
>  }
> @@ -1153,17 +1148,11 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
>  		return -ENOMEM;
>  	}
>  
> -	mutex_lock(&vc4->power_lock);
> -	if (vc4->power_refcount++ == 0) {
> -		ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> -		if (ret < 0) {
> -			mutex_unlock(&vc4->power_lock);
> -			vc4->power_refcount--;
> -			kfree(exec);
> -			return ret;
> -		}
> +	ret = vc4_v3d_pm_get(vc4);
> +	if (ret) {
> +		kfree(exec);
> +		return ret;
>  	}
> -	mutex_unlock(&vc4->power_lock);
>  
>  	exec->args = args;
>  	INIT_LIST_HEAD(&exec->unref_list);
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index f008584eb739..7820b8eaaa98 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -124,6 +124,39 @@ static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
>  	return 0;
>  }
>  
> +/**
> + * Wraps pm_runtime_get_sync() in a refcount, so that we can reliably
> + * get the pm_runtime refcount to 0 in vc4_reset().
> + */
> +int
> +vc4_v3d_pm_get(struct vc4_dev *vc4)
> +{
> +	mutex_lock(&vc4->power_lock);
> +	if (vc4->power_refcount++ == 0) {
> +		int ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> +
> +		if (ret < 0) {
> +			vc4->power_refcount--;
> +			mutex_unlock(&vc4->power_lock);
> +			return ret;
> +		}
> +	}
> +	mutex_unlock(&vc4->power_lock);
> +
> +	return 0;
> +}
> +
> +void
> +vc4_v3d_pm_put(struct vc4_dev *vc4)
> +{
> +	mutex_lock(&vc4->power_lock);
> +	if (--vc4->power_refcount == 0) {
> +		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
> +		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
> +	}
> +	mutex_unlock(&vc4->power_lock);
> +}
> +
>  static void vc4_v3d_init_hw(struct drm_device *dev)
>  {
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

