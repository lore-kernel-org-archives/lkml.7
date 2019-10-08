Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C108206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="VEO1J0fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJHRr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:47:57 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37441 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:47:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id z125so6206119ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x/lkpIj/2xYb2Ets/AmbxlIgxRR/5zYpb4Zq2VW265Y=;
        b=VEO1J0fHbr5YZ64cx9iNONBB/RbjNEHNF81sZuVrfzgwpgfM5wn/Aq/YpvWDWwQmI7
         e97bleMB5sVfaIglyn+RI/xrFBkvvrZhcUgxioe2FKUObrC6KqvpqTDgmssVPeNW5J8C
         1AjOapwOziiaYPQ36bl/VJFU7O3k1VUcOx7N4jdqQ8qQ9hZoD4iCK7ZHxybAnRUI513u
         3ekrGql9AWKcdY7eMi/l0+l/OFBl3tXpgYpQfUta1djE7G/yBLsUiKOXhIT/yI0+qPC5
         0kYGNuLsebLLL2e+LgzP03yApbbrHk2w1RGB2LOtDQsGVJqu9P+DWjb/fzWcUwbv0l+F
         EQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/lkpIj/2xYb2Ets/AmbxlIgxRR/5zYpb4Zq2VW265Y=;
        b=paMU6ZKEN5pL3hfrQLM588fMcJ0UprXCCnY0uY8XzEZWgLDlPu6fGjHapQKoz96HNk
         lbo7dswpBeOLDIZdWsKII4Ys+O1HfMfQ/h5rgagQ6H4nmzjYF00Vh2HEI/lmu0L0XYai
         jBSVj3VNWiurc+MU5zG2dYmakWtV26peN+LHNShCMEHxQfFnKI1GRmVJNmIne5SHtYPY
         dlR1JmdpfiJCAkgXeEiqXUZI88ZeiUWZZMY8y6cTe9ZJIDn0G3p4LGeaKmfBU1oXHlfN
         BagsdNWLE6Zv8cvNrj/y6N3RO7RNjDoLsKeK7ht/YmrvaLsDJa3QOM40Bdve3vl+er7c
         gb4w==
X-Gm-Message-State: APjAAAU7m8r4lpJL4oZAbwuBZKBPZqO8Zo25ktOclN3guUad8xKt2wjC
        1Rn1nJeR+LeOUVFNNnbQOBj7Hw==
X-Google-Smtp-Source: APXvYqwB0j6YLnOuSJFwML6RrLxWpgPxO8HpM5WazcbeXRunUhPMQAOhuf8/Kmo+7icAraDRTOTaTw==
X-Received: by 2002:a25:3287:: with SMTP id y129mr16402593yby.339.1570556874742;
        Tue, 08 Oct 2019 10:47:54 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id p10sm4719432ywc.19.2019.10.08.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 10:47:53 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:47:53 -0400
