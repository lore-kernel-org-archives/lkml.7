Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EF42339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfHUNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:30:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728840AbfHUNal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:30:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A170E7F7B45C492575C;
        Wed, 21 Aug 2019 21:30:34 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 21:30:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <fugang.duan@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: fec: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 21 Aug 2019 21:29:45 +0800
Message-ID: <20190821132945.19648-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/freescale/fec_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c01d3ec..cacc671 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3338,7 +3338,6 @@ fec_probe(struct platform_device *pdev)
 	struct fec_platform_data *pdata;
 	struct net_device *ndev;
 	int i, irq, ret = 0;
-	struct resource *r;
 	const struct of_device_id *of_id;
 	static int dev_id;
 	struct device_node *np = pdev->dev.of_node, *phy_node;
@@ -3378,8 +3377,7 @@ fec_probe(struct platform_device *pdev)
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fep->hwp = devm_ioremap_resource(&pdev->dev, r);
+	fep->hwp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fep->hwp)) {
 		ret = PTR_ERR(fep->hwp);
 		goto failed_ioremap;
-- 
2.7.4


