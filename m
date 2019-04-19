Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66560217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfDSDHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:07:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfDSDHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:07:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B51C543980F7887919E1;
        Fri, 19 Apr 2019 11:07:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 19 Apr 2019 11:06:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: refine tx timeout count handle
Date:   Fri, 19 Apr 2019 11:05:40 +0800
Message-ID: <1555643147-52407-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In current codes, tx_timeout_cnt is used before increased,
then we can see the tx_timeout_count is still 0 from the
print when tx timeout happens, e.g.
"hns3 0000:7d:00.3 eth3: tx_timeout count: 0, queue id: 0, SW_NTU:
 0xa6, SW_NTC: 0xa4, HW_HEAD: 0xa4, HW_TAIL: 0xa6, INT: 0x1"

The tx_timeout_cnt should be updated before used.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9233438..193994c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1655,6 +1655,8 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 		return false;
 	}
 
+	priv->tx_timeout_count++;
+
 	tx_ring = priv->ring_data[timeout_queue].ring;
 
 	hw_head = readl_relaxed(tx_ring->tqp->io_base +
@@ -1682,8 +1684,6 @@ static void hns3_nic_net_timeout(struct net_device *ndev)
 	if (!hns3_get_tx_timeo_queue_info(ndev))
 		return;
 
-	priv->tx_timeout_count++;
-
 	/* request the reset, and let the hclge to determine
 	 * which reset level should be done
 	 */
-- 
2.7.4

