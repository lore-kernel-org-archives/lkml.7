Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9934020643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Of+gRCLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCGLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:46:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37034 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:46:57 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so15317962itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJFCmIBEkjX0SmedhiLrBylGwmmAasIGYFf4pgeMd5U=;
        b=Of+gRCLx2RnIP0JKabQ9E4/TSFoRliLCGEbnMjNeyp0iC7Q8f6gKg1lGQNvxE8keug
         fKxQPu07y0ZaCEoP+AgqVmqoZKEAJnsLdLkUQOKo4lA4S+1Fr3Fmz4+cWFf0NwOBdPhY
         +aZQ4ZpJa5j+AXeyvUXLRjbQHJBQxG149Xirk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJFCmIBEkjX0SmedhiLrBylGwmmAasIGYFf4pgeMd5U=;
        b=b/PpYJhUESjVzZUeJ+A6muCPI4n+6M4VU0t3p0Efw9ASHYKRQ+6MQPW+YldjEdyCYN
         ygyCLhT/0+xRGTn9GMv9IumIcvgdfvvo8aJs0d2ndeFxthzxodJ3rHL14pBHt2bGZevi
         M5PJMgt2O+tGNNo7EeKRF89PURnrU/00S8azVXaBYOEDJ+YmzPETlJopLRTDcoEwKOiV
         K2AfEV1fYhvDjFEGh3iB5k5EbjmfAQn4zN60K6AV+qe9NyKSp+DTkeD1rdYcgUngGZmK
         4yFHLb7Ldwn5gYkrN5XEWIVxSXGPt72b4IB7LvAjZOC/2y7f0WiVrdgi5pwpFeeGRamZ
         WrAg==
X-Gm-Message-State: APjAAAWNJlBXiSFUV7c894xCmBktRFq1DtcX1a8g1haOmtC0fyv/+TQ6
        eQqDAxm1pWiCFYQlux3Ael1okK8+EVSHVCz1kWtBrw==
X-Google-Smtp-Source: APXvYqxFKCKG4CZ6yIwfDTfytYJuhqUEZu1ooas6vRHNiYP95URGNZt74y7RFAwCbsQDcyB5hOiZDqMXV1E5AyjS19c=
X-Received: by 2002:a24:e4d:: with SMTP id 74mr4722223ite.32.1551959215516;
 Thu, 07 Mar 2019 03:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-6-jagan@amarulasolutions.com> <20190304155014.2c7mx4uvzqwy7yde@flea>
In-Reply-To: <20190304155014.2c7mx4uvzqwy7yde@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 7 Mar 2019 17:16:44 +0530
Message-ID: <CAMty3ZCpr1rG_AB1hkFpSVyY2HVTkaUqyXf6czWEEn-J=LXE0w@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] drm/sun4i: sun6i_mipi_dsi: Simplify dsi setup
 timings code
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

On Mon, Mar 4, 2019 at 9:20 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Mar 03, 2019 at 11:05:27PM +0530, Jagan Teki wrote:
> > DSI timings are varies between burst/non-burst devices and
> > current driver is handling this support via if, else statements
> > which would difficult to read.
> >
> > Simplify it by using goto to make code more readable.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > ---
> > Note: This change is created based on previous version burst
> > changes [1] by addressing comment from [2] by Maxime to make
> > code readable.
> >
> > [1] https://patchwork.kernel.org/cover/10813623/
> > [2] https://patchwork.kernel.org/patch/10666607/
> >
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 79 ++++++++++++++------------
> >  1 file changed, 42 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 31ec4048804d..898f32319c2d 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -550,7 +550,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >  {
> >       struct mipi_dsi_device *device = dsi->device;
> >       unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> > -     u16 hbp = 0, hfp = 0, hsa = 0, hblk = 0, vblk = 0;
> > +     u16 hbp, hfp, hsa, hblk;
> > +     u16 vblk = 0;
> >       u32 basic_ctl = 0;
> >       size_t bytes;
> >       u8 *buffer;
> > @@ -558,6 +559,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >       /* Do all timing calculations up front to allocate buffer space */
> >
> >       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > +             hbp = hfp = hsa = 0;
>
> This raises a checkpatch warning and isn't necessary
>
> >               hblk = mode->hdisplay * Bpp;
> >               basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
> >                           SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
> > @@ -566,48 +568,51 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >               if (device->lanes == 4)
> >                       basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
> >                                    SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
> > -     } else {
> > -             /*
> > -              * A sync period is composed of a blanking packet (4
> > -              * bytes + payload + 2 bytes) and a sync event packet
> > -              * (4 bytes). Its minimal size is therefore 10 bytes
> > -              */
> > +
> > +             goto alloc_buf;
>
> And I'd rather not have a goto in the middle of the code for no
> particular reason.

OK, will try to think for better simplification otherwise will drop it
in next version.
