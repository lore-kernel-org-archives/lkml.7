Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C64EC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC25C205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEFCvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 22:51:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfEFCuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 22:50:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA5D628C2E200DECB266;
        Mon,  6 May 2019 10:50:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 10:50:11 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <nhorman@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: add counter for times RX pages gets allocated
Date:   Mon, 6 May 2019 10:48:43 +0800
Message-ID: <1557110932-683-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557110932-683-1-git-send-email-tanhuazhong@huawei.com>
References: <1557110932-683-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently, using "ethtool --statistics" can show how many time RX
page have been reused, but there is no counter for RX page not
being reused.

This patch adds non_reuse_pg counter to better debug the performance
issue, because it is hard to determine when the RX page is reused
or not if there is no such counter.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 4 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ff3c9f1..453fdf4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2315,6 +2315,10 @@ hns3_nic_alloc_rx_buffers(struct hns3_enet_ring *ring, int cleand_count)
 				break;
 			}
 			hns3_replace_buffer(ring, ring->next_to_use, &res_cbs);
+
+			u64_stats_update_begin(&ring->syncp);
+			ring->stats.non_reuse_pg++;
+			u64_stats_update_end(&ring->syncp);
 		}
 
 		ring_ptr_move_fw(ring, next_to_use);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f669412..9680a68 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -389,6 +389,7 @@ struct ring_stats {
 			u64 l2_err;
 			u64 l3l4_csum_err;
 			u64 rx_multicast;
+			u64 non_reuse_pg;
 		};
 	};
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 7256ed4..d1588ea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -49,6 +49,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 	HNS3_TQP_STAT("l2_err", l2_err),
 	HNS3_TQP_STAT("l3l4_csum_err", l3l4_csum_err),
 	HNS3_TQP_STAT("multicast", rx_multicast),
+	HNS3_TQP_STAT("non_reuse_pg", non_reuse_pg),
 };
 
 #define HNS3_RXQ_STATS_COUNT ARRAY_SIZE(hns3_rxq_stats)
-- 
2.7.4

