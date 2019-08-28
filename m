Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8912F2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfH1Hfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:35:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:10305 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbfH1Hfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:35:52 -0400
X-UUID: 6f68ed90593742dab0c3c4620f95d36e-20190828
X-UUID: 6f68ed90593742dab0c3c4620f95d36e-20190828
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 757357155; Wed, 28 Aug 2019 15:34:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 15:34:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 15:34:40 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7]  add support USB for MT8183
Date:   Wed, 28 Aug 2019 15:34:24 +0800
Message-ID: <1566977671-22191-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 45C8A0C3D21D41A54704C36113615E527385CF6190ED1896979E2DBFA0EBD17D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support USB DRD controller and enable it's remote
wakeup functoin for MT8183, they depend on the following
series patches:

1. this series add support MT6358 PMIC
  [v5,01/10] mfd: mt6397: clean up code
  https://patchwork.kernel.org/patch/11110487/

2. this series add support pericfg syscon
  [1/2] dt-bindings: clock: mediatek: add pericfg for MT8183
  https://patchwork.kernel.org/patch/11117799/

3. add property mediatek,discth for tphy
  [06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
  https://patchwork.kernel.org/patch/11110695/

v2 changes:
  add patch [7/7]

Chunfeng Yun (7):
  dt-bindings: usb: mtu3: support USB wakeup for MT8183
  dt-bindings: usb: mtk-xhci: support USB wakeup for MT8183
  usb: mtu3: support ip-sleep wakeup for MT8183
  usb: mtk-xhci: support ip-sleep wakeup for MT8183
  arm64: dts: mt8183: add usb and phy nodes
  arm64: dts: mt8183: enable USB remote wakeup
  arm64: dts: mt8183: tune disconnect threshold of u2phy

 .../bindings/usb/mediatek,mtk-xhci.txt        |  1 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 23 +++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 64 +++++++++++++++++++
 drivers/usb/host/xhci-mtk.c                   | 14 +++-
 drivers/usb/mtu3/mtu3_host.c                  | 14 +++-
 6 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.23.0

