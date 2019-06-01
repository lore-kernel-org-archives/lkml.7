Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E90C04AB6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDF827043
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFAAI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 20:08:27 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:33651 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfFAAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:08:26 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 20:08:26 EDT
X-UUID: a8890faa009e4b42a9d51a1661fd203d-20190531
X-UUID: a8890faa009e4b42a9d51a1661fd203d-20190531
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1633841494; Fri, 31 May 2019 16:03:20 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 May 2019 17:03:19 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Jun 2019 08:03:17 +0800
From:   <sean.wang@mediatek.com>
To:     <john@phrozen.org>, <davem@davemloft.net>
CC:     <nbd@openwrt.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next v1 0/6] Add MT7629 ethernet support
Date:   Sat, 1 Jun 2019 08:03:09 +0800
Message-ID: <1559347395-14058-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MT7629 inlcudes two sets of SGMIIs used for external switch or PHY, and embedded
switch (ESW) via GDM1, GePHY via GMAC2, so add several patches in the series to
make the code base common with the old SoCs.

The patch 1, 3 and 6, adds extension for SGMII to have the hardware configured
for 1G, 2.5G and AN to fit the capability of the target PHY. In patch 6 could be
an example showing how to use these configurations for underlying PHY speed to
match up the link speed of the target PHY.

The patch 4 is used for automatically configured the hardware path from GMACx to
the target PHY by the description in deviceetree topology to determine the
proper value for the corresponding MUX.

The patch 2 and 5 is for the update for MT7629 including dt-binding document and
its driver.

Sean Wang (6):
  dt-bindings: clock: mediatek: Add an extra required property to
    sgmiisys
  dt-bindings: net: mediatek: Add support for MediaTek MT7629 SoC
  net: ethernet: mediatek: Extend SGMII related functions
  net: ethernet: mediatek: Integrate hardware path from GMAC to PHY
    variants
  net: ethernet: mediatek: Add MT7629 ethernet support
  arm64: dts: mt7622: Enlarge the SGMII register range

 .../arm/mediatek/mediatek,sgmiisys.txt        |   2 +
 .../devicetree/bindings/net/mediatek-net.txt  |  14 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   3 +-
 drivers/net/ethernet/mediatek/Makefile        |   3 +-
 drivers/net/ethernet/mediatek/mtk_eth_path.c  | 323 ++++++++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  97 +++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 177 +++++++++-
 drivers/net/ethernet/mediatek/mtk_sgmii.c     | 105 ++++++
 8 files changed, 647 insertions(+), 77 deletions(-)
 create mode 100644 drivers/net/ethernet/mediatek/mtk_eth_path.c
 create mode 100644 drivers/net/ethernet/mediatek/mtk_sgmii.c

-- 
2.17.1

