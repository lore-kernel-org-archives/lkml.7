Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186A6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14202176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613487;
	bh=7I/A2Gv6FuvwnPeTtQRWUP+nBGtZ1qPYwGx36MZx0LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxFBgxk1uilzh45sC8B3SweFqeGpr0EPn4c2lb8gzl34fhElNgEpdS/jyxsRhpJOL
	 PmM3UD8kPnxBoCqgw8XLbjLbjvR5z29HLnzJABxCJffj7lmtfHgIiyuvgRDvG0HkdS
	 6uQD4dPL73m2FEE2RidHGfnW5otVq3sNxVSnduUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfLQULZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfLQULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:11:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5434206D7;
        Tue, 17 Dec 2019 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613484;
        bh=7I/A2Gv6FuvwnPeTtQRWUP+nBGtZ1qPYwGx36MZx0LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoSDTec7cudtWeEjbqeLh32nMlqsssjueRDSKUQuPzudxrYOq03Ka4MpYIRywrwG3
         y8zQaAWzm+AW1xOAP9n8MddJc1/3+n6GpbLRTA3aQSFGsHsGRO+cnU/rmooVapXt/4
         b0pgbYPZCfgZ8rss4T6kv2BOrdyVLkpo3ncRUw/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 05/37] net: ethernet: ti: cpsw: fix extra rx interrupt
Date:   Tue, 17 Dec 2019 21:09:26 +0100
Message-Id: <20191217200723.798238922@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 51302f77bedab8768b761ed1899c08f89af9e4e2 ]

Now RX interrupt is triggered twice every time, because in
cpsw_rx_interrupt() it is asked first and then disabled. So there will be
pending interrupt always, when RX interrupt is enabled again in NAPI
handler.

Fix it by first disabling IRQ and then do ask.

Fixes: 870915feabdc ("drivers: net: cpsw: remove disable_irq/enable_irq as irq can be masked from cpsw itself")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -890,8 +890,8 @@ static irqreturn_t cpsw_rx_interrupt(int
 {
 	struct cpsw_common *cpsw = dev_id;
 
-	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_RX);
 	writel(0, &cpsw->wr_regs->rx_en);
+	cpdma_ctlr_eoi(cpsw->dma, CPDMA_EOI_RX);
 
 	if (cpsw->quirk_irq) {
 		disable_irq_nosync(cpsw->irqs_table[0]);


