Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D892133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ArT0hy+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfEMOj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:39:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33089 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfEMOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:39:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so17937820edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ryZaZY36BnT6HZ57j2I8+zLgD4GPxPPgFaTeITzHIls=;
        b=ArT0hy+5fBWwK4ahOW21BLqnpZkbJDOETktpPAUm+jqGy80Szxv7N+eI1QHQPWbsZi
         4yP6W7VIfG/chPd4gzRCxUvO6uFj3W66783FeGfyxGuF9IVnhKw9chexY4oD6GMGHCg+
         UuAHK1omaV8hjS0KOo6MEuP0umM1qY25gg12w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ryZaZY36BnT6HZ57j2I8+zLgD4GPxPPgFaTeITzHIls=;
        b=H/PmFhlLmC0Xh8FXi1a+E6hMiej/quUjoEUEIBUfmi5IJ4EXqhzyxkzbvhwb+z3ASz
         gDP/re9xVJc9dt3flapejWtkQ35w/DZiEUGRTQUIXznkr3x6sneoEMemfN9DyBZS2FYn
         EY1tB2hZRnBvfJecpPXiF0dAAepdEMbZJfUS3PqndznuLVYqHOuvW3Mc8Bq5nulW7uxv
         wZQoTDJBlZ3H3btVNP49U0l8BPq7P4Kt+79e471bLZvUfkUKAvTEmQJHr6H2+je4npyG
         JPVtHUu2njOUo+E2Uqko5KEyKT6dOL2PXt1j6enrKnO9w7ChXFNOy5/N1NN5sXJkGhuH
         GXcA==
X-Gm-Message-State: APjAAAVIPk1slOmxaH4jPPN0Kx9UfeoJSTut1Pfi6lbzXqACKfZiuzEA
        oewhxz0LSF8Y5fYyK0iSNeFGlA==
X-Google-Smtp-Source: APXvYqynBjsYVMKBelwmFg3AUdbFo/m1V+E7GiuAZWbZBkyClPMwGgY3y8iX8aW8uTI5W/6a7W+mKw==
X-Received: by 2002:aa7:c44e:: with SMTP id n14mr29429954edr.203.1557758366108;
        Mon, 13 May 2019 07:39:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h8sm297691ejf.73.2019.05.13.07.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 07:39:25 -0700 (PDT)
Date:   Mon, 13 May 2019 16:39:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH] drm/panfrost: Use drm_gem_dump_map_offset()
Message-ID: <20190513143921.GP17751@phenom.ffwll.local>
Mail-Followup-To: Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20190513143244.16478-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513143244.16478-1-steven.price@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:32:44PM +0100, Steven Price wrote:
> panfrost_ioctl_mmap_bo() contains a reimplementation of
> drm_gem_dump_map_offset() but with a bug - it allows mapping imported
> objects (without going through the exporter). Fix this by switching to
> use the generic drm_gem_dump_map_offset() function instead which has the
> bonus of simplifying the code.

gem_dumb stuff is for kms drivers, panfrost is a render driver. We're
generally trying to separate these two worlds somewhat cleanly.

I think it'd be good to have a non-dumb version of this in the core, and
use that. Or upgrade the dumb version to be that helper for everyone (and
drop the _dumb).
-Daniel

> CC: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 94b0819ad50b..d048250ad8ab 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -254,26 +254,14 @@ static int panfrost_ioctl_mmap_bo(struct drm_device *dev, void *data,
>  		      struct drm_file *file_priv)
>  {
>  	struct drm_panfrost_mmap_bo *args = data;
> -	struct drm_gem_object *gem_obj;
> -	int ret;
>  
>  	if (args->flags != 0) {
>  		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
>  		return -EINVAL;
>  	}
>  
> -	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
> -	if (!gem_obj) {
> -		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
> -		return -ENOENT;
> -	}
> -
> -	ret = drm_gem_create_mmap_offset(gem_obj);
> -	if (ret == 0)
> -		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
> -	drm_gem_object_put_unlocked(gem_obj);
> -
> -	return ret;
> +	return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> +				       &args->offset);
>  }
>  
>  static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
