Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7073C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EABD20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124448;
	bh=UYI+i4ZdBUJfq10YbStvW3i66fBJsqe8ARvR8bHxCbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Nj9Bp3FMBqDQWJphDdcTGN2vnp/+bdc/hgFBA9qQd1IcKNiRBDkX9NYJhQGQx5cd2
	 IoUMhmrKZ6SEaht7EDJj70ehkikI6NEXveTqeLxibwAVDMyHcRbM2TdLMjTG6Saqp7
	 zloh1+Ecq/6kOQ487lsY+0FzFNKBfLI01PEsQ4Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJCP7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbfJCP7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:43 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CCC222C2;
        Thu,  3 Oct 2019 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118382;
        bh=UYI+i4ZdBUJfq10YbStvW3i66fBJsqe8ARvR8bHxCbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqbyF7VSy9NGgBFB+HIevDvHLWm+7aEURok3DWHfiN9exDTZhQ0pl2MxYRrX080ic
         NvimPrOdtKf3nbQIlfd+/crmMgf4KzFT7yuBdmLEm+N4KARx9ff/JsYlUcKUJn+11m
         v/Eryv8Mp0Q/GqOr9XmwF5yWFxqs8FHEcY16wT1Q=
Received: by mail-qt1-f178.google.com with SMTP id u22so4246606qtq.13;
        Thu, 03 Oct 2019 08:59:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUvA72ISCtY+efvzNh6dqfvQ3Lf6ux9VN7JhsN2AaaBO3tEWT7g
        EK6o3DrXOWHKyp1GJ2XG1mlKWB7qzSa95wev2A==
X-Google-Smtp-Source: APXvYqwcwdNJlOIpfQZz2dIR2x5UhCf43ZSWs3Ge+J8BHWO8rEIey1vwAN28tyHAn9j5UNMWeVMspf0z3kY4qPEkVYI=
X-Received: by 2002:ad4:458d:: with SMTP id x13mr9205417qvu.85.1570118380840;
 Thu, 03 Oct 2019 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190920075411.15735-1-marcel@ziswiler.com> <20190920075411.15735-2-marcel@ziswiler.com>
 <20191001220539.GA16232@bogus> <e6fdfd7f46308dbc8fd33d4a2ff0b242ec39a84c.camel@toradex.com>
In-Reply-To: <e6fdfd7f46308dbc8fd33d4a2ff0b242ec39a84c.camel@toradex.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Oct 2019 10:59:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmCVP3Fc2sUY=FpM5-HLQ0-=uTf6PEwn0XzyC5BBHBOA@mail.gmail.com>
Message-ID: <CAL_JsqKmCVP3Fc2sUY=FpM5-HLQ0-=uTf6PEwn0XzyC5BBHBOA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: simple: add display timings for logic
 technologies displays
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "marcel@ziswiler.com" <marcel@ziswiler.com>,
        "info@logictechno.com" <info@logictechno.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:27 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> On Tue, 2019-10-01 at 17:05 -0500, Rob Herring wrote:
> > On Fri, Sep 20, 2019 at 09:54:11AM +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > > Add display timings for the following 3 display panels manufactured
> > > by
> > > Logic Technologies Limited:
> > >
> > > - LT161010-2NHC e.g. as found in the Toradex Capacitive Touch
> > > Display
> > >   7" Parallel [1]
> > > - LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display
> > > 7"
> > >   Parallel [2]
> > > - LT170410-2WHC e.g. as found in the Toradex Capacitive Touch
> > > Display
> > >   10.1" LVDS [3]
> > >
> > > Those panels may also be distributed by Endrich Bauelemente
> > > Vertriebs
> > > GmbH [4].
> > >
> > > [1]
> > > https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
> > > [2]
> > > https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
> > > [3]
> > > https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
> > > [4]
> > > https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30
> > >
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > > ---
> > >
> > >  drivers/gpu/drm/panel/panel-simple.c | 65
> > > ++++++++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > > b/drivers/gpu/drm/panel/panel-simple.c
> > > index 28fa6ba7b767..42bd0de25167 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -2034,6 +2034,62 @@ static const struct panel_desc lg_lp129qe = {
> > >     },
> > >  };
> > >
> > > +static const struct display_timing logictechno_lt161010_2nh_timing
> > > = {
> > > +   .pixelclock = { 26400000, 33300000, 46800000 },
> > > +   .hactive = { 800, 800, 800 },
> > > +   .hfront_porch = { 16, 210, 354 },
> > > +   .hback_porch = { 46, 46, 46 },
> > > +   .hsync_len = { 1, 20, 40 },
> > > +   .vactive = { 480, 480, 480 },
> > > +   .vfront_porch = { 7, 22, 147 },
> > > +   .vback_porch = { 23, 23, 23 },
> > > +   .vsync_len = { 1, 10, 20 },
> > > +   .flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> > > +            DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> > > +            DISPLAY_FLAGS_SYNC_POSEDGE,
> > > +};
> > > +
> > > +static const struct panel_desc logictechno_lt161010_2nh = {
> > > +   .timings = &logictechno_lt161010_2nh_timing,
> > > +   .num_timings = 1,
> > > +   .size = {
> > > +           .width = 154,
> > > +           .height = 86,
> > > +   },
> > > +   .bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > > +   .bus_flags = DRM_BUS_FLAG_DE_HIGH |
> > > +                DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > > +                DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> > > +};
> > > +
> > > +static const struct display_timing logictechno_lt170410_2whc_timing
> > > = {
> > > +   .pixelclock = { 68900000, 71100000, 7340000 },
> > > +   .hactive = { 1280, 1280, 1280 },
> > > +   .hfront_porch = { 23, 60, 71 },
> > > +   .hback_porch = { 23, 60, 71 },
> > > +   .hsync_len = { 15, 40, 47 },
> > > +   .vactive = { 800, 800, 800 },
> > > +   .vfront_porch = { 5, 7, 10 },
> > > +   .vback_porch = { 5, 7, 10 },
> > > +   .vsync_len = { 6, 9, 12 },
> > > +   .flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> > > +            DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> > > +            DISPLAY_FLAGS_SYNC_POSEDGE,
> > > +};
> > > +
> > > +static const struct panel_desc logictechno_lt170410_2whc = {
> > > +   .timings = &logictechno_lt170410_2whc_timing,
> > > +   .num_timings = 1,
> > > +   .size = {
> > > +           .width = 217,
> > > +           .height = 136,
> > > +   },
> > > +   .bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > > +   .bus_flags = DRM_BUS_FLAG_DE_HIGH |
> > > +                DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > > +                DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> > > +};
> > > +
> > >  static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
> > >     .clock = 30400,
> > >     .hdisplay = 800,
> > > @@ -3264,6 +3320,15 @@ static const struct of_device_id
> > > platform_of_match[] = {
> > >     }, {
> > >             .compatible = "lg,lp129qe",
> > >             .data = &lg_lp129qe,
> > > +   }, {
> > > +           .compatible = "logictechno,lt161010-2nhc",
> > > +           .data = &logictechno_lt161010_2nh,
> > > +   }, {
> > > +           .compatible = "logictechno,lt161010-2nhr",
> > > +           .data = &logictechno_lt161010_2nh,
> > > +   }, {
> > > +           .compatible = "logictechno,lt170410-2whc",
> > > +           .data = &logictechno_lt170410_2whc,
> >
> > The vendor prefix wasn't documented, but the compatible string and
> > rest
> > already are?
>
> Marcel added the vendor prefix in the first patch of the series [1]

Right, but where's the panel's binding documentation with the above
compatible strings documented?

Rob
