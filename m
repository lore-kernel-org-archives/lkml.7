Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE25C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAC21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="juUdJDhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfGEMZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:25:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGEMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:25:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so8086511edr.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sp6o/n6EyLOrj3/DcsUkjbmVbC7RVr0FqOl1AVMUQxE=;
        b=juUdJDhCXFnJ0I3tvrOBE6o+BNxVkxERdKLMu+waFpCNXRdetjSibdR8/MwI8NUeiZ
         zd1RWnNgguXBUeuoW6+0QaFuUos1KOMqXrt2uG1sj41V8EB2AdDwzsdhrdti2I56lg59
         NQFAOykAAoBiSkU9pnUa1fYe9EtGLW/58vYr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sp6o/n6EyLOrj3/DcsUkjbmVbC7RVr0FqOl1AVMUQxE=;
        b=a2xqG0h7epL6X/XjFlmGF7+j5+dDcfRK2DsjxVoZbWDRYVqRzlRb04sSlD7De0klcQ
         bex5uV4ygXvkA2w2cB8q5gn91k594V/WElEbE68+qM+lb0SVEHnn+cNIz41UGJxDYJY9
         IQtm+SMOELHKgHEw5rLv6TAXmkhAedKqwksc1GzRpE/whIGD5ZYa0vtT2XIZvdckZL2o
         F/PYqzS6CFmw4g816dr/dvLAeBPM4qeovye1DLTJvusLjRpCTkMqXL36+p3mctHc1Pej
         F05AuFUjpU/pRvvmQN/oWsxz/A60S9ylgNKfFWCGm/8w1RBlcz3fjVTOtrTFmoLXnigC
         V0rw==
X-Gm-Message-State: APjAAAWkXIftwBZ6kRiPKXsx8Os4GxyPj8tQk1VsQ5lYRdmc2BSTBnVc
        ditg2LOsPsDNbwaXx0GHGbHptg==
X-Google-Smtp-Source: APXvYqyrlGbmN8C47H4iFrm3hb1tSo+V6ad6lMSzqx49wvXnGtJpcxvu8AeEvgWOKwH8fQl+HYOEzA==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr4172335edr.233.1562329549795;
        Fri, 05 Jul 2019 05:25:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id rv16sm1694956ejb.79.2019.07.05.05.25.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 05:25:49 -0700 (PDT)
Date:   Fri, 5 Jul 2019 14:25:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH 2/2] drm/komeda: Computing layer_split and image_enhancer
 internally
Message-ID: <20190705122546.GO15868@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20190705114427.17456-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705114427.17456-1-james.qian.wang@arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:44:45AM +0000, james qian wang (Arm Technology China) wrote:
> For layer_split:
> Enable it if the scaling exceed the accept range of scaler.
> 
> For image_enhancer:
> Enable it if the scaling is a 2x+ scaling

Imo should be two patches. Aside from that (and with 0 knowledge about the
hw, just looking at this from a kms/atomic uapi pov):

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.h  |  3 ++-
>  .../arm/display/komeda/komeda_pipeline_state.c    | 15 ++++++++++++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  8 +-------
>  .../drm/arm/display/komeda/komeda_wb_connector.c  | 10 +---------
>  4 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index fc1b8613385e..a90bcbb3cb23 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -537,7 +537,8 @@ void komeda_pipeline_disable(struct komeda_pipeline *pipe,
>  void komeda_pipeline_update(struct komeda_pipeline *pipe,
>  			    struct drm_atomic_state *old_state);
>  
> -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> +void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
> +				   struct komeda_data_flow_cfg *dflow,
>  				   struct drm_framebuffer *fb);
>  
>  #endif /* _KOMEDA_PIPELINE_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 2b415ef2b7d3..709870bdaa4f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -784,9 +784,11 @@ komeda_timing_ctrlr_validate(struct komeda_timing_ctrlr *ctrlr,
>  	return 0;
>  }
>  
> -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> +void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
> +				   struct komeda_data_flow_cfg *dflow,
>  				   struct drm_framebuffer *fb)
>  {
> +	struct komeda_scaler *scaler = layer->base.pipeline->scalers[0];
>  	u32 w = dflow->in_w;
>  	u32 h = dflow->in_h;
>  
> @@ -803,6 +805,17 @@ void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
>  
>  	dflow->en_scaling = (w != dflow->out_w) || (h != dflow->out_h);
>  	dflow->is_yuv = fb->format->is_yuv;
> +
> +	/* try to enable image enhancer if it is a 2x+ upscaling */
> +	dflow->en_img_enhancement = dflow->out_w >= 2 * w ||
> +				    dflow->out_h >= 2 * h;
> +
> +	/* try to enable split if scaling exceed the scaler's acceptable
> +	 * input/output range.
> +	 */
> +	if (dflow->en_scaling && scaler)
> +		dflow->en_split = !in_range(&scaler->hsize, dflow->in_w) ||
> +				  !in_range(&scaler->hsize, dflow->out_w);
>  }
>  
>  static bool merger_is_available(struct komeda_pipeline *pipe,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 5bb8553cc117..c095af154216 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -18,7 +18,6 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>  			    struct komeda_data_flow_cfg *dflow)
>  {
>  	struct komeda_plane *kplane = to_kplane(st->plane);
> -	struct komeda_plane_state *kplane_st = to_kplane_st(st);
>  	struct drm_framebuffer *fb = st->fb;
>  	const struct komeda_format_caps *caps = to_kfb(fb)->format_caps;
>  	struct komeda_pipeline *pipe = kplane->layer->base.pipeline;
> @@ -57,10 +56,7 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>  		return -EINVAL;
>  	}
>  
> -	dflow->en_img_enhancement = !!kplane_st->img_enhancement;
> -	dflow->en_split = !!kplane_st->layer_split;
> -
> -	komeda_complete_data_flow_cfg(dflow, fb);
> +	komeda_complete_data_flow_cfg(kplane->layer, dflow, fb);
>  
>  	return 0;
>  }
> @@ -175,8 +171,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  
>  	old = to_kplane_st(plane->state);
>  
> -	new->img_enhancement = old->img_enhancement;
> -
>  	return &new->base;
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index bb8a61f6e9a4..617e1f7b8472 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -13,7 +13,6 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
>  			 struct komeda_crtc_state *kcrtc_st,
>  			 struct komeda_data_flow_cfg *dflow)
>  {
> -	struct komeda_scaler *scaler = wb_layer->base.pipeline->scalers[0];
>  	struct drm_framebuffer *fb = conn_st->writeback_job->fb;
>  
>  	memset(dflow, 0, sizeof(*dflow));
> @@ -28,14 +27,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
>  	dflow->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
>  	dflow->rot = DRM_MODE_ROTATE_0;
>  
> -	komeda_complete_data_flow_cfg(dflow, fb);
> -
> -	/* if scaling exceed the acceptable scaler input/output range, try to
> -	 * enable split.
> -	 */
> -	if (dflow->en_scaling && scaler)
> -		dflow->en_split = !in_range(&scaler->hsize, dflow->in_w) ||
> -				  !in_range(&scaler->hsize, dflow->out_w);
> +	komeda_complete_data_flow_cfg(wb_layer, dflow, fb);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
