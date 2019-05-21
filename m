Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58587C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1AB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="aWKTwUmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfEUObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:31:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44938 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfEUObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:31:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so20675125qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PyrGJVaDIDa8mPCeaWnN0LHsz5UJOyZm9YX3+HrlLJE=;
        b=aWKTwUmgpBFUh6N1mK0ydwpN0IMSzV8KFBCGc9S9QEgq2U6sboJ+AzaiUVzTIxCciv
         hvSN1dJ8Pxms1H3dAAV8uZIYhC6QSbluSEw923wvF8x3AftWbeSYJsmVOys3xbnHHl3j
         F79TxMhwdcHbaJvNqNb9hb4cR5Z0+rJKqFNz33Jt9kTFO9NuM8Ag5gJKqP7r6cujZA5Y
         kLc0u17+nwbBpRHvKwwxXZksGC6F5kJC+Tbq97vIPHI0Jjh0VQvHOD2xZOAV9F0hIW7c
         GvhxWIpUltgZjMNNwafxnN1W+ztT3O2Zow9NrZwW9THRyXzYmiQTnJnf0nMWQ2ZTwytD
         LJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PyrGJVaDIDa8mPCeaWnN0LHsz5UJOyZm9YX3+HrlLJE=;
        b=tn3inswHcYQyn8PSDfX0emomExFRciEOZq+lUxB9dJSoYifb4xJkT0rcS3ILwMr3TR
         J7k2wzUip9sSW5m/GGe+IXy8qNfa0NxrPO5DAkAJBogwBkmKQ349MgN3eA1RP84jxRfM
         5iiqJxzcljJO+aGK4wSpoZy4e54IhJO+vYfyzrWlEjN82Fc8hsvEELhQwzPblYCeNy6x
         m1WWuwCWeWOiJHwSx4OD51iurLFh64Y7H29PQFVuqhNciu5qHsOCCv1Ga5OsvbD1bhjO
         nEoHz9zEXRwS93H6XOGtm523dJoed/PnIY/KZEWglFuUgxtJCoSoCOectIFwEWbZ/5FF
         uy5w==
X-Gm-Message-State: APjAAAXZtGfjDDJciQV4wM+1W9LF5amKmIVC/ew4VjGPECFzuGdIWL2i
        QlT16oONYYEUr0oqGIjf/5c/Zp9nd8U=
X-Google-Smtp-Source: APXvYqznmeTbRfvbVfhyCQazVtnh+RM5RRICrQnjMja4GPu1+E6Fbw6oty1lE1j7VVDaksgBFgRLqw==
X-Received: by 2002:a0c:8b6f:: with SMTP id d47mr18658733qvc.32.1558449109339;
        Tue, 21 May 2019 07:31:49 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id x23sm8460011qto.20.2019.05.21.07.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 07:31:48 -0700 (PDT)
Date:   Tue, 21 May 2019 10:31:48 -0400
From:   Sean Paul <sean@poorly.run>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v4 03/11] drm: Add atomic variants for bridge
 enable/disable
Message-ID: <20190521143148.GB17077@art_vandelay>
References: <20190508160920.144739-1-sean@poorly.run>
 <CGME20190508160937epcas2p36170c1528618f4a187506e704f729951@epcas2p3.samsung.com>
 <20190508160920.144739-4-sean@poorly.run>
 <04aef058-fd7f-d37f-de84-6d05a66341bd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04aef058-fd7f-d37f-de84-6d05a66341bd@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:58:06AM +0200, Andrzej Hajda wrote:
> On 08.05.2019 18:09, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > This patch adds atomic variants for all of
> > pre_enable/enable/disable/post_disable bridge functions. These will be
> > called from the appropriate atomic helper functions. If the bridge
> > driver doesn't implement the atomic version of the function, we will
> > fall back to the vanilla implementation.
> >
> > Note that some drivers call drm_bridge_disable directly, and these cases
> > are not covered. It's up to the driver to decide whether to implement
> > both atomic_disable and disable, or if it's not necessary.
> >
> > Changes in v3:
> > - Added to the patchset
> > Changes in v4:
> > - Fix up docbook references (Daniel)
> >
> > Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-4-sean@poorly.run
> >
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> 
> 
> In general patch looks OK, ie. it correctly mimics old behavior with
> added atomic state.
> 
> However I have mixed feelings about it, because of the whole idea that
> order of enabling/disabling bridges in the chain is the same for all
> bridge chains is just incorrect. It depends on link types between
> bridges, there are also multi-in/out bridges which does not fit at all
> in this model. Due to this lack of flexibility developers either
> explicitly avoids drm_bridge->next chaining in favor of custom
> solutions, or worse they forcibly try to fit into this model by either
> violating hw specs, either by introducing hacks into the drivers.
> 
> The simplest solution for this would be to just let parent bridge calls
> children's callbacks explicitly (as exynos_drm_dsi and vc4_dsi do).

