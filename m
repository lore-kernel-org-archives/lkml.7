Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B35C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080FD218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XZHHbEsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGCKB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:01:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36938 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGCKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:01:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so1482599eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSerdf2DO7Omic2w+oNZyPee/VO/jfA+Kk59Tlp7L3M=;
        b=XZHHbEshRHyinFuyW6TPlL33umZPDibfUV4mNEG7Ilmf0G6HIbH/4SNKjbWu5TnJn7
         A8qZBFnh9rgDFhSdgtkm0dunXHM5/55EFXVy6XZfEKQcbuPDR4xdEMcHYLByNWJXNns6
         IjlMx+mXyBCOxNexUV8S9todbAhrW2dznldDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aSerdf2DO7Omic2w+oNZyPee/VO/jfA+Kk59Tlp7L3M=;
        b=YDR2WnSxn98xiVHY6L2iCCj3yVb1uDyCg9myBFx2bB3SrILKRd72yHVq99UstULiJJ
         npIc1HH7iTHL9JDlUNpUb2d1K4xaaVDTIidOsQK/gEU0GgevOHcs4t0rZDA+LN2AytOW
         zedRZA3azljiYRNqqO5NBleTzF+Q6QzgATArLxaJgoFbsstfQAORrlMN4HhJsFZtBgiG
         VSYlzniGQYJI4xgBVIx77doRUramIwhK0DALPrZJDRdT0SNMOLcyGZ24suwea0SeBZnR
         KwYkVgcn5PoBqTHZKVJl4eTV9tsB7MDMimT/EWMKZkSKRKYednxYCBCPwRazgdLBmh2c
         Xefg==
X-Gm-Message-State: APjAAAXLV+I9bJ6HuDzukZSZ38M3FUf/zQJq94tx5RQaOLi53uWNpmFA
        vyjuuTNLi3lf9Y7jtOewCXHWxg==
X-Google-Smtp-Source: APXvYqzT18OCU2y0XM+rXVAOV95cRRI8IZfUaElhsUGDU0cOAnnDhXYeIyzKjKGCVkM2DuuolQu3lw==
X-Received: by 2002:a50:b107:: with SMTP id k7mr42238866edd.193.1562148113780;
        Wed, 03 Jul 2019 03:01:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t13sm540506edd.13.2019.07.03.03.01.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 03:01:53 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:01:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds VRR support
