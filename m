Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF2DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5353C205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfDYMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:45:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731397AbfDYMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B1F4271DC940DED6267;
        Thu, 25 Apr 2019 20:44:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Apr 2019 20:44:04 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH V3 net-next 05/11] net: hns3: use atomic_t replace u32 for arq's count
Date:   Thu, 25 Apr 2019 20:42:49 +0800
Message-ID: <1556196175-65389-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
References: <1556196175-65389-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since irq handler and mailbox task will both update arq's count,
so arq's count should use atomic_t instead of u32, otherwise
its value may go wrong finally.

Fixes: 07a0556a3a73 ("net: hns3: Changes to support ARQ(Asynchronous Receive Queue)")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h          | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 360463a..8b6191f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -111,7 +111,7 @@ struct hclgevf_mbx_arq_ring {
 	struct hclgevf_dev *hdev;
 	u32 head;
 	u32 tail;
-	u32 count;
+	atomic_t count;
 	u16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 1b428d4..71f356f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -340,7 +340,7 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	hdev->arq.hdev = hdev;
 	hdev->arq.head = 0;
 	hdev->arq.tail = 0;
-	hdev->arq.count = 0;
+	atomic_set(&hdev->arq.count, 0);
 	hdev->hw.cmq.csq.next_to_clean = 0;
 	hdev->hw.cmq.csq.next_to_use = 0;
 	hdev->hw.cmq.crq.next_to_clean = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index eb56287..3c22639 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -212,7 +212,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			/* we will drop the async msg if we find ARQ as full
 			 * and continue with next message
 			 */
-			if (hdev->arq.count >= HCLGE_MBX_MAX_ARQ_MSG_NUM) {
+			if (atomic_read(&hdev->arq.count) >=
+			    HCLGE_MBX_MAX_ARQ_MSG_NUM) {
 				dev_warn(&hdev->pdev->dev,
 					 "Async Q full, dropping msg(%d)\n",
 					 req->msg[1]);
@@ -224,7 +225,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			memcpy(&msg_q[0], req->msg,
 			       HCLGE_MBX_MAX_ARQ_MSG_SIZE * sizeof(u16));
 			hclge_mbx_tail_ptr_move_arq(hdev->arq);
-			hdev->arq.count++;
+			atomic_inc(&hdev->arq.count);
 
 			hclgevf_mbx_task_schedule(hdev);
 
@@ -317,7 +318,7 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 		}
 
 		hclge_mbx_head_ptr_move_arq(hdev->arq);
-		hdev->arq.count--;
+		atomic_dec(&hdev->arq.count);
 		msg_q = hdev->arq.msg_q[hdev->arq.head];
 	}
 }
-- 
2.7.4

