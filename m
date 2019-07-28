Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255CC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBD2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvJGjGNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG1PZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:25:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39993 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1PZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:25:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so51371413wmj.5;
        Sun, 28 Jul 2019 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OnbAgSPJwvUbw2tRezNGTvwhfaWECDe+MXcGqH5rpM=;
        b=tvJGjGNCiGu81qsWG9UW1f56ISoykEzQxe69HGgPuJWY1vWh2BToE4P1lQr7o5zhty
         Y2DXk41Rk9LE1SFSiWTRbXOLb3Ahyjyh3LwqbXk+RU9t0fS6e+lp4lMHC2jEoTiGo3q/
         8/iuL/uplQQPaE1s+4RoUDSg4F5g7RMbV+4g9nIA74D8p7dTNgg5YCEDhPJg8uDP4ndy
         gQ5Q36Ltmq/rQZfnqMOaz8qyOzAyc03cAux98RtGT56OwjoJ1Mo27sJ1WLyV5VggUoF1
         0+QxYug6KjR5HKu80bJZYdugQqf5bNZNv/vvWMNATeNBdgw7RYpPCeeiqtRoNGjFerIR
         QOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OnbAgSPJwvUbw2tRezNGTvwhfaWECDe+MXcGqH5rpM=;
        b=tKg/BHVWaeiLMU+Vryut8ytGUVcU3O8S4NEgsVT5RbxgEnuKWPkUxgdZULP8iVxk67
         DAST7XhS9qTHwuURvZdnUZ5PGyVKqDKbEBK1TNREXQb0eSSGOguXYjgWYcZypg1rDMEi
         d4gfMuTu468xyA8tj00MjION2jHwnN0XYA3mjoHKid9OrsxdsHAIBHP6qcq3vehAxfVv
         PgMTsCt5d9Q372jPhtdSnJONxHi9Q0bNubmv03Y40hTBnB/7yF53OLKv/YJAIJd8k7F9
         O3IvExCnJBeDy6FCWBvxeQnZCDAcrjlutRnLKDmZx40FcbbTRJ/o201MDHJgqYE7wdIr
         +QNw==
X-Gm-Message-State: APjAAAXITFsC0SFxUJL0t5vMylnos1VsQQOhT2Twsn0yesgx3JSmfODD
        FLyCnXqAfIxc4hlmqSITGNdDzoaMjPgv/oIbx6E=
X-Google-Smtp-Source: APXvYqwqMHY/y3WFu0ZR36r/YOmks/hkw86Ydao02mX6fAJoEhqh32A4SVNoT8E4xKHv5jx67NZn+rRHRT2VWzP/WGU=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr99117091wmj.13.1564327516506;
 Sun, 28 Jul 2019 08:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190728141218.12702-1-daniel.baluta@nxp.com> <b6506f6579f823e4c1e26ef3a7d1eed2@akkea.ca>
In-Reply-To: <b6506f6579f823e4c1e26ef3a7d1eed2@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 28 Jul 2019 18:25:05 +0300
Message-ID: <CAEnQRZCyyfoVeG90Qbt8nQaEJYS7ywsSRFAy7a7WR6JrKfq-yg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Init rates and parents configs for clocks
To:     Angus Ainslie <angus@akkea.ca>
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
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 5:53 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Daniel,
>
> On 2019-07-28 07:12, Daniel Baluta wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> >
> > Add the initial configuration for clocks that need default parent and
> > rate
> > setting. This is based on the vendor tree clock provider parents and
> > rates
> > configuration except this is doing the setup in dts rather then using
> > clock
> > consumer API in a clock provider driver.
> >
> > Note that by adding the initial rate setting for audio_pll1/audio_pll
> > setting we need to remove it from imx8mq-librem5-devkit.dts
> > imx8mq-librem5-devkit.dts
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> This works with our board. One small nit below
>
> Tested-by: Angus Ainslie (Purism) <angus@akkea.ca>
>
> > ---
> > Changes since v2:
> >       - set rate for audio_pll1/audio_pll2  in the dtsi file and
> >       remove the setting from imx8mq-librem5-devkit.dts
> >
> >  .../dts/freescale/imx8mq-librem5-devkit.dts   |  5 -----
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 21 +++++++++++++++++++
> >  2 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > index 683a11035643..c702ccc82867 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > @@ -169,11 +169,6 @@
> >       };
> >  };
> >
> > -&clk {
> > -     assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
> > -     assigned-clock-rates = <786432000>, <722534400>;
> > -};
> > -
> >  &dphy {
> >       status = "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 02fbd0625318..c67625a881a4 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -494,6 +494,27 @@
> >                               clock-names = "ckil", "osc_25m", "osc_27m",
> >                                             "clk_ext1", "clk_ext2",
> >                                             "clk_ext3", "clk_ext4";
> > +                             assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1>,
> > +                                     <&clk IMX8MQ_AUDIO_PLL1>,
> > +                                     <&clk IMX8MQ_AUDIO_PLL2>,
> > +                                     <&clk IMX8MQ_CLK_AHB>,
> > +                                     <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
> > +                                     <&clk IMX8MQ_CLK_AUDIO_AHB>,
> > +                                     <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> > +                                     <&clk IMX8MQ_CLK_NOC>;
> > +                             assigned-clock-parents = <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_133M>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_266M>,
> > +                                             <&clk IMX8MQ_SYS2_PLL_500M>,
> > +                                             <&clk IMX8MQ_CLK_27M>,
> > +                                             <&clk IMX8MQ_SYS1_PLL_800M>;
> > +                             assigned-clock-rates = <593999999>,
> > +                                             <786432000>,
> > +                                             <722534400>;
> > +
> > +
>
> Extra whitespace

Thanks Angus for testing. Fixed in v4.
