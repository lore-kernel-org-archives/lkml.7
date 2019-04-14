Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A185C10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384B218C3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfDNBtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:49:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfDNBtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:49:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 42B6CF73F84E06431FEC;
        Sun, 14 Apr 2019 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Sun, 14 Apr 2019 09:48:51 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 10/12] net: hns3: do not initialize MDIO bus when PHY is inexistent
Date:   Sun, 14 Apr 2019 09:47:44 +0800
Message-ID: <1555206466-44240-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
References: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For some cases, PHY may not be connected to MDIO bus, then
the driver will initialize fail since MDIO bus initialization
fails.

This patch fixes it by skipping the MDIO bus initialization
when PHY is inexistent.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 48eda2c..12be4e2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -121,12 +121,18 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 
 int hclge_mac_mdio_config(struct hclge_dev *hdev)
 {
+#define PHY_INEXISTENT	255
+
 	struct hclge_mac *mac = &hdev->hw.mac;
 	struct phy_device *phydev;
 	struct mii_bus *mdio_bus;
 	int ret;
 
-	if (hdev->hw.mac.phy_addr >= PHY_MAX_ADDR) {
+	if (hdev->hw.mac.phy_addr == PHY_INEXISTENT) {
+		dev_info(&hdev->pdev->dev,
+			 "no phy device is connected to mdio bus\n");
+		return 0;
+	} else if (hdev->hw.mac.phy_addr >= PHY_MAX_ADDR) {
 		dev_err(&hdev->pdev->dev, "phy_addr(%d) is too large.\n",
 			hdev->hw.mac.phy_addr);
 		return -EINVAL;
-- 
2.7.4

