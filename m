Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D5C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635CF206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYzMKyTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLTTm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:42:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43768 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:42:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so10482445wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Il1oF0g3ydughv8Jds3YmOufzmr6Qzx+GD4OK+haAtA=;
        b=PYzMKyTpUL0K26WI+Dr6m1u9kWHpKKbZXQiSG0uoqZQAS46qonqRLrJ6rHzuxQHVE4
         yTTSeMlZlsEI5X/IyrYu8mNqVYOKCTi0szti9CVKA0nQhuCnREJO/+5H9PGZbYG/YQHI
         ktd+sIy5QrTGEAbaZDASuQV1k9EzdA4p23+wvd62/ktHw61PMKY9Ocj5yrNblluyNKfy
         XZp0ZFxSTrNOvGxvxNfOXS1X/DLKRSe/JgU5tGGLOu+xbNOQYVCx921LS4/RMRttWNNV
         Y301Zh3lq64UXVN0WHcs6VmRDbj1H8YvEsgb2Ct3p++lZe0hyHcWCCuFxRVC3Iv1142g
         P1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il1oF0g3ydughv8Jds3YmOufzmr6Qzx+GD4OK+haAtA=;
        b=IF0LJbDhUwAlVtwvXlWdl0vwghwS8ajTNUK30e4jPXcC/e0wG9rPpGqlvyqrucOef7
         WKXkEUdTHm+Bg+kxr3pLClYvAEvPQ3WZxTV+RuZtmnqStRRwWTkEMY39Px8DVhSTp40o
         Fj3FykcJrJc42xFLeyliF5bkyL+iJEwREaG+6IuYi0Vh/pisQZsJ0q1XFCTxPfu9Dbe5
         Fg7nlWD9IFOs9MNTaNfRYrWhEzSu02I7j78FO9NuU6TeLlWVrQcrHiFT/HubY4MN9S0u
         0PCViZLy0+ttaLqM+H+RVMg9Nbgm78iDks+EATMU8MYBDZi7jHgkmw4KaZ/bWykoNR2j
         0Srg==
X-Gm-Message-State: APjAAAXGzLgKWDDljDMGET5TK3GCRpk18e1+rGYWmmd0jf6m6DQdmDhr
        nyWdG12pDVFMVJuKu5v1PVeUgWSyetfX+oLDQkw=
X-Google-Smtp-Source: APXvYqwS3x4ycvpu21JJuqMEX6UIs51kUKgvD6zRDQswANHwI6xv7rw2TIDsASMikMs8u5f31Yyr/YGm/upuu+kif0c=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr13744281wrq.206.1576870944945;
 Fri, 20 Dec 2019 11:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20191202214713.41001-1-thomasanderson@google.com>
 <20191210185924.GA20941@google.com> <20191219233303.GA131109@google.com>
In-Reply-To: <20191219233303.GA131109@google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Dec 2019 14:42:13 -0500
Message-ID: <CADnq5_OtVFEuiM9eByRpkPX9Vhgu0Oq0aCzbctxOSTL1XJcm7w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max
 clock is exceeded
To:     Tom Anderson <thomasanderson@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:10 AM Tom Anderson <thomasanderson@google.com> wrote:
>
> Ping.  Is there any action required to get this landed?

Looks good to me, but I'd like to hear from the display guys.

Alex


>
> On Tue, Dec 10, 2019 at 10:59:24AM -0800, Tom Anderson wrote:
> > Friendly ping.
> >
> > On Mon, Dec 02, 2019 at 01:47:13PM -0800, Thomas Anderson wrote:
> > > For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
> > > formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
> > > "interesting" modes would be disabled, leaving only low-res or low
> > > framerate modes.
> > >
> > > This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
> > > clock is exceeded. Verified that 8K30 and 4K120 are now available and
> > > working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.
> > >
> > > Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> > > ---
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
> > >  1 file changed, 23 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 7aac9568d3be..803e59d97411 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> > >     return color_space;
> > >  }
> > >
> > > -static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
> > > -{
> > > -   if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > > -           return;
> > > -
> > > -   timing_out->display_color_depth--;
> > > -}
> > > -
> > > -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> > > -                                           const struct drm_display_info *info)
> > > +static bool adjust_colour_depth_from_display_info(
> > > +   struct dc_crtc_timing *timing_out,
> > > +   const struct drm_display_info *info)
> > >  {
> > > +   enum dc_color_depth depth = timing_out->display_color_depth;
> > >     int normalized_clk;
> > > -   if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > > -           return;
> > >     do {
> > >             normalized_clk = timing_out->pix_clk_100hz / 10;
> > >             /* YCbCr 4:2:0 requires additional adjustment of 1/2 */
> > >             if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
> > >                     normalized_clk /= 2;
> > >             /* Adjusting pix clock following on HDMI spec based on colour depth */
> > > -           switch (timing_out->display_color_depth) {
> > > +           switch (depth) {
> > > +           case COLOR_DEPTH_888:
> > > +                   break;
> > >             case COLOR_DEPTH_101010:
> > >                     normalized_clk = (normalized_clk * 30) / 24;
> > >                     break;
> > > @@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
> > >                     normalized_clk = (normalized_clk * 48) / 24;
> > >                     break;
> > >             default:
> > > -                   return;
> > > +                   /* The above depths are the only ones valid for HDMI. */
> > > +                   return false;
> > >             }
> > > -           if (normalized_clk <= info->max_tmds_clock)
> > > -                   return;
> > > -           reduce_mode_colour_depth(timing_out);
> > > -
> > > -   } while (timing_out->display_color_depth > COLOR_DEPTH_888);
> > > -
> > > +           if (normalized_clk <= info->max_tmds_clock) {
> > > +                   timing_out->display_color_depth = depth;
> > > +                   return true;
> > > +           }
> > > +   } while (--depth > COLOR_DEPTH_666);
> > > +   return false;
> > >  }
> > >
> > >  static void fill_stream_properties_from_drm_display_mode(
> > > @@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
> > >
> > >     stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
> > >     stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> > > -   if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> > > -           adjust_colour_depth_from_display_info(timing_out, info);
> > > +   if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > > +           if (!adjust_colour_depth_from_display_info(timing_out, info) &&
> > > +               drm_mode_is_420_also(info, mode_in) &&
> > > +               timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
> > > +                   timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> > > +                   adjust_colour_depth_from_display_info(timing_out, info);
> > > +           }
> > > +   }
> > >  }
> > >
> > >  static void fill_audio_info(struct audio_info *audio_info,
> > > --
> > > 2.24.0.393.g34dc348eaf-goog
> > >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