Message-ID: <20190703100149.GF15868@phenom.ffwll.local>
Mail-Followup-To: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:26:16AM +0000, Lowry Li (Arm Technology China) wrote:
> Adds a new drm property "vrr" and "vrr_enable" and implemented
> the set/get functions, through which userspace could set vfp
> data to komeda.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c |  6 +++
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 62 ++++++++++++++++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    | 12 +++++
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  4 +-
>  4 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index ed3f273..c1355f5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1065,6 +1065,7 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
>  				    struct komeda_component_state *state)
>  {
>  	struct drm_crtc_state *crtc_st = state->crtc->state;
> +	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(crtc_st);
>  	struct drm_display_mode *mode = &crtc_st->adjusted_mode;
>  	u32 __iomem *reg = c->reg;
>  	u32 hactive, hfront_porch, hback_porch, hsync_len;
> @@ -1102,6 +1103,9 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
>  		value |= BS_CTRL_DL;
>  	}
>  
> +	if (kcrtc_st->en_vrr)
> +		malidp_write32_mask(reg, BS_VINTERVALS, 0x3FFF, kcrtc_st->vfp);
> +
>  	malidp_write32(reg, BLK_CONTROL, value);
>  }
>  
> @@ -1171,6 +1175,8 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
>  	ctrlr = to_ctrlr(c);
>  
>  	ctrlr->supports_dual_link = true;
> +	ctrlr->supports_vrr = true;
> +	set_range(&ctrlr->vfp_range, 0, 0x3FF);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 4f580b0..3744e6d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -467,6 +467,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc)
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
>  	if (state) {
> +		state->vfp = 0;
> +		state->en_vrr = 0;
>  		crtc->state = &state->base;
>  		crtc->state->crtc = crtc;
>  	}
> @@ -487,6 +489,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc)
>  	new->affected_pipes = old->active_pipes;
>  	new->clock_ratio = old->clock_ratio;
>  	new->max_slave_zorder = old->max_slave_zorder;
> +	new->vfp = old->vfp;
> +	new->en_vrr = old->en_vrr;
>  
>  	return &new->base;
>  }
> @@ -525,6 +529,30 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
>  
>  	if (property == kcrtc->clock_ratio_property) {
>  		*val = kcrtc_st->clock_ratio;
> +	} else if (property == kcrtc->vrr_property) {
> +		*val = kcrtc_st->vfp;
> +	} else if (property == kcrtc->vrr_enable_property) {
> +		*val = kcrtc_st->en_vrr;
> +	} else {
> +		DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int komeda_crtc_atomic_set_property(struct drm_crtc *crtc,
> +					   struct drm_crtc_state *state,
> +					   struct drm_property *property,
> +					   uint64_t val)
> +{
> +	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
> +	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(state);
> +
> +	if (property == kcrtc->vrr_property) {
> +		kcrtc_st->vfp = val;
> +	} else if (property == kcrtc->vrr_enable_property) {
> +		kcrtc_st->en_vrr = val;
>  	} else {
>  		DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
>  		return -EINVAL;
> @@ -544,6 +572,7 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
>  	.enable_vblank		= komeda_crtc_vblank_enable,
>  	.disable_vblank		= komeda_crtc_vblank_disable,
>  	.atomic_get_property	= komeda_crtc_atomic_get_property,
> +	.atomic_set_property	= komeda_crtc_atomic_set_property,
>  };
>  
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> @@ -613,6 +642,35 @@ static int komeda_crtc_create_slave_planes_property(struct komeda_crtc *kcrtc)
>  	return 0;
>  }
>  
> +static int komeda_crtc_create_vrr_property(struct komeda_crtc *kcrtc)
> +{
> +	struct drm_crtc *crtc = &kcrtc->base;
> +	struct drm_property *prop;
> +	struct komeda_timing_ctrlr *ctrlr = kcrtc->master->ctrlr;
> +
> +	if (!ctrlr->supports_vrr)
> +		return 0;
> +
> +	prop = drm_property_create_range(crtc->dev, DRM_MODE_PROP_ATOMIC, "vrr",
> +					 ctrlr->vfp_range.start,
> +					 ctrlr->vfp_range.end);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&crtc->base, prop, 0);
> +	kcrtc->vrr_property = prop;
> +
> +	prop = drm_property_create_bool(crtc->dev, DRM_MODE_PROP_ATOMIC,
> +					"enable_vrr");

Uh, what exactly are you doing reinventing uapi properties that we already
standardized?

> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&crtc->base, prop, 0);
> +	kcrtc->vrr_enable_property = prop;
> +
> +	return 0;
> +}
> +
>  static struct drm_plane *
>  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
>  {
> @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
>  	if (err)
>  		return err;
>  
> +	err = komeda_crtc_create_vrr_property(kcrtc);
> +	if (err)
> +		return err;
> +
>  	return err;
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index dc1d436..d0cf838 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -98,6 +98,12 @@ struct komeda_crtc {
>  
>  	/** @slave_planes_property: property for slaves of the planes */
>  	struct drm_property *slave_planes_property;

And this seems to not be the first time this happened. Looking at komeda
with a quick git grep on properties you've actually accumulated quite a
pile of such driver properties already. Where's the userspace for this?
Where's the uapi discussions for this stuff? Where's the igt tests for
this (yes a bunch are after we agreed to have testcases for this).

I know that in the past we've been somewhat sloppy properties, but that
was a mistake and we've cranked down on this hard. Probably need to fix
this with a pile of reverts and start over.
-Daniel

> +
> +	/** @vrr_property: property for variable refresh rate */
> +	struct drm_property *vrr_property;
> +
> +	/** @vrr_enable_property: property for enable/disable the vrr */
> +	struct drm_property *vrr_enable_property;
>  };
>  
>  /**
> @@ -126,6 +132,12 @@ struct komeda_crtc_state {
>  
>  	/** @max_slave_zorder: the maximum of slave zorder */
>  	u32 max_slave_zorder;
> +
> +	/** @vfp: the value of vertical front porch */
> +	u32 vfp;
> +
> +	/** @en_vrr: enable status of variable refresh rate */
> +	u8 en_vrr : 1;
>  };
>  
>  /** struct komeda_kms_dev - for gather KMS related things */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 00e8083..66d7664 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -336,7 +336,9 @@ struct komeda_improc_state {
>  /* display timing controller */
>  struct komeda_timing_ctrlr {
>  	struct komeda_component base;
> -	u8 supports_dual_link : 1;
> +	u8 supports_dual_link : 1,
> +	   supports_vrr : 1;
> +	struct malidp_range vfp_range;
>  };
>  
>  struct komeda_timing_ctrlr_state {
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
