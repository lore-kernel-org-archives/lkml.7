Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2CFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C6D208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFGJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:46:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfFGJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:46:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE0D28;
        Fri,  7 Jun 2019 02:46:37 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306233F96A;
        Fri,  7 Jun 2019 02:48:17 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 83934682579; Fri,  7 Jun 2019 10:46:35 +0100 (BST)
Date:   Fri, 7 Jun 2019 10:46:35 +0100
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
Subject: Re: [PATCH 2/3] drm/komeda: Add split support for scaler
Message-ID: <20190607094635.GB4173@e110455-lin.cambridge.arm.com>
References: <20190520104411.6092-1-james.qian.wang@arm.com>
 <20190520104411.6092-3-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520104411.6092-3-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, May 20, 2019 at 11:44:47AM +0100, james qian wang (Arm Technology China) wrote:
> To achieve same caling effect compare with none split, the texel
> calculation need to use the same scaling ratio before split, so add
> "total_xxx" to pipeline to describe the hsize/vsize before split.
> Update pipeline and d71_scaler_update accordingly.
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 47 +++++++++++++++++--
>  .../drm/arm/display/komeda/komeda_pipeline.h  | 19 ++++++--
>  .../display/komeda/komeda_pipeline_state.c    | 21 ++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_plane.c |  8 ++--
>  .../arm/display/komeda/komeda_wb_connector.c  |  2 +-
>  5 files changed, 81 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 3266bd54c936..d101a5cc2766 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -642,23 +642,58 @@ static void d71_scaler_update(struct komeda_component *c,
>  
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize_in, st->vsize_in));
>  	malidp_write32(reg, SC_OUT_SIZE, HV_SIZE(st->hsize_out, st->vsize_out));
> +	malidp_write32(reg, SC_H_CROP, HV_CROP(st->left_crop, st->right_crop));
> +
> +	/* for right part, HW only sample the valid pixel which means the pixels
> +	 * in left_crop will be jumpped, and the first sample pixel is:
> +	 *
> +	 * dst_a = st->total_hsize_out - st->hsize_out + st->left_crop + 0.5;
> +	 *
> +	 * Then the corresponding texel in src is:
> +	 *
> +	 * h_delta_phase = st->total_hsize_in / st->total_hsize_out;
> +	 * src_a = dst_A * h_delta_phase;
> +	 *
> +	 * and h_init_phase is src_a deduct the real source start src_S;
> +	 *
> +	 * src_S = st->total_hsize_in - st->hsize_in;
> +	 * h_init_phase = src_a - src_S;
> +	 *
> +	 * And HW precision for the initial/delta_phase is 16:16 fixed point,
> +	 * the following is the simplified formula
> +	 */
> +	if (st->right_part) {
> +		u32 dst_a = st->total_hsize_out - st->hsize_out + st->left_crop;
> +
> +		if (st->en_img_enhancement)
> +			dst_a -= 1;
> +
> +		init_ph = ((st->total_hsize_in * (2 * dst_a + 1) -
> +			    2 * st->total_hsize_out * (st->total_hsize_in -
> +			    st->hsize_in)) << 15) / st->total_hsize_out;
> +	} else {
> +		init_ph = (st->total_hsize_in << 15) / st->total_hsize_out;
> +	}
>  
> -	init_ph = (st->hsize_in << 15) / st->hsize_out;
>  	malidp_write32(reg, SC_H_INIT_PH, init_ph);
>  
> -	delta_ph = (st->hsize_in << 16) / st->hsize_out;
> +	delta_ph = (st->total_hsize_in << 16) / st->total_hsize_out;
>  	malidp_write32(reg, SC_H_DELTA_PH, delta_ph);
>  
> -	init_ph = (st->vsize_in << 15) / st->vsize_out;
> +	init_ph = (st->total_vsize_in << 15) / st->vsize_out;
>  	malidp_write32(reg, SC_V_INIT_PH, init_ph);
>  
> -	delta_ph = (st->vsize_in << 16) / st->vsize_out;
> +	delta_ph = (st->total_vsize_in << 16) / st->vsize_out;
>  	malidp_write32(reg, SC_V_DELTA_PH, delta_ph);
>  
>  	ctrl = 0;
>  	ctrl |= st->en_scaling ? SC_CTRL_SCL : 0;
>  	ctrl |= st->en_alpha ? SC_CTRL_AP : 0;
>  	ctrl |= st->en_img_enhancement ? SC_CTRL_IENH : 0;
> +	/* If we use the hardware splitter we shouldn't set SC_CTRL_LS */
> +	if (st->en_split &&
> +	    state->inputs[0].component->id != KOMEDA_COMPONENT_SPLITTER)
> +		ctrl |= SC_CTRL_LS;
>  
>  	malidp_write32(reg, BLK_CONTROL, ctrl);
>  	malidp_write32(reg, BLK_INPUT_ID0, to_d71_input_id(&state->inputs[0]));
> @@ -716,10 +751,12 @@ static int d71_scaler_init(struct d71_dev *d71,
>  	}
>  
>  	scaler = to_scaler(c);
> -	set_range(&scaler->hsize, 4, d71->max_line_size);
> +	set_range(&scaler->hsize, 4, 2048);
>  	set_range(&scaler->vsize, 4, 4096);
>  	scaler->max_downscaling = 6;
>  	scaler->max_upscaling = 64;
> +	scaler->scaling_split_overlap = 8;
> +	scaler->enh_split_overlap = 1;
>  
>  	malidp_write32(c->reg, BLK_CONTROL, 0);
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index c92733736799..4e1cf8fd89bf 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -247,15 +247,22 @@ struct komeda_scaler {
>  	struct malidp_range hsize, vsize;
>  	u32 max_upscaling;
>  	u32 max_downscaling;
> +	u8 scaling_split_overlap; /* split overlap for scaling */
> +	u8 enh_split_overlap; /* split overlap for image enhancement */
>  };
>  
>  struct komeda_scaler_state {
>  	struct komeda_component_state base;
>  	u16 hsize_in, vsize_in;
>  	u16 hsize_out, vsize_out;
> +	u16 total_hsize_in, total_vsize_in;
> +	u16 total_hsize_out; /* total_xxxx are size before split */
> +	u16 left_crop, right_crop;
>  	u8 en_scaling : 1,
>  	   en_alpha : 1, /* enable alpha processing */
> -	   en_img_enhancement : 1;
> +	   en_img_enhancement : 1,
> +	   en_split : 1,
> +	   right_part; /* right part of split image */

Should right_part be a 1 bit value here, same as in komeda_data_flow_cfg ?

>  };
>  
>  struct komeda_compiz {
> @@ -323,11 +330,16 @@ struct komeda_data_flow_cfg {
>  	struct komeda_component_output input;
>  	u16 in_x, in_y, in_w, in_h;
>  	u32 out_x, out_y, out_w, out_h;
> +	u16 total_in_h, total_in_w;
> +	u16 total_out_w;
> +	u16 left_crop, right_crop, overlap;
>  	u32 rot;
>  	int blending_zorder;
>  	u8 pixel_blend_mode, layer_alpha;
>  	u8 needs_scaling : 1,
> -	   needs_img_enhancement : 1;
> +	   needs_img_enhancement : 1,
> +	   needs_split : 1,
> +	   right_part : 1; /* right part of display image if split enabled */
>  };
>  
>  /** struct komeda_pipeline_funcs */
> @@ -488,6 +500,7 @@ void komeda_pipeline_disable(struct komeda_pipeline *pipe,
>  void komeda_pipeline_update(struct komeda_pipeline *pipe,
>  			    struct drm_atomic_state *old_state);
>  
> -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow);
> +void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> +				   struct drm_framebuffer *fb);
>  
>  #endif /* _KOMEDA_PIPELINE_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index fcd34164b3c2..9657dbfe0210 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -489,11 +489,19 @@ komeda_scaler_validate(void *user,
>  	st->hsize_in = dflow->in_w;
>  	st->vsize_in = dflow->in_h;
>  	st->hsize_out = dflow->out_w;
> -	st->vsize_out = dflow->out_w;
> +	st->vsize_out = dflow->out_h;
> +	st->right_crop = dflow->right_crop;
> +	st->left_crop = dflow->left_crop;
> +	st->total_vsize_in = dflow->total_in_h;
> +	st->total_hsize_in = dflow->total_in_w;
> +	st->total_hsize_out = dflow->total_out_w;
> +
>  	st->en_scaling = dflow->needs_scaling;
>  	/* Enable alpha processing if the next stage needs the pixel alpha */
>  	st->en_alpha = dflow->pixel_blend_mode != DRM_MODE_BLEND_PIXEL_NONE;
>  	st->en_img_enhancement = dflow->needs_img_enhancement;
> +	st->en_split = dflow->needs_split;
> +	st->right_part = dflow->right_part;
>  
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
>  	komeda_component_set_output(&dflow->input, &scaler->base, 0);
> @@ -647,14 +655,23 @@ komeda_timing_ctrlr_validate(struct komeda_timing_ctrlr *ctrlr,
>  	return 0;
>  }
>  
> -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow)
> +void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> +				   struct drm_framebuffer *fb)
>  {
>  	u32 w = dflow->in_w;
>  	u32 h = dflow->in_h;
>  
> +	dflow->total_in_w = dflow->in_w;
> +	dflow->total_in_h = dflow->in_h;
> +	dflow->total_out_w = dflow->out_w;
> +
>  	if (drm_rotation_90_or_270(dflow->rot))
>  		swap(w, h);
>  
> +	/* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
> +	if (!fb->format->has_alpha)
> +		dflow->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
> +
>  	dflow->needs_scaling = (w != dflow->out_w) || (h != dflow->out_h);
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index aad766365bbb..75ef0e6c5d98 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -22,10 +22,7 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>  	memset(dflow, 0, sizeof(*dflow));
>  
>  	dflow->blending_zorder = st->normalized_zpos;
> -
> -	/* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
> -	dflow->pixel_blend_mode = fb->format->has_alpha ?
> -			st->pixel_blend_mode : DRM_MODE_BLEND_PIXEL_NONE;
> +	dflow->pixel_blend_mode = st->pixel_blend_mode;
>  	dflow->layer_alpha = st->alpha >> 8;
>  
>  	dflow->out_x = st->crtc_x;
> @@ -46,9 +43,10 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>  							fb->modifier));
>  		return -EINVAL;
>  	}
> +
>  	dflow->needs_img_enhancement = kplane_st->img_enhancement;
>  
> -	komeda_complete_data_flow_cfg(dflow);
> +	komeda_complete_data_flow_cfg(dflow, fb);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index eed521218ef3..20295291572f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -31,7 +31,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
>  	dflow->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
>  	dflow->rot = DRM_MODE_ROTATE_0;
>  
> -	komeda_complete_data_flow_cfg(dflow);
> +	komeda_complete_data_flow_cfg(dflow, fb);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 

Otherwise: Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