From:   Sean Paul <sean@poorly.run>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds power management support
Message-ID: <20191008174753.GC85762@art_vandelay>
References: <20190923015908.26627-1-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923015908.26627-1-lowry.li@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 01:59:25AM +0000, Lowry Li (Arm Technology China) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> 
> Adds system power management support in KMS kernel driver.
> 
> Depends on:
> https://patchwork.freedesktop.org/series/62377/
> 
> Changes since v1:
> Since we have unified mclk/pclk/pipeline->aclk to one mclk, which will
> be turned on/off when crtc atomic enable/disable, removed runtime power
> management.
> Removes run time get/put related flow.
> Adds to disable the aclk when register access finished.
> 
> Changes since v2:
> Rebases to the drm-misc-next branch.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  1 -
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 65 +++++++++++++++++--
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 30 ++++++++-
>  4 files changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 38d5cb20e908..b47c0dabd0d1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -5,7 +5,6 @@
>   *
>   */
>  #include <linux/clk.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  
>  #include <drm/drm_atomic.h>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index bee4633cdd9f..8a03324f02a5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -258,7 +258,7 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  			  product->product_id,
>  			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
>  		err = -ENODEV;
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
>  
>  	DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
> @@ -271,19 +271,19 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  	err = mdev->funcs->enum_resources(mdev);
>  	if (err) {
>  		DRM_ERROR("enumerate display resource failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
>  
>  	err = komeda_parse_dt(dev, mdev);
>  	if (err) {
>  		DRM_ERROR("parse device tree failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
>  
>  	err = komeda_assemble_pipelines(mdev);
>  	if (err) {
>  		DRM_ERROR("assemble display pipelines failed.\n");
> -		goto err_cleanup;
> +		goto disable_clk;
>  	}
>  
>  	dev->dma_parms = &mdev->dma_parms;
> @@ -296,11 +296,14 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  	if (mdev->iommu && mdev->funcs->connect_iommu) {
>  		err = mdev->funcs->connect_iommu(mdev);
>  		if (err) {
> +			DRM_ERROR("connect iommu failed.\n");
>  			mdev->iommu = NULL;
> -			goto err_cleanup;
> +			goto disable_clk;
>  		}
>  	}
>  
> +	clk_disable_unprepare(mdev->aclk);
> +
>  	err = sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
>  	if (err) {
>  		DRM_ERROR("create sysfs group failed.\n");
> @@ -313,6 +316,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  
>  	return mdev;
>  
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
>  err_cleanup:
>  	komeda_dev_destroy(mdev);
>  	return ERR_PTR(err);
> @@ -330,8 +335,12 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  #endif
>  
> +	if (mdev->aclk)
> +		clk_prepare_enable(mdev->aclk);
> +
>  	if (mdev->iommu && mdev->funcs->disconnect_iommu)
> -		mdev->funcs->disconnect_iommu(mdev);
> +		if (mdev->funcs->disconnect_iommu(mdev))
> +			DRM_ERROR("disconnect iommu failed.\n");
>  	mdev->iommu = NULL;
>  
>  	for (i = 0; i < mdev->n_pipelines; i++) {
> @@ -359,3 +368,47 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  
>  	devm_kfree(dev, mdev);
>  }
> +
> +int komeda_dev_resume(struct komeda_dev *mdev)
> +{
> +	int ret = 0;
> +
> +	clk_prepare_enable(mdev->aclk);
> +
> +	if (mdev->iommu && mdev->funcs->connect_iommu) {
> +		ret = mdev->funcs->connect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("connect iommu failed.\n");
> +			goto disable_clk;
> +		}
> +	}
> +
> +	ret = mdev->funcs->enable_irq(mdev);
> +
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
> +
> +	return ret;
> +}
> +
> +int komeda_dev_suspend(struct komeda_dev *mdev)
> +{
> +	int ret = 0;
> +
> +	clk_prepare_enable(mdev->aclk);
> +
> +	if (mdev->iommu && mdev->funcs->disconnect_iommu) {
> +		ret = mdev->funcs->disconnect_iommu(mdev);
> +		if (ret < 0) {
> +			DRM_ERROR("disconnect iommu failed.\n");
> +			goto disable_clk;
> +		}
> +	}
> +
> +	ret = mdev->funcs->disable_irq(mdev);
> +
> +disable_clk:
> +	clk_disable_unprepare(mdev->aclk);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 8acf8c0601cc..414200233b64 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -224,4 +224,7 @@ void komeda_print_events(struct komeda_events *evts);
>  static inline void komeda_print_events(struct komeda_events *evts) {}
>  #endif
>  
> +int komeda_dev_resume(struct komeda_dev *mdev);
> +int komeda_dev_suspend(struct komeda_dev *mdev);
> +
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index 69ace6f9055d..d6c2222c5d33 100644
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
> @@ -136,13 +137,40 @@ static const struct of_device_id komeda_of_match[] = {
>  
>  MODULE_DEVICE_TABLE(of, komeda_of_match);
>  
> +static int __maybe_unused komeda_pm_suspend(struct device *dev)
> +{
> +	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> +	struct drm_device *drm = &mdrv->kms->base;
> +	int res;
> +
> +	res = drm_mode_config_helper_suspend(drm);

Just noticed this while prepping the -misc pull request.

You should use the atomic helpers instead, drm_atomic_helper_suspend and
drm_atomic_helper_resume.

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
> +	komeda_dev_resume(mdrv->mdev);
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +
> +static const struct dev_pm_ops komeda_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(komeda_pm_suspend, komeda_pm_resume)
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
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
