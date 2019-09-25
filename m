Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C4C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE21E21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S8u2T1Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbfIYLYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:24:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34557 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389351AbfIYLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:24:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so4464104otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+hkGJiRxWvy80JBX4xAVN7vmq9IRUZjlI+1BsjvFZQ=;
        b=S8u2T1Jrf3uaj0nLZlsuBOGl6oZRKCE6mlf3STSWtLbYB9p9+2ke784bsyfkvHk7z9
         wpwZ3xjZGYqVpW5xumhHxNqRTqIAb4Xiyx18XbR3L5a2aB6ZhhDpKAhey6DC9rnJeXGn
         t7R3VfFdo1xDEUYdCgN++oWXBxUIi+xN+VSBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+hkGJiRxWvy80JBX4xAVN7vmq9IRUZjlI+1BsjvFZQ=;
        b=Jww2E2E9CN9M2+mPs6EmlC2YZy6EIpQ7kN1qUdcC3mjfNiCz2b8llwhIELnCN13WAj
         DFdxxRtVMMT0mFN4IkFTH3kVhCz4/wW9OpEQc0cUOAEUBH6tUQlK9Rge4G33ChU0MZqX
         g2v58iOeNpY08JqS82HVONY3uQe/7wTAd12Ie5oXx3fXrwm/hcXx/uaNrN8RniIel55Y
         oFS38OdNeeFot7OQ/qlIF/r+TyiSpm4ZkdB1/gmESidAF+TK48ePvyNKICe08l8dOkyl
         u7d0W+4aoAPxRlS6R3Qlx1og+XuWpw7zXHQPlA3u0b9hoUCZ2B8L/NSGB6ZoXDgt+zUS
         9lAQ==
X-Gm-Message-State: APjAAAXvsnni/wlRd3+lQfpT2eN0W5HjSNj+xgFVw4HYYe15Ecpy0uFx
        YHqVgdFgNKL6yjzmY2BwJqpYQFCJfXWGga4EmufRcMdB
X-Google-Smtp-Source: APXvYqz0U3xmOqMGF5CBHGF7/2U9v/CZHjYOCqLstpdeac2+5JuKXwJ62baDY51wo9Lsb7Itofs6sS9kKnfFvLzRvOk=
X-Received: by 2002:a05:6830:17c1:: with SMTP id p1mr2978569ota.188.1569410642714;
 Wed, 25 Sep 2019 04:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
 <1569242365-182133-2-git-send-email-hjc@rock-chips.com> <CAKMK7uFSSoahOesvxL2jQVPXUhG=TuWE4GMfXEAkdTRNbAsp+w@mail.gmail.com>
 <63db669e-b463-a024-6b8b-73cafd236229@rock-chips.com>
In-Reply-To: <63db669e-b463-a024-6b8b-73cafd236229@rock-chips.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 25 Sep 2019 13:23:49 +0200
Message-ID: <CAKMK7uHM1LRmqX8RnVOnToPyMoVVHqtpcuY8FQ17tzrVkvx1YQ@mail.gmail.com>
Subject: Re: [PATCH 01/36] drm/fourcc: Add 2 plane YCbCr 10bit format support
To:     "sandy.huang" <hjc@rock-chips.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 8:46 AM sandy.huang <hjc@rock-chips.com> wrote:
>
>
> =E5=9C=A8 2019/9/23 =E4=B8=8B=E5=8D=889:06, Daniel Vetter =E5=86=99=E9=81=
=93:
> > On Mon, Sep 23, 2019 at 2:40 PM Sandy Huang <hjc@rock-chips.com> wrote:
> >> The drm_format_info.cpp[3] unit is BytePerPlane, when we add define
> >> 10bit YUV format, here have some problem.
> >> So we change cpp to bpp, use unit BitPerPlane to describe the data
> >> format.
> >>
> >> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > Whatever the layout you have for these (it's not really defined in
> > your patch here down to the level of detail we want) I think this
> > should be described with the block_h/w and char_per_block
> > functionality. Not by extending the legacy and depcrecated cpp
> > somehow.
> > -Daniel
>
> Hi Daniel,
>
> It seems the char_per_block and block_h/w can't describing the following
> data format:
>
> /*
>   * 2x2 subsampled Cr:Cb plane 10 bits per channel
>   * index 0 =3D Y plane, [9:0]
>   * index 1 =3D Cr:Cb plane, [19:0] Cr:x:Cb:x [19:0]
>   */

