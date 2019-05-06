Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB5C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HKsFzThl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEFJd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:33:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54174 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:33:27 -0400
Received: by mail-it1-f195.google.com with SMTP id l10so19198110iti.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gyd/Ti2kNFqn57KrY+jJie0lDAypj1lVK7fphS1Bm7M=;
        b=HKsFzThl5UWeChygjAOtiRYkHMtsyGBOPTcSmC+vo3Rm32ECFjRyNUWDPcIzhoy4Wf
         YYkKqERL30biuuTmsK95DtLtLhsfmquox7B7WsSAMs92vIvpxcFh9m4T2bkRn8Bjn5lN
         zE1+piUwnv4R43r5rHaMnAB+nQRO/IT8RT7Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gyd/Ti2kNFqn57KrY+jJie0lDAypj1lVK7fphS1Bm7M=;
        b=U2/Rxb2Vgp65vj60nBAerUm+GO4dFyDGqmwXxUUg9qh/yWEcz568AFAoTe+mqfn6aO
         SDA5bcC3+Yqh19Ra6OuPCxfMfopVtux3Fq3VTs9K3HOT+pV9npbEUIt/G6bkdhtsTcbg
         vIb7c8ZnrXLte19uXE6L1GrHZZ19PJopziPHF4JiYw2LPAcSSqHTOKkwTkAoeEZkf924
         lcFEFTyTlPquX+/eGxe9NBd+LG3GEekTVjsftsO7wewDdNOfSE9Tebko1bXjhaLCjtbj
         ybW7ciUjJqpIjCOoEZOWtWGL5kel9JLYhCS89H12APe8Pm34AaKPYzuIXHKKr6/H8Zba
         2MXg==
X-Gm-Message-State: APjAAAVugUVbg1qGDeIOAwI+wL8tlYKkHvTQCh7BrWWLKAhmxHrS+4uA
        kBxEp5woGWIgFnrRZaGOaNNiIYcLPIrlKXgpkHkC8g==
X-Google-Smtp-Source: APXvYqx/SnEtjDy0ciVF4+liqkodEYASR4S6w603/eqwIhIS2Lvf6CSIQVgbf5ng1w20fkg51AF8ckTTLJqxn2r59Ac=
X-Received: by 2002:a24:65cf:: with SMTP id u198mr6958544itb.32.1557135206826;
 Mon, 06 May 2019 02:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190503115928.27662-1-jagan@amarulasolutions.com> <20190503144651.ttqfha656dykqjzo@flea>
In-Reply-To: <20190503144651.ttqfha656dykqjzo@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 6 May 2019 15:03:15 +0530
Message-ID: <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 8:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, May 03, 2019 at 05:29:28PM +0530, Jagan Teki wrote:
> > Add Ethernet support for orangepi-one-plus board,
> >
> > - Ethernet port connected via RTL8211E PHY
> > - PHY suppiled with
> >   GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
> >   GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
> > - RGMII-RESET pin connected via PD14
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Your commit log should be improved. We can get those informations from
> the patch itself...

Thought it was a clear commit log :)  will update anyway.

>
> > ---
> > Changes for v2:
> > - emac changes on top of https://patchwork.kernel.org/cover/10899529/
> >   series
> >
> >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  8 ++++
> >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 42 +++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > index 12e17567ab56..9e8ed1053715 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > @@ -9,4 +9,12 @@
> >  / {
> >       model = "OrangePi One Plus";
> >       compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
> > +
> > +     aliases {
> > +             ethernet0 = &emac;
> > +     };
> > +};
> > +
> > +&emac {
> > +     status = "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > index 62e27948a3fa..c48e24acaf8a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > @@ -45,6 +45,48 @@
> >               regulator-max-microvolt = <5000000>;
> >               regulator-always-on;
> >       };
> > +
> > +     /*
> > +      * The board uses 2.5V RGMII signalling. Power sequence to enable
> > +      * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
> > +      * at the same time and to wait 100ms.
> > +      */
> > +     reg_gmac_2v5: gmac-2v5 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "gmac-2v5";
> > +             regulator-min-microvolt = <2500000>;
> > +             regulator-max-microvolt = <2500000>;
> > +             startup-delay-us = <100000>;
> > +             enable-active-high;
> > +             gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* GMAC_EN: PD6 */
> > +
> > +             /* The real parent of gmac-2v5 is reg_vcc5v, but we need to
> > +              * enable two regulators to power the phy. This is one way
> > +              * to achieve that.
> > +              */
> > +             vin-supply = <&reg_aldo2>; /* VCC3V3-MAC: GMAC-3V */
> > +     };
> > +};
> > +
> > +&emac {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&ext_rgmii_pins>;
> > +     phy-mode = "rgmii";
> > +     phy-handle = <&ext_rgmii_phy>;
> > +     phy-supply = <&reg_gmac_2v5>;
> > +     allwinner,rx-delay-ps = <1500>;
> > +     allwinner,tx-delay-ps = <700>;
> > +};
> > +
> > +&mdio {
> > +     ext_rgmii_phy: ethernet-phy@1 {
> > +             compatible = "ethernet-phy-ieee802.3-c22";
> > +             reg = <1>;
> > +
> > +             reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* RGMII-RESET: PD14 */
> > +             reset-assert-us = <15000>;
> > +             reset-deassert-us = <40000>;
> > +     };
> >  };
>
> ... however, at no point in time you explain why you made that switch,
> and while most of the definition of the EMAC nodes is in the DTSI, you
> only enable it in one DTS.

The dtsi is shared b/w 1+ and lite2 and 1+ has emac, so I enabled the
status directly on dts and keeping the relevant nodes on dtsi just
like SoC dtsi does. do I need to mention this in commit log?
