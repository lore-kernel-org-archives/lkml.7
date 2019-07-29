Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B5C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CDE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3NGlBhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfG2JD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42432 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2JD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:03:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so11014022wrr.9;
        Mon, 29 Jul 2019 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7y+B0NsHK08ns87YYWWmTZg44ekWnBl+gyEZRdNH7dk=;
        b=Q3NGlBhYcmY7gU7pa16M4xiyd4vGtiytI6d390UxmvVqpbpPMRQrlvlHUz0UP8G+os
         BCn59Q5YiDmTmmJUy0RRvJWMcQj9ENlFM5DJahpwI6dWPxbZ+gKMN2FgHQp01b4uHr3X
         lFwKQ9aBY+LCEihdfxwmsiC3o0xRn0WlcEgSOkC/XCwR++CHeME1MRbLGMifhwVfZyIB
         tPT7vERlOK82OnoEPIKs4H43XD7k1KcIH3XBSeclCTmaUAtnRIWZOuQZa38li4tMj2w8
         6Bo77DH/eulrOOkNA8Ofw8gHuPCuFOz8b7Ec6YZY4DlGcMOxX5v94wRhWa9RsG80Xgrr
         dImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7y+B0NsHK08ns87YYWWmTZg44ekWnBl+gyEZRdNH7dk=;
        b=maXhu0awdH4aFKs2OxijuF+/nqh6Fj2RmaM63/GgIMxuTJhV2M7ml6kVQExvUEruSx
         xrJdjK9HcHiuJnGC1rx+cMtOow58pE3kbFGg+sGcjmK2PKVCY/nD+7MFvG/NV4dp3TNF
         GVU1C73vez+Oo7QzrlX0j6APPT/XoiRWB3p3ATivnEfnxh/sgdlx/SW3PVLlX6akpVpP
         DXW3vhHkse5GkOD/xhulGJVYMvQx83a8HhV7CeW/MPxmAaEyQasPfh+ltY21raEMkZu4
         2xo8Ojg4D8ZtjyNW1bitwclmnf/ObCiqD5WDGronF50mjqSW2+DjB0vRn8A5Aur+7x12
         5Zjw==
X-Gm-Message-State: APjAAAVa9yG8/NQWzrursvz4hC+8bU10dBmdZX/LRA5DQMeOx7pTis7c
        SSKjRvUVfDqHehKW1XDBj2ANM8mDkSTZmNRyuUs=
X-Google-Smtp-Source: APXvYqxr49mqHWNHmDv+kvjF41anGCxPRTZve8h+rl+VxZ+94QVxFkj3HV+j0emyuMOH5LeC2mJrrnrQpEI4SlZ0SLc=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr45325987wrx.196.1564391036430;
 Mon, 29 Jul 2019 02:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190728141218.12702-1-daniel.baluta@nxp.com> <20190729083130.GA3904@bogon.m.sigxcpu.org>
In-Reply-To: <20190729083130.GA3904@bogon.m.sigxcpu.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 12:03:45 +0300
Message-ID: <CAEnQRZDwAQZ7E=ayJeZCvXJ8fyayCmpAqe9=oLm4gxw8zoN0oQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Init rates and parents configs for clocks
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>, baruch@tkos.co.il,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:32 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote=
:
>
> Hi,
> On Sun, Jul 28, 2019 at 05:12:18PM +0300, Daniel Baluta wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> >
> > Add the initial configuration for clocks that need default parent and r=
ate
> > setting. This is based on the vendor tree clock provider parents and ra=
tes
> > configuration except this is doing the setup in dts rather then using c=
lock
> > consumer API in a clock provider driver.
> >
> > Note that by adding the initial rate setting for audio_pll1/audio_pll
> > setting we need to remove it from imx8mq-librem5-devkit.dts
> > imx8mq-librem5-devkit.dts
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> > Changes since v2:
> >       - set rate for audio_pll1/audio_pll2  in the dtsi file and
> >       remove the setting from imx8mq-librem5-devkit.dts
> >
> >  .../dts/freescale/imx8mq-librem5-devkit.dts   |  5 -----
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 21 +++++++++++++++++++
> >  2 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/=
arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > index 683a11035643..c702ccc82867 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > @@ -169,11 +169,6 @@
> >       };
> >  };
> >
> > -&clk {
> > -     assigned-clocks =3D <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_=
PLL2>;
> > -     assigned-clock-rates =3D <786432000>, <722534400>;
> > -};
> > -
> >  &dphy {
> >       status =3D "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mq.dtsi
> > index 02fbd0625318..c67625a881a4 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -494,6 +494,27 @@
> >                               clock-names =3D "ckil", "osc_25m", "osc_2=
7m",
> >                                             "clk_ext1", "clk_ext2",
> >                                             "clk_ext3", "clk_ext4";
> > +                             assigned-clocks =3D <&clk IMX8MQ_VIDEO_PL=
L1>,
> > +                                     <&clk IMX8MQ_AUDIO_PLL1>,
> > +                                     <&clk IMX8MQ_AUDIO_PLL2>,
> > +                                     <&clk IMX8MQ_CLK_AHB>,
> > +                                     <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
> > +                                     <&clk IMX8MQ_CLK_AUDIO_AHB>,
> > +                                     <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> > +                                     <&clk IMX8MQ_CLK_NOC>;
> > +                             assigned-clock-parents =3D <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_133=
M>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_266=
M>,
> > +                                             <&clk IMX8MQ_SYS2_PLL_500=
M>,
> > +                                             <&clk IMX8MQ_CLK_27M>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_800=
M>;
> > +                             assigned-clock-rates =3D <593999999>,
> > +                                             <786432000>,
> > +                                             <722534400>;
> > +
> > +
> >                       };
> >
> >                       src: reset-controller@30390000 {
>
> togethe with http://code.bulix.org/pd88jp-812381?raw tested on
> linux-20190725 (plus mipi dsi):
>
> Tested-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Thanks for testing this Guido. Can you please add your Tested-by
to my fourth version of the patch.

[PATCH v4] arm64: dts: imx8mq: Init rates and parents configs for clocks
