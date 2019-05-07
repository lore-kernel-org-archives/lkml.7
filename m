Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E28C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260B320578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Rxxs5hK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEGM5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:57:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54106 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfEGM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:57:48 -0400
Received: by mail-it1-f194.google.com with SMTP id l10so26196437iti.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0tpjcX8McjyYgv5/kWuINyynciVnOO7CJ86ikKZd+4g=;
        b=Rxxs5hK0qGnzH7fqh66e4Eo+TGmNsKGD4tP0wvGisqVV3aZM0m3FHn1ocajb+McYSu
         zbIzQeYY2ji7/XVMqA7EwE+MbcRV455kTsQx4IofquUaVFBi+s5ScLRn3qmLaxJ2AHsc
         U31Hq+5sV3IV/BsGdTFBkPWbaiZxj4/V5jhy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=0tpjcX8McjyYgv5/kWuINyynciVnOO7CJ86ikKZd+4g=;
        b=FO7Kud/Z123WHc6RjLEEdbEgVFrbeMGS2pOpcZKIKdhvklNpx+Uy5NMw3wYek5sq25
         ZjdqG3VgFhf8KKDQCXEQ0zivMvk8sUsUNOwWtqSET3MT6+3SASda6LrwWRkE2f4S/H9s
         bcGDgW1xtni5h9PV4WRuHEuN+xt8U42IlAOLZ6E626Z7o07h/dBolRa865NoHoUoM8LH
         IkudTfqAsli76UM/HDnFImSlzao5SzZ4E03LGS3khpacjJkZ64RiG6H1cKHmimSDPXAC
         YGr8Q3WdPOxqY+0/fyIHca6cwOhdXgXd1qaLjkCWyYa+C9ax/EJ1T2GhB2GjnGQPSjq1
         i9Sw==
X-Gm-Message-State: APjAAAXI5O155Eo7vqIZfkbustGvyl5eA0JnBBlEkYdPmGpEVc1hZkU2
        XeJNGDqd8SakguncVki35xnrUQTja8nPZEJAqeFs8Q==
X-Google-Smtp-Source: APXvYqz8eEfTlDbhEWXsRqixp4YhLJz9Bp5ddH/g4ZeYiffylPkssVgZj/k76i5n4HZ+v9owl78h9IKz8CO5jtPfxZc=
X-Received: by 2002:a24:1cc4:: with SMTP id c187mr2490255itc.107.1557233867322;
 Tue, 07 May 2019 05:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190503115928.27662-1-jagan@amarulasolutions.com>
 <20190503144651.ttqfha656dykqjzo@flea> <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
 <20190506133101.c3twwwydy5mez3db@core.my.home>
