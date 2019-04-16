Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8D620821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDPIMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:12:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36772 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725840AbfDPIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:12:22 -0400
X-UUID: 87c546c982b341adb8fc2bf989b38a1e-20190416
X-UUID: 87c546c982b341adb8fc2bf989b38a1e-20190416
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 816406446; Tue, 16 Apr 2019 16:12:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:12:14 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:12:14 +0800
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
Subject: [PATCH v10] Add basic and clock support for Mediatek MT8183 SoC
Date:   Tue, 16 Apr 2019 16:12:10 +0800
Message-ID: <1555402331-5343-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 35F24435D2C66066E16C2512E8FB759B83A095EA45967CA7916527E2AC6E26E42000:8
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

Change in v10:
Add the L2 cache node to prevent warning on unable to detect cache
hierarchy.

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
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 329 ++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1

