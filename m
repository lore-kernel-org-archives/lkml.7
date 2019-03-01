Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E22C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABAE2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfCARyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:54:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfCARyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:54:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AA0180D;
        Fri,  1 Mar 2019 09:54:11 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA97D3F575;
        Fri,  1 Mar 2019 09:54:10 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id F3F186800F3; Fri,  1 Mar 2019 17:54:08 +0000 (GMT)
Date:   Fri, 1 Mar 2019 17:54:08 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 05/10] drm/arm/malidp:- Define a common list of AFBC
 format modifiers supported for DP500, DP550 and DP650
Message-ID: <20190301175408.GA25147@e110455-lin.cambridge.arm.com>
References: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
 <1551198042-4314-6-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551198042-4314-6-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 04:20:56PM +0000, Ayan Halder wrote:
> From: Ayan Kumar Halder <ayan.halder@arm.com>
> 
> We need to define a common list of format modifiers supported by each of
> the Mali display processors.
> 
> The following are the constraints with AFBC:-
> 
> 1. AFBC is not supported for the formats defined in
> malidp_hw_format_is_linear_only()
> 
> 2. Some of the formats are supported only with AFBC modifiers. Thus we have
> introduced a new function 'malidp_hw_format_is_afbc_only()' which verifies
> the same.
> 
> 3. AFBC_FORMAT_MOD_YTR needs to be provided for any RGB format.
> 
> 4. Formats <= 16bpp cannot support AFBC_FORMAT_MOD_SPLIT.
> 
> 5. CBR should not be set for non-subsampled formats.
> 
> 6. SMART layer does not support framebuffer with AFBC modifiers.
> Return -EINVAL for such a scenario.
> 
> 7. AFBC_FORMAT_MOD_YTR is not supported for any YUV formats.
> 
> 8. Formats which are subsampled cannot support AFBC_FORMAT_MOD_SPLIT.
> However in DP550, YUV_420_10BIT is supported with AFBC_FORMAT_MOD_SPLIT.
> This feature has been identified with
> MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT.
> 
> 9. In DP550 and DP650, for YUYV, the hardware supports different
> format-ids to be used with and without AFBC modifier. We have used the
> feature 'MALIDP_DEVICE_AFBC_YUYV_USE_422_P2' to identify this
> characteristic.
> 
> 10. DP500 does not support split mode (ie AFBC_FORMAT_MOD_SPLIT). We have
> used the feature 'MALIDP_DEVICE_AFBC_SUPPORT_SPLIT' to identify the DPs
> which support SPLIT mode.
> 
> 11. DP550 supports YUV420 with split mode. We have defined the feature
> 'AFBC_SUPPORT_SPLIT_WITH_YUV_420_10' to identify this characteristic.
> 
> Changes since v1:-
> - Merged https://patchwork.freedesktop.org/patch/265215/ into this patch
> - As Liviu pointed out in the last patch, we can pull the checks outside
> of the 'while (*modifiers != DRM_FORMAT_MOD_INVALID)' loop
> - Rebased
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c    |  32 ++-------
>  drivers/gpu/drm/arm/malidp_drv.h    |   6 ++
>  drivers/gpu/drm/arm/malidp_hw.c     |  96 +++++++++++++++++++++++++--
>  drivers/gpu/drm/arm/malidp_hw.h     |  24 +++++--
>  drivers/gpu/drm/arm/malidp_mw.c     |   2 +-
>  drivers/gpu/drm/arm/malidp_planes.c | 126 +++++++++++++++++++++++++++++++++++-
>  6 files changed, 246 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index ab50ad0..c697664 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -264,37 +264,17 @@ static bool
>  malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
>  				    const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
> -	const struct drm_format_info *info;
> -
> -	if ((mode_cmd->modifier[0] >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
> -		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
> +	if (malidp_format_mod_supported(dev, mode_cmd->pixel_format,
> +					mode_cmd->modifier[0]) == false)
>  		return false;
> -	}
> -
> -	if (mode_cmd->modifier[0] &
> -	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> -		DRM_DEBUG_KMS("Unsupported modifiers\n");
> -		return false;
> -	}
> -
> -	info = drm_get_format_info(dev, mode_cmd);
> -	if (!info) {
> -		DRM_DEBUG_KMS("Unable to get the format information\n");
> -		return false;
> -	}
> -
> -	if (info->num_planes != 1) {
> -		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> -		return false;
> -	}
>  
>  	if (mode_cmd->offsets[0] != 0) {
>  		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
>  		return false;
>  	}
>  
> -	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> -	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> +	case AFBC_SIZE_16X16:
>  		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
>  			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
>  			return false;
> @@ -319,8 +299,8 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
>  	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
>  	u32 afbc_superblock_width = 0, afbc_size = 0;
>  
> -	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> -	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
> +	case AFBC_SIZE_16X16:
>  		afbc_superblock_height = 16;
>  		afbc_superblock_width = 16;
>  		break;
> diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
> index b76c86f..019a682 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.h
> +++ b/drivers/gpu/drm/arm/malidp_drv.h
> @@ -90,6 +90,12 @@ struct malidp_crtc_state {
>  int malidp_de_planes_init(struct drm_device *drm);
>  int malidp_crtc_init(struct drm_device *drm);
>  
> +bool malidp_hw_format_is_linear_only(u32 format);
> +bool malidp_hw_format_is_afbc_only(u32 format);
> +
> +bool malidp_format_mod_supported(struct drm_device *drm,
> +				 u32 format, u64 modifier);
> +
>  #ifdef CONFIG_DEBUG_FS
>  void malidp_error(struct malidp_drm *malidp,
>  		  struct malidp_error_stats *error_stats, u32 status,
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index b4a0e11..0ac2762 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -60,6 +60,8 @@ static const struct malidp_format_id malidp500_de_formats[] = {
>  #define MALIDP_ID(__group, __format) \
>  	((((__group) & 0x7) << 3) | ((__format) & 0x7))
>  
> +#define AFBC_YUV_422_FORMAT_ID	MALIDP_ID(5, 1)
> +
>  #define MALIDP_COMMON_FORMATS \
>  	/*    fourcc,   layers supporting the format,      internal id   */ \
>  	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 0) }, \
> @@ -162,6 +164,32 @@ static const struct malidp_layer malidp650_layers[] = {
>  		ROTATE_NONE, 0 },
>  };
>  
> +const u64 malidp_format_modifiers[] = {
> +	/* All RGB formats (except XRGB, RGBX, XBGR, BGRX) */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR),
> +
> +	/* All RGB formats > 16bpp (except XRGB, RGBX, XBGR, BGRX) */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE | AFBC_SPLIT),
> +
> +	/* All 8 or 10 bit YUV 444 formats. */
> +	/* In DP550, 10 bit YUV 420 format also supported */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE | AFBC_SPLIT),
> +
> +	/* YUV 420, 422 P1 8 bit and YUV 444 8 bit/10 bit formats */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16),
> +
> +	/* YUV 420, 422 P1 8, 10 bit formats */
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR | AFBC_SPARSE),
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR),
> +
> +	/* All formats */
> +	DRM_FORMAT_MOD_LINEAR,
> +
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
>  #define SE_N_SCALING_COEFFS	96
>  static const u16 dp500_se_scaling_coeffs[][SE_N_SCALING_COEFFS] = {
>  	[MALIDP_UPSCALING_COEFFS - 1] = {
> @@ -866,7 +894,10 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ |
> +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> +				    MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT |
> +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
>  			.n_layers = ARRAY_SIZE(malidp550_layers),
>  			.layers = malidp550_layers,
>  			.de_irq_map = {
> @@ -912,7 +943,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.se_base = MALIDP550_SE_BASE,
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
> -			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
> +			.features = MALIDP_REGMAP_HAS_CLEARIRQ |
> +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
>  			.n_layers = ARRAY_SIZE(malidp650_layers),
>  			.layers = malidp650_layers,
>  			.de_irq_map = {
> @@ -961,19 +994,72 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  };
>  
>  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> -			   u8 layer_id, u32 format)
> +			   u8 layer_id, u32 format, bool has_modifier)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < map->n_pixel_formats; i++) {
>  		if (((map->pixel_formats[i].layer & layer_id) == layer_id) &&
> -		    (map->pixel_formats[i].format == format))
> -			return map->pixel_formats[i].id;
> +		    (map->pixel_formats[i].format == format)) {
> +			/*
> +			 * In some DP550 and DP650, DRM_FORMAT_YUYV + AFBC modifier
> +			 * is supported by a different h/w format id than
> +			 * DRM_FORMAT_YUYV (only).
> +			 */
> +			if (format == DRM_FORMAT_YUYV &&
> +			    (has_modifier) &&
> +			    (map->features & MALIDP_DEVICE_AFBC_YUYV_USE_422_P2))
> +				return AFBC_YUV_422_FORMAT_ID;
> +			else
> +				return map->pixel_formats[i].id;
> +		}
>  	}
>  
>  	return MALIDP_INVALID_FORMAT_ID;
>  }
>  
> +bool malidp_hw_format_is_linear_only(u32 format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_ARGB2101010:
> +	case DRM_FORMAT_RGBA1010102:
> +	case DRM_FORMAT_BGRA1010102:
> +	case DRM_FORMAT_ARGB8888:
> +	case DRM_FORMAT_RGBA8888:
> +	case DRM_FORMAT_BGRA8888:
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_RGBX8888:
> +	case DRM_FORMAT_BGRX8888:
> +	case DRM_FORMAT_RGB888:
> +	case DRM_FORMAT_RGB565:
> +	case DRM_FORMAT_ARGB1555:
> +	case DRM_FORMAT_RGBA5551:
> +	case DRM_FORMAT_BGRA5551:
> +	case DRM_FORMAT_UYVY:
> +	case DRM_FORMAT_XYUV8888:
> +	case DRM_FORMAT_XVYU2101010:
> +	case DRM_FORMAT_X0L2:
> +	case DRM_FORMAT_X0L0:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +bool malidp_hw_format_is_afbc_only(u32 format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_VUY888:
> +	case DRM_FORMAT_VUY101010:
> +	case DRM_FORMAT_YUV420_8BIT:
> +	case DRM_FORMAT_YUV420_10BIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void malidp_hw_clear_irq(struct malidp_hw_device *hwdev, u8 block, u32 irq)
>  {
>  	u32 base = malidp_get_block_base(hwdev, block);
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 651558f..0859302 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -95,7 +95,10 @@ struct malidp_se_config {
>  };
>  
>  /* regmap features */
> -#define MALIDP_REGMAP_HAS_CLEARIRQ	(1 << 0)
> +#define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
> +#define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
> +#define MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT		BIT(2)
> +#define MALIDP_DEVICE_AFBC_YUYV_USE_422_P2			BIT(3)
>  
>  struct malidp_hw_regmap {
>  	/* address offset of the DE register bank */
> @@ -321,7 +324,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq);
>  void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
>  
>  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> -			   u8 layer_id, u32 format);
> +			   u8 layer_id, u32 format, bool has_modifier);
>  
>  static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hwdev, bool rotated)
>  {
> @@ -390,9 +393,18 @@ static inline void malidp_se_set_enh_coeffs(struct malidp_hw_device *hwdev)
>  
>  #define MALIDP_GAMMA_LUT_SIZE		4096
>  
> -#define AFBC_MOD_VALID_BITS (AFBC_FORMAT_MOD_BLOCK_SIZE_MASK | \
> -			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPLIT | \
> -			AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_CBR | \
> -			AFBC_FORMAT_MOD_TILED | AFBC_FORMAT_MOD_SC)
> +#define AFBC_SIZE_MASK		AFBC_FORMAT_MOD_BLOCK_SIZE_MASK
> +#define AFBC_SIZE_16X16		AFBC_FORMAT_MOD_BLOCK_SIZE_16x16
> +#define AFBC_YTR		AFBC_FORMAT_MOD_YTR
> +#define AFBC_SPARSE		AFBC_FORMAT_MOD_SPARSE
> +#define AFBC_CBR		AFBC_FORMAT_MOD_CBR
> +#define AFBC_SPLIT		AFBC_FORMAT_MOD_SPLIT
> +#define AFBC_TILED		AFBC_FORMAT_MOD_TILED
> +#define AFBC_SC			AFBC_FORMAT_MOD_SC
> +
> +#define AFBC_MOD_VALID_BITS	(AFBC_SIZE_MASK | AFBC_YTR | AFBC_SPLIT | \
> +				 AFBC_SPARSE | AFBC_CBR | AFBC_TILED | AFBC_SC)
> +
> +extern const u64 malidp_format_modifiers[];
>  
>  #endif  /* __MALIDP_HW_H__ */
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 041a64d..28cd351 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -143,7 +143,7 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  
>  	mw_state->format =
>  		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
> -					fb->format->format);
> +					fb->format->format, !!fb->modifier);
>  	if (mw_state->format == MALIDP_INVALID_FORMAT_ID) {
>  		struct drm_format_name_buf format_name;
>  
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 181957c..79e00bf 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -52,6 +52,8 @@
>  #define MALIDP550_LS_ENABLE		0x01c
>  #define MALIDP550_LS_R1_IN_SIZE		0x020
>  
> +#define MODIFIERS_COUNT_MAX		15
> +
>  /*
>   * This 4-entry look-up-table is used to determine the full 8-bit alpha value
>   * for formats with 1- or 2-bit alpha channels.
> @@ -145,6 +147,119 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tmmu_prefetch_pgsize=%d\n", ms->mmu_prefetch_pgsize);
>  }
>  
> +bool malidp_format_mod_supported(struct drm_device *drm,
> +				 u32 format, u64 modifier)
> +{
> +	const struct drm_format_info *info;
> +	const u64 *modifiers;
> +	struct malidp_drm *malidp = drm->dev_private;
> +	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
> +
> +	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
> +		return false;
> +
> +	/* Some pixel formats are supported without any modifier */
> +	if (modifier == DRM_FORMAT_MOD_LINEAR) {
> +		/*
> +		 * However these pixel formats need to be supported with
> +		 * modifiers only
> +		 */
> +		return !malidp_hw_format_is_afbc_only(format);
> +	}
> +
> +	if ((modifier >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
> +		DRM_ERROR("Unknown modifier (not Arm)\n");
> +		return false;
> +	}
> +
> +	if (modifier &
> +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> +		DRM_DEBUG_KMS("Unsupported modifiers\n");
> +		return false;
> +	}
> +
> +	modifiers = malidp_format_modifiers;
> +
> +	/* SPLIT buffers must use SPARSE layout */
> +	if (WARN_ON_ONCE((modifier & AFBC_SPLIT) && !(modifier & AFBC_SPARSE)))
> +		return false;
> +
> +	/* CBR only applies to YUV formats, where YTR should be always 0 */
> +	if (WARN_ON_ONCE((modifier & AFBC_CBR) && (modifier & AFBC_YTR)))
> +		return false;
> +
> +	while (*modifiers != DRM_FORMAT_MOD_INVALID) {
> +		if (*modifiers == modifier)
> +			break;
> +
> +		modifiers++;
> +	}
> +
> +	/* return false, if the modifier was not found */
> +	if (*modifiers == DRM_FORMAT_MOD_INVALID) {
> +		DRM_DEBUG_KMS("Unsupported modifier\n");
> +		return false;
> +	}
> +
> +	info = drm_format_info(format);
> +
> +	if (info->num_planes != 1) {
> +		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> +		return false;
> +	}
> +
> +	if (malidp_hw_format_is_linear_only(format) == true) {
> +		DRM_DEBUG_KMS("Given format (0x%x) is supported is linear mode only\n",
> +			      format);
> +		return false;
> +	}
> +
> +	/*
> +	 * RGB formats need to provide YTR modifier and YUV formats should not
> +	 * provide YTR modifier.
> +	 */
> +	if (!(info->is_yuv) != !!(modifier & AFBC_FORMAT_MOD_YTR)) {
> +		DRM_DEBUG_KMS("AFBC_FORMAT_MOD_YTR is %s for %s formats\n",
> +			      info->is_yuv ? "disallowed" : "mandatory",
> +			      info->is_yuv ? "YUV" : "RGB");
> +		return false;
> +	}
> +
> +	if (modifier & AFBC_SPLIT) {
> +		if (!info->is_yuv) {
> +			if (drm_format_plane_cpp(format, 0) <= 2) {
> +				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
> +				return false;
> +			}
> +		}
> +
> +		if ((drm_format_horz_chroma_subsampling(format) != 1) ||
> +		    (drm_format_vert_chroma_subsampling(format) != 1)) {
> +			if (!(format == DRM_FORMAT_YUV420_10BIT &&
> +			      (map->features & MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT))) {
> +				DRM_DEBUG_KMS("Formats which are sub-sampled should never be split\n");
> +				return false;
> +			}
> +		}
> +	}
> +
> +	if (modifier & AFBC_CBR) {
> +		if ((drm_format_horz_chroma_subsampling(format) == 1) ||
> +		    (drm_format_vert_chroma_subsampling(format) == 1)) {
> +			DRM_DEBUG_KMS("Formats which are not sub-sampled should not have CBR set\n");
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static bool malidp_format_mod_supported_per_plane(struct drm_plane *plane,
> +						  u32 format, u64 modifier)
> +{
> +	return malidp_format_mod_supported(plane->dev, format, modifier);
> +}
> +
>  static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -153,6 +268,7 @@ static const struct drm_plane_funcs malidp_de_plane_funcs = {
>  	.atomic_duplicate_state = malidp_duplicate_plane_state,
>  	.atomic_destroy_state = malidp_destroy_plane_state,
>  	.atomic_print_state = malidp_plane_atomic_print_state,
> +	.format_mod_supported = malidp_format_mod_supported_per_plane,
>  };
>  
>  static int malidp_se_check_scaling(struct malidp_plane *mp,
> @@ -406,8 +522,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	fb = state->fb;
>  
>  	ms->format = malidp_hw_get_format_id(&mp->hwdev->hw->map,
> -					     mp->layer->id,
> -					     fb->format->format);
> +					     mp->layer->id, fb->format->format,
> +					     !!fb->modifier);
>  	if (ms->format == MALIDP_INVALID_FORMAT_ID)
>  		return -EINVAL;
>  
> @@ -469,6 +585,12 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  			return -EINVAL;
>  	}
>  
> +	/* SMART layer does not support AFBC */
> +	if (mp->layer->id == DE_SMART && fb->modifier) {
> +		DRM_ERROR("AFBC framebuffer not supported in SMART layer");
> +		return -EINVAL;
> +	}
> +
>  	ms->rotmem_size = 0;
>  	if (state->rotation & MALIDP_ROTATED_MASK) {
>  		int val;
> -- 
> 2.7.4
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
