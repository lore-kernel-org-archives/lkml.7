Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E400CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E26222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ghmjdeVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394590AbfJYNXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:23:21 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39101 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394579AbfJYNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:23:21 -0400
Received: by mail-il1-f194.google.com with SMTP id i12so1818136ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojEgknO9gsXeCFh5vUTwvNw4vcn18ObyJp/IQFfkXH4=;
        b=ghmjdeVEvFvSvG4KtfjhR9Z3D1l6oZlkktIdvWK/D7Ly8jj0WNyKfHtTZc2lgjStTT
         Xhoobs6lf5kaUYh2SlVmVWTe7V9HLUkNK1oACZ2zm8ZnaLajhW8HKmt+IKWw4oUmHjBA
         R4JdZ7vYqxS4PsSR+hVLfAdIlGiVChkESV0Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojEgknO9gsXeCFh5vUTwvNw4vcn18ObyJp/IQFfkXH4=;
        b=TaonmSymCKIxTDSwaKdE8HyfJ7/y0oOHGc4JDgxrkq9J2qMt/9/HlYS6OslvikY9lt
         FUEFSfVH9Cr7aug1zk8tvKaUVaYWFXTrHT0nAuIaft7FqzUudyZqFmILepqlG9sL2I2w
         1NTvQRsS9EAb2DX+ak77qPfgXYI/AkI/ynl9ZmfbQQsFqEAWFnaXmfxpNVxubFwZF0yz
         PvFzP4QgnyPCRpE4OjjxL85WTcOpoZT9B0D1o9A/sOaK/eILuCUS5b3/kL+bcsOcpt7I
         bm4Lsw/fQ2R2NdAKwKdm/D+qr1KDp+3EMMMcN50xy/w3qN1NeMiDA/QeN0sUJOYvUF6a
         ud8Q==
X-Gm-Message-State: APjAAAULTJKetxsSwYj5HLL7M5PkS1nvKBF+ynHVfY1iHEk1Ck6bR/wa
        CsfzX21lamBNOef8gHScMqH8I0vwi/uIIufyjxJ3QA==
X-Google-Smtp-Source: APXvYqw0pBA4TWcmcAghY5wftGh5PsNrcHujAq3KoFAEr3ZRnDiuFICtxs82RGWOsFQdTo67xfnYb+skWRVTZwG0zos=
X-Received: by 2002:a92:5d8f:: with SMTP id e15mr4259484ilg.173.1572009800025;
 Fri, 25 Oct 2019 06:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-6-jagan@amarulasolutions.com> <20191007105708.raxavxk4n7bvxh7x@gilmour>
 <CAMty3ZCiwOGgwbsjTHvEZhwHGhsgb6_FeBs9hHgLai9=rV2_HQ@mail.gmail.com>
 <20191016080306.44pmo3rfmtnkgosq@gilmour> <CAMty3ZCTE=W+TNRvdowec-eYB625j97uG8F3fzVMtRFsKsqFFQ@mail.gmail.com>
 <20191017095225.ntx647ivegaldlyf@gilmour> <CAMty3ZAvqRLh16vFd-63h4+SzQkNydGfNKX_pByqFD-hZfncpQ@mail.gmail.com>
 <20191024182749.czihj3gnvj5yz2eo@hendrix>
In-Reply-To: <20191024182749.czihj3gnvj5yz2eo@hendrix>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 25 Oct 2019 18:53:08 +0530
Message-ID: <CAMty3ZBL+P82uZP0dT0Y695p1K9tyxgqQ-X14OE+H4dZmXMkpg@mail.gmail.com>
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

