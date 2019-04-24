Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31770C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E52175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfDXLHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:07:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbfDXLG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:06:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98A8120B47F0F7009D9D;
        Wed, 24 Apr 2019 19:06:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 19:06:44 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 12/12] net: hns3: remove reset after command send failed
Date:   Wed, 24 Apr 2019 19:05:31 +0800
Message-ID: <1556103931-64031-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
References: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

It's meaningless to trigger reset when failed to send command to IMP,
because the failure is usually caused by no authority, illegal command
and so on. When that happened, we just need to return the status code
for further debugging.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 804c870..4ac8063 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1653,8 +1653,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	if (ret) {
 		dev_err(dev, "fail(%d) to query msix int status bd num\n",
 			ret);
-		/* reset everything for now */
-		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 		return ret;
 	}
 
@@ -1675,8 +1673,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	if (ret) {
 		dev_err(dev, "query all mpf msix int cmd failed (%d)\n",
 			ret);
-		/* reset everything for now */
-		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 		goto msi_error;
 	}
 
@@ -1710,8 +1706,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	if (ret) {
 		dev_err(dev, "clear all mpf msix int cmd failed (%d)\n",
 			ret);
-		/* reset everything for now */
-		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 		goto msi_error;
 	}
 
@@ -1725,8 +1719,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	if (ret) {
 		dev_err(dev, "query all pf msix int cmd failed (%d)\n",
 			ret);
-		/* reset everything for now */
-		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 		goto msi_error;
 	}
 
@@ -1767,8 +1759,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	if (ret) {
 		dev_err(dev, "clear all pf msix int cmd failed (%d)\n",
 			ret);
-		/* reset everything for now */
-		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 	}
 
 	/* query and clear mac tnl interruptions */
-- 
2.7.4

