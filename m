Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23076C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520020825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXg0BCP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfIEJtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:49:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43288 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfIEJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:49:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id l22so1999244qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLTsSGkAS20nKvSmDJ8nD9cteiUsmNrKqKIdwSgw/JU=;
        b=aXg0BCP9Sek1lvZeMuLX3m0T7YqT3J7+y48L+cuVdvR8ljEDdiPEof2dLMZGMrNQqf
         frfpxxqdq4i1ZSuneYWogqaVVwUXhpWbAAr50DK5fwnz7E0gTyF774wGR5nyj0EYsHkU
         O58lSwPmNLnkiy7PLIyxy6NJBfLmKRlhrMQ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLTsSGkAS20nKvSmDJ8nD9cteiUsmNrKqKIdwSgw/JU=;
        b=FMlhDNsKSecJYbF9N5WJ2jskV2sAxx9EO7VSFNeZRBiNF+hMGsS92zizCEPtlBPCun
         0sPDqhLiM6oizKOs2gHelvhD3Iuo4wEx782aio+S93/ZLMewxRXo16NuDaayuzTuYQeM
         v+j+c0rljrpfNXFsDBfNrUROPGrc/dubaGFdW8qz42QMjUKDlshhm7kyCSHILqNOh7ct
         5Ondm4r4hmuN1L2GLrgwKvACOojidkgACWXvcMZGSn4rJRdu6x6V79hcHNf4HhzU9NYv
         oSj98mBTJvAyBWD2cOB1geTDU3PaIDtXWO4D2EWLOzDYX25KtwA/mhWtN3cTz1Emr6d9
         lSmw==
X-Gm-Message-State: APjAAAURcBpFVQODU3mtnlEaKDJX8gRkdiXOnze+w+7WYtQSy159Oljn
        LBklAHSKiUzxF9t9Fo7t+KygA2N0pMZ2kmHK9n8GzA==
X-Google-Smtp-Source: APXvYqyXj8KKk6gL7JNHTjmBpk7/3LqhzsyiSDFP08Dv/c/7DWQvOJacLN7yrqb3hzTQyDsYjO9u9/Zn/1y3KylZCaY=
X-Received: by 2002:a0c:efcc:: with SMTP id a12mr1032204qvt.59.1567676970643;
 Thu, 05 Sep 2019 02:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190905081546.42716-1-drinkcat@chromium.org> <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
In-Reply-To: <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 5 Sep 2019 17:49:19 +0800
Message-ID: <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add node for the Mali GPU
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Fan <nick.fan@mediatek.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick review!

On Thu, Sep 5, 2019 at 5:09 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 5, 2019 at 9:16 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > Add a basic GPU node and opp table for mt8183.
> >
> > The binding we use with out-of-tree Mali drivers includes more
> > clocks, I assume this would be required eventually if we have an
> > in-tree driver:
>
> We have an in-tree driver...

Right but AFAICT it does not support Bifrost GPU (yet?).

>
> > clocks =
> >         <&topckgen CLK_TOP_MFGPLL_CK>,
> >         <&topckgen CLK_TOP_MUX_MFG>,
> >         <&clk26m>,
> >         <&mfgcfg CLK_MFG_BG3D>;
> > clock-names =
> >         "clk_main_parent",
> >         "clk_mux",
> >         "clk_sub_parent",
> >         "subsys_mfg_cg";

Do you think we should add those to the binding document? May not be
easy to match what the amlogic binding does (I'm not sure to
understand the details of this device, but I can dig further/ask).

> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > ---
> > Upstreaming what matches existing bindings from our Chromium OS tree:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/arch/arm64/boot/dts/mediatek/mt8183.dtsi#1348
> >
> > The evb part of this change depends on this patch to add PMIC dtsi:
> > https://patchwork.kernel.org/patch/10928161/
> >
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |   7 ++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 103 ++++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index 1fb195c683c3d01..200d8e65a6368a1 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -7,6 +7,7 @@
> >
> >  /dts-v1/;
> >  #include "mt8183.dtsi"
> > +#include "mt6358.dtsi"
> >
> >  / {
> >         model = "MediaTek MT8183 evaluation board";
> > @@ -30,6 +31,12 @@
> >         status = "okay";
> >  };
> >
> > +&gpu {
> > +       supply-names = "mali", "mali_sram";
> > +       mali-supply = <&mt6358_vgpu_reg>;
> > +       mali_sram-supply = <&mt6358_vsram_gpu_reg>;
>
> Not documented. Just 'sram-supply' is enough.

Will fix.

> Note that the binding doc queued up for 5.4 has been converted to DT schema.

Yep I see that in linux-next.

>
> > +};
> > +
> >  &i2c0 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&i2c_pins_0>;
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 97f84aa9fc6e1c1..8ea548a762ea252 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -579,6 +579,109 @@
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               gpu: mali@13040000 {
>
> gpu@...
>
> > +                       compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
>
> You need to add this compatible string too.

Will do.

>
> > +                       reg = <0 0x13040000 0 0x4000>;
> > +                       interrupts =
> > +                               <GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
> > +                               <GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
> > +                               <GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
> > +                       interrupt-names = "job", "mmu", "gpu";
> > +
> > +                       clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> > +                       power-domains =
> > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>,
> > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>,
> > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
>
> This needs to be documented too.

I see that Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
has power-domains in the example both not in the yaml, is that
expected?


>
> > +
> > +                       operating-points-v2 = <&gpu_opp_table>;
> > +               };
> > +
> > +               gpu_opp_table: opp_table0 {
> > +                       compatible = "operating-points-v2";
> > +                       opp-shared;
> > +
> > +                       opp-300000000 {
> > +                               opp-hz = /bits/ 64 <300000000>;
> > +                               opp-microvolt = <625000>, <850000>;
> > +                       };
> > +
> > +                       opp-320000000 {
> > +                               opp-hz = /bits/ 64 <320000000>;
> > +                               opp-microvolt = <631250>, <850000>;
> > +                       };
> > +
> > +                       opp-340000000 {
> > +                               opp-hz = /bits/ 64 <340000000>;
> > +                               opp-microvolt = <637500>, <850000>;
> > +                       };
> > +
> > +                       opp-360000000 {
> > +                               opp-hz = /bits/ 64 <360000000>;
> > +                               opp-microvolt = <643750>, <850000>;
> > +                       };
> > +
> > +                       opp-380000000 {
> > +                               opp-hz = /bits/ 64 <380000000>;
> > +                               opp-microvolt = <650000>, <850000>;
> > +                       };
> > +
> > +                       opp-400000000 {
> > +                               opp-hz = /bits/ 64 <400000000>;
> > +                               opp-microvolt = <656250>, <850000>;
> > +                       };
> > +
> > +                       opp-420000000 {
> > +                               opp-hz = /bits/ 64 <420000000>;
> > +                               opp-microvolt = <662500>, <850000>;
> > +                       };
> > +
> > +                       opp-460000000 {
> > +                               opp-hz = /bits/ 64 <460000000>;
> > +                               opp-microvolt = <675000>, <850000>;
> > +                       };
> > +
> > +                       opp-500000000 {
> > +                               opp-hz = /bits/ 64 <500000000>;
> > +                               opp-microvolt = <687500>, <850000>;
> > +                       };
> > +
> > +                       opp-540000000 {
> > +                               opp-hz = /bits/ 64 <540000000>;
> > +                               opp-microvolt = <700000>, <850000>;
> > +                       };
> > +
> > +                       opp-580000000 {
> > +                               opp-hz = /bits/ 64 <580000000>;
> > +                               opp-microvolt = <712500>, <850000>;
> > +                       };
> > +
> > +                       opp-620000000 {
> > +                               opp-hz = /bits/ 64 <620000000>;
> > +                               opp-microvolt = <725000>, <850000>;
> > +                       };
> > +
> > +                       opp-653000000 {
> > +                               opp-hz = /bits/ 64 <653000000>;
> > +                               opp-microvolt = <743750>, <850000>;
> > +                       };
> > +
> > +                       opp-698000000 {
> > +                               opp-hz = /bits/ 64 <698000000>;
> > +                               opp-microvolt = <768750>, <868750>;
> > +                       };
> > +
> > +                       opp-743000000 {
> > +                               opp-hz = /bits/ 64 <743000000>;
> > +                               opp-microvolt = <793750>, <893750>;
> > +                       };
> > +
> > +                       opp-800000000 {
> > +                               opp-hz = /bits/ 64 <800000000>;
> > +                               opp-microvolt = <825000>, <925000>;
> > +                       };
>
> Okay, but I seriously doubt the OPP selection logic is sophisticated
> enough or will ever be to use all these levels...
>
> > +               };
> > +
> >                 mmsys: syscon@14000000 {
> >                         compatible = "mediatek,mt8183-mmsys", "syscon";
> >                         reg = <0 0x14000000 0 0x1000>;
> > --
> > 2.23.0.187.g17f5b7556c-goog
> >
