Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1942DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8086205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T6H+R4uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfECHpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:45:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33676 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfECHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:45:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so4959875edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ht7ldCcnmY9plyEbS2W1qmDw5wTgWdvyppozEZpw7HQ=;
        b=T6H+R4uIAFzfIES2U8r1AYSGchQxdCJJ9vP7hGNw/sH4aCj9+LazKyJ6lxQg4NAGUH
         wzPBE9PO0FtRObyMQtrDkN/oqe3RZYV0JLoOQxG477ayiafc0gXywn+4C1TRs0rM+yIs
         IPdXxf9iwDIii6avW4RVgoTsguLPxs5/akSBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ht7ldCcnmY9plyEbS2W1qmDw5wTgWdvyppozEZpw7HQ=;
        b=FyfhVsiSCAyC+oyedDXMH36VlaC6f9b/hZSiegXL6Hfav9GO9fHGNBQQZN3uCl+NkL
         bI61/03LxjiXJRyOJsn09A1YQ2cwgX/S+WrqWGY8b6iZCJtxXt3RVOG4hOfRb+dfpP17
         GTBxymwgXqeGezZVXqf34ecYBu18n205BAGSkbu1GXqa54d2qMcQ0JGygdhlPzEGLkut
         0C0sNg3ibSChStlOOe7Za3VBO/9yXbQSw2jsqB0tNpVtMJJrotvMnUXi2/IREqAVU7lR
         OBHxnFP4EEkTawuL6P1ewrPwEghIuKr3eQUBHPuby+sT6P4uWQ3EBMa4kfWm6se2uza3
         g6Qg==
X-Gm-Message-State: APjAAAV5Nf04eUEzw0bho9uu/Z5iEknQjDPVbEyTDVbcdRWqvbDnorGe
        l7p0S0CylMcTtrIJvfUIcOyXoQ==
X-Google-Smtp-Source: APXvYqwed9WHleUr3fnpoYIigFukLNHMBVxremAL9tiDABDKd1r9lst5kmMB+3GnFWfOd3yylE0PwA==
X-Received: by 2002:a50:b835:: with SMTP id j50mr6526687ede.63.1556869543068;
        Fri, 03 May 2019 00:45:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b4sm396875edf.7.2019.05.03.00.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:45:41 -0700 (PDT)
Date:   Fri, 3 May 2019 09:45:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drm: Add atomic variants for bridge
 enable/disable
Message-ID: <20190503074539.GG3271@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20190502194956.218441-1-sean@poorly.run>
 <20190502194956.218441-4-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502194956.218441-4-sean@poorly.run>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:49:45PM -0400, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds atomic variants for all of
