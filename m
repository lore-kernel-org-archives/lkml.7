Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7312AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413512068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414665;
	bh=plkKtLAsyDuFJg/YpcbFdJkboKAp8rYwkIi9sDfq+jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vj3ezwCMlYLWjCuEyqBGlC7xsJvriZK8PxpBVgZMQpblNGp1OXe84IykLv6q4WPcS
	 yB48EF6JCpZM04n6wsQZT2uAp3i4IiY1pa9bh+sdVwLkxWcRLaSfYuTfb/Hp+75beN
	 3hHpLojjdb3XM0dy0coL+2laPbMDkUA0UBKYOmWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfLCXLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfLCWlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25AE20684;
        Tue,  3 Dec 2019 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412899;
        bh=plkKtLAsyDuFJg/YpcbFdJkboKAp8rYwkIi9sDfq+jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLyp/TnhBhbDmQ98czl1PnLXXrb0VyxZGE+vKdVwldvvJOBc4deX0ldK4+qXUONXV
         PXM06ZX6upgMuRufy/J0sjbZIKvfOmHAktIuKgcbxr0O7BTzDTLfH+QIZbiu2LcCzJ
         94ogWlwDdtKmaJGBREOaGfxO4IQuUM8No6PYw6Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 059/135] can: flexcan: increase error counters if skb enqueueing via can_rx_offload_queue_sorted() fails
Date:   Tue,  3 Dec 2019 23:34:59 +0100
Message-Id: <20191203213021.829145542@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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
index 56fa98d7aa90c..a4f0fa94d136a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -658,6 +658,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -706,7 +707,9 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		dev->stats.rx_fifo_errors++;
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
@@ -719,6 +722,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	int flt;
 	struct can_berr_counter bec;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -750,7 +754,9 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
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



