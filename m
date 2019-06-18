Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B23C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FA20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VE6Y+iEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfFRJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:29:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38678 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfFRJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:29:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so18497713edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygA4/btdGX30WaSq3l4uRN0XwEfMKYE5konUAh3dxDc=;
        b=VE6Y+iEjOXsLgL/EtksINVNRZmPkDOeK6bS+UqFVtBRAUWaq+rtj/XwO3UT+afh5Gw
         886EVzbjOo2QMSUL5DgmfyVOjAc2TvI6QoUabyEbBxydmovGBlHcqLbgrv5lbZUhC1B4
         5AV6NGijxmsB7KWqI4QnaibBUNaCXOZlzaU40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ygA4/btdGX30WaSq3l4uRN0XwEfMKYE5konUAh3dxDc=;
        b=HbfMXfcRMrUsr1gT8FkA4vBVk5NqYxp7bH+AKpvo0ChvUlJv9kwiPOMttfbzE08M7v
         wodNUeK2dbi/mPO8JSdBbXH7Cb9dLCzt4ILKevZD/LyLfdpW7SmyOipfkrNR+mKdrJ6g
         d5v/I9az1pckIT6KUA1lgiX2kP8PcOEV4mhQ6Pz2Ne0Oop/n3eglD3D+0zGPIZW4lNgN
         ObigAMrz0lJN0FQ4ksUq3MRQ7RFQM+gpp+gT5YzZ/mOnz/2C4AZjNFjum1RyGYJg9yup
         vJzBibbp2NAPoq5IH3eYO6JiabSPEzjgCwy4Mq4UuYtqbmqo1L1uhUMDooWEPzDwqJxF
         txgg==
X-Gm-Message-State: APjAAAX7AXar3hWrI5SldnfmNOCEnUm/APUkl9THtKT54ElxKOzXCuBG
        yEqDq9wsgGc1f3dSXidWYs0cNg==
X-Google-Smtp-Source: APXvYqyYrIlT1OnmP/pU/52IIO2CetQLJegQS/QZA9okb1cPanhH5ZCWwhMFpRkKXEp1CIMLo3GJ7w==
X-Received: by 2002:a50:ba09:: with SMTP id g9mr106173551edc.172.1560850147318;
        Tue, 18 Jun 2019 02:29:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e33sm4596534eda.83.2019.06.18.02.29.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:29:06 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:29:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <20190618092904.GQ12905@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:45:29PM -0300, Rodrigo Siqueira wrote:
> When vkms calls drm_universal_plane_init(), it sets 0 for the
> possible_crtcs parameter which works well for a single encoder and
> connector; however, this approach is not flexible and does not fit well
> for vkms. This commit adds an index parameter for vkms_plane_init()
> which makes code flexible and enables vkms to support other DRM features.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
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

Having to hard-code the index because for the crtc you need the planes,
but for the planes you need drm_crtc_index of their crtc is annoying, but
not really a better way :-/

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  }
>  
>  static int __init vkms_init(void)
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8d628d18105e..ad63dbe5e994 100644
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
> index 8cf40297cf56..3f8e8b53f3bb 100644
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
