Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215021726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbfHWKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:10:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40164 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403955AbfHWKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:10:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id h8so12644041edv.7;
        Fri, 23 Aug 2019 03:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKS1KyGtoYN5+tkn28jHjU+gIFqU2WJasV1MLrqgjLs=;
        b=b0MV9XKh9RidUDsYXQ/jkbqG5eibm3f9ZNj4Gqj9niDBSMBaFWHW2GEUlccbUaZvMe
         iwfbv2Ukt6Ya2gJFHdRWqqHuEHdkbQTlsHS7oxLB4Ln81vsw7Ajz+OHZEFmVgEE8QKcI
         +i/+lm+J6WLcu6SMOY8SYPFVAaHJ84+3aALm3ihFt39DOvkPAxetHRyvXxFhDYigVzuC
         8PZCFXliNWcj9IbQuHHu35A/JZmO4L91p3mjtl8m5ucCJTBdYFbbtjegQn+VpsMvPn2I
         +zXBY3hjmUk8IqrCiRWWqm4AYwpNCS6VPqg+nHdXH+I2ylbqOJaiSAQgIYnhjGQ87Sb+
         OfkQ==
X-Gm-Message-State: APjAAAUyxgN2RpqHYXWQJPX28mDO2OocUlQO+bDnYAJI4/KrfdOEGwwd
        FzTDVWs2tUzjGW/1+NFx4Bkvpi9p000=
X-Google-Smtp-Source: APXvYqx0Mg+LBPYLQ/3JwNlw5biflPeonaUTQhIu/M1eVqYE6s+h3lHIJuP65z0pTwGr+fRVveRBLw==
X-Received: by 2002:a50:9177:: with SMTP id f52mr3515178eda.294.1566555045188;
        Fri, 23 Aug 2019 03:10:45 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id l9sm430960eds.96.2019.08.23.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 03:10:44 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l2so8558968wmg.0;
        Fri, 23 Aug 2019 03:10:44 -0700 (PDT)
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr4120674wml.25.1566555044102;
 Fri, 23 Aug 2019 03:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190823094228.6540-1-megous@megous.com> <20190823100807.22heh2gahi7owo4e@flea>
In-Reply-To: <20190823100807.22heh2gahi7owo4e@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 23 Aug 2019 18:10:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v65mDt8t2sceTzKvYP6XVHJgikXyYMc+xWxZFkTJ+LZ1fg@mail.gmail.com>
Message-ID: <CAGb2v65mDt8t2sceTzKvYP6XVHJgikXyYMc+xWxZFkTJ+LZ1fg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: orange-pi-3: Enable WiFi
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 6:08 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Fri, Aug 23, 2019 at 11:42:28AM +0200, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > Orange Pi 3 has AP6256 WiFi/BT module. WiFi part of the module is called
> > bcm43356 and can be used with the brcmfmac driver. The module is powered by
> > the two always on regulators (not AXP805).
> >
> > WiFi uses a PG port with 1.8V voltage level signals. SoC needs to be
> > configured so that it sets up an 1.8V input bias on this port. This is done
> > by the pio driver by reading the vcc-pg-supply voltage.
> >
> > You'll need a fw_bcm43456c5_ag.bin firmware file and nvram.txt
> > configuration that can be found in the Xulongs's repository for H6:
> >
> > https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256
> >
> > Mainline brcmfmac driver expects the firmware and nvram at the following
> > paths relative to the firmware directory:
> >
> >   brcm/brcmfmac43456-sdio.bin
> >   brcm/brcmfmac43456-sdio.txt
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >
> > Since RTC patches for H6 were merged, this can now go in too, if it looks ok.
> >
> > Other patches for this WiFi chip support were merged in previous cycles,
> > so this just needs enabling in DTS now.
> >
> > Sorry for the links in the commit log, but this information is useful,
> > even if the link itself goes bad. Any pointer what to google for
> > (file names, tree name) is great for anyone searching in the future.
>
> I understand, but this should (also?) be in the wiki. Please add it
> there too.
>
> > Please take a look.
> >
> > Thank you,
> >       Ondrej
> >
> >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > index eda9d5f640b9..49d954369087 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > @@ -56,6 +56,34 @@
> >               regulator-max-microvolt = <5000000>;
> >               regulator-always-on;
> >       };
> > +
> > +     reg_vcc33_wifi: vcc33-wifi {
> > +             /* Always on 3.3V regulator for WiFi and BT */
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc33-wifi";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-always-on;
> > +             vin-supply = <&reg_vcc5v>;
> > +     };
> > +
> > +     reg_vcc_wifi_io: vcc-wifi-io {
> > +             /* Always on 1.8V/300mA regulator for WiFi and BT IO */
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc-wifi-io";
> > +             regulator-min-microvolt = <1800000>;
> > +             regulator-max-microvolt = <1800000>;
> > +             regulator-always-on;
> > +             vin-supply = <&reg_vcc33_wifi>;
> > +     };
> > +
> > +     wifi_pwrseq: wifi_pwrseq {

IIRC we shouldn't use underscores in node names. Maxime can you fix that up?

ChenYu

> > +             compatible = "mmc-pwrseq-simple";
> > +             clocks = <&rtc 1>;
> > +             clock-names = "ext_clock";
> > +             reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> > +             post-power-on-delay-ms = <200>;
> > +     };
> >  };
> >
> >  &cpu0 {
> > @@ -91,6 +119,25 @@
> >       status = "okay";
> >  };
> >
> > +&mmc1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&mmc1_pins>;
>
> This is the default already. I've removed it and applied.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
