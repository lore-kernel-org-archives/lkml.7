Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B5C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BECA24125
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468721;
	bh=fQ02JyQDkRWNpS/HDzUVnfKR46n40zNB008usY4M+uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibaUbsOIEq0zn2aJ/hromIwlFKyR6tuwp5mu0LOn04SzK8TM2HuXa/du27+tjPwzG
	 ORUIh53fIwovQSIaUlu32hKMKs02BIch5ZIx2tsfrpGlLgvVY61yNvSa5TqmNfI4pt
	 +u51RW8eq59U9lZqtNZ8+otuI4wuTqDBVz2Y8OtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfL0RpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfL0RpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892772464B;
        Fri, 27 Dec 2019 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468718;
        bh=fQ02JyQDkRWNpS/HDzUVnfKR46n40zNB008usY4M+uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ8qJScEWMQnnkE+WyUKMI2wicg/SfoOlGZEmLPIenOApQHZnwGUziCa7QXkWkAOf
         0s96gPekV6zCOf8ZRJ/PTPyOeI30H9jB5qwzp6mB9e1U8I3ohq54ZwWzcqa90wckdp
         z9stLNTXJZBXQfz8mdOo1K5APQQJkatI0ulB7f9M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 72/84] net: stmmac: Always arm TX Timer at end of transmission start
Date:   Fri, 27 Dec 2019 12:43:40 -0500
Message-Id: <20191227174352.6264-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 4772f26db8d1fb568c4862c538344a1b5fb52081 ]

If TX Coalesce timer is enabled we should always arm it, otherwise we
may hit the case where an interrupt is missed and the TX Queue will
timeout.

Arming the timer does not necessarly mean it will run the tx_clean()
because this function is wrapped around NAPI launcher.

Fixes: 9125cdd1be11 ("stmmac: add the initial tx coalesce schema")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 437b1b2b3e6b..7ee0e46539c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2997,6 +2997,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+	stmmac_tx_timer_arm(priv, queue);
 
 	return NETDEV_TX_OK;
 
@@ -3210,6 +3211,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_q->tx_tail_addr = tx_q->dma_tx_phy + (tx_q->cur_tx * sizeof(*desc));
 	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, queue);
+	stmmac_tx_timer_arm(priv, queue);
 
 	return NETDEV_TX_OK;
 
-- 
2.20.1

