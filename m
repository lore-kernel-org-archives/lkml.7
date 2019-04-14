Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF43C282E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B6E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfDNBtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:49:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbfDNBtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:49:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3EB41E2E555A0119C9E1;
        Sun, 14 Apr 2019 09:48:57 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Sun, 14 Apr 2019 09:48:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 07/12] net: hns3: always assume no drop TC for performance reason
Date:   Sun, 14 Apr 2019 09:47:41 +0800
Message-ID: <1555206466-44240-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
References: <1555206466-44240-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently RX shared buffer' threshold size for speific TC is
set to smaller value when the TC's PFC is not enabled, which may
cause performance problem because hardware may not have enough
hardware buffer when PFC is not enabled.

This patch sets the same threshold size for all TC no matter if
the specific TC's PFC is enabled.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 29 +++-------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0d1cd3f..7e7cdad 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1432,17 +1432,6 @@ static int hclge_get_tc_num(struct hclge_dev *hdev)
 	return cnt;
 }
 
-static int hclge_get_pfc_enalbe_num(struct hclge_dev *hdev)
-{
-	int i, cnt = 0;
-
-	for (i = 0; i < HCLGE_MAX_TC_NUM; i++)
-		if (hdev->hw_tc_map & BIT(i) &&
-		    hdev->tm_info.hw_pfc_map & BIT(i))
-			cnt++;
-	return cnt;
-}
-
 /* Get the number of pfc enabled TCs, which have private buffer */
 static int hclge_get_pfc_priv_num(struct hclge_dev *hdev,
 				  struct hclge_pkt_buf_alloc *buf_alloc)
@@ -1507,13 +1496,11 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 				u32 rx_all)
 {
 	u32 shared_buf_min, shared_buf_tc, shared_std;
-	int tc_num, pfc_enable_num;
+	int tc_num = hclge_get_tc_num(hdev);
 	u32 shared_buf, aligned_mps;
 	u32 rx_priv;
 	int i;
 
-	tc_num = hclge_get_tc_num(hdev);
-	pfc_enable_num = hclge_get_pfc_enalbe_num(hdev);
 	aligned_mps = roundup(hdev->mps, HCLGE_BUF_SIZE_UNIT);
 
 	if (hnae3_dev_dcb_supported(hdev))
@@ -1522,9 +1509,7 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 		shared_buf_min = aligned_mps + HCLGE_NON_DCB_ADDITIONAL_BUF
 					+ hdev->dv_buf_size;
 
-	shared_buf_tc = pfc_enable_num * aligned_mps +
-			(tc_num - pfc_enable_num) * aligned_mps / 2 +
-			aligned_mps;
+	shared_buf_tc = tc_num * aligned_mps + aligned_mps;
 	shared_std = roundup(max_t(u32, shared_buf_min, shared_buf_tc),
 			     HCLGE_BUF_SIZE_UNIT);
 
@@ -1546,14 +1531,8 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 	}
 
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
-		if ((hdev->hw_tc_map & BIT(i)) &&
-		    (hdev->tm_info.hw_pfc_map & BIT(i))) {
-			buf_alloc->s_buf.tc_thrd[i].low = aligned_mps;
-			buf_alloc->s_buf.tc_thrd[i].high = 2 * aligned_mps;
-		} else {
-			buf_alloc->s_buf.tc_thrd[i].low = 0;
-			buf_alloc->s_buf.tc_thrd[i].high = aligned_mps;
-		}
+		buf_alloc->s_buf.tc_thrd[i].low = aligned_mps;
+		buf_alloc->s_buf.tc_thrd[i].high = 2 * aligned_mps;
 	}
 
 	return true;
-- 
2.7.4

