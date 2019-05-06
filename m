Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6200C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892DF20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154311;
	bh=cwAnhsjms5JETVrm8lBnIu77/bq24kiXauUNJlo/6dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JIl2FCfdOjt0SKQOOT84i8NTBbGxQgaOv9W6DAlFjsFozYTSXGPkZOH1fckvu+tKK
	 k57LhzMLWhnTI5o8EiWv0TxcD/C1eZikU0cvsJn0SOK9ZsQjwSwlflg7BYKp1d1sGb
	 UWjPVycB2TVZwBUypA+U9MP6YUuxG9k7LzI9U31o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfEFOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbfEFOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:48:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D93216B7;
        Mon,  6 May 2019 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154122;
        bh=cwAnhsjms5JETVrm8lBnIu77/bq24kiXauUNJlo/6dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tq9bb0NuKroikxPBcGMse/5Igze2MiMaWh8K/yZ9b2NsbuEU+b1RpfQSJdlVBOBxd
         74kJUE3BDe6UPNvoxM4d5glvchjRXRujSKf3qpUGzk9Y2CnEx/Rp3LgINPB38UFOB9
         bRH65aTQGqUoNo/tmMWhbB//jtipN0HnAgUQum2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liubin Shu <shuliubin@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 46/62] net: hns: fix KASAN: use-after-free in hns_nic_net_xmit_hw()
Date:   Mon,  6 May 2019 16:33:17 +0200
Message-Id: <20190506143055.229546324@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index ad8681cf5ef0..f77578a5ea9d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -375,8 +375,6 @@ netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
 	wmb(); /* commit all data before submit */
 	assert(skb->queue_mapping < priv->ae_handle->q_num);
 	hnae_queue_xmit(priv->ae_handle->qs[skb->queue_mapping], buf_num);
-	ring->stats.tx_pkts++;
-	ring->stats.tx_bytes += skb->len;
 
 	return NETDEV_TX_OK;
 
@@ -916,6 +914,9 @@ static int hns_nic_tx_poll_one(struct hns_nic_ring_data *ring_data,
 		/* issue prefetch for next Tx descriptor */
 		prefetch(&ring->desc_cb[ring->next_to_clean]);
 	}
+	/* update tx ring statistics. */
+	ring->stats.tx_pkts += pkts;
+	ring->stats.tx_bytes += bytes;
 
 	NETIF_TX_UNLOCK(ndev);
 
-- 
2.20.1



