Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46576C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179982075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554999911;
	bh=5ZY6Ux4o/b4SgaHZR1GuMTomVW6gaqvwWf8MJYCI0dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VFOGBl7WA37G48/eQtMng6LTXrwsp0AzmmHTCWrBOV8CA0wLvOzODFmxg+vHeBKBL
	 RtcMJ/V4mD9EOvODtFzIkktJBMIFg4RTc4bDnMYW+dc90EZlgh+VW4mtneqJYj6vmi
	 oGw4Kud3dtQPaipHRWVzaAgc6r0+TPHSgQR0fHGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDKQZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:25:09 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E505D21872;
        Thu, 11 Apr 2019 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554999908;
        bh=5ZY6Ux4o/b4SgaHZR1GuMTomVW6gaqvwWf8MJYCI0dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SXpAXQvTaCl36WoCz9YvXugpE9tYxXXgzKj8teUtmAvSIZ8LDgS8Uqp4Iu0Df3bcP
         kx3gAOK2wzWtQClj+N142dDBB6ArHpsMTwBxwrCte0qI0tS2snA6nhG03A58lrZ59O
         oei7Wr5RRi57AXFumiZFMtvDDeidAfLACZIucUKc=
Received: by mail-qt1-f170.google.com with SMTP id k14so7850780qtb.0;
        Thu, 11 Apr 2019 09:25:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXVA/vpajSun+Yc/SVJt6cYhEd0Zy3CmN6ccpLhmw0t8/zivnMV
        0ki5RtwG5IoLPnc62j9ci5IATN9UBtksQd0SCA==
X-Google-Smtp-Source: APXvYqzE0tsPgw0s58ddryR0M9hBIh+DzVt0fXHNwUM3dxgOkROFgx4a8YoH3FTR3cyh8/QKsrPCFxbEc8lhUPg+qtk=
X-Received: by 2002:ac8:3f6f:: with SMTP id w44mr40633789qtk.59.1554999907079;
 Thu, 11 Apr 2019 09:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105720.32357-1-peron.clem@gmail.com> <2957024.jOddxINRMN@jernej-laptop>
 <CAJiuCcdo_WAP1_rOcqOcoNkt7rdGb3H_GVMN2DiZnvo_4c=7DA@mail.gmail.com>
 <2797515.ZAugZ1JPiN@jernej-laptop> <20190411152752.qlabx7heh74dy2ao@flea>
In-Reply-To: <20190411152752.qlabx7heh74dy2ao@flea>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Apr 2019 11:24:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJAwxxZqokOYfxfSu05AxjAtts_vKajGFpDhyvqb2sO5Q@mail.gmail.com>
Message-ID: <CAL_JsqJAwxxZqokOYfxfSu05AxjAtts_vKajGFpDhyvqb2sO5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:27 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 11, 2019 at 05:23:25PM +0200, Jernej =C5=A0krabec wrote:
> > Dne =C4=8Detrtek, 11. april 2019 ob 17:20:04 CEST je Cl=C3=A9ment P=C3=
=A9ron napisal(a):
> > > Hi,
> > >
> > > On Thu, 11 Apr 2019 at 17:05, Jernej =C5=A0krabec <jernej.skrabec@sio=
l.net>
> > wrote:
> > > > Dne =C4=8Detrtek, 11. april 2019 ob 12:57:16 CEST je Cl=C3=A9ment P=
=C3=A9ron napisal(a):
> > > > > Add the mali gpu node to the H6 device-tree.
> > > > >
> > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > ---
> > > > >
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > > > > e0dc4a05c1ba..196753110434 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > @@ -157,6 +157,20 @@
> > > > >
> > > > >                       allwinner,sram =3D <&ve_sram 1>;
> > > > >
> > > > >               };
> > > > >
> > > > > +             gpu: gpu@1800000 {
> > > > > +                     compatible =3D "allwinner,sun50i-h6-mali",
> > > > > +                                  "arm,mali-t720";
> > > > > +                     reg =3D <0x01800000 0x4000>;
> > > > > +                     interrupts =3D <GIC_SPI 84
> > > >
> > > > IRQ_TYPE_LEVEL_HIGH>,
> > > >
> > > > > +                                  <GIC_SPI 85
> > > >
> > > > IRQ_TYPE_LEVEL_HIGH>,
> > > >
> > > > > +                                  <GIC_SPI 83
> > > >
> > > > IRQ_TYPE_LEVEL_HIGH>;
> > > >
> > > > > +                     interrupt-names =3D "job", "mmu", "gpu";
> > > > > +                     clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GP=
U>;
> > > > > +                     clock-names =3D "core", "bus";
> > > > > +                     resets =3D <&ccu RST_BUS_GPU>;
> > > > > +                     status =3D "disabled";
> > > >
> > > > Usually self sufficient peripherals are enabled by default in DTSI.
> > >
> > > I follow the other Mali Midgard (rk3399, rk3288) syntax.
> > > But I think you're right here, will go for an update I think.
> >
> > I quickly checked A64 and H5 DTSI and both have GPU enabled by default =
(status
> > property is not set).
>
> I asked myself the same question, but the H6 seems to have a supply
> wired to the GPU, while the H3 and H5 do not. So I'm not sure we want
> to enable it on all the boards, even though some might have left out
> the GPU supply which will result in a non-working GPU (I assume?)

If the default state is enabled, then only devfreq will be disabled
for panfrost, but it should otherwise work. I guess we could be
smarter and just do frequency changes if all the OPP voltages are the
same.

Rob
