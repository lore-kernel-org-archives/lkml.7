Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6EAC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF74A22C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfGZD15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:27:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfGZD1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:27:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E275C20D583BA8B69D89;
        Fri, 26 Jul 2019 11:27:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Jul 2019 11:26:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yufeng Mo <moyufeng@huawei.com>,
        lipeng 00277521 <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 05/11] net: hns3: change GFP flag during lock period
Date:   Fri, 26 Jul 2019 11:24:56 +0800
Message-ID: <1564111502-15504-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564111502-15504-1-git-send-email-tanhuazhong@huawei.com>
References: <1564111502-15504-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufeng Mo <moyufeng@huawei.com>

When allocating memory, the GFP_KERNEL cannot be used during the
spin_lock period. This is because it may cause scheduling when holding
spin_lock. This patch changes GFP flag to GFP_ATOMIC in this case.

Fixes: dd74f815dd41 ("net: hns3: Add support for rule add/delete for flow director")
Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
Signed-off-by: lipeng 00277521 <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9329aab..faf60b4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5798,7 +5798,7 @@ static int hclge_add_fd_entry_by_arfs(struct hnae3_handle *handle, u16 queue_id,
 			return -ENOSPC;
 		}
 
-		rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+		rule = kzalloc(sizeof(*rule), GFP_ATOMIC);
 		if (!rule) {
 			spin_unlock_bh(&hdev->fd_rule_lock);
 
-- 
2.7.4

