Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28595C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F32073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDKM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:27:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfDKM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30B0592564D0BF429361;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:34 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: divide shared buffer between TC
Date:   Thu, 11 Apr 2019 20:25:27 +0800
Message-ID: <1554985531-1827-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently hardware may have not enough buffer to receive packet
when it has used more than two MPS(maximum packet size) of
buffer, but there are still a lot of shared buffer left unused
when TC num is small.

This patch divides shared buffer to be used between TC when
the port supports DCB, and adjust the wateline and thredhold
according to user manual for the port that does not support
DCB.

This patch also change hclge_get_tc_num's return type to u32
to avoid signed-unsigned mix with divide.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5926016..709099a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1422,7 +1422,7 @@ static int hclge_tx_buffer_alloc(struct hclge_dev *hdev,
 	return ret;
 }
 
-static int hclge_get_tc_num(struct hclge_dev *hdev)
+static u32 hclge_get_tc_num(struct hclge_dev *hdev)
 {
 	int i, cnt = 0;
 
@@ -1495,8 +1495,8 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 				struct hclge_pkt_buf_alloc *buf_alloc,
 				u32 rx_all)
 {
-	u32 shared_buf_min, shared_buf_tc, shared_std;
-	int tc_num = hclge_get_tc_num(hdev);
+	u32 shared_buf_min, shared_buf_tc, shared_std, hi_thrd, lo_thrd;
+	u32 tc_num = hclge_get_tc_num(hdev);
 	u32 shared_buf, aligned_mps;
 	u32 rx_priv;
 	int i;
@@ -1526,13 +1526,26 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 	} else {
 		buf_alloc->s_buf.self.high = aligned_mps +
 						HCLGE_NON_DCB_ADDITIONAL_BUF;
-		buf_alloc->s_buf.self.low =
-			roundup(aligned_mps / 2, HCLGE_BUF_SIZE_UNIT);
+		buf_alloc->s_buf.self.low = aligned_mps;
+	}
+
+	if (hnae3_dev_dcb_supported(hdev)) {
+		if (tc_num)
+			hi_thrd = (shared_buf - hdev->dv_buf_size) / tc_num;
+		else
+			hi_thrd = shared_buf - hdev->dv_buf_size;
+
+		hi_thrd = max_t(u32, hi_thrd, 2 * aligned_mps);
+		hi_thrd = rounddown(hi_thrd, HCLGE_BUF_SIZE_UNIT);
+		lo_thrd = hi_thrd - aligned_mps / 2;
+	} else {
+		hi_thrd = aligned_mps + HCLGE_NON_DCB_ADDITIONAL_BUF;
+		lo_thrd = aligned_mps;
 	}
 
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
-		buf_alloc->s_buf.tc_thrd[i].low = aligned_mps;
-		buf_alloc->s_buf.tc_thrd[i].high = 2 * aligned_mps;
+		buf_alloc->s_buf.tc_thrd[i].low = lo_thrd;
+		buf_alloc->s_buf.tc_thrd[i].high = hi_thrd;
 	}
 
 	return true;
-- 
2.7.4

