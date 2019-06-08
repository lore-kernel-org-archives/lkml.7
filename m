Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F623C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DE21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994866;
	bh=ugI5JX4HZr8+/Im1/glR6HassMJ2Y0b18i4KJ2cZyTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HmwYPnwZU+61iERKh932laGSMjX+p0b6nH8jx54Pwnn2ImXZQqnNAEhJu20RDTO/j
	 m0y72GBFuRxBjZzD68F8KP8rTWYXvcUxmYQqOsSS7XarSOoCosYfV7Mxi5voWbGwzL
	 FUAW+fk8wga9ClwniBAJgSYk6rm+qCf9tmdwNj6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfFHLyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfFHLkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2CB214AF;
        Sat,  8 Jun 2019 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994032;
        bh=ugI5JX4HZr8+/Im1/glR6HassMJ2Y0b18i4KJ2cZyTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWAeCMSYQtxdI/vrj8OXYi8Kp5EBaaRwbMFMFjZY/V+ebjKJEh+hoZv1rymGaj2CN
         fF4vP1bovp0uVv6vZfgju3JrWXKGmhRgKxkwNYM9qZhfH7YkkmDbfCD4bCs0zr5k11
         7WzGlDXOaPSdWdjB1dfufUhbtjwgaZum5V2MMek4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biao Huang <biao.huang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 26/70] net: stmmac: update rx tail pointer register to fix rx dma hang issue.
Date:   Sat,  8 Jun 2019 07:39:05 -0400
Message-Id: <20190608113950.8033-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>

[ Upstream commit 4523a5611526709ec9b4e2574f1bb7818212651e ]

Currently we will not update the receive descriptor tail pointer in
stmmac_rx_refill. Rx dma will think no available descriptors and stop
once received packets exceed DMA_RX_SIZE, so that the rx only test will fail.

Update the receive tail pointer in stmmac_rx_refill to add more descriptors
to the rx channel, so packets can be received continually

Fixes: 54139cf3bb33 ("net: stmmac: adding multiple buffers for rx")
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3c409862c52e..8cebc44108b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3338,6 +3338,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		entry = STMMAC_GET_ENTRY(entry, DMA_RX_SIZE);
 	}
 	rx_q->dirty_rx = entry;
+	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
 }
 
 /**
-- 
2.20.1

