Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C62C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BEB2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfJNHPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:15:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13252 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbfJNHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:15:25 -0400
X-UUID: b90a83006a8348e499a3b78d1aa1c982-20191014
X-UUID: b90a83006a8348e499a3b78d1aa1c982-20191014
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-mc.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 181844034; Mon, 14 Oct 2019 15:15:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 15:15:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 15:15:18 +0800
From:   MarkLee <Mark-MC.Lee@mediatek.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rene van Dorst <opensource@vdorst.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        MarkLee <Mark-MC.Lee@mediatek.com>
Subject: [PATCH net,v3 1/2] net: ethernet: mediatek: Fix MT7629 missing GMII mode support
Date:   Mon, 14 Oct 2019 15:15:17 +0800
Message-ID: <20191014071518.11923-2-Mark-MC.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191014071518.11923-1-Mark-MC.Lee@mediatek.com>
References: <20191014071518.11923-1-Mark-MC.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the original design, mtk_phy_connect function will set ge_mode=1
if phy-mode is GMII(PHY_INTERFACE_MODE_GMII) and then set the correct
ge_mode to ETHSYS_SYSCFG0 register. This logic was broken after apply  
mediatek PHYLINK patch(Fixes tag), the new mtk_mac_config function will
not set ge_mode=1 for GMII mode hence the final ETHSYS_SYSCFG0 setting 
will be incorrect for mt7629 GMII mode. This patch add the missing logic
back to fix it.
			 
Fixes: b8fc9f30821e ("net: ethernet: mediatek: Add basic PHYLINK support")
Signed-off-by: MarkLee <Mark-MC.Lee@mediatek.com>
--
v2->v3:
* no change
v1->v2:
* no change
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c61069340f4f..703adb96429e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -261,6 +261,7 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		ge_mode = 0;
 		switch (state->interface) {
 		case PHY_INTERFACE_MODE_MII:
+		case PHY_INTERFACE_MODE_GMII:
 			ge_mode = 1;
 			break;
 		case PHY_INTERFACE_MODE_REVMII:
-- 
2.17.1

