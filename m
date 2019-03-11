Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D223206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVNu1Lno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCKIgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:36:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36572 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfCKIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:36:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id c2so2196248qkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoDI8ROvQDkT2vCYknBNd8fdKJWrC6E/dSkQ0P/uU1U=;
        b=WVNu1LnoRj9631xw1pelArznfjO3oUpyv8sy7tGuEuF10mwDhjBVWnlMMtTOMz1Qrr
         A656xZga9mZUIHq+HkxLe7rD/J0iJU1gPdwjvvXM1ofz9slkq1T1OJD+Hcy0+aqx1pJr
         1Va5gTgS0h8jSHgPc+zX3UFPlWbKDyEmA4gkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoDI8ROvQDkT2vCYknBNd8fdKJWrC6E/dSkQ0P/uU1U=;
        b=Oc0I7V4+GbUsz5/aLCbfv/dSeKaHpfqPGNciwTnBrNgiy5KxoP1YwWWPfKuUZ4NzYO
         LmF3/4udlTaDNDTOz8MA5gw0C++zu2P5hpV5q9We6JNCn7VtUW7DkBqymua/sE/sXY2L
         WIZtApGbo1C23Td4RkJ4KNT5f8ZPc683l0TsYU5QlkhZZznm7uX+4puoWqPN+mZ7qSrv
         i3iUL8XsZ84lWUacV4GloVWJM+2sciNA39nH6Ts1lk+RkXYle6LckD6zOtBTG1qr24+m
         YKIeloK3pwM0X8GsFBFk412ozcQ4cTm4gPJRckREKM7GRGX0xHi6R3GCQfMzXA8nNV2Z
         1Ggg==
X-Gm-Message-State: APjAAAUcwNE67kzjtB3j4snagSqxad6+1y2v20zWF4IHQcSarjFZXTZu
        9jHZQnn7bcfSchPwKNBtASrTrs0/bxHeUcH6Gk4Sig==
X-Google-Smtp-Source: APXvYqwbche5xjlALNknSOAK3hzUFzqxsoAA3Ai2ZATXr8HNyaBqJMgBBV7q6rFemptgoV7oeh8ZdAJTt7CNMTXiyEM=
X-Received: by 2002:a05:620a:12e1:: with SMTP id f1mr5315548qkl.151.1552293393785;
 Mon, 11 Mar 2019 01:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com> <1552282840-12778-7-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1552282840-12778-7-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 11 Mar 2019 16:36:22 +0800
Message-ID: <CANMq1KDqKy=F0+Ld+k1-E9Y9qxfYMDORJPHvqEpCBGi5G7+zgw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] dts: arm64: mt8183: Add I2C nodes
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:41 PM Qii Wang <qii.wang@mediatek.com> wrote:
>
> This patch adds nodes for I2C controller.
>
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---

This applies on top of some other uncommitted series, right? This is
fine, but please say which one.

>  arch/arm64/boot/dts/mediatek/mt8183.dtsi |  190 ++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 165b859..f20f1af 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -16,6 +16,21 @@
>         #address-cells = <2>;
>         #size-cells = <2>;
>
> +       aliases {
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;
> +               i2c7 = &i2c7;
> +               i2c8 = &i2c8;
> +               i2c9 = &i2c9;
> +               i2c10 = &i2c10;
> +               i2c11 = &i2c11;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> @@ -268,6 +283,79 @@
>                         status = "disabled";
>                 };
>
> +               i2c6: i2c@11005000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11005000 0 0x1000>,
> +                               <0 0x11000600 0 0x80>;
> +                       interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C6>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c0: i2c@11007000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11007000 0 0x1000>,
> +                               <0 0x11000080 0 0x80>;
> +                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C0>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c4: i2c@11008000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       id = <4>;
> +                       reg = <0 0x11008000 0 0x1000>,
> +                               <0 0x11000100 0 0x80>;
> +                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C1>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C1_ARBITER>;
> +                       clock-names = "main", "dma","arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c2: i2c@11009000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11009000 0 0x1000>,
> +                               <0 0x11000280 0 0x80>;
> +                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C2>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C2_ARBITER>;
> +                       clock-names = "main", "dma", "arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c3: i2c@1100f000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x1100f000 0 0x1000>,
> +                               <0 0x11000400 0 0x80>;
> +                       interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C3>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 spi0: spi@1100a000 {
>                         compatible = "mediatek,mt8183-spi";
>                         #address-cells = <1>;
> @@ -294,6 +382,20 @@
>                         status = "disabled";
>                 };
>
> +               i2c1: i2c@11011000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11011000 0 0x1000>,
> +                               <0 0x11000480 0 0x80>;
> +                       interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C4>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 spi2: spi@11012000 {
>                         compatible = "mediatek,mt8183-spi";
>                         #address-cells = <1>;
> @@ -320,6 +422,66 @@
>                         status = "disabled";
>                 };
>
> +               i2c9: i2c@11014000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11014000 0 0x1000>,
> +                               <0 0x11000180 0 0x80>;
> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C1_IMM>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C1_ARBITER>;
> +                       clock-names = "main", "dma", "arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c10: i2c@11015000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11015000 0 0x1000>,
> +                               <0 0x11000300 0 0x80>;
> +                       interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C2_IMM>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C2_ARBITER>;
> +                       clock-names = "main", "dma", "arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c5: i2c@11016000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11016000 0 0x1000>,
> +                               <0 0x11000500 0 0x80>;
> +                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C5>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C5_ARBITER>;
> +                       clock-names = "main", "dma", "arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c11: i2c@11017000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x11017000 0 0x1000>,
> +                               <0 0x11000580 0 0x80>;
> +                       interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C5_IMM>,
> +                                <&infracfg CLK_INFRA_AP_DMA>,
> +                                <&infracfg CLK_INFRA_I2C5_ARBITER>;
> +                       clock-names = "main", "dma", "arb";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 spi4: spi@11018000 {
>                         compatible = "mediatek,mt8183-spi";
>                         #address-cells = <1>;
> @@ -346,6 +508,34 @@
>                         status = "disabled";
>                 };
>
> +               i2c7: i2c@1101a000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x1101a000 0 0x1000>,
> +                               <0 0x11000680 0 0x80>;
> +                       interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C7>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               i2c8: i2c@1101b000 {
> +                       compatible = "mediatek,mt8183-i2c";
> +                       reg = <0 0x1101b000 0 0x1000>,
> +                               <0 0x11000700 0 0x80>;
> +                       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_I2C8>,
> +                                <&infracfg CLK_INFRA_AP_DMA>;
> +                       clock-names = "main", "dma";
> +                       clock-div = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";
> +               };
> +
>                 audiosys: syscon@11220000 {
>                         compatible = "mediatek,mt8183-audiosys", "syscon";
>                         reg = <0 0x11220000 0 0x1000>;
> --
> 1.7.9.5
>
