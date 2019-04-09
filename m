Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BC3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CAF20818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554772170;
	bh=1BkXaBHmADM0p2CpTukf2bZxhHWNCIxFzO/Rrf4FZCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HKKreuXitKKR0HLSPpBqeuxMy8t5sR6rNayVHQ06BF1B1heTprrWzgJhEUJopMTpY
	 z2NWkD17IiXiEOAYeM+rYrw/Rc2VQfCZRhtnlWSba9Imi7CukQKe9iebxRjKuR8H5Q
	 /jrcHXF40dH5IM0EwEECp4X5qn+rS11G1lm5B3/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfDIBJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:09:29 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6ED21874;
        Tue,  9 Apr 2019 01:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554772167;
        bh=1BkXaBHmADM0p2CpTukf2bZxhHWNCIxFzO/Rrf4FZCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=00c2jEDjpGNAhhfi7vQ2PVbSmek1kMqwGE8pZhnouFjHtAb0aFoWTV0H8xl+sO9Z4
         xW1ktk2KrA58rH305O8nwfEo3IDBEe6AyvzUIyhr+liiFNGxH/KGGPozGeZUlNJm6M
         L6EGDiniZLduFCwlxqeCrrYZtqQo9Cfq3XmZs3RI=
Received: by mail-qt1-f174.google.com with SMTP id t28so17850127qte.6;
        Mon, 08 Apr 2019 18:09:27 -0700 (PDT)
X-Gm-Message-State: APjAAAVKFqIyrXRMbp+7idnl/t1kRqW2pcnGEmieSQFAeRlyAesgB4Dl
        SQ4GmgWcf1LyH8zkehDpKWP5VG/04kZUe6hvrQ==
X-Google-Smtp-Source: APXvYqwzZYb2mCrLdNnyppoU0hlsrw18yJQ5hvEX7pAlMdPoB4W0VXSuh1I/hnrX3b5krKBmkP+Dy1VLd5bRThf5iGo=
X-Received: by 2002:ac8:33cf:: with SMTP id d15mr28265010qtb.149.1554772166965;
 Mon, 08 Apr 2019 18:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190405205736.55177-1-icenowy@aosc.io> <20190405205736.55177-3-icenowy@aosc.io>
 <20190406071402.GA6006@bogus> <B954438A-73B2-4156-81CD-197C08D0E3F5@aosc.io>
In-Reply-To: <B954438A-73B2-4156-81CD-197C08D0E3F5@aosc.io>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 20:09:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMxhbvT6jv+-tsaOPq4anTjRPn0b2qVp=TF4uh6KDzNw@mail.gmail.com>
Message-ID: <CAL_JsqJMxhbvT6jv+-tsaOPq4anTjRPn0b2qVp=TF4uh6KDzNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 2:24 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2019=E5=B9=B44=E6=9C=886=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:14:02, Rob Herring <robh@kernel.org> =E5=86=99=E5=88=B0:
> >On Sat, Apr 06, 2019 at 04:57:33AM +0800, Icenowy Zheng wrote:
> >> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> >> external USB3 pins of the SoC.
> >>
> >> Add a device tree binding for the PHY.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >> Changes in v5:
> >> - Dropped Vbus regulator and added connector subnode.
> >>
> >> Changes in v4:
> >> - Changed Vbus regulator property to vbus-supply.
> >>
> >> Changes in v3:
> >> - Added Chen-Yu's Review tag.
> >>
> >> No changes in v2, v1.
> >>
> >>  .../bindings/phy/sun50i-usb3-phy.txt          | 28
> >+++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>  create mode 100644
> >Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >>
> >> diff --git
> >a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >> new file mode 100644
> >> index 000000000000..eeedc53e6360
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> >> @@ -0,0 +1,28 @@
> >> +Allwinner sun50i USB3 PHY
> >> +-----------------------
> >> +
> >> +Required properties:
> >> +- compatible : should be one of
> >> +  * allwinner,sun60i-h6-usb3-phy
> >> +- reg : a list of offset + length pairs
> >> +- #phy-cells : from the generic phy bindings, must be 0
> >> +- clocks : phandle + clock specifier for the phy clock
> >> +- resets : phandle + reset specifier for the phy reset
> >> +
> >> +Optional nodes:
> >> +- connector : A sub-node required for representing the connector
> >connected
> >> +          to the USB PHY. See ../connector/usb-connector.txt for
> >details.
> >> +
> >> +Example:
> >> +    usb3phy: phy@5210000 {
> >> +            compatible =3D "allwinner,sun50i-h6-usb3-phy";
> >> +            reg =3D <0x5210000 0x10000>;
> >> +            clocks =3D <&ccu CLK_USB_PHY1>;
> >> +            resets =3D <&ccu RST_USB_PHY1>;
> >> +            #phy-cells =3D <0>;
> >> +
> >> +            connector {
> >> +                    compatible =3D "usb-a-connector";
> >> +                    label =3D "USB3";
> >
> >The binding defines that a connector is a child of USB controller or
>
> Please note that the word used is not "USB controller", but "USB interfac=
e
> controller".

Same thing.

We do not represent PHYs as part of the hierarchy. The controller just
points to its PHY with the 'phys' property, but is not part of the
graph.

Unless your PHY handle USB-C functions like PD and alternate modes,
then it shouldn't be part of the graph.

> A USB controller is something that deal with USB protocol, and connect to=
 a USB
> PHY with ULPI/UTMI/PIPE interface. It's not connected to the connector
> directly at all. Then the PHY is connected to the interface controller (i=
f present), or
> the connector, with D+, D- and SS pins.
>
> >some port controller (such as USB-C ctrlr) with OF graph to USB
> >controller. So either way, this is wrong unless this is more than just
> >a
> >phy.
> >
> >Rob
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> =E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84=
Android=E8=AE=BE=E5=A4=87=E3=80=82