We can't allocate individual bits, buffers are always at least byte
aligned. And once you have that, you can actually do that.

Or maybe this is a lot more funnier format, which has aven
non-byte-aligned strides. Which would be rather surprising.

Anyway either needs a lot more comments, or just need to use the
infrastructure we have already. E.g. for your case: 4 pixels with 10
bits each gives you 5*8 =3D 40 bits of 5 bytes. So you very much can
describe this format accurately with the block layout stuff, with a
block size of 4 pixels wide and 1 pixel height and a byte size per
block of 5 bytes. Similar for the others.
-Daniel

>
> >> ---
> >>   drivers/gpu/drm/drm_client.c        |   4 +-
> >>   drivers/gpu/drm/drm_fb_helper.c     |   8 +-
> >>   drivers/gpu/drm/drm_format_helper.c |   4 +-
> >>   drivers/gpu/drm/drm_fourcc.c        | 172 +++++++++++++++++++-------=
----------
> >>   drivers/gpu/drm/drm_framebuffer.c   |   2 +-
> >>   include/drm/drm_fourcc.h            |   4 +-
> >>   include/uapi/drm/drm_fourcc.h       |  15 ++++
> >>   7 files changed, 115 insertions(+), 94 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client=
.c
> >> index d9a2e36..a36ffbe 100644
> >> --- a/drivers/gpu/drm/drm_client.c
> >> +++ b/drivers/gpu/drm/drm_client.c
> >> @@ -263,7 +263,7 @@ drm_client_buffer_create(struct drm_client_dev *cl=
ient, u32 width, u32 height, u
> >>
> >>          dumb_args.width =3D width;
> >>          dumb_args.height =3D height;
> >> -       dumb_args.bpp =3D info->cpp[0] * 8;
> >> +       dumb_args.bpp =3D info->bpp[0];
> >>          ret =3D drm_mode_create_dumb(dev, &dumb_args, client->file);
> >>          if (ret)
> >>                  goto err_delete;
> >> @@ -366,7 +366,7 @@ static int drm_client_buffer_addfb(struct drm_clie=
nt_buffer *buffer,
> >>          int ret;
> >>
> >>          info =3D drm_format_info(format);
> >> -       fb_req.bpp =3D info->cpp[0] * 8;
> >> +       fb_req.bpp =3D info->bpp[0];
> >>          fb_req.depth =3D info->depth;
> >>          fb_req.width =3D width;
> >>          fb_req.height =3D height;
> >> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_=
helper.c
> >> index a7ba5b4..b30e782 100644
> >> --- a/drivers/gpu/drm/drm_fb_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >> @@ -382,7 +382,7 @@ static void drm_fb_helper_dirty_blit_real(struct d=
rm_fb_helper *fb_helper,
> >>                                            struct drm_clip_rect *clip)
> >>   {
> >>          struct drm_framebuffer *fb =3D fb_helper->fb;
> >> -       unsigned int cpp =3D fb->format->cpp[0];
> >> +       unsigned int cpp =3D fb->format->bpp[0] / 8;
> >>          size_t offset =3D clip->y1 * fb->pitches[0] + clip->x1 * cpp;
> >>          void *src =3D fb_helper->fbdev->screen_buffer + offset;
> >>          void *dst =3D fb_helper->buffer->vaddr + offset;
> >> @@ -1320,14 +1320,14 @@ int drm_fb_helper_check_var(struct fb_var_scre=
eninfo *var,
> >>           * Changes struct fb_var_screeninfo are currently not pushed =
back
> >>           * to KMS, hence fail if different settings are requested.
> >>           */
> >> -       if (var->bits_per_pixel !=3D fb->format->cpp[0] * 8 ||
> >> +       if (var->bits_per_pixel !=3D fb->format->bpp[0] ||
> >>              var->xres > fb->width || var->yres > fb->height ||
> >>              var->xres_virtual > fb->width || var->yres_virtual > fb->=
height) {
> >>                  DRM_DEBUG("fb requested width/height/bpp can't fit in=
 current fb "
> >>                            "request %dx%d-%d (virtual %dx%d) > %dx%d-%=
d\n",
> >>                            var->xres, var->yres, var->bits_per_pixel,
> >>                            var->xres_virtual, var->yres_virtual,
> >> -                         fb->width, fb->height, fb->format->cpp[0] * =
8);
> >> +                         fb->width, fb->height, fb->format->bpp[0]);
> >>                  return -EINVAL;
> >>          }
> >>
> >> @@ -1678,7 +1678,7 @@ static void drm_fb_helper_fill_var(struct fb_inf=
o *info,
> >>          info->pseudo_palette =3D fb_helper->pseudo_palette;
> >>          info->var.xres_virtual =3D fb->width;
> >>          info->var.yres_virtual =3D fb->height;
> >> -       info->var.bits_per_pixel =3D fb->format->cpp[0] * 8;
> >> +       info->var.bits_per_pixel =3D fb->format->bpp[0];
> >>          info->var.accel_flags =3D FB_ACCELF_TEXT;
> >>          info->var.xoffset =3D 0;
> >>          info->var.yoffset =3D 0;
> >> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm=
_format_helper.c
> >> index 0897cb9..eea3afb 100644
> >> --- a/drivers/gpu/drm/drm_format_helper.c
> >> +++ b/drivers/gpu/drm/drm_format_helper.c
> >> @@ -36,7 +36,7 @@ static unsigned int clip_offset(struct drm_rect *cli=
p,
> >>   void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *f=
b,
> >>                     struct drm_rect *clip)
> >>   {
> >> -       unsigned int cpp =3D fb->format->cpp[0];
> >> +       unsigned int cpp =3D fb->format->bpp[0] / 8;
> >>          size_t len =3D (clip->x2 - clip->x1) * cpp;
> >>          unsigned int y, lines =3D clip->y2 - clip->y1;
> >>
> >> @@ -63,7 +63,7 @@ void drm_fb_memcpy_dstclip(void __iomem *dst, void *=
vaddr,
> >>                             struct drm_framebuffer *fb,
> >>                             struct drm_rect *clip)
> >>   {
> >> -       unsigned int cpp =3D fb->format->cpp[0];
> >> +       unsigned int cpp =3D fb->format->bpp[0] / 8;
> >>          unsigned int offset =3D clip_offset(clip, fb->pitches[0], cpp=
);
> >>          size_t len =3D (clip->x2 - clip->x1) * cpp;
> >>          unsigned int y, lines =3D clip->y2 - clip->y1;
> >> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc=
.c
> >> index c630064..071dc07 100644
> >> --- a/drivers/gpu/drm/drm_fourcc.c
> >> +++ b/drivers/gpu/drm/drm_fourcc.c
> >> @@ -157,89 +157,95 @@ EXPORT_SYMBOL(drm_get_format_name);
> >>   const struct drm_format_info *__drm_format_info(u32 format)
> >>   {
> >>          static const struct drm_format_info formats[] =3D {
> >> -               { .format =3D DRM_FORMAT_C8,              .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGB332,          .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGR233,          .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XRGB4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XBGR4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGBX4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGRX4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_ARGB4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ABGR4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGBA4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGRA4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_XRGB1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XBGR1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGBX5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGRX5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_ARGB1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ABGR1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGBA5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGRA5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGB565,          .depth =3D 1=
6, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGR565,          .depth =3D 1=
6, .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGB888,          .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGR888,          .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XRGB8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XBGR8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGBX8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGRX8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGB565_A8,       .depth =3D 2=
4, .num_planes =3D 2, .cpp =3D { 2, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGR565_A8,       .depth =3D 2=
4, .num_planes =3D 2, .cpp =3D { 2, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_XRGB2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XBGR2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_RGBX1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_BGRX1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_ARGB2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ABGR2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGBA1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGRA1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ARGB8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ABGR8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGBA8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGRA8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_XRGB16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_XBGR16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> -               { .format =3D DRM_FORMAT_ARGB16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_ABGR16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGB888_A8,       .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 3, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGR888_A8,       .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 3, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_XRGB8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 4, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_XBGR8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 4, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_RGBX8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 4, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_BGRX8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 4, 1, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true },
> >> -               { .format =3D DRM_FORMAT_YUV410,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 4, .vsub =3D 4, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVU410,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 4, .vsub =3D 4, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YUV411,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 4, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVU411,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 4, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YUV420,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 2, .vsub =3D 2, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVU420,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 2, .vsub =3D 2, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YUV422,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVU422,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YUV444,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVU444,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 1, 1, 1 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV12,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 2, .vsub =3D 2, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV21,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 2, .vsub =3D 2, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV16,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV61,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV24,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_NV42,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 1, 2, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YUYV,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_YVYU,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_UYVY,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_VYUY,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_XYUV8888,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_VUY888,          .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_AYUV,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true, .is_yuv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y210,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y212,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y216,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y410,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true, .is_yuv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y412,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true, .is_yuv =3D true },
> >> -               { .format =3D DRM_FORMAT_Y416,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_=
alpha =3D true, .is_yuv =3D true },
> >> -               { .format =3D DRM_FORMAT_XVYU2101010,     .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_XVYU12_16161616, .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> -               { .format =3D DRM_FORMAT_XVYU16161616,    .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_y=
uv =3D true },
> >> +               { .format =3D DRM_FORMAT_C8,              .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGB332,          .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGR233,          .depth =3D 8=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XRGB4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XBGR4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGBX4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGRX4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_ARGB4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ABGR4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGBA4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGRA4444,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_XRGB1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XBGR1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGBX5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGRX5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_ARGB1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ABGR1555,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGBA5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGRA5551,        .depth =3D 1=
5, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGB565,          .depth =3D 1=
6, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGR565,          .depth =3D 1=
6, .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGB888,          .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 24, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGR888,          .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 24, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XRGB8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XBGR8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGBX8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGRX8888,        .depth =3D 2=
4, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGB565_A8,       .depth =3D 2=
4, .num_planes =3D 2, .cpp =3D { 16, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGR565_A8,       .depth =3D 2=
4, .num_planes =3D 2, .cpp =3D { 16, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_XRGB2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XBGR2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_RGBX1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_BGRX1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_ARGB2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ABGR2101010,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGBA1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGRA1010102,     .depth =3D 3=
0, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ARGB8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ABGR8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGBA8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGRA8888,        .depth =3D 3=
2, .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_XRGB16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_XBGR16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1 },
> >> +               { .format =3D DRM_FORMAT_ARGB16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_ABGR16161616F,   .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGB888_A8,       .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 24, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGR888_A8,       .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 24, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_XRGB8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 32, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_XBGR8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 32, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_RGBX8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 32, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_BGRX8888_A8,     .depth =3D 3=
2, .num_planes =3D 2, .cpp =3D { 32, 8, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true },
> >> +               { .format =3D DRM_FORMAT_YUV410,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 4, .vsub =3D 4, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVU410,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 4, .vsub =3D 4, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YUV411,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 4, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVU411,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 4, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YUV420,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 2, .vsub =3D 2, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVU420,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 2, .vsub =3D 2, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YUV422,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVU422,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YUV444,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVU444,          .depth =3D 0=
,  .num_planes =3D 3, .cpp =3D { 8, 8, 8 },  .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV12,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 2, .vsub =3D 2, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV21,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 2, .vsub =3D 2, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV16,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV61,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV24,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV42,            .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 8, 16, 0 }, .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV12_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 2, .vsub =3D 2, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV21_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 2, .vsub =3D 2, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV16_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 2, .vsub =3D 1, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV61_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 2, .vsub =3D 1, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV24_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 1, .vsub =3D 1, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_NV42_10,         .depth =3D 0=
,  .num_planes =3D 2, .cpp =3D { 10, 20, 0 }, .hsub =3D 1, .vsub =3D 1, .is=
_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YUYV,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_YVYU,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_UYVY,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_VYUY,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 16, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_XYUV8888,        .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_VUY888,          .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 24, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_AYUV,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true, .is_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y210,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y212,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y216,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y410,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true, .is_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y412,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true, .is_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_Y416,            .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .has=
_alpha =3D true, .is_yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_XVYU2101010,     .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 32, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_XVYU12_16161616, .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >> +               { .format =3D DRM_FORMAT_XVYU16161616,    .depth =3D 0=
,  .num_planes =3D 1, .cpp =3D { 8, 0, 0 },  .hsub =3D 1, .vsub =3D 1, .is_=
yuv =3D true },
> >>                  { .format =3D DRM_FORMAT_Y0L0,            .depth =3D =
0,  .num_planes =3D 1,
> >>                    .char_per_block =3D { 8, 0, 0 }, .block_w =3D { 2, =
0, 0 }, .block_h =3D { 2, 0, 0 },
> >>                    .hsub =3D 2, .vsub =3D 2, .has_alpha =3D true, .is_=
yuv =3D true },
> >> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_f=
ramebuffer.c
> >> index 0b72468..7b29e97 100644
> >> --- a/drivers/gpu/drm/drm_framebuffer.c
> >> +++ b/drivers/gpu/drm/drm_framebuffer.c
> >> @@ -530,7 +530,7 @@ int drm_mode_getfb(struct drm_device *dev,
> >>          r->height =3D fb->height;
> >>          r->width =3D fb->width;
> >>          r->depth =3D fb->format->depth;
> >> -       r->bpp =3D fb->format->cpp[0] * 8;
> >> +       r->bpp =3D fb->format->bpp[0];
> >>          r->pitch =3D fb->pitches[0];
> >>
> >>          /* GET_FB() is an unprivileged ioctl so we must not return a
> >> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> >> index 306d1ef..021358d 100644
> >> --- a/include/drm/drm_fourcc.h
> >> +++ b/include/drm/drm_fourcc.h
> >> @@ -73,12 +73,12 @@ struct drm_format_info {
> >>                  /**
> >>                   * @cpp:
> >>                   *
> >> -                * Number of bytes per pixel (per plane), this is alia=
sed with
> >> +                * Number of bits per pixel (per plane), this is alias=
ed with
> >>                   * @char_per_block. It is deprecated in favour of usi=
ng the
> >>                   * triplet @char_per_block, @block_w, @block_h for be=
tter
> >>                   * describing the pixel format.
> >>                   */
> >> -               u8 cpp[3];
> >> +               u8 bpp[3];
> >>
> >>                  /**
> >>                   * @char_per_block:
> >> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_four=
cc.h
> >> index 3feeaa3..5fe89e9 100644
> >> --- a/include/uapi/drm/drm_fourcc.h
> >> +++ b/include/uapi/drm/drm_fourcc.h
> >> @@ -266,6 +266,21 @@ extern "C" {
> >>   #define DRM_FORMAT_P016                fourcc_code('P', '0', '1', '6=
') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
> >>
> >>   /*
> >> + * 2 plane YCbCr 10bit
> >> + * index 0 =3D Y plane, [9:0] Y
> >> + * index 1 =3D Cr:Cb plane, [19:0] Cr:Cb little endian
> >> + * or
> >> + * index 1 =3D Cb:Cr plane, [19:0] Cb:Cr little endian
> >> + */
> >> +
> >> +#define DRM_FORMAT_NV12_10     fourcc_code('N', 'A', '1', '2') /* 2x2=
 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV21_10     fourcc_code('N', 'A', '2', '1') /* 2x2=
 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV16_10     fourcc_code('N', 'A', '1', '6') /* 2x1=
 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV61_10     fourcc_code('N', 'A', '6', '1') /* 2x1=
 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV24_10     fourcc_code('N', 'A', '2', '4') /* non=
-subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV42_10     fourcc_code('N', 'A', '4', '2') /* non=
-subsampled Cb:Cr plane */
> >> +
> >> +/*
> >>    * 3 plane YCbCr
> >>    * index 0: Y plane, [7:0] Y
> >>    * index 1: Cb plane, [7:0] Cb
> >> --
> >> 2.7.4
> >>
> >>
> >>
> >
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
