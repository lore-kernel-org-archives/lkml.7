Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8290C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfDWQ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:56:28 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34087 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfDWQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:56:27 -0400
X-Originating-IP: 93.29.109.196
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E5F8BC0005;
        Tue, 23 Apr 2019 16:56:20 +0000 (UTC)
Message-ID: <aa971342fc687193541b8c991024e06e377851a1.camel@bootlin.com>
Subject: Re: [PATCH 06/20] lib: Add video format information library
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
Date:   Tue, 23 Apr 2019 18:56:20 +0200
In-Reply-To: <0aae62f0-776a-6933-2290-f0141d01c5b2@suse.de>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>
         <0aae62f0-776a-6933-2290-f0141d01c5b2@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 23 avril 2019 à 13:22 +0200, Thomas Zimmermann a écrit :
> Hi
> 
> Am 17.04.19 um 09:54 schrieb Maxime Ripard:
> > Move the DRM formats API to turn this into a more generic image formats API
> > to be able to leverage it into some other places of the kernel, such as
> > v4l2 drivers.
> 
> Here's some nitpicking: 'image_format_*' appears slightly vague; it
> could refer to a disk or ROM image as well. Something like
> 'pixel_format_*', 'pixbuf_format_*', etc. would clearly indicate graphics.

Yeah I'm with you on this one. It's bike-shedding, but I think it's
fine as long as more fundamental topics are moving as well.

Cheers,

Paul

