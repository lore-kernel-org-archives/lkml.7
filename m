Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BD2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SSZO3wVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfCOLAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:00:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46026 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfCOLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:00:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so645127edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WZNvd6y0YLnfxfABLpCF0Z2TBSL5fmjzDtI59hFlnFA=;
        b=SSZO3wVvrRav+CCRVjODa1OBz6ahfVf5+/dSq7LNBUPnZfMRKl7Gjn1nTtzuW/X9QB
         AnJSRZSm5SIfdOby+VaOyKypXqnmOe7QAb6TLYTfn+UmwbrkkUpQWGP5soQn1kFvvmp2
         /wR2aYBgF2v7IMFgMxfIq0uSRCOO+7LE5LO4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WZNvd6y0YLnfxfABLpCF0Z2TBSL5fmjzDtI59hFlnFA=;
        b=TX28MgoOHWCxV/a2QaaLm+CehGYryOl++BKXm/ovKLfP+NRDhD2+sc/7xxQwAaLFIk
         qvD2AutFAkGcNHHgo75mLzBvA9O2bns9B2e5Desy4FtIv8KlBF+R2RI+HdhczfOyOyC8
         o4lX7/MnhlEtaTAk0YDZLbWTJAllT1XG2VOpnc27SvJvWvewuvAFUzoU387veekq4NLS
         Bw6tAAKmHzQLzAlhAzhN4DR8Szqr55kR9XF5P7U6egVUdg2Z+8yKQlRVk9v8l2/FY2HP
         Fs+krv0BlnirVdm4kTSYLE6Q2bcsScn0rL8HcO9VqXv0CJpusjngESQyL15YuKCMXaiY
         qyGQ==
X-Gm-Message-State: APjAAAW1ncG2/xxGMtsMuWe7Hax37lPR7nLNmg5OFRI1D/i+k8NnTcLo
        FAAZCoHkIsltn+Q8EPKkPjFQBA==
X-Google-Smtp-Source: APXvYqwOz0kyitcV/nO2NUl+JsJmZuqZRr1eY/xEQ8TQj3MNFvHndPpsvX2eNbjo7UFHeWAM+dDlRw==
X-Received: by 2002:a50:b4e6:: with SMTP id x35mr2304372edd.123.1552647634665;
        Fri, 15 Mar 2019 04:00:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p12sm344720ejr.58.2019.03.15.04.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 04:00:33 -0700 (PDT)
Date:   Fri, 15 Mar 2019 12:00:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/atomic-helper: Make atomic_enable/disable crtc
 callbacks optional
Message-ID: <20190315110031.GY2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:48:45PM -0300, Rodrigo Siqueira wrote:
> Allow atomic_enable and atomic_disable operations from
> drm_crtc_helper_funcs struct optional. With this, the target display
> drivers don't need to define a dummy function if they don't need one.
> 
> Changes since v2:
> * Don't make funcs optional
> * Update kerneldoc for atomic_enable/disable
> * Replace "if (funcs->atomic_enable)" by "if (funcs->commit)"
> * Improve commit message
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c      | 5 ++---
>  include/drm/drm_modeset_helper_vtables.h | 4 ++++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 540a77a2ade9..d506e13c2945 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1034,7 +1034,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  			funcs->atomic_disable(crtc, old_crtc_state);
>  		else if (funcs->disable)
>  			funcs->disable(crtc);
> -		else
> +		else if (funcs->dpms)
>  			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
>  
>  		if (!(dev->irq_enabled && dev->num_crtcs))
> @@ -1277,10 +1277,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		if (new_crtc_state->enable) {
>  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
>  					 crtc->base.id, crtc->name);
> -
>  			if (funcs->atomic_enable)
>  				funcs->atomic_enable(crtc, old_crtc_state);
> -			else
> +			else if (funcs->commit)
>  				funcs->commit(crtc);
>  		}
>  	}
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index cfb7be40bed7..ce4de6b1e444 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -418,6 +418,8 @@ struct drm_crtc_helper_funcs {
>  	 * Drivers can use the @old_crtc_state input parameter if the operations
>  	 * needed to enable the CRTC don't depend solely on the new state but
>  	 * also on the transition between the old state and the new state.
> +	 *
> +	 * This function is optional.
>  	 */
>  	void (*atomic_enable)(struct drm_crtc *crtc,
>  			      struct drm_crtc_state *old_crtc_state);
> @@ -441,6 +443,8 @@ struct drm_crtc_helper_funcs {
>  	 * parameter @old_crtc_state which could be used to access the old
>  	 * state. Atomic drivers should consider to use this one instead
>  	 * of @disable.
> +	 *
> +	 * This function is optional.
>  	 */
>  	void (*atomic_disable)(struct drm_crtc *crtc,
>  			       struct drm_crtc_state *old_crtc_state);
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
