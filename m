Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3B0217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HCr/Ff4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICK4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:56:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46729 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfICK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:56:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id i8so4370964edn.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQW5ksUhth30PvkhQFOylQR/xNf82JELFG+PaoKpjl8=;
        b=HCr/Ff4IC/t1ZweR3epw+151TIAAyUjN8ycson8ojpS3AhP6c8Zv7sFnCOjT6VZ/Yy
         zIObkyOxQvQj6T+Jdzqtq5Ckw8l/tUiDTOsQ81a6J1ZJBgR5KsvFRapTdTSy8yXFa2IG
         UCOlXa0LmS3X5OSSSqWIEqdw0LaIv2c7Orm0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KQW5ksUhth30PvkhQFOylQR/xNf82JELFG+PaoKpjl8=;
        b=jANN+ZcTwp7Ut+kfAvcKzI/07+6/e1MKsf21v+nu7dNh+Jh8qCwBR7aVMxJjYS+9vY
         HAC1Tt9NdnR/gv6jJrmveocIFWkjOLBKrjYo3odAq6grwHOE33kc44nbGNbmuYd0OsPx
         oqySpHLQfDj4xGy/dl+A9RI2hTenkhSD7UD4W5fGTIL2NYkVCZPAsHd1VsYP0IyuEb3B
         Kjj9V2vFsSZHwXZFjiFA0djnpxigul0bFXuCzA3oD24JgVfjZyzoGO3kwDNR/aT60zr0
         jMd1m6D2mAwB1AJf0nhqLaAw2rEdCkXzUHRVEpwG1V9JZCsBfB0JZGGegkiGk8zzrJuK
         IIog==
X-Gm-Message-State: APjAAAUtXigRV3qEF2yAmmWzFMtZtZpSPdPTr3x/kP8PkdNq8TlyKRzk
        C7BFG5trYmY3OefTVrhECGjXE6vje6/pLQ==
X-Google-Smtp-Source: APXvYqyrII1RCMo80LZV/0pNv78bxoT8GQ59T3vfIdsTL9O6A4nYU+5Hh5B7//NyoCQMO9Nd1XqAQQ==
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr4565145ejx.155.1567508194892;
        Tue, 03 Sep 2019 03:56:34 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u27sm122992edb.48.2019.09.03.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:56:34 -0700 (PDT)
Date:   Tue, 3 Sep 2019 12:56:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] drm/ttm: add drm gem ttm helpers, starting with
 drm_gem_ttm_print_info()
Message-ID: <20190903105631.GV2112@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190903101248.12879-1-kraxel@redhat.com>
 <20190903101248.12879-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903101248.12879-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:12:44PM +0200, Gerd Hoffmann wrote:
> Now with ttm_buffer_object being a subclass of drm_gem_object we can
> easily lookup ttm_buffer_object for a given drm_gem_object, which in
> turn allows to create common helper functions.
> 
> This patch starts off with a drm_gem_ttm_print_info() helper function
> which prints adds some ttm specific lines to the debug output.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  include/drm/drm_gem_ttm_helper.h     | 19 ++++++++++
>  drivers/gpu/drm/drm_gem_ttm_helper.c | 53 ++++++++++++++++++++++++++++
>  Documentation/gpu/drm-mm.rst         | 12 +++++++
>  drivers/gpu/drm/Kconfig              |  7 ++++
>  drivers/gpu/drm/Makefile             |  3 ++
>  5 files changed, 94 insertions(+)
>  create mode 100644 include/drm/drm_gem_ttm_helper.h
>  create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c
> 
> diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
> new file mode 100644
> index 000000000000..6268f89c5a48
> --- /dev/null
> +++ b/include/drm/drm_gem_ttm_helper.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef DRM_GEM_TTM_HELPER_H
> +#define DRM_GEM_TTM_HELPER_H
> +
> +#include <linux/kernel.h>
> +
> +#include <drm/drm_gem.h>
> +#include <drm/drm_device.h>
> +#include <drm/ttm/ttm_bo_api.h>
> +#include <drm/ttm/ttm_bo_driver.h>
> +
> +#define drm_gem_ttm_of_gem(gem_obj) \
> +	container_of(gem_obj, struct ttm_buffer_object, base)
> +
> +void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
> +			    const struct drm_gem_object *gem);
> +
> +#endif
> diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
> new file mode 100644
> index 000000000000..5a19a7e130c4
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/module.h>
> +
> +#include <drm/drm_gem_ttm_helper.h>
> +
> +/**
> + * DOC: overview
> + *
> + * This library provides helper functions for gem objects backed by
> + * ttm.
> + */
> +
> +/**
> + * drm_gem_ttm_print_info() - Print &ttm_buffer_object info for debugfs
> + * @p: DRM printer
> + * @indent: Tab indentation level
> + * @gem: GEM object
> + *
> + * This function can be used as the &drm_driver->gem_print_info callback.

&drm_gem_object_funcs.print_info is the new thing. Also I think you need
the . for kerneldoc to parse this correctly and make it a link.

> + */
> +void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
> +			    const struct drm_gem_object *gem)
> +{
> +	static const char const *plname[] = {
> +		[ TTM_PL_SYSTEM ] = "system",
> +		[ TTM_PL_TT     ] = "tt",
> +		[ TTM_PL_VRAM   ] = "vram",
> +		[ TTM_PL_PRIV   ] = "priv",
> +
> +		[ 16 ]            = "cached",
> +		[ 17 ]            = "uncached",
> +		[ 18 ]            = "wc",
> +		[ 19 ]            = "contig",
> +
> +		[ 21 ]            = "pinned", /* NO_EVICT */
> +		[ 22 ]            = "topdown",
> +	};
> +	const struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
> +
> +	drm_print_bits(p, indent, "placement", bo->mem.placement,
> +		       plname, ARRAY_SIZE(plname));
> +	if (bo->mem.bus.is_iomem) {
> +		drm_printf_indent(p, indent, "bus.base=%lx\n",
> +				  (unsigned long)bo->mem.bus.base);
> +		drm_printf_indent(p, indent, "bus.offset=%lx\n",
> +				  (unsigned long)bo->mem.bus.offset);
> +	}
> +}
> +EXPORT_SYMBOL(drm_gem_ttm_print_info);
> +
> +MODULE_DESCRIPTION("DRM gem ttm helpers");
> +MODULE_LICENSE("GPL");
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index b664f054c259..a70a1d9f30ec 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -412,6 +412,18 @@ VRAM MM Helper Functions Reference
>  .. kernel-doc:: drivers/gpu/drm/drm_vram_mm_helper.c
>     :export:
>  
> +GEM TTM Helper Functions Reference
> +-----------------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_gem_ttm_helper.c
> +   :doc: overview
> +
> +.. kernel-doc:: include/drm/drm_gem_ttm_helper.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_gem_ttm_helper.c
> +   :export:
> +
>  VMA Offset Manager
>  ==================
>  
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

Nice! With the kerneldoc bikeshed fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
