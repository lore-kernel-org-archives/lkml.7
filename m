Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCDEC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF1C2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509933;
	bh=V7t//CdQTxgs7mOSserxTrv7xWMVDDEvG7FnxmcW7dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1Y7UAzhqgEY2Zq7TGtc7Brc5lOSzYYNdJJLovuKrdabdNQOebl8Sy3j9djshPuQW
	 63zxrdMJM8l7bX9wg2hKJxcvWPfIk6Cudjx3LrGhjdv5l5t6V7zzUf5itDDHM4Ag44
	 Fom9HfM7u9GoWlo7V24yU+OE8OD+YbSEbYLcK2Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbfGSENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389181AbfGSENZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD55521850;
        Fri, 19 Jul 2019 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509604;
        bh=V7t//CdQTxgs7mOSserxTrv7xWMVDDEvG7FnxmcW7dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rRq4meUbZTUfKHc5Iha+KAbgedJmnQro06rh/DTQBsYzcEF1qXSdENz0j1rdF94g
         R5Dfgy698lzvcIufOKOIk5VSEfvTi6C6fP9Trhg3P448lsJ6mlojtZakju7Z0YVLe8
         iznPRg5J0mCNllEiBdK0s9udrPNIa8uydz4GP14M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/45] serial: 8250: Fix TX interrupt handling condition
Date:   Fri, 19 Jul 2019 00:12:31 -0400
Message-Id: <20190719041304.18849-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>

[ Upstream commit db1b5bc047b3cadaedab3826bba82c3d9e023c4b ]

Interrupt handler checked THRE bit (transmitter holding register
empty) in LSR to detect if TX fifo is empty.
In case when there is only receive interrupts the TX handling
got called because THRE bit in LSR is set when there is no
transmission (FIFO empty). TX handling caused TX stop, which in
RS-485 half-duplex mode actually resets receiver FIFO. This is not
desired during reception because of possible data loss.

The fix is to check if THRI is set in IER in addition of the TX
fifo status. THRI in IER is set when TX is started and cleared
when TX is stopped.
This ensures that TX handling is only called when there is really
transmission on going and an interrupt for THRE and not when there
are only RX interrupts.

Signed-off-by: Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5b54439a8a9b..b4d6fef83f65 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1820,7 +1820,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			status = serial8250_rx_chars(up, status);
 	}
 	serial8250_modem_status(up);
-	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
+	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE) &&
+		(up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.20.1

