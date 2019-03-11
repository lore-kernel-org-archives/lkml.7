Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371472084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLQ4aEZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfCKR5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:57:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40177 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:57:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id g20so25328wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iolUJX/XWcerqZAtLzzyf59iSzeciiLbzNOLo5dPAnI=;
        b=sLQ4aEZmYBcKoAyKHseI8xh+eUYQmDeb6GYRFeeW/IBI2YJErN56MoOMBm/OvQ8POj
         ytXP1GkAZyLF2p5FCRM1CAssBONJh2cbxUKqZQsXRXU8DckOK3CDcvP+IM8gh2WwLxBD
         6INyCGJV5FIWA3xLlyyxEIzKoVJ9RSvBnQr2QX3oTbDJsNUHoGKiKpRrUQD1rwFSjhMD
         yABYJSwwP7yiPbD8lh3MbVKmvaOYVkc7pWH9FIXVMcrIq9e1MevEc0mnfaa5ukiE5gr0
         wNJleM9nC4gs23zcpcnVpY3CLuXuIkPcO8eJ32gJRmEfmp9nHrCVZu4RrmAK/K66OuNd
         PYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iolUJX/XWcerqZAtLzzyf59iSzeciiLbzNOLo5dPAnI=;
        b=q4qCOTtoJOprH1OzDhZ4n1lXwJOEDH4WoRcKDCYuyidZ/8NkYhgg0Kl9Gd6WLHSMrZ
         eSVEwcpFCLGOaNp3Ap3PzuUcHhVJcV5Gn625IySPSURV4cBt0HvJJMWfNYNzllvbzncz
         AV5MsomM+4XHF0LrS0FzN/X/N4PI8goqa7QkbjARl0GkCVabC6iwQesy9YbQF/4VzkdC
         i+QmZgEVD3I4sT/DvlDAFxAtAGHTR2T14REViZemS9dEPTuylS7M5NEPZv91Q78VOfUM
         MzI6WG3NIw8hluQ+rv7aJ9UOJPDELH28+vUBAAM/OI3x2KK25OVrzMnd7tpAXgf2+tl/
         y7LQ==
X-Gm-Message-State: APjAAAWXX9WeWlpAKiqSlxtXA5zDVW79Zih4gmYNiBNySoEqfunm71ZY
        0/YoJdxVWJvBjLoiZp3AY/zlRil6zhBOp+VYDms=
X-Google-Smtp-Source: APXvYqzc7aHGApCRsMsF0HTjgYqOTWEvwPvj4U958Mw/yH6vP8xB5Q43OKy6Q/CpQMJWZF9OjY7Ta4a3ugt9sW+bMMw=
X-Received: by 2002:a1c:2543:: with SMTP id l64mr190933wml.116.1552327020104;
 Mon, 11 Mar 2019 10:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-4-andrew.smirnov@gmail.com> <20190304122556.GE6325@pendragon.ideasonboard.com>
