Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A4CC74A4D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F99208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U8rDjxBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGKIGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:06:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44354 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGKIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:06:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so4820736edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+SoPVgrSwxE+SD5Gka9UyJam9wb/yXmmLhho1t+jC0=;
        b=U8rDjxBEyYr0VStX/0LsjLJGKj8SE0LTIMUfqv51EN5aKz1VlbfBYme/xAXgm+VDfR
         u3YyU9LQo9CTcS6IECHF6m3g451JB08Ex1buQKY8yWz8kuqkYWTGM8tfph2yURTL5FgP
         +qHoU5xzobkIY3uU21JINa29BqEfAg9wOQiUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=D+SoPVgrSwxE+SD5Gka9UyJam9wb/yXmmLhho1t+jC0=;
        b=Gt5martlrKFlBn6390qBydzanEUBPQoKxr5ICE7Q1X+LCwZq7huzvJkUwzNF2aNaVn
         poKJVdIn46WWZ/Dk9aILXK/DXf2p8UdXVV07iY4pktGLxDWN2tx9WhzRN+titXlBzW6m
         80N5EFgzVaGtxZDeZgBHvJ4q5ZOpuX5VtGdUCxY8y+f5omxB4gleQIuwFlXzRKCxfHZC
         YXjmY/uaUOQtRQ5pEoXPPqPYZNp0KsidsJqCymIW3YLlMAZVqswQpWeDQgO+cvrkVnBo
         /MRj4DN0aeZAQlAXHRCSucAdsRMQ4AkEr+02QDO/FgkQhupBU2HiUMKUtPt07N7rRJgN
         PzkQ==
X-Gm-Message-State: APjAAAWLqlN02WLKtWBSOnQVwO5/PDXgSgMHSInpn6nhDgCjp4Virj7Q
        /k9J7lt2sqytq4MP1cRdqrVTVdk1
X-Google-Smtp-Source: APXvYqwwPFvkq2PUZ+PFqXzZjantxLKgPuScrjKnpQJBjeBOpMk26XzvnC9IezL+eLsKBuYBu3XC0g==
X-Received: by 2002:a50:ac07:: with SMTP id v7mr2067590edc.205.1562832395544;
        Thu, 11 Jul 2019 01:06:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k5sm1005815eja.41.2019.07.11.01.06.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:06:34 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:06:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] drm/vkms: Avoid assigning 0 for possible_crtc
Message-ID: <20190711080632.GF15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <d67849c62a8d8ace1a0af455998b588798a4c45f.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67849c62a8d8ace1a0af455998b588798a4c45f.1561491964.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:36:18PM -0300, Rodrigo Siqueira wrote:
> When vkms invoke drm_universal_plane_init(), it sets 0 for
> possible_crtcs parameter which means that planes can't be attached to
> any CRTC. It currently works due to some safeguard in the drm_crtc file;
> however, it is possible to identify the problem by trying to append a
> second connector. This patch fixes this issue by modifying
> vkms_plane_init() to accept an index parameter which makes the code a
> little bit more flexible and avoid set zero to possible_crtcs.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
>  drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
>  drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
>  drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index cc53ef88a331..966b3d653189 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -127,7 +127,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	dev->mode_config.preferred_depth = 24;
>  	dev->mode_config.helper_private = &vkms_mode_config_helpers;
>  
> -	return vkms_output_init(vkmsdev);
> +	return vkms_output_init(vkmsdev, 0);
>  }
>  
>  static int __init vkms_init(void)
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 12b4db7ac641..e2d1aa089dec 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -115,10 +115,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
>  			       int *max_error, ktime_t *vblank_time,
>  			       bool in_vblank_irq);
>  
> -int vkms_output_init(struct vkms_device *vkmsdev);
> +int vkms_output_init(struct vkms_device *vkmsdev, int index);
>  
>  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				  enum drm_plane_type type);
> +				  enum drm_plane_type type, int index);
>  
>  /* Gem stuff */
>  struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 56fb5c2a2315..fb1941a6522c 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -35,7 +35,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  	.get_modes    = vkms_conn_get_modes,
>  };
>  
> -int vkms_output_init(struct vkms_device *vkmsdev)
> +int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  {
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
> @@ -45,12 +45,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  	struct drm_plane *primary, *cursor = NULL;
>  	int ret;
>  
> -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> +	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
>  	if (IS_ERR(primary))
>  		return PTR_ERR(primary);
>  
>  	if (enable_cursor) {
> -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> +		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
>  		if (IS_ERR(cursor)) {
>  			ret = PTR_ERR(cursor);
>  			goto err_cursor;
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 0fceb6258422..18c630cfc485 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -176,7 +176,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
>  };
>  
>  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				  enum drm_plane_type type)
> +				  enum drm_plane_type type, int index)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	const struct drm_plane_helper_funcs *funcs;
> @@ -198,7 +198,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  		funcs = &vkms_primary_helper_funcs;
>  	}
>  
> -	ret = drm_universal_plane_init(dev, plane, 0,
> +	ret = drm_universal_plane_init(dev, plane, 1 << index,
>  				       &vkms_plane_funcs,
>  				       formats, nformats,
>  				       NULL, type, NULL);
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
