Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F055C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D32208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dr1Eb0RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfHLL2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17332 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d6e0001>; Mon, 12 Aug 2019 04:28:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:28:44 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:43 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:43 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d680000>; Mon, 12 Aug 2019 04:28:43 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shardar Shariff Md" <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 02/14] serial: tegra: add support to ignore read
Date:   Mon, 12 Aug 2019 16:58:11 +0530
Message-ID: <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609326; bh=zpw7TSCQ2PhiK+cGW6njf70OBmHI80wFy8FT5HgbPvA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dr1Eb0RH/DE68qvQ8DyqbnAs4EfQ1GVAD1EtDndlCrVNj9QP/+ewgMbWCdTExZvkE
         vIBoF6e6Fuh2LrDwgQhQWBbUD6rbJ7JqokCrs0FX1dmwmhHudix4hutIefc3stxTuT
         8+ZpZN4ahWPhOMOUu15HlS5Rst70VXLmVG5zdAMEamjhgZwy3SAXgsEtWXfUTEZtEi
         pJUnQJn/Sux3QOf3/KLv4aZ17FC742I+RfUuvagRQRviXSama4IiOkIyV1HIti8Ohd
         NM8GW6lFEbJmJvQkVd3sQ558FkCrFE3Y3/ug1zr5wkfK5URMUlIJkUhapyKEgZdKtN
         qvzSN8Tdkb/JQ==
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
index 19f4c24..93d299e 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -542,6 +542,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 		ch = (unsigned char) tegra_uart_read(tup, UART_RX);
 		tup->uport.icount.rx++;
 
+		if (tup->uport.ignore_status_mask & UART_LSR_DR)
+			continue;
+
 		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
 			tty_insert_flip_char(tty, ch, flag);
 	} while (1);
@@ -562,6 +565,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
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
@@ -1190,6 +1197,11 @@ static void tegra_uart_set_termios(struct uart_port *u,
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

