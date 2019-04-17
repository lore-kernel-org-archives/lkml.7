Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941BBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7035E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfDQMie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:38:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54353 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQMie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:38:34 -0400
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5A96240002;
        Wed, 17 Apr 2019 12:38:29 +0000 (UTC)
Message-ID: <69e9a0b02c48867cca05f496dd2129b0e41d5904.camel@bootlin.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Wed, 17 Apr 2019 14:38:29 +0200
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-04-17 at 09:54 +0200, Maxime Ripard wrote:
> Hi,
> 
> DRM comes with an extensive format support to retrieve the various
> parameters associated with a given format (such as the subsampling, or the
> bits per pixel), as well as some helpers and utilities to ease the driver
> development.
> 
> v4l2, on the other side, doesn't provide such facilities, leaving each
> driver reimplement a subset of the formats parameters for the one supported
> by that particular driver. This leads to a lot of duplication and
> boilerplate code in the v4l2 drivers.
> 
> This series tries to address this by moving the DRM format API into lib and
> turning it into a more generic API. In order to do this, we've needed to do
> some preliminary changes on the DRM drivers, then moved the API and finally
> converted a v4l2 driver to give an example of how such library could be
> used.
> 
> Let me know what you think,

Another thing to consider would be using unsigned ints for the plane
index so we can avoid < 0 checks all over the place.

What do you think?

Cheers,

Paul

> Maxime
> 
> Changes from RFC:
>   - Rebased on next
>   - Fixed the various formats mapping
>   - Added tags
>   - Did most of the formats functions as inline functions
>   - Used a consistent prefix for all the utilities functions
>   - Fixed the compilation breakages, and did a run of allmodconfig for arm,
>     arm64 and x86_64
>   - Fixed out of array bounds warnings in the image_format_info_block_*
>     functions
>   - Added License and copyright headers on missing files
> 
> Maxime Ripard (20):
>   drm: Remove users of drm_format_num_planes
>   drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
>   drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
>   drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
>   drm: Replace instances of drm_format_info by drm_get_format_info
>   lib: Add video format information library
>   drm/fb: Move from drm_format_info to image_format_info
>   drm/malidp: Convert to generic image format library
>   drm/client: Convert to generic image format library
>   drm/exynos: Convert to generic image format library
>   drm/i915: Convert to generic image format library
>   drm/ipuv3: Convert to generic image format library
>   drm/msm: Convert to generic image format library
>   drm/omap: Convert to generic image format library
>   drm/rockchip: Convert to generic image format library
>   drm/tegra: Convert to generic image format library
>   drm/fourcc: Remove old DRM format API
>   lib: image-formats: Add v4l2 formats support
>   lib: image-formats: Add more functions
>   media: sun6i: Convert to the image format API
> 
>  drivers/gpu/drm/Kconfig                                |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c                 |   4 +-
>  drivers/gpu/drm/arm/malidp_drv.c                       |   3 +-
>  drivers/gpu/drm/arm/malidp_hw.c                        |   3 +-
>  drivers/gpu/drm/arm/malidp_mw.c                        |   2 +-
>  drivers/gpu/drm/arm/malidp_planes.c                    |  20 +-
>  drivers/gpu/drm/armada/armada_fb.c                     |   3 +-
>  drivers/gpu/drm/armada/armada_overlay.c                |   2 +-
>  drivers/gpu/drm/armada/armada_plane.c                  |   2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c        |  11 +-
>  drivers/gpu/drm/bochs/bochs.h                          |   4 +-
>  drivers/gpu/drm/bochs/bochs_hw.c                       |   2 +-
>  drivers/gpu/drm/drm_client.c                           |   7 +-
>  drivers/gpu/drm/drm_fb_cma_helper.c                    |   4 +-
>  drivers/gpu/drm/drm_fb_helper.c                        |  14 +-
>  drivers/gpu/drm/drm_format_helper.c                    |   4 +-
>  drivers/gpu/drm/drm_fourcc.c                           | 345 +-----
>  drivers/gpu/drm/drm_framebuffer.c                      |  10 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c           |   4 +-
>  drivers/gpu/drm/exynos/exynos_drm_fb.c                 |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_ipp.c                |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_ipp.h                |   4 +-
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c             |   3 +-
>  drivers/gpu/drm/gma500/framebuffer.c                   |   4 +-
>  drivers/gpu/drm/i915/i915_drv.h                        |   6 +-
>  drivers/gpu/drm/i915/intel_display.c                   |  14 +-
>  drivers/gpu/drm/i915/intel_pm.c                        |   6 +-
>  drivers/gpu/drm/i915/intel_sprite.c                    |   3 +-
>  drivers/gpu/drm/imx/ipuv3-plane.c                      |  19 +-
>  drivers/gpu/drm/mediatek/mtk_drm_fb.c                  |   8 +-
>  drivers/gpu/drm/meson/meson_overlay.c                  |  14 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c            |  11 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c              |  10 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c              |   4 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c             |  25 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c               |   8 +-
>  drivers/gpu/drm/msm/msm_fb.c                           |  18 +-
>  drivers/gpu/drm/omapdrm/dss/dispc.c                    |   9 +-
>  drivers/gpu/drm/omapdrm/omap_fb.c                      |  15 +-
>  drivers/gpu/drm/radeon/radeon_fb.c                     |   4 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c             |  17 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c            |  14 +-
>  drivers/gpu/drm/selftests/Makefile                     |   3 +-
>  drivers/gpu/drm/selftests/drm_modeset_selftests.h      |   3 +-
>  drivers/gpu/drm/selftests/test-drm_format.c            | 280 +----
>  drivers/gpu/drm/selftests/test-drm_modeset_common.h    |   3 +-
>  drivers/gpu/drm/stm/ltdc.c                             |   2 +-
>  drivers/gpu/drm/sun4i/sun4i_backend.c                  |   6 +-
>  drivers/gpu/drm/sun4i/sun4i_frontend.c                 |  18 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c                 |   4 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.c                |   6 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.h                |   5 +-
>  drivers/gpu/drm/tegra/fb.c                             |  14 +-
>  drivers/gpu/drm/tegra/plane.c                          |   4 +-
>  drivers/gpu/drm/vc4/vc4_plane.c                        |  15 +-
>  drivers/gpu/drm/zte/zx_plane.c                         |   6 +-
>  drivers/gpu/ipu-v3/ipu-pre.c                           |   3 +-
>  drivers/gpu/ipu-v3/ipu-prg.c                           |   3 +-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c     |  89 +-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h     |  49 +-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h |   6 +-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c   |  11 +-
>  include/drm/drm_fourcc.h                               | 219 +---
>  include/drm/drm_framebuffer.h                          |   4 +-
>  include/drm/drm_mode_config.h                          |   5 +-
>  include/linux/image-formats.h                          | 438 ++++++-
>  lib/Kconfig                                            |   7 +-
>  lib/Makefile                                           |   3 +-
>  lib/image-formats-selftests.c                          | 325 +++++-
>  lib/image-formats.c                                    | 717 ++++++++++-
>  70 files changed, 1740 insertions(+), 1174 deletions(-)
>  delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
>  create mode 100644 include/linux/image-formats.h
>  create mode 100644 lib/image-formats-selftests.c
>  create mode 100644 lib/image-formats.c
> 
> base-commit: de3c659c83ce88d495f2a36397071fdd0a337345
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

