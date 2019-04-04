Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC246C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933B32171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfDDIT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:19:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbfDDITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3C0150A58CD97F54516;
        Thu,  4 Apr 2019 16:19:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:19:04 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <sergei.shtylyov@cogentembedded.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 04/12] net: hns3: return 0 and print warning when hit duplicate MAC
Date:   Thu, 4 Apr 2019 16:17:51 +0800
Message-ID: <1554365879-7932-5-git-send-email-tanhuazhong@huawei.com>
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

From: Peng Li <lipeng321@huawei.com>

When set 2 same MAC to different function of one port, IMP
will return error as the later one may modify the origin one.
This will cause bond fail for 2 VFs of one port.

Driver just print warning and return 0 with this patch, so
if set same MAC address, it will return 0 but do not really
configure HW.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
V2: fixes comments from Sergei Shtylyov
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e742a05..f51e4c0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5962,8 +5962,11 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 	}
 
 	/* check if we just hit the duplicate */
-	if (!ret)
-		ret = -EINVAL;
+	if (!ret) {
+		dev_warn(&hdev->pdev->dev, "VF %d mac(%pM) exists\n",
+			 vport->vport_id, addr);
+		return 0;
+	}
 
 	dev_err(&hdev->pdev->dev,
 		"PF failed to add unicast entry(%pM) in the MAC table\n",
-- 
2.7.4

