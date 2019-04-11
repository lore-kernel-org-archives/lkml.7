Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81806C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D4B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:12:24 -0400
Received: from foss.arm.com ([217.140.101.70]:43860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDKOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:12:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762D880D;
        Thu, 11 Apr 2019 07:12:22 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843A13F68F;
        Thu, 11 Apr 2019 07:12:20 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20190409205427.6943-1-robh@kernel.org>
 <20190409205427.6943-4-robh@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <91804969-e3cc-9d39-3ca7-0b59bafd442b@arm.com>
Date:   Thu, 11 Apr 2019 15:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409205427.6943-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 21:54, Rob Herring wrote:
> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.
> 
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
> v3:
> - Add support for reset lines (Neil)
> - Add a MAINTAINERS entry (Rob)
> - Call dma_set_mask_and_coherent (Rob)
> - Do MMU invalidate on map and unmap. Restructure to do a single
>   operation per map/unmap call. (Rob)
> - Add a missing explicit padding to struct drm_panfrost_create_bo (Rob)
> - Fix 0-day error: "panfrost_devfreq.c:151:9-16: ERROR: PTR_ERR applied after initialization to constant on line 150"
> - Drop HW_FEATURE_AARCH64_MMU conditional (Rob)
> - s/DRM_PANFROST_PARAM_GPU_ID/DRM_PANFROST_PARAM_GPU_PROD_ID/ (Rob)
> - Check drm_gem_shmem_prime_import_sg_table() error code (Rob)
> - Re-order power on sequence (Rob)
> - Move panfrost_acquire_object_fences() before scheduling job (Rob)
> - Add NULL checks on array pointers in job clean-up (Rob)
> - Rework devfreq (Tomeu)
> - Fix devfreq init with no regulator (Rob)
> - Various WS and comments clean-up (Rob)
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

This looks like it has addressed my comments, so:

Reviewed-by: Steven Price <steven.price@arm.com>


There's a couple of nits below if you do respin, but these shouldn't
block merging the driver.

[...]
> +static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
> +		struct drm_file *file)
> +{
> +	struct panfrost_device *pfdev = dev->dev_private;
> +	struct drm_panfrost_submit *args = data;
> +	struct drm_syncobj *sync_out;
> +	struct panfrost_job *job;
> +	int ret = 0;
> +
> +	job = kcalloc(1, sizeof(*job), GFP_KERNEL);

Why not simply kzalloc()? I think you're going to want a new ioctl
if/when adding support for multiple job submissions in one ioctl.

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
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));

The hardware reports the correct mask, from kbase:

> 	err = dma_set_mask(kbdev->dev,
> 			DMA_BIT_MASK(kbdev->gpu_props.mmu.pa_bits));
> 	if (err)
> 		goto dma_set_mask_failed;
> 
> 	err = dma_set_coherent_mask(kbdev->dev,
> 			DMA_BIT_MASK(kbdev->gpu_props.mmu.pa_bits));
> 	if (err)
> 		goto dma_set_mask_failed;

Although I'm not sure if it has ever varied.

Thanks,

Steve
