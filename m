Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28240C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018C3218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfDXDYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:24:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729213AbfDXDXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DF0BFDE30721E023BAF;
        Wed, 24 Apr 2019 11:23:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 11:23:18 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: stop schedule reset service while unloading driver
Date:   Wed, 24 Apr 2019 11:22:03 +0800
Message-ID: <1556076127-61459-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
References: <1556076127-61459-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses HCLGE_STATE_REMOVING/HCLGEVF_STATE_REMOVING flag to
indicate that the driver is unloading, and we should stop new coming
reset service to be scheduled, otherwise, reset service will access
some resource which has been freed by unloading.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4d5568e..ead8308 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2175,7 +2175,8 @@ static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
 
 static void hclge_reset_task_schedule(struct hclge_dev *hdev)
 {
-	if (!test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
+	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
+	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
 		schedule_work(&hdev->rst_service_task);
 }
 
@@ -7768,6 +7769,7 @@ static void hclge_state_init(struct hclge_dev *hdev)
 static void hclge_state_uninit(struct hclge_dev *hdev)
 {
 	set_bit(HCLGE_STATE_DOWN, &hdev->state);
+	set_bit(HCLGE_STATE_REMOVING, &hdev->state);
 
 	if (hdev->service_timer.function)
 		del_timer_sync(&hdev->service_timer);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 6ce5b03..f0de528 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1611,7 +1611,8 @@ static void hclgevf_get_misc_vector(struct hclgevf_dev *hdev)
 
 void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev)
 {
-	if (!test_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state)) {
+	if (!test_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state) &&
+	    !test_bit(HCLGEVF_STATE_REMOVING, &hdev->state)) {
 		set_bit(HCLGEVF_STATE_RST_SERVICE_SCHED, &hdev->state);
 		schedule_work(&hdev->rst_service_task);
 	}
@@ -2049,6 +2050,7 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 	int i;
 
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
+	set_bit(HCLGEVF_STATE_REMOVING, &hdev->state);
 
 	if (hdev->reset_type != HNAE3_VF_RESET)
 		for (i = 0; i < handle->kinfo.num_tqps; i++)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index ee3a6cb..0cceda3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -130,6 +130,7 @@ enum hclgevf_states {
 	HCLGEVF_STATE_DOWN,
 	HCLGEVF_STATE_DISABLED,
 	HCLGEVF_STATE_IRQ_INITED,
+	HCLGEVF_STATE_REMOVING,
 	/* task states */
 	HCLGEVF_STATE_SERVICE_SCHED,
 	HCLGEVF_STATE_RST_SERVICE_SCHED,
-- 
2.7.4

