Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C0C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C48A217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfFSQPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:15:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfFSQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:15:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8935D344;
        Wed, 19 Jun 2019 09:15:23 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3173F246;
        Wed, 19 Jun 2019 09:15:23 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 0DFD5682413; Wed, 19 Jun 2019 17:15:22 +0100 (BST)
Date:   Wed, 19 Jun 2019 17:15:21 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds power management support
Message-ID: <20190619161521.GD17204@e110455-lin.cambridge.arm.com>
References: <1560750919-32255-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560750919-32255-1-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Mon, Jun 17, 2019 at 06:55:49AM +0100, Lowry Li (Arm Technology China) wrote:
> Adds runtime and system power management support in KMS kernel driver.
> 
> Depends on:
> - https://patchwork.freedesktop.org/series/61650/
> - https://patchwork.freedesktop.org/series/60083/
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c |  2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c  | 30 +++++++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h  |  2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c  | 54 ++++++++++++++++++++++--
>  4 files changed, 85 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 66c5e0d..1b4ea8a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -257,6 +257,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>  komeda_crtc_atomic_enable(struct drm_crtc *crtc,
>  			  struct drm_crtc_state *old)
>  {
> +	pm_runtime_get_sync(crtc->dev->dev);
>  	komeda_crtc_prepare(to_kcrtc(crtc));
>  	drm_crtc_vblank_on(crtc);
>  	komeda_crtc_do_flush(crtc, old);
> @@ -330,6 +331,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>  
>  	drm_crtc_vblank_off(crtc);
>  	komeda_crtc_unprepare(kcrtc);
> +	pm_runtime_put(crtc->dev->dev);
>  }
>  
>  static void
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 405c64d..edd0943 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -308,3 +308,33 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  
>  	devm_kfree(dev, mdev);
>  }
> +
> +int komeda_dev_resume(struct komeda_dev *mdev)
> +{
> +	int ret = 0;
> +
> +	if (mdev->iommu && mdev->funcs->connect_iommu) {
> +		ret = mdev->funcs->connect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("connect iommu failed.\n");
> +			return ret;
> +		}
> +	}
> +
> +	return mdev->funcs->enable_irq(mdev);
> +}
> +
> +int komeda_dev_suspend(struct komeda_dev *mdev)
> +{
> +	int ret = 0;
> +
> +	if (mdev->iommu && mdev->funcs->disconnect_iommu) {
> +		ret = mdev->funcs->disconnect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("disconnect iommu failed.\n");
> +			return ret;
> +		}
> +	}
> +
> +	return mdev->funcs->disable_irq(mdev);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index d1c86b6..096f9f7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -207,4 +207,6 @@ struct komeda_dev {
>  
>  struct komeda_dev *dev_to_mdev(struct device *dev);
>  
> +int komeda_dev_resume(struct komeda_dev *mdev);
> +int komeda_dev_suspend(struct komeda_dev *mdev);
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index cfa5068..aa4cef1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -8,6 +8,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/component.h>
> +#include <linux/pm_runtime.h>
>  #include <drm/drm_of.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> @@ -32,6 +33,9 @@ static void komeda_unbind(struct device *dev)
>  		return;
>  
>  	komeda_kms_detach(mdrv->kms);
> +
> +	pm_runtime_disable(dev);
> +
>  	komeda_dev_destroy(mdrv->mdev);
>  
>  	dev_set_drvdata(dev, NULL);
> @@ -52,6 +56,9 @@ static int komeda_bind(struct device *dev)
>  		err = PTR_ERR(mdrv->mdev);
>  		goto free_mdrv;
>  	}
> +	dev_set_drvdata(dev, mdrv);
> +
> +	pm_runtime_enable(dev);
>  
>  	mdrv->kms = komeda_kms_attach(mdrv->mdev);
>  	if (IS_ERR(mdrv->kms)) {
> @@ -59,11 +66,10 @@ static int komeda_bind(struct device *dev)
>  		goto destroy_mdev;
>  	}
>  
> -	dev_set_drvdata(dev, mdrv);
> -
>  	return 0;
>  
>  destroy_mdev:
> +	pm_runtime_disable(dev);
>  	komeda_dev_destroy(mdrv->mdev);
>  
>  free_mdrv:
> @@ -134,13 +140,55 @@ static int komeda_platform_remove(struct platform_device *pdev)
>  
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
>  
> +static int komeda_rt_pm_suspend(struct device *dev)
> +{
> +	dev_info(dev, "%s\n", __func__);
> +	return 0;
> +}
> +
> +static int komeda_rt_pm_resume(struct device *dev)
> +{
> +	dev_info(dev, "%s\n", __func__);
> +	return 0;
> +}


Useful only for debugging? I think you've missed an opportunity here to turn
off clocks and disable interrupts.

> +
> +static int __maybe_unused komeda_pm_suspend(struct device *dev)
> +{
> +	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> +	struct drm_device *drm = &mdrv->kms->base;
> +	int res;
> +
> +	dev_info(dev, "%s\n", __func__);
> +	res = drm_mode_config_helper_suspend(drm);
> +
> +	komeda_dev_suspend(mdrv->mdev);
> +
> +	return res;
> +}
> +
> +static int __maybe_unused komeda_pm_resume(struct device *dev)
> +{
> +	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> +	struct drm_device *drm = &mdrv->kms->base;
> +
> +	dev_info(dev, "%s\n", __func__);

I don't see the point of printing all these message on suspend/resume. Please
convert them to DRM_DEBUG() if you want to have some sort of notices in the
kernel log, otherwise please remove them.

Best regards,
Liviu


> +	komeda_dev_resume(mdrv->mdev);
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +
> +static const struct dev_pm_ops komeda_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
> +	SET_RUNTIME_PM_OPS(komeda_rt_pm_suspend, komeda_rt_pm_resume, NULL)
> +};
> +
>  static struct platform_driver komeda_platform_driver = {
>  	.probe	= komeda_platform_probe,
>  	.remove	= komeda_platform_remove,
>  	.driver	= {
>  		.name = "komeda",
>  		.of_match_table	= komeda_of_match,
> -		.pm = NULL,
> +		.pm = &komeda_pm_ops,
>  	},
>  };
>  
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
