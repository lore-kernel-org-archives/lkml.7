Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6841C28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D1C20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFGCGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 22:06:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728207AbfFGCFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:05:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F41B661E8AC9352B4D01;
        Fri,  7 Jun 2019 10:05:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 7 Jun 2019 10:05:08 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Zhongzhu Liu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 02/12] net: hns3: fix wrong size of mailbox responding data
Date:   Fri, 7 Jun 2019 10:03:03 +0800
Message-ID: <1559872993-14507-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559872993-14507-1-git-send-email-tanhuazhong@huawei.com>
References: <1559872993-14507-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongzhu Liu <liuzhongzhu@huawei.com>

According to user manual, the maximum size of mailbox responding
data is 8 bytes, the macro HCLGE_MBX_MAX_RESP_DATA_SIZE
should be defined as 8 instead of 16.

Fixes: 9194d18b0577 ("net: hns3: fix the problem that the supported port is empty")
Signed-off-by: Zhongzhu Liu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 83e19c6..8ad5292 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -69,7 +69,7 @@ enum hclge_mbx_vlan_cfg_subcode {
 };
 
 #define HCLGE_MBX_MAX_MSG_SIZE	16
-#define HCLGE_MBX_MAX_RESP_DATA_SIZE	16
+#define HCLGE_MBX_MAX_RESP_DATA_SIZE	8
 #define HCLGE_MBX_RING_MAP_BASIC_MSG_NUM	3
 #define HCLGE_MBX_RING_NODE_VARIABLE_NUM	3
 
-- 
2.7.4

