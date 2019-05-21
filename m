Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD36C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KeH2Aa8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEUGrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:47:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33718 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfEUGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:47:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so1550144wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dtcdsu0fUtok0q96jnMGpWM0fc0NoVZ6NVYcC/TU3EI=;
        b=KeH2Aa8UGeY3ald/vMtEvRNEPoOZgF6ZxP+nhAsZupukHiOm8t0PXqEZS/WBoeHG/0
         7vTSdr7BTbtHz2o2Jqvx7wMH1SmkqwzYd5Gdg/w0hH3eL/OlPpzUlozsZ4rN6E/h7sMd
         bMdDLCwW+K7eQEPgfsVVK5lh7g25N8mZ7wUgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dtcdsu0fUtok0q96jnMGpWM0fc0NoVZ6NVYcC/TU3EI=;
        b=Mq6oWR2OM2LmGjyBfIa7bimtUgCJlhu56Pn6CBCuNkVFamH5ROn1DGJLnVYNZZXIcD
         i2s3KwxhuX4FoTtjG9Q2NbOvgevD7HOXJ+5N5iIREVdklqKfzC195nufBrzpvXbB4Alq
         0WMSfzfWW08T7AlGl++K8BCSlzLoZh8HynMuzN3Jo9d5/lrzBuyA8i8yn6JzglBnCXmF
         UyMPz4Zd2M7niHTt04xdPl1BFRLi0YBWyLcbD7lo85Ll0B0JvJ6jwRVUJhC4piKmS1XS
         Tv6RysbHTPErzWuNK6emN3vg1ZSl1tnsKCQ8eSnwo4Xax/b7B7RYkFKpPfaRaXSvDdwm
         O5zg==
X-Gm-Message-State: APjAAAWdGYR5izijrpBp47D+OldmlgMxxu8EzQBZAGStXGhMTZ/suHKG
        VqrctyjE0KuGRdF6cCtXXt8CjaUAGAc8sg1nrVWCrQ==
X-Google-Smtp-Source: APXvYqzfKKX+FWJFZbOOtvY+5rX4F4OJzEUSEX+qaWWcrbh0PkdH/kOZOIQuqFdUHG1hJoLc5d9aCY/fi8EkfoSZ+9Y=
X-Received: by 2002:a1c:7310:: with SMTP id d16mr1907943wmb.65.1558421233660;
 Mon, 20 May 2019 23:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190418141658.10868-1-jagan@amarulasolutions.com> <20190418145641.q23tupopz2czjzc5@flea>
In-Reply-To: <20190418145641.q23tupopz2czjzc5@flea>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 21 May 2019 08:47:02 +0200
Message-ID: <CAOf5uwn8CtRs8cx0KC-bxNoRP4TiDrHi8F83QfjsZhueLDYFJg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable CAN
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, Apr 18, 2019 at 4:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Apr 18, 2019 at 07:46:58PM +0530, Jagan Teki wrote:
> > Oceanic 5205 5inMFD has MCP2515 CAN device connected via SPI1.
> >
> > - via SPI1 bus
> > - vdd supplied by 5V supply along with PL2 enable pin
> > - xceiver supply same as vdd
> > - can oscillator connected at 20MHz
> > - PB2 gpio as interrupt pin
> > - PD6 gpio as RX_BUF1_CAN0
> > - PD7 gpio as RX_BUF0_CAN0
> >
> > Tested-by: Tamas Papp <tamas@osukl.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../sun50i-a64-oceanic-5205-5inmfd.dts        | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> > index f0cd6587f619..22535a297f51 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> > @@ -21,6 +21,24 @@
> >       chosen {
> >               stdout-path = "serial0:115200n8";
> >       };
> > +
> > +     can_osc: can-osc {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <20000000>;
> > +     };
> > +
> > +     reg_can_v5v: reg-can-v5v {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "reg-can-v5v";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             regulator-boot-on;
> > +             enable-active-high;
> > +             gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* CAN_3V3_EN: PL2 */
> > +             status = "okay";
>
> You don't need the status property here.
>

Correct, need to be dropped

> > +     };
> > +
> >  };
> >
> >  &ehci0 {
> > @@ -77,6 +95,31 @@
> >       status = "okay";
> >  };
> >
> > +&pio {
> > +     can_pins: can-pins {
> > +             pins = "PD6",                   /* RX_BUF1_CAN0 */
> > +                    "PD7";                   /* RX_BUF0_CAN0 */
> > +             function = "gpio_in";
> > +     };
> > +};
>
> That isn't needed. What are they used for, you're not tying them to
> anything?

Mux of their function is correct. They are connected in the schematics
but not used right now.
I can garantee that kernel wlll always configurred in the right way
and if I want I can export in userspace
for debug purpose

Michael


>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



--
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
