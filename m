Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78099C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442AD20665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F9CIevuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFZQaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:30:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33016 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:30:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so4204110edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxtWuk1q9NwdLhCWjigp44Ai1m3FAAy67WUlQm2a8yA=;
        b=F9CIevuQHRyHX0Cb4LbioMn7puTjlO57X0AZlpXpUCdNutm0m2aJ7IS0d8M21OWHZK
         +TETAqZTKW1TY9VDnAGJK5hZkd6b7xbLie+HSdTg2DDc63QTHsEvYtwx3R/luOMgj16x
         ehuLvbWfKr7ecteKGqISws5eJ8uiRlMZCBetw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pxtWuk1q9NwdLhCWjigp44Ai1m3FAAy67WUlQm2a8yA=;
        b=Jp1wPdCnGNi2SvTemmr6T23fSVVQgjsMPv32sM3iZMkajnsEIKYl5h7F+I+fVVlSIy
         TS3+FPXuoyvi+FKSZ+cUb7Ji87kWu6k5y3pUA5m5jAjlnUlAaAXIAJC12tF99qu8TkZY
         kjIAKsGfyw1/yTf35t0jrSv3u2iNSduM7F4q2saqv4G4F26Xz1OnLliiQwFIL9uH+QG1
         Iy4jqbbOhsLM6VcjAAN62WBLIS4ZejGOSo5kQvjM6n+jvaa2+FojJq58qPpycdpYBRNV
         hDj9GN6oaXxDFrDjIICob7gXHpQkKZtXPjo+rt5wIDsy12TdjbEyXBdI5eB9DBwSCvUP
         ktyg==
X-Gm-Message-State: APjAAAXFl+M545nDLuEftCHKtcv0LAyv1YzIdEoYe6uJ2KPbyT4Q0VUd
        EJVAVdTBrs5JWQmRHWrq1TOnQnAfQoE=
X-Google-Smtp-Source: APXvYqw14KV/pLRZOsgSJp+IRx5aZGACL1k4TeWcmneUTB28zjQgI7qKkEuffGFS5EHv4rTsmQzyaA==
X-Received: by 2002:a50:b4fd:: with SMTP id x58mr6357100edd.97.1561566600740;
        Wed, 26 Jun 2019 09:30:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g7sm5884310eda.52.2019.06.26.09.29.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:29:59 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:29:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/bochs: fix framebuffer setup.
Message-ID: <20190626162957.GW12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626065551.12956-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:55:51AM +0200, Gerd Hoffmann wrote:
> If bo->width doesn't match fb->width the driver fails to configure
> the display correctly, resulting in a scrambled display.  Fix it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 +-
>  drivers/gpu/drm/bochs/bochs_hw.c  | 13 +++++++++----
>  drivers/gpu/drm/bochs/bochs_kms.c |  1 +
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index cc35d492142c..78c0283496cc 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr);
> +		      int x, int y, int fbwidth, u64 addr);
>  int bochs_hw_load_edid(struct bochs_device *bochs);
>  
>  /* bochs_mm.c */
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index 791ab2f79947..141aa02962d3 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -255,16 +255,21 @@ void bochs_hw_setformat(struct bochs_device *bochs,
>  }
>  
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr)
> +		      int x, int y, int fbwidth, u64 addr)
>  {
> -	unsigned long offset = (unsigned long)addr +
> +	unsigned long offset;
> +	unsigned int vx, vy;
> +
> +	bochs->stride = fbwidth * (bochs->bpp / 8);
> +	offset = (unsigned long)addr +
>  		y * bochs->stride +
>  		x * (bochs->bpp / 8);
> -	int vy = offset / bochs->stride;
> -	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
> +	vy = offset / bochs->stride;
> +	vx = (offset % bochs->stride) * 8 / bochs->bpp;
>  
>  	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
>  			 x, y, addr, offset, vx, vy);
> +	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, fbwidth);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 5904eddc83a5..1f6aa11a1dc9 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -36,6 +36,7 @@ static void bochs_plane_update(struct bochs_device *bochs,
>  	bochs_hw_setbase(bochs,
>  			 state->crtc_x,
>  			 state->crtc_y,
> +			 gbo->width,

You want the dimensions of the drm_framebuffer here, not something from
the underlying gem bo.

>  			 gbo->bo.offset);

I think same here, or at least additionally take into account both
drm_framebuffer offset _and_ vram offset.
-Daniel

>  	bochs_hw_setformat(bochs, state->fb->format);
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
