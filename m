Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71FAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A55520645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEBQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:24:26 -0400
Received: from foss.arm.com ([217.140.101.70]:48850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:24:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A1AA78;
        Thu,  2 May 2019 09:24:24 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB1B3F5AF;
        Thu,  2 May 2019 09:24:24 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 7776268240E; Thu,  2 May 2019 17:24:22 +0100 (BST)
Date:   Thu, 2 May 2019 17:24:22 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ben Davis <Ben.Davis@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] drm/malidp: Enable writeback scaling
Message-ID: <20190502162422.GZ15144@e110455-lin.cambridge.arm.com>
References: <1556813386-18823-1-git-send-email-ben.davis@arm.com>
 <1556813386-18823-3-git-send-email-ben.davis@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556813386-18823-3-git-send-email-ben.davis@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:10:10PM +0100, Ben Davis wrote:
> The phase setting part of malidp_crtc_atomic_check_scaling is refactored
> to allow use in writeback scaling.
> 
> Also the enable_memwrite function prototype is simplified by directly
> passing mw_state.
> 
> Signed-off-by: Ben Davis <ben.davis@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

I will pull this series the mali-dp tree after more people had a chance
to review it. I think the next thing to do would be to come up with a
test in igt for these properties.

Thanks,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_crtc.c |  47 ++++++++-------
>  drivers/gpu/drm/arm/malidp_drv.c  |  10 +++-
>  drivers/gpu/drm/arm/malidp_drv.h  |   2 +
>  drivers/gpu/drm/arm/malidp_hw.c   |  45 ++++++++++-----
>  drivers/gpu/drm/arm/malidp_hw.h   |  19 ++++++-
>  drivers/gpu/drm/arm/malidp_mw.c   | 117 ++++++++++++++++++++++++++++++--------
>  drivers/gpu/drm/arm/malidp_regs.h |   1 +
>  7 files changed, 176 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 3f65996..6548859 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -265,6 +265,29 @@ static int malidp_crtc_atomic_check_ctm(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> +void malidp_set_se_config_phase(struct malidp_se_config *s)
> +{
> +#define SE_N_PHASE 4
> +#define SE_SHIFT_N_PHASE 12
> +	u32 phase;
> +
> +	/* Calculate initial_phase and delta_phase for horizontal. */
> +	phase = s->input_w;
> +	s->h_init_phase = ((phase << SE_N_PHASE) / s->output_w + 1) / 2;
> +
> +	phase <<= (SE_SHIFT_N_PHASE + SE_N_PHASE);
> +	s->h_delta_phase = phase / s->output_w;
> +
> +	/* Same for vertical. */
> +	phase = s->input_h;
> +	s->v_init_phase = ((phase << SE_N_PHASE) / s->output_h + 1) / 2;
> +
> +	phase <<= (SE_SHIFT_N_PHASE + SE_N_PHASE);
> +	s->v_delta_phase = phase / s->output_h;
> +#undef SE_N_PHASE
> +#undef SE_SHIFT_N_PHASE
> +}
> +
>  static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
>  					    struct drm_crtc_state *state)
>  {
> @@ -291,7 +314,6 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
>  
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
>  		struct malidp_plane *mp = to_malidp_plane(plane);
> -		u32 phase;
>  
>  		if (!(mp->layer->id & scaling))
>  			continue;
> @@ -319,27 +341,8 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
>  		s->output_w = pstate->crtc_w;
>  		s->output_h = pstate->crtc_h;
>  
> -#define SE_N_PHASE 4
> -#define SE_SHIFT_N_PHASE 12
> -		/* Calculate initial_phase and delta_phase for horizontal. */
> -		phase = s->input_w;
> -		s->h_init_phase =
> -				((phase << SE_N_PHASE) / s->output_w + 1) / 2;
> -
> -		phase = s->input_w;
> -		phase <<= (SE_SHIFT_N_PHASE + SE_N_PHASE);
> -		s->h_delta_phase = phase / s->output_w;
> -
> -		/* Same for vertical. */
> -		phase = s->input_h;
> -		s->v_init_phase =
> -				((phase << SE_N_PHASE) / s->output_h + 1) / 2;
> -
> -		phase = s->input_h;
> -		phase <<= (SE_SHIFT_N_PHASE + SE_N_PHASE);
> -		s->v_delta_phase = phase / s->output_h;
> -#undef SE_N_PHASE
> -#undef SE_SHIFT_N_PHASE
> +
> +		malidp_set_se_config_phase(s);
>  		s->plane_src_id = mp->layer->id;
>  	}
>  
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index d37ff9d..e2465e9 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -138,7 +138,7 @@ static void malidp_atomic_commit_se_config(struct drm_crtc *crtc,
>  	u32 val;
>  
>  	/* Set SE_CONTROL */
> -	if (!s->scale_enable) {
> +	if (!s->scale_enable && !s->wb_scale_enable) {
>  		val = malidp_hw_read(hwdev, se_control);
>  		val &= ~MALIDP_SE_SCALING_EN;
>  		malidp_hw_write(hwdev, val, se_control);
> @@ -147,12 +147,16 @@ static void malidp_atomic_commit_se_config(struct drm_crtc *crtc,
>  
>  	hwdev->hw->se_set_scaling_coeffs(hwdev, s, old_s);
>  	val = malidp_hw_read(hwdev, se_control);
> -	val |= MALIDP_SE_SCALING_EN | MALIDP_SE_ALPHA_EN;
> +	val |= MALIDP_SE_SCALING_EN;
>  
>  	val &= ~MALIDP_SE_ENH(MALIDP_SE_ENH_MASK);
>  	val |= s->enhancer_enable ? MALIDP_SE_ENH(3) : 0;
>  
> -	val |= MALIDP_SE_RGBO_IF_EN;
> +	if (s->scale_enable)
> +		val |= (MALIDP_SE_RGBO_IF_EN | MALIDP_SE_ALPHA_EN);
> +	else
> +		val &= ~((MALIDP_SE_RGBO_IF_EN | MALIDP_SE_ALPHA_EN));
> +
>  	malidp_hw_write(hwdev, val, se_control);
>  
>  	/* Set IN_SIZE & OUT_SIZE. */
> diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
> index 391d6ff..924f831 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.h
> +++ b/drivers/gpu/drm/arm/malidp_drv.h
> @@ -104,6 +104,8 @@ struct malidp_crtc_state {
>  int malidp_de_planes_init(struct drm_device *drm);
>  int malidp_crtc_init(struct drm_device *drm);
>  
> +void malidp_set_se_config_phase(struct malidp_se_config *s);
> +
>  bool malidp_hw_format_is_linear_only(u32 format);
>  bool malidp_hw_format_is_afbc_only(u32 format);
>  
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 1a36718..6f59c0e 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -497,13 +497,18 @@ static long malidp500_se_calc_mclk(struct malidp_hw_device *hwdev,
>  	return ret;
>  }
>  
> -static int malidp500_enable_memwrite(struct malidp_hw_device *hwdev,
> -				     dma_addr_t *addrs, s32 *pitches,
> -				     int num_planes, u16 w, u16 h, u32 fmt_id,
> -				     const s16 *rgb2yuv_coeffs)
> +static int malidp500_enable_memwrite(struct malidp_hw_device *hwdev, u16 w, u16 h,
> +				     struct malidp_mw_connector_state *mw_state)
>  {
> +
> +	int num_planes = mw_state->n_planes;
> +	dma_addr_t *addrs = mw_state->addrs;
> +	s32 *pitches = mw_state->pitches;
> +	u32 fmt_id = mw_state->format;
>  	u32 base = MALIDP500_SE_MEMWRITE_BASE;
>  	u32 de_base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
> +	const s16 *rgb2yuv_coeffs = !mw_state->rgb2yuv_initialized ?
> +					mw_state->rgb2yuv_coeffs : NULL;
>  
>  	/* enable the scaling engine block */
>  	malidp_hw_setbits(hwdev, MALIDP_SCALE_ENGINE_EN, de_base + MALIDP_DE_DISPLAY_FUNC);
> @@ -847,13 +852,18 @@ static long malidp550_se_calc_mclk(struct malidp_hw_device *hwdev,
>  	return ret;
>  }
>  
> -static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
> -				     dma_addr_t *addrs, s32 *pitches,
> -				     int num_planes, u16 w, u16 h, u32 fmt_id,
> -				     const s16 *rgb2yuv_coeffs)
> +static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev, u16 w, u16 h,
> +				     struct malidp_mw_connector_state *mw_state)
>  {
> +	int num_planes = mw_state->n_planes;
> +	bool scaling = mw_state->wb_scale_enable;
> +	dma_addr_t *addrs = mw_state->addrs;
> +	s32 *pitches = mw_state->pitches;
> +	u32 fmt_id = mw_state->format;
>  	u32 base = MALIDP550_SE_MEMWRITE_BASE;
>  	u32 de_base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
> +	const s16 *rgb2yuv_coeffs = !mw_state->rgb2yuv_initialized ?
> +					mw_state->rgb2yuv_coeffs : NULL;
>  
>  	/* enable the scaling engine block */
>  	malidp_hw_setbits(hwdev, MALIDP_SCALE_ENGINE_EN, de_base + MALIDP_DE_DISPLAY_FUNC);
> @@ -876,10 +886,18 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
>  		WARN(1, "Invalid number of planes");
>  	}
>  
> -	malidp_hw_write(hwdev, MALIDP_DE_H_ACTIVE(w) | MALIDP_DE_V_ACTIVE(h),
> -			MALIDP550_SE_MEMWRITE_OUT_SIZE);
> -	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
> -			  MALIDP550_SE_CONTROL);
> +	malidp_hw_clearbits(hwdev, MALIDP_SE_MEMWRITE_EN | MALIDP_SE_MEMWRITE_SCL_EN,
> +			    MALIDP550_SE_CONTROL);
> +
> +	if (scaling) {
> +		malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_SCL_EN,
> +				  MALIDP550_SE_CONTROL);
> +	} else {
> +		malidp_hw_write(hwdev, MALIDP_DE_H_ACTIVE(w) | MALIDP_DE_V_ACTIVE(h),
> +				MALIDP550_SE_MEMWRITE_OUT_SIZE);
> +		malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
> +				  MALIDP550_SE_CONTROL);
> +	}
>  
>  	if (rgb2yuv_coeffs) {
>  		int i;
> @@ -897,7 +915,8 @@ static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
>  {
>  	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
>  
> -	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
> +	malidp_hw_clearbits(hwdev,
> +			    MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN | MALIDP_SE_MEMWRITE_SCL_EN,
>  			    MALIDP550_SE_CONTROL);
>  	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
>  }
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 8352a2e..61ddcb5 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -85,6 +85,7 @@ enum malidp_scaling_coeff_set {
>  struct malidp_se_config {
>  	u8 scale_enable : 1;
>  	u8 enhancer_enable : 1;
> +	u8 wb_scale_enable : 1;
>  	u8 hcoeff : 3;
>  	u8 vcoeff : 3;
>  	u8 plane_src_id;
> @@ -94,6 +95,19 @@ struct malidp_se_config {
>  	u32 v_init_phase, v_delta_phase;
>  };
>  
> +#define to_mw_state(_state) (struct malidp_mw_connector_state *)(_state)
> +
> +struct malidp_mw_connector_state {
> +	struct drm_connector_state base;
> +	dma_addr_t addrs[2];
> +	s32 pitches[2];
> +	u8 format;
> +	u8 n_planes;
> +	bool rgb2yuv_initialized;
> +	const s16 *rgb2yuv_coeffs;
> +	bool wb_scale_enable;
> +};
> +
>  /* regmap features */
>  #define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
>  #define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
> @@ -206,9 +220,8 @@ struct malidp_hw {
>  	 * @param h - height of the output frame
>  	 * @param fmt_id - internal format ID of output buffer
>  	 */
> -	int (*enable_memwrite)(struct malidp_hw_device *hwdev, dma_addr_t *addrs,
> -			       s32 *pitches, int num_planes, u16 w, u16 h, u32 fmt_id,
> -			       const s16 *rgb2yuv_coeffs);
> +	int (*enable_memwrite)(struct malidp_hw_device *hwdev, u16 w, u16 h,
> +			       struct malidp_mw_connector_state *mw_state);
>  
>  	/*
>  	 * Disable the writing to memory of the next frame's content.
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 2865f7a..f1ad588 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -13,23 +13,12 @@
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_writeback.h>
> +#include <video/videomode.h>
>  
>  #include "malidp_drv.h"
>  #include "malidp_hw.h"
>  #include "malidp_mw.h"
>  
> -#define to_mw_state(_state) (struct malidp_mw_connector_state *)(_state)
> -
> -struct malidp_mw_connector_state {
> -	struct drm_connector_state base;
> -	dma_addr_t addrs[2];
> -	s32 pitches[2];
> -	u8 format;
> -	u8 n_planes;
> -	bool rgb2yuv_initialized;
> -	const s16 *rgb2yuv_coeffs;
> -};
> -
>  static int malidp_mw_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct drm_device *dev = connector->dev;
> @@ -126,19 +115,91 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  			       struct drm_connector_state *conn_state)
>  {
>  	struct malidp_mw_connector_state *mw_state = to_mw_state(conn_state);
> +	struct malidp_crtc_state *cs = to_malidp_crtc_state(crtc_state);
> +	struct malidp_se_config *s = &cs->scaler_config;
>  	struct malidp_drm *malidp = encoder->dev->dev_private;
>  	struct drm_framebuffer *fb;
> -	int i, n_planes;
> +	int i, n_planes, ret;
> +	struct malidp_hw_device *hwdev = malidp->dev;
> +	struct videomode vm;
> +	u32 h_upscale_factor = 0; /* U16.16 */
> +	u32 v_upscale_factor = 0; /* U16.16 */
> +
> +	s->wb_scale_enable = 0;
>  
>  	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
>  		return 0;
>  
> +
> +	/* 0s are the default for writeback_dest_w,h - so don't scale.
> +	 * The case where one of w,h is set but the other is 0 is meaningless
> +	 * so ignore it
> +	 */
> +	if (conn_state->writeback_dest_w && conn_state->writeback_dest_h) {
> +		if ((conn_state->writeback_dest_w != crtc_state->mode.hdisplay) ||
> +		    (conn_state->writeback_dest_h != crtc_state->mode.vdisplay)) {
> +			s->wb_scale_enable = 1;
> +			mw_state->wb_scale_enable = true;
> +		}
> +	}
> +
>  	fb = conn_state->writeback_job->fb;
> -	if ((fb->width != crtc_state->mode.hdisplay) ||
> -	    (fb->height != crtc_state->mode.vdisplay)) {
> -		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> -				fb->width, fb->height);
> -		return -EINVAL;
> +	if (s->wb_scale_enable) {
> +		if (s->scale_enable) {
> +			DRM_DEBUG_KMS("Attempting to scale on writeback while scaling a layer\n");
> +			return -EINVAL;
> +		}
> +
> +		s->input_w = crtc_state->mode.hdisplay;
> +		s->input_h = crtc_state->mode.vdisplay;
> +		s->output_w = conn_state->writeback_dest_w;
> +		s->output_h = conn_state->writeback_dest_h;
> +
> +		if (fb->width < s->output_w + conn_state->writeback_dest_x ||
> +		    fb->height < s->output_h + conn_state->writeback_dest_y) {
> +			DRM_DEBUG_KMS("Invalid framebuffer size %ux%u for writeback x,y,w,h %u,%u,%u,%u\n",
> +					fb->width, fb->height,
> +					conn_state->writeback_dest_x,
> +					conn_state->writeback_dest_y,
> +					s->output_w, s->output_h);
> +			return -EINVAL;
> +		}
> +
> +		if ((s->output_w > s->input_w) || (s->output_h > s->input_h)) {
> +			DRM_DEBUG_KMS("Upscaling on writeback is not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Convert crtc_[w|h] to U32.32, then divide by U16.16 src_[w|h]
> +		 * to get the U16.16 result.
> +		 */
> +		h_upscale_factor = div_u64((u64)s->output_w << 32,
> +					   (u32)s->input_w << 16);
> +		v_upscale_factor = div_u64((u64)s->output_h << 32,
> +					   (u32)s->input_h << 16);
> +
> +		/* enhancer is for upscaling */
> +		s->enhancer_enable = 0;
> +
> +		malidp_set_se_config_phase(s);
> +
> +		s->hcoeff = malidp_se_select_coeffs(h_upscale_factor);
> +		s->vcoeff = malidp_se_select_coeffs(v_upscale_factor);
> +
> +		drm_display_mode_to_videomode(&crtc_state->adjusted_mode, &vm);
> +		ret = hwdev->hw->se_calc_mclk(hwdev, s, &vm);
> +		if (ret < 0)
> +			return -EINVAL;
> +	}
> +
> +	else {
> +		if ((fb->width < crtc_state->mode.hdisplay + conn_state->writeback_dest_x) ||
> +		    (fb->height < crtc_state->mode.vdisplay + conn_state->writeback_dest_y)) {
> +			DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> +					fb->width, fb->height);
> +			return -EINVAL;
> +	       }
>  	}
>  
>  	if (fb->modifier) {
> @@ -163,6 +224,8 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  		struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, i);
>  		/* memory write buffers are never rotated */
>  		u8 alignment = malidp_hw_get_pitch_align(malidp->dev, 0);
> +		unsigned int cpp = fb->format->cpp[i];
> +		unsigned int pitch = fb->pitches[i];
>  
>  		if (fb->pitches[i] & (alignment - 1)) {
>  			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
> @@ -170,7 +233,9 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  			return -EINVAL;
>  		}
>  		mw_state->pitches[i] = fb->pitches[i];
> -		mw_state->addrs[i] = obj->paddr + fb->offsets[i];
> +		mw_state->addrs[i] = obj->paddr + fb->offsets[i] +
> +				     (conn_state->writeback_dest_y * pitch) +
> +				     (conn_state->writeback_dest_x * cpp);
>  	}
>  	mw_state->n_planes = n_planes;
>  
> @@ -257,13 +322,17 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
>  				     &mw_state->addrs[0],
>  				     mw_state->format);
>  
> +		if (mw_state->wb_scale_enable) {
> +			DRM_DEV_DEBUG_DRIVER(drm->dev,
> +					     "Scaling writeback to %ux%u\n",
> +					     conn_state->writeback_dest_w,
> +					     conn_state->writeback_dest_h);
> +		}
> +
>  		drm_writeback_queue_job(mw_conn, conn_state->writeback_job);
>  		conn_state->writeback_job = NULL;
> -		hwdev->hw->enable_memwrite(hwdev, mw_state->addrs,
> -					   mw_state->pitches, mw_state->n_planes,
> -					   fb->width, fb->height, mw_state->format,
> -					   !mw_state->rgb2yuv_initialized ?
> -					   mw_state->rgb2yuv_coeffs : NULL);
> +		hwdev->hw->enable_memwrite(hwdev, conn_state->writeback_dest_w,
> +					   conn_state->writeback_dest_h, mw_state);
>  		mw_state->rgb2yuv_initialized = !!mw_state->rgb2yuv_coeffs;
>  	} else {
>  		DRM_DEV_DEBUG_DRIVER(drm->dev, "Disable memwrite\n");
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index a3363f3..254aa98 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -73,6 +73,7 @@
>  #define   MALIDP_DISP_FUNC_CADJ		(1 << 4)
>  #define   MALIDP_DISP_FUNC_ILACED	(1 << 8)
>  #define   MALIDP_SCALE_ENGINE_EN	(1 << 16)
> +#define   MALIDP_SE_MEMWRITE_SCL_EN	(1 << 5)
>  #define   MALIDP_SE_MEMWRITE_EN		(2 << 5)
>  
>  /* register offsets for IRQ management */
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
