Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D880E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103638;
	bh=HLY5Zfs3P3knoYqKm1BqmPQwJ3CmGXEce1/gN1ZH0bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NZAOhhM4JHWzE/AGGVcUyp7HQ9hyGV9/fxX0DcjTapmAehNtgdbbArXpt0DktORYE
	 1/ckLMCzk1x/HfMGhD0GcQ36x3RgmCz9kvZbnpJ3jy6bYf/sr73yTN+DZW29ORGt2y
	 r9/ljbrLBCQ/u4HHEf4EW4kr4UIR5vKvydYbxk9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfH2SNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfH2SNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB135233FF;
        Thu, 29 Aug 2019 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102414;
        bh=HLY5Zfs3P3knoYqKm1BqmPQwJ3CmGXEce1/gN1ZH0bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4NYKwECKMQv+4D1o6nWxvutBHo9crRhS5NOl2Fk7nhhdi6PAXbjIFa04/XNRUyrT
         r/fcjzr5cMFoOp11G9tP5PvvQHGcT3l89GZgIHTqY8ohncql2vHmDNDIRr/ovL3l0x
         BvT2Urq4xKGBFtD6upWHzU+8Z25q8GY9aeooGZjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 09/76] net: tundra: tsi108: use spin_lock_irqsave instead of spin_lock_irq in IRQ context
Date:   Thu, 29 Aug 2019 14:12:04 -0400
Message-Id: <20190829181311.7562-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
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
index 78a7de3fb622f..c62f474b6d08e 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -371,9 +371,10 @@ tsi108_stat_carry_one(int carry, int carry_bit, int carry_shift,
 static void tsi108_stat_carry(struct net_device *dev)
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
+	unsigned long flags;
 	u32 carry1, carry2;
 
-	spin_lock_irq(&data->misclock);
+	spin_lock_irqsave(&data->misclock, flags);
 
 	carry1 = TSI_READ(TSI108_STAT_CARRY1);
 	carry2 = TSI_READ(TSI108_STAT_CARRY2);
@@ -441,7 +442,7 @@ static void tsi108_stat_carry(struct net_device *dev)
 			      TSI108_STAT_TXPAUSEDROP_CARRY,
 			      &data->tx_pause_drop);
 
-	spin_unlock_irq(&data->misclock);
+	spin_unlock_irqrestore(&data->misclock, flags);
 }
 
 /* Read a stat counter atomically with respect to carries.
-- 
2.20.1

