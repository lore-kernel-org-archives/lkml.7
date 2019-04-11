Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED07C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C322184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:26:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbfDKM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34E2553AF51499322636;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:35 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: do not initialize MDIO bus when PHY is inexistent
Date:   Thu, 11 Apr 2019 20:25:29 +0800
Message-ID: <1554985531-1827-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For some boards, PHY is not connected to MDIO bus. In this case,
MDIO bus initialization will fail, then cause the device initialize
fail.

This patch fixes it by skip the MDIO bus initialization when PHY
is inexistent.

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

