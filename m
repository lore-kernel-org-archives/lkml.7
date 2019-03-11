Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1572075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCKJn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:43:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33145 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726723AbfCKJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:43:26 -0400
X-UUID: 366357bf2c854dc7b4a187ec5dd157fe-20190311
X-UUID: 366357bf2c854dc7b4a187ec5dd157fe-20190311
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1595569405; Mon, 11 Mar 2019 17:43:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Mar
 2019 17:43:17 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 17:43:16 +0800
Message-ID: <1552297396.12703.2.camel@mhfsdcap03>
Subject: Re: [PATCH v6 6/6] dts: arm64: mt8183: Add I2C nodes
From:   Qii Wang <qii.wang@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        <xinping.qian@mediatek.com>, <liguo.zhang@mediatek.com>,
        Rob Herring <robh@kernel.org>
Date:   Mon, 11 Mar 2019 17:43:16 +0800
In-Reply-To: <CANMq1KDqKy=F0+Ld+k1-E9Y9qxfYMDORJPHvqEpCBGi5G7+zgw@mail.gmail.com>
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
         <1552282840-12778-7-git-send-email-qii.wang@mediatek.com>
         <CANMq1KDqKy=F0+Ld+k1-E9Y9qxfYMDORJPHvqEpCBGi5G7+zgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 16:36 +0800, Nicolas Boichat wrote:
> On Mon, Mar 11, 2019 at 1:41 PM Qii Wang <qii.wang@mediatek.com> wrote:
> >
> > This patch adds nodes for I2C controller.
> >
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > ---
> 
> This applies on top of some other uncommitted series, right? This is
> fine, but please say which one.
> 

https://patchwork.kernel.org/cover/10846715/
This series are based on 5.0-rc1(i2c/for-next) and these series
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017570.html
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017320.html

> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi |  190 ++++++++++++++++++++++++++++++
> >  1 file changed, 190 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 165b859..f20f1af 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -16,6 +16,21 @@
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> >
> > +       aliases {
> > +               i2c0 = &i2c0;
> > +               i2c1 = &i2c1;
> > +               i2c2 = &i2c2;
> > +               i2c3 = &i2c3;
> > +               i2c4 = &i2c4;
> > +               i2c5 = &i2c5;
> > +               i2c6 = &i2c6;
> > +               i2c7 = &i2c7;
> > +               i2c8 = &i2c8;
> > +               i2c9 = &i2c9;
> > +               i2c10 = &i2c10;
> > +               i2c11 = &i2c11;
> > +       };
> > +
> >         cpus {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > @@ -268,6 +283,79 @@
> >                         status = "disabled";
> >                 };
> >
> > +               i2c6: i2c@11005000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11005000 0 0x1000>,
> > +                               <0 0x11000600 0 0x80>;
> > +                       interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C6>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c0: i2c@11007000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11007000 0 0x1000>,
> > +                               <0 0x11000080 0 0x80>;
> > +                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C0>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c4: i2c@11008000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       id = <4>;
> > +                       reg = <0 0x11008000 0 0x1000>,
> > +                               <0 0x11000100 0 0x80>;
> > +                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C1>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C1_ARBITER>;
> > +                       clock-names = "main", "dma","arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c2: i2c@11009000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11009000 0 0x1000>,
> > +                               <0 0x11000280 0 0x80>;
> > +                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C2>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C2_ARBITER>;
> > +                       clock-names = "main", "dma", "arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c3: i2c@1100f000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x1100f000 0 0x1000>,
> > +                               <0 0x11000400 0 0x80>;
> > +                       interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C3>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 spi0: spi@1100a000 {
> >                         compatible = "mediatek,mt8183-spi";
> >                         #address-cells = <1>;
> > @@ -294,6 +382,20 @@
> >                         status = "disabled";
> >                 };
> >
> > +               i2c1: i2c@11011000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11011000 0 0x1000>,
> > +                               <0 0x11000480 0 0x80>;
> > +                       interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C4>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 spi2: spi@11012000 {
> >                         compatible = "mediatek,mt8183-spi";
> >                         #address-cells = <1>;
> > @@ -320,6 +422,66 @@
> >                         status = "disabled";
> >                 };
> >
> > +               i2c9: i2c@11014000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11014000 0 0x1000>,
> > +                               <0 0x11000180 0 0x80>;
> > +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C1_IMM>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C1_ARBITER>;
> > +                       clock-names = "main", "dma", "arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c10: i2c@11015000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11015000 0 0x1000>,
> > +                               <0 0x11000300 0 0x80>;
> > +                       interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C2_IMM>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C2_ARBITER>;
> > +                       clock-names = "main", "dma", "arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c5: i2c@11016000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11016000 0 0x1000>,
> > +                               <0 0x11000500 0 0x80>;
> > +                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C5>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C5_ARBITER>;
> > +                       clock-names = "main", "dma", "arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c11: i2c@11017000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x11017000 0 0x1000>,
> > +                               <0 0x11000580 0 0x80>;
> > +                       interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C5_IMM>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>,
> > +                                <&infracfg CLK_INFRA_I2C5_ARBITER>;
> > +                       clock-names = "main", "dma", "arb";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 spi4: spi@11018000 {
> >                         compatible = "mediatek,mt8183-spi";
> >                         #address-cells = <1>;
> > @@ -346,6 +508,34 @@
> >                         status = "disabled";
> >                 };
> >
> > +               i2c7: i2c@1101a000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x1101a000 0 0x1000>,
> > +                               <0 0x11000680 0 0x80>;
> > +                       interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C7>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               i2c8: i2c@1101b000 {
> > +                       compatible = "mediatek,mt8183-i2c";
> > +                       reg = <0 0x1101b000 0 0x1000>,
> > +                               <0 0x11000700 0 0x80>;
> > +                       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_I2C8>,
> > +                                <&infracfg CLK_INFRA_AP_DMA>;
> > +                       clock-names = "main", "dma";
> > +                       clock-div = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       status = "disabled";
> > +               };
> > +
> >                 audiosys: syscon@11220000 {
> >                         compatible = "mediatek,mt8183-audiosys", "syscon";
> >                         reg = <0 0x11220000 0 0x1000>;
> > --
> > 1.7.9.5
> >


