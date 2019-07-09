Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09010C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5092166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGICgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:36:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12602 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725886AbfGICgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:36:44 -0400
X-UUID: 1d77772b16c348e28179721787fd1af7-20190709
X-UUID: 1d77772b16c348e28179721787fd1af7-20190709
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2044741967; Tue, 09 Jul 2019 10:36:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 10:36:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 10:36:35 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, Jose Abreu <joabreu@synopsys.com>,
        <andrew@lunn.ch>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>,
        <boon.leong.ong@intel.com>
Subject: [PATCH 1/2 net-next] net: stmmac: dwmac4: mac address array boudary violation issue
Date:   Tue, 9 Jul 2019 10:36:22 +0800
Message-ID: <20190709023623.8358-2-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190709023623.8358-1-biao.huang@mediatek.com>
References: <20190709023623.8358-1-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mac address array size is GMAC_MAX_PERFECT_ADDRESSES,
so the 'reg' should be less than it, or will affect other registers.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 8d9f6cda4012..776077ec1a23 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -454,7 +454,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 			reg++;
 		}
 
-		while (reg <= GMAC_MAX_PERFECT_ADDRESSES) {
+		while (reg < GMAC_MAX_PERFECT_ADDRESSES) {
 			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
 			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
 			reg++;
-- 
2.18.0

