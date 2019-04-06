Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C603C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664842173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDFHqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:46:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfDFHot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:44:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 61C7E25E482C10668F3E;
        Sat,  6 Apr 2019 15:44:46 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 15:44:39 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: fix keep_alive_timer not stop problem
Date:   Sat, 6 Apr 2019 15:43:36 +0800
Message-ID: <1554536616-24977-13-git-send-email-tanhuazhong@huawei.com>
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

When hclgevf_client_start() fails or VF driver unloaded, there is
nobody to disable keep_alive_timer.

So this patch fixes them.

Fixes: a6d818e31d08 ("net: hns3: Add vport alive state checking support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 110ec8b..b917960 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2031,9 +2031,15 @@ static int hclgevf_set_alive(struct hnae3_handle *handle, bool alive)
 static int hclgevf_client_start(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int ret;
+
+	ret = hclgevf_set_alive(handle, true);
+	if (ret)
+		return ret;
 
 	mod_timer(&hdev->keep_alive_timer, jiffies + 2 * HZ);
-	return hclgevf_set_alive(handle, true);
+
+	return 0;
 }
 
 static void hclgevf_client_stop(struct hnae3_handle *handle)
@@ -2075,6 +2081,10 @@ static void hclgevf_state_uninit(struct hclgevf_dev *hdev)
 {
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
+	if (hdev->keep_alive_timer.function)
+		del_timer_sync(&hdev->keep_alive_timer);
+	if (hdev->keep_alive_task.func)
+		cancel_work_sync(&hdev->keep_alive_task);
 	if (hdev->service_timer.function)
 		del_timer_sync(&hdev->service_timer);
 	if (hdev->service_task.func)
-- 
2.7.4

