Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3CCC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BA420650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LujxeDo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfJNIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:34:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40364 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfJNIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:34:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so14037225edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ev3/tmiBvz1CL+AFRiajlcGRmBwNYmqYly8acElmmc4=;
        b=LujxeDo8Wu48fn3frx1lWXSQXTwgaUca13SemyA/tNhyZSgBQcdcboiEiYxpyhkFdU
         1vNZSJjS0Rm/fhTXjRxrwOpG4xipVjGwRIUDF4iRDf2M8vwPYKXZ1PXPTvXKDbJgRW14
         FwhelFgxVEL2pMLavAOnbUrkvtprLvSUOBspA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ev3/tmiBvz1CL+AFRiajlcGRmBwNYmqYly8acElmmc4=;
        b=ZUjb4fBlG4anrr70n0nQuhNQoYWaFVfcxQs/2HkQ+MJE2lLCyrYpqtcYOzBEDjFINo
         I+2TL7XoR+3bBPKnutOu6hmg5VoYcgOv97y7gWOIlFMebqQYI8vwdOw4on7UtKfZ7Q0L
         l0lcc2aXGWS6lMtLuTOyaRAmkvVHDcgZPja/l2kMMV4BREmSknuxonfBBOhZOOE3H5df
         q+GwlosOPKW80/PfYAAN9BVeYVxdKwOHa06JDjuQrhXdDAbsErQgX9A2f5MeoZS9AQQY
         BaagC/favps/AAIfS3e+t4v5jabTl5CkKRzNUHHgO7TA5l9VyykWmGD28ShkC39kVE+a
         5Q3w==
X-Gm-Message-State: APjAAAVnBPHAyCY22KMP3SCSdI2KWy4KoXf0oR6Fj2pI6iIzrwChihNB
        qMFR7d/EzVGJLqTGPjePcp27mw==
X-Google-Smtp-Source: APXvYqzdU3vUBf6ebA7tEk/9vdIXbVK/y31TQce6DV0kVJ6chOS2f22F44l/F9oRE4U9O9bE2V8auw==
X-Received: by 2002:a17:907:366:: with SMTP id rs6mr27382876ejb.232.1571042062825;
        Mon, 14 Oct 2019 01:34:22 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id e44sm3028623ede.34.2019.10.14.01.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:34:22 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:34:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "sandy.huang" <hjc@rock-chips.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Message-ID: <20191014083420.GB11828@phenom.ffwll.local>
Mail-Followup-To: "sandy.huang" <hjc@rock-chips.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        Sean Paul <sean@poorly.run>
References: <2c46d532-f810-392d-b9c0-3b9aaccae7f4@rock-chips.com>
 <20191008113338.GP1208@intel.com>
 <a5fa3d8e-9e8e-8aa8-8abb-f00e8357acb5@rock-chips.com>
 <eafa5b37-e132-ad37-3876-384ac5ec9584@rock-chips.com>
 <20191011064433.GA18503@jamwan02-TSP300>
 <5c932cb6-fdfb-88db-3757-4c1b602d4778@rock-chips.com>
 <20191011072250.GA20592@jamwan02-TSP300>
 <f4828cab-da7e-1658-51e7-0d123cfdbdf9@rock-chips.com>
 <20191011083247.GA22224@jamwan02-TSP300>
 <dd1afe6b-9762-e8dc-c281-b0c0ff31891c@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd1afe6b-9762-e8dc-c281-b0c0ff31891c@rock-chips.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:45:45PM +0800, sandy.huang wrote:
