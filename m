Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfHVAqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:46:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12180 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729081AbfHVAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:46:11 -0400
X-UUID: 3903fa845faf47d685a9fa1ac8adcc0d-20190822
X-UUID: 3903fa845faf47d685a9fa1ac8adcc0d-20190822
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 658753542; Thu, 22 Aug 2019 08:46:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 08:46:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 08:46:00 +0800
Message-ID: <1566434764.14794.2.camel@mtkswgap22>
Subject: Re: [PATCH v2 11/11] arm64: dts: add dts nodes for MT6779
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, CC Hwang <cc.hwang@mediatek.com>,
        <wsd_upstream@mediatek.com>, Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>, <linux-clk@vger.kernel.org>
Date:   Thu, 22 Aug 2019 08:46:04 +0800
In-Reply-To: <c533371d-efcd-59dc-0172-3f5775221302@kernel.org>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
         <1566206502-4347-12-git-send-email-mars.cheng@mediatek.com>
         <adec38bf-735b-9131-2b9d-1e427d47f88d@kernel.org>
         <1566214950.17081.3.camel@mtkswgap22>
         <c533371d-efcd-59dc-0172-3f5775221302@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

> >>> +	soc {
> >>> +		#address-cells = <2>;
> >>> +		#size-cells = <2>;
> >>> +		compatible = "simple-bus";
> >>> +		ranges;
> >>> +
> >>> +		gic: interrupt-controller@0c000000 {
> >>> +			compatible = "arm,gic-v3";
> >>> +			#interrupt-cells = <3>;
> >>
> >> You also haven't described the CPU PMUs. Depending on how they are wired
> >> (SPIs or PPIs), you may have to change the interrupt-cells property to
> >> include a cell for the PPI partitioning.
> >>
> > 
> > pmu nodes would be:
> > 
> >         pmu {
> >                 compatible = "arm,armv8-pmuv3";
> >                 interrupt-parent = <&gic>;
> >                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >         };
> > 
> >         dsu-pmu-0 {
> >                 compatible = "arm,dsu-pmu";
> >                 interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> >                 cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
> >                         <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> >         };
> > 
> > so I think interrupt-cells could be <3>, will add pmu nodes in v3.
> 
> No, that's wrong, at least for the CPU pmu node.
> 
> First, you need two of them (one for the A55s, one for the A75s).
> Then you need to partition the corresponding PPI so that they can be
> described as separate affinity sets.
> Finally, this implies that #interrupt-cells goes up to 4, and all the
> interrupts directly routed to the GIC must be updated.
> 
> You should have something like this:
> 
> 	&gic {
> 		ppi-partitions {
> 			cluster0: interrupt-partition-0 {
> 				affinity = <&cpu0 &cpu1 &cpu2
>                                             &cpu3 &cpu4 &cpu5>;
> 			};
> 
> 			cluster1: interrupt-partition-1 {
> 				affinity = <&cpu6 &cpu7>;
> 			};
> 	};
> 
> 	pmu_a55 {
> 		compatible = "arm,cortex-a55-pmu", "arm,armv8-pmuv3";
> 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &cluster0>;
> 	};
> 
> 	pmu_a75 {
> 		compatible = "arm,cortex-a75-pmu", "arm,armv8-pmuv3";
> 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &cluster1>;
> 	};
> 
> Please see the rk3399 usage of the binding, as it is the canonical example.
> 
> > 

Got the idea. Will check rk3399 and fix our part. Thanks for reviewing.

