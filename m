Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32542147A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfDATMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:12:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfDATMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:12:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB178EBD;
        Mon,  1 Apr 2019 12:12:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052CF3F59C;
        Mon,  1 Apr 2019 12:12:04 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
Date:   Mon, 1 Apr 2019 20:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401074730.12241-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 08:47, Rob Herring wrote:
> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.

FWIW, on an antique T624 (Juno) it seems to work no worse than the kbase 
driver plus panfrost-nondrm, which is to say it gets far enough to prove 
that the userspace definitely doesn't support T624 (kmscube manages to 
show a grey background, but the GPU is constantly falling over with page 
faults trying to dereference address 0 - for obvious reasons I'm not 
going to get any further involved in debugging that).

A couple of discoveries and general observations below.

> v2:
> - Add GPU reset on job hangs (Tomeu)
> - Add RuntimePM and devfreq support (Tomeu)
> - Fix T760 support (Tomeu)
> - Add a TODO file (Rob, Tomeu)
> - Support multiple in fences (Tomeu)
> - Drop support for shared fences (Tomeu)
> - Fill in MMU de-init (Rob)
> - Move register definitions back to single header (Rob)
> - Clean-up hardcoded job submit todos (Rob)
> - Implement feature setup based on features/issues (Rob)
> - Add remaining Midgard DT compatible strings (Rob)
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
[...]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> new file mode 100644
> index 000000000000..227ba5202a6f
> --- /dev/null
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> +/* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> +
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "panfrost_device.h"
> +#include "panfrost_devfreq.h"
> +#include "panfrost_features.h"
> +#include "panfrost_gpu.h"
> +#include "panfrost_job.h"
> +#include "panfrost_mmu.h"
> +
> +static int panfrost_clk_init(struct panfrost_device *pfdev)
> +{
> +	int err;
> +	unsigned long rate;
> +
> +	pfdev->clock = devm_clk_get(pfdev->dev, NULL);
> +	if (IS_ERR(pfdev->clock)) {

The DT binding says clocks are optional, but this doesn't treat them as 
such.

> +		dev_err(pfdev->dev, "get clock failed %ld\n", PTR_ERR(pfdev->clock));
> +		return PTR_ERR(pfdev->clock);
> +	}
> +
> +	rate = clk_get_rate(pfdev->clock);
> +	dev_info(pfdev->dev, "clock rate = %lu\n", rate);
> +
> +	err = clk_prepare_enable(pfdev->clock);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
[...]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> new file mode 100644
> index 000000000000..57a99032bcc6
> --- /dev/null
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[...]
> +static int panfrost_probe(struct platform_device *pdev)
> +{
> +	struct panfrost_device *pfdev;
> +	struct drm_device *ddev;
> +	int err;
> +
> +	pfdev = devm_kzalloc(&pdev->dev, sizeof(*pfdev), GFP_KERNEL);
> +	if (!pfdev)
> +		return -ENOMEM;
> +
> +	pfdev->pdev = pdev;
> +	pfdev->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, pfdev);
> +
> +	/* Allocate and initialze the DRM device. */
> +	ddev = drm_dev_alloc(&panfrost_drm_driver, &pdev->dev);
> +	if (IS_ERR(ddev))
> +		return PTR_ERR(ddev);
> +
> +	ddev->dev_private = pfdev;
> +	pfdev->ddev = ddev;
> +
> +	spin_lock_init(&pfdev->mm_lock);
> +
> +	/* 4G enough for now. can be 48-bit */
> +	drm_mm_init(&pfdev->mm, SZ_32M >> PAGE_SHIFT, SZ_4G);

You probably want a dma_set_mask_and_coherent() call for your 'real' 
output address size somewhere - the default 32-bit mask works out OK for 
RK3399, but on systems with RAM above 4GB io-pgtable will get very 
unhappy about DMA bounce-buffering.

> +
> +	pm_runtime_use_autosuspend(pfdev->dev);
> +	pm_runtime_set_autosuspend_delay(pfdev->dev, 50); /* ~3 frames */
> +	pm_runtime_enable(pfdev->dev);
> +
> +	err = panfrost_device_init(pfdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Fatal error during GPU init\n");
> +		goto err_out0;
> +	}
> +
> +	err = panfrost_devfreq_init(pfdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Fatal error during devfreq init\n");
> +		goto err_out1;
> +	}
> +
> +	/*
> +	 * Register the DRM device with the core and the connectors with
> +	 * sysfs
> +	 */
> +	err = drm_dev_register(ddev, 0);
> +	if (err < 0)
> +		goto err_out1;
> +
> +	return 0;
> +
> +err_out1:
> +	panfrost_device_fini(pfdev);
> +err_out0:
> +	drm_dev_put(ddev);

Reloading the module after a failed probe complains about an unbalanced 
pm_runtime_enable(), so I guess you need a disable somewhere around here.

