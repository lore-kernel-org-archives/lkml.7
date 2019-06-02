Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C15C28CC2
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 04:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC31827849
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 04:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5F5ZBWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfFBEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 00:35:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34703 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFBEfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 00:35:18 -0400
Received: by mail-it1-f194.google.com with SMTP id u124so1335577itc.1;
        Sat, 01 Jun 2019 21:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4CanWuqlNjLflmz2Qk/RlQLeFzHSfAI7esEAGrAgZw=;
        b=l5F5ZBWA+DIDLYP5up+gD3seEEamNpL0MIqvd2Dnmdzhee4Vu3Qq86qHO7VzvIibYj
         dfY4wHw1J+8/HcOLOBnYfdo6CXkMP02GgHcPT1j1imyhoYpcU3tsvT3Wige8AkhKKba+
         uoq40Z505t+MEPTpTDwGFM2wi/CDY0dul+QJC3PwCbYoKSNUwjiZh7UuzC6iDpWhI3oo
         119NU4yjBTiceJGveft99++sSNK9OGlX6Dt3WIeDa2pgKdMzib/4hYDg5nnJ1mC5PkMP
         /7fDWrV/2FI5awIClRiZelc98NLmR1Pdxc0NrlnCBpMbi15KMXw4BiZyHSvjiIJCZied
         fFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4CanWuqlNjLflmz2Qk/RlQLeFzHSfAI7esEAGrAgZw=;
        b=iJl6FVoE8dWrFnnYNeiweNXdxvqJqrkghuqnYeN6Taja9T8KK9CFVLPE6QliQ36Jub
         hFsqmGAQDEMeZZzs7YPWgQF/jFtUOeNuZ2EDV6ruPW1QJy7wlO78S31CN/5VNjjNWUZM
         RxdTVvBxp+FyruT0zhLzJRfya92OpFuKP5PISrh1oZdX5ZCFkeK7csWNvdeUVYq7mXn7
         Lxe3E3T0tZzGPpDlrrAoWp6i9HXPcqs3e9nR7lMkjtizFkCof6FkWynKVSAdT8Dxpg/1
         aCYuWiOwTKA+/sjFN19y0l2+UkN/UwQvytVOZ9x0HhdPCGfvZvftJMDiZKyx3k4aRYHK
         VdJg==
X-Gm-Message-State: APjAAAVCjN0+8fSN0n+5HWq3TYpws7X/jqN0PeJ6asO1tjFQpjLkwH/A
        dY0+mSfDYc130zyo6oAoaXyp2N+Q4rFQXuRUtIg=
X-Google-Smtp-Source: APXvYqwXbkiXIYjDHXmh3/thigHgwkv16g5iRA7ZvyyvH5clOqzbumpceyiCVbQ5RGunSbjGlHDuLiCOYNTYxPCyj8E=
X-Received: by 2002:a24:ed7:: with SMTP id 206mr9474956ite.97.1559450117296;
 Sat, 01 Jun 2019 21:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190531201913.1122-1-linux.amoon@gmail.com> <20190601095106.GA2213@Mani-XPS-13-9360>
In-Reply-To: <20190601095106.GA2213@Mani-XPS-13-9360>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 2 Jun 2019 10:05:06 +0530
Message-ID: <CANAwSgQXrp5+UOdBEjq9PvBHw9KmgxpkVsENc05MoBMDBOoczg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing configuration pwr
 amd rst for PCIe
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

Thanks for your review comment.

On Sat, 1 Jun 2019 at 15:21, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> On Fri, May 31, 2019 at 08:19:13PM +0000, Anand Moon wrote:
> > This patch add missing PCIe gpio pin (#PCIE_PWR) for vcc3v3_pcie power
> > regulator node also add missing reset pinctrl (#PCIE_PERST_L) for PCIe node.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > using schematics: thanks for suggested by Manivannan
> > [1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf
> >
> > Changes from prevoius patch:
> > [2] https://patchwork.kernel.org/patch/10968695/
> >
> > Fix the suject and commit message and corrected the PWR and PERST configuration
> > as per shematics and dts nodes.
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts    | 7 +++++++
> >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts  | 7 +++++++
> >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 3 +--
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > index 6b059bd7a04f..94e2a59bc1c7 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > @@ -89,6 +89,8 @@
> >
> >  &pcie0 {
> >       ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
>
> Looks like ep-gpio is wrong here :/ I probably referred old schematics
> at that time. Correct pin mapping is,
>
> ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
>
> And this should be fixed in a separate patch with "Fixes" tag!
>

Ok I will changes per the above. I have also check this with the
u-boot changes .

> >  };
> >
> >  &pinctrl {
> > @@ -104,6 +106,11 @@
> >                       rockchip,pins =
> >                               <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> >                       };
> > +
> > +             pcie_perst_l: pcie-perst-l {
> > +                     rockchip,pins =
> > +                             <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> >       };
> >
> >       usb2 {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > index 12285c51cceb..665fe09c7c74 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > @@ -64,6 +64,8 @@
> >
> >  &pcie0 {
> >       ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
> >  };
> >
> >  &pinctrl {
> > @@ -104,6 +106,11 @@
> >                       rockchip,pins =
> >                               <2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> >                       };
> > +
> > +             pcie_perst_l: pcie-perst-l {
> > +                     rockchip,pins =
> > +                             <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> >       };
> >
> >       usb2 {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > index c7d48d41e184..3df0cd67b4b2 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > @@ -55,6 +55,7 @@
> >
> >       vcc3v3_pcie: vcc3v3-pcie-regulator {
> >               compatible = "regulator-fixed";
> > +             gpio = <&gpio2 RK_PA5 GPIO_ACTIVE_HIGH>;
>
> Actually the PWR pin mapping is defined in a separate node for both Rock960
> and Ficus in respective dts. So defining it here would be wrong as the PWR
> pin mapping is different for both boards.
>

Ok Thanks, so I will move the PWR pin nodes the respective dts files.

                  PCIE_PERST     PCIE_PWR
Rock960     GPIO2_A2          GPIO2_A5
Ficus          GPIO2_D4          GPIO1_D0   /* reference u-boot */

Pls confirm this is correct.

Best Regards
-Anand

> Thanks,
> Mani