In-Reply-To: <20190304122556.GE6325@pendragon.ideasonboard.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 11 Mar 2019 10:56:49 -0700
Message-ID: <CAHQ1cqF7fmySXX8Sq-cP5fNzhtZc=Dm4p0VOBvhXwhTjmWUMJQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/bridge: tc358767: Simplify tc_set_video_mode()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:26 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Andrey,
>
> Thank you for the patch.
>
> On Tue, Feb 26, 2019 at 11:36:03AM -0800, Andrey Smirnov wrote:
> > Simplify tc_set_video_mode() by replacing repreated calls to
> > tc_write()/regmap_write() with a single call regmap_multi_reg_write().
> > No functional change intended.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 125 ++++++++++++++++--------------
> >  1 file changed, 65 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 86ebd49194b7..c85468fcc157 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -641,10 +641,6 @@ static int tc_get_display_props(struct tc_data *tc)
> >
> >  static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
> >  {
> > -     int ret;
> > -     int vid_sync_dly;
> > -     int max_tu_symbol;
> > -
> >       int left_margin = mode->htotal - mode->hsync_end;
> >       int right_margin = mode->hsync_start - mode->hdisplay;
> >       int hsync_len = mode->hsync_end - mode->hsync_start;
> > @@ -653,76 +649,85 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
> >       int vsync_len = mode->vsync_end - mode->vsync_start;
> >
> >       /*
> > -      * Recommended maximum number of symbols transferred in a transfer unit:
> > +      * Recommended maximum number of symbols transferred in a
> > +      * transfer unit:
> >        * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
> >        *              (output active video bandwidth in bytes))
> >        * Must be less than tu_size.
> >        */
> > -     max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
> > -
> > -     dev_dbg(tc->dev, "set mode %dx%d\n",
> > -             mode->hdisplay, mode->vdisplay);
> > -     dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
> > -             left_margin, right_margin, hsync_len);
> > -     dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
> > -             upper_margin, lower_margin, vsync_len);
> > -     dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
> > -
> > +     int max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
> >
> > +     /* DP Main Stream Attributes */
> > +     int vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> >       /*
> >        * LCD Ctl Frame Size
> >        * datasheet is not clear of vsdelay in case of DPI
> >        * assume we do not need any delay when DPI is a source of
> >        * sync signals
> >        */
> > -     tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
> > -              OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
> > -     tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
> > -                      (ALIGN(hsync_len, 2) << 0));    /* Hsync */
> > -     tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
> > -                      (ALIGN(mode->hdisplay, 2) << 0)); /* width */
> > -     tc_write(VTIM01, (upper_margin << 16) |         /* V back porch */
> > -                      (vsync_len << 0));             /* Vsync */
> > -     tc_write(VTIM02, (lower_margin << 16) |         /* V front porch */
> > -                      (mode->vdisplay << 0));        /* height */
> > -     tc_write(VFUEN0, VFUEN);                /* update settings */
> > -
> > +     u32 vpctrl0 = (0 << 20) /* VSDELAY */ |
> > +                   OPXLFMT_RGB888 | FRMSYNC_DISABLED |
> > +                   MSF_DISABLED;
> > +     u32 htim01 = (ALIGN(left_margin, 2) << 16) | /* H back porch */
> > +                  (ALIGN(hsync_len, 2) << 0); /* Hsync */
> > +     u32 htim02 = (ALIGN(right_margin, 2) << 16) | /* H front porch */
> > +                  (ALIGN(mode->hdisplay, 2) << 0); /* width */
> > +     u32 vtim01 = (upper_margin << 16) | /* V back porch */
> > +                  (vsync_len << 0); /* Vsync */
> > +     u32 vtim02 = (lower_margin << 16) | /* V front porch */
> > +                  (mode->vdisplay << 0); /* height */
> >       /* Test pattern settings */
> > -     tc_write(TSTCTL,
> > -              (120 << 24) |  /* Red Color component value */
> > -              (20 << 16) |   /* Green Color component value */
> > -              (99 << 8) |    /* Blue Color component value */
> > -              (1 << 4) |     /* Enable I2C Filter */
> > -              (2 << 0) |     /* Color bar Mode */
> > -              0);
> > -
> > -     /* DP Main Stream Attributes */
> > -     vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> > -     tc_write(DP0_VIDSYNCDELAY,
> > -              (max_tu_symbol << 16) |        /* thresh_dly */
> > -              (vid_sync_dly << 0));
> > +     u32 tstctl = (120 << 24) |  /* Red Color component value */
> > +                  (20 << 16)  |  /* Green Color component value */
> > +                  (99 <<  8)  |  /* Blue Color component value */
> > +                  (1 <<  4)   |  /* Enable I2C Filter */
> > +                  (2 <<  0);     /* Color bar Mode */
> > +     u32 dp0_vidsyncdelay = (max_tu_symbol << 16) |  /* thresh_dly */
> > +                            (vid_sync_dly << 0);
> > +     u32 dp0_totalval = (mode->vtotal << 16) | (mode->htotal);
> > +     u32 dp0_startval = ((upper_margin + vsync_len) << 16) |
> > +                        ((left_margin + hsync_len) << 0);
> > +     u32 dp0_activeval = (mode->vdisplay << 16) | (mode->hdisplay);
> > +     u32 dp0_syncval = (vsync_len << 16) | (hsync_len << 0) |
> > +                       (mode->flags & DRM_MODE_FLAG_NHSYNC) ?
> > +                       SYNCVAL_HS_POL_ACTIVE_LOW : 0 |
> > +                       (mode->flags & DRM_MODE_FLAG_NVSYNC) ?
> > +                       SYNCVAL_VS_POL_ACTIVE_LOW : 0;
> > +     u32 dpipxlfmt = VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> > +                     DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> > +                     DPI_BPP_RGB888;
> > +     u32 dp0_misc = (max_tu_symbol << 23) |
> > +                    (TU_SIZE_RECOMMENDED << 16) |
> > +                    BPC_8;
> > +
> > +     const struct reg_sequence video_mode_settings[] = {
> > +             { VPCTRL0, vpctrl0 },
> > +             { HTIM01, htim01 },
> > +             { HTIM02, htim02 },
> > +             { VTIM01, vtim01 },
> > +             { VTIM02, vtim02 },
> > +             { VFUEN0, VFUEN },  /* update settings */
> > +             { TSTCTL, tstctl },
> > +             { DP0_VIDSYNCDELAY, dp0_vidsyncdelay },
> > +             { DP0_TOTALVAL, dp0_totalval },
> > +             { DP0_STARTVAL, dp0_startval },
> > +             { DP0_ACTIVEVAL, dp0_activeval },
> > +             { DP0_SYNCVAL, dp0_syncval },
> > +             { DPIPXLFMT, dpipxlfmt },
> > +             { DP0_MISC, dp0_misc },
> > +     };
>
> I like the removal of the tc_write() macro, but slightly dislike the
> need for this array. Another possible option to handle errors in a nicer
> way would be
>
> static int tc_write(struct tc_data *tc, unsigned int reg, unsigned int val,
>                     int *status)
> {
>         if (!*status)
>                 *status = regmap_write(tc->regmap, reg, val);
>         return *status;
> }
>
> ...
>         int err = 0;
>
>         tc_write(tc, ..., ..., &err);
>         tc_write(tc, ..., ..., &err);
>         tc_write(tc, ..., ..., &err);
>         tc_write(tc, ..., ..., &err);
>         tc_write(tc, ..., ..., &err);
>
>         return err;
>

I'd rather not define any new helper functions just for the sake of
avoiding using regmap_multi_reg_write(). I updated this patch in v2 to
combine register value initialization and array declaration, so maybe
you'll find it less displeasing.

Thanks,
Andrey Smirnov