In-Reply-To: <20190506133101.c3twwwydy5mez3db@core.my.home>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 7 May 2019 18:27:35 +0530
Message-ID: <CAMty3ZDNi7t-FSj=Wt3p39=CWx-o6QzKgbMKYd93mgDLBMVrbg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: h6:
 orangepi-one-plus: Add Ethernet support
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:01 PM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> On Mon, May 06, 2019 at 03:03:15PM +0530, Jagan Teki wrote:
> > On Fri, May 3, 2019 at 8:16 PM Maxime Ripard <maxime.ripard@bootlin.com=
> wrote:
> > >
> > > On Fri, May 03, 2019 at 05:29:28PM +0530, Jagan Teki wrote:
> > > > Add Ethernet support for orangepi-one-plus board,
> > > >
> > > > - Ethernet port connected via RTL8211E PHY
> > > > - PHY suppiled with
> > > >   GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
> > > >   GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
> > > > - RGMII-RESET pin connected via PD14
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Your commit log should be improved. We can get those informations fro=
m
> > > the patch itself...
> >
> > Thought it was a clear commit log :)  will update anyway.
> >
> > >
> > > > ---
> > > > Changes for v2:
> > > > - emac changes on top of https://patchwork.kernel.org/cover/1089952=
9/
> > > >   series
> > > >
> > > >  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  8 ++++
> > > >  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 42 +++++++++++++++=
++++
> > > >  2 files changed, 50 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-p=
lus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > index 12e17567ab56..9e8ed1053715 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> > > > @@ -9,4 +9,12 @@
> > > >  / {
> > > >       model =3D "OrangePi One Plus";
> > > >       compatible =3D "xunlong,orangepi-one-plus", "allwinner,sun50i=
-h6";
> > > > +
> > > > +     aliases {
> > > > +             ethernet0 =3D &emac;
> > > > +     };
> > > > +};
> > > > +
> > > > +&emac {
> > > > +     status =3D "okay";
> > > >  };
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > index 62e27948a3fa..c48e24acaf8a 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > > @@ -45,6 +45,48 @@
> > > >               regulator-max-microvolt =3D <5000000>;
> > > >               regulator-always-on;
> > > >       };
> > > > +
> > > > +     /*
> > > > +      * The board uses 2.5V RGMII signalling. Power sequence to en=
able
> > > > +      * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power ra=
ils
> > > > +      * at the same time and to wait 100ms.
> > > > +      */
> > > > +     reg_gmac_2v5: gmac-2v5 {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             regulator-name =3D "gmac-2v5";
> > > > +             regulator-min-microvolt =3D <2500000>;
> > > > +             regulator-max-microvolt =3D <2500000>;
> > > > +             startup-delay-us =3D <100000>;
> > > > +             enable-active-high;
> > > > +             gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* GMAC_EN: PD6=
 */
> > > > +
> > > > +             /* The real parent of gmac-2v5 is reg_vcc5v, but we n=
eed to
> > > > +              * enable two regulators to power the phy. This is on=
e way
> > > > +              * to achieve that.
> > > > +              */
> > > > +             vin-supply =3D <&reg_aldo2>; /* VCC3V3-MAC: GMAC-3V *=
/
> > > > +     };
> > > > +};
> > > > +
> > > > +&emac {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&ext_rgmii_pins>;
> > > > +     phy-mode =3D "rgmii";
> > > > +     phy-handle =3D <&ext_rgmii_phy>;
> > > > +     phy-supply =3D <&reg_gmac_2v5>;
> > > > +     allwinner,rx-delay-ps =3D <1500>;
> > > > +     allwinner,tx-delay-ps =3D <700>;
> > > > +};
> > > > +
> > > > +&mdio {
> > > > +     ext_rgmii_phy: ethernet-phy@1 {
> > > > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > +             reg =3D <1>;
> > > > +
> > > > +             reset-gpios =3D <&pio 3 14 GPIO_ACTIVE_LOW>; /* RGMII=
-RESET: PD14 */
> > > > +             reset-assert-us =3D <15000>;
> > > > +             reset-deassert-us =3D <40000>;
> > > > +     };
> > > >  };
> > >
> > > ... however, at no point in time you explain why you made that switch=
,
> > > and while most of the definition of the EMAC nodes is in the DTSI, yo=
u
> > > only enable it in one DTS.
> >
> > The dtsi is shared b/w 1+ and lite2 and 1+ has emac, so I enabled the
> > status directly on dts and keeping the relevant nodes on dtsi just
> > like SoC dtsi does. do I need to mention this in commit log?
>
> Lite 2 doesn't have reg_gmac_2v5 and it also doesn't have the external ph=
y.
> But with this patch, reg_gmac_2v5 will also show up in the Lite 2's final
> DTB.
>
> Comapred to SoC dtsi, the SoC always has things that are in the dtsi, the=
y
> are just not enabled/used by the board, but they are present on the chip.
>
> So this comes down to what the meaning of board-level dtsi should be. I
> doubt we want it to mean "a collection of stuff that may or may not be
> present on the boards that depend on it".

Was thinking in another direction, thanks for the info. agreed.
