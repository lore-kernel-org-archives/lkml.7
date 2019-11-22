Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91822C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D52071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419795;
	bh=mGM2iICIWnmG/JTWLsOe+qYgsPuoE13JMoQ2jwvaX3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ps+IMl19zQdQbG0qhY3ne6PCkNKPozdsTzryWUSzlQqpWmX68Y3+SlzUh5ZlpXGlq
	 3AZIvA4bBHulAtOjHu8Nu6n8xfzKAC1ipiHP5MyDi44YIcUVjDDeydrxtsoPyoJuxT
	 xN+ywN1jioNn6uze9CibcAkQpKHBepc1Z+cjdQzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfKVKty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfKVKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67BAD20872;
        Fri, 22 Nov 2019 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419788;
        bh=mGM2iICIWnmG/JTWLsOe+qYgsPuoE13JMoQ2jwvaX3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTXP2fiuYmvxF+8U7KgftWSly5w3l8a3FP5bc+h6d5D/YEPFIrxCip5ad+M9kj/Nc
         O2x51OwEzx5vs9pxAuRHPqwpPNoGUaeA5B7MsRp8pMIl9yTPHskP80BTztc8nQd5Kp
         47fUlUsmfxoH1ubKkhzZ3I6lShPTCwetu4+R4nJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/122] net: ovs: fix return type of ndo_start_xmit function
Date:   Fri, 22 Nov 2019 11:27:43 +0100
Message-Id: <20191122100729.788558530@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit eddf11e18dff0e8671e06ce54e64cfc843303ab9 ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/vport-internal_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 1c09ad457d2a9..1083b5e901349 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -44,7 +44,8 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
 }
 
 /* Called with rcu_read_lock_bh. */
-static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int len, err;
 
@@ -63,7 +64,7 @@ static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 	} else {
 		netdev->stats.tx_errors++;
 	}
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static int internal_dev_open(struct net_device *netdev)
-- 
2.20.1



