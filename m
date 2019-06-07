Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC8C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE3208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KlZS2HiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfFGHkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:40:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39934 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:40:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so1644791edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIFP2DYtX9Gl8U6x7V5zWoqYM6apBAgsstaP/BgvhgE=;
        b=KlZS2HiGz0OexPES4/ehlB6xYnxIzO6a9O1KU8ivBrcX6+i1omdzgtehQXcvdaJq33
         aIOXmbI6Q8rL77ukFROgIIMvb7Q3EvYH5ak+fKaNYXeL75S0CPwKxNhtMShtkPDhTBHU
         xRPVOu+pZjrpJ5nY1mJXbk9K8g11r3iIMmnB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AIFP2DYtX9Gl8U6x7V5zWoqYM6apBAgsstaP/BgvhgE=;
        b=cyZ1yysSfgkMGT7esd6yRcBulpGSBv9KwmXB0Ot1T+WCOZLhrh8Ovz3UlLaw75k35w
         mNrfZIRW+cl3YPk7AteqMeUP5Ibw0kEUv2C4SuyAaXvxvzcGgyHl1X2SG0nvQ2zrJqN+
         SsJlN8YmW9NyaxzMbzpgU+9VwtHltAsF5x3YZnphQASetWEnxQSv+OjryoQp+RSFcF1X
         ecthEohEvDhjgkfkNzdxAzzHQsb+Bh0R6FfUsSaO3tVFBM6f3FU1mo3pMttVv50spP+t
         LSxYo+4xSbQmkjCdkkcjrmVjmVIVsCsPu8Kwk7zEb/iUro79KFcB+essNiYfQp9Q8K8L
         eXaA==
X-Gm-Message-State: APjAAAXvvvCgy1REzSYpiW6Djq5PFLdZF9DmFTuYihWSCkhvqVCnHEwu
        bsvrJKo62oneSc6FF7ZigolPvA==
X-Google-Smtp-Source: APXvYqz9EuA+ClFQHUZhAv22wU+ejS2Fs0cp2Ablw14R/rImGcbPYjyriULZzdd7uAM4i9PAiA4Dvw==
X-Received: by 2002:a50:9871:: with SMTP id h46mr36057994edb.69.1559893201061;
        Fri, 07 Jun 2019 00:40:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 17sm319179edu.21.2019.06.07.00.39.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:39:59 -0700 (PDT)
Date:   Fri, 7 Jun 2019 09:39:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <20190607073957.GB21222@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:40:38PM -0300, Rodrigo Siqueira wrote:
> When vkms calls drm_universal_plane_init(), it sets 0 for the
> possible_crtcs parameter which works well for a single encoder and
> connector; however, this approach is not flexible and does not fit well
> for vkms. This commit adds an index parameter for vkms_plane_init()
> which makes code flexible and enables vkms to support other DRM features.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

I think a core patch to WARN_ON if this is NULL would be good. Since
that's indeed a bit broken ... We'd need to check all callers to make sure
there's not other such bugs anywhere ofc.
-Daniel

> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
>  drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
>  drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
>  drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 738dd6206d85..92296bd8f623 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -92,7 +92,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	dev->mode_config.max_height = YRES_MAX;
>  	dev->mode_config.preferred_depth = 24;
>  
> -	return vkms_output_init(vkmsdev);
> +	return vkms_output_init(vkmsdev, 0);
>  }
>  
>  static int __init vkms_init(void)
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 81f1cfbeb936..e81073dea154 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -113,10 +113,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
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
> index 3b162b25312e..1442b447c707 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -36,7 +36,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>  	.get_modes    = vkms_conn_get_modes,
>  };
>  
> -int vkms_output_init(struct vkms_device *vkmsdev)
> +int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  {
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
> @@ -46,12 +46,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
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
> index 0e67d2d42f0c..20ffc52f9194 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -168,7 +168,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
>  };
>  
>  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				  enum drm_plane_type type)
> +				  enum drm_plane_type type, int index)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	const struct drm_plane_helper_funcs *funcs;
> @@ -190,7 +190,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
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