On Fri, Oct 25, 2019 at 12:33 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Oct 24, 2019 at 01:28:28PM +0530, Jagan Teki wrote:
> > On Thu, Oct 17, 2019 at 3:22 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Wed, Oct 16, 2019 at 02:19:44PM +0530, Jagan Teki wrote:
> > > > On Wed, Oct 16, 2019 at 1:33 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2019 at 05:37:50PM +0530, Jagan Teki wrote:
> > > > > > On Mon, Oct 7, 2019 at 4:27 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > > > >
> > > > > > > On Sat, Oct 05, 2019 at 07:49:12PM +0530, Jagan Teki wrote:
> > > > > > > > Add MIPI DSI pipeline for Allwinner A64.
> > > > > > > >
> > > > > > > > - dsi node, with A64 compatible since it doesn't support
> > > > > > > >   DSI_SCLK gating unlike A33
> > > > > > > > - dphy node, with A64 compatible with A33 fallback since
> > > > > > > >   DPHY on A64 and A33 is similar
> > > > > > > > - finally, attach the dsi_in to tcon0 for complete MIPI DSI
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > > > > > > > ---
> > > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
> > > > > > > >  1 file changed, 38 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > > index 69128a6dfc46..ad4170b8aee0 100644
> > > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > > @@ -382,6 +382,12 @@
> > > > > > > >                                       #address-cells = <1>;
> > > > > > > >                                       #size-cells = <0>;
> > > > > > > >                                       reg = <1>;
> > > > > > > > +
> > > > > > > > +                                     tcon0_out_dsi: endpoint@1 {
> > > > > > > > +                                             reg = <1>;
> > > > > > > > +                                             remote-endpoint = <&dsi_in_tcon0>;
> > > > > > > > +                                             allwinner,tcon-channel = <1>;
> > > > > > > > +                                     };
> > > > > > > >                               };
> > > > > > > >                       };
> > > > > > > >               };
> > > > > > > > @@ -1003,6 +1009,38 @@
> > > > > > > >                       status = "disabled";
> > > > > > > >               };
> > > > > > > >
> > > > > > > > +             dsi: dsi@1ca0000 {
> > > > > > > > +                     compatible = "allwinner,sun50i-a64-mipi-dsi";
> > > > > > > > +                     reg = <0x01ca0000 0x1000>;
> > > > > > > > +                     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > +                     clocks = <&ccu CLK_BUS_MIPI_DSI>;
> > > > > > > > +                     clock-names = "bus";
> > > > > > >
> > > > > > > This won't validate with the bindings you have either here, since it
> > > > > > > still expects bus and mod.
> > > > > > >
> > > > > > > I guess in that cas, we can just drop clock-names, which will require
> > > > > > > a bit of work on the driver side as well.
> > > > > >
> > > > > > Okay.
> > > > > > mod clock is not required for a64, ie reason we have has_mod_clk quirk
> > > > > > patch. Adjust the clock-names: on dt-bindings would make sense here,
> > > > > > what do you think?
> > > > >
> > > > > I'm confused, what are you suggesting?
> > > >
> > > > Sorry for the confusion.
> > > >
> > > > The mod clock is not required for A64 and we have a patch for handling
> > > > mod clock using has_mod_clk quirk(on the series), indeed the mod clock
> > > > is available in A31 and not needed for A64. So, to satisfy this
> > > > requirement the clock-names on dt-bindings can update to make mod
> > > > clock-name is optional and bus clock is required.
> > >
> > > No, the bus clock name is not needed if there's only one clock.
> >
> > Okay, is it because the same clock handle it on PHY side?
>
> No, because there's only one clock and thus you don't need to
> differentiate them.
>
> > >
> > > > I'm not exactly sure, this is correct but trying to understand if it
> > > > is possible or not? something like
> > > >
> > > >    clocks:
> > > >       minItems: 1
> > > >       maxItems: 2
> > > >      items:
> > > >        - description: Bus Clock
> > > >        - description: Module Clock
> > >
> > > That's correct.
> > >
> > > >    clock-names:
> > > >       minItems: 1
> > > >       maxItems: 2
> > > >      items:
> > > >        - const: bus
> > > >        - const: mod
> > >
> > > Here, just keep the current clock-names definition, and make it
> > > required only for SoCs that are not the A64
> >
> > Okay, please have a look here I have pasted the diff for comments.
> >
> >    clocks:
> > +    minItems: 2
> >      items:
> >        - description: Bus Clock
> >        - description: Module Clock
>
> Didn't you tell me that you didn't need the module clock?
>
> How do you handle the case were you just have the bus clock then?

Make sense, it is my mistake then. we don't require to specify here I
think since it implies globally. I think it should be sufficient to
mention on allOf: section based on the SoC like I mentioned in above
snippet.
