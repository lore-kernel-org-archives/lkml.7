Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8389C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CFC207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpY2LVMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgAFXMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:12:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40909 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgAFXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:12:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so17299982wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mt/KSGizDW+gN6JY4pnkoG8YUZWLUj0R1lKF3CWE40I=;
        b=qpY2LVMA4Vffz9/P4mw8I4c+32ZDP+BurHCcfG+QxGsG0LMXJRdzau7WaTOzWYFlhk
         bmufM7RogOC8qk9WKcpJR9mWJidGFDJd8lEU6vbPPrt5W7PgeFtgPNANO13dUcVYQm8K
         pD+nqkyZsm7lQqkzLEfcsK3+46trMwV0RdDZbFF+1KFmR5Ok8KvELzZfZYT5CskPK2t1
         xw1YGc66YN22ipN3goNNa4b3WMM1Z/sILtYFCxKjcurF4slOjx4A8zRTeflvoM3isbuC
         ns5Cc3Fj+8i9+jwGlbi11rrlgPe8rZYOzuEMK6ajJRs2t0GMxuYBbTdXu9iHfXjCQfPh
         0mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mt/KSGizDW+gN6JY4pnkoG8YUZWLUj0R1lKF3CWE40I=;
        b=r+SZTxIHOF7q/rWg3MOkBtJ8EorbgP75gvjKmBLVheR5BoZEy/J2qg9OQ3ErHLFNzA
         7ZedydosG6AwtfGs+vBJLh9rzP5oj7+2bpfQzdI2NUn2r5AAhYlUOAykGCAQHsuZA4cH
         4I2g12iIysLrJuaTEHIBw/VupjEFT7CH7H0tvvn23Qx1SzGJ0wYoMlB7AqWiib5TdLVI
         G9R4W6FhP9kvMvxt1TxxyskJslx1C/bhvpZNpQnRB8fJb55RCXOCxuTEpDLEXqixAPoN
         6NTS9mN+5LN7ZHjsSALLtaZI7CDVjTD84LwxlRXdBFD/4a/nP5U0HyQo0tUG+ve9+cmQ
         K+Ag==
X-Gm-Message-State: APjAAAUOBwddKo5UjhkbED71B96Y0y897dRiDk71GuwDrOfbnMfcoil/
        J31CJ9f770BHDQrl9gSpIbgBOKGbO6kO/9DMb9o=
X-Google-Smtp-Source: APXvYqwsorRuwMKa4/uWPvFE6LVbj+OYVzmzpWsbdQ871r8KiGZXlD8QgFWS1cnGgkPjAmCdMOOihZlC0JttP7cdvSU=
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr30944421wmp.30.1578352347620;
 Mon, 06 Jan 2020 15:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20191202214713.41001-1-thomasanderson@google.com> <722bf0b1-5ff3-5a44-80f1-e67a3fe4d97f@amd.com>
In-Reply-To: <722bf0b1-5ff3-5a44-80f1-e67a3fe4d97f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Jan 2020 18:12:15 -0500
Message-ID: <CADnq5_ORRNiCu-oF2Et-Ukuiy1QesUP_mJFbBQr_Hxe0OPupBA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max
 clock is exceeded
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Thomas Anderson <thomasanderson@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
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

On Thu, Jan 2, 2020 at 10:14 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-12-02 4:47 p.m., Thomas Anderson wrote:
> > For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
> > formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
> > "interesting" modes would be disabled, leaving only low-res or low
> > framerate modes.
> >
> > This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
> > clock is exceeded. Verified that 8K30 and 4K120 are now available and
> > working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.
> >
> > Signed-off-by: Thomas Anderson <thomasanderson@google.com>
>
> Apologies for the late response.
>
> Thanks for getting high-res modes working on HDMI.
>
> This change is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 7aac9568d3be..803e59d97411 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> >       return color_space;
> >  }
> >
> > -static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
> > -{
> > -     if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -             return;
> > -
> > -     timing_out->display_color_depth--;
> > -}
> > -
> > -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> > -                                             const struct drm_display_info *info)
> > +static bool adjust_colour_depth_from_display_info(
> > +     struct dc_crtc_timing *timing_out,
> > +     const struct drm_display_info *info)
> >  {
> > +     enum dc_color_depth depth = timing_out->display_color_depth;
> >       int normalized_clk;
> > -     if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -             return;
> >       do {
> >               normalized_clk = timing_out->pix_clk_100hz / 10;
> >               /* YCbCr 4:2:0 requires additional adjustment of 1/2 */
> >               if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
> >                       normalized_clk /= 2;
> >               /* Adjusting pix clock following on HDMI spec based on colour depth */
> > -             switch (timing_out->display_color_depth) {
> > +             switch (depth) {
> > +             case COLOR_DEPTH_888:
> > +                     break;
> >               case COLOR_DEPTH_101010:
> >                       normalized_clk = (normalized_clk * 30) / 24;
> >                       break;
> > @@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
> >                       normalized_clk = (normalized_clk * 48) / 24;
> >                       break;
> >               default:
> > -                     return;
> > +                     /* The above depths are the only ones valid for HDMI. */
> > +                     return false;
> >               }
> > -             if (normalized_clk <= info->max_tmds_clock)
> > -                     return;
> > -             reduce_mode_colour_depth(timing_out);
> > -
> > -     } while (timing_out->display_color_depth > COLOR_DEPTH_888);
> > -
> > +             if (normalized_clk <= info->max_tmds_clock) {
> > +                     timing_out->display_color_depth = depth;
> > +                     return true;
> > +             }
> > +     } while (--depth > COLOR_DEPTH_666);
> > +     return false;
> >  }
> >
> >  static void fill_stream_properties_from_drm_display_mode(
> > @@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
> >
> >       stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
> >       stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> > -     if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> > -             adjust_colour_depth_from_display_info(timing_out, info);
> > +     if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > +             if (!adjust_colour_depth_from_display_info(timing_out, info) &&
> > +                 drm_mode_is_420_also(info, mode_in) &&
> > +                 timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
> > +                     timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> > +                     adjust_colour_depth_from_display_info(timing_out, info);
> > +             }
> > +     }
> >  }
> >
> >  static void fill_audio_info(struct audio_info *audio_info,
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
