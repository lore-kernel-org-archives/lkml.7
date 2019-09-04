Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586F421670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfIDJMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:12:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727144AbfIDJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:12:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2296C4A38C189A8F0F9B;
        Wed,  4 Sep 2019 17:12:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:11:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: host: xhci-tegra: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 17:10:04 +0800
Message-ID: <20190904091004.3808-1-yuehaibing@huawei.com>
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
 drivers/usb/host/xhci-tegra.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2ff7c91..742960a 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -970,7 +970,7 @@ static int tegra_xusb_powerdomain_init(struct device *dev,
 static int tegra_xusb_probe(struct platform_device *pdev)
 {
 	struct tegra_xusb_mbox_msg msg;
-	struct resource *res, *regs;
+	struct resource *regs;
 	struct tegra_xusb *tegra;
 	struct xhci_hcd *xhci;
 	unsigned int i, j, k;
@@ -992,14 +992,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tegra->fpci_base = devm_ioremap_resource(&pdev->dev, res);
+	tegra->fpci_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->fpci_base))
 		return PTR_ERR(tegra->fpci_base);
 
 	if (tegra->soc->has_ipfs) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
+		tegra->ipfs_base = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(tegra->ipfs_base))
 			return PTR_ERR(tegra->ipfs_base);
 	}
-- 
2.7.4


