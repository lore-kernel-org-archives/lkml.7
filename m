Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB7FC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555492173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDFHqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:46:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbfDFHos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:44:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 55809C1D7D44773A99E7;
        Sat,  6 Apr 2019 15:44:46 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 15:44:37 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: do not request reset when hardware resetting
Date:   Sat, 6 Apr 2019 15:43:31 +0800
Message-ID: <1554536616-24977-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
References: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hardware reset does not finish, the driver should not
request a new reset, otherwise the ongoing hardware reset
will get problem.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6e8fa2e..1c93da2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -32,6 +32,7 @@
 static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps);
 static int hclge_init_vlan_config(struct hclge_dev *hdev);
 static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev);
+static bool hclge_get_hw_reset_stat(struct hnae3_handle *handle);
 static int hclge_set_umv_space(struct hclge_dev *hdev, u16 space_size,
 			       u16 *allocated_size, bool is_alloc);
 
@@ -2714,9 +2715,18 @@ int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id)
 
 static void hclge_do_reset(struct hclge_dev *hdev)
 {
+	struct hnae3_handle *handle = &hdev->vport[0].nic;
 	struct pci_dev *pdev = hdev->pdev;
 	u32 val;
 
+	if (hclge_get_hw_reset_stat(handle)) {
+		dev_info(&pdev->dev, "Hardware reset not finish\n");
+		dev_info(&pdev->dev, "func_rst_reg:0x%x, global_rst_reg:0x%x\n",
+			 hclge_read_dev(&hdev->hw, HCLGE_FUN_RST_ING),
+			 hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG));
+		return;
+	}
+
 	switch (hdev->reset_type) {
 	case HNAE3_GLOBAL_RESET:
 		val = hclge_read_dev(&hdev->hw, HCLGE_GLOBAL_RESET_REG);
-- 
2.7.4

