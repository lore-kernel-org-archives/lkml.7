Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A65C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA9218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfDXDX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:23:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbfDXDXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 670111C91465009F0132;
        Wed, 24 Apr 2019 11:23:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 11:23:19 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: extend the loopback state acquisition time
Date:   Wed, 24 Apr 2019 11:22:05 +0800
Message-ID: <1556076127-61459-11-git-send-email-tanhuazhong@huawei.com>
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

From: liuzhongzhu <liuzhongzhu@huawei.com>

The test results show that the maximum time of hardware return
to mac link state is 500MS.The software needs to set twice the
maximum time of hardware return state (1000MS).

If not modified, the loopback test returns probability failure.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ead8308..22afd75 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5338,8 +5338,8 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en,
 #define HCLGE_SERDES_RETRY_MS	10
 #define HCLGE_SERDES_RETRY_NUM	100
 
-#define HCLGE_MAC_LINK_STATUS_MS   20
-#define HCLGE_MAC_LINK_STATUS_NUM  10
+#define HCLGE_MAC_LINK_STATUS_MS   10
+#define HCLGE_MAC_LINK_STATUS_NUM  100
 #define HCLGE_MAC_LINK_STATUS_DOWN 0
 #define HCLGE_MAC_LINK_STATUS_UP   1
 
-- 
2.7.4

