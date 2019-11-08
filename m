Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C347C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D162085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214668;
	bh=FReMmvb5mhGVKmc7T3QgYVpv0ScYqZMSvTTubSLgang=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E76y2+GZCQiK9hvzvdhMY6uAhrCMAk8r3sjn7hmK2yOqQwc+ARtSG5AMzKgfSS7KH
	 8Uhb2bLgHiPA0CDWOooULKDGr8lbQDGiBWGzN6VtnWug1kKYuLK+OUch3K971ryN/4
	 jR0VbBxRckY+67AsxGMZ1tv1L9g6coshNg7eOiio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfKHLmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389788AbfKHLmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8872521D7B;
        Fri,  8 Nov 2019 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213332;
        bh=FReMmvb5mhGVKmc7T3QgYVpv0ScYqZMSvTTubSLgang=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzWpkg6LnACP5D9D1IEmSd3xybTvZQDCUgMQ4uCbth5IU+P47/umtN2R6ougtyfeI
         S++XBPf4U7HebNsNcoOoW9pvaJYTTdEJVnHSJShJDYv7ikXNS9W/IDGZdvLZxISDEQ
         ZW1YuReiaRw0WUCJGEw8TV49PPUnsAxUu63/Mjq0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 171/205] MIPS: lantiq: Do not enable IRQs in dma open
Date:   Fri,  8 Nov 2019 06:37:18 -0500
Message-Id: <20191108113752.12502-171-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
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
index 664f2f7f55c1c..982859f2b2a38 100644
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
index e08301d833e2e..379db19a303c8 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -439,6 +439,7 @@ ltq_etop_open(struct net_device *dev)
 		if (!IS_TX(i) && (!IS_RX(i)))
 			continue;
 		ltq_dma_open(&ch->dma);
+		ltq_dma_enable_irq(&ch->dma);
 		napi_enable(&ch->napi);
 	}
 	phy_start(dev->phydev);
-- 
2.20.1

