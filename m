Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819DC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB24321773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfDQBvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:51:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfDQBvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:51:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0F597ECB5168847F1BC9;
        Wed, 17 Apr 2019 09:51:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 09:50:55 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>,
        <mcoquelin.stm32@gmail.com>, <aaro.koskinen@nokia.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <netdev@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net: stmmac: Use bfsize1 in ndesc_init_rx_desc
Date:   Wed, 17 Apr 2019 09:49:39 +0800
Message-ID: <20190417014939.36656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

gcc warn this:

drivers/net/ethernet/stmicro/stmmac/norm_desc.c: In function ndesc_init_rx_desc:
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:138:6: warning: variable 'bfsize1' set but not used [-Wunused-but-set-variable]

Like enh_desc_init_rx_desc, we should use bfsize1
in ndesc_init_rx_desc to calculate 'p->des1'

Fixes: 583e63614149 ("net: stmmac: use correct DMA buffer size in the RX descriptor")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index b7dd4e3..6d69067 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -140,7 +140,7 @@ static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 
 	bfsize1 = min(bfsize, BUF_SIZE_2KiB - 1);
-	p->des1 |= cpu_to_le32(bfsize & RDES1_BUFFER1_SIZE_MASK);
+	p->des1 |= cpu_to_le32(bfsize1 & RDES1_BUFFER1_SIZE_MASK);
 
 	if (mode == STMMAC_CHAIN_MODE)
 		ndesc_rx_set_on_chain(p, end);
-- 
2.7.0


