Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4F206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+04xdjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfDYHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:34:50 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37794 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDYHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:34:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id p134so8091534ybc.4;
        Thu, 25 Apr 2019 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jync8zT3pYBQlUFkiBZNXqfiHjID5+lBGeoKEA5uWfI=;
        b=P+04xdjlbqoPGTzo5FzfMh0+S6grgnpxLsoaONtUmmHj8RrK0LgzY82reoG1bJ8AnZ
         tTLaWStqXtJ30RMVMAs5cw5OOSWwvkyoNJsMbBE1NjM4+bDD0p9h916C1HnxolvBEzAA
         x9+tkDxJLOe3yAbvzHQOfhmdfhXRQ7NKfq/yPkdAD1xEeDD99Fka/hSxZjd6nAF7le4c
         x8wW0XRshBrFH7nQevMcVCoirZSHIxyXi2saS+HzB9dS6xiU833Sq2i4lvIn3L/eaKFj
         jIrZkN5qJNlUC11IOGQmp/s47LFfuF40tvXwGaL7YS4OD/KiuBMeRJuo1Z5oUSweA4GU
         LZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jync8zT3pYBQlUFkiBZNXqfiHjID5+lBGeoKEA5uWfI=;
        b=na8s/Yawpata+5Jbb2tHhJgRO6BzUL7AItb9f9v3piKX6JT35tutWwW/jVJXyhstJh
         BzrtlptV+GywMjMqAXngTWpacO7hMJwtpJ9DTK8/3Q0AfGgadR/rKuwQKPZNcw+le6ja
         AEv83MnQpnnQPZSupNKQL/ZB1Au4SYlsx5gkKC8KzcOJb5vhtrgHXLbuXyKKMbj3h83U
         NnPEgDEs657n7FqN695XMB801QhuuV+JnG3mlZR/uzp527cCeaoZ8XTj676P+XMuY9bz
         i+lxRV9ONxchckV7O1O+CRU+H1tSCU7vMy8c8lB6zl378f8EJ65izTuYkVAonrSMo8/z
         sS6w==
X-Gm-Message-State: APjAAAWndokScijQ98yLYeLMpsL5cAS0PsH02CnY5hlHXY+ehMWlaQ3U
        cfwcE/tBiDCKSFzUg6fEYXQhd2nQcypE1Bhgow2gmulKHcs=
X-Google-Smtp-Source: APXvYqwb4Hil9w9Z1eOkhJJEnuKDKMpletRk92eJ0TIqZ3W0s35d7vzNiUCDvKgQYh+qdA/ROuimal60GREYO00mh34=
X-Received: by 2002:a25:d7c1:: with SMTP id o184mr30575996ybg.147.1556177688563;
 Thu, 25 Apr 2019 00:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190411154534.25563-1-peron.clem@gmail.com> <20190411154534.25563-3-peron.clem@gmail.com>
 <CAJiuCcc2CrEBQEoon9p=pitrjqoy6tzOSjhjBY3=oXNCHdiZ5A@mail.gmail.com> <20190423160545.muolantrdppz35rz@flea>
In-Reply-To: <20190423160545.muolantrdppz35rz@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 25 Apr 2019 09:34:36 +0200
Message-ID: <CAJiuCce_KZzYx5T3bq3i_PHGGSts_=Fh==c0CvqsuHhdqmsG-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: h6: add r_watchog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 at 18:05, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Fri, Apr 19, 2019 at 09:00:42PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > On Thu, 11 Apr 2019 at 17:34, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> > >
> > > Allwinner H6 has a r_watchdog similar to A64.
> > >
> > > Declare it in the device-tree.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 5c2f5451227b..66dc684a378e 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -622,6 +622,13 @@
> > >                         #reset-cells =3D <1>;
> > >                 };
> > >
> > > +               r_watchdog: watchdog@7020400 {
> > > +                       compatible =3D "allwinner,sun50i-a64-wdt",
> > > +                                    "allwinner,sun6i-a31-wdt";
> > > +                       reg =3D <0x07020400 0x20>;
> > > +                       interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HI=
GH>;
> > > +               };
> >
> > I have set the same compatible as A64 because regarding the User
> > Manual they have exactly the same memory mapping.
> > However we don't know really if it's the same IP version, maybe there
> > will be an errata one day.
> > So I would like to know if it's better to define the h6-wdt also
> >   compatible =3D  "allwinner,sun50i-h6-wdt", "allwinner,sun50i-a64-wdt"=
,
> >                                  "allwinner,sun6i-a31-wdt";
> >
> > I would say Yes, but with this logic we would have to had a new
> > compatible each time there is a  new SoC.
>
Hi,

> Why not just having the A31 compatible?
H6 has a lightly differences in registers with A31 but it's the same
as 64 (WDOG_KEY_FIELD)

As the A64 is already introduced if think it's a good solution to reuse it.

Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
