Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4931C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80301205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfDYMpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:45:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731396AbfDYMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:44:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 443398E64BEF5BB26870;
        Thu, 25 Apr 2019 20:44:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Apr 2019 20:44:03 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH V3 net-next 04/11] net: hns3: stop sending keep alive msg when VF command queue needs reinit
Date:   Thu, 25 Apr 2019 20:42:48 +0800
Message-ID: <1556196175-65389-5-git-send-email-tanhuazhong@huawei.com>
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

HCLGEVF_STATE_CMD_DISABLE is more suitable than
HCLGEVF_STATE_RST_HANDLING to stop sending keep alive msg,
since HCLGEVF_STATE_RST_HANDLING only be set when the reset
task is running.

Fixes: c59a85c07e77 ("net: hns3: stop sending keep alive msg to PF when VF is resetting")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index f9d98f8..7672cab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1758,7 +1758,7 @@ static void hclgevf_keep_alive_task(struct work_struct *work)
 
 	hdev = container_of(work, struct hclgevf_dev, keep_alive_task);
 
-	if (test_bit(HCLGEVF_STATE_RST_HANDLING, &hdev->state))
+	if (test_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state))
 		return;
 
 	ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_KEEP_ALIVE, 0, NULL,
-- 
2.7.4

