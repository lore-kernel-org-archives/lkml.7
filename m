Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427ACC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1925A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922047;
	bh=Hn5IxzR4qi7mZNzsvBgm5nBI5/UaXLEBlJO5Qce3YHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmTT8x6I8qGDReVKovPsxwp0FxzNXdA5PPn95GSvQYxFePHRCP4b9m5TKogztOLSd
	 jCrnEhaim5/UmfKrR/yWswVP8tQ6VlyttF2l1/808n0HDOEdj9bMKuPo4UmlQie0sz
	 bFduhWADBjBnb3JjDrlxnnPGQsiTBCWUnlA80UgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfFGPkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbfFGPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:40:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F80A212F5;
        Fri,  7 Jun 2019 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922039;
        bh=Hn5IxzR4qi7mZNzsvBgm5nBI5/UaXLEBlJO5Qce3YHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/20rrOEdPwR3H7F9W65mqaXFQwCwoIP0cmDLl8h62zkqwfjhNke95FMyi/vbGQe/
         Hp8vu7UK6wcBeZ8EZaUgxQ2kTwKaz9ywB+lZEttJ2gjUZIhtbmgU7H0H8ZJ7ILXc6t
         fH5e1adIehNiW4oDZRCLa405X5aIaGA956TupxLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/69] net: mvpp2: fix bad MVPP2_TXQ_SCHED_TOKEN_CNTR_REG queue value
Date:   Fri,  7 Jun 2019 17:38:56 +0200
Message-Id: <20190607153850.174817877@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
References: <20190607153848.271562617@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 21808437214637952b61beaba6034d97880fbeb3 ]

MVPP2_TXQ_SCHED_TOKEN_CNTR_REG() expects the logical queue id but
the current code is passing the global tx queue offset, so it ends
up writing to unknown registers (between 0x8280 and 0x82fc, which
seemed to be unused by the hardware). This fixes the issue by using
the logical queue id instead.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4780,7 +4780,7 @@ static inline void mvpp2_xlg_max_rx_size
 /* Set defaults to the MVPP2 port */
 static void mvpp2_defaults_set(struct mvpp2_port *port)
 {
-	int tx_port_num, val, queue, ptxq, lrxq;
+	int tx_port_num, val, queue, lrxq;
 
 	if (port->priv->hw_version == MVPP21) {
 		/* Configure port to loopback if needed */
@@ -4802,11 +4802,9 @@ static void mvpp2_defaults_set(struct mv
 	mvpp2_write(port->priv, MVPP2_TXP_SCHED_CMD_1_REG, 0);
 
 	/* Close bandwidth for all queues */
-	for (queue = 0; queue < MVPP2_MAX_TXQ; queue++) {
-		ptxq = mvpp2_txq_phys(port->id, queue);
+	for (queue = 0; queue < MVPP2_MAX_TXQ; queue++)
 		mvpp2_write(port->priv,
-			    MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(ptxq), 0);
-	}
+			    MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(queue), 0);
 
 	/* Set refill period to 1 usec, refill tokens
 	 * and bucket size to maximum
@@ -5645,7 +5643,7 @@ static void mvpp2_txq_deinit(struct mvpp
 	txq->descs_dma         = 0;
 
 	/* Set minimum bandwidth for disabled TXQs */
-	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(txq->id), 0);
+	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(txq->log_id), 0);
 
 	/* Set Tx descriptors queue starting address and size */
 	cpu = get_cpu();


