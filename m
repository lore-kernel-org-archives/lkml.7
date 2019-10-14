Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB5ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC1A20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gQEUAXsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfJNMIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:08:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37752 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNMID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:08:03 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so37400213iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6crmpTwGnz+uFcnLN62tbtxngSexhL6XeYQRkm/JhoY=;
        b=gQEUAXsMwogpgVvZgUXndfP8Yx1YL+c7KNJMu+nO1RwHxW4SfBzwf+tTSjUdob83Lt
         8bjCllxos6er4GVPWpid4x2QZH+CKRzOyTW+27zQjnfWvMatBzD0PFfILP+3UmKhPM8Z
         CoPSGPu5lzhnetQrfUKDbabRzqD5JKJCzT9Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6crmpTwGnz+uFcnLN62tbtxngSexhL6XeYQRkm/JhoY=;
        b=NPZ/3396773WomDLM9pnnD0VN1uYfTsEdUJz/GYch8Q+0GL31ULvunR3dJ0l2MAPCc
         6E1Qv3tqmU6D5MS21E19d0rl9anNDllYYRL7MWb7of4ySojOaH7xotV+CxHimKC/MyGd
         cNE6Yfnzu8RGz7Sw5Wd+3XtYdv+ElDr5nkc/Cj3YQcO1wCEJe0TknjFCGvjyfy/VDBK6
         Bq1ZPm/z5TEPGDPGd+X71uSQu2P7KcEKXiHuvSa6RI5D8st363IddONhDXdl19BfetsT
         SER8mUjgq7bJsxI8X6jV5ML4aAIV8q3yqK5kAVjQIGfRKFDMQAeZwejokA/FX+rUcR/i
         GjCg==
X-Gm-Message-State: APjAAAVghDkwFg4icvBSpdBnA066vwTgRHV30N64JFa3wf7SXXbb2p36
        h/I5rsKQZW0h1cU567TO4DYWxzphH6nlSX8SJUKR3A==
X-Google-Smtp-Source: APXvYqxpgGP82G+0e/506RQFRNOo+V1cYmj86xwy/H75qzek0TZSuNPkcdhhBjRp/kGb802FWG6ooo62z42OJaaLFpU=
X-Received: by 2002:a6b:37c6:: with SMTP id e189mr18175247ioa.61.1571054882584;
 Mon, 14 Oct 2019 05:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-6-jagan@amarulasolutions.com> <20191007105708.raxavxk4n7bvxh7x@gilmour>
In-Reply-To: <20191007105708.raxavxk4n7bvxh7x@gilmour>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 14 Oct 2019 17:37:50 +0530
Message-ID: <CAMty3ZCiwOGgwbsjTHvEZhwHGhsgb6_FeBs9hHgLai9=rV2_HQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 4:27 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, Oct 05, 2019 at 07:49:12PM +0530, Jagan Teki wrote:
> > Add MIPI DSI pipeline for Allwinner A64.
> >
> > - dsi node, with A64 compatible since it doesn't support
> >   DSI_SCLK gating unlike A33
> > - dphy node, with A64 compatible with A33 fallback since
> >   DPHY on A64 and A33 is similar
> > - finally, attach the dsi_in to tcon0 for complete MIPI DSI
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 69128a6dfc46..ad4170b8aee0 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -382,6 +382,12 @@
> >                                       #address-cells = <1>;
> >                                       #size-cells = <0>;
> >                                       reg = <1>;
> > +
> > +                                     tcon0_out_dsi: endpoint@1 {
> > +                                             reg = <1>;
> > +                                             remote-endpoint = <&dsi_in_tcon0>;
> > +                                             allwinner,tcon-channel = <1>;
> > +                                     };
> >                               };
> >                       };
> >               };
> > @@ -1003,6 +1009,38 @@
> >                       status = "disabled";
> >               };
> >
> > +             dsi: dsi@1ca0000 {
> > +                     compatible = "allwinner,sun50i-a64-mipi-dsi";
> > +                     reg = <0x01ca0000 0x1000>;
> > +                     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&ccu CLK_BUS_MIPI_DSI>;
> > +                     clock-names = "bus";
>
> This won't validate with the bindings you have either here, since it
> still expects bus and mod.
>
> I guess in that cas, we can just drop clock-names, which will require
> a bit of work on the driver side as well.

Okay.
mod clock is not required for a64, ie reason we have has_mod_clk quirk
patch. Adjust the clock-names: on dt-bindings would make sense here,
what do you think?
