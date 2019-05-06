Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B6206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="rffGOnol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEFNbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:31:05 -0400
Received: from vps.xff.cz ([195.181.215.36]:51150 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFNbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1557149462; bh=5NaP41T2tboqejgP6JhPceVbZhbz7QlauYREMH66sUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rffGOnol+UCVtuc4lDzDpU7ZELd4yFrvN3P6lLYRyUkMf2wJhR1AX8b8lMAji2h0n
         2hcL/yQD/1SZ52jNLuAZBeuMne37sNSo4TNFrHQfo/McQbm19+xPw/4MvcC02mOFbD
         hwZXO1KICQaLB/t3qCIZHRwM9Q6pRPorlo98oDeI=
Date:   Mon, 6 May 2019 15:31:01 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: h6:
 orangepi-one-plus: Add Ethernet support
Message-ID: <20190506133101.c3twwwydy5mez3db@core.my.home>
Mail-Followup-To: Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20190503115928.27662-1-jagan@amarulasolutions.com>
 <20190503144651.ttqfha656dykqjzo@flea>
 <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 03:03:15PM +0530, Jagan Teki wrote:
> On Fri, May 3, 2019 at 8:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, May 03, 2019 at 05:29:28PM +0530, Jagan Teki wrote:
> > > Add Ethernet support for orangepi-one-plus board,
> > >
> > > - Ethernet port connected via RTL8211E PHY
> > > - PHY suppiled with
> > >   GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
> > >   GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
> > > - RGMII-RESET pin connected via PD14
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Your commit log should be improved. We can get those informations from
> > the patch itself...
> 
> Thought it was a clear commit log :)  will update anyway.
> 
> >
> > > ---
> > > Changes for v2:
> > > - emac changes on top of https://patchwork.kernel.org/cover/10899529/
> > >   series
> > >
> > >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  8 ++++
> > >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 42 +++++++++++++++++++
> > >  2 files changed, 50 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > index 12e17567ab56..9e8ed1053715 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > @@ -9,4 +9,12 @@
> > >  / {
> > >       model = "OrangePi One Plus";
> > >       compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
> > > +
> > > +     aliases {
> > > +             ethernet0 = &emac;
> > > +     };
> > > +};
> > > +
> > > +&emac {
> > > +     status = "okay";
> > >  };
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > index 62e27948a3fa..c48e24acaf8a 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > @@ -45,6 +45,48 @@
> > >               regulator-max-microvolt = <5000000>;
> > >               regulator-always-on;
> > >       };
> > > +
> > > +     /*
> > > +      * The board uses 2.5V RGMII signalling. Power sequence to enable
> > > +      * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
> > > +      * at the same time and to wait 100ms.
> > > +      */
> > > +     reg_gmac_2v5: gmac-2v5 {
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "gmac-2v5";
> > > +             regulator-min-microvolt = <2500000>;
> > > +             regulator-max-microvolt = <2500000>;
> > > +             startup-delay-us = <100000>;
> > > +             enable-active-high;
> > > +             gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* GMAC_EN: PD6 */
> > > +
> > > +             /* The real parent of gmac-2v5 is reg_vcc5v, but we need to
> > > +              * enable two regulators to power the phy. This is one way
> > > +              * to achieve that.
> > > +              */
> > > +             vin-supply = <&reg_aldo2>; /* VCC3V3-MAC: GMAC-3V */
> > > +     };
> > > +};
> > > +
> > > +&emac {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&ext_rgmii_pins>;
> > > +     phy-mode = "rgmii";
> > > +     phy-handle = <&ext_rgmii_phy>;
> > > +     phy-supply = <&reg_gmac_2v5>;
> > > +     allwinner,rx-delay-ps = <1500>;
> > > +     allwinner,tx-delay-ps = <700>;
> > > +};
> > > +
> > > +&mdio {
> > > +     ext_rgmii_phy: ethernet-phy@1 {
> > > +             compatible = "ethernet-phy-ieee802.3-c22";
> > > +             reg = <1>;
> > > +
> > > +             reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* RGMII-RESET: PD14 */
> > > +             reset-assert-us = <15000>;
> > > +             reset-deassert-us = <40000>;
> > > +     };
> > >  };
> >
> > ... however, at no point in time you explain why you made that switch,
> > and while most of the definition of the EMAC nodes is in the DTSI, you
> > only enable it in one DTS.
> 
> The dtsi is shared b/w 1+ and lite2 and 1+ has emac, so I enabled the
> status directly on dts and keeping the relevant nodes on dtsi just
> like SoC dtsi does. do I need to mention this in commit log?

Lite 2 doesn't have reg_gmac_2v5 and it also doesn't have the external phy.
But with this patch, reg_gmac_2v5 will also show up in the Lite 2's final
DTB.

Comapred to SoC dtsi, the SoC always has things that are in the dtsi, they
are just not enabled/used by the board, but they are present on the chip.

So this comes down to what the meaning of board-level dtsi should be. I
doubt we want it to mean "a collection of stuff that may or may not be
present on the boards that depend on it".

regards,
	o.

> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
