Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E91C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A00222DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKTBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:44:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfKTBo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:44:27 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4DF3AEC1C098C7BC3E7B;
        Wed, 20 Nov 2019 09:44:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 20 Nov 2019 09:44:16 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net] net: hns3: fix a wrong reset interrupt status mask
Date:   Wed, 20 Nov 2019 09:44:45 +0800
Message-ID: <1574214285-43543-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hardware user manual, bits5~7 in register
HCLGE_MISC_VECTOR_INT_STS means reset interrupts status,
but HCLGE_RESET_INT_M is defined as bits0~2 now. So it
will make hclge_reset_err_handle() read the wrong reset
interrupt status.

This patch fixes this wrong bit mask.

Fixes: 2336f19d7892 ("net: hns3: check reset interrupt status when reset fails")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 59b8243..615cde1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -166,7 +166,7 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_GLOBAL_RESET_BIT		0
 #define HCLGE_CORE_RESET_BIT		1
 #define HCLGE_IMP_RESET_BIT		2
-#define HCLGE_RESET_INT_M		GENMASK(2, 0)
+#define HCLGE_RESET_INT_M		GENMASK(7, 5)
 #define HCLGE_FUN_RST_ING		0x20C00
 #define HCLGE_FUN_RST_ING_B		0
 
-- 
2.7.4

