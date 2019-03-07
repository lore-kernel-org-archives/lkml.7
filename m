Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E653020652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lHhwg8nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCGPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:54:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40868 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCGPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:54:15 -0500
Received: by mail-it1-f193.google.com with SMTP id l139so16470123ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LUFA47JD6fq3OK0jABhbKJ06GUrxFVieYU5GLswYvk=;
        b=lHhwg8nRx09lQejfiICM1GKBsodbtiuTxHKAqtWuO4NekWJ+0ba3TwgFb1o7K61zYf
         VNS8PbXT5RIJxc9SrbHUG7fj2Sp+iYHh2DXR7nkZxoDwzUlJsyS66G5y1l6Cumscd0uS
         x65F8q/FC3D8TqFz4Lw+VMwdYOFOZKxUlgpEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LUFA47JD6fq3OK0jABhbKJ06GUrxFVieYU5GLswYvk=;
        b=q5Fu1GmfNNbfs9lzJCOAiRAd9w+NG0vk8e9B8o/QZfEqqkGpYSGKJ9zbSvIMy3TW+J
         tVHBbT4pjxMfPCURZDMH0jHsV/0FUOHq3AdF0N7wsUxqf5+VikrDJdT9E0Du2G3OFrMa
         q/pSnjxoMfPicBDyDnHincLRCV2cKBLfpXCDAlSnc0oNRocGU97zg13eDBoo7bY9Is/Y
         hE/i3KfOQPOe4c6/cZBOHOsJV5MDeE23hYBaFwYpJEzLpb5mEFt/uXODc/Gahw6ERZBf
         nmvWPlBbqyBKrhtscfdb/0iD9nnAyScADRMAVONz5K7+NE0n8T96IsDsUX8Y9KgtDCFj
         nQJw==
X-Gm-Message-State: APjAAAVZVngdgTZBE8Fi6UIJrGAWIFk8myEmkZAr2kTwaP7/oiDSh8oG
        9wN+CD+xk0XvQgoO/7TY0lQCut8WniS6YXeRQHYSrw==
X-Google-Smtp-Source: APXvYqwlEmbPjakTrIjiCGoe/cXdNrWdejhMnLntIoO8i3ZjMrtEdI2XoKnn+jPrjHZcKwoL1iyfw+9uSEjP7kTprpY=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr5824882itk.173.1551974053879;
 Thu, 07 Mar 2019 07:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-3-jagan@amarulasolutions.com> <20190304154320.uledvwz5jhzt22o3@flea>
 <CAMty3ZDWkLWgWhGWBjhXOsmAXzuGKGADAEhzB6gcL+jd7FRazQ@mail.gmail.com> <20190307153935.uxh2hsmahw5l7h4q@flea>
In-Reply-To: <20190307153935.uxh2hsmahw5l7h4q@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 7 Mar 2019 21:24:02 +0530
Message-ID: <CAMty3ZDyk60R0YCsBV6toz84CFjD0D6uWyLVhmp8PC+Mj8GJpQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Mar 07, 2019 at 05:49:07PM +0530, Jagan Teki wrote:
> > On Mon, Mar 4, 2019 at 9:13 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Mar 03, 2019 at 11:05:24PM +0530, Jagan Teki wrote:
> > > > TCON DRQ for non-burst DSI mode can computed based on horizontal
> > > > front porch value, but the current driver trying to include sync
> > > > timings along with front porch resulting wrong drq.
> > > >
> > > > This patch is trying to update the drq by subtracting hsync_start
> > > > with hdisplay, which is horizontal front porch.
> > > >
> > > > Current code:
> > > > ------------
> > > > mode->hsync_end - mode->hdisplay => horizontal front porch + sync
> > > >
> > > > With this patch:
> > > > ----------------
> > > > mode->hsync_start - mode->hdisplay => horizontal front porch
> > > >
> > > > BSP code form BPI-M64-bsp is computing TCON DRQ set bits
> > > > for non-burts as (from linux-sunxi/
> > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > >
> > > > => panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
> > > > => (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
> > >                                   ^ + sync length +
> > > >    - panel->lcd_x - panel->hbp
> > > > => timmings->hor_front_porch
> > >                                ^ + sync
> > > > => mode->hsync_start - mode->hdisplay
> > >
> > > s/hsync_start/hsync_end/
> >
> > No, it should be front porch so it is hsync_start. This change is
> > trying to update DRQ set to use front porch and above evaluation from
> > BSP, result the same front front porch
> >
> > Current driver has hsync_end - hdisplay which is not front porch
> > timing (it is adding extra sync timing).
>
> It would be if you considered that the back porch actually was the
> back porch plus the sync length. I have found no such evidence, quite
> the opposite actually, everything seems to point at the fact that
> unlike the TCON, the DSI block uses the back porch as only the back
> porch.

Sorry, I'm not clear about back porch here.

The current code has mode->hsync_end - mode->hdisplay which is Front
porch + sync time do you think it's not? DRQ set time is pure front
porch value (according BSP) as I didn't see any information about DRQ
set bits in manual or anywhere.

fyi: atleast if you didn't trust me, here is existing applied patch
for about equations.
https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c?id=2cfdc24d2f8d9b14704567c065beb2a118a578fa

So, this patch fixed to remove sync time by updating hsync_start -
hdisplay which is pure front porch. and it's clear that pane is not
working without this.

>
>
> > I believe this is something similar like fixed patches for VBP, HBLK
> > timings.
> >
> > > Did you encounter any panel where this was fixing something? If so,
> > > which one, and what is the matching timings and / or datasheet?
> >
> > W/O this change Bananapi  s070wv20 panel has issue on striped lines on
> > the panel[1] and timings are
> >
> > static const struct drm_display_mode s070wv20_default_mode = {
> >         .clock = 30000,
> >         .vrefresh = 60,
> >
> >         .hdisplay = 800,
> >         .hsync_start = 800 + 40,
> >         .hsync_end = 800 + 40 + 48,
> >         .htotal = 800 + 40 + 48 + 40,
> >
> >         .vdisplay = 480,
> >         .vsync_start = 480 + 13,
> >         .vsync_end = 480 + 13 + 3,
> >         .vtotal = 480 + 13 + 3 + 29,
> > };
> >
> > Which is similar like in panel-simple "bananapi,s070wv20-ct16"
> >
> > Here is the DSI panel patches and sequence:
> > [pixel clock is 30Mhz] https://patchwork.kernel.org/patch/10680331/
> > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
>
> What are those supposed to be? It doesn't look like timings but rather initialization sequences
>
> > matches timings for
> > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
>
> That's not even the same resolution..

fyi about the sequence.

>
> > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
>
> And this isn't a set of timings either.
>
> > Attached is panel datasheet.
>
> Which is for an RGB panel... not a MIPI-DSI one.

Same panel timings It is a DSI ICN6211 bridge, I have attached the
patch above https://patchwork.kernel.org/patch/10680331/ for
information about the display please find previous mail attachment.
