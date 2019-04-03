Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E73C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C52084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfDCDJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:09:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbfDCDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:09:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 17B7BA914C1FA8ECBAE7;
        Wed,  3 Apr 2019 11:09:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 11:09:11 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: split function hnae3_match_n_instantiate()
Date:   Wed, 3 Apr 2019 11:08:01 +0800
Message-ID: <1554260881-44948-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The function hnae3_match_n_instantiate() was called both by
initializing or uninitializing client. For uninitializing, the
return value was never used.

To make it more clear, this patch splits it to two functions,
hnae3_init_client_instance() and hnae3_uninit_client_instance().

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 40 ++++++++++++++++-------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 17ab4f4..fa8b850 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -76,8 +76,8 @@ static int hnae3_get_client_init_flag(struct hnae3_client *client,
 	return inited;
 }
 
-static int hnae3_match_n_instantiate(struct hnae3_client *client,
-				     struct hnae3_ae_dev *ae_dev, bool is_reg)
+static int hnae3_init_client_instance(struct hnae3_client *client,
+				      struct hnae3_ae_dev *ae_dev)
 {
 	int ret;
 
@@ -87,23 +87,27 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 		return 0;
 	}
 
-	/* now, (un-)instantiate client by calling lower layer */
-	if (is_reg) {
-		ret = ae_dev->ops->init_client_instance(client, ae_dev);
-		if (ret)
-			dev_err(&ae_dev->pdev->dev,
-				"fail to instantiate client, ret = %d\n", ret);
+	ret = ae_dev->ops->init_client_instance(client, ae_dev);
+	if (ret)
+		dev_err(&ae_dev->pdev->dev,
+			"fail to instantiate client, ret = %d\n", ret);
 
-		return ret;
-	}
+	return ret;
+}
+
+static void hnae3_uninit_client_instance(struct hnae3_client *client,
+					 struct hnae3_ae_dev *ae_dev)
+{
+	/* check if this client matches the type of ae_dev */
+	if (!(hnae3_client_match(client->type, ae_dev->dev_type) &&
+	      hnae3_get_bit(ae_dev->flag, HNAE3_DEV_INITED_B)))
+		return;
 
 	if (hnae3_get_client_init_flag(client, ae_dev)) {
 		ae_dev->ops->uninit_client_instance(client, ae_dev);
 
 		hnae3_set_client_init_flag(client, ae_dev, 0);
 	}
-
-	return 0;
 }
 
 int hnae3_register_client(struct hnae3_client *client)
@@ -129,7 +133,7 @@ int hnae3_register_client(struct hnae3_client *client)
 		/* if the client could not be initialized on current port, for
 		 * any error reasons, move on to next available port
 		 */
-		ret = hnae3_match_n_instantiate(client, ae_dev, true);
+		ret = hnae3_init_client_instance(client, ae_dev);
 		if (ret)
 			dev_err(&ae_dev->pdev->dev,
 				"match and instantiation failed for port, ret = %d\n",
@@ -153,7 +157,7 @@ void hnae3_unregister_client(struct hnae3_client *client)
 	mutex_lock(&hnae3_common_lock);
 	/* un-initialize the client on every matched port */
 	list_for_each_entry(ae_dev, &hnae3_ae_dev_list, node) {
-		hnae3_match_n_instantiate(client, ae_dev, false);
+		hnae3_uninit_client_instance(client, ae_dev);
 	}
 
 	list_del(&client->node);
@@ -205,7 +209,7 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 		 * initialize the figure out client instance
 		 */
 		list_for_each_entry(client, &hnae3_client_list, node) {
-			ret = hnae3_match_n_instantiate(client, ae_dev, true);
+			ret = hnae3_init_client_instance(client, ae_dev);
 			if (ret)
 				dev_err(&ae_dev->pdev->dev,
 					"match and instantiation failed, ret = %d\n",
@@ -243,7 +247,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 		 * un-initialize the figure out client instance
 		 */
 		list_for_each_entry(client, &hnae3_client_list, node)
-			hnae3_match_n_instantiate(client, ae_dev, false);
+			hnae3_uninit_client_instance(client, ae_dev);
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
@@ -301,7 +305,7 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 	 * initialize the figure out client instance
 	 */
 	list_for_each_entry(client, &hnae3_client_list, node) {
-		ret = hnae3_match_n_instantiate(client, ae_dev, true);
+		ret = hnae3_init_client_instance(client, ae_dev);
 		if (ret)
 			dev_err(&ae_dev->pdev->dev,
 				"match and instantiation failed, ret = %d\n",
@@ -343,7 +347,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 			continue;
 
 		list_for_each_entry(client, &hnae3_client_list, node)
-			hnae3_match_n_instantiate(client, ae_dev, false);
+			hnae3_uninit_client_instance(client, ae_dev);
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
-- 
2.7.4

