Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41533C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6BD20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413202;
	bh=HJIMmg4bFMw3QQFQHg2hsidB0buLvQM3GwFp4muuUxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=clCbRtgNYOsFN3ud9Ui+d4KP011HvvzKkRDHx/gAJzY4V8u6z6YmNG/7tRGW/Oo4D
	 5zd/k0MHnSlneuBdZ/fIMiwEBH9mEtR4v+X0jY+Kf87hGxklU3TgsX6/yvOTFysIKs
	 xrffP8QvnfgxHHz7Q2sWF4m9l2PMYTF6P2TWJzSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfLCWql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfLCWqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:46:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08AD2084B;
        Tue,  3 Dec 2019 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413195;
        bh=HJIMmg4bFMw3QQFQHg2hsidB0buLvQM3GwFp4muuUxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3pl4MxcVt+qevtUv35x29D/Mm8pz9Otwj5fblBbCkuLRgHurIZrkMq6so6Gr12Gu
         5URLE9qWKULNkq5TDfe/+cwzfoWECqEJq6zXb3LnIDcIcfbr4+Oso49RbLScnkB92F
         36Z9YOXnWjZm/p9TDp2cTX1PmIdSATdIswndyZl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/321] can: flexcan: increase error counters if skb enqueueing via can_rx_offload_queue_sorted() fails
Date:   Tue,  3 Dec 2019 23:31:40 +0100
Message-Id: <20191203223428.889570507@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 758124335a9dd649ab820bfb5b328170919ee7dc ]

The call to can_rx_offload_queue_sorted() may fail and return an error
(in the current implementation due to resource shortage). The passed skb
is consumed.

This patch adds incrementing of the appropriate error counters to let
the device statistics reflect that there's a problem.

Reported-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 581e84d8e2c89..bfe13c6627bed 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -566,6 +566,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -614,7 +615,9 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		dev->stats.rx_fifo_errors++;
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
@@ -627,6 +630,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	int flt;
 	struct can_berr_counter bec;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -658,7 +662,9 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		dev->stats.rx_fifo_errors++;
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
-- 
2.20.1



