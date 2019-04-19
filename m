Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9363F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfDSDHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727317AbfDSDHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F14D727A04BAD0699734;
        Fri, 19 Apr 2019 11:07:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:07:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: add queue's statistics update to service task
Date:   Fri, 19 Apr 2019 11:05:46 +0800
Message-ID: <1555643147-52407-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch updates VF's TQP statistic info in the service task,
and adds a limitation to prevent update too frequently.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 8 ++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ac06568..f9d98f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1649,6 +1649,7 @@ static void hclgevf_service_timer(struct timer_list *t)
 
 	mod_timer(&hdev->service_timer, jiffies + 5 * HZ);
 
+	hdev->stats_timer++;
 	hclgevf_task_schedule(hdev);
 }
 
@@ -1769,9 +1770,16 @@ static void hclgevf_keep_alive_task(struct work_struct *work)
 
 static void hclgevf_service_task(struct work_struct *work)
 {
+	struct hnae3_handle *handle;
 	struct hclgevf_dev *hdev;
 
 	hdev = container_of(work, struct hclgevf_dev, service_task);
+	handle = &hdev->nic;
+
+	if (hdev->stats_timer >= HCLGEVF_STATS_TIMER_INTERVAL) {
+		hclgevf_tqps_update_stats(handle);
+		hdev->stats_timer = 0;
+	}
 
 	/* request the link status from the PF. PF would be able to tell VF
 	 * about such updates in future so we might remove this later
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index d39c032..ee3a6cb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -116,6 +116,8 @@
 #define HCLGEVF_S_IP_BIT		BIT(3)
 #define HCLGEVF_V_TAG_BIT		BIT(4)
 
+#define HCLGEVF_STATS_TIMER_INTERVAL	(36)
+
 enum hclgevf_evt_cause {
 	HCLGEVF_VECTOR0_EVENT_RST,
 	HCLGEVF_VECTOR0_EVENT_MBX,
@@ -281,6 +283,7 @@ struct hclgevf_dev {
 	struct hnae3_client *nic_client;
 	struct hnae3_client *roce_client;
 	u32 flag;
+	u32 stats_timer;
 };
 
 static inline bool hclgevf_is_reset_pending(struct hclgevf_dev *hdev)
-- 
2.7.4

