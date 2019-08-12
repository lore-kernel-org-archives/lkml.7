Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86427C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F3D208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U4AiIbqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHLL2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:50 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18392 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d7a0001>; Mon, 12 Aug 2019 04:28:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:28:48 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:47 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d6c0000>; Mon, 12 Aug 2019 04:28:47 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ahung Cheng <ahcheng@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Date:   Mon, 12 Aug 2019 16:58:12 +0530
Message-ID: <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609339; bh=Ju0I1OjHLvuVSfB3vnK3kMoIM9Kz7fux7WW6Ri42sDI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=U4AiIbqYe1oxGBhux61fk5drh0Ud0gpfTxjrxTDRUw4t/3TMZmfh6mfAcJ3cDUJZX
         pO6pAxWBXhHd24fU+VC+wdP+YQU5SEoNZGQBCdNlWE9N8QFYkMl3gqDL69rZwTrNgR
         iKX50WSJ2fvt+iNsA8f8kQVoZv3RJfO65ZqiXfkgaEYG2qaXrJWvH/Dbw9IM6e7FEX
         Ms8ulgskomVco6bycHZNoLmtKC4+khCDlMD3/QISZSgda3oVqYrtBHEjxlRpMhYtr/
         eUFQ0WV9KyMGELrX1G5XFpcwaOlBeXSkGMh/FjnRk3NbrjfI81+0SOraM3E8Dkw98Y
         iDwVRFeDPDweg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahung Cheng <ahcheng@nvidia.com>

This avoids two race conditions from the UART shutdown sequence both
leading to 'Machine check error in AXI2APB' and kernel oops.

One was that the clock was disabled before the DMA was terminated making
it possible for the DMA callbacks to be called after the clock was
disabled. These callbacks could write to the UART registers causing
timeout.

The second was that the clock was disabled before the UART was
completely flagged as closed. This is done after the shutdown is called
and a new write could be started after the clock was disabled.
tegra_uart_start_pio_tx could be called causing timeout.

Given that the baud rate is reset at the end of shutdown sequence, this
fix is to examine the baud rate to avoid register access from both race
conditions.

Besides, terminate the DMA before disabling the clock.

Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
Signed-off-by: Shardar Mohammed <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 93d299e..d908465 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -126,6 +126,8 @@ struct tegra_uart_port {
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
 static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
+static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
+					bool dma_to_memory);
 
 static inline unsigned long tegra_uart_read(struct tegra_uart_port *tup,
 		unsigned long reg)
@@ -458,6 +460,9 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
 	unsigned long count;
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 
+	if (WARN_ON(!tup->current_baud))
+		return;
+
 	tail = (unsigned long)&xmit->buf[xmit->tail];
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	if (!count)
@@ -829,6 +834,12 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
 	tup->current_baud = 0;
 	spin_unlock_irqrestore(&tup->uport.lock, flags);
 
+	tup->rx_in_progress = 0;
+	tup->tx_in_progress = 0;
+
+	tegra_uart_dma_channel_free(tup, true);
+	tegra_uart_dma_channel_free(tup, false);
+
 	clk_disable_unprepare(tup->uart_clk);
 }
 
@@ -1066,12 +1077,6 @@ static void tegra_uart_shutdown(struct uart_port *u)
 	struct tegra_uart_port *tup = to_tegra_uport(u);
 
 	tegra_uart_hw_deinit(tup);
-
-	tup->rx_in_progress = 0;
-	tup->tx_in_progress = 0;
-
-	tegra_uart_dma_channel_free(tup, true);
-	tegra_uart_dma_channel_free(tup, false);
 	free_irq(u->irq, tup);
 }
 
-- 
2.7.4

