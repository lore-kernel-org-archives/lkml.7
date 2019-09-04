Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DEC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590E1233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kEbuzFcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfIDEn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:43:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2813 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40ed0000>; Tue, 03 Sep 2019 21:43:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:24 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:24 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:23 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40e80001>; Tue, 03 Sep 2019 21:43:23 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ahung Cheng <ahcheng@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH V2 02/12] serial: tegra: avoid reg access when clk disabled
Date:   Wed, 4 Sep 2019 10:12:57 +0530
Message-ID: <1567572187-29820-3-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572205; bh=PZ59Mpf8sr8yOSmoLunP2q8kB0Wcyq2pk6q6TcYRovs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kEbuzFcIKys2WCgf8BevrYmtCkSgoa9I8IYFIVb6NyIfnxUUTbwldkKKwU5JYx4Za
         6JTJ42kPR5F6l0UaryupFw8jJzHxKuO50dXnRy2kM0xMjKTRMQjFwA0moFvNLPmJz7
         Sx/g8NpqwDESchrgiobxdaLbYfL+6MYiT1RaBbk1buBjLQueRsLZh199tQlHDdd1J0
         +1bWO4PJX1AQJHiAWLbX7LmY1GusPf6uCwe7Dj8BkPTriB6TIdHiB0/7KtLzbtXHDC
         IMOEuM9C0JdbsYC8LyWklKLWgw0yiaMmA/O7Bt2jGbSLAo8K7bL+QfKplSJrCEvQ04
         rxJYSE76StW4A==
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
index 9c15c87..29bf7b7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -126,6 +126,8 @@ struct tegra_uart_port {
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
 static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
+static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
+					bool dma_to_memory);
 
 static inline unsigned long tegra_uart_read(struct tegra_uart_port *tup,
 		unsigned long reg)
@@ -461,6 +463,9 @@ static void tegra_uart_start_next_tx(struct tegra_uart_port *tup)
 	unsigned long count;
 	struct circ_buf *xmit = &tup->uport.state->xmit;
 
+	if (!tup->current_baud)
+		return;
+
 	tail = (unsigned long)&xmit->buf[xmit->tail];
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 	if (!count)
@@ -832,6 +837,12 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
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
 
@@ -1069,12 +1080,6 @@ static void tegra_uart_shutdown(struct uart_port *u)
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

