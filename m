Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A66C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF2207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFDVWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:22:41 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:34410 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFDVWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:22:40 -0400
X-UUID: cd99d0f0e3104553a074aea72534f4de-20190604
X-UUID: cd99d0f0e3104553a074aea72534f4de-20190604
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 339247170; Tue, 04 Jun 2019 13:22:31 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Jun 2019 14:22:29 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 05:22:28 +0800
From:   <sean.wang@mediatek.com>
To:     <john@phrozen.org>, <davem@davemloft.net>
CC:     <nbd@openwrt.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net v1] net: ethernet: mediatek: Fixed several errors caused by undefined symbols
Date:   Wed, 5 Jun 2019 05:22:27 +0800
Message-ID: <1559683347-5752-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fixed several errors caused by undefined symbols catched by kbuild test
robot.

ERROR: "mtk_sgmii_init" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
ERROR: "mtk_setup_hw_path" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
ERROR: "mtk_sgmii_setup_mode_force" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
ERROR: "mtk_sgmii_setup_mode_an" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
ERROR: "mtk_w32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
ERROR: "mtk_r32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!

Fixes: 	7093f9d80c7c ("net: ethernet: mediatek: Integrate hardware path from GMAC to PHY variants")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/ethernet/mediatek/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index 212c86f9982f..d92adef15603 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -3,5 +3,6 @@
 # Makefile for the Mediatek SoCs built-in ethernet macs
 #
 
-obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth_soc.o mtk_sgmii.o \
-						  mtk_eth_path.o
+obj-$(CONFIG_NET_MEDIATEK_SOC) := mtk_eth.o
+
+mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o
-- 
2.17.1

