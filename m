Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30195222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213522;
	bh=7XFWGjzpQtz6PRzn1lFFoviMx4ObyncTWJNx3KXmWYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRB43Ay9N4SWtY8I57yKWLaSCcl99aSDta0Ku6czEgyd99a8qhqzK7oq3qkY3aw0H
	 VdYBnIo5Ldkczz8NtXDuWoBHq07n5Mx7U/YNVIVjAUg8IamB6ZQigsZsCo1PmzqWEc
	 DdvoG3hqJQpdtuu5IkBOAkhE1wp+v/YBPxr9ulJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfKHLpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391064AbfKHLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E3F20656;
        Fri,  8 Nov 2019 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213515;
        bh=7XFWGjzpQtz6PRzn1lFFoviMx4ObyncTWJNx3KXmWYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jE2ihDClaEycB46JyAnbXCyd4+25iej9ZhxatXf4HiVQhEhzQDoggAAI/y2JrsgdX
         0/3gPta+K9lz3HqQhnwzTIO5zfw4VcrkhTOqCC84+JAclHAiIsqhNFCmBYTR851I2I
         cHUQeal/PkVlpIS59nFzTQdXrYdu4VhDEFBwADiA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 085/103] MIPS: lantiq: Do not enable IRQs in dma open
Date:   Fri,  8 Nov 2019 06:42:50 -0500
Message-Id: <20191108114310.14363-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

[ Upstream commit cc973aecf0b0541918c5ecabe6c90d1f709b5f89 ]

When a DMA channel is opened the IRQ should not get activated
automatically, this allows it to pull data out manually without the help
of interrupts. This is needed for a workaround in the vrx200 Ethernet
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/lantiq/xway/dma.c        | 1 -
 drivers/net/ethernet/lantiq_etop.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 805b3a6ab2d60..dcc16d8de8c37 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -106,7 +106,6 @@ ltq_dma_open(struct ltq_dma_channel *ch)
 	spin_lock_irqsave(&ltq_dma_lock, flag);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(0, DMA_CHAN_ON, LTQ_DMA_CCTRL);
-	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
 	spin_unlock_irqrestore(&ltq_dma_lock, flag);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_open);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index afc8100694405..c978a857a25c2 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -438,6 +438,7 @@ ltq_etop_open(struct net_device *dev)
 		if (!IS_TX(i) && (!IS_RX(i)))
 			continue;
 		ltq_dma_open(&ch->dma);
+		ltq_dma_enable_irq(&ch->dma);
 		napi_enable(&ch->napi);
 	}
 	phy_start(dev->phydev);
-- 
2.20.1

