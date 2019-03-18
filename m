Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCRInF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:43:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1761 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726704AbfCRInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:43:00 -0400
X-UUID: 54f89a9753cc4d9eaf2598e2aa7df394-20190318
X-UUID: 54f89a9753cc4d9eaf2598e2aa7df394-20190318
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 120850136; Mon, 18 Mar 2019 16:42:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Mar 2019 16:42:35 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 18 Mar 2019 16:42:35 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>
Subject: [PATCH v9] Add basic and clock support for Mediatek MT8183 SoC
Date:   Mon, 18 Mar 2019 16:42:31 +0800
Message-ID: <1552898552-13045-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0668F928F97FCA96D4F29756B84F46943B93C36C95FBA686C3B80493995455E62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board and use correct clock to shell.

Based on v5.1-rc1 and
http://lists.infradead.org/pipermail/linux-mediatek/2019-March/017963.html

Change in v9:
Remove pio node since binding is not documented yet

Change in v8:
1. Fix interrupt-parent of pio node
2. Remove pinfunc.h and spi node patches

Change in v7:
1. Place all the MMIO peripherals under one or more simple-bus nodes
2. Make the pinfunc.h and spi node into seperate patch
3. Modify SPIs pamerater from 4 back to 3
   and remove patch "support 4 interrupt parameters for sysirq"
4. Rename intpol-controller to interrupt-controller
5. Rename pinctrl@1000b000 to pinctrl@10005000

Change in v6:
1. Remove power and iommu nodes
2. Fix dtb build warning
3. Fix pinctrl binding doc
4. Fix '_' in node names

Change in v5:
1. Collect all device tree nodes to the last patch
2. Add PMU
3. Add Signed-off-by
4. Remove clock driver code and binding doc
5. Add pinctrl, iommu, spi, and pwrap nodes

Change in v4:
1. Correct syntax error in dtsi
2. Add MT8183 clock support

Change in v3:
1. Fill out GICC, GICH, GICV regions
2. Update Copyright to 2018

Change in v2:
1. Split dt-bindings into different patches
2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 311 ++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1

