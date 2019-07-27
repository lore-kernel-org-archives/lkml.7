Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FB5C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C0720828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 05:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfG0Fsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:48:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbfG0FsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:48:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF5F44A60892E37F9A0D;
        Sat, 27 Jul 2019 13:48:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 27 Jul 2019 13:48:08 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <saeedm@mellanox.com>,
        Guangbin Huang <huangguangbin@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH V3 net-next 02/10] net: hns3: add a check for get_reset_level
Date:   Sat, 27 Jul 2019 13:46:04 +0800
Message-ID: <1564206372-42467-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564206372-42467-1-git-send-email-tanhuazhong@huawei.com>
References: <1564206372-42467-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangbin Huang <huangguangbin@huawei.com>

For some cases, ops->get_reset_level may not be implemented, so we
should check whether it is NULL before calling get_reset_level.

Signed-off-by: Guangbin Huang <huangguangbin@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 08af782..4d58c53 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1963,7 +1963,7 @@ static pci_ers_result_t hns3_slot_reset(struct pci_dev *pdev)
 
 	ops = ae_dev->ops;
 	/* request the reset */
-	if (ops->reset_event) {
+	if (ops->reset_event && ops->get_reset_level) {
 		if (ae_dev->hw_err_reset_req) {
 			reset_type = ops->get_reset_level(ae_dev,
 						&ae_dev->hw_err_reset_req);
-- 
2.7.4

