Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D09C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224CF21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116541;
	bh=cOKvPzehnVnEMJW+UX/DD7QdnrvrvJ+njfuVMeYqVMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jw5CYysPYRqokk3pd+W1PyPau5wAH7wlLsvZzdKYf1XkQ9zcG04Q/IbgUCBqdbLic
	 TWD5t2CeuLeRurD9kqw//WlY7sJYJWiFUApmJmzWQ6QInhxGF7aGkZBCBHZAxaQYoJ
	 tw6CaAOW8JP/jc2VIvOQtxCMw3dCIVYvGS+UwF2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfDXOfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfDXOfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679C421900;
        Wed, 24 Apr 2019 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116536;
        bh=cOKvPzehnVnEMJW+UX/DD7QdnrvrvJ+njfuVMeYqVMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg4+pHDFQvzKifjMMXqgwpOQHjsheMpvGPKLNTISM4Tzo4T9nABeRg65jo/Eg7cJH
         1ALj3L/hS+KtXDYmGAPgDoe90pVDujdg3qPKSVI4/aHAylMRJc+0UTBj0EdQOo253a
         rOKz/qbRFxVrDUUL5WVHq/FLwVhLQ6RW6pRIHbFA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liubin Shu <shuliubin@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 46/66] net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()
Date:   Wed, 24 Apr 2019 10:33:20 -0400
Message-Id: <20190424143341.27665-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liubin Shu <shuliubin@huawei.com>

[ Upstream commit 3a39a12ad364a9acd1038ba8da67cd8430f30de4 ]

This patch is trying to fix the issue due to:
[27237.844750] BUG: KASAN: use-after-free in hns_nic_net_xmit_hw+0x708/0xa18[hns_enet_drv]

After hnae_queue_xmit() in hns_nic_net_xmit_hw(), can be
interrupted by interruptions, and than call hns_nic_tx_poll_one()
to handle the new packets, and free the skb. So, when turn back to
hns_nic_net_xmit_hw(), calling skb->len will cause use-after-free.

This patch update tx ring statistics in hns_nic_tx_poll_one() to
fix the bug.

Signed-off-by: Liubin Shu <shuliubin@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 60e7d7ae3787..e5a7c0761dbd 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -376,8 +376,6 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 	wmb(); /* commit all data before submit */
 	assert(skb->queue_mapping < priv->ae_handle->q_num);
 	hnae_queue_xmit(priv->ae_handle->qs[skb->queue_mapping], buf_num);
-	ring->stats.tx_pkts++;
-	ring->stats.tx_bytes += skb->len;
 
 	return NETDEV_TX_OK;
 
@@ -999,6 +997,9 @@ static int hns_nic_tx_poll_one(struct hns_nic_ring_data *ring_data,
 		/* issue prefetch for next Tx descriptor */
 		prefetch(&ring->desc_cb[ring->next_to_clean]);
 	}
+	/* update tx ring statistics. */
+	ring->stats.tx_pkts += pkts;
+	ring->stats.tx_bytes += bytes;
 
 	NETIF_TX_UNLOCK(ring);
 
-- 
2.19.1

