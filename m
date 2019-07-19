Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED951C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD91D2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510378;
	bh=LZs241TmqQKk1XRktVEc3oe7vFsgqsPuD2FiKW8uBpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0fGnQCwWPjYK8Ekmb+BiL3rrckDFbz/xgyufQLyQtZcH2ajb1B/g3rZ+3uEs770BQ
	 /ArHxickyxSxFgIjUCKjgTgusbY6f/F80QHRdv2ehRkNxljRkqdt0/T4Ri/b9+VUq7
	 bp2Gi9nCbu74UaF3ukN2C9LcgYO7glqEwmpe7HFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbfGSE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733066AbfGSEIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:08:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96A8218A4;
        Fri, 19 Jul 2019 04:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509304;
        bh=LZs241TmqQKk1XRktVEc3oe7vFsgqsPuD2FiKW8uBpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xiDgPLxNg7GahQUXl8XFucl6YCfBYAftuz2lL47QW1fdBLWxiHipspYf2Cr8I5tn3
         T2LMe4WKVqpwx2iFE/SctMMCU1KFUfKAXWwdR0HX0cspfjKZOM1hxBIEfnM6u6BoIo
         5rkc1JfTpZpVqjgadtOcUwROdVcEZpMY7s7PF71E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rautkoski Kimmo EXT <ext-kimmo.rautkoski@vaisala.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 025/101] serial: 8250: Fix TX interrupt handling condition
Date:   Fri, 19 Jul 2019 00:06:16 -0400
Message-Id: <20190719040732.17285-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
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
index e26d87b6ffc5..aa4de6907f77 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1874,7 +1874,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
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

