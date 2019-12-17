Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC28206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613845;
	bh=7I/A2Gv6FuvwnPeTtQRWUP+nBGtZ1qPYwGx36MZx0LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+tyCFA1il3LE8yjL6m2wU7J1F8nL9QtYgSggwtsChCZz3eHt+zsTLqotDDyyj+C9
	 P3poDUfmDcRaBTWFF5rP7XlbPrVTF/HxM8UZFUigCVQgOSNmS4SjpSTrR1YUYPUqUy
	 yo2w6AoWDcvgV0XomxMe9QTf1+hEWYmUwVDYA6cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfLQURZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfLQURW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:17:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6AE21775;
        Tue, 17 Dec 2019 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613842;
        bh=7I/A2Gv6FuvwnPeTtQRWUP+nBGtZ1qPYwGx36MZx0LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zjkhR5VxbS/9tPGHU4tnAlFJSZY858/v94zzTz/Tem5bpmXHVKwuxxjrhnQ5Sw+Ot
         8wldtg+fhPYixZkI2Qk/TbE31rylxtxEbhlQTfyKv/mI+XR3ykTzA+WWKkBImB1WPz
         +IVRQw7XIXE++/23gtMLxHy+QAZlQHh+SrUUXnL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 05/25] net: ethernet: ti: cpsw: fix extra rx interrupt
Date:   Tue, 17 Dec 2019 21:16:04 +0100
Message-Id: <20191217200905.642350955@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200903.179327435@linuxfoundation.org>
References: <20191217200903.179327435@linuxfoundation.org>
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


