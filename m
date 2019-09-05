Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61102C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F06D22CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567679564;
	bh=NQujPZaifvocqXBm599tGClyU1aW6kjLF6eo/z6uOaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nH4N35fQbWjsaPd4arU4NjKQCb5SgVhdW88bF2gpMPHuYRGJUnfPdEQmVSxmdF/xn
	 YdlnEPyI3lejehidy+YnvAEE3gajvd8FbpYcg8B8kz7QYYe2X4cwIQOcL+ajdOc232
	 rXI+BkYXkBmzxyrEz4forEoIAWuIaYqOD7gpc85g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbfIEKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbfIEKcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:32:43 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB1222DD3;
        Thu,  5 Sep 2019 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567679561;
        bh=NQujPZaifvocqXBm599tGClyU1aW6kjLF6eo/z6uOaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9Tn7qVrlMY1fcBtiJ06AOYQViFIU1snLQymJvqz/C/R0E6lNN6BZiflc+uA6jcGD
         hWPgq0KYVqZW0NCdqUKPil1w9T0z0Nnoe5mlNDf3Helte4q3i+3+6iL52doqp04O5/
         7pu6mXzqcaTvDHa+ohcsMqBCseKADvQF0n7/vB+0=
Received: by mail-qt1-f171.google.com with SMTP id g4so2151306qtq.7;
        Thu, 05 Sep 2019 03:32:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXBa8QsPXluYGgNN16NPmExea60ik1hgjJa9FI2J60TmnkyZbqL
        gtN0CJWixi0WR8RXo8B7gAic7RB5iDktebcIhQ==
X-Google-Smtp-Source: APXvYqz7/ulBAvR7x3VrV/jxmMu9as/2Hzs9+dy1OH+geYhotKlOQxVVZj0kapvCvcSo3AeWsbYX9GZHNBzrJ0ONyGQ=
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr470851qvn.200.1567679560330;
 Thu, 05 Sep 2019 03:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190905081546.42716-1-drinkcat@chromium.org> <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
 <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
In-Reply-To: <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Sep 2019 11:32:29 +0100
X-Gmail-Original-Message-ID: <CAL_JsqLAEe1qYkTWCw7VPau9WnXTMUqtHR5XWGuk7ynZBiuLQA@mail.gmail.com>
Message-ID: <CAL_JsqLAEe1qYkTWCw7VPau9WnXTMUqtHR5XWGuk7ynZBiuLQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add node for the Mali GPU
To:     Nicolas Boichat <drinkcat@chromium.org>
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

On Thu, Sep 5, 2019 at 10:49 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Thanks for the quick review!
>
> On Thu, Sep 5, 2019 at 5:09 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 5, 2019 at 9:16 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > Add a basic GPU node and opp table for mt8183.
> > >
> > > The binding we use with out-of-tree Mali drivers includes more
> > > clocks, I assume this would be required eventually if we have an
> > > in-tree driver:
> >
> > We have an in-tree driver...
>
> Right but AFAICT it does not support Bifrost GPU (yet?).

It's mostly the mesa userspace side that's missing. The kernel driver
needs the compatible string and page table support[1]. The former
should be enough to access the registers which is typically enough to
sort out an platform specific clock, reset, power issues.

> > > clocks =
> > >         <&topckgen CLK_TOP_MFGPLL_CK>,
> > >         <&topckgen CLK_TOP_MUX_MFG>,
> > >         <&clk26m>,
> > >         <&mfgcfg CLK_MFG_BG3D>;
> > > clock-names =
> > >         "clk_main_parent",
> > >         "clk_mux",
> > >         "clk_sub_parent",
> > >         "subsys_mfg_cg";
>
> Do you think we should add those to the binding document? May not be
> easy to match what the amlogic binding does (I'm not sure to
> understand the details of this device, but I can dig further/ask).

I somewhat expect this needs more investigation. I'm doubtful that
there's a 26MHz clock going to Mali. Ideally, the clocks are what are
actually connected to the h/w, not just a list of all the clocks
needed on some platform because we fail to manage them elsewhere (like
an interconnect driver). Otherwise we end up with a different list for
every platform.

> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > ---
> > > Upstreaming what matches existing bindings from our Chromium OS tree:
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/arch/arm64/boot/dts/mediatek/mt8183.dtsi#1348
> > >
> > > The evb part of this change depends on this patch to add PMIC dtsi:
> > > https://patchwork.kernel.org/patch/10928161/
> > >
> > >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |   7 ++
> > >  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 103 ++++++++++++++++++++
> > >  2 files changed, 110 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > > index 1fb195c683c3d01..200d8e65a6368a1 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > > @@ -7,6 +7,7 @@
> > >
> > >  /dts-v1/;
> > >  #include "mt8183.dtsi"
> > > +#include "mt6358.dtsi"
> > >
> > >  / {
> > >         model = "MediaTek MT8183 evaluation board";
> > > @@ -30,6 +31,12 @@
> > >         status = "okay";
> > >  };
> > >
> > > +&gpu {
> > > +       supply-names = "mali", "mali_sram";
> > > +       mali-supply = <&mt6358_vgpu_reg>;
> > > +       mali_sram-supply = <&mt6358_vsram_gpu_reg>;
> >
> > Not documented. Just 'sram-supply' is enough.
>
> Will fix.
>
> > Note that the binding doc queued up for 5.4 has been converted to DT schema.
>
> Yep I see that in linux-next.
>
> >
> > > +};
> > > +
> > >  &i2c0 {
> > >         pinctrl-names = "default";
> > >         pinctrl-0 = <&i2c_pins_0>;
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > index 97f84aa9fc6e1c1..8ea548a762ea252 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > > @@ -579,6 +579,109 @@
> > >                         #clock-cells = <1>;
> > >                 };
> > >
> > > +               gpu: mali@13040000 {
> >
> > gpu@...
> >
> > > +                       compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
> >
> > You need to add this compatible string too.
>
> Will do.
>
> >
> > > +                       reg = <0 0x13040000 0 0x4000>;
> > > +                       interrupts =
> > > +                               <GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
> > > +                               <GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
> > > +                               <GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
> > > +                       interrupt-names = "job", "mmu", "gpu";
> > > +
> > > +                       clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> > > +                       power-domains =
> > > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>,
> > > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>,
> > > +                               <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> >
> > This needs to be documented too.
>
> I see that Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> has power-domains in the example both not in the yaml, is that
> expected?

Err, no. Probably some copy-n-paste from utgard.

Rob

[1] https://patchwork.freedesktop.org/patch/304731/
