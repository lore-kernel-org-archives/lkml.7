Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D915C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D945220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfDDITM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:19:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbfDDITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF90DFA23302F325DBB7;
        Thu,  4 Apr 2019 16:19:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:19:03 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <sergei.shtylyov@cogentembedded.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 02/12] net: hns3: reduce resources use in kdump kernel
Date:   Thu, 4 Apr 2019 16:17:49 +0800
Message-ID: <1554365879-7932-3-git-send-email-tanhuazhong@huawei.com>
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

From: Yonglong Liu <liuyonglong@huawei.com>

When the kdump kernel started, the HNS3 driver fail to register:
[14.753340] hns3 0000:7d:00.0: Alloc umv space failed, want 512, get 0
[14.795034] hns3 0000:7d:00.0: add uc mac address fail, ret =-22.

By default, the HNS3 driver will use about 512M memory, but
usually the reserved memory of kdump kernel is 576M, so the HNS3
driver fail to register. This patch reduces the memory use in
kdump kernel to about 16M.

And when the kdump kernel starts, we must clear ucast mac address
first to avoid add fail.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index deda606..e742a05 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/if_vlan.h>
+#include <linux/crash_dump.h>
 #include <net/rtnetlink.h>
 #include "hclge_cmd.h"
 #include "hclge_dcb.h"
@@ -1015,6 +1016,23 @@ static int hclge_get_cap(struct hclge_dev *hdev)
 	return ret;
 }
 
+static void hclge_init_kdump_kernel_config(struct hclge_dev *hdev)
+{
+#define HCLGE_MIN_TX_DESC	64
+#define HCLGE_MIN_RX_DESC	64
+
+	if (!is_kdump_kernel())
+		return;
+
+	dev_info(&hdev->pdev->dev,
+		 "Running kdump kernel. Using minimal resources\n");
+
+	/* minimal queue pairs equals to the number of vports */
+	hdev->num_tqps = hdev->num_vmdq_vport + hdev->num_req_vfs + 1;
+	hdev->num_tx_desc = HCLGE_MIN_TX_DESC;
+	hdev->num_rx_desc = HCLGE_MIN_RX_DESC;
+}
+
 static int hclge_configure(struct hclge_dev *hdev)
 {
 	struct hclge_cfg cfg;
@@ -1074,6 +1092,8 @@ static int hclge_configure(struct hclge_dev *hdev)
 
 	hdev->tx_sch_mode = HCLGE_FLAG_TC_BASE_SCH_MODE;
 
+	hclge_init_kdump_kernel_config(hdev);
+
 	return ret;
 }
 
@@ -6293,7 +6313,8 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
 		return -EINVAL;
 	}
 
-	if (!is_first && hclge_rm_uc_addr(handle, hdev->hw.mac.mac_addr))
+	if ((!is_first || is_kdump_kernel()) &&
+	    hclge_rm_uc_addr(handle, hdev->hw.mac.mac_addr))
 		dev_warn(&hdev->pdev->dev,
 			 "remove old uc mac address fail.\n");
 
-- 
2.7.4

