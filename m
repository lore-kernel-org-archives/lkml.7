Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF45C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FCD21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117477;
	bh=3EUCTPsbvTs0aEjsTrLmw6vNj/JmIjvc4x70ozzT7sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8nQ+9IAx6e0VyoETijf+thMekMbqwmwQcuxSK/sF6h/U4b1fbg80PmhkWIBhurSN
	 C4mCjAtHda8+fAGe2g8dIUoFpgMkhuzuX6rJFxvLw5YTB885f8lWhFhsqGo9t7yi/k
	 eWFaGi1RzvvZF8NaxHvWMaDVJsl8omTgVONPrcUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfDXOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732744AbfDXOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:51:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3D4218FD;
        Wed, 24 Apr 2019 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117470;
        bh=3EUCTPsbvTs0aEjsTrLmw6vNj/JmIjvc4x70ozzT7sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hquYoRwAwa2aUh8KQHnQhf7FW+Vj08rwsjGqgEKT6ovdQlVbyiPrvNKviLJhYg8AJ
         L9RcGUCbtv0p5uEtIhsuHzML8zaIK1R6YbFU0gd6KknU3RXQDQblZcYzEh3DgAlPaC
         lVnYmihcD8kMdWa/N7lfAYfbwUJURGs+V9y7ch5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/28] net: hns: Use NAPI_POLL_WEIGHT for hns driver
Date:   Wed, 24 Apr 2019 10:50:05 -0400
Message-Id: <20190424145012.30886-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit acb1ce15a61154aa501891d67ebf79bc9ea26818 ]

When the HNS driver loaded, always have an error print:
"netif_napi_add() called with weight 256"

This is because the kernel checks the NAPI polling weights
requested by drivers and it prints an error message if a driver
requests a weight bigger than 64.

So use NAPI_POLL_WEIGHT to fix it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index f77578a5ea9d..24a815997ec5 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -28,9 +28,6 @@
 
 #define SERVICE_TIMER_HZ (1 * HZ)
 
-#define NIC_TX_CLEAN_MAX_NUM 256
-#define NIC_RX_CLEAN_MAX_NUM 64
-
 #define RCB_IRQ_NOT_INITED 0
 #define RCB_IRQ_INITED 1
 #define HNS_BUFFER_SIZE_2048 2048
@@ -1822,7 +1819,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 			hns_nic_tx_fini_pro_v2;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_TX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 	for (i = h->q_num; i < h->q_num * 2; i++) {
@@ -1835,7 +1832,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 			hns_nic_rx_fini_pro_v2;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_RX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 
-- 
2.19.1

