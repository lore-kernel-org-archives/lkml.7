Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE9EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C2205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429668;
	bh=ue65A/VHffRhGxa92M9SL1+8Tm3NdmZW+uzUza6JSTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVglmjU1HNY94CO7xSeR7M2L1yGwJ3vXLbZRAs4yitUjE3lydi9x0zv8Bc80YWBy9
	 NQTd7AUAHbscROn5svUfjLH/tm9j7DtCSbw55Qvtq3xoz8RDv5jjeM33Pd6HAaHN3+
	 Odf2ZImoPsZ9dD2hyM3lDBeAuNNOnVx3+ys9DB2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfG2Trr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389978AbfG2Trf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:47:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141FC20C01;
        Mon, 29 Jul 2019 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429654;
        bh=ue65A/VHffRhGxa92M9SL1+8Tm3NdmZW+uzUza6JSTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoRGB1gHhhFp8Q8P5V0dsFDoBFdvK3wwfaeuDBC91jYyhbpKiO1Vpnkgb1xSH4hmT
         ssENsXRl4y7aHi+nXAMo5MprL1y+NGRL2w3i5mJHjK+cXfTtpgMHgp1Dxa7x8X755j
         rBluCRwrAl8Yl5tSLv+4O6m+QRUUkLiOwi4nqvVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 052/215] serial: 8250: Fix TX interrupt handling condition
Date:   Mon, 29 Jul 2019 21:20:48 +0200
Message-Id: <20190729190749.568119012@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 682300713be4..eb2e2d141c01 100644
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
 
 	uart_unlock_and_check_sysrq(port, flags);
-- 
2.20.1



