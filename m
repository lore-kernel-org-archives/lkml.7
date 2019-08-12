Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53859C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B09214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jVCm+sga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfHLL3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17358 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d7e0000>; Mon, 12 Aug 2019 04:29:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:28:59 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:59 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:59 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d770000>; Mon, 12 Aug 2019 04:28:58 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH 06/14] serial: tegra: report error to upper tty layer
Date:   Mon, 12 Aug 2019 16:58:15 +0530
Message-ID: <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609342; bh=lg7+2FM3LWtjdJ00yRSfWkWg11JYeWHpFHZ5bmji6R8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jVCm+sgaK0YWRNK/meHcf2zRZyRaDgzt61Kjp4RORDCO0dJ7jkEvcqitZHjc6besD
         fP9cAbp6FqSip9JeguyKRbjPucIzfGkujdF4WR5W5fM6MMwX6rW/+3DPA4MwyRGmKI
         gTPx/ptB9k2q7E5Zer7nAvmlaBN4Av0pe+DE30TRjEDnNUwQLFL7J73KTBvsJEYv7p
         YvqnxPLne134/2bam0DNwMT93mtCMyfXNEMTA7rlSoC0inRfeVrUTGet53BOuxnEeM
         2eJ9PeHs6vLbbI3+0n0hrRDV4/oQDOuXeyP7oB85YYhwyX+xVBz8GsG9n48tMV2R5z
         OpYtR2ZcoC76A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report overrun/parity/frame/break errors to top tty layer. Add support
to ignore break character if IGNBRK is set.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index f6a3f4e..7ab81bb 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -374,13 +374,21 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 			tup->uport.icount.frame++;
 			dev_err(tup->uport.dev, "Got frame errors\n");
 		} else if (lsr & UART_LSR_BI) {
-			dev_err(tup->uport.dev, "Got Break\n");
-			tup->uport.icount.brk++;
-			/* If FIFO read error without any data, reset Rx FIFO */
+			/*
+			 * Break error
+			 * If FIFO read error without any data, reset Rx FIFO
+			 */
 			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
 				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
+			if (tup->uport.ignore_status_mask & UART_LSR_BI)
+				return TTY_BREAK;
+			flag = TTY_BREAK;
+			tup->uport.icount.brk++;
+			dev_err(tup->uport.dev, "Got Break\n");
 		}
+		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
 	}
+
 	return flag;
 }
 
@@ -562,6 +570,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 			break;
 
 		flag = tegra_uart_decode_rx_error(tup, lsr);
+		if (flag != TTY_NORMAL)
+			continue;
+
 		ch = (unsigned char) tegra_uart_read(tup, UART_RX);
 		tup->uport.icount.rx++;
 
@@ -1224,6 +1235,8 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	/* Ignore all characters if CREAD is not set */
 	if ((termios->c_cflag & CREAD) == 0)
 		tup->uport.ignore_status_mask |= UART_LSR_DR;
+	if (termios->c_iflag & IGNBRK)
+		tup->uport.ignore_status_mask |= UART_LSR_BI;
 
 	spin_unlock_irqrestore(&u->lock, flags);
 }
-- 
2.7.4

