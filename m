Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25BF20449
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154011;
	bh=EBWVdMCzEwKEHSELCT87BNA4jcDi3i7WepKdSep1mQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANSSywnpw5BXHIm4s20PpwzVYXZsR6TDm35IhArMpgYp7NtGkXMbPGy5jXCt6hLZt
	 w1Jmgf1RGfg2WBzUgBThNjo9noDikZReC2FZcofg7sxqbD5bP+NNXFJR1+0zV+8LTj
	 Qh9esXMjU7yGz3D6fpxKI44ks3ICJ8QiSMHXSzdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfEFOqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbfEFOqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677C32053B;
        Mon,  6 May 2019 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154006;
        bh=EBWVdMCzEwKEHSELCT87BNA4jcDi3i7WepKdSep1mQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwHQCX6NTr0Pyv547jeDLZ4E5yIv3lwUNl91583fZFT424rgMK5vvcN/es811/Aiw
         jz5YxP/P50ZoHK1MnUJvhV64Ew3wFWQgxxDORrG/LIhLMkkkBrE3yIAvfZpTBZTAB8
         OyE+T/MtnMGNYpI4EVHf5jGxd4gw0zfN5KUSMyeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 48/75] net: hns: Use NAPI_POLL_WEIGHT for hns driver
Date:   Mon,  6 May 2019 16:32:56 +0200
Message-Id: <20190506143057.571060089@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 15739eae3da1..8fd040817804 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -29,9 +29,6 @@
 
 #define SERVICE_TIMER_HZ (1 * HZ)
 
-#define NIC_TX_CLEAN_MAX_NUM 256
-#define NIC_RX_CLEAN_MAX_NUM 64
-
 #define RCB_IRQ_NOT_INITED 0
 #define RCB_IRQ_INITED 1
 #define HNS_BUFFER_SIZE_2048 2048
@@ -2270,7 +2267,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 			hns_nic_tx_fini_pro_v2;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_TX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 	for (i = h->q_num; i < h->q_num * 2; i++) {
@@ -2283,7 +2280,7 @@ static int hns_nic_init_ring_data(struct hns_nic_priv *priv)
 			hns_nic_rx_fini_pro_v2;
 
 		netif_napi_add(priv->netdev, &rd->napi,
-			       hns_nic_common_poll, NIC_RX_CLEAN_MAX_NUM);
+			       hns_nic_common_poll, NAPI_POLL_WEIGHT);
 		rd->ring->irq_init_flag = RCB_IRQ_NOT_INITED;
 	}
 
-- 
2.20.1