> +	return err;
> +}
> +
> +static int panfrost_remove(struct platform_device *pdev)
> +{
> +	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> +	struct drm_device *ddev = pfdev->ddev;
> +
> +	drm_dev_unregister(ddev);
> +	pm_runtime_get_sync(pfdev->dev);
> +	pm_runtime_put_sync_autosuspend(pfdev->dev);
> +	pm_runtime_disable(pfdev->dev);
> +	panfrost_device_fini(pfdev);
> +	drm_dev_put(ddev);
> +	return 0;
> +}
> +
> +static const struct of_device_id dt_match[] = {
> +	{ .compatible = "arm,mali-t604" },
> +	{ .compatible = "arm,mali-t624" },
> +	{ .compatible = "arm,mali-t628" },
> +	{ .compatible = "arm,mali-t720" },
> +	{ .compatible = "arm,mali-t760" },
> +	{ .compatible = "arm,mali-t820" },
> +	{ .compatible = "arm,mali-t830" },
> +	{ .compatible = "arm,mali-t860" },
> +	{ .compatible = "arm,mali-t880" },

Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, dt_match);
> +
> +static const struct dev_pm_ops panfrost_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(panfrost_device_suspend, panfrost_device_resume, NULL)
> +};
> +
> +static struct platform_driver panfrost_driver = {
> +	.probe		= panfrost_probe,
> +	.remove		= panfrost_remove,
> +	.driver		= {
> +		.name	= "panfrost",
> +		.pm	= &panfrost_pm_ops,
> +		.of_match_table = dt_match,
> +	},
> +};
> +module_platform_driver(panfrost_driver);
> +
> +MODULE_AUTHOR("Panfrost Project Developers");
> +MODULE_DESCRIPTION("Panfrost DRM Driver");
> +MODULE_LICENSE("GPL v2");
[...]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> new file mode 100644
> index 000000000000..867e2ba3a761
> --- /dev/null
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
[...]
> +static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
> +{
> +	u32 quirks = 0;
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8443) ||
> +	    panfrost_has_hw_issue(pfdev, HW_ISSUE_11035))
> +		quirks |= SC_LS_PAUSEBUFFER_DISABLE;
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_10327))
> +		quirks |= SC_SDC_DISABLE_OQ_DISCARD;
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_10797))
> +		quirks |= SC_ENABLE_TEXGRD_FLAGS;
> +
> +	if (!panfrost_has_hw_issue(pfdev, GPUCORE_1619)) {
> +		if (panfrost_model_cmp(pfdev, 0x750) < 0) /* T60x, T62x, T72x */
> +			quirks |= SC_LS_ATTR_CHECK_DISABLE;
> +		else if (panfrost_model_cmp(pfdev, 0x880) <= 0) /* T76x, T8xx */
> +			quirks |= SC_LS_ALLOW_ATTR_TYPES;
> +	}
> +
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_TLS_HASHING))
> +		quirks |= SC_TLS_HASH_ENABLE;
> +
> +	if (quirks)
> +		gpu_write(pfdev, GPU_SHADER_CONFIG, quirks);
> +
> +
> +	quirks = gpu_read(pfdev, GPU_TILER_CONFIG);
> +
> +	/* Set tiler clock gate override if required */
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_T76X_3953))
> +		quirks |= TC_CLOCK_GATE_OVERRIDE;
> +
> +	gpu_write(pfdev, GPU_TILER_CONFIG, quirks);
> +
> +
> +	quirks = gpu_read(pfdev, GPU_L2_MMU_CONFIG);
> +
> +	/* Limit read & write ID width for AXI */
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
> +		quirks &= ~(L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_READS |
> +			    L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_WRITES);
> +	else
> +		quirks &= ~(L2_MMU_CONFIG_LIMIT_EXTERNAL_READS |
> +			    L2_MMU_CONFIG_LIMIT_EXTERNAL_WRITES);
> +
> +#if 0
> +	if (kbdev->system_coherency == COHERENCY_ACE) {
> +		/* Allow memory configuration disparity to be ignored, we
> +		 * optimize the use of shared memory and thus we expect
> +		 * some disparity in the memory configuration */
> +		quirks |= L2_MMU_CONFIG_ALLOW_SNOOP_DISPARITY;

Well that sounds terrifying; I rather wish my brain had preprocessed 
that #if already.

> +	}
> +#endif
> +	gpu_write(pfdev, GPU_L2_MMU_CONFIG, quirks);
> +
> +	quirks = 0;
> +	if ((panfrost_model_eq(pfdev, 0x860) || panfrost_model_eq(pfdev, 0x880)) &&
> +	    pfdev->features.revision >= 0x2000)
> +		quirks |= JM_MAX_JOB_THROTTLE_LIMIT << JM_JOB_THROTTLE_LIMIT_SHIFT;
> +	else if (panfrost_model_eq(pfdev, 0x6000) &&
> +		 pfdev->features.coherency_features == COHERENCY_ACE)
> +		quirks |= (COHERENCY_ACE_LITE | COHERENCY_ACE) <<
> +			   JM_FORCE_COHERENCY_FEATURES_SHIFT;

Experience says you can never really trust what ID registers claim about 
system integration stuff like coherency, because eventually someone will 
get a tieoff wrong and make it all fall apart. If even the vendor driver 
has a DT override for it you know you're on thin ice ;)

Ultimately, most of your I/O coherency behaviour will be governed by 
what the DMA API thinks (based on "dma-coherent"), so if you end up with 
mismatched expectations at the point coherency_features gets set up then 
you're liable to have a bad time. See the arm-smmu drivers for prior 
examples of handling the equivalent thing.

Robin.

> +
> +	if (quirks)
> +		gpu_write(pfdev, GPU_JM_CONFIG, quirks);
> +}
