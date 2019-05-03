Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355DC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8A4205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SeLvo/40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfECHvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:51:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45707 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECHvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:51:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so4927763edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=n7t/Kebxq6iBR4ADzVR7dHWOyJxGteqIN/GCSVQp2YY=;
        b=SeLvo/40fwEhRzzHx49prbQNpakn3iTVRxLWh1rs4eNJAqSdZBoQntnqIZ8/ftwGrf
         gv8EUYBDfj6xn1Mz58eSolh9VqKaxLjyVTy00ZndhmXLfJQMt4YPbygbDCvZVF4YrO01
         wUBF+9FVGMAfYAntwRD+2GoXmprjU9+kQGka0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=n7t/Kebxq6iBR4ADzVR7dHWOyJxGteqIN/GCSVQp2YY=;
        b=Fo1giUB+TaGqXa7+WPoomyDDDTJLtPWIpwcFi5UmDLF/3N1RUX8lnUX4x1k+IYewvf
         Jj7RSF4kYfHUb0Bo0GlcZNa2vhbGwJulMuwlma8VP4FFAtjYW+kNfkEAm0W4+qo7z94D
         LouQD6GVRYJWlFQfqhMpIORQdOn5o+QfQmBB2jhhUhGKREHw9VDQiTvWPabBVTSpWMPO
         EmQmSnarLlVoC/saGkZLvIndh9gGs4SiyR6NKtsoi4y7uKQ4OIRY3cxXRWrCZMOJ9/K7
         TyC9Mzh+MmlTBBfnZIfllQ8gaxPH4v8cka0UD166/JhlA9B7rsjr3l0eG3wcrEhpapyD
         Zh9Q==
X-Gm-Message-State: APjAAAVYR5z95eGOxVQ4Sna9LIV8a+E4CGqOKy7NePb4YIgQNTufrzJE
        tOchg4WB6WK4GFy5SM/Q2TL/xQ==
X-Google-Smtp-Source: APXvYqyTj17drs0o5htlkIel+wQvYQSusWSUXFYSO1d9G3a9EfThp39v1jl9vbA+s2pLrZQueKR0Sw==
X-Received: by 2002:a17:906:5c7:: with SMTP id t7mr4794756ejt.129.1556869893721;
        Fri, 03 May 2019 00:51:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y19sm388395edq.53.2019.05.03.00.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:51:32 -0700 (PDT)
Date:   Fri, 3 May 2019 09:51:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] drm: Add atomic variants of enable/disable to
 encoder helper funcs
Message-ID: <20190503075130.GH3271@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20190502194956.218441-1-sean@poorly.run>
 <20190502194956.218441-2-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502194956.218441-2-sean@poorly.run>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:49:43PM -0400, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds atomic_enable and atomic_disable callbacks to the
> encoder helpers. This will allow encoders to make informed decisions in
> their start-up/shutdown based on the committed state.
> 
> Aside from the new hooks, this patch also introduces the new signature
> for .atomic_* functions going forward. Instead of passing object state
> (well, encoders don't have atomic state, but let's ignore that), we pass
> the entire atomic state so the driver can inspect more than what's
> happening locally.
> 
> This is particularly important for the upcoming self refresh helpers.
> 
> Changes in v3:
> - Added patch to the set
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c      |  6 +++-
>  include/drm/drm_modeset_helper_vtables.h | 45 ++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 553415fe8ede..71cc7d6b0644 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1001,6 +1001,8 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		if (funcs) {
>  			if (new_conn_state->crtc && funcs->prepare)
>  				funcs->prepare(encoder);
> +			else if (funcs->atomic_disable)
> +				funcs->atomic_disable(encoder, old_state);

I'd put the atomic one first. The reason why ->disable here is later is
that ->disable has some really funky meaning in the old legacy crtc
helpers, and hence ->prepare was preferrable: Legacy ->disable also was
supposed to release resources (something we now do in
->atomic_destroy_state). See the huge NOTE: in the @disable kerneldoc.


>  			else if (funcs->disable)
>  				funcs->disable(encoder);
>  			else if (funcs->dpms)
> @@ -1309,7 +1311,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		drm_bridge_pre_enable(encoder->bridge);
>  
>  		if (funcs) {
> -			if (funcs->enable)
> +			if (funcs->atomic_enable)
> +				funcs->atomic_enable(encoder, old_state);
> +			else if (funcs->enable)
>  				funcs->enable(encoder);
>  			else if (funcs->commit)
>  				funcs->commit(encoder);
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 8f3602811eb5..de57fb40cb6e 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -675,6 +675,51 @@ struct drm_encoder_helper_funcs {
>  	enum drm_connector_status (*detect)(struct drm_encoder *encoder,
>  					    struct drm_connector *connector);
>  
> +	/**
> +	 * @atomic_disable:
> +	 *
> +	 * This callback should be used to disable the encoder. With the atomic
> +	 * drivers it is called before this encoder's CRTC has been shut off
> +	 * using their own &drm_crtc_helper_funcs.atomic_disable hook. If that
> +	 * sequence is too simple drivers can just add their own driver private
> +	 * encoder hooks and call them from CRTC's callback by looping over all
> +	 * encoders connected to it using for_each_encoder_on_crtc().
> +	 *
> +	 * This callback is a variant of @disable that provides the atomic state
> +	 * to the driver. It takes priority over @disable during atomic commits.
> +	 *
> +	 * This hook is used only by atomic helpers. Atomic drivers don't need
> +	 * to implement it if there's no need to disable anything at the encoder
> +	 * level. To ensure that runtime PM handling (using either DPMS or the
> +	 * new "ACTIVE" property) works @atomic_disable must be the inverse of
> +	 * @atomic_enable.
> +	 */

I'd add something like "For atomic drivers also consider @atomic_disable"
to the kerneldoc of @disable (before the NOTE: which is only relevant for
pre-atomic). Same for the enable side.

> +	void (*atomic_disable)(struct drm_encoder *encoder,
> +			       struct drm_atomic_state *state);
> +
> +	/**
> +	 * @atomic_enable:
> +	 *
> +	 * This callback should be used to enable the encoder. It is called
> +	 * after this encoder's CRTC has been enabled using their own
> +	 * &drm_crtc_helper_funcs.atomic_enable hook. If that sequence is
> +	 * too simple drivers can just add their own driver private encoder
> +	 * hooks and call them from CRTC's callback by looping over all encoders
> +	 * connected to it using for_each_encoder_on_crtc().
> +	 *
> +	 * This callback is a variant of @enable that provides the atomic state
> +	 * to the driver. It is called in place of @enable during atomic
> +	 * commits.

needs to be adjusted here for "takes priority".
> +	 *
> +	 * This hook is used only by atomic helpers, for symmetry with @disable.
> +	 * Atomic drivers don't need to implement it if there's no need to
> +	 * enable anything at the encoder level. To ensure that runtime PM
> +	 * handling (using either DPMS or the new "ACTIVE" property) works
> +	 * @enable must be the inverse of @disable for atomic drivers.
> +	 */
> +	void (*atomic_enable)(struct drm_encoder *encoder,
> +			      struct drm_atomic_state *state);
> +

With the nits:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	/**
>  	 * @disable:
>  	 *
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
