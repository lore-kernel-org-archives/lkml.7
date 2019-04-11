Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDABCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902AE2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaYmM/4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDKPU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:20:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37416 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:20:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so2196821ywd.4;
        Thu, 11 Apr 2019 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AXTt1TFBMBOViy/QP1pNCCk2KiS3VbjgXEWNmIrzuNs=;
        b=MaYmM/4lfJg5wk3kk1Y5WH9pgU+wvFPggreJCBr9j7CpgeJszR8Jf6UbW4RcXVZ+uh
         nHQL98UeMDcw2n9QRWrF29h86bRwi/EGMXIV73l2lLVWcbHciBNb5pq8HJcP6yWMHyJe
         qYHDHC/PFSEeV74G/5RBUg32QtTGcfFaVz/PmysqNcdFnGLnF24qlIlRbwL4ClhfVfc+
         9TPIu2IOK1bJwni3WOigblGtinwkz5rGjEollkE4qxeDDAVvRgIJkn98+k7rkdLvQkxr
         bIM0JO4VZ6GVC1LSf3tvuiR+t6vLWvGv7hL8dOJnqhux8p838KlpUsfHj3HL45Sy5Mh/
         GI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AXTt1TFBMBOViy/QP1pNCCk2KiS3VbjgXEWNmIrzuNs=;
        b=S6JBiuJiIKUBS8aAsOVe9ee8Z3Xr5YdoaCCoyLAxRE1wmLh/gf3mlmU+/1W7pls8xp
         HPEPFtp4UQ5XhEIsS2CSslFyu4CpZSeWLl9pRCiZTimSulBNM54pfoaVMUQR8OpmxyxE
         N1f65OLgsPtjHVUX5KX7/qbXCNpiYYnD1v3anwHWF7zdbtvsCfDvOntv0l9dLcm3F60E
         PoMTSGAO6neMUBwDEskAQ0WavDISP9VxxXyMNMaxjzgmSQDx9+MIRLjykAv3vX81eEz1
         sKGZgV/tcm2918pExvFMn6J3oOyVOMdt7bXek5rEO+YztoNuKsLF6znHZHw0sUJhsM3J
         pr+w==
X-Gm-Message-State: APjAAAUNcMaub1lBA2YcVntXUSPBdeHV415vlxt/DCnJZsTFwz6u2BME
        uMYemR4EaZJgfcuXfnsZy0JGNtk6+ak8Mp95pjQ=
X-Google-Smtp-Source: APXvYqzqlqa/5f8JTk4U0iXDHff5gLXK2d40FLKKOep04m3g5KehU7cVC0C0sTNtklJ8yvMd9DP/XEacsy0ZI7NlBDo=
X-Received: by 2002:a81:6f87:: with SMTP id k129mr40791228ywc.322.1554996027634;
 Thu, 11 Apr 2019 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105720.32357-1-peron.clem@gmail.com> <20190411105720.32357-5-peron.clem@gmail.com>
 <2957024.jOddxINRMN@jernej-laptop>
In-Reply-To: <2957024.jOddxINRMN@jernej-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 17:20:04 +0200
Message-ID: <CAJiuCcdo_WAP1_rOcqOcoNkt7rdGb3H_GVMN2DiZnvo_4c=7DA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 17:05, Jernej =C5=A0krabec <jernej.skrabec@siol.net>=
 wrote:
>
> Dne =C4=8Detrtek, 11. april 2019 ob 12:57:16 CEST je Cl=C3=A9ment P=C3=A9=
ron napisal(a):
> > Add the mali gpu node to the H6 device-tree.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > e0dc4a05c1ba..196753110434 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -157,6 +157,20 @@
> >                       allwinner,sram =3D <&ve_sram 1>;
> >               };
> >
> > +             gpu: gpu@1800000 {
> > +                     compatible =3D "allwinner,sun50i-h6-mali",
> > +                                  "arm,mali-t720";
> > +                     reg =3D <0x01800000 0x4000>;
> > +                     interrupts =3D <GIC_SPI 84
> IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 85
> IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 83
> IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names =3D "job", "mmu", "gpu";
> > +                     clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> > +                     clock-names =3D "core", "bus";
> > +                     resets =3D <&ccu RST_BUS_GPU>;
> > +                     status =3D "disabled";
>
> Usually self sufficient peripherals are enabled by default in DTSI.

I follow the other Mali Midgard (rk3399, rk3288) syntax.
But I think you're right here, will go for an update I think.

Clement

>
> > +             };
> > +
> >               syscon: syscon@3000000 {
> >                       compatible =3D "allwinner,sun50i-h6-system-
> control",
> >                                    "allwinner,sun50i-a64-
> system-control";
>
>
>
>
