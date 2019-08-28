Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D93C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622022DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfH1GVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:21:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5741 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbfH1GVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:21:31 -0400
X-UUID: a3bca1a9a3a14e44aed1070ed2e458f3-20190828
X-UUID: a3bca1a9a3a14e44aed1070ed2e458f3-20190828
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1507342948; Wed, 28 Aug 2019 14:21:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 14:21:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 14:21:27 +0800
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
Subject: [PATCH 0/6] add support USB for MT8183
Date:   Wed, 28 Aug 2019 14:20:55 +0800
Message-ID: <1566973261-21677-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7E5A70E4659ABA37BFB2D59CBB2721E4101DDEEA0A1E5A9D0208508D714115312000:8
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

Chunfeng Yun (6):
  dt-bindings: usb: mtu3: support USB wakeup for MT8183
  dt-bindings: usb: mtk-xhci: support USB wakeup for MT8183
  usb: mtu3: support ip-sleep wakeup for MT8183
  usb: mtk-xhci: support ip-sleep wakeup for MT8183
  arm64: dts: mt8183: add usb and phy nodes
  arm64: dts: mt8183: enable USB remote wakeup

 .../bindings/usb/mediatek,mtk-xhci.txt        |  1 +
 .../devicetree/bindings/usb/mediatek,mtu3.txt |  1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 23 +++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 63 +++++++++++++++++++
 drivers/usb/host/xhci-mtk.c                   | 14 ++++-
 drivers/usb/mtu3/mtu3_host.c                  | 14 ++++-
 6 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.23.0

