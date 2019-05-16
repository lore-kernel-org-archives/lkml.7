Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CF92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gzNlisoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfEPUZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:25:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40157 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfEPUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:25:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so7029658eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbM6kYK8qDaSCxjbjwvaLEEjjuUd6lpMuLuY5LCU8A4=;
        b=gzNlisoZx8O9l4eiCtdEJCzWLHjt15TW/rhGY61RezCA1ZTIg1/HkJcWHHh1Dg+0Uk
         amiORah2jqE2/rLBg7atfVqDx62WQZOzmJdJTW3J4tucOrnZVvIk97W7o+cKyoGhgs33
         rWCb0m7Z0aBT2Mzb1X+yxc8a+3nrtNgZi8pCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FbM6kYK8qDaSCxjbjwvaLEEjjuUd6lpMuLuY5LCU8A4=;
        b=AeZRrdxJ3BUegMzgszhHtcVA0hzVI3qwI0vBJtbL5A1r9Ma+C4WLMeikK2haB5+CP+
         Sy8liMElcNQ7xUWpdeYjoSavuWC8BYSK0nR5zSi2S9xl5kK70ba3qYzq+H85G2FObWjo
         TV7Y2UfADdbf1cb1k5/xnHDrM0DdqWWyu07+afq/IbT94TO5f+Duk6qujEc9jcTGrLVD
         tiMB8hIvdhjqsW1lHPoyhhhJ82nLIewyMq1QuTAyskQGOH+39GB3YAI++OrxwlFOBkTH
         ljyWj0nBvUJsjnk/kFvT8/SLtmm0NyFZH7NmojBQjza4KhtdmZMdePQ43RYHE2P96Bni
         xnDA==
X-Gm-Message-State: APjAAAW/jL82UW4k8ockxLK3KPgbZVpIXnyXEgwENQ3xVCX/D4a44UOg
        QWpkTREaUEkjiOatuPhNKzHFhw==
X-Google-Smtp-Source: APXvYqwTczkD8DcRJoKp1ZAqpJVbATvhi2sCWZ/XQSH6S3eyrp3ivY4YlfBGDArwAsjCfxGNJJU5Ww==
X-Received: by 2002:a50:ec87:: with SMTP id e7mr52647119edr.126.1558038340813;
        Thu, 16 May 2019 13:25:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y21sm2093670eds.31.2019.05.16.13.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 13:25:40 -0700 (PDT)
Date:   Thu, 16 May 2019 22:25:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/gem: Rename drm_gem_dumb_map_offset() to
 drm_gem_map_offset()
Message-ID: <20190516202537.GD3851@phenom.ffwll.local>
Mail-Followup-To: Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190516141447.46839-1-steven.price@arm.com>
 <20190516141447.46839-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516141447.46839-2-steven.price@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:14:45PM +0100, Steven Price wrote:
> drm_gem_dumb_map_offset() is a useful helper for non-dumb clients, so
> rename it to remove the _dumb.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_dumb_buffers.c      | 4 ++--
>  drivers/gpu/drm/drm_gem.c               | 6 +++---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 3 +--
>  include/drm/drm_gem.h                   | 4 ++--
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index 81dfdd33753a..956665464296 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -46,7 +46,7 @@
>   * To support dumb objects drivers must implement the &drm_driver.dumb_create
>   * operation. &drm_driver.dumb_destroy defaults to drm_gem_dumb_destroy() if
>   * not set and &drm_driver.dumb_map_offset defaults to
> - * drm_gem_dumb_map_offset(). See the callbacks for further details.
> + * drm_gem_map_offset(). See the callbacks for further details.
>   *
>   * Note that dumb objects may not be used for gpu acceleration, as has been
>   * attempted on some ARM embedded platforms. Such drivers really must have
> @@ -125,7 +125,7 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
>  						    args->handle,
>  						    &args->offset);
>  	else
> -		return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> +		return drm_gem_map_offset(file_priv, dev, args->handle,
>  					       &args->offset);
>  }
>  
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 50de138c89e0..99bb7f79a70b 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -294,7 +294,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
>  EXPORT_SYMBOL(drm_gem_handle_delete);
>  
>  /**
> - * drm_gem_dumb_map_offset - return the fake mmap offset for a gem object
> + * drm_gem_map_offset - return the fake mmap offset for a gem object
>   * @file: drm file-private structure containing the gem object
>   * @dev: corresponding drm_device
>   * @handle: gem object handle
> @@ -306,7 +306,7 @@ EXPORT_SYMBOL(drm_gem_handle_delete);
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */
> -int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
> +int drm_gem_map_offset(struct drm_file *file, struct drm_device *dev,
>  			    u32 handle, u64 *offset)
>  {
>  	struct drm_gem_object *obj;
> @@ -332,7 +332,7 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_dumb_map_offset);
> +EXPORT_SYMBOL_GPL(drm_gem_map_offset);
>  
>  /**
>   * drm_gem_dumb_destroy - dumb fb callback helper for gem based drivers
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index a55f5ac41bf3..5e3aa9e4a096 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -276,8 +276,7 @@ int exynos_drm_gem_map_ioctl(struct drm_device *dev, void *data,
>  {
>  	struct drm_exynos_gem_map *args = data;
>  
> -	return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> -				       &args->offset);
> +	return drm_gem_map_offset(file_priv, dev, args->handle, &args->offset);
>  }
>  
>  struct exynos_drm_gem *exynos_drm_gem_get(struct drm_file *filp,
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 5047c7ee25f5..91b07c2325e9 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -395,8 +395,8 @@ int drm_gem_fence_array_add(struct xarray *fence_array,
>  int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
>  				     struct drm_gem_object *obj,
>  				     bool write);
> -int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
> -			    u32 handle, u64 *offset);
> +int drm_gem_map_offset(struct drm_file *file, struct drm_device *dev,
> +		       u32 handle, u64 *offset);
>  int drm_gem_dumb_destroy(struct drm_file *file,
>  			 struct drm_device *dev,
>  			 uint32_t handle);
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
