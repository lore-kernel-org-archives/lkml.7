Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DDCC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56872085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGDOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:06:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbfGDOG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:06:29 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D8497951752DBEBBD4F7;
        Thu,  4 Jul 2019 22:06:21 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 22:06:15 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: fix flow control configure issue for fibre port
Date:   Thu, 4 Jul 2019 22:04:21 +0800
Message-ID: <1562249068-40176-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562249068-40176-1-git-send-email-tanhuazhong@huawei.com>
References: <1562249068-40176-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Flow control autoneg is unsupported for fibre port. It takes no
effect for flow control when restart autoneg. This patch fixes
it, return -EOPNOTSUPP when user tries to enable flow control
autoneg.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 62c6263..2ecc10a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8179,8 +8179,9 @@ static void hclge_get_pauseparam(struct hnae3_handle *handle, u32 *auto_neg,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	struct phy_device *phydev = hdev->hw.mac.phydev;
 
-	*auto_neg = hclge_get_autoneg(handle);
+	*auto_neg = phydev ? hclge_get_autoneg(handle) : 0;
 
 	if (hdev->tm_info.fc_mode == HCLGE_FC_PFC) {
 		*rx_en = 0;
@@ -8211,11 +8212,13 @@ static int hclge_set_pauseparam(struct hnae3_handle *handle, u32 auto_neg,
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 	u32 fc_autoneg;
 
-	fc_autoneg = hclge_get_autoneg(handle);
-	if (auto_neg != fc_autoneg) {
-		dev_info(&hdev->pdev->dev,
-			 "To change autoneg please use: ethtool -s <dev> autoneg <on|off>\n");
-		return -EOPNOTSUPP;
+	if (phydev) {
+		fc_autoneg = hclge_get_autoneg(handle);
+		if (auto_neg != fc_autoneg) {
+			dev_info(&hdev->pdev->dev,
+				 "To change autoneg please use: ethtool -s <dev> autoneg <on|off>\n");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	if (hdev->tm_info.fc_mode == HCLGE_FC_PFC) {
@@ -8226,16 +8229,13 @@ static int hclge_set_pauseparam(struct hnae3_handle *handle, u32 auto_neg,
 
 	hclge_set_flowctrl_adv(hdev, rx_en, tx_en);
 
-	if (!fc_autoneg)
+	if (!auto_neg)
 		return hclge_cfg_pauseparam(hdev, rx_en, tx_en);
 
 	if (phydev)
 		return phy_start_aneg(phydev);
 
-	if (hdev->pdev->revision == 0x20)
-		return -EOPNOTSUPP;
-
-	return hclge_restart_autoneg(handle);
+	return -EOPNOTSUPP;
 }
 
 static void hclge_get_ksettings_an_result(struct hnae3_handle *handle,
-- 
2.7.4

