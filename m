Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A148C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032852171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDDIUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:20:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728799AbfDDITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:19:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EB0D5F73CEBD8232B622;
        Thu,  4 Apr 2019 16:19:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:19:04 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <sergei.shtylyov@cogentembedded.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 05/12] net: hns3: minor optimization for ring_space
Date:   Thu, 4 Apr 2019 16:17:52 +0800
Message-ID: <1554365879-7932-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554365879-7932-1-git-send-email-tanhuazhong@huawei.com>
References: <1554365879-7932-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch optimizes the ring_space by calculating the
ring space without calling ring_dist.

Also ring_dist is only used by ring_space, so this patch
removes it when it is no longer used.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 75669cd..025d0f7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -577,18 +577,13 @@ union l4_hdr_info {
 	unsigned char *hdr;
 };
 
-/* the distance between [begin, end) in a ring buffer
- * note: there is a unuse slot between the begin and the end
- */
-static inline int ring_dist(struct hns3_enet_ring *ring, int begin, int end)
-{
-	return (end - begin + ring->desc_num) % ring->desc_num;
-}
-
 static inline int ring_space(struct hns3_enet_ring *ring)
 {
-	return ring->desc_num -
-		ring_dist(ring, ring->next_to_clean, ring->next_to_use) - 1;
+	int begin = ring->next_to_clean;
+	int end = ring->next_to_use;
+
+	return ((end >= begin) ? (ring->desc_num - end + begin) :
+			(begin - end)) - 1;
 }
 
 static inline int is_ring_empty(struct hns3_enet_ring *ring)
-- 
2.7.4

