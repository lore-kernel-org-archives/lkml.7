Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0ECC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1E2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfHFPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:51:29 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57045 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:51:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9A53120049;
        Tue,  6 Aug 2019 17:51:24 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:51:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190806155123.GB10478@ravnborg.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806133454.8254-2-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=e5mUnYsNAAAA:8 a=5DYXHGcTGYXu9a63KT0A:9 a=CjuIK1q_8ugA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

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

You have made nice kernel-doc comments for the struct and the public
functions.
Could we plug this into the existing doc too so one can browse around.
This will also allow you to check for any syntax errors using 
"make htmldocs"
(I spotted  one gbo versus bo mismatch)

A small DOC section in the top of drm_gem_ttm_helper.c
would also be nice. Just a few lines that introduce the purpose of this
file would cut it.

	Sam


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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
