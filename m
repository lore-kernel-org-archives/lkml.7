Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6F0218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDXDYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:24:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729199AbfDXDXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B36BAB3CA7F4CBB8542;
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
Subject: [PATCH net-next 07/12] net: hns3: not reset TQP in the DOWN while VF resetting
Date:   Wed, 24 Apr 2019 11:22:02 +0800
Message-ID: <1556076127-61459-8-git-send-email-tanhuazhong@huawei.com>
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

Since the hardware does not handle mailboxes and the hardware
reset include TQP reset, so it is unnecessary to reset TQP
in the hclgevf_ae_stop() while doing VF reset. Also it is
unnecessary to reset the remaining TQP when one reset fails.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 7672cab..6ce5b03 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2050,8 +2050,10 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-	for (i = 0; i < handle->kinfo.num_tqps; i++)
-		hclgevf_reset_tqp(handle, i);
+	if (hdev->reset_type != HNAE3_VF_RESET)
+		for (i = 0; i < handle->kinfo.num_tqps; i++)
+			if (hclgevf_reset_tqp(handle, i))
+				break;
 
 	/* reset tqp stats */
 	hclgevf_reset_tqp_stats(handle);
-- 
2.7.4

