Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE7C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABB020674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ims/dqb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbfDQPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:41:29 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42117 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732792AbfDQPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:41:27 -0400
Received: by mail-ed1-f50.google.com with SMTP id x61so21367253edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSXfHh//D5u79ijZBx0LMvnuNbTygUaZjwukO2ZZAS4=;
        b=ims/dqb0WQ3UQlzuRVqPOhnSvO+G4uZChM4mkx08AZEkJVf3Dp0gsLNs1qNo6RPtS8
         HP2YPM1Rxgy9X+PdbpoXTWcm+cADBXMR9860J2sJN0wSjgGAUTs4XO0308LQ9QASvgOu
         7nFdw2bk1SW+yI7z/DBGqnP1ug/Cuod1Yr4XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LSXfHh//D5u79ijZBx0LMvnuNbTygUaZjwukO2ZZAS4=;
        b=oyCC835fiqLnarI6l7rUItfFMfe/FRhhC2gT/F8RXDfB+BxiaqzYpoVIE1zZtS+Shd
         wDlv6sAX/Q29Z7ELAMu3Pqe8Cc5rohW8SiH7FelUBfYqGw/V+Tb4qNa88gaFZhgZI1+o
         X+9CmifUzUB2ccH2JJBdIXEc8w1hr1Er83T5X/cLeUBYJU1f4eLsWL/bMEgTbLOn59u2
         AN4//OADrjETjAEA9niihT/BhAZCpc2vH4Mqv94+awQWHZU1fi+2o1u0TfSMqJaiWB4C
         D0OOGH1ahewhm7eepvyfba29lkuXyWHZMy7nihsibDc5ChyMQ4Rpap6bEnXoOiGdie8c
         SBWA==
X-Gm-Message-State: APjAAAWx1QnE6y7xTfqBh3gRCC73I5iCJBdzKbL1TxqEvxATfoGcndQt
        O8bv65V+crfjbEJ+wima4qlBuw==
X-Google-Smtp-Source: APXvYqwShZ7LD/SRo5pFZ3foEnEU4YEEYDS04MpmUK2nQA/ZD+r3LyqK/vcFeAUhXzc38nHm+Sj/1A==
X-Received: by 2002:a17:906:c50:: with SMTP id t16mr239756ejf.296.1555515684521;
        Wed, 17 Apr 2019 08:41:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w3sm9908308edq.33.2019.04.17.08.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 08:41:23 -0700 (PDT)
Date:   Wed, 17 Apr 2019 17:41:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
Message-ID: <20190417154121.GJ13337@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
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

In the interest of making myself unpopular: Why move this out of drm?

We do have a bunch of other such shared helpers already (mostly in
drivers/video) for dt videomode and hdmi infoframes, and I'm not super
sure that's going better than keeping it maintained in drm.

Plus the uapi is already that you include drm_fourcc.h to get at these,
dropping the drm prefix isn't going to help I think.

Of course we'd need to make it a separate drm_formats.ko (so that v4l can
use it without dragging in all of drm), and we need to add some fields for
converting to v4l fourcc codes (which are different). But that should be
all possible. And I don't think the drm_ prefix in v4l code is a problem,
it's actually a feature: It makes it really clear that these are the drm
fourcc codes, as allocated in drm_fourcc.h, plus their modifiers, and all
that. That allocation authority is also already baked into various khr/ext
standards, too.

Ofc it'll perpetuate the joke that drm has no meaning anymore as an
abbrevation, but oh welp :-)
-Daniel


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
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
