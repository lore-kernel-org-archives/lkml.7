Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19256C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8FA2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfHUNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:51:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUNvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:51:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 022F8B2573DACA4DFC57;
        Wed, 21 Aug 2019 21:51:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 21:51:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@st.com>, <joabreu@synopsys.com>,
        <khilman@baylibre.com>, <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: stmmac: dwmac-meson8b: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 21 Aug 2019 21:51:30 +0800
Message-ID: <20190821135130.68636-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 786ca4a..9cda29e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -308,7 +308,6 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
-	struct resource *res;
 	struct meson8b_dwmac *dwmac;
 	int ret;
 
@@ -332,8 +331,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err_remove_config_dt;
 	}
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
+	dwmac->regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dwmac->regs)) {
 		ret = PTR_ERR(dwmac->regs);
 		goto err_remove_config_dt;
-- 
2.7.4


