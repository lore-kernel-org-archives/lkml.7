Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F47C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA74217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgADCt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:49:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbgADCtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:49:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9AACFE375103C6703C0E;
        Sat,  4 Jan 2020 10:49:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 4 Jan 2020 10:49:27 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/8] net: hns3: modify the IRQ name of TQP vector
Date:   Sat, 4 Jan 2020 10:49:26 +0800
Message-ID: <1578106171-17238-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578106171-17238-1-git-send-email-tanhuazhong@huawei.com>
References: <1578106171-17238-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When rename the net devices, the IRQ number can not be
fetched by the net device name, because the driver request
the IRQ resources only when the vector resource changed, and
the rename operation did not change the vector resources,
so the IRQ name keeps the previous net device name.
So this patch modifies the name of the TQP IRQ as
"pci driver name"-"pci name"-"TxRx"-"index".

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 01bad67..e240d99f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -133,18 +133,21 @@ static int hns3_nic_init_irq(struct hns3_nic_priv *priv)
 			continue;
 
 		if (tqp_vectors->tx_group.ring && tqp_vectors->rx_group.ring) {
-			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN - 1,
-				 "%s-%s-%d", priv->netdev->name, "TxRx",
-				 txrx_int_idx++);
+			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN,
+				 "%s-%s-%s-%d", hns3_driver_name,
+				 pci_name(priv->ae_handle->pdev),
+				 "TxRx", txrx_int_idx++);
 			txrx_int_idx++;
 		} else if (tqp_vectors->rx_group.ring) {
-			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN - 1,
-				 "%s-%s-%d", priv->netdev->name, "Rx",
-				 rx_int_idx++);
+			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN,
+				 "%s-%s-%s-%d", hns3_driver_name,
+				 pci_name(priv->ae_handle->pdev),
+				 "Rx", rx_int_idx++);
 		} else if (tqp_vectors->tx_group.ring) {
-			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN - 1,
-				 "%s-%s-%d", priv->netdev->name, "Tx",
-				 tx_int_idx++);
+			snprintf(tqp_vectors->name, HNAE3_INT_NAME_LEN,
+				 "%s-%s-%s-%d", hns3_driver_name,
+				 pci_name(priv->ae_handle->pdev),
+				 "Tx", tx_int_idx++);
 		} else {
 			/* Skip this unused q_vector */
 			continue;
-- 
2.7.4

