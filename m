Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7DFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330FA208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfF1LwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:52:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfF1LwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:52:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0BA32ECDF1E9B2DC181A;
        Fri, 28 Jun 2019 19:52:06 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 19:51:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: enable DCB when TC num is one and pfc_en is non-zero
Date:   Fri, 28 Jun 2019 19:50:08 +0800
Message-ID: <1561722618-12168-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561722618-12168-1-git-send-email-tanhuazhong@huawei.com>
References: <1561722618-12168-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently when TC num is one, the DCB will be disabled no matter if
pfc_en is non-zero or not.

This patch enables the DCB if pfc_en is non-zero, even when TC num
is one.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c    |  2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 19 +++++++++++++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 1161361..bac4ce1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -325,6 +325,8 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	hdev->tm_info.hw_pfc_map = pfc_map;
 	hdev->tm_info.pfc_en = pfc->pfc_en;
 
+	hclge_tm_pfc_info_update(hdev);
+
 	return hclge_pause_setup_hw(hdev, false);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 9edae5f..cb2fb5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -597,8 +597,10 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 		hdev->tm_info.prio_tc[i] =
 			(i >= hdev->tm_info.num_tc) ? 0 : i;
 
-	/* DCB is enabled if we have more than 1 TC */
-	if (hdev->tm_info.num_tc > 1)
+	/* DCB is enabled if we have more than 1 TC or pfc_en is
+	 * non-zero.
+	 */
+	if (hdev->tm_info.num_tc > 1 || hdev->tm_info.pfc_en)
 		hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
 	else
 		hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
@@ -1388,6 +1390,19 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 	hclge_tm_schd_info_init(hdev);
 }
 
+void hclge_tm_pfc_info_update(struct hclge_dev *hdev)
+{
+	/* DCB is enabled if we have more than 1 TC or pfc_en is
+	 * non-zero.
+	 */
+	if (hdev->tm_info.num_tc > 1 || hdev->tm_info.pfc_en)
+		hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
+	else
+		hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
+
+	hclge_pfc_info_init(hdev);
+}
+
 int hclge_tm_init_hw(struct hclge_dev *hdev, bool init)
 {
 	int ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index f60e540..5150daa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -147,6 +147,7 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev, bool init);
 int hclge_tm_schd_setup_hw(struct hclge_dev *hdev);
 void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
 void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
+void hclge_tm_pfc_info_update(struct hclge_dev *hdev);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev, bool init);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
-- 
2.7.4

