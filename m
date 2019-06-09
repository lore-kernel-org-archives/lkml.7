Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA39C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4E82070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099113;
	bh=SvWGAvkxgjmODqnVbmP7KfjW3rewC18TXRFmwzS63VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lfQlEmViMmCaO4UPOnC05ITV4u2D7+xdXkSQYzs9wUJe3lN0r5klfL/kpmUlpVsXA
	 2jsWXpJqhIOnELnjfi+a7zlfkFhv8ApbybF1swFw1jIkDiVo+bjsk+kLKMdbVE35Ll
	 eq1v2CSxoOY04S8UadmahL6QYLX40eyk3J1yHE1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfFIQvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732041AbfFIQvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:51:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B41C205ED;
        Sun,  9 Jun 2019 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099108;
        bh=SvWGAvkxgjmODqnVbmP7KfjW3rewC18TXRFmwzS63VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMI8z6A13Vw6aSvMFGm3YV64oufF3IABUQE3ZNY3ic1+IDSl32kahXLoHchyPmU3J
         i1VgxEhxCsbDBc2+LZz1RPZ/2BHq+zZxtQezVpqu72KlpdbLcOZnOYQSUql23jEo8s
         0BQgaPa+s8SZYno7120vBDnw5ls6f35FKbvI9uIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 13/83] net: mvpp2: fix bad MVPP2_TXQ_SCHED_TOKEN_CNTR_REG queue value
Date:   Sun,  9 Jun 2019 18:41:43 +0200
Message-Id: <20190609164128.650983310@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
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
@@ -3938,7 +3938,7 @@ static inline void mvpp2_gmac_max_rx_siz
 /* Set defaults to the MVPP2 port */
 static void mvpp2_defaults_set(struct mvpp2_port *port)
 {
-	int tx_port_num, val, queue, ptxq, lrxq;
+	int tx_port_num, val, queue, lrxq;
 
 	/* Configure port to loopback if needed */
 	if (port->flags & MVPP2_F_LOOPBACK)
@@ -3958,11 +3958,9 @@ static void mvpp2_defaults_set(struct mv
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
@@ -4709,7 +4707,7 @@ static void mvpp2_txq_deinit(struct mvpp
 	txq->descs_phys        = 0;
 
 	/* Set minimum bandwidth for disabled TXQs */
-	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(txq->id), 0);
+	mvpp2_write(port->priv, MVPP2_TXQ_SCHED_TOKEN_CNTR_REG(txq->log_id), 0);
 
 	/* Set Tx descriptors queue starting address and size */
 	mvpp2_write(port->priv, MVPP2_TXQ_NUM_REG, txq->id);


