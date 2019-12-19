Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF18222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSG6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:58:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfLSG5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:57:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E49CE31B55E5B73CE31F;
        Thu, 19 Dec 2019 14:57:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 14:57:38 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/8] net: hns3: optimization for CMDQ uninitialization
Date:   Thu, 19 Dec 2019 14:57:42 +0800
Message-ID: <1576738667-37960-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576738667-37960-1-git-send-email-tanhuazhong@huawei.com>
References: <1576738667-37960-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When uninitializing CMDQ, HCLGE_STATE_CMD_DISABLE will
be set up firstly, then the driver does not send command
anymore. So, hclge_free_cmd_desc can be called without
holding ring->lock. hclge_destroy_cmd_queue() and
hclge_destroy_queue() are unnecessary now, so removes them,
the VF driver has implemented currently.

BTW, the VF driver should set up HCLGEVF_STATE_CMD_DISABLE
as well in the hclgevf_cmd_uninit(), just likes what the PF
driver does.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c   | 16 ++--------------
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c |  2 +-
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 940ead3..7f509ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -479,19 +479,6 @@ static void hclge_cmd_uninit_regs(struct hclge_hw *hw)
 	hclge_write_dev(hw, HCLGE_NIC_CRQ_TAIL_REG, 0);
 }
 
-static void hclge_destroy_queue(struct hclge_cmq_ring *ring)
-{
-	spin_lock(&ring->lock);
-	hclge_free_cmd_desc(ring);
-	spin_unlock(&ring->lock);
-}
-
-static void hclge_destroy_cmd_queue(struct hclge_hw *hw)
-{
-	hclge_destroy_queue(&hw->cmq.csq);
-	hclge_destroy_queue(&hw->cmq.crq);
-}
-
 void hclge_cmd_uninit(struct hclge_dev *hdev)
 {
 	spin_lock_bh(&hdev->hw.cmq.csq.lock);
@@ -501,5 +488,6 @@ void hclge_cmd_uninit(struct hclge_dev *hdev)
 	spin_unlock(&hdev->hw.cmq.crq.lock);
 	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
 
-	hclge_destroy_cmd_queue(&hdev->hw);
+	hclge_free_cmd_desc(&hdev->hw.cmq.csq);
+	hclge_free_cmd_desc(&hdev->hw.cmq.crq);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index af2245e..f38d236 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -443,7 +443,7 @@ void hclgevf_cmd_uninit(struct hclgevf_dev *hdev)
 {
 	spin_lock_bh(&hdev->hw.cmq.csq.lock);
 	spin_lock(&hdev->hw.cmq.crq.lock);
-	clear_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+	set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
 	hclgevf_cmd_uninit_regs(&hdev->hw);
 	spin_unlock(&hdev->hw.cmq.crq.lock);
 	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
-- 
2.7.4

