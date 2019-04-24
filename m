Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996BC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C397218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117552;
	bh=qkHgnlvZr45MQfkI542aNb2Ev68iyb3su3qFtVj6As0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y0FjPRsZv/4qvQRIZJSrmdT2BV9jOla5B7tj3elsvdMcC2nBWMlozz9P+AeCDZuUL
	 D4ceLxFWIg8MScC+hkfwNucj6FOXfDx8zx2oeszaR/TV4aLCLms8os4WEwmGN/FSsk
	 qjEocR9y6/uObc7BThW38BQ54qgect9XDoVovqcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfDXOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732943AbfDXOwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:52:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46576218FD;
        Wed, 24 Apr 2019 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117542;
        bh=qkHgnlvZr45MQfkI542aNb2Ev68iyb3su3qFtVj6As0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QS5Oy+Kt4Hmg+cn1wupYTMyULvFVbnI2M8UlSWY8Prh1GlDuANE2kpwKgx9xATlar
         eCkmXo8ek3G7ExRzS+Fb8YUuXyf9sfH/JG+ScC/qn5Apm9LBg6kd7W13c2iPfYO4yZ
         Fz/Tnfot3igEyjGk6pOGAEohqGk47qOu1TMp272U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/15] net: hns: Use NAPI_POLL_WEIGHT for hns driver
Date:   Wed, 24 Apr 2019 10:51:47 -0400
Message-Id: <20190424145152.31351-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145152.31351-1-sashal@kernel.org>
References: <20190424145152.31351-1-sashal@kernel.org>
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
index 2fa54b0b0679..6d649e7b45a9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -28,9 +28,6 @@
 
 #define SERVICE_TIMER_HZ (1 * HZ)
 
-#define NIC_TX_CLEAN_MAX_NUM 256
-#define NIC_RX_CLEAN_MAX_NUM 64
-
 #define RCB_IRQ_NOT_INITED 0
 #define RCB_IRQ_INITED 1
 
@@ -1408,7 +1405,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 		rd->fini_process = hns_nic_tx_fini_pro;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_TX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 	for (i = h->q_num; i < h->q_num * 2; i++) {
@@ -1420,7 +1417,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 		rd->fini_process = hns_nic_rx_fini_pro;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_RX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 
-- 
2.19.1

