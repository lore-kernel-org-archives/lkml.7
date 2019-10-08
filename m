Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F1DECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9119521721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfJHLdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:33:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:27247 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730812AbfJHLdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:33:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 04:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="187267995"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 08 Oct 2019 04:33:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 08 Oct 2019 14:33:38 +0300
Date:   Tue, 8 Oct 2019 14:33:38 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "sandy.huang" <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Message-ID: <20191008113338.GP1208@intel.com>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
 <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
 <20190930104849.GA1208@intel.com>
 <2c46d532-f810-392d-b9c0-3b9aaccae7f4@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c46d532-f810-392d-b9c0-3b9aaccae7f4@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:40:20AM +0800, sandy.huang wrote:
> Hi ville syrjala,
> 
> 在 2019/9/30 下午6:48, Ville Syrjälä 写道:
> > On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> >> These new format is supported by some rockchip socs:
> >>
> >> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> >> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> >> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
> >>
> >> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> >> ---
> >>   drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
> >>   include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
> >>   2 files changed, 32 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> >> index c630064..ccd78a3 100644
> >> --- a/drivers/gpu/drm/drm_fourcc.c
> >> +++ b/drivers/gpu/drm/drm_fourcc.c
> >> @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >>   		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
> >>   		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
> >>   		  .hsub = 2, .vsub = 2, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> >> +		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
> >> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> >> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> >>   		{ .format = DRM_FORMAT_P210,		.depth = 0,
> >>   		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
> >>   		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,
> >> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> >> index 3feeaa3..08e2221 100644
> >> --- a/include/uapi/drm/drm_fourcc.h
> >> +++ b/include/uapi/drm/drm_fourcc.h
> >> @@ -238,6 +238,20 @@ extern "C" {
> >>   #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
> >>   
> >>   /*
> >> + * 2 plane YCbCr
> >> + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> >> + * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
> >> + * or
> >> + * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> > So now you're defining it as some kind of byte aligned block.
> > With that specifying endianness would now make sense since
> > otherwise this tells us absolutely nothing about the memory
> > layout.
> >
> > So I'd either do that, or go back to not specifying anything and
> > use some weasel words like "mamory layout is implementation defined"
> > which of course means no one can use it for anything that involves
> > any kind of cross vendor stuff.
> /*
>   * 2 plane YCbCr
>   * index 0 = Y plane, [39: 0] Y3:Y2:Y1:Y0 10:10:10:10  little endian
>   * index 1 = Cb:Cr plane, [79: 0] Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 
> 10:10:10:10:10:10:10:10  little endian
>   * or
>   * index 1 = Cr:Cb plane, [79: 0] Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 
> 10:10:10:10:10:10:10:10  little endian
>   */
> 
> Is this description ok?

Seems OK to me, if it actually describes the format correctly.

Though I'm not sure why the CbCr is defines as an 80bit block
and Y has a 40bit block. 40bits should be enough for CbCr as well.

> 
> >> + */
> >> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> >> +
> >> +/*
> >>    * 2 plane YCbCr MSB aligned
> >>    * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> >>    * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> >> -- 
> >> 2.7.4
> >>
> >>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

-- 
Ville Syrjälä
Intel
