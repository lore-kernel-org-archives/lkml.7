Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BEFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E972077B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyu+bD4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfIAN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 09:58:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46226 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfIAN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 09:58:04 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so24036696iog.13;
        Sun, 01 Sep 2019 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF+meSx1bEFTy7Z7hGNAu8TZHiib5xXgk5qjoCl0TyY=;
        b=uyu+bD4gbp/hsOiWFHXuhhGeQrdXDIWEO3Z9+WuN2O47auyKnWqbhA9GVU9SGeW7yp
         ULQfWtPpwwAfqPvq2ahn5VJTe7l00ou/jwxaxknko7ozNkyHx7qIYswy7ZwwaywkLOl2
         YLvu7eSanN9mjhNEGdsq+Xl0gAdMUZvYwJmAUe9a3pEj3nEJ07t5TW/ZtS9X+y4RB3K3
         u6mBEZzBz2iu5Dfsri/Zmj7Gf6xkHXb6zNmYrjqgcaGU9cSRB8FmZZSz0/y50A+IgTUQ
         hFOsSIO0w7cwxS46fiF9ChXTLfePH7S/Da+iY9lsEFP+sE9q7KRTtnFH9NfA+fKpfUR1
         6CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF+meSx1bEFTy7Z7hGNAu8TZHiib5xXgk5qjoCl0TyY=;
        b=r6SpbNV2RTsPd2SUC1HC+RjIjEQicqyEkEJkN7O36/93j4N43PbuddvQofU1GkS6BR
         RMi2HwYps2lWTSIY3ZE4aoAkL/DNw/Y1TdQv5dkS0d0612xMoAEOQLNRKEgdcEXPsT5w
         QE73X06zbtpj1RBRc/Vsp7Po9JbFp3Ax+F9E95oW042Vbm15gQQCGOv38RYQP/IW9mr+
         nUgJhqMYDjBtGv5Ih+U+0FBhUa4sQ74QVhqXEmhuQGo6g5uoMaJ8e8nb5e9v+Ue81aSG
         3xFGumzYEr3JAjjVee+rPxSwERLJxvHFJvVW21DenBeEFBKl6waINcn2IOOrlZTxmn0x
         B/TQ==
X-Gm-Message-State: APjAAAU5SiI2dfymZp0OwHxA2DaNxfwVjx6X5jyntjJMWZzP/MaIkIY5
        iMoHNpS3fPxXSlxDT81mvoXsPP/NcZ5Rl9c8gXc=
X-Google-Smtp-Source: APXvYqx5+qJklr9M1xU6EtAgkQ41VZKlq5q76eM9Ir5udtUUFGL0apaVA6CNyP7esnU8bnVx0gk8NAASa6bpJFnNY3Y=
X-Received: by 2002:a5d:8e15:: with SMTP id e21mr7192495iod.296.1567346283789;
 Sun, 01 Sep 2019 06:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-2-linux.amoon@gmail.com>
 <CAFBinCBWq0LcdA1-a5W06zKp0RzGs5_=Mph6StGKXJ7npCgbfg@mail.gmail.com>
In-Reply-To: <CAFBinCBWq0LcdA1-a5W06zKp0RzGs5_=Mph6StGKXJ7npCgbfg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 1 Sep 2019 19:27:47 +0530
Message-ID: <CANAwSgS+HGYXr290=EvdhKxh3TiBOqfbcuuF4cMAiBVX1ez9+Q@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to P5V0 regulator
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your review comments.

Their have been some revision changes in S905 Odroid Schematics.
[0] https://dn.odroid.com/S905/Schematic/

Well I have make my changes based on old odroid-c2_rev0.2_20151218.pdf

On Sun, 1 Sep 2019 at 17:07, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per shematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
> typo: "schematics"
>
OK. next time will run spell check before I send these changes.

> > fixed regulator output which is supplied by P5V0.
> >
> > Rename vcc3v3 regulator node to vddio_ao3v3 as per shematics.
> typo: "schematics"
Ok.
>
> according to the schematics there's both:
> - VDDIO_AO3V3
> - VCC3V3 (which is turned on by VDDIO_AO3V3, see [0])
>

From the schematics it seams same.

VDDIO_AO3V3---DMG340LSQN4 (Q4)---VCC3V3

But this name change was done to link TFLASH_VDD_EN to TFLASH_VDD for eMMC

VDDIO_AO3V3-----TFLASH_VDD using  TFLASH_VDD_EN gpio pin.

Well I have tested this changes on eMMC module.

> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 29 +++++++++++++++++--
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index 792698a60a12..98e742bf44c1 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -104,11 +104,34 @@
> >                 regulator-max-microvolt = <1800000>;
> >         };
> >
> > -       vcc3v3: regulator-vcc3v3 {
> > +       vddio_ao1v8: regulator-vddio-ao1v8 {
> >                 compatible = "regulator-fixed";
> > -               regulator-name = "VCC3V3";
> > +               regulator-name = "VDDIO_AO1V8";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               regulator-always-on;
> > +               /* U17 RT9179GB */
> > +               vin-supply = <&p5v0>;
> > +       };
> > +
> > +       vddio_ao3v3: regulator-vddio-ao3v3 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "VDDIO_AO3V3";
> >                 regulator-min-microvolt = <3300000>;
> >                 regulator-max-microvolt = <3300000>;
> > +               regulator-always-on;
> > +               /* U11 MP2161GJ-C499 */
> > +               vin-supply = <&p5v0>;
> > +       };
> > +
> > +       vddc_ddr: regulator-vddc-ddr {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "DDR_VDDC";
> personally I would call this (along with the node name and alias) DDR3_1V5
> odroid-c2_rev0.1_20150930.pdf shows that DDR3_1V5 and DDR_VDDC are
> both the same. however, the DDR_VDDC signal name is not used by any
> component in the datasheet

Ok Thanks I will change this to DDR3_1V5 as per the datasheet.
>
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1500000>;
> > +               regulator-always-on;
> > +               /* U15 MP2161GJ-C499 */
> > +               vin-supply = <&p5v0>;
> >         };
> >
> >         emmc_pwrseq: emmc-pwrseq {
> > @@ -301,7 +324,7 @@
> >         mmc-hs200-1_8v;
> >
> >         mmc-pwrseq = <&emmc_pwrseq>;
> > -       vmmc-supply = <&vcc3v3>;
> > +       vmmc-supply = <&vddio_ao3v3>;
> odroid-c2_rev0.1_20150930.pdf uses VCC3V3 as supply
>
>
> Martin

Best Regards

-Anand
