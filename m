Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EF1218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfDXDXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:23:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729393AbfDXDXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:23:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DA631C92CE525AF47B9;
        Wed, 24 Apr 2019 11:23:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 11:23:19 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: prevent double free in hns3_put_ring_config()
Date:   Wed, 24 Apr 2019 11:22:06 +0800
Message-ID: <1556076127-61459-12-git-send-email-tanhuazhong@huawei.com>
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

This patch adds a check for the hns3_put_ring_config() to prevent
double free, and for more readable, move the NULL assignment of
priv->ring_data into the hns3_put_ring_config().

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7dc281c..b0f31eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3487,6 +3487,7 @@ static int hns3_get_ring_config(struct hns3_nic_priv *priv)
 	}
 
 	devm_kfree(&pdev->dev, priv->ring_data);
+	priv->ring_data = NULL;
 	return ret;
 }
 
@@ -3495,12 +3496,16 @@ static void hns3_put_ring_config(struct hns3_nic_priv *priv)
 	struct hnae3_handle *h = priv->ae_handle;
 	int i;
 
+	if (!priv->ring_data)
+		return;
+
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
 		devm_kfree(priv->dev, priv->ring_data[i].ring);
 		devm_kfree(priv->dev,
 			   priv->ring_data[i + h->kinfo.num_tqps].ring);
 	}
 	devm_kfree(priv->dev, priv->ring_data);
+	priv->ring_data = NULL;
 }
 
 static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
@@ -3920,8 +3925,6 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_dbg_uninit(handle);
 
-	priv->ring_data = NULL;
-
 out_netdev_free:
 	free_netdev(netdev);
 }
@@ -4268,12 +4271,10 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	hns3_uninit_all_ring(priv);
 err_uninit_vector:
 	hns3_nic_uninit_vector_data(priv);
-	priv->ring_data = NULL;
 err_dealloc_vector:
 	hns3_nic_dealloc_vector_data(priv);
 err_put_ring:
 	hns3_put_ring_config(priv);
-	priv->ring_data = NULL;
 
 	return ret;
 }
@@ -4335,7 +4336,6 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 		netdev_err(netdev, "uninit ring error\n");
 
 	hns3_put_ring_config(priv);
-	priv->ring_data = NULL;
 
 	return ret;
 }
-- 
2.7.4

