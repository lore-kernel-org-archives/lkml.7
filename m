Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C3C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7331721773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfDQMli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:41:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:49137 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfDQMli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:41:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 05:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="132141962"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2019 05:41:33 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 62E01204DA; Wed, 17 Apr 2019 15:41:32 +0300 (EEST)
Date:   Wed, 17 Apr 2019 15:41:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 19/20] lib: image-formats: Add more functions
Message-ID: <20190417124131.febnqtpp6oetbafs@paasikivi.fi.intel.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <382f72c5938f538c8489cb2032050f4be252ad59.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382f72c5938f538c8489cb2032050f4be252ad59.1555487650.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Apr 17, 2019 at 09:54:45AM +0200, Maxime Ripard wrote:
> V4L2 drivers typically need a few more helpers compared to DRM drivers, so
> let's add them.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  include/linux/image-formats.h | 42 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+)
> 
> diff --git a/include/linux/image-formats.h b/include/linux/image-formats.h
> index b78b8e861fc9..a2cf3528bd31 100644
> --- a/include/linux/image-formats.h
> +++ b/include/linux/image-formats.h
> @@ -388,6 +388,48 @@ uint64_t image_format_info_min_pitch(const struct image_format_info *info,
>  			    image_format_info_block_height(info, plane));
>  }
>  
> +/**
> + * image_format_info_plane_stride - determine the stride value
> + * @format: pointer to the image_format_info
> + * @width: plane width
> + * @plane: plane index
> + *
> + * Returns:
> + * The bytes per pixel value for the specified plane.

In V4L2 the bytesperline (stride) value is user configurable and is also
subject to hardware capabilities. So effectively this makes what the
function returns a minimum value for a given format. I think you could add
this to the documentation. This is also not the number of bytes per pixel,
as suggested above. So, e.g.

	Returns the minimum number of bytes between two consecutive lines.

> + */
> +static inline
> +unsigned int image_format_info_plane_stride(const struct image_format_info *format,
> +					    unsigned int width, int plane)
> +{
> +	if (!format || plane >= format->num_planes)
> +		return 0;
> +
> +	return image_format_info_plane_width(format, width, plane) *
> +		image_format_info_plane_cpp(format, plane);
> +}
> +
> +/**
> + * image_format_info_plane_size - determine the size value
> + * @format: pointer to the image_format_info
> + * @width: plane width
> + * @height: plane width
> + * @plane: plane index
> + *
> + * Returns:
> + * The size of the plane buffer.

Similarly:

	Returns the minimum size of the plane buffer.

With these,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> + */
> +static inline
> +unsigned int image_format_info_plane_size(const struct image_format_info *format,
> +					  unsigned int width, unsigned int height,
> +					  int plane)
> +{
> +	if (!format || plane >= format->num_planes)
> +		return 0;
> +
> +	return image_format_info_plane_stride(format, width, plane) *
> +		image_format_info_plane_height(format, height, plane);
> +}
> +
>  const struct image_format_info *__image_format_drm_lookup(u32 drm);
>  const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2);
>  const struct image_format_info *image_format_drm_lookup(u32 drm);

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
