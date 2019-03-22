Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CB020850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFEHFlKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfCVRYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:24:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfCVRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:24:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so3240328wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+iRj6RrZ5LZRmE3eANyClzvBaOa5hSIo4qZkLuqdTU=;
        b=RFEHFlKyDaMNOGo3f3APQRfPU6+iNPN/0bB39NlkjvmfM+jlbi0jJF+bl7xg5KPfDu
         bQDiLsjxfH/hxSbZu7hkGVXcNW2KyP27njPoIMzNwP1wq4ub/oStaCT80owvdndStrlG
         9Yz9olymk09jsvkji49HbeQVIjOzyRrpdHK0ra8P0Vz412DfG5R8biM4UpHPLtG8oZ/B
         4ak8epMEv3uXx42nleRgkM5uPMPNno6VfgipVUCsic+v9s21PYTTgNcuNq2Ow0wKvXuj
         4KTcGAgMLQF5BBgCRmdsg24/5PWVuK3V4zpvQKcYmrC80Nut44au662fHEgQvNoJRAHd
         P3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+iRj6RrZ5LZRmE3eANyClzvBaOa5hSIo4qZkLuqdTU=;
        b=Kp0kqytV52DueNh+w6fcsI5fKvCLkPGGgwjihAVzMl/7Y2s2P9758bNuAA2QmB4ism
         WRy9gcRImqYtqzH2PCnhg0Ki+Lb9MqXq1m1oqWTLwk57hTH7pc832PlR35gNfdAYmtQU
         3ehGR2aUw3iovJOCjhYEoD7EE4bg8gbSZuP1W5/Y+3rqDMf3ckDsUpOF7WjD/7rb+eeQ
         pchZvg8IVgTz7sYkv3clFr4KGRc3sSioDgksAz4xcBcNxDMPq/vWcRMVWwNJTjR/FiJC
         nnhH+AUC7ntWiSqu864WstxqGDMCdpSqVpeVho93J+k7Qu1kOIoCkDANFImfEJes/Qa5
         tT4w==
X-Gm-Message-State: APjAAAUHJYOGWzs8ELkgdocaKcbB+BEbhjRUOUU88O3VvmZcXcw+zPvD
        GrJCuuoObwKmF4Y9Ttjn5kAAOqh0nQ+JY/OX4p4=
X-Google-Smtp-Source: APXvYqzxB4BbODoi41AVHPNrvQnD/M7vMe72GhxYPSKqtxYEKsGo8S9vPP8QywYDqUnN6X49xyXFuaoOB+wGNIPx4SY=
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr7607997wrp.129.1553275478059;
 Fri, 22 Mar 2019 10:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-5-andrew.smirnov@gmail.com> <0d08d4e0-ff1d-ae14-e8f8-696c7448fcb1@ti.com>
