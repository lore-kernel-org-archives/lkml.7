Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787EBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473232080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfHZB14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 21:27:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfHZB14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 21:27:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 77F959007E5A52120171;
        Mon, 26 Aug 2019 09:27:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 26 Aug 2019 09:27:45 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <nbd@openwrt.org>, <john@phrozen.org>, <sean.wang@mediatek.com>,
        <nelson.chang@mediatek.com>, <davem@davemloft.net>,
        <matthias.bgg@gmail.com>
CC:     <kernel-janitors@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH v2 -next] net: mediatek: remove set but not used variable 'status'
Date:   Mon, 26 Aug 2019 09:31:18 +0800
Message-ID: <20190826013118.22720-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824.142158.1506174328495468705.davem@davemloft.net>
References: <20190824.142158.1506174328495468705.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:
drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function mtk_handle_irq:
drivers/net/ethernet/mediatek/mtk_eth_soc.c:1951:6: warning: variable status set but not used [-Wunused-but-set-variable]

Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: change format of 'Fixes' tag.
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8ddbb8d..bb7d623 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1948,9 +1948,7 @@ static irqreturn_t mtk_handle_irq_tx(int irq, void *_eth)
 static irqreturn_t mtk_handle_irq(int irq, void *_eth)
 {
 	struct mtk_eth *eth = _eth;
-	u32 status;
 
-	status = mtk_r32(eth, MTK_PDMA_INT_STATUS);
 	if (mtk_r32(eth, MTK_PDMA_INT_MASK) & MTK_RX_DONE_INT) {
 		if (mtk_r32(eth, MTK_PDMA_INT_STATUS) & MTK_RX_DONE_INT)
 			mtk_handle_irq_rx(irq, _eth);
-- 
2.7.4

