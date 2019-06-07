Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD9C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EF020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfFGJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:13:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFGJN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:13:57 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 05:13:56 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 519CE28;
        Fri,  7 Jun 2019 02:06:00 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 154723F246;
        Fri,  7 Jun 2019 02:06:00 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CA7E168240D; Fri,  7 Jun 2019 10:05:58 +0100 (BST)
Date:   Fri, 7 Jun 2019 10:05:58 +0100
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
Subject: Re: [PATCH v2 1/2] drm/komeda: Adds SMMU support
Message-ID: <20190607090558.GA4173@e110455-lin.cambridge.arm.com>
References: <1559814765-18455-1-git-send-email-lowry.li@arm.com>
 <1559814765-18455-2-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559814765-18455-2-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Thu, Jun 06, 2019 at 10:53:05AM +0100, Lowry Li (Arm Technology China) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> 
> Adds iommu_connect and disconnect for SMMU support, and configures
> TBU translation once SMMU has been attached to the display device.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c |  5 +++
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   | 49 ++++++++++++++++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c    | 18 ++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  7 ++++
>  .../drm/arm/display/komeda/komeda_framebuffer.c    |  2 +
>  .../drm/arm/display/komeda/komeda_framebuffer.h    |  2 +
>  6 files changed, 83 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 4e26a80..4a48dd6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -215,6 +215,8 @@ static void d71_layer_update(struct komeda_component *c,
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
>  
> +	if (kfb->is_va)
> +		ctrl |= L_TBU_EN;
>  	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
>  }
>  
> @@ -348,6 +350,9 @@ static void d71_wb_layer_update(struct komeda_component *c,
>  			       fb->pitches[i] & 0xFFFF);
>  	}
>  
> +	if (kfb->is_va)
> +		ctrl |= LW_TBU_EN;
> +
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
>  	malidp_write32(reg, BLK_INPUT_ID0, to_d71_input_id(&state->inputs[0]));
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> index 8e682c7..1b9e734 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -517,6 +517,53 @@ static void d71_init_fmt_tbl(struct komeda_dev *mdev)
>  	table->n_formats = ARRAY_SIZE(d71_format_caps_table);
>  }
>  
> +static int d71_connect_iommu(struct komeda_dev *mdev)
> +{
> +	struct d71_dev *d71 = mdev->chip_data;
> +	u32 __iomem *reg = d71->gcu_addr;
> +	u32 check_bits = (d71->num_pipelines == 2) ?
> +			 GCU_STATUS_TCS0 | GCU_STATUS_TCS1 : GCU_STATUS_TCS0;
> +	int i, ret;
> +
> +	if (!d71->integrates_tbu)
> +		return -1;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, 0x7, TBU_CONNECT_MODE);
> +
> +	ret = dp_wait_cond(has_bits(check_bits, malidp_read32(reg, BLK_STATUS)),
> +			100, 1000, 1000);
> +	if (ret <= 0) {

You don't want to return -ETIMEDOUT if dp_wait_cond() returns zero. Maybe
follow the same flow as in d71_disconnect_iommu() ?

> +		DRM_ERROR("connect to TCU timeout!\n");
> +		malidp_write32_mask(reg, BLK_CONTROL, 0x7, INACTIVE_MODE);
> +		return -ETIMEDOUT;
> +	}
> +
> +	for (i = 0; i < d71->num_pipelines; i++)
> +		malidp_write32_mask(d71->pipes[i]->lpu_addr, LPU_TBU_CONTROL,
> +				    LPU_TBU_CTRL_TLBPEN, LPU_TBU_CTRL_TLBPEN);
> +	return 0;
> +}
> +
> +static int d71_disconnect_iommu(struct komeda_dev *mdev)
> +{
> +	struct d71_dev *d71 = mdev->chip_data;
> +	u32 __iomem *reg = d71->gcu_addr;
> +	u32 check_bits = (d71->num_pipelines == 2) ?
> +			 GCU_STATUS_TCS0 | GCU_STATUS_TCS1 : GCU_STATUS_TCS0;
> +	int ret;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, 0x7, TBU_DISCONNECT_MODE);
> +
> +	ret = dp_wait_cond(((malidp_read32(reg, BLK_STATUS) & check_bits) == 0),
> +			100, 1000, 1000);
> +	if (ret < 0) {
> +		DRM_ERROR("disconnect from TCU timeout!\n");
> +		malidp_write32_mask(reg, BLK_CONTROL, 0x7, INACTIVE_MODE);
> +	}
> +
> +	return ret;
> +}
> +
>  static struct komeda_dev_funcs d71_chip_funcs = {
>  	.init_format_table = d71_init_fmt_tbl,
>  	.enum_resources	= d71_enum_resources,
> @@ -527,6 +574,8 @@ static void d71_init_fmt_tbl(struct komeda_dev *mdev)
>  	.on_off_vblank	= d71_on_off_vblank,
>  	.change_opmode	= d71_change_opmode,
>  	.flush		= d71_flush,
> +	.connect_iommu	= d71_connect_iommu,
> +	.disconnect_iommu = d71_disconnect_iommu,
>  };
>  
>  struct komeda_dev_funcs *
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index c92e161..e80e673 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -253,6 +253,19 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  	dev->dma_parms = &mdev->dma_parms;
>  	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>  
> +	mdev->iommu = iommu_get_domain_for_dev(mdev->dev);
> +	if (!mdev->iommu)
> +		DRM_INFO("continue without IOMMU support!\n");
> +
> +	if (mdev->iommu && mdev->funcs->connect_iommu) {
> +		err = mdev->funcs->connect_iommu(mdev);
> +		if (err) {
> +			mdev->iommu = NULL;
> +			DRM_ERROR("connect iommu failed.\n");

I thought you're going to remove these extra DRM_ERRORs.

Best regards,
Liviu

> +			goto err_cleanup;
> +		}
> +	}
> +
>  	err = sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
>  	if (err) {
>  		DRM_ERROR("create sysfs group failed.\n");
> @@ -282,6 +295,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  #endif
>  
> +	if (mdev->iommu && mdev->funcs->disconnect_iommu)
> +		if (mdev->funcs->disconnect_iommu(mdev))
> +			DRM_ERROR("disconnect iommu failed.\n");
> +	mdev->iommu = NULL;
> +
>  	for (i = 0; i < mdev->n_pipelines; i++) {
>  		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
>  		mdev->pipelines[i] = NULL;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 83ace71..dac1eda 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -92,6 +92,10 @@ struct komeda_dev_funcs {
>  	int (*enum_resources)(struct komeda_dev *mdev);
>  	/** @cleanup: call to chip to cleanup komeda_dev->chip data */
>  	void (*cleanup)(struct komeda_dev *mdev);
> +	/** @connect_iommu: Optional, connect to external iommu */
> +	int (*connect_iommu)(struct komeda_dev *mdev);
> +	/** @disconnect_iommu: Optional, disconnect to external iommu */
> +	int (*disconnect_iommu)(struct komeda_dev *mdev);
>  	/**
>  	 * @irq_handler:
>  	 *
> @@ -184,6 +188,9 @@ struct komeda_dev {
>  	 */
>  	void *chip_data;
>  
> +	/** @iommu: iommu domain */
> +	struct iommu_domain *iommu;
> +
>  	/** @debugfs_root: root directory of komeda debugfs */
>  	struct dentry *debugfs_root;
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index d5822a3..360ab70 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -201,6 +201,8 @@ struct drm_framebuffer *
>  		goto err_cleanup;
>  	}
>  
> +	kfb->is_va = mdev->iommu ? true : false;
> +
>  	return &kfb->base;
>  
>  err_cleanup:
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> index 6cbb2f6..f4046e2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -21,6 +21,8 @@ struct komeda_fb {
>  	 * extends drm_format_info for komeda specific information
>  	 */
>  	const struct komeda_format_caps *format_caps;
> +	/** @is_va: if smmu is enabled, it will be true */
> +	bool is_va;
>  	/** @aligned_w: aligned frame buffer width */
>  	u32 aligned_w;
>  	/** @aligned_h: aligned frame buffer height */
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