In-Reply-To: <0d08d4e0-ff1d-ae14-e8f8-696c7448fcb1@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 22 Mar 2019 10:24:26 -0700
Message-ID: <CAHQ1cqFVN-cYU-cieO9BWU=s3v1+nbj0pxqda3VOyCNzH9K65g@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] drm/bridge: tc358767: Simplify tc_set_video_mode()
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:19 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 22/03/2019 05:28, Andrey Smirnov wrote:
> > Simplify tc_set_video_mode() by replacing repreated calls to
> > tc_write()/regmap_write() with a single call to
> > regmap_multi_reg_write(). While at it, simplify explicit shifting by
> > using macros from <linux/bitfield.h>. No functional change intended.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 146 +++++++++++++++++-------------
> >  1 file changed, 85 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 38d542f553cd..d99c9f32a133 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -24,6 +24,7 @@
> >   * GNU General Public License for more details.
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/gpio/consumer.h>
> > @@ -56,6 +57,7 @@
> >
> >  /* Video Path */
> >  #define VPCTRL0                      0x0450
> > +#define VSDELAY                      GENMASK(31, 20)
> >  #define OPXLFMT_RGB666                       (0 << 8)
> >  #define OPXLFMT_RGB888                       (1 << 8)
> >  #define FRMSYNC_DISABLED             (0 << 4) /* Video Timing Gen Disabled */
> > @@ -63,9 +65,17 @@
> >  #define MSF_DISABLED                 (0 << 0) /* Magic Square FRC disabled */
> >  #define MSF_ENABLED                  (1 << 0) /* Magic Square FRC enabled */
> >  #define HTIM01                       0x0454
> > +#define HPW                  GENMASK(8, 0)
> > +#define HBPR                 GENMASK(24, 16)
> >  #define HTIM02                       0x0458
> > +#define HDISPR                       GENMASK(10, 0)
> > +#define HFPR                 GENMASK(24, 16)
> >  #define VTIM01                       0x045c
> > +#define VSPR                 GENMASK(7, 0)
> > +#define VBPR                 GENMASK(23, 16)
> >  #define VTIM02                       0x0460
> > +#define VFPR                 GENMASK(23, 16)
> > +#define VDISPR                       GENMASK(10, 0)
> >  #define VFUEN0                       0x0464
> >  #define VFUEN                                BIT(0)   /* Video Frame Timing Upload */
> >
> > @@ -100,14 +110,28 @@
> >  /* Main Channel */
> >  #define DP0_SECSAMPLE                0x0640
> >  #define DP0_VIDSYNCDELAY     0x0644
> > +#define VID_SYNC_DLY         GENMASK(15, 0)
> > +#define THRESH_DLY           GENMASK(31, 16)
> > +
> >  #define DP0_TOTALVAL         0x0648
> > +#define H_TOTAL                      GENMASK(15, 0)
> > +#define V_TOTAL                      GENMASK(31, 16)
> >  #define DP0_STARTVAL         0x064c
> > +#define H_START                      GENMASK(15, 0)
> > +#define V_START                      GENMASK(31, 16)
> >  #define DP0_ACTIVEVAL                0x0650
> > +#define H_ACT                        GENMASK(15, 0)
> > +#define V_ACT                        GENMASK(31, 16)
> > +
> >  #define DP0_SYNCVAL          0x0654
> > +#define VS_WIDTH             GENMASK(30, 16)
> > +#define HS_WIDTH             GENMASK(14, 0)
> >  #define SYNCVAL_HS_POL_ACTIVE_LOW    (1 << 15)
> >  #define SYNCVAL_VS_POL_ACTIVE_LOW    (1 << 31)
> >  #define DP0_MISC             0x0658
> >  #define TU_SIZE_RECOMMENDED          (63) /* LSCLK cycles per TU */
> > +#define MAX_TU_SYMBOL                GENMASK(28, 23)
> > +#define TU_SIZE                      GENMASK(21, 16)
> >  #define BPC_6                                (0 << 5)
> >  #define BPC_8                                (1 << 5)
> >
> > @@ -184,6 +208,12 @@
> >
> >  /* Test & Debug */
> >  #define TSTCTL                       0x0a00
> > +#define COLOR_R                      GENMASK(31, 24)
> > +#define COLOR_G                      GENMASK(23, 16)
> > +#define COLOR_B                      GENMASK(15, 8)
> > +#define ENI2CFILTER          BIT(4)
> > +#define COLOR_BAR_MODE               GENMASK(1, 0)
> > +#define COLOR_BAR_MODE_BARS  2
> >  #define PLL_DBG                      0x0a04
> >
> >  static bool tc_test_pattern;
> > @@ -647,10 +677,6 @@ static int tc_get_display_props(struct tc_data *tc)
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
> > @@ -659,76 +685,74 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
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
> > -     /* Test pattern settings */
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
> > +     const u32 vs_pol = mode->flags & DRM_MODE_FLAG_NVSYNC ?
> > +             SYNCVAL_VS_POL_ACTIVE_LOW : 0;
> > +     const u32 hs_pol = mode->flags & DRM_MODE_FLAG_NHSYNC ?
> > +             SYNCVAL_HS_POL_ACTIVE_LOW : 0;
> > +     const struct reg_sequence video_mode_settings[] = {
> > +             { VPCTRL0, FIELD_PREP(VSDELAY, 0) |
> > +                        OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED },
> > +             { HTIM01, FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
> > +                       FIELD_PREP(HPW, ALIGN(hsync_len, 2)) },
> > +             { HTIM02, FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
> > +                       FIELD_PREP(HFPR, ALIGN(right_margin, 2)) },
> > +             { VTIM01, FIELD_PREP(VBPR, upper_margin) |
> > +                       FIELD_PREP(VSPR, vsync_len) },
> > +             { VTIM02, FIELD_PREP(VFPR, lower_margin) |
> > +                       FIELD_PREP(VDISPR, mode->vdisplay) },
> > +             { VFUEN0, VFUEN },
> > +             { TSTCTL, FIELD_PREP(COLOR_R, 120) |
> > +                       FIELD_PREP(COLOR_G, 20) |
> > +                       FIELD_PREP(COLOR_B, 99) |
> > +                       ENI2CFILTER |
> > +                       FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS) },
> > +             { DP0_VIDSYNCDELAY, FIELD_PREP(THRESH_DLY, max_tu_symbol) |
> > +                                 FIELD_PREP(VID_SYNC_DLY, vid_sync_dly) },
> > +             { DP0_TOTALVAL, FIELD_PREP(H_TOTAL, mode->htotal) |
> > +                             FIELD_PREP(V_TOTAL, mode->vtotal) },
> > +             { DP0_STARTVAL, FIELD_PREP(H_START, left_margin + hsync_len) |
> > +                             FIELD_PREP(V_START,
> > +                                        upper_margin + vsync_len) },
> > +             { DP0_ACTIVEVAL, FIELD_PREP(V_ACT, mode->vdisplay) |
> > +                              FIELD_PREP(H_ACT, mode->hdisplay) },
> > +             { DP0_SYNCVAL, FIELD_PREP(VS_WIDTH, vsync_len) |
> > +                            FIELD_PREP(HS_WIDTH, hsync_len) |
> > +                            hs_pol | vs_pol },
> > +             { DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> > +                          DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> > +                          DPI_BPP_RGB888 },
> > +             { DP0_MISC, FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
> > +                         FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
> > +                         BPC_8 },
> > +     };
> >
> > -     tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
> > -
> > -     tc_write(DP0_STARTVAL,
> > -              ((upper_margin + vsync_len) << 16) |
> > -              ((left_margin + hsync_len) << 0));
> > -
> > -     tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
> > -
> > -     tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
> > -              ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
> > -              ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
> > -
> > -     tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> > -              DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
> > -
> > -     tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
> > -                        BPC_8);
> > +     dev_dbg(tc->dev, "set mode %dx%d\n",
> > +             mode->hdisplay, mode->vdisplay);
> > +     dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
> > +             left_margin, right_margin, hsync_len);
> > +     dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
> > +             upper_margin, lower_margin, vsync_len);
> > +     dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
> >
> > -     return 0;
> > -err:
> > -     return ret;
> > +     return regmap_multi_reg_write(tc->regmap,
> > +                                   video_mode_settings,
> > +                                   ARRAY_SIZE(video_mode_settings));
> >  }
> >
> >  static int tc_wait_link_training(struct tc_data *tc, u32 *error)
>
> I don't like this change. I think multi_reg_write is good for writing
> things like, say, color conversion table. But the data for video mode is
> more complex and needs more logic (e.g. here ?: operator is used).

The logic was stuffed into function arguments before, so this patch
didn't really change anything.

> You need to stuff all that logic into variable initializers. You can't use
> e.g. if() anymore,

Where you planning on doing so, or is it just hypothetical?

> and you can't even insert a debug print between the
> writes if you need to.
>

Same here.

> So, in my opinion, this doesn't look (much) cleaner, and makes life more
> difficult.
>

Sure, I'll drop this patch since it generates so much resistance.

Thanks,
Andrey Smirnov
