Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB8C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AB22080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfH1OZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:25:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfH1OZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:25:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20AAF72F76A31012F689;
        Wed, 28 Aug 2019 22:25:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 22:25:30 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: use macro instead of magic number
Date:   Wed, 28 Aug 2019 22:23:06 +0800
Message-ID: <1567002196-63242-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
References: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses macro to replace some magic number.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index a56f388..3b4cd23 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -774,7 +774,8 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 	rx_priv_wl = (struct hclge_rx_priv_wl_buf *)desc[1].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
 		dev_info(&hdev->pdev->dev,
-			 "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n", i + 4,
+			 "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n",
+			 i + HCLGE_TC_NUM_ONE_DESC,
 			 rx_priv_wl->tc_wl[i].high, rx_priv_wl->tc_wl[i].low);
 
 	cmd = HCLGE_OPC_RX_COM_THRD_ALLOC;
@@ -796,7 +797,8 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 	rx_com_thrd = (struct hclge_rx_com_thrd *)desc[1].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
 		dev_info(&hdev->pdev->dev,
-			 "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n", i + 4,
+			 "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n",
+			 i + HCLGE_TC_NUM_ONE_DESC,
 			 rx_com_thrd->com_thrd[i].high,
 			 rx_com_thrd->com_thrd[i].low);
 	return;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 80e5cc2..38b7932 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -72,9 +72,10 @@ struct hclge_dbg_reg_common_msg {
 	enum hclge_opcode_type cmd;
 };
 
+#define	HCLGE_DBG_MAX_DFX_MSG_LEN	60
 struct hclge_dbg_dfx_message {
 	int flag;
-	char message[60];
+	char message[HCLGE_DBG_MAX_DFX_MSG_LEN];
 };
 
 #define HCLGE_DBG_MAC_REG_TYPE_LEN	32
-- 
2.7.4

