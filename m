Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E257C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422C4218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfDXDXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:23:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbfDXDX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54C54F963C4B421197F0;
        Wed, 24 Apr 2019 11:23:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 11:23:17 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: stop sending keep alive msg when VF command queue needs reinit
Date:   Wed, 24 Apr 2019 11:21:59 +0800
Message-ID: <1556076127-61459-5-git-send-email-tanhuazhong@huawei.com>
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

