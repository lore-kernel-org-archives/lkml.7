Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD222CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jhQLbAuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfIDEnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:43:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7319 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfIDEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40f60000>; Tue, 03 Sep 2019 21:43:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:31 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:31 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:31 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40ef0000>; Tue, 03 Sep 2019 21:43:30 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH V2 04/12] serial: tegra: report error to upper tty layer
Date:   Wed, 4 Sep 2019 10:12:59 +0530
Message-ID: <1567572187-29820-5-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572214; bh=HAO/3tHNmsgBI1WiOn5FkmB03zXOUH5H8G2INtCZe6g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jhQLbAuBYin85On3xPsqt1bAcQkj/cCX2NKEqRufFhT/4LmvwmQ09zU0nBDRKmhNN
         KaPXOKTuOCg7Ggt1WmM2itoFKy0ARInsQqtrz4jWuqDrjoxd1BKlcS+e2Saza6vogX
         vY58MTGgF0y0zhgWU7s4qOaDwXmwiCXqxvMCDjmX/9jTKTD6ZP5wyFtiUdqEZinyhY
         yTaiSx3yHQfrYJyjWZsCkrHpAdsHXnTJcgnGwifGSgGf+8+0gAw2U0dIYdrxw4wyQL
         FdYLTaGGWQIXzzPJj1u8n4Os4Ht66fVCJ7Z8l9pVMlDufKMg00fNCqDxfHGqXfudm8
         NRyS1/54oPyuQ==
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
index 4cd6d5f..c3f9913 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -373,13 +373,21 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
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
+			dev_dbg(tup->uport.dev, "Got Break\n");
 		}
+		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
 	}
+
 	return flag;
 }
 
@@ -561,6 +569,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 			break;
 
 		flag = tegra_uart_decode_rx_error(tup, lsr);
+		if (flag != TTY_NORMAL)
+			continue;
+
 		ch = (unsigned char) tegra_uart_read(tup, UART_RX);
 		tup->uport.icount.rx++;
 
@@ -1223,6 +1234,8 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	/* Ignore all characters if CREAD is not set */
 	if ((termios->c_cflag & CREAD) == 0)
 		tup->uport.ignore_status_mask |= UART_LSR_DR;
+	if (termios->c_iflag & IGNBRK)
+		tup->uport.ignore_status_mask |= UART_LSR_BI;
 
 	spin_unlock_irqrestore(&u->lock, flags);
 }
-- 
2.7.4

