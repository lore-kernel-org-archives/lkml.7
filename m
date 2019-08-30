Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B72C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B46C23426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfH3HlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:41:05 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726975AbfH3HlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:41:05 -0400
X-UUID: a17a791afa36447bbe0f1f1599d73d84-20190830
X-UUID: a17a791afa36447bbe0f1f1599d73d84-20190830
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 105821875; Fri, 30 Aug 2019 15:41:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:41:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:41:01 +0800
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
Subject: [PATCH v3 0/7]  add support USB for MT8183
Date:   Fri, 30 Aug 2019 15:40:47 +0800
Message-ID: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E5F213E7CA528242F5F6039032059112C7EC7C2778DB20F4402EB0CD069E1B992000:8
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
  [v2,1/2] dt-bindings: clock: mediatek: add pericfg for MT8183
  https://patchwork.kernel.org/patch/11118183/

3. add property mediatek,discth for tphy
  [06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
  https://patchwork.kernel.org/patch/11110695/

v3 changes:
  1. changes micros define
  2. remove #reset-cell
  3. update dependent series

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
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 63 +++++++++++++++++++
 drivers/usb/host/xhci-mtk.c                   | 14 ++++-
 drivers/usb/mtu3/mtu3_host.c                  | 14 ++++-
 6 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.23.0

