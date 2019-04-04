Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D00C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D19F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDDITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:19:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbfDDITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03BBD9AF2A55792883B3;
        Thu,  4 Apr 2019 16:19:15 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:19:04 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <sergei.shtylyov@cogentembedded.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH V2 net-next 07/12] net: hns3: simplify hclgevf_cmd_csq_clean
Date:   Thu, 4 Apr 2019 16:17:54 +0800
Message-ID: <1554365879-7932-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554365879-7932-1-git-send-email-tanhuazhong@huawei.com>
References: <1554365879-7932-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csq is used as a ring buffer, the value of the desc will be replaced
in next use. This patch removes the unnecessary memset, and just
updates the next_to_clean.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 35 +++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 9441b45..930b175 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -27,26 +27,39 @@ static int hclgevf_ring_space(struct hclgevf_cmq_ring *ring)
 	return ring->desc_num - used - 1;
 }
 
+static int hclgevf_is_valid_csq_clean_head(struct hclgevf_cmq_ring *ring,
+					   int head)
+{
+	int ntu = ring->next_to_use;
+	int ntc = ring->next_to_clean;
+
+	if (ntu > ntc)
+		return head >= ntc && head <= ntu;
+
+	return head >= ntc || head <= ntu;
+}
+
 static int hclgevf_cmd_csq_clean(struct hclgevf_hw *hw)
 {
+	struct hclgevf_dev *hdev = container_of(hw, struct hclgevf_dev, hw);
 	struct hclgevf_cmq_ring *csq = &hw->cmq.csq;
-	u16 ntc = csq->next_to_clean;
-	struct hclgevf_desc *desc;
 	int clean = 0;
 	u32 head;
 
-	desc = &csq->desc[ntc];
 	head = hclgevf_read_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG);
-	while (head != ntc) {
-		memset(desc, 0, sizeof(*desc));
-		ntc++;
-		if (ntc == csq->desc_num)
-			ntc = 0;
-		desc = &csq->desc[ntc];
-		clean++;
+	rmb(); /* Make sure head is ready before touch any data */
+
+	if (!hclgevf_is_valid_csq_clean_head(csq, head)) {
+		dev_warn(&hdev->pdev->dev, "wrong cmd head (%d, %d-%d)\n", head,
+			 csq->next_to_use, csq->next_to_clean);
+		dev_warn(&hdev->pdev->dev,
+			 "Disabling any further commands to IMP firmware\n");
+		set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+		return -EIO;
 	}
-	csq->next_to_clean = ntc;
 
+	clean = (head - csq->next_to_clean + csq->desc_num) % csq->desc_num;
+	csq->next_to_clean = head;
 	return clean;
 }
 
-- 
2.7.4

