Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B839DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797D220663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx1A50aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfHLHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:12:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39260 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:12:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id s142so8592808ybc.6;
        Mon, 12 Aug 2019 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w53iwTfuNgVzz+uekdvZLevbq0Q8+wQ8XWoSTjhLEzw=;
        b=dx1A50aNGZNyaxktizwfsIS5ig44DHRVLmjnRFBxzE2aEVU5gp9aDwZyRbfQ1xM+ls
         aPbSCNMVVMseuHKonr5RmEpdmDF773I6dzbPr0ZiapfPWYaMmbvwrdeKGKjq5DWtvPWk
         85rd6xty+3YXrIZEiag82dgZZiPVpgFV3XMK5t8THU//e9elcVF/KSvc79jXjSA85HoZ
         E6J4wsVh6zq9zXFV3rGsNqalljXtxizDfHtUWUH9MI43T1bmzWCm+5qioWCty8BiITj/
         FUF3305LVRMdcGdtdAChlUWc/Ise2vpHp6p52/dNwF2LxwWt2AR+UcyY7+xaR9UmlKmM
         Rs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w53iwTfuNgVzz+uekdvZLevbq0Q8+wQ8XWoSTjhLEzw=;
        b=VDnG6JkQevCePuTo5E53IURr/TUVkB3A3HPPxXtzrpPnE0p8boh5gECEL7MH8SqySM
         TRJRn+rRydLrn+NgqC/MKS2esuBhfJfSYGUJ6CX26YMA22Gjy9HhUrrKV0pBy2jhemyC
         KAVF97DtVZScT8wJBHgADrOgZwQEBsZgy6uzmh6HhSA78oXZ/2fJLk44In9NE3sZhDTn
         PbP5AsDeqxw9lOob/Yns53SNII1GMWLOhtkVSrJiGojomBHJgTi/+JQM33ggBa4DAAWw
         PefXwJmTtVcPL0iNJskQ7Iz0H4b4xUHpIW5VgCfFHDlCW5JTNYgCHDLWXwbXztpGX7AQ
         r0hg==
X-Gm-Message-State: APjAAAVTPfAgJccAoRR+kPr5cJNCF/72K9OWrYM/eGXQdl6+Il1OnNEO
        xFBp8vBknA+Sa/nTf3QgLxwrEBIpW7Aiu+WjT24=
X-Google-Smtp-Source: APXvYqxK5RP5HKV5KbAdo8Zc5B28TcBzX3ZmB0Wav0s3p5jBwAteFRui/TZGArGh2FLJK84pClkqbky376KDbpr3PPE=
X-Received: by 2002:a5b:9c9:: with SMTP id y9mr291017ybq.438.1565593921754;
 Mon, 12 Aug 2019 00:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190811203144.5999-1-peron.clem@gmail.com> <20190811203144.5999-2-peron.clem@gmail.com>
 <CAGb2v67T3h_KTVZ20NVWNd78xqCa2ZhYiCJr4oOwYjUM3OaZXA@mail.gmail.com> <CAGb2v67N5Ykzo6myKqrNMgu6PCH2pJTzw9JJ5t0MGP_p=0ae9g@mail.gmail.com>
In-Reply-To: <CAGb2v67N5Ykzo6myKqrNMgu6PCH2pJTzw9JJ5t0MGP_p=0ae9g@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 12 Aug 2019 09:11:50 +0200
Message-ID: <CAJiuCccoxzjmuZLrD88NgKZmwWhWkNq5xD=bTF5fgkq6M0Qb4g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 1/3] arm64: dts: allwinner: Add SPDIF
 node for Allwinner H6
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, 12 Aug 2019 at 08:35, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Mon, Aug 12, 2019 at 12:52 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 12, 2019 at 4:31 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >
> > > The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).
> > >
> > > Only one pinmuxing is available so set it as default.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++=
++
> > >  1 file changed, 38 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 7628a7c83096..677eb374678d 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -83,6 +83,24 @@
> > >                 method =3D "smc";
> > >         };
> > >
> > > +       sound-spdif {
> > > +               compatible =3D "simple-audio-card";
> > > +               simple-audio-card,name =3D "sun50i-h6-spdif";
> > > +
> > > +               simple-audio-card,cpu {
> > > +                       sound-dai =3D <&spdif>;
> > > +               };
> > > +
> > > +               simple-audio-card,codec {
> > > +                       sound-dai =3D <&spdif_out>;
> > > +               };
> > > +       };
> > > +
> > > +       spdif_out: spdif-out {
> > > +               #sound-dai-cells =3D <0>;
> > > +               compatible =3D "linux,spdif-dit";
> > > +       };
> > > +
> >
> > We've always had this part in the board dts. It isn't relevant to board=
s
> > that don't have SPDIF output.
> >
> > Also, not so relevant here, but there are different simple sound card
> > constructs. Some support multiple audio streams with dynamic PCM routin=
g.
> > How these are configured really depends on what interfaces are usable.
> >
> > So keeping this at the board level is IMO a better choice.

I Agree, I try to keep coherency with sun50i-a64.dtsi.
But sound routing is really at board level not SoC one.

Regards,
Cl=C3=A9ment

>
> Forgot to mention. Both patches and all parts in this patch are OK. It's
> just the parts the need to be moved.
>
>
> > ChenYu
> >
> >
> > >         timer {
> > >                 compatible =3D "arm,armv8-timer";
> > >                 interrupts =3D <GIC_PPI 13
> > > @@ -282,6 +300,11 @@
> > >                                 bias-pull-up;
> > >                         };
> > >
> > > +                       spdif_tx_pin: spdif-tx-pin {
> > > +                               pins =3D "PH7";
> > > +                               function =3D "spdif";
> > > +                       };
> > > +
> > >                         uart0_ph_pins: uart0-ph-pins {
> > >                                 pins =3D "PH0", "PH1";
> > >                                 function =3D "uart0";
> > > @@ -411,6 +434,21 @@
> > >                         };
> > >                 };
> > >
> > > +               spdif: spdif@5093000 {
> > > +                       #sound-dai-cells =3D <0>;
> > > +                       compatible =3D "allwinner,sun50i-h6-spdif";
> > > +                       reg =3D <0x05093000 0x400>;
> > > +                       interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIG=
H>;
> > > +                       clocks =3D <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SP=
DIF>;
> > > +                       clock-names =3D "apb", "spdif";
> > > +                       resets =3D <&ccu RST_BUS_SPDIF>;
> > > +                       dmas =3D <&dma 2>;
> > > +                       dma-names =3D "tx";
> > > +                       pinctrl-names =3D "default";
> > > +                       pinctrl-0 =3D <&spdif_tx_pin>;
> > > +                       status =3D "disabled";
> > > +               };
> > > +
> > >                 usb2otg: usb@5100000 {
> > >                         compatible =3D "allwinner,sun50i-h6-musb",
> > >                                      "allwinner,sun8i-a33-musb";
> > > --
> > > 2.20.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > To view this discussion on the web, visit https://groups.google.com/d=
/msgid/linux-sunxi/20190811203144.5999-2-peron.clem%40gmail.com.
