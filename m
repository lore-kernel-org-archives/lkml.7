Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD7FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75107215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfKHPJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:09:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60112 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKHPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:09:12 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iT5sY-0001pZ-Ns; Fri, 08 Nov 2019 16:08:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Date:   Fri, 08 Nov 2019 16:08:50 +0100
Message-ID: <17879396.dXe580Ps6o@diego>
In-Reply-To: <20191009145008.GB16989@phenom.ffwll.local>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com> <1569486289-152061-2-git-send-email-hjc@rock-chips.com> <20191009145008.GB16989@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Sandy,

Am Mittwoch, 9. Oktober 2019, 16:50:08 CET schrieb Daniel Vetter:
> On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> > These new format is supported by some rockchip socs:
> > 
> > DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> > DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> > DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
> > 
> > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > ---
> >  drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
> >  include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index c630064..ccd78a3 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >  		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
> >  		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
> >  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> > +		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
> > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> >  		{ .format = DRM_FORMAT_P210,		.depth = 0,
> >  		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
> >  		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,
> 
> Yup this is what I had in mind with using the block stuff to describe your
> new 10bit yuv formats. Thanks for respining.
> 
> Once we've nailed the exact bit description of the format precisely this
> can be merged imo.

I just saw this series still sitting in my inbox, so was wondering about the
"once we've nailed the exact bit description..." and what is missing for that.

Thanks
Heiko


> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 3feeaa3..08e2221 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -238,6 +238,20 @@ extern "C" {
> >  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
> >  
> >  /*
> > + * 2 plane YCbCr
> > + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> > + * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
> > + * or
> > + * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> > + */
> > +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> > +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> > +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> > +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> > +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> > +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> > +
> > +/*
> >   * 2 plane YCbCr MSB aligned
> >   * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> >   * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> 
> 




