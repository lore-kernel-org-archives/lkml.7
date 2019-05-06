Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B1C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86847208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MhppLfhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEFJ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:56:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46072 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEFJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:56:35 -0400
Received: by mail-io1-f67.google.com with SMTP id b3so4879567iob.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKysu+ggf2+uQ2eAYt5TABC1hM3kbCmZ2bSj1OoK+OM=;
        b=MhppLfhCXW0INxzbxBlzLRgcumDMA+umn+ZIMi6q0SEj+gA8/uRdEhMghQ4vKoYlde
         wny1k8TC8SRS3s4LbUOF7CBlrkRiJGnGlgqons8KzzHCVS0QGRKKj7maoD8EyAmx/H/P
         ZQzliTixtkHeJsxdpySNWEHEBjUraQGgGtZIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKysu+ggf2+uQ2eAYt5TABC1hM3kbCmZ2bSj1OoK+OM=;
        b=YgFc/AG2wQrnFaVqIM5h1+6yMT4rwVSbDoCtp2li4Ejt1nGG+SQvcoMheDdCCD9ny1
         T/9G4CBM14MltpP337afi1YpEFxTXHP/4uVQ1QeCA6URr1+bxTjnqUevdd5hGuWYRKu8
         3XO8PUXAe+AsJDbKT33QlTUrc2OKpO2YiiCPtylOK3LOqS564n7wEhHq7dozTRBE9w6h
         JbckaEQJfVgA8xlnOenLpk78L3K2HT41fH/ETo12+P6Bmqqsj2KMX/Mft39GnnLbDp9V
         iALrCcnNanLYnGIRL5AIAucy09CiFSpmo6fhUSSemeua4LphK62GH7t59jdNUFgdzceT
         0HJw==
X-Gm-Message-State: APjAAAUEDP7WTXTX+LsULp2aDXs9Fw6jmiaCtlpmDjw2j97aMFN9wqNT
        LeD3UntEo7ad0nW4p5ArxT9o5HJ4syuzhrwQtfIAwQ==
X-Google-Smtp-Source: APXvYqxnO2dIWJ1E/SWJUjsbW7VCI6mmCoIsPzRHG8r3fnfPHd+tzQrIUou2K1SZ7cU+q2Nd+dainfJ8cFKvythXg7c=
X-Received: by 2002:a6b:bb82:: with SMTP id l124mr2188291iof.252.1557136594368;
 Mon, 06 May 2019 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190501121448.3812-1-jagan@amarulasolutions.com> <20190501193429.GA9075@ravnborg.org>
In-Reply-To: <20190501193429.GA9075@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 6 May 2019 15:26:22 +0530
Message-ID: <CAMty3ZAfwVyvmAmenhrQHJcy3eq-Yb61a4WLop_8jS-7vM940A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: simple: Add FriendlyELEC HD702E 800x1280
 LCD panel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Thu, May 2, 2019 at 1:04 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan
>
> On Wed, May 01, 2019 at 05:44:47PM +0530, Jagan Teki wrote:
> > HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> > resolution. It has built in Goodix, GT9271 captive touchscreen
> > with backlight adjustable via PWM.
> >
> > Add support for it.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Please submit the binding in a separate patch as per
> Documentation/devicetree/bindings/submitting-patches.txt

Hmm.. prepared like this initially but few of my patches were combined
earlier even-though I sent it separately. anyway let me separate it
again.

>
> The binding looks like it is compatible with common-panel and
> simple-panel - please say so in the bindings.
> See for example the last few binding documents added to the kernel tree.

Correct, will update.

>
> > ---
> >  .../display/panel/friendlyarm,hd702e.txt      | 29 +++++++++++++++++++
> >  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> > new file mode 100644
> > index 000000000000..67349d7f79be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> > @@ -0,0 +1,29 @@
> > +FriendlyELEC HD702E 800x1280 LCD panel
> > +
> > +HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> > +resolution. It has built in Goodix, GT9271 captive touchscreen
> > +with backlight adjustable via PWM.
> > +
> > +Required properties:
> > +- compatible: should be "friendlyarm,hd702e"
> > +- power-supply: regulator to provide the supply voltage
> > +
> > +Optional properties:
> > +- backlight: phandle of the backlight device attached to the panel
> > +
> > +Optional nodes:
> > +- Video port for LCD panel input.
> > +
> > +Example:
> > +
> > +     panel {
> > +             compatible ="friendlyarm,hd702e";
> > +             backlight = <&backlight>;
> > +             power-supply = <&vcc3v3_sys>;
> > +
> > +             port {
> > +                     panel_in_edp: endpoint {
> > +                             remote-endpoint = <&edp_out_panel>;
> > +                     };
> > +             };
> > +     };
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 9e8218f6a3f2..9db3c0c65ef2 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1184,6 +1184,29 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
> >       .bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> >  };
> >
> > +static const struct drm_display_mode friendlyarm_hd702e_mode = {
> > +     .clock          = 67185,
> > +     .hdisplay       = 800,
> > +     .hsync_start    = 800 + 20,
> > +     .hsync_end      = 800 + 20 + 24,
> > +     .htotal         = 800 + 20 + 24 + 20,
> > +     .vdisplay       = 1280,
> > +     .vsync_start    = 1280 + 4,
> > +     .vsync_end      = 1280 + 4 + 8,
> > +     .vtotal         = 1280 + 4 + 8 + 4,
> > +     .vrefresh       = 60,
> > +     .flags          = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > +};
> > +
> > +static const struct panel_desc friendlyarm_hd702e = {
> > +     .modes = &friendlyarm_hd702e_mode,
> > +     .num_modes = 1,
> > +     .size = {
> > +             .width  = 94,
> > +             .height = 151,
> > +     },
> > +};
> As I read the datasheet then this panel needs at least a prepare delay
> of 10 ms (it says > 10 ms from VGH until Data).
> And then we also know that VGH shall be valid at least 10 ms after DVDD
> so prepare is likely 20 ms.
>
> Based on datasheet found here:
> https://pan.baidu.com/s/1geEfBLh/
>
> Please evaluate all delays.

This part I'm unclear, I tried to get the datasheet of this but
couldn't find it either. I have a reference for these FriendlyELEC
panels from https://github.com/friendlyarm/kernel-rockchip/blob/nanopi4-linux-v4.4.y/drivers/gpu/drm/panel/panel-friendlyelec.c
but they are not using any of these delays.

>
> > +
> >  static const struct drm_display_mode giantplus_gpg482739qs5_mode = {
> >       .clock = 9000,
> >       .hdisplay = 480,
> > @@ -2634,6 +2657,9 @@ static const struct of_device_id platform_of_match[] = {
> >       }, {
> >               .compatible = "edt,etm0700g0edh6",
> >               .data = &edt_etm0700g0bdh6,
> > +     }, {
> > +             .compatible = "friendlyarm,hd702e",
> > +             .data = &friendlyarm_hd702e,
> >       }, {
> >               .compatible = "foxlink,fl500wvr00-a0t",
> >               .data = &foxlink_fl500wvr00_a0t,
>
> Add these in sorted order.
> "fox" is before "fri"

True, will sort it.
