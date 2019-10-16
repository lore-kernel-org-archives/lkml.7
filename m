Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B413DECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E1C20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oDLHRvC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbfJPIt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:49:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38834 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfJPIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:49:59 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so52748343iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkFKCgNZd30QrMCh3RiyW6uUTpINk4yhCuU9i7apvF8=;
        b=oDLHRvC6Da2CfSONZTkFu1bX2HUbVJbI71A8Kmnp8x1j9NKcOadDyR4zX0/SUlCeDW
         6EP3b8kcsQfyUBkTYAd4jBTbJotQJjQ39oVD+mG36pdochYrgL1N9fvZ+4W/6s0/hKDV
         BglF9H8nLhQu+PPWgzunU49/vZjl42IXUCUpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkFKCgNZd30QrMCh3RiyW6uUTpINk4yhCuU9i7apvF8=;
        b=KuBfG/l20eji5vQrE5nQb938SIdmpeh6zdZPh+5VjmttvDqvO3dOB8zlRIXruLCgI/
         AfDOLGcKyyRbxD6SEmV43pO07XGf7KNPIJQssBvGSnEk7qx0IKYaYsdvge9v/cFTgHKz
         3gJzrO0zKt69jpN1bII+5xbDZJlJ7pDKBO3NHTGTxD5gVR0d9anSXAuny0rjWRAFxskI
         I+ugYa76BnKkhZhcyHmBrkWqWTwS41P0hiW3fTow8ldS8v5FDRnomEDk/p0tY/1JC2cS
         wjDRXa7UDk3NyOXGsMP1c+HRlhlpsufQHZtJSxWT5yFDuBsMZq9S0kNp+v9J9ItfbzE7
         3Fhw==
X-Gm-Message-State: APjAAAXV0blt30jf3agD+0rzfXAC+lo27kVLXnJvxNXwz7SNE5sVGnFC
        I3qEQh69TDOoescXeawgMQx4mKJ/ygl3LscWeal1iQ==
X-Google-Smtp-Source: APXvYqwM/YfYZ+riS2Cum5gGH058KHcCEur2jM3FQN+H7YrTWDuxynyVSyvoqlYwq/gm6khtHfKG1I7SfwJJ3PPT7kg=
X-Received: by 2002:a6b:5c0f:: with SMTP id z15mr8252242ioh.173.1571215796031;
 Wed, 16 Oct 2019 01:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-6-jagan@amarulasolutions.com> <20191007105708.raxavxk4n7bvxh7x@gilmour>
 <CAMty3ZCiwOGgwbsjTHvEZhwHGhsgb6_FeBs9hHgLai9=rV2_HQ@mail.gmail.com> <20191016080306.44pmo3rfmtnkgosq@gilmour>
In-Reply-To: <20191016080306.44pmo3rfmtnkgosq@gilmour>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Oct 2019 14:19:44 +0530
Message-ID: <CAMty3ZCTE=W+TNRvdowec-eYB625j97uG8F3fzVMtRFsKsqFFQ@mail.gmail.com>
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

On Wed, Oct 16, 2019 at 1:33 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Oct 14, 2019 at 05:37:50PM +0530, Jagan Teki wrote:
> > On Mon, Oct 7, 2019 at 4:27 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Sat, Oct 05, 2019 at 07:49:12PM +0530, Jagan Teki wrote:
> > > > Add MIPI DSI pipeline for Allwinner A64.
> > > >
> > > > - dsi node, with A64 compatible since it doesn't support
> > > >   DSI_SCLK gating unlike A33
> > > > - dphy node, with A64 compatible with A33 fallback since
> > > >   DPHY on A64 and A33 is similar
> > > > - finally, attach the dsi_in to tcon0 for complete MIPI DSI
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > index 69128a6dfc46..ad4170b8aee0 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > @@ -382,6 +382,12 @@
> > > >                                       #address-cells = <1>;
> > > >                                       #size-cells = <0>;
> > > >                                       reg = <1>;
> > > > +
> > > > +                                     tcon0_out_dsi: endpoint@1 {
> > > > +                                             reg = <1>;
> > > > +                                             remote-endpoint = <&dsi_in_tcon0>;
> > > > +                                             allwinner,tcon-channel = <1>;
> > > > +                                     };
> > > >                               };
> > > >                       };
> > > >               };
> > > > @@ -1003,6 +1009,38 @@
> > > >                       status = "disabled";
> > > >               };
> > > >
> > > > +             dsi: dsi@1ca0000 {
> > > > +                     compatible = "allwinner,sun50i-a64-mipi-dsi";
> > > > +                     reg = <0x01ca0000 0x1000>;
> > > > +                     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                     clocks = <&ccu CLK_BUS_MIPI_DSI>;
> > > > +                     clock-names = "bus";
> > >
> > > This won't validate with the bindings you have either here, since it
> > > still expects bus and mod.
> > >
> > > I guess in that cas, we can just drop clock-names, which will require
> > > a bit of work on the driver side as well.
> >
> > Okay.
> > mod clock is not required for a64, ie reason we have has_mod_clk quirk
> > patch. Adjust the clock-names: on dt-bindings would make sense here,
> > what do you think?
>
> I'm confused, what are you suggesting?

Sorry for the confusion.

The mod clock is not required for A64 and we have a patch for handling
mod clock using has_mod_clk quirk(on the series), indeed the mod clock
is available in A31 and not needed for A64. So, to satisfy this
requirement the clock-names on dt-bindings can update to make mod
clock-name is optional and bus clock is required.

I'm not exactly sure, this is correct but trying to understand if it
is possible or not? something like

   clocks:
      minItems: 1
      maxItems: 2
     items:
       - description: Bus Clock
       - description: Module Clock

   clock-names:
      minItems: 1
      maxItems: 2
     items:
       - const: bus
       - const: mod