> Best regards
> Thomas
> 
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  include/linux/image-formats.h | 387 +++++++++++++++++++++-
> >  lib/Kconfig                   |   7 +-
> >  lib/Makefile                  |   3 +-
> >  lib/image-formats-selftests.c | 325 +++++++++++++++++-
> >  lib/image-formats.c           | 655 +++++++++++++++++++++++++++++++++++-
> >  5 files changed, 1377 insertions(+)
> >  create mode 100644 include/linux/image-formats.h
> >  create mode 100644 lib/image-formats-selftests.c
> >  create mode 100644 lib/image-formats.c
> > 
> > diff --git a/include/linux/image-formats.h b/include/linux/image-formats.h
> > new file mode 100644
> > index 000000000000..ec43d9f9a527
> > --- /dev/null
> > +++ b/include/linux/image-formats.h
> > @@ -0,0 +1,387 @@
> > +/*
> > + * Copyright (c) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > + * Copyright (c) 2019 Maxime Ripard <maxime.ripard@bootlin.com>
> > + *
> > + * Permission to use, copy, modify, distribute, and sell this software and its
> > + * documentation for any purpose is hereby granted without fee, provided that
> > + * the above copyright notice appear in all copies and that both that copyright
> > + * notice and this permission notice appear in supporting documentation, and
> > + * that the name of the copyright holders not be used in advertising or
> > + * publicity pertaining to distribution of the software without specific,
> > + * written prior permission.  The copyright holders make no representations
> > + * about the suitability of this software for any purpose.  It is provided "as
> > + * is" without express or implied warranty.
> > + *
> > + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
> > + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
> > + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
> > + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
> > + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
> > + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
> > + * OF THIS SOFTWARE.
> > + */
> > +
> > +#ifndef _IMAGE_FORMATS_H_
> > +#define _IMAGE_FORMATS_H_
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * struct image_format_info - information about a image format
> > + */
> > +struct image_format_info {
> > +	union {
> > +		/**
> > +		 * @drm_fmt:
> > +		 *
> > +		 * DRM 4CC format identifier (DRM_FORMAT_*)
> > +		 */
> > +		u32 drm_fmt;
> > +
> > +		/**
> > +		 * @format:
> > +		 *
> > +		 * DRM 4CC format identifier (DRM_FORMAT_*). Kept
> > +		 * around for compatibility reasons with the current
> > +		 * DRM drivers.
> > +		 */
> > +		u32 format;
> > +	};
> > +
> > +	/**
> > +	 * @depth:
> > +	 *
> > +	 * Color depth (number of bits per pixel excluding padding bits),
> > +	 * valid for a subset of RGB formats only. This is a legacy field, do
> > +	 * not use in new code and set to 0 for new formats.
> > +	 */
> > +	u8 depth;
> > +
> > +	/** @num_planes: Number of color planes (1 to 3) */
> > +	u8 num_planes;
> > +
> > +	union {
> > +		/**
> > +		 * @cpp:
> > +		 *
> > +		 * Number of bytes per pixel (per plane), this is aliased with
> > +		 * @char_per_block. It is deprecated in favour of using the
> > +		 * triplet @char_per_block, @block_w, @block_h for better
> > +		 * describing the pixel format.
> > +		 */
> > +		u8 cpp[3];
> > +
> > +		/**
> > +		 * @char_per_block:
> > +		 *
> > +		 * Number of bytes per block (per plane), where blocks are
> > +		 * defined as a rectangle of pixels which are stored next to
> > +		 * each other in a byte aligned memory region. Together with
> > +		 * @block_w and @block_h this is used to properly describe tiles
> > +		 * in tiled formats or to describe groups of pixels in packed
> > +		 * formats for which the memory needed for a single pixel is not
> > +		 * byte aligned.
> > +		 *
> > +		 * @cpp has been kept for historical reasons because there are
> > +		 * a lot of places in drivers where it's used. In drm core for
> > +		 * generic code paths the preferred way is to use
> > +		 * @char_per_block, image_format_info_block_width() and
> > +		 * image_format_info_block_height() which allows handling both
> > +		 * block and non-block formats in the same way.
> > +		 *
> > +		 * For formats that are intended to be used only with non-linear
> > +		 * modifiers both @cpp and @char_per_block must be 0 in the
> > +		 * generic format table. Drivers could supply accurate
> > +		 * information from their drm_mode_config.get_format_info hook
> > +		 * if they want the core to be validating the pitch.
> > +		 */
> > +		u8 char_per_block[3];
> > +	};
> > +
> > +	/**
> > +	 * @block_w:
> > +	 *
> > +	 * Block width in pixels, this is intended to be accessed through
> > +	 * image_format_info_block_width()
> > +	 */
> > +	u8 block_w[3];
> > +
> > +	/**
> > +	 * @block_h:
> > +	 *
> > +	 * Block height in pixels, this is intended to be accessed through
> > +	 * image_format_info_block_height()
> > +	 */
> > +	u8 block_h[3];
> > +
> > +	/** @hsub: Horizontal chroma subsampling factor */
> > +	u8 hsub;
> > +	/** @vsub: Vertical chroma subsampling factor */
> > +	u8 vsub;
> > +
> > +	/** @has_alpha: Does the format embeds an alpha component? */
> > +	bool has_alpha;
> > +
> > +	/** @is_yuv: Is it a YUV format? */
> > +	bool is_yuv;
> > +};
> > +
> > +/**
> > + * image_format_info_is_yuv_packed - check that the format info matches a YUV
> > + * format with data laid in a single plane
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a packed YUV format.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_packed(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->num_planes == 1;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_semiplanar - check that the format info matches a YUV
> > + * format with data laid in two planes (luminance and chrominance)
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a semiplanar YUV format.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_semiplanar(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->num_planes == 2;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_planar - check that the format info matches a YUV
> > + * format with data laid in three planes (one for each YUV component)
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a planar YUV format.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_planar(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->num_planes == 3;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_sampling_410 - check that the format info matches a
> > + * YUV format with 4:1:0 sub-sampling
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a YUV format with 4:1:0
> > + * sub-sampling.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_sampling_410(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->hsub == 4 && info->vsub == 4;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_sampling_411 - check that the format info matches a
> > + * YUV format with 4:1:1 sub-sampling
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a YUV format with 4:1:1
> > + * sub-sampling.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_sampling_411(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->hsub == 4 && info->vsub == 1;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_sampling_420 - check that the format info matches a
> > + * YUV format with 4:2:0 sub-sampling
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a YUV format with 4:2:0
> > + * sub-sampling.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_sampling_420(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->hsub == 2 && info->vsub == 2;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_sampling_422 - check that the format info matches a
> > + * YUV format with 4:2:2 sub-sampling
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a YUV format with 4:2:2
> > + * sub-sampling.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_sampling_422(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->hsub == 2 && info->vsub == 1;
> > +}
> > +
> > +/**
> > + * image_format_info_is_yuv_sampling_444 - check that the format info matches a
> > + * YUV format with 4:4:4 sub-sampling
> > + * @info: format info
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format info matches a YUV format with 4:4:4
> > + * sub-sampling.
> > + */
> > +static inline bool
> > +image_format_info_is_yuv_sampling_444(const struct image_format_info *info)
> > +{
> > +	return info->is_yuv && info->hsub == 1 && info->vsub == 1;
> > +}
> > +
> > +/**
> > + * image_format_info_plane_cpp - determine the bytes per pixel value
> > + * @format: pixel format info
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The bytes per pixel value for the specified plane.
> > + */
> > +static inline
> > +int image_format_info_plane_cpp(const struct image_format_info *info, int plane)
> > +{
> > +	if (!info || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	return info->cpp[plane];
> > +}
> > +
> > +/**
> > + * image_format_info_plane_width - width of the plane given the first plane
> > + * @format: pixel format info
> > + * @width: width of the first plane
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The width of @plane, given that the width of the first plane is @width.
> > + */
> > +static inline
> > +int image_format_info_plane_width(const struct image_format_info *info, int width,
> > +				  int plane)
> > +{
> > +	if (!info || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	if (plane == 0)
> > +		return width;
> > +
> > +	return width / info->hsub;
> > +}
> > +
> > +/**
> > + * image_format_info_plane_height - height of the plane given the first plane
> > + * @format: pixel format info
> > + * @height: height of the first plane
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The height of @plane, given that the height of the first plane is @height.
> > + */
> > +static inline
> > +int image_format_info_plane_height(const struct image_format_info *info, int height,
> > +				   int plane)
> > +{
> > +	if (!info || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	if (plane == 0)
> > +		return height;
> > +
> > +	return height / info->vsub;
> > +}
> > +
> > +/**
> > + * image_format_info_block_width - width in pixels of block.
> > + * @format: pointer to the image_format_info
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The width in pixels of a block, depending on the plane index.
> > + */
> > +static inline
> > +unsigned int image_format_info_block_width(const struct image_format_info *format,
> > +					   int plane)
> > +{
> > +	if (!format)
> > +		return 0;
> > +
> > +	if (plane < 0 || plane >= ARRAY_SIZE(format->block_w))
> > +		return 0;
> > +
> > +	if (plane >= format->num_planes)
> > +		return 0;
> > +
> > +	if (!format->block_w[plane])
> > +		return 1;
> > +
> > +	return format->block_w[plane];
> > +}
> > +
> > +/**
> > + * image_format_info_block_height - height in pixels of a block
> > + * @info: pointer to the image_format_info
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The height in pixels of a block, depending on the plane index.
> > + */
> > +static inline
> > +unsigned int image_format_info_block_height(const struct image_format_info *format,
> > +					    int plane)
> > +{
> > +	if (!format)
> > +		return 0;
> > +
> > +	if (plane < 0 || plane >= ARRAY_SIZE(format->block_w))
> > +		return 0;
> > +
> > +	if (plane >= format->num_planes)
> > +		return 0;
> > +
> > +	if (!format->block_h[plane])
> > +		return 1;
> > +
> > +	return format->block_h[plane];
> > +}
> > +
> > +/**
> > + * image_format_info_min_pitch - computes the minimum required pitch in bytes
> > + * @info: pixel format info
> > + * @plane: plane index
> > + * @buffer_width: buffer width in pixels
> > + *
> > + * Returns:
> > + * The minimum required pitch in bytes for a buffer by taking into consideration
> > + * the pixel format information and the buffer width.
> > + */
> > +static inline
> > +uint64_t image_format_info_min_pitch(const struct image_format_info *info,
> > +				     int plane, unsigned int buffer_width)
> > +{
> > +	if (!info || plane < 0 || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[plane],
> > +			    image_format_info_block_width(info, plane) *
> > +			    image_format_info_block_height(info, plane));
> > +}
> > +
> > +const struct image_format_info *__image_format_drm_lookup(u32 drm);
> > +const struct image_format_info *image_format_drm_lookup(u32 drm);
> > +
> > +#endif /* _IMAGE_FORMATS_H_ */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index fb453afff32e..9a0160d3123b 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -625,3 +625,10 @@ config GENERIC_LIB_UCMPDI2
> >  
> >  config OBJAGG
> >  	tristate "objagg" if COMPILE_TEST
> > +
> > +config IMAGE_FORMATS
> > +	bool
> > +
> > +config IMAGE_FORMATS_SELFTESTS
> > +	tristate "Test image format functions"
> > +	depends on IMAGE_FORMATS
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 6996d2b9f401..203336b91248 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -280,3 +280,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> >  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> >  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> >  obj-$(CONFIG_OBJAGG) += objagg.o
> > +
> > +obj-$(CONFIG_IMAGE_FORMATS) += image-formats.o
> > +obj-$(CONFIG_IMAGE_FORMATS_SELFTESTS) += image-formats-selftests.o
> > diff --git a/lib/image-formats-selftests.c b/lib/image-formats-selftests.c
> > new file mode 100644
> > index 000000000000..d0f0011b535e
> > --- /dev/null
> > +++ b/lib/image-formats-selftests.c
> > @@ -0,0 +1,325 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test cases for the image_format functions
> > + */
> > +
> > +#define pr_fmt(fmt) "image_format: " fmt
> > +
> > +#include <linux/errno.h>
> > +#include <linux/image-formats.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include <drm/drm_fourcc.h>
> > +
> > +#define FAIL(test, msg, ...) \
> > +	do { \
> > +		if (test) { \
> > +			pr_err("%s/%u: " msg, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
> > +			return -EINVAL; \
> > +		} \
> > +	} while (0)
> > +
> > +#define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
> > +
> > +static int test_image_format_info_block_width(void)
> > +{
> > +	const struct image_format_info *info = NULL;
> > +
> > +	/* Test invalid arguments */
> > +	FAIL_ON(image_format_info_block_width(info, 0) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, -1) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, 1) != 0);
> > +
> > +	/* Test 1 plane format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_width(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 1) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, -1) != 0);
> > +
> > +	/* Test 2 planes format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_NV12);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_width(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 1) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 2) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, -1) != 0);
> > +
> > +	/* Test 3 planes format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_YUV422);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_width(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 1) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 2) != 1);
> > +	FAIL_ON(image_format_info_block_width(info, 3) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, -1) != 0);
> > +
> > +	/* Test a tiled format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_X0L0);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_width(info, 0) != 2);
> > +	FAIL_ON(image_format_info_block_width(info, 1) != 0);
> > +	FAIL_ON(image_format_info_block_width(info, -1) != 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int test_image_format_info_block_height(void)
> > +{
> > +	const struct image_format_info *info = NULL;
> > +
> > +	/* Test invalid arguments */
> > +	FAIL_ON(image_format_info_block_height(info, 0) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, -1) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, 1) != 0);
> > +
> > +	/* Test 1 plane format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_height(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 1) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, -1) != 0);
> > +
> > +	/* Test 2 planes format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_NV12);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_height(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 1) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 2) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, -1) != 0);
> > +
> > +	/* Test 3 planes format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_YUV422);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_height(info, 0) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 1) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 2) != 1);
> > +	FAIL_ON(image_format_info_block_height(info, 3) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, -1) != 0);
> > +
> > +	/* Test a tiled format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_X0L0);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_block_height(info, 0) != 2);
> > +	FAIL_ON(image_format_info_block_height(info, 1) != 0);
> > +	FAIL_ON(image_format_info_block_height(info, -1) != 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int test_image_format_info_min_pitch(void)
> > +{
> > +	const struct image_format_info *info = NULL;
> > +
> > +	/* Test invalid arguments */
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	/* Test 1 plane 8 bits per pixel format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_RGB332);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 640);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 1024);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 1920);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 4096);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 671);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
> > +			(uint64_t)(UINT_MAX - 1));
> > +
> > +	/* Test 1 plane 16 bits per pixel format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 4);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 1280);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 2048);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 3840);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 8192);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 1342);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX * 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
> > +			(uint64_t)(UINT_MAX - 1) * 2);
> > +
> > +	/* Test 1 plane 24 bits per pixel format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_RGB888);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 3);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 6);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 1920);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 3072);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 5760);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 12288);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 2013);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX * 3);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
> > +			(uint64_t)(UINT_MAX - 1) * 3);
> > +
> > +	/* Test 1 plane 32 bits per pixel format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_ABGR8888);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 4);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 8);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 2560);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 4096);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 7680);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 16384);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 2684);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX * 4);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
> > +			(uint64_t)(UINT_MAX - 1) * 4);
> > +
> > +	/* Test 2 planes format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_NV12);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 640);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 320) != 640);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 1024);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 512) != 1024);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 1920);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 960) != 1920);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 4096);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 2048) != 4096);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 671);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 336) != 672);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
> > +			(uint64_t)UINT_MAX + 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
> > +			(uint64_t)(UINT_MAX - 1));
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2) !=
> > +			(uint64_t)(UINT_MAX - 1));
> > +
> > +	/* Test 3 planes 8 bits per pixel format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_YUV422);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 3, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) != 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 1) != 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 2) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 2) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 640);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 320) != 320);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 320) != 320);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 1024);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 512) != 512);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 512) != 512);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 1920);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 960) != 960);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 960) != 960);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 4096);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 2048) != 2048);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 2048) != 2048);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 671);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 336) != 336);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, 336) != 336);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
> > +			(uint64_t)UINT_MAX / 2 + 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1) !=
> > +			(uint64_t)UINT_MAX / 2 + 1);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2) !=
> > +			(uint64_t)(UINT_MAX - 1) / 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2) !=
> > +			(uint64_t)(UINT_MAX - 1) / 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2) !=
> > +			(uint64_t)(UINT_MAX - 1) / 2);
> > +
> > +	/* Test tiled format */
> > +	info = image_format_drm_lookup(DRM_FORMAT_X0L2);
> > +	FAIL_ON(!info);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) != 0);
> > +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) != 0);
> > +
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) != 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) != 4);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) != 1280);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) != 2048);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) != 3840);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) != 8192);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) != 1342);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=
> > +			(uint64_t)UINT_MAX * 2);
> > +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
> > +			(uint64_t)(UINT_MAX - 1) * 2);
> > +
> > +	return 0;
> > +}
> > +
> > +#define selftest(test)	{ .name = #test, .func = test, }
> > +
> > +static struct image_format_test {
> > +	char	*name;
> > +	int	(*func)(void);
> > +} tests[] = {
> > +	selftest(test_image_format_info_block_height),
> > +	selftest(test_image_format_info_block_width),
> > +	selftest(test_image_format_info_min_pitch),
> > +};
> > +
> > +static int __init image_format_test_init(void)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> > +		struct image_format_test *test = &tests[i];
> > +		int ret;
> > +
> > +		ret = test->func();
> > +		if (ret) {
> > +			pr_err("Failed test %s\n", test->name);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	pr_info("All tests executed properly.\n");
> > +	return 0;
> > +}
> > +module_init(image_format_test_init);
> > +
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/lib/image-formats.c b/lib/image-formats.c
> > new file mode 100644
> > index 000000000000..1e52a7410222
> > --- /dev/null
> > +++ b/lib/image-formats.c
> > @@ -0,0 +1,655 @@
> > +/*
> > + * Copyright (c) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > + * Copyright (c) 2019 Maxime Ripard <maxime.ripard@bootlin.com>
> > + *
> > + * Permission to use, copy, modify, distribute, and sell this software and its
> > + * documentation for any purpose is hereby granted without fee, provided that
> > + * the above copyright notice appear in all copies and that both that copyright
> > + * notice and this permission notice appear in supporting documentation, and
> > + * that the name of the copyright holders not be used in advertising or
> > + * publicity pertaining to distribution of the software without specific,
> > + * written prior permission.  The copyright holders make no representations
> > + * about the suitability of this software for any purpose.  It is provided "as
> > + * is" without express or implied warranty.
> > + *
> > + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
> > + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
> > + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
> > + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
> > + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
> > + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
> > + * OF THIS SOFTWARE.
> > + */
> > +
> > +#include <linux/bug.h>
> > +#include <linux/image-formats.h>
> > +#include <linux/kernel.h>
> > +#include <linux/math64.h>
> > +
> > +#include <uapi/drm/drm_fourcc.h>
> > +
> > +static const struct image_format_info formats[] = {
> > +	{
> > +		.drm_fmt = DRM_FORMAT_C8,
> > +		.depth = 8,
> > +		.num_planes = 1,
> > +		.cpp = { 1, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGB332,
> > +		.depth = 8,
> > +		.num_planes = 1,
> > +		.cpp = { 1, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGR233,
> > +		.depth = 8,
> > +		.num_planes = 1,
> > +		.cpp = { 1, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XRGB4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XBGR4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBX4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRX4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ARGB4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ABGR4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBA4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRA4444,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XRGB1555,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XBGR1555,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBX5551,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRX5551,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ARGB1555,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ABGR1555,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBA5551,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRA5551,
> > +		.depth = 15,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGB565,
> > +		.depth = 16,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGR565,
> > +		.depth = 16,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGB888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 3, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGR888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 3, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XRGB8888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XBGR8888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBX8888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRX8888,
> > +		.depth = 24,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGB565_A8,
> > +		.depth = 24,
> > +		.num_planes = 2,
> > +		.cpp = { 2, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGR565_A8,
> > +		.depth = 24,
> > +		.num_planes = 2,
> > +		.cpp = { 2, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XRGB2101010,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XBGR2101010,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBX1010102,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRX1010102,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ARGB2101010,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ABGR2101010,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBA1010102,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRA1010102,
> > +		.depth = 30,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ARGB8888,
> > +		.depth = 32,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_ABGR8888,
> > +		.depth = 32,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBA8888,
> > +		.depth = 32,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRA8888,
> > +		.depth = 32,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGB888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 3, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGR888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 3, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XRGB8888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 4, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XBGR8888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 4, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_RGBX8888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 4, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_BGRX8888_A8,
> > +		.depth = 32,
> > +		.num_planes = 2,
> > +		.cpp = { 4, 1, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUV410,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 4,
> > +		.vsub = 4,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVU410,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 4,
> > +		.vsub = 4,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUV411,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 4,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVU411,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 4,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUV420,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVU420,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUV422,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVU422,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUV444,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVU444,
> > +		.depth = 0,
> > +		.num_planes = 3,
> > +		.cpp = { 1, 1, 1 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV12,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV21,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV16,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV61,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV24,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_NV42,
> > +		.depth = 0,
> > +		.num_planes = 2,
> > +		.cpp = { 1, 2, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YUYV,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_YVYU,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_UYVY,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_VYUY,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_XYUV8888,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_AYUV,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.cpp = { 4, 0, 0 },
> > +		.hsub = 1,
> > +		.vsub = 1,
> > +		.has_alpha = true,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_Y0L0,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.char_per_block = { 8, 0, 0 },
> > +		.block_w = { 2, 0, 0 },
> > +		.block_h = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.has_alpha = true,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_X0L0,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.char_per_block = { 8, 0, 0 },
> > +		.block_w = { 2, 0, 0 },
> > +		.block_h = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_Y0L2,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.char_per_block = { 8, 0, 0 },
> > +		.block_w = { 2, 0, 0 },
> > +		.block_h = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.has_alpha = true,
> > +		.is_yuv = true,
> > +	}, {
> > +		.drm_fmt = DRM_FORMAT_X0L2,
> > +		.depth = 0,
> > +		.num_planes = 1,
> > +		.char_per_block = { 8, 0, 0 },
> > +		.block_w = { 2, 0, 0 },
> > +		.block_h = { 2, 0, 0 },
> > +		.hsub = 2,
> > +		.vsub = 2,
> > +		.is_yuv = true,
> > +	},
> > +};
> > +
> > +#define __image_format_lookup(_field, _fmt)			\
> > +	({							\
> > +		const struct image_format_info *format = NULL;	\
> > +		unsigned i;					\
> > +								\
> > +		for (i = 0; i < ARRAY_SIZE(formats); i++)	\
> > +			if (formats[i]._field == _fmt)		\
> > +				format = &formats[i];		\
> > +								\
> > +		format;						\
> > +	})
> > +
> > +/**
> > + * __image_format_drm_lookup - query information for a given format
> > + * @drm: DRM fourcc pixel format (DRM_FORMAT_*)
> > + *
> > + * The caller should only pass a supported pixel format to this function.
> > + *
> > + * Returns:
> > + * The instance of struct image_format_info that describes the pixel format, or
> > + * NULL if the format is unsupported.
> > + */
> > +const struct image_format_info *__image_format_drm_lookup(u32 drm)
> > +{
> > +	return __image_format_lookup(drm_fmt, drm);
> > +}
> > +EXPORT_SYMBOL(__image_format_drm_lookup);
> > +
> > +/**
> > + * image_format_drm_lookup - query information for a given format
> > + * @drm: DRM fourcc pixel format (DRM_FORMAT_*)
> > + *
> > + * The caller should only pass a supported pixel format to this function.
> > + * Unsupported pixel formats will generate a warning in the kernel log.
> > + *
> > + * Returns:
> > + * The instance of struct image_format_info that describes the pixel format, or
> > + * NULL if the format is unsupported.
> > + */
> > +const struct image_format_info *image_format_drm_lookup(u32 drm)
> > +{
> > +	const struct image_format_info *format;
> > +
> > +	format = __image_format_drm_lookup(drm);
> > +
> > +	WARN_ON(!format);
> > +	return format;
> > +}
> > +EXPORT_SYMBOL(image_format_drm_lookup);
> > 

