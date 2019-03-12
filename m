Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87680C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F551206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FMzPEmHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCLLAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:00:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34355 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfCLLAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:00:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id a16so1909129edn.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNJ2ybNxx7uWACO3ww3ZRQP1C0/Z52aC1aU+GhIsXUw=;
        b=FMzPEmHfM3b0yW84eY5h+5XrpYYURtyM8WFZMOOiTnND+My8tsB1qe57OhD2QZ+0HI
         TQGfKqG8F7YOuJPWxw0LNRKV+OBlkP/EfxJdO/W2Df92oXM1m22y/w+bvTKKxQLi0F1f
         OW1T7QANrQhHD81y4xsTdlX47nKedyuM1JO8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UNJ2ybNxx7uWACO3ww3ZRQP1C0/Z52aC1aU+GhIsXUw=;
        b=jQNTz0Mto+PoOXa/Oes58Y84MlomxJIpvJJooUAOxHoXNvOFTU2lO9Dad+Ljx/jCIX
         CC8CQR2j3pKvPlmP0vyhk3dUpVhVuOY87npQLlXxkvoAPHOQzlJ7UxNtSn+SMgxOkh2x
         5hiOOlLZl6jy7tDGUlpq5mM80JfCllGWikG7I3fQRCp6vSS+8uNAtc8FDD0nE+YocuOh
         93tFoylm970MWLC/kkYKPgHEyU3Vzpk6myM2IiwpnBxSp86931zYM9O+YmWkgtyFKxSf
         Gih1v4/Vcqtc0ZQYWUwnMx+hp0g/XH38El08qfSY1/yrpm1GjTJZzM6Knt93IgcNCnJW
         Ch9A==
X-Gm-Message-State: APjAAAWGXnjEaO0usOT8uNQJCHcPEJwWvpqRgGXWGicm2qZRpbX8xZ2Y
        S0yCks2Zwg679kHzMJzeXIQ2Vg==
X-Google-Smtp-Source: APXvYqzlE6l2pN58Hfgtk/cyz7/EUOJSZox3Dd0XC8VU4x/UnYBsVCamH8b6ThBJFn+Ak7K+9UjiWw==
X-Received: by 2002:a50:b16c:: with SMTP id l41mr2917926edd.209.1552388447677;
        Tue, 12 Mar 2019 04:00:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b8sm1363825edt.34.2019.03.12.04.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:00:46 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:00:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic-helper: Validate pointer before dereference
Message-ID: <20190312110044.GA2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:01:20PM -0300, Rodrigo Siqueira wrote:
> The function disable_outputs() and
> drm_atomic_helper_commit_modeset_enables() tries to retrieve
> helper_private from the target CRTC, for dereferencing some operations.
> However, the current implementation does not check whether
> helper_private is null and, if not, if it has a valid pointer to a dpms
> and commit functions. This commit adds pointer validations before
> trying to dereference the dpms and commit function.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Please also adjust the kerneldoc for these functions. And I think the
patch subject can be improved, e.g. "Make ->atomic_enable/disable crtc
callbacks optional". Describe what you're trying to achieve in the
summary, not how you achieve it.
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 30 ++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 540a77a2ade9..fbeef7c461fc 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1028,14 +1028,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  
>  
>  		/* Right function depends upon target state. */
> -		if (new_crtc_state->enable && funcs->prepare)
> -			funcs->prepare(crtc);
> -		else if (funcs->atomic_disable)
> -			funcs->atomic_disable(crtc, old_crtc_state);
> -		else if (funcs->disable)
> -			funcs->disable(crtc);
> -		else
> -			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> +		if (funcs) {

I don't think making funcs optional is a good idea. If you have a crtc
with no functions implemented, it's not terribly useful.

Also making functions optional just here is not going to help if we still
require it everywhere else.
-Daniel

> +			if (new_crtc_state->enable && funcs->prepare)
> +				funcs->prepare(crtc);
> +			else if (funcs->atomic_disable)
> +				funcs->atomic_disable(crtc, old_crtc_state);
> +			else if (funcs->disable)
> +				funcs->disable(crtc);
> +			else if (funcs->dpms)
> +				funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> +		}
>  
>  		if (!(dev->irq_enabled && dev->num_crtcs))
>  			continue;
> @@ -1277,11 +1279,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		if (new_crtc_state->enable) {
>  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
>  					 crtc->base.id, crtc->name);
> -
> -			if (funcs->atomic_enable)
> -				funcs->atomic_enable(crtc, old_crtc_state);
> -			else
> -				funcs->commit(crtc);
> +			if (funcs) {
> +				if (funcs->atomic_enable)
> +					funcs->atomic_enable(crtc,
> +							     old_crtc_state);
> +				else if (funcs->atomic_enable)
> +					funcs->commit(crtc);
> +			}
>  		}
>  	}
>  
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
