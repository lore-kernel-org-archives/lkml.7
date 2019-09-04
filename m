Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E845C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A652087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C3QUAcAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfIDEnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:43:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7308 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40eb0000>; Tue, 03 Sep 2019 21:43:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:20 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:19 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40e40006>; Tue, 03 Sep 2019 21:43:19 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 01/12] serial: tegra: add support to ignore read
Date:   Wed, 4 Sep 2019 10:12:56 +0530
Message-ID: <1567572187-29820-2-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572203; bh=rvdELilOlZ/dP5Mxngi1Fe/3ok5haQDWkHnyX1em8eM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=C3QUAcAxXjJkCHmckEGVn5XgYuxqCESS9RmToIRuW8x0+mcMdNTqE7ac1/gWa1dor
         PDV34HxuOI54OrNZ5+gTe1Jujx5CSwciKHwWIXojr2cKfrhw0kNu8pKnnF7tXs0l89
         utQxfEE/+G+lC/LD5kGIAQ82W3yvquIuyHDYciqDs8f7uwMuzRPhK9Kw8IuCE9pqf0
         /E58tAmLgG/QFlzmyr+lb/ojqpIp00FkMAYMgeQz5UyAM0bfTvlkpZfm1xzTAYaH/+
         pCCQeQfFEAXjVUqXz7QKoTvriwQ/glxrgfNuu2s9NjLjQ7TfdUaJHgB5+ukTNBuCeR
         ht4NT1RY7sIug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Add support to ignore read characters if CREAD flag is not set.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 82a8d51..9c15c87 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -547,6 +547,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 
 		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
 			tty_insert_flip_char(tty, ch, flag);
+
+		if (tup->uport.ignore_status_mask & UART_LSR_DR)
+			continue;
 	} while (1);
 }
 
@@ -565,6 +568,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 		dev_err(tup->uport.dev, "No tty port\n");
 		return;
 	}
+
+	if (tup->uport.ignore_status_mask & UART_LSR_DR)
+		return;
+
 	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
 				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
 	copied = tty_insert_flip_string(tty,
@@ -1193,6 +1200,11 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 
+	tup->uport.ignore_status_mask = 0;
+	/* Ignore all characters if CREAD is not set */
+	if ((termios->c_cflag & CREAD) == 0)
+		tup->uport.ignore_status_mask |= UART_LSR_DR;
+
 	spin_unlock_irqrestore(&u->lock, flags);
 }
 
-- 
2.7.4

