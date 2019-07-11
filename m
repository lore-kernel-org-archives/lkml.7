Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE59AC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B998420872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j3ssSlpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGKITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:19:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33452 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfGKITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:19:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so4894763edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3/3DeARjpqDKrOiocguflEWJfLgc8iajX+V50d8eXY=;
        b=j3ssSlptUwsg/Ru4XoPIm/vhppsSq9rWUJxH/pfzzVK0TcYmRRWLuGW1XQms8l9KOH
         7xaFI8UVwDiBmt2gROE6dEvp/FN1DId7smdCHJgQG9GDXhVINqKW+oESG9li+45FZxCA
         8j83NyZQSy72xcr/dsbR6YrGkjZw/k6aS9V7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=q3/3DeARjpqDKrOiocguflEWJfLgc8iajX+V50d8eXY=;
        b=FKcAarQbn/5aIul5VNxFMQLMfSAclwNwYFCcAo64vjDt+dtBHPIF9pVpJiU1JeNvVn
         LH+W6+eY0sP6YCqxkb03XrNS7paRZlKBBdLSJOGUCeuHRSXJSodz3CMiHg8fJqPX0lik
         +d72657cY8bRz1Z55WrbxDLqoimuIo7YI7EbRvcJ4fA5Xz1FiK62E0tPAoRt7oGQHsSN
         nn5a08ebE355muv5QeAwEJ6VlEtcqm+aYb5lgiDvf/zMDY6ayevYaUnrM/uN4rAJPwB+
         cf0wb0aI1Hj6RTdPB6PjGY9DHf+AI4sUNGLfwZlr/jvLF8nM/CUYUNSPruIwve0p66p5
         8i0w==
X-Gm-Message-State: APjAAAXedqxTthC2j8RcMcEFRSBfQVnEP4ai4KzMJCpINQbzdBXNR+ps
        EQDhl7qTTUHG0f6YSZ9d2xw=
X-Google-Smtp-Source: APXvYqyBQ+5xwEWc3sxBQXdac27XI2zZ8XzAl5ZBTEUm5Gz/1nLeqTVYgGOVSifhdFbLS0YSjzaJGg==
X-Received: by 2002:a05:6402:14cf:: with SMTP id f15mr2074419edx.255.1562833156233;
        Thu, 11 Jul 2019 01:19:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n16sm1348746edo.81.2019.07.11.01.19.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:19:15 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:19:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/5] drm/vkms: Decouple crc operations from composer
Message-ID: <20190711081913.GH15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <6e8a03dc7c666ee998ee36172a96cff39f8dd46d.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8a03dc7c666ee998ee36172a96cff39f8dd46d.1561491964.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:37:58PM -0300, Rodrigo Siqueira wrote:
> In the vkms_composer.c, some of the functions related to CRC and compose
> have interdependence between each other. This patch reworks some
> functions inside vkms_composer to make crc and composer computation
> decoupled.
> 
> This patch is preparation work for making vkms able to support new
> features.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 49 ++++++++++++++++------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index eb7ea8be1f98..51a270514219 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -105,35 +105,31 @@ static void compose_cursor(struct vkms_composer *cursor_composer,
>  	      primary_composer, cursor_composer);
>  }
>  
> -static uint32_t _vkms_get_crc(struct vkms_composer *primary_composer,
> -			      struct vkms_composer *cursor_composer)
> +static int compose_planes(void **vaddr_out,
> +			  struct vkms_composer *primary_composer,
> +			  struct vkms_composer *cursor_composer)
>  {
>  	struct drm_framebuffer *fb = &primary_composer->fb;
>  	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
>  	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> -	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
> -	u32 crc = 0;
>  
> -	if (!vaddr_out) {
> -		DRM_ERROR("Failed to allocate memory for output frame.");
> -		return 0;
> +	if (!*vaddr_out) {
> +		*vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);

Uh allocating memory here isn't great, since you effectily can't handle
the error at all. Also for big resolutions kzalloc will fall back to
kvmalloc I think, which is rather expensive to set up.

But I guess this is a preexisting issue, so welp.

What I would do is pull out the allocation at least, so that
compose_planes really only dos composing, can never fail because it
doesn't need to allocate memory.

> +		if (!*vaddr_out) {
> +			DRM_ERROR("Cannot allocate memory for output frame.");
> +			return -ENOMEM;
> +		}
>  	}
>  
> -	if (WARN_ON(!vkms_obj->vaddr)) {
> -		kfree(vaddr_out);
> -		return crc;
> -	}
> +	if (WARN_ON(!vkms_obj->vaddr))
> +		return -EINVAL;
>  
> -	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
> +	memcpy(*vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
>  
>  	if (cursor_composer)
> -		compose_cursor(cursor_composer, primary_composer, vaddr_out);
> +		compose_cursor(cursor_composer, primary_composer, *vaddr_out);
>  
> -	crc = compute_crc(vaddr_out, primary_composer);
> -
> -	kfree(vaddr_out);
> -
> -	return crc;
> +	return 0;
>  }
>  
>  /**
> @@ -154,9 +150,11 @@ void vkms_composer_worker(struct work_struct *work)
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  	struct vkms_composer *primary_composer = NULL;
>  	struct vkms_composer *cursor_composer = NULL;
> +	void *vaddr_out = NULL;
>  	u32 crc32 = 0;
>  	u64 frame_start, frame_end;
>  	bool crc_pending;
> +	int ret;
>  
>  	spin_lock_irq(&out->composer_lock);
>  	frame_start = crtc_state->frame_start;
> @@ -180,14 +178,25 @@ void vkms_composer_worker(struct work_struct *work)
>  	if (crtc_state->num_active_planes == 2)
>  		cursor_composer = crtc_state->active_planes[1]->composer;
>  
> -	if (primary_composer)
> -		crc32 = _vkms_get_crc(primary_composer, cursor_composer);
> +	if (!primary_composer)
> +		return;
> +
> +	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			kfree(vaddr_out);
> +		return;
> +	}
> +
> +	crc32 = compute_crc(vaddr_out, primary_composer);
>  
>  	/*
>  	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
>  	 */
>  	while (frame_start <= frame_end)
>  		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
> +
> +	kfree(vaddr_out);

Especially since you're freeing the memory _outside_ of compose_planes.

Aside: This all kinda doesn't go in the right direction for
high-performance composing, so I guess I need to get started with typing
up what that should look like.
-Daniel

>  }
>  
>  static const char * const pipe_crc_sources[] = {"auto"};
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
