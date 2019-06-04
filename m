Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD52220843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFDPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:18:04 -0400
Received: from foss.arm.com ([217.140.101.70]:46446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfFDPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:18:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62D0A341;
        Tue,  4 Jun 2019 08:18:03 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F9C43F5AF;
        Tue,  4 Jun 2019 08:18:03 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 558BD682573; Tue,  4 Jun 2019 16:18:01 +0100 (BST)
Date:   Tue, 4 Jun 2019 16:18:01 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2] drm/komeda: Added AFBC support for komeda driver
Message-ID: <20190604151801.GP15316@e110455-lin.cambridge.arm.com>
References: <20190523095635.27996-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523095635.27996-1-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:56:54AM +0100, james qian wang (Arm Technology China) wrote:
> For supporting AFBC:
> 1. Check if the user requested modifier can be supported by display HW.
> 2. Check the obj->size with AFBC's requirement.
> 3. Configure HW according to the modifier (afbc features)
> 
> This patch depends on:
> - https://patchwork.freedesktop.org/series/59915/
> - https://patchwork.freedesktop.org/series/59000/
> 
> v2: Rebase and addressed Ayan's comments
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks,
Liviu

> ---
>  .../arm/display/komeda/d71/d71_component.c    | 39 ++++++++++
>  .../arm/display/komeda/komeda_format_caps.c   | 53 +++++++++++++
>  .../arm/display/komeda/komeda_format_caps.h   |  5 ++
>  .../arm/display/komeda/komeda_framebuffer.c   | 75 ++++++++++++++++++-
>  .../arm/display/komeda/komeda_framebuffer.h   |  4 +
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  4 +
>  .../display/komeda/komeda_pipeline_state.c    | 18 ++++-
>  .../gpu/drm/arm/display/komeda/komeda_plane.c | 15 +++-
>  9 files changed, 210 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 323e5994a55c..5c9bc859f886 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -134,6 +134,27 @@ static u32 to_rot_ctrl(u32 rot)
>  	return lr_ctrl;
>  }
>  
> +static u32 to_ad_ctrl(u64 modifier)
> +{
> +	u32 afbc_ctrl = AD_AEN;
> +
> +	if (!modifier)
> +		return 0;
> +
> +	if ((modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) ==
> +	    AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
> +		afbc_ctrl |= AD_WB;
> +
> +	if (modifier & AFBC_FORMAT_MOD_YTR)
> +		afbc_ctrl |= AD_YT;
> +	if (modifier & AFBC_FORMAT_MOD_SPLIT)
> +		afbc_ctrl |= AD_BS;
> +	if (modifier & AFBC_FORMAT_MOD_TILED)
> +		afbc_ctrl |= AD_TH;
> +
> +	return afbc_ctrl;
> +}
> +
>  static inline u32 to_d71_input_id(struct komeda_component_output *output)
>  {
>  	struct komeda_component *comp = output->component;
> @@ -173,6 +194,24 @@ static void d71_layer_update(struct komeda_component *c,
>  			       fb->pitches[i] & 0xFFFF);
>  	}
>  
> +	malidp_write32(reg, AD_CONTROL, to_ad_ctrl(fb->modifier));
> +	if (fb->modifier) {
> +		u64 addr;
> +
> +		malidp_write32(reg, LAYER_AD_H_CROP, HV_CROP(st->afbc_crop_l,
> +							     st->afbc_crop_r));
> +		malidp_write32(reg, LAYER_AD_V_CROP, HV_CROP(st->afbc_crop_t,
> +							     st->afbc_crop_b));
> +		/* afbc 1.2 wants payload, afbc 1.0/1.1 wants end_addr */
> +		if (fb->modifier & AFBC_FORMAT_MOD_TILED)
> +			addr = st->addr[0] + kfb->offset_payload;
> +		else
> +			addr = st->addr[0] + kfb->afbc_size - 1;
> +
> +		malidp_write32(reg, BLK_P1_PTR_LOW, lower_32_bits(addr));
> +		malidp_write32(reg, BLK_P1_PTR_HIGH, upper_32_bits(addr));
> +	}
> +
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> index 1e17bd6107a4..b2195142e3f3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> @@ -35,6 +35,59 @@ komeda_get_format_caps(struct komeda_format_caps_table *table,
>  	return NULL;
>  }
>  
> +/* Two assumptions
> + * 1. RGB always has YTR
> + * 2. Tiled RGB always has SC
> + */
> +u64 komeda_supported_modifiers[] = {
> +	/* AFBC_16x16 + features: YUV+RGB both */
> +	AFBC_16x16(0),
> +	/* SPARSE */
> +	AFBC_16x16(_SPARSE),
> +	/* YTR + (SPARSE) */
> +	AFBC_16x16(_YTR | _SPARSE),
> +	AFBC_16x16(_YTR),
> +	/* SPLIT + SPARSE + YTR RGB only */
> +	/* split mode is only allowed for sparse mode */
> +	AFBC_16x16(_SPLIT | _SPARSE | _YTR),
> +	/* TILED + (SPARSE) */
> +	/* TILED YUV format only */
> +	AFBC_16x16(_TILED | _SPARSE),
> +	AFBC_16x16(_TILED),
> +	/* TILED + SC + (SPLIT+SPARSE | SPARSE) + (YTR) */
> +	AFBC_16x16(_TILED | _SC | _SPLIT | _SPARSE | _YTR),
> +	AFBC_16x16(_TILED | _SC | _SPARSE | _YTR),
> +	AFBC_16x16(_TILED | _SC | _YTR),
> +	/* AFBC_32x8 + features: which are RGB formats only */
> +	/* YTR + (SPARSE) */
> +	AFBC_32x8(_YTR | _SPARSE),
> +	AFBC_32x8(_YTR),
> +	/* SPLIT + SPARSE + (YTR) */
> +	/* split mode is only allowed for sparse mode */
> +	AFBC_32x8(_SPLIT | _SPARSE | _YTR),
> +	/* TILED + SC + (SPLIT+SPARSE | SPARSE) + YTR */
> +	AFBC_32x8(_TILED | _SC | _SPLIT | _SPARSE | _YTR),
> +	AFBC_32x8(_TILED | _SC | _SPARSE | _YTR),
> +	AFBC_32x8(_TILED | _SC | _YTR),
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
> +bool komeda_format_mod_supported(struct komeda_format_caps_table *table,
> +				 u32 layer_type, u32 fourcc, u64 modifier)
> +{
> +	const struct komeda_format_caps *caps;
> +
> +	caps = komeda_get_format_caps(table, fourcc, modifier);
> +	if (!caps)
> +		return false;
> +
> +	if (!(caps->supported_layer_types & layer_type))
> +		return false;
> +
> +	return true;
> +}
> +
>  u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
>  				  u32 layer_type, u32 *n_fmts)
>  {
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index 60f39e77b098..bc3b2df361b9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -77,6 +77,8 @@ struct komeda_format_caps_table {
>  	const struct komeda_format_caps *format_caps;
>  };
>  
> +extern u64 komeda_supported_modifiers[];
> +
>  const struct komeda_format_caps *
>  komeda_get_format_caps(struct komeda_format_caps_table *table,
>  		       u32 fourcc, u64 modifier);
> @@ -86,4 +88,7 @@ u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
>  
>  void komeda_put_fourcc_list(u32 *fourcc_list);
>  
> +bool komeda_format_mod_supported(struct komeda_format_caps_table *table,
> +				 u32 layer_type, u32 fourcc, u64 modifier);
> +
>  #endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index 4d8160cf09c3..d0e713aedb8e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -36,6 +36,76 @@ static const struct drm_framebuffer_funcs komeda_fb_funcs = {
>  	.create_handle	= komeda_fb_create_handle,
>  };
>  
> +static int
> +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
> +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	struct drm_framebuffer *fb = &kfb->base;
> +	const struct drm_format_info *info = fb->format;
> +	struct drm_gem_object *obj;
> +	u32 alignment_w = 0, alignment_h = 0, alignment_header;
> +	u32 n_blocks = 0, min_size = 0;
> +
> +	obj = drm_gem_object_lookup(file, mode_cmd->handles[0]);
> +	if (!obj) {
> +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> +		return -ENOENT;
> +	}
> +
> +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> +		alignment_w = 32;
> +		alignment_h = 8;
> +		break;
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +		alignment_w = 16;
> +		alignment_h = 16;
> +		break;
> +	default:
> +		WARN(1, "Invalid AFBC_FORMAT_MOD_BLOCK_SIZE: %lld.\n",
> +		     fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK);
> +		break;
> +	}
> +
> +	/* tiled header afbc */
> +	if (fb->modifier & AFBC_FORMAT_MOD_TILED) {
> +		alignment_w *= AFBC_TH_LAYOUT_ALIGNMENT;
> +		alignment_h *= AFBC_TH_LAYOUT_ALIGNMENT;
> +		alignment_header = AFBC_TH_BODY_START_ALIGNMENT;
> +	} else {
> +		alignment_header = AFBC_BODY_START_ALIGNMENT;
> +	}
> +
> +	kfb->aligned_w = ALIGN(fb->width, alignment_w);
> +	kfb->aligned_h = ALIGN(fb->height, alignment_h);
> +
> +	if (fb->offsets[0] % alignment_header) {
> +		DRM_DEBUG_KMS("afbc offset alignment check failed.\n");
> +		goto check_failed;
> +	}
> +
> +	n_blocks = (kfb->aligned_w * kfb->aligned_h) / AFBC_SUPERBLK_PIXELS;
> +	kfb->offset_payload = ALIGN(n_blocks * AFBC_HEADER_SIZE,
> +				    alignment_header);
> +
> +	kfb->afbc_size = kfb->offset_payload + n_blocks *
> +			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
> +			       AFBC_SUPERBLK_ALIGNMENT);
> +	min_size = kfb->afbc_size + fb->offsets[0];
> +	if (min_size > obj->size) {
> +		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
> +			      obj->size, min_size);
> +		goto check_failed;
> +	}
> +
> +	fb->obj[0] = obj;
> +	return 0;
> +
> +check_failed:
> +	drm_gem_object_put_unlocked(obj);
> +	return -EINVAL;
> +}
> +
>  static int
>  komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
>  			       struct drm_file *file,
> @@ -118,7 +188,10 @@ komeda_fb_create(struct drm_device *dev, struct drm_file *file,
>  
>  	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);
>  
> -	ret = komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
> +	if (kfb->base.modifier)
> +		ret = komeda_fb_afbc_size_check(kfb, file, mode_cmd);
> +	else
> +		ret = komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
>  	if (ret < 0)
>  		goto err_cleanup;
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> index ea2fe190c1e3..e3bab0defd72 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -25,6 +25,10 @@ struct komeda_fb {
>  	u32 aligned_w;
>  	/** @aligned_h: aligned frame buffer height */
>  	u32 aligned_h;
> +	/** @afbc_size: minimum size of afbc */
> +	u32 afbc_size;
> +	/** @offset_payload: start of afbc body buffer */
> +	u32 offset_payload;
>  };
>  
>  #define to_kfb(dfb)	container_of(dfb, struct komeda_fb, base)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 3e58901fb776..306ea069a1b4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -148,7 +148,7 @@ static void komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
>  	config->min_height	= 0;
>  	config->max_width	= 4096;
>  	config->max_height	= 4096;
> -	config->allow_fb_modifiers = false;
> +	config->allow_fb_modifiers = true;
>  
>  	config->funcs = &komeda_mode_config_funcs;
>  	config->helper_private = &komeda_mode_config_helpers;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 1b7e933ea303..fdde93bad8de 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -235,6 +235,10 @@ struct komeda_layer_state {
>  	/* layer specific configuration state */
>  	u16 hsize, vsize;
>  	u32 rot;
> +	u16 afbc_crop_l;
> +	u16 afbc_crop_r;
> +	u16 afbc_crop_t;
> +	u16 afbc_crop_b;
>  	dma_addr_t addr[3];
>  };
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 9748c9438868..db2c3d6d2a8a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -291,8 +291,22 @@ komeda_layer_validate(struct komeda_layer *layer,
>  	st = to_layer_st(c_st);
>  
>  	st->rot = dflow->rot;
> -	st->hsize = kfb->aligned_w;
> -	st->vsize = kfb->aligned_h;
> +
> +	if (fb->modifier) {
> +		st->hsize = kfb->aligned_w;
> +		st->vsize = kfb->aligned_h;
> +		st->afbc_crop_l = dflow->in_x;
> +		st->afbc_crop_r = kfb->aligned_w - dflow->in_x - dflow->in_w;
> +		st->afbc_crop_t = dflow->in_y;
> +		st->afbc_crop_b = kfb->aligned_h - dflow->in_y - dflow->in_h;
> +	} else {
> +		st->hsize = dflow->in_w;
> +		st->vsize = dflow->in_h;
> +		st->afbc_crop_l = 0;
> +		st->afbc_crop_r = 0;
> +		st->afbc_crop_t = 0;
> +		st->afbc_crop_b = 0;
> +	}
>  
>  	for (i = 0; i < fb->format->num_planes; i++)
>  		st->addr[i] = komeda_fb_get_pixel_addr(kfb, dflow->in_x,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 07ed0cc1bc44..6462c0206942 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -153,6 +153,18 @@ komeda_plane_atomic_destroy_state(struct drm_plane *plane,
>  	kfree(to_kplane_st(state));
>  }
>  
> +static bool
> +komeda_plane_format_mod_supported(struct drm_plane *plane,
> +				  u32 format, u64 modifier)
> +{
> +	struct komeda_dev *mdev = plane->dev->dev_private;
> +	struct komeda_plane *kplane = to_kplane(plane);
> +	u32 layer_type = kplane->layer->layer_type;
> +
> +	return komeda_format_mod_supported(&mdev->fmt_tbl, layer_type,
> +					   format, modifier);
> +}
> +
>  static const struct drm_plane_funcs komeda_plane_funcs = {
>  	.update_plane		= drm_atomic_helper_update_plane,
>  	.disable_plane		= drm_atomic_helper_disable_plane,
> @@ -160,6 +172,7 @@ static const struct drm_plane_funcs komeda_plane_funcs = {
>  	.reset			= komeda_plane_reset,
>  	.atomic_duplicate_state	= komeda_plane_atomic_duplicate_state,
>  	.atomic_destroy_state	= komeda_plane_atomic_destroy_state,
> +	.format_mod_supported	= komeda_plane_format_mod_supported,
>  };
>  
>  /* for komeda, which is pipeline can be share between crtcs */
> @@ -212,7 +225,7 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
>  	err = drm_universal_plane_init(&kms->base, plane,
>  			get_possible_crtcs(kms, c->pipeline),
>  			&komeda_plane_funcs,
> -			formats, n_formats, NULL,
> +			formats, n_formats, komeda_supported_modifiers,
>  			get_plane_type(kms, c),
>  			"%s", c->name);
>  
> -- 
> 2.17.1
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