> Hi, james, ville syrjala, david,
> 
> 在 2019/10/11 下午4:32, james qian wang (Arm Technology China) 写道:
> > On Fri, Oct 11, 2019 at 03:32:17PM +0800, sandy.huang wrote:
> > > 在 2019/10/11 下午3:22, james qian wang (Arm Technology China) 写道:
> > > > On Fri, Oct 11, 2019 at 03:07:22PM +0800, sandy.huang wrote:
> > > > > 在 2019/10/11 下午2:44, james qian wang (Arm Technology China) 写道:
> > > > > > On Fri, Oct 11, 2019 at 11:35:53AM +0800, sandy.huang wrote:
> > > > > > > Hi james.qian.wang,
> > > > > > > 
> > > > > > >        Thank for you remind, fou some unknow reason, i miss the the mail from
> > > > > > > you:(, i get this message from https://patchwork.kernel.org/patch/11161937/
> > > > > > > 
> > > > > > > sorry about that.
> > > > > > > 
> > > > > > >        About the format block describe, I also found some unreasonable,  this
> > > > > > > format need 2 line aligned, so the block_h need to sed as 2, and the
> > > > > > > char_per_block need set as w * h * 10 for y plane, and w * h * 2 * 10 for uv
> > > > > > > plane, so the following describe maybe more correct, thanks.
> > > > > > > 
> > > > > > >            { .format = DRM_FORMAT_NV12_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > Hi Sandy:
> > > > > > I think for such NV12 YUV-422 (hsub = 2, vsub = 2) 2x2 subsampled format
> > > > > > the block size can be:
> > > > > > 
> > > > > > the Y plane:  2x2;
> > > > > > The UV plane: 1x2; (H direction sample 1 Cb and 1Cr, V direction 2 lines got 2)
> > > > > > 
> > > > > > Then:
> > > > > > 
> > > > > > .char_per_block = {5, 5, 0} block_w = {2, 1, 0}. block_h = {2, 2, 0};
> > > > > > 
> > > > > > Thanks
> > > > > > James
> > > > > Hi James,
> > > > > 
> > > > > If the block_w is 2 pixel, one line size at block is 2*10 bit %8 != 0,
> > > > Hi Sandy:
> > > > you got a mistake here, the bpp of UV plane is 20, 10bit Cb + 10 bit Cr.
> > > here is for y plane.
> > Sorry, Are we talking about the block size calcaltion here ?
> > 
> > block_size = block_w * block_h * plane_bpp
> > 
> > for you Y plane a 2x2 block is: 2 x 2 * 10 bpp = 40bits
> > 
> > And the block info is for computing the minimum pitch, and don't
> > consider the specific hardware alignment here.
> > 
> > see: drm_format_info_min_pitch()
> > 
> > If you hardware need alignment, you need to put that consideration into your
> > specific driver.
> > 
> > James.
> 
> Hi david and ville syrjala,
> 
>     Do you have any Suggestions?
> 
>     James think Y plane 2x2 block size is enough to describe this format,
> but i prefer to use 4x2 block size, this can include the alignment message.
> 
> just like the malidp_de_plane_check()@malidp_plane.c have the following 
> code, here use the block size to check alignment.
> 
>     block_w = drm_format_info_block_width(fb->format, 0);
>     block_h = drm_format_info_block_height(fb->format, 0);
>     if (fb->width % block_w || fb->height % block_h) {
>         DRM_DEBUG_KMS("Buffer width/height needs to be a multiple of tile
> sizes");
>         return -EINVAL;
>     }
>     if ((state->src_x >> 16) % block_w || (state->src_y >> 16) % block_h) {
>         DRM_DEBUG_KMS("Plane src_x/src_y needs to be a multiple of tile
> sizes");
>         return -EINVAL;
>     }
> 
> can you give me some suggestions?

For the linear layout (i.e. modifier == 0) the blocks are meant to be laid
out one after the other, linearly, in memory. If you have some additional
hw alignment constraint then that should be checked in the driver.

If you have some tiling on top, then that should be encoded in a different
modifier (which can then set its own block sizes, and have its own rules
for how they're laid out in memory).

Taking this all together I think what we want here is a 1x4 Y block and a
1x2 UV block size in pixels. The sub-sampling is expressed in hsub/vsub
for the UV plane, we don't align the block-sizes two 2 rows to encode that
(see all the other yuv planar formats for examples).
-Daniel

> 
> thanks,
> 
> sandy.huang
> 
> > 
> > > > > although we use block to describe this format, but actually the data is
> > > > > still stored one line by one line, still need 4 pixel aligned. so i think
> > > > > here need use 4pixel*2line for per block
> > > > I think this is your hardware specific requirement.
> > > > 
> > > > Thanks
> > > > James
> > > yes, this is a new format first used at rockchip platform.
> > > 
> > > 
> > > Thanks,
> > > 
> > > sandy.huang
> > > 
> > > > > Thanks,
> > > > > 
> > > > > sandy.huang.
> > > > > 
> > > > > > >              .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > >            { .format = DRM_FORMAT_NV21_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > >            { .format = DRM_FORMAT_NV16_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 2, .vsub = 1, .is_yuv = true},
> > > > > > >            { .format = DRM_FORMAT_NV61_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 2, .vsub = 1, .is_yuv = true},
> > > > > > >            { .format = DRM_FORMAT_NV24_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 1, .vsub = 1, .is_yuv = true},
> > > > > > >            { .format = DRM_FORMAT_NV42_10,        .depth = 0, .num_planes = 2,
> > > > > > >              .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
> > > > > > > = { 2, 2, 0 },
> > > > > > >              .hsub = 1, .vsub = 1, .is_yuv = true},
> > > > > > > 
> > > > > > > 
> > > > > > > > >              { .format = DRM_FORMAT_P016,        .depth = 0,  .num_planes =
> > > > > > > 2,
> > > > > > > > >                .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 },
> > > > > > > .block_h = { 1, 0, 0 },
> > > > > > > > >                .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > > > > +        { .format = DRM_FORMAT_NV12_10,        .depth = 0,  .num_planes
> > > > > > > = 2,
> > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 },
> > > > > > > .block_h = { 4, 4, 0 },
> > > > > > > 
> > > > > > > > Hi Sandy:
> > > > > > > > Their is a problem here for char_per_block size of plane[0]:
> > > > > > > > Since: 5 * 8 != 4 * 4 * 10;
> > > > > > > > Seems you mis-set the block_w/h, per your block size the block is 2x2, and
> > > > > > > it should be:
> > > > > > > >      .char_per_block = { 5, 10, 0 }, .block_w = { 2, 2, 0 }, .block_h = { 2,
> > > > > > > 2, 0 },
> > > > > > > 
> > > > > > > > Best Regards:
> > > > > > > > James
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 在 2019/10/8 下午7:49, sandy.huang 写道:
> > > > > > > > 在 2019/10/8 下午7:33, Ville Syrjälä 写道:
> > > > > > > > > On Tue, Oct 08, 2019 at 10:40:20AM +0800, sandy.huang wrote:
> > > > > > > > > > Hi ville syrjala,
> > > > > > > > > > 
> > > > > > > > > > 在 2019/9/30 下午6:48, Ville Syrjälä 写道:
> > > > > > > > > > > On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> > > > > > > > > > > > These new format is supported by some rockchip socs:
> > > > > > > > > > > > 
> > > > > > > > > > > > DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> > > > > > > > > > > > DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> > > > > > > > > > > > DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >       drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
> > > > > > > > > > > >       include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
> > > > > > > > > > > >       2 files changed, 32 insertions(+)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git a/drivers/gpu/drm/drm_fourcc.c
> > > > > > > > > > > > b/drivers/gpu/drm/drm_fourcc.c
> > > > > > > > > > > > index c630064..ccd78a3 100644
> > > > > > > > > > > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > > > > > > > > > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > > > > > > > > > > @@ -261,6 +261,24 @@ const struct drm_format_info
> > > > > > > > > > > > *__drm_format_info(u32 format)
> > > > > > > > > > > >               { .format = DRM_FORMAT_P016,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > >                 .char_per_block = { 2, 4, 0 }, .block_w = {
> > > > > > > > > > > > 1, 0, 0 }, .block_h = { 1, 0, 0 },
> > > > > > > > > > > >                 .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV12_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV21_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 2, .vsub = 2, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV16_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 2, .vsub = 1, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV61_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 2, .vsub = 1, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV24_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 1, .vsub = 1, .is_yuv = true},
> > > > > > > > > > > > +        { .format = DRM_FORMAT_NV42_10,        .depth =
> > > > > > > > > > > > 0,  .num_planes = 2,
> > > > > > > > > > > > +          .char_per_block = { 5, 10, 0 }, .block_w = {
> > > > > > > > > > > > 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > > > > > > > > > > +          .hsub = 1, .vsub = 1, .is_yuv = true},
> > > > > > > > > > > >               { .format = DRM_FORMAT_P210,        .depth = 0,
> > > > > > > > > > > >                 .num_planes = 2, .char_per_block = { 2, 4, 0 },
> > > > > > > > > > > >                 .block_w = { 1, 0, 0 }, .block_h = { 1, 0,
> > > > > > > > > > > > 0 }, .hsub = 2,
> > > > > > > > > > > > diff --git a/include/uapi/drm/drm_fourcc.h
> > > > > > > > > > > > b/include/uapi/drm/drm_fourcc.h
> > > > > > > > > > > > index 3feeaa3..08e2221 100644
> > > > > > > > > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > > > > > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > > > > > > > @@ -238,6 +238,20 @@ extern "C" {
> > > > > > > > > > > >       #define DRM_FORMAT_NV42        fourcc_code('N', 'V',
> > > > > > > > > > > > '4', '2') /* non-subsampled Cb:Cr plane */
> > > > > > > > > > > >          /*
> > > > > > > > > > > > + * 2 plane YCbCr
> > > > > > > > > > > > + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> > > > > > > > > > > > + * index 1 = Cb:Cr plane,
> > > > > > > > > > > > Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
> > > > > > > > > > > > + * or
> > > > > > > > > > > > + * index 1 = Cr:Cb plane,
> > > > > > > > > > > > Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> > > > > > > > > > > So now you're defining it as some kind of byte aligned block.
> > > > > > > > > > > With that specifying endianness would now make sense since
> > > > > > > > > > > otherwise this tells us absolutely nothing about the memory
> > > > > > > > > > > layout.
> > > > > > > > > > > 
> > > > > > > > > > > So I'd either do that, or go back to not specifying anything and
> > > > > > > > > > > use some weasel words like "mamory layout is implementation defined"
> > > > > > > > > > > which of course means no one can use it for anything that involves
> > > > > > > > > > > any kind of cross vendor stuff.
> > > > > > > > > > /*
> > > > > > > > > >       * 2 plane YCbCr
> > > > > > > > > >       * index 0 = Y plane, [39: 0] Y3:Y2:Y1:Y0 10:10:10:10 little endian
> > > > > > > > > >       * index 1 = Cb:Cr plane, [79: 0] Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0
> > > > > > > > > > 10:10:10:10:10:10:10:10  little endian
> > > > > > > > > >       * or
> > > > > > > > > >       * index 1 = Cr:Cb plane, [79: 0] Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0
> > > > > > > > > > 10:10:10:10:10:10:10:10  little endian
> > > > > > > > > >       */
> > > > > > > > > > 
> > > > > > > > > > Is this description ok?
> > > > > > > > > Seems OK to me, if it actually describes the format correctly.
> > > > > > > > > 
> > > > > > > > > Though I'm not sure why the CbCr is defines as an 80bit block
> > > > > > > > > and Y has a 40bit block. 40bits should be enough for CbCr as well.
> > > > > > > > > 
> > > > > > > > well, this is taken into account yuv444,  4 y point corresponding with 4
> > > > > > > > uv point.
> > > > > > > > 
> > > > > > > > if only describes the layout memory, here can change to 40bit block.
> > > > > > > > 
> > > > > > > > thanks.
> > > > > > > > 
> > > > > > > > > > > > + */
> > > > > > > > > > > > +#define DRM_FORMAT_NV12_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '1', '2') /* 2x2 subsampled Cr:Cb plane */
> > > > > > > > > > > > +#define DRM_FORMAT_NV21_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '2', '1') /* 2x2 subsampled Cb:Cr plane */
> > > > > > > > > > > > +#define DRM_FORMAT_NV16_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '1', '6') /* 2x1 subsampled Cr:Cb plane */
> > > > > > > > > > > > +#define DRM_FORMAT_NV61_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '6', '1') /* 2x1 subsampled Cb:Cr plane */
> > > > > > > > > > > > +#define DRM_FORMAT_NV24_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '2', '4') /* non-subsampled Cr:Cb plane */
> > > > > > > > > > > > +#define DRM_FORMAT_NV42_10    fourcc_code('N', 'A',
> > > > > > > > > > > > '4', '2') /* non-subsampled Cb:Cr plane */
> > > > > > > > > > > > +
> > > > > > > > > > > > +/*
> > > > > > > > > > > >        * 2 plane YCbCr MSB aligned
> > > > > > > > > > > >        * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> > > > > > > > > > > >        * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x
> > > > > > > > > > > > [10:6:10:6] little endian
> > > > > > > > > > > > -- 
> > > > > > > > > > > > 2.7.4
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > _______________________________________________
> > > > > > > > > > > > dri-devel mailing list
> > > > > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > > > > _______________________________________________
> > > > > > > > dri-devel mailing list
> > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
