Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4DBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3229720C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zt48Rbli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfHFNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:54:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39466 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:54:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so82372014edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Aey82lnDkdAPYntpuLEjB4mu5EkhVccrp4BZNXQePg=;
        b=Zt48Rbli4U2JuTyPPQJYA7JnqgvoX5oNln7AUrR/R8AgdhI92eah9DQ+p5bYeYvdLH
         E9P82Xx4ULmDVAvb5RDZiQ73iqZveIGsylFEut8+2PfeYvL48HoCZoDl11WP/Phyweip
         bd7lCvam6ge4f6int6xTldvDXlep4Mq1BgpD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3Aey82lnDkdAPYntpuLEjB4mu5EkhVccrp4BZNXQePg=;
        b=mnbrWyZaY5gYr2L8NvIYzNu+IwkBfRVsvNsWjULCDoI4QrteC5RK2GppJrVkhs1rfO
         EsLdTDGMoJ9gstc0hGBiJ8SjPY7vgZEXZFscPEnUOUL5UNSrgJ9dsf1yo46M3cl9aet5
         M7YpDy20XLCTefAFwRtX/oVNSEeVWllGPZ0mXDZsUYyt+5CLV96kdHOcr02aOi42YKdl
         MGYp3Ntj4U4YBcjPjvaraidddpJfSg50E5lNvMHCACPuftwGMy2N0AJHJ0ig0fmpzR5U
         09FkRVPtRIWllJBJFi5h6E79ryXHCbC0h9Z3lP1uHx0rRFuJU6XSBFs6PPQmX4YDmv2N
         JUxQ==
X-Gm-Message-State: APjAAAXjNHjOk2SSDUap7IpS0t+ndO7DNq7zO1Dm96EhltPNrS4yC3Cb
        GCIQ7J2URehJ3PigxJqMEJE79g==
X-Google-Smtp-Source: APXvYqxnPHZOyMBHU2FQkb1239Dp88uZ8NFsOkyJTc6B0djfnBpLxpLOKSvAeF1gtvOT3CbNM3ahTw==
X-Received: by 2002:a17:906:1292:: with SMTP id k18mr3379185ejb.146.1565099669266;
        Tue, 06 Aug 2019 06:54:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d44sm20657680eda.75.2019.08.06.06.54.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:54:28 -0700 (PDT)
Date:   Tue, 6 Aug 2019 15:54:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190806135426.GA7444@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806133454.8254-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:34:52PM +0200, Gerd Hoffmann wrote:
> Now with ttm_buffer_object being a subclass of drm_gem_object we can
> easily lookup ttm_buffer_object for a given drm_gem_object, which in
> turm allows to create common helper functions.  This patch starts off
> with dump mmap helpers.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_ttm_helper.h     | 27 +++++++++++++++
>  drivers/gpu/drm/drm_gem_ttm_helper.c | 52 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/Kconfig              |  7 ++++
>  drivers/gpu/drm/Makefile             |  3 ++
>  4 files changed, 89 insertions(+)
>  create mode 100644 include/drm/drm_gem_ttm_helper.h
>  create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c
> 
> diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
> new file mode 100644
> index 000000000000..2c6874190b17
> --- /dev/null
> +++ b/include/drm/drm_gem_ttm_helper.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef DRM_GEM_TTM_HELPER_H
> +#define DRM_GEM_TTM_HELPER_H
> +
> +#include <drm/drm_gem.h>
> +#include <drm/ttm/ttm_bo_api.h>
> +#include <linux/kernel.h> /* for container_of() */
> +
> +/**
> + * Returns the container of type &struct ttm_buffer_object
> + * for field base.
> + * @gem:	the GEM object
> + * Returns:	The containing GEM VRAM object
> + */
> +static inline struct ttm_buffer_object *drm_gem_ttm_of_gem(
> +	struct drm_gem_object *gem)
> +{
> +	return container_of(gem, struct ttm_buffer_object, base);
> +}
> +
> +u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo);
> +int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
> +					struct drm_device *dev,
> +					uint32_t handle, uint64_t *offset);
> +
> +#endif
> diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
> new file mode 100644
> index 000000000000..b069bd0c4c94
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <drm/drm_gem_ttm_helper.h>
> +
> +/**
> + * drm_gem_ttm_mmap_offset() - Returns a GEM ttm object's mmap offset
> + * @gbo:	the GEM ttm object
> + *
> + * See drm_vma_node_offset_addr() for more information.
> + *
> + * Returns:
> + * The buffer object's offset for userspace mappings on success, or
> + * 0 if no offset is allocated.
> + */
> +u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo)
> +{
> +	return drm_vma_node_offset_addr(&bo->base.vma_node);

Why do we need a new one here, can't we use the existing gem
implementation for this (there really should only be one I hope, but I
didn't check).

> +}
> +EXPORT_SYMBOL(drm_gem_ttm_mmap_offset);
> +
> +/**
> + * drm_gem_ttm_driver_dumb_mmap_offset() - \
> +	Implements &struct drm_driver.dumb_mmap_offset
> + * @file:	DRM file pointer.
> + * @dev:	DRM device.
> + * @handle:	GEM handle
> + * @offset:	Returns the mapping's memory offset on success
> + *
> + * Returns:
> + * 0 on success, or
> + * a negative errno code otherwise.
> + */
> +int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
> +					 struct drm_device *dev,
> +					 uint32_t handle, uint64_t *offset)
> +{
> +	struct drm_gem_object *gem;
> +	struct ttm_buffer_object *bo;
> +
> +	gem = drm_gem_object_lookup(file, handle);
> +	if (!gem)
> +		return -ENOENT;
> +
> +	bo = drm_gem_ttm_of_gem(gem);
> +	*offset = drm_gem_ttm_mmap_offset(bo);
> +
> +	drm_gem_object_put_unlocked(gem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_gem_ttm_driver_dumb_mmap_offset);

Same for this, you're just upcasting to ttm_bo and then downcasting to
gem_bo again ... I think just a series to roll out the existing gem
helpers everywhere should work?
-Daniel

> +
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e6f40fb54c9a..f7b25519f95c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -172,6 +172,13 @@ config DRM_VRAM_HELPER
>  	help
>  	  Helpers for VRAM memory management
>  
> +config DRM_TTM_HELPER
> +	tristate
> +	depends on DRM
> +	select DRM_TTM
> +	help
> +	  Helpers for ttm-based gem objects
> +
>  config DRM_GEM_CMA_HELPER
>  	bool
>  	depends on DRM
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 10f8329a8b71..545c61d6528b 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -37,6 +37,9 @@ drm_vram_helper-y := drm_gem_vram_helper.o \
>  		     drm_vram_mm_helper.o
>  obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
>  
> +drm_ttm_helper-y := drm_gem_ttm_helper.o
> +obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
> +
>  drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper.o \
>  		drm_plane_helper.o drm_dp_mst_topology.o drm_atomic_helper.o \
>  		drm_kms_helper_common.o drm_dp_dual_mode_helper.o \
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