> pre_enable/enable/disable/post_disable bridge functions. These will be
> called from the appropriate atomic helper functions. If the bridge
> driver doesn't implement the atomic version of the function, we will
> fall back to the vanilla implementation.
> 
> Note that some drivers call drm_bridge_disable directly, and these cases
> are not covered. It's up to the driver to decide whether to implement
> both atomic_disable and disable, or if it's not necessary.
> 
> Changes in v3:
> - Added to the patchset
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c |   8 +-
>  drivers/gpu/drm/drm_bridge.c        | 110 +++++++++++++++++++++++++++
>  include/drm/drm_bridge.h            | 114 ++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 1f81ca8daad7..9d9e47276839 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -995,7 +995,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call disable hooks twice.
>  		 */
> -		drm_bridge_disable(encoder->bridge);
> +		drm_atomic_bridge_disable(encoder->bridge, old_state);
>  
>  		/* Right function depends upon target state. */
>  		if (funcs) {
> @@ -1009,7 +1009,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
>  		}
>  
> -		drm_bridge_post_disable(encoder->bridge);
> +		drm_atomic_bridge_post_disable(encoder->bridge, old_state);
>  	}
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> @@ -1308,7 +1308,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call enable hooks twice.
>  		 */
> -		drm_bridge_pre_enable(encoder->bridge);
> +		drm_atomic_bridge_pre_enable(encoder->bridge, old_state);
>  
>  		if (funcs) {
>  			if (funcs->atomic_enable)
> @@ -1319,7 +1319,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  				funcs->commit(encoder);
>  		}
>  
> -		drm_bridge_enable(encoder->bridge);
> +		drm_atomic_bridge_enable(encoder->bridge, old_state);
>  	}
>  
>  	drm_atomic_helper_commit_writebacks(dev, old_state);
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 138b2711d389..accccb586adf 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -352,6 +352,116 @@ void drm_bridge_enable(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_enable);
>  
> +/**
> + * drm_atomic_bridge_disable - disables all bridges in the encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_disable (falls back on
> + * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
> + * starting from the last bridge to the first. These are called before calling
> + * the encoder's prepare op.

Since this is for atomic, where &drm_encoder_helper_funcs.atomic_disable
is the recommened one, would be good to change that. Plus use the
hyperlinked form. Same for all the below.


> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	drm_atomic_bridge_disable(bridge->next, state);
> +
> +	if (bridge->funcs->atomic_disable)
> +		bridge->funcs->atomic_disable(bridge, state);
> +	else if (bridge->funcs->disable)
> +		bridge->funcs->disable(bridge);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_disable);
> +
> +/**
> + * drm_atomic_bridge_post_disable - cleans up after disabling all bridges in the
> + *				    encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
> + * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
> + * starting from the first bridge to the last. These are called after completing
> + * the encoder's prepare op.
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	if (bridge->funcs->atomic_post_disable)
> +		bridge->funcs->atomic_post_disable(bridge, state);
> +	else if (bridge->funcs->post_disable)
> +		bridge->funcs->post_disable(bridge);
> +
> +	drm_atomic_bridge_post_disable(bridge->next, state);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_post_disable);
> +
> +/**
> + * drm_bridge_pre_enable - prepares for enabling all bridges in the encoder
> + *			   chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.pre_enable (falls back on

atomic_pre_enable (I think all the others you've adjusted correctly).

> + * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
> + * starting from the last bridge to the first. These are called before calling
> + * the encoder's commit op.

&drm_encoder_helper_funcs.atomic_enable
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	drm_atomic_bridge_pre_enable(bridge->next, state);
> +
> +	if (bridge->funcs->atomic_pre_enable)
> +		bridge->funcs->atomic_pre_enable(bridge, state);
> +	else if (bridge->funcs->pre_enable)
> +		bridge->funcs->pre_enable(bridge);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_pre_enable);
> +
> +/**
> + * drm_atomic_bridge_enable - enables all bridges in the encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_enable (falls back on
> + * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
> + * starting from the first bridge to the last. These are called after completing
> + * the encoder's commit op.
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	if (bridge->funcs->atomic_enable)
> +		bridge->funcs->atomic_enable(bridge, state);
> +	else if (bridge->funcs->enable)
> +		bridge->funcs->enable(bridge);
> +
> +	drm_atomic_bridge_enable(bridge->next, state);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_enable);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index d4428913a4e1..86f436895c7b 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -237,6 +237,111 @@ struct drm_bridge_funcs {
>  	 * The enable callback is optional.
>  	 */
>  	void (*enable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @atomic_pre_enable:
> +	 *
> +	 * This callback should enable the bridge. It is called right before
> +	 * the preceding element in the display pipe is enabled. If the
> +	 * preceding element is a bridge this means it's called before that
> +	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
> +	 * element is a &drm_encoder it's called right before the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_enable,
> +	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
> +	 * &drm_encoder_helper_funcs.dpms hook.

I woulnd't mention the depracated (for atomic drivers) hooks anymore, i.e.
drop commit, dpms, prepare in all these texts. Also makes it more
readable.

> +	 *
> +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
> +	 * will not yet be running when this callback is called. The bridge must
> +	 * not enable the display link feeding the next bridge in the chain (if
> +	 * there is one) when this callback is called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_pre_enable. It
> +	 * would be prudent to also provide an implementation of @pre_enable if
> +	 * you are expecting driver calls into &drm_bridge_pre_enable.
> +	 *
> +	 * The @atomic_pre_enable callback is optional.
> +	 */
> +	void (*atomic_pre_enable)(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state);
> +
> +	/**
> +	 * @atomic_enable:
> +	 *
> +	 * This callback should enable the bridge. It is called right after
> +	 * the preceding element in the display pipe is enabled. If the
> +	 * preceding element is a bridge this means it's called after that
> +	 * bridge's @atomic_enable or @enable function. If the preceding element
> +	 * is a &drm_encoder it's called right after the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_enable,
> +	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
> +	 * &drm_encoder_helper_funcs.dpms hook.
> +	 *
> +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> +	 * signals) feeding it is running when this callback is called. This
> +	 * callback must enable the display link feeding the next bridge in the
> +	 * chain if there is one.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_enable. It
> +	 * would be prudent to also provide an implementation of @enable if
> +	 * you are expecting driver calls into &drm_bridge_enable.
> +	 *
> +	 * The enable callback is optional.
> +	 */
> +	void (*atomic_enable)(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state);
> +	/**
> +	 * @atomic_disable:
> +	 *
> +	 * This callback should disable the bridge. It is called right before
> +	 * the preceding element in the display pipe is disabled. If the
> +	 * preceding element is a bridge this means it's called before that
> +	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
> +	 * is a &drm_encoder it's called right before the
> +	 * &drm_encoder_helper_funcs.atomic_disable,
> +	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
> +	 * or &drm_encoder_helper_funcs.dpms hook.
> +	 *
> +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> +	 * signals) feeding it is still running when this callback is called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_disable. It
> +	 * would be prudent to also provide an implementation of @disable if
> +	 * you are expecting driver calls into &drm_bridge_disable.
> +	 *
> +	 * The disable callback is optional.
> +	 */
> +	void (*atomic_disable)(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state);
> +
> +	/**
> +	 * @atomic_post_disable:
> +	 *
> +	 * This callback should disable the bridge. It is called right after the
> +	 * preceding element in the display pipe is disabled. If the preceding
> +	 * element is a bridge this means it's called after that bridge's
> +	 * @atomic_post_disable or @post_disable function. If the preceding
> +	 * element is a &drm_encoder it's called right after the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_disable,
> +	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
> +	 * or &drm_encoder_helper_funcs.dpms hook.
> +	 *
> +	 * The bridge must assume that the display pipe (i.e. clocks and timing
> +	 * singals) feeding it is no longer running when this callback is
> +	 * called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_post_disable.
> +	 * It would be prudent to also provide an implementation of
> +	 * @post_disable if you are expecting driver calls into
> +	 * &drm_bridge_post_disable.
> +	 *
> +	 * The post_disable callback is optional.
> +	 */
> +	void (*atomic_post_disable)(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state);
>  };
>  
>  /**
> @@ -314,6 +419,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
>  
> +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state);
> +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state);
> +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state);
> +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state);
> +
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>  					u32 connector_type);
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

With the doc nits:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
