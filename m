Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60F20818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQRaIVaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfDHOiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:38:04 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40385 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:38:04 -0400
Received: by mail-yb1-f194.google.com with SMTP id q17so3411457ybg.7;
        Mon, 08 Apr 2019 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5zgQg9h/+XGqw9uMKR3O8ZtKmVTVYMFaTyu50OJbK4=;
        b=gQRaIVajH0rvJYN/BDkG6sGy85E5IM4jg5swzb/3XkeTczwpEdR+IrVIMCGV8ivMIA
         voGBTfbjqedsLZx0uQMpDFpkgCCr6c73WuiJGgcDVWr+96d1T7YzH/77NsMRuzlwLwzP
         KCB62jyB9NHhigIOkInxhxtu/EiRiWqA0ImXe+YEOluzLasU+r3dXmXHwwb2A1Qpe69U
         TnWH4ICVsztTaDt64LKatQHwlg5RChhE0OxezUbduQfWU/8Zqss9DmjZXY0e0vzoWOMw
         MRZ+pBDnhVH7D6HDRyeFGrJX3eFCOKJULiOthtaVb6rNEZVk8zG4/88z3+5H5bp7N1YW
         91Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5zgQg9h/+XGqw9uMKR3O8ZtKmVTVYMFaTyu50OJbK4=;
        b=BK3R4xx1k3+kL4Iv+O3cWreSKrVPxuYJ022ks/zjSGCVrY0PKlU7hkqbSDR5oO/FFU
         kPXhJ60N8FWXj1joJjiRImZetYZA+Z5YHN407hg2ceiYk59Olnv2aNyRizNfuCqapDwI
         dHzCX2HAdb4OBCLNd2O2faCohaSt5gX6zN2/Fa4laTKMAanflJ4NrGqzC6OWx1e7k0Of
         ZAs4+wmHg5hq5ZgcSSWbkVLr+bhdQZM8UtmdXxOoYu1hoZoFpmw8gXxC1U6Ciiv/f3Gw
         Gdyuw2pL2W92CdUJZFvrkp3jJai/YJ7VyndBigTUcMmajBwPuLYTpakshUUXj5rSpFOs
         1mMw==
X-Gm-Message-State: APjAAAWZNNLzg6M/wNEN4MDzG2uedJoBFnMRY81nMZoy+L6Ayw146QSX
        vgeqveGzUpG+bNIRjS3FITdO/1sFKkg6Bx7JUtw=
X-Google-Smtp-Source: APXvYqyFA7qMT1LrdfAwfDoOSF1fCvVzNvOS9p5V1HGk+7PcHb91ckV3cyGL4nlXiqU8TLeIQeGliMQqj/AtAgU4dDo=
X-Received: by 2002:a5b:144:: with SMTP id c4mr25006837ybp.328.1554734283250;
 Mon, 08 Apr 2019 07:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190408092619.23152-1-peron.clem@gmail.com> <20190408092619.23152-2-peron.clem@gmail.com>
 <20190408104157.tdxg2al3fpanhqqu@flea>
In-Reply-To: <20190408104157.tdxg2al3fpanhqqu@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 8 Apr 2019 16:40:17 +0200
Message-ID: <CAJiuCcfpM0nC3W8+kLE+di-H5ph+u5kGRbCd31orax68A3iA4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Apr 2019 at 12:42, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Mon, Apr 08, 2019 at 11:26:14AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > There is only one pinmuxing available for each MMC controller.
> >
> > Move the pinctrl to the SOC
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 2 --
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts  | 4 ----
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi          | 4 ++++
> >  3 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > index b2526dac2fcf..62e27948a3fa 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > @@ -56,8 +56,6 @@
> >  };
> >
> >  &mmc0 {
> > -     pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&mmc0_pins>;
> >       vmmc-supply =3D <&reg_cldo1>;
> >       cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >       bus-width =3D <4>;
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arc=
h/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > index bdb8470fc8dc..4802902e128f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > @@ -104,8 +104,6 @@
> >  };
> >
> >  &mmc0 {
> > -     pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&mmc0_pins>;
> >       vmmc-supply =3D <&reg_cldo1>;
> >       cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >       bus-width =3D <4>;
> > @@ -113,8 +111,6 @@
> >  };
> >
> >  &mmc2 {
> > -     pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&mmc2_pins>;
> >       vmmc-supply =3D <&reg_cldo1>;
> >       vqmmc-supply =3D <&reg_bldo2>;
> >       non-removable;
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index 3e4bb0b0de69..006d3b6418af 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -278,6 +278,8 @@
> >                       resets =3D <&ccu RST_BUS_MMC0>;
> >                       reset-names =3D "ahb";
> >                       interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +                     pinctrl-names =3D "default";
>
> This is indented with spaces and not tabulations. This error is
> reported by checkpatch.
>
> > +                     pinctrl-0 =3D <&mmc0_pins>;
> >                       status =3D "disabled";
> >                       #address-cells =3D <1>;
> >                       #size-cells =3D <0>;
> > @@ -306,6 +308,8 @@
> >                       resets =3D <&ccu RST_BUS_MMC2>;
> >                       reset-names =3D "ahb";
> >                       interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > +                     pinctrl-names =3D "default";
> > +                     pinctrl-0 =3D <&mmc0_pins>;
>
> I guess you meant mmc2?
Yes

>
> Can you test your patches before sending them please?
I made a test before posting the patch but I think my U-boot correctly
mux the pins before linux.
That's why I didn't catch it.
Anyway it's really trival and I should have seen it.
My apologizes for this,
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
