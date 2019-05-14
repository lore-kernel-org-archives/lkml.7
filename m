Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B5EC04AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 02:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F05208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 02:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfENC3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 22:29:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47783 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726387AbfENC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 22:29:10 -0400
X-UUID: 477adf8be90040efa94d9a7d15314c71-20190514
X-UUID: 477adf8be90040efa94d9a7d15314c71-20190514
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 231203543; Tue, 14 May 2019 10:29:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 10:29:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 10:28:59 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [v2, PATCH 2/4] net: stmmac: fix csr_clk can't be zero issue
Date:   Tue, 14 May 2019 10:28:51 +0800
Message-ID: <1557800933-30759-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1557800933-30759-1-git-send-email-biao.huang@mediatek.com>
References: <1557800933-30759-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The specific clk_csr value can be zero, and
stmmac_clk is necessary for MDC clock which can be set dynamically.
So, change the condition from plat->clk_csr to plat->stmmac_clk to
fix clk_csr can't be zero issue.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    6 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 906f2be..a905b63 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4374,10 +4374,10 @@ int stmmac_dvr_probe(struct device *device,
 	 * set the MDC clock dynamically according to the csr actual
 	 * clock input.
 	 */
-	if (!priv->plat->clk_csr)
-		stmmac_clk_csr_set(priv);
-	else
+	if (priv->plat->clk_csr >= 0)
 		priv->clk_csr = priv->plat->clk_csr;
+	else
+		stmmac_clk_csr_set(priv);
 
 	stmmac_check_pcs_mode(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3031f2b..f45bfbe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -408,7 +408,10 @@ struct plat_stmmacenet_data *
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
 
-	/* Get clk_csr from device tree */
+	/* Default to get clk_csr from stmmac_clk_crs_set(),
+	 * or get clk_csr from device tree.
+	 */
+	plat->clk_csr = -1;
 	of_property_read_u32(np, "clk_csr", &plat->clk_csr);
 
 	/* "snps,phy-addr" is not a standard property. Mark it as deprecated
-- 
1.7.9.5

