Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB93222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSG5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:57:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfLSG5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:57:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D6F433F23F7B03A80800;
        Thu, 19 Dec 2019 14:57:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 14:57:39 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 7/8] net: hns3: add a log for getting chain failure in hns3_nic_uninit_vector_data()
Date:   Thu, 19 Dec 2019 14:57:46 +0800
Message-ID: <1576738667-37960-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576738667-37960-1-git-send-email-tanhuazhong@huawei.com>
References: <1576738667-37960-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the mapping can be overwritten, when fail to get
the chain between vector and ring, we should go on to
deal with the remaining options. For debugging, this
patch adds log info for this failure.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 840a1fb..aee5fac 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3602,7 +3602,12 @@ static void hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 		if (!tqp_vector->rx_group.ring && !tqp_vector->tx_group.ring)
 			continue;
 
-		hns3_get_vector_ring_chain(tqp_vector, &vector_ring_chain);
+		/* Since the mapping can be overwritten, when fail to get the
+		 * chain between vector and ring, we should go on to deal with
+		 * the remaining options.
+		 */
+		if (hns3_get_vector_ring_chain(tqp_vector, &vector_ring_chain))
+			dev_warn(priv->dev, "failed to get ring chain\n");
 
 		h->ae_algo->ops->unmap_ring_from_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-- 
2.7.4