Yeah, I completely agree that the bridge chaining is worn out. I also agree that
letting the parent call the child would alleviate some of this. However I do
worry that relying on the driver to order the calls correctly might be too much
to ask. I think the pattern for handling this type of thing is to add bridge
helper functions that allow drivers to override the default behavior when a
tricky situation arises. This would allow us to break down the bridge midlayer
and more tightly integrate it into the atomic world.

> 
> But since it is not a blocker I will left it up to you :) :

That said, agree that it's out of scope for this project. If you like the above,
I can add a TODO item to the list in a follow-up patch.


> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thank you!

Sean

> 
> 
> Regards
> 
> Andrzej
> 
> 
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c |   8 +-
> >  drivers/gpu/drm/drm_bridge.c        | 110 ++++++++++++++++++++++++++++
> >  include/drm/drm_bridge.h            | 106 +++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index ccf01831f265..e8b7187a8494 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -995,7 +995,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> >  		 * Each encoder has at most one connector (since we always steal
> >  		 * it away), so we won't call disable hooks twice.
> >  		 */
> > -		drm_bridge_disable(encoder->bridge);
> > +		drm_atomic_bridge_disable(encoder->bridge, old_state);
> >  
> >  		/* Right function depends upon target state. */
> >  		if (funcs) {
> > @@ -1009,7 +1009,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> >  				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
> >  		}
> >  
> > -		drm_bridge_post_disable(encoder->bridge);
> > +		drm_atomic_bridge_post_disable(encoder->bridge, old_state);
> >  	}
> >  
> >  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> > @@ -1308,7 +1308,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> >  		 * Each encoder has at most one connector (since we always steal
> >  		 * it away), so we won't call enable hooks twice.
> >  		 */
> > -		drm_bridge_pre_enable(encoder->bridge);
> > +		drm_atomic_bridge_pre_enable(encoder->bridge, old_state);
> >  
> >  		if (funcs) {
> >  			if (funcs->atomic_enable)
> > @@ -1319,7 +1319,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> >  				funcs->commit(encoder);
> >  		}
> >  
> > -		drm_bridge_enable(encoder->bridge);
> > +		drm_atomic_bridge_enable(encoder->bridge, old_state);
> >  	}
> >  
> >  	drm_atomic_helper_commit_writebacks(dev, old_state);
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 138b2711d389..cba537c99e43 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -352,6 +352,116 @@ void drm_bridge_enable(struct drm_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL(drm_bridge_enable);
> >  
> > +/**
> > + * drm_atomic_bridge_disable - disables all bridges in the encoder chain
> > + * @bridge: bridge control structure
> > + * @state: atomic state being committed
> > + *
> > + * Calls &drm_bridge_funcs.atomic_disable (falls back on
> > + * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
> > + * starting from the last bridge to the first. These are called before calling
> > + * &drm_encoder_helper_funcs.atomic_disable
> > + *
> > + * Note: the bridge passed should be the one closest to the encoder
> > + */
> > +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> > +			       struct drm_atomic_state *state)
> > +{
> > +	if (!bridge)
> > +		return;
> > +
> > +	drm_atomic_bridge_disable(bridge->next, state);
> > +
> > +	if (bridge->funcs->atomic_disable)
> > +		bridge->funcs->atomic_disable(bridge, state);
> > +	else if (bridge->funcs->disable)
> > +		bridge->funcs->disable(bridge);
> > +}
> > +EXPORT_SYMBOL(drm_atomic_bridge_disable);
> > +
> > +/**
> > + * drm_atomic_bridge_post_disable - cleans up after disabling all bridges in the
> > + *				    encoder chain
> > + * @bridge: bridge control structure
> > + * @state: atomic state being committed
> > + *
> > + * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
> > + * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
> > + * starting from the first bridge to the last. These are called after completing
> > + * &drm_encoder_helper_funcs.atomic_disable
> > + *
> > + * Note: the bridge passed should be the one closest to the encoder
> > + */
> > +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> > +				    struct drm_atomic_state *state)
> > +{
> > +	if (!bridge)
> > +		return;
> > +
> > +	if (bridge->funcs->atomic_post_disable)
> > +		bridge->funcs->atomic_post_disable(bridge, state);
> > +	else if (bridge->funcs->post_disable)
> > +		bridge->funcs->post_disable(bridge);
> > +
> > +	drm_atomic_bridge_post_disable(bridge->next, state);
> > +}
> > +EXPORT_SYMBOL(drm_atomic_bridge_post_disable);
> > +
> > +/**
> > + * drm_atomic_bridge_pre_enable - prepares for enabling all bridges in the
> > + *				  encoder chain
> > + * @bridge: bridge control structure
> > + * @state: atomic state being committed
> > + *
> > + * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
> > + * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
> > + * starting from the last bridge to the first. These are called before calling
> > + * &drm_encoder_helper_funcs.atomic_enable
> > + *
> > + * Note: the bridge passed should be the one closest to the encoder
> > + */
> > +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> > +				  struct drm_atomic_state *state)
> > +{
> > +	if (!bridge)
> > +		return;
> > +
> > +	drm_atomic_bridge_pre_enable(bridge->next, state);
> > +
> > +	if (bridge->funcs->atomic_pre_enable)
> > +		bridge->funcs->atomic_pre_enable(bridge, state);
> > +	else if (bridge->funcs->pre_enable)
> > +		bridge->funcs->pre_enable(bridge);
> > +}
> > +EXPORT_SYMBOL(drm_atomic_bridge_pre_enable);
> > +
> > +/**
> > + * drm_atomic_bridge_enable - enables all bridges in the encoder chain
> > + * @bridge: bridge control structure
> > + * @state: atomic state being committed
> > + *
> > + * Calls &drm_bridge_funcs.atomic_enable (falls back on
> > + * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
> > + * starting from the first bridge to the last. These are called after completing
> > + * &drm_encoder_helper_funcs.atomic_enable
> > + *
> > + * Note: the bridge passed should be the one closest to the encoder
> > + */
> > +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> > +			      struct drm_atomic_state *state)
> > +{
> > +	if (!bridge)
> > +		return;
> > +
> > +	if (bridge->funcs->atomic_enable)
> > +		bridge->funcs->atomic_enable(bridge, state);
> > +	else if (bridge->funcs->enable)
> > +		bridge->funcs->enable(bridge);
> > +
> > +	drm_atomic_bridge_enable(bridge->next, state);
> > +}
> > +EXPORT_SYMBOL(drm_atomic_bridge_enable);
> > +
> >  #ifdef CONFIG_OF
> >  /**
> >   * of_drm_find_bridge - find the bridge corresponding to the device node in
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index d4428913a4e1..322801884814 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -237,6 +237,103 @@ struct drm_bridge_funcs {
> >  	 * The enable callback is optional.
> >  	 */
> >  	void (*enable)(struct drm_bridge *bridge);
> > +
> > +	/**
> > +	 * @atomic_pre_enable:
> > +	 *
> > +	 * This callback should enable the bridge. It is called right before
> > +	 * the preceding element in the display pipe is enabled. If the
> > +	 * preceding element is a bridge this means it's called before that
> > +	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
> > +	 * element is a &drm_encoder it's called right before the encoder's
> > +	 * &drm_encoder_helper_funcs.atomic_enable hook.
> > +	 *
> > +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
> > +	 * will not yet be running when this callback is called. The bridge must
> > +	 * not enable the display link feeding the next bridge in the chain (if
> > +	 * there is one) when this callback is called.
> > +	 *
> > +	 * Note that this function will only be invoked in the context of an
> > +	 * atomic commit. It will not be invoked from &drm_bridge_pre_enable. It
> > +	 * would be prudent to also provide an implementation of @pre_enable if
> > +	 * you are expecting driver calls into &drm_bridge_pre_enable.
> > +	 *
> > +	 * The @atomic_pre_enable callback is optional.
> > +	 */
> > +	void (*atomic_pre_enable)(struct drm_bridge *bridge,
> > +				  struct drm_atomic_state *state);
> > +
> > +	/**
> > +	 * @atomic_enable:
> > +	 *
> > +	 * This callback should enable the bridge. It is called right after
> > +	 * the preceding element in the display pipe is enabled. If the
> > +	 * preceding element is a bridge this means it's called after that
> > +	 * bridge's @atomic_enable or @enable function. If the preceding element
> > +	 * is a &drm_encoder it's called right after the encoder's
> > +	 * &drm_encoder_helper_funcs.atomic_enable hook.
> > +	 *
> > +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> > +	 * signals) feeding it is running when this callback is called. This
> > +	 * callback must enable the display link feeding the next bridge in the
> > +	 * chain if there is one.
> > +	 *
> > +	 * Note that this function will only be invoked in the context of an
> > +	 * atomic commit. It will not be invoked from &drm_bridge_enable. It
> > +	 * would be prudent to also provide an implementation of @enable if
> > +	 * you are expecting driver calls into &drm_bridge_enable.
> > +	 *
> > +	 * The enable callback is optional.
> > +	 */
> > +	void (*atomic_enable)(struct drm_bridge *bridge,
> > +			      struct drm_atomic_state *state);
> > +	/**
> > +	 * @atomic_disable:
> > +	 *
> > +	 * This callback should disable the bridge. It is called right before
> > +	 * the preceding element in the display pipe is disabled. If the
> > +	 * preceding element is a bridge this means it's called before that
> > +	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
> > +	 * is a &drm_encoder it's called right before the
> > +	 * &drm_encoder_helper_funcs.atomic_disable hook.
> > +	 *
> > +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> > +	 * signals) feeding it is still running when this callback is called.
> > +	 *
> > +	 * Note that this function will only be invoked in the context of an
> > +	 * atomic commit. It will not be invoked from &drm_bridge_disable. It
> > +	 * would be prudent to also provide an implementation of @disable if
> > +	 * you are expecting driver calls into &drm_bridge_disable.
> > +	 *
> > +	 * The disable callback is optional.
> > +	 */
> > +	void (*atomic_disable)(struct drm_bridge *bridge,
> > +			       struct drm_atomic_state *state);
> > +
> > +	/**
> > +	 * @atomic_post_disable:
> > +	 *
> > +	 * This callback should disable the bridge. It is called right after the
> > +	 * preceding element in the display pipe is disabled. If the preceding
> > +	 * element is a bridge this means it's called after that bridge's
> > +	 * @atomic_post_disable or @post_disable function. If the preceding
> > +	 * element is a &drm_encoder it's called right after the encoder's
> > +	 * &drm_encoder_helper_funcs.atomic_disable hook.
> > +	 *
> > +	 * The bridge must assume that the display pipe (i.e. clocks and timing
> > +	 * signals) feeding it is no longer running when this callback is
> > +	 * called.
> > +	 *
> > +	 * Note that this function will only be invoked in the context of an
> > +	 * atomic commit. It will not be invoked from &drm_bridge_post_disable.
> > +	 * It would be prudent to also provide an implementation of
> > +	 * @post_disable if you are expecting driver calls into
> > +	 * &drm_bridge_post_disable.
> > +	 *
> > +	 * The post_disable callback is optional.
> > +	 */
> > +	void (*atomic_post_disable)(struct drm_bridge *bridge,
> > +				    struct drm_atomic_state *state);
> >  };
> >  
> >  /**
> > @@ -314,6 +411,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
> >  void drm_bridge_pre_enable(struct drm_bridge *bridge);
> >  void drm_bridge_enable(struct drm_bridge *bridge);
> >  
> > +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> > +			       struct drm_atomic_state *state);
> > +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> > +				    struct drm_atomic_state *state);
> > +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> > +				  struct drm_atomic_state *state);
> > +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> > +			      struct drm_atomic_state *state);
> > +
> >  #ifdef CONFIG_DRM_PANEL_BRIDGE
> >  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> >  					u32 connector_type);
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
