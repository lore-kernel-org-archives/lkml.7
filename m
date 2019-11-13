Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2209C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBBB2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573612119;
	bh=fCpRbnO/C4K2SYmAOtHa5kjvmeYmsk7heKkZ5Wjfqeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iOJh75tpWTLYVw6npYgqcpUkQaqTBmupulND7Hklf8rNxvICh0dC+3boZq1Eu1c+m
	 gie6TZZXUa8yGXju6WM3uctAHZ1RhQX5UnpE/cOk8LfZCNWAiFLRvAmlzenvwqCvb0
	 NVN0gHdJz8jdS5ZMC4h9E4aLbb1o9S5I4cbStmv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKMBub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfKMBu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:50:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96639222CA;
        Wed, 13 Nov 2019 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609828;
        bh=fCpRbnO/C4K2SYmAOtHa5kjvmeYmsk7heKkZ5Wjfqeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2dp5JOA9Z0kS4nOQHzLoPMDm7QuaY2DYM15m+m0K1Rf/SxHYTRoaxmrjo/JjiCb5
         0Lf4Nte8EjiYjG7mWlLXQIG8cWXjFiVGNelfjwAvLd2pgKxdZh3w+UiBusg8sX4zkt
         5MO9ct6N9paFt1uU459CR9kFnFkXszIWQOxZrG44=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Wei Liu <wei.liu2@citrix.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 002/209] net: xen-netback: fix return type of ndo_start_xmit function
Date:   Tue, 12 Nov 2019 20:46:58 -0500
Message-Id: <20191113015025.9685-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit a9ca7f17c6d240e269a24cbcd76abf9a940309dd ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netback/interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 27b6b141cb71f..4cafc31b98b7c 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -173,7 +173,8 @@ static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
 				[skb_get_hash_raw(skb) % size];
 }
 
-static int xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xenvif *vif = netdev_priv(dev);
 	struct xenvif_queue *queue = NULL;
-- 
2.20.1

