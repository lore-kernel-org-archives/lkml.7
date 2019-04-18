Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A1C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047421850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfDRGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:22:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40699 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfDRGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:22:35 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 13757E0004;
        Thu, 18 Apr 2019 06:22:29 +0000 (UTC)
Date:   Thu, 18 Apr 2019 08:22:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
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
Message-ID: <20190418062229.eyog4i62eg4pr6uf@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417154121.GJ13337@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 17, 2019 at 05:41:21PM +0200, Daniel Vetter wrote:
> On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > DRM comes with an extensive format support to retrieve the various
> > parameters associated with a given format (such as the subsampling, or the
> > bits per pixel), as well as some helpers and utilities to ease the driver
> > development.
> >
> > v4l2, on the other side, doesn't provide such facilities, leaving each
> > driver reimplement a subset of the formats parameters for the one supported
> > by that particular driver. This leads to a lot of duplication and
> > boilerplate code in the v4l2 drivers.
> >
> > This series tries to address this by moving the DRM format API into lib and
> > turning it into a more generic API. In order to do this, we've needed to do
> > some preliminary changes on the DRM drivers, then moved the API and finally
> > converted a v4l2 driver to give an example of how such library could be
> > used.
> >
> > Let me know what you think,
> > Maxime
> >
> > Changes from RFC:
> >   - Rebased on next
> >   - Fixed the various formats mapping
> >   - Added tags
> >   - Did most of the formats functions as inline functions
> >   - Used a consistent prefix for all the utilities functions
> >   - Fixed the compilation breakages, and did a run of allmodconfig for arm,
> >     arm64 and x86_64
> >   - Fixed out of array bounds warnings in the image_format_info_block_*
> >     functions
> >   - Added License and copyright headers on missing files
> >
> > Maxime Ripard (20):
> >   drm: Remove users of drm_format_num_planes
> >   drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
> >   drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
> >   drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
> >   drm: Replace instances of drm_format_info by drm_get_format_info
> >   lib: Add video format information library
> >   drm/fb: Move from drm_format_info to image_format_info
> >   drm/malidp: Convert to generic image format library
> >   drm/client: Convert to generic image format library
> >   drm/exynos: Convert to generic image format library
> >   drm/i915: Convert to generic image format library
> >   drm/ipuv3: Convert to generic image format library
> >   drm/msm: Convert to generic image format library
> >   drm/omap: Convert to generic image format library
> >   drm/rockchip: Convert to generic image format library
> >   drm/tegra: Convert to generic image format library
> >   drm/fourcc: Remove old DRM format API
> >   lib: image-formats: Add v4l2 formats support
> >   lib: image-formats: Add more functions
> >   media: sun6i: Convert to the image format API
>
> In the interest of making myself unpopular: Why move this out of drm?
>
> We do have a bunch of other such shared helpers already (mostly in
> drivers/video) for dt videomode and hdmi infoframes, and I'm not super
> sure that's going better than keeping it maintained in drm.
>
> Plus the uapi is already that you include drm_fourcc.h to get at these,
> dropping the drm prefix isn't going to help I think.
>
> Of course we'd need to make it a separate drm_formats.ko (so that v4l can
> use it without dragging in all of drm), and we need to add some fields for
> converting to v4l fourcc codes (which are different). But that should be
> all possible. And I don't think the drm_ prefix in v4l code is a problem,
> it's actually a feature: It makes it really clear that these are the drm
> fourcc codes, as allocated in drm_fourcc.h, plus their modifiers, and all
> that. That allocation authority is also already baked into various khr/ext
> standards, too.

The way I see it, there's a fundamental difference between the UAPI
and the kernel. I don't suggest we change anything about the UAPI: the
drm formats should keep their prefix, drm_fourcc.h can remain that
authority, it's all fine.

Internally however, the long term goal is to share the fourcc's
between DRM and V4L2 for the same formats. It basically means that of
course v4l2 should be using the DRM fourcc when a format exists in DRM
and not v4l2, but also that DRM should use v4l2 fourcc when the format
exists in v4l2 but not DRM, and that is far more likely, given the
already extensive v4l2 formats support.

And given how the current state is a mess in this regard, I'm not too
optimistic about keeping the formats in their relevant frameworks.

Having a shared library, governed by both, will make this far easier,
since it will be easy to discover the formats that are already
supported by the other subsystem.

If we want to keep the current library in DRM, we have two options
then:

  - Support all the v4l2 formats in the DRM library, which is
    essentially what I'm doing in the last patches. However, that
    would require to have the v4l2 developpers also reviewing stuff
    there. And given how busy they are, I cannot really see how that
    would work.

  - Develop the same library from within v4l2. That is really a poor
    solution, since the information would be greatly duplicated
    between the two, and in terms of maintainance, code, and binary
    size that would be duplicated too.

Having it shared allows to easily share, and discover formats from the
other subsystem, and to have a single, unique place where this is
centralized.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
