Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179C23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102626;
	bh=EuMjjEGx2MFzb26c4JDylJlINgym/vHqNxNZSc+0fw8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zLgd+/zJ/KX2ILyaNphgdvSw3VTSnBNZAr4O+mFndmwYPeUM4OWHah2sINgSmfB8+
	 7x6qvN6JdJmWe4T8KuLEhUaURYTi7FX9ZwLgER/FtrSbQryo/BF/e8t8saDMR9lntC
	 EfCrjpmQSspU8K16c+glxPJeutK3DWcOOW1/99Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfH2SRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfH2SQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4832189D;
        Thu, 29 Aug 2019 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102617;
        bh=EuMjjEGx2MFzb26c4JDylJlINgym/vHqNxNZSc+0fw8=;
        h=From:To:Cc:Subject:Date:From;
        b=ho69awwU9GzUoCPUeuhMmiWhalO1yaQydHOyQ2GeH5yIirTLQCKRQTD5oANXvLvi2
         v9JQU+Ij9sX4xd+HS1Dq7/+0ObmsunoncoOGVxsHkCcldoRb1arJCsEhiHRdf1yt1s
         gCQ1NTe+fbC4JDYk9qrdhFlPoa1kM+fEWwualiAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/27] net: tundra: tsi108: use spin_lock_irqsave instead of spin_lock_irq in IRQ context
Date:   Thu, 29 Aug 2019 14:16:27 -0400
Message-Id: <20190829181655.8741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>

[ Upstream commit 8c25d0887a8bd0e1ca2074ac0c6dff173787a83b ]

As spin_unlock_irq will enable interrupts.
Function tsi108_stat_carry is called from interrupt handler tsi108_irq.
Interrupts are enabled in interrupt handler.
Use spin_lock_irqsave/spin_unlock_irqrestore instead of spin_(un)lock_irq
in IRQ context to avoid this.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/tundra/tsi108_eth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index c2d15d9c0c33b..455979e47424c 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -381,9 +381,10 @@ tsi108_stat_carry_one(int carry, int carry_bit, int carry_shift,
 static void tsi108_stat_carry(struct net_device *dev)
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
+	unsigned long flags;
 	u32 carry1, carry2;
 
-	spin_lock_irq(&data->misclock);
+	spin_lock_irqsave(&data->misclock, flags);
 
 	carry1 = TSI_READ(TSI108_STAT_CARRY1);
 	carry2 = TSI_READ(TSI108_STAT_CARRY2);
@@ -451,7 +452,7 @@ static void tsi108_stat_carry(struct net_device *dev)
 			      TSI108_STAT_TXPAUSEDROP_CARRY,
 			      &data->tx_pause_drop);
 
-	spin_unlock_irq(&data->misclock);
+	spin_unlock_irqrestore(&data->misclock, flags);
 }
 
 /* Read a stat counter atomically with respect to carries.
-- 
2.20.1

