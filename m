Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D38C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215D12082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256523;
	bh=AQqpYqdxLMQw/vqH56cUslHi8pQ+V6BoMJLbFPlFIQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OS4fkJ5vD5rDhp/AQKDAErSPa0BSqciST2MjqJuaYx9Egqt71HfK774BCSIgReyCD
	 SejzirNHeiYGDC99vwtzsGeYg7/48rMHWwvG/Wj7y+B0i+sfI/y/dHyqr2wHOSi1el
	 yk+qvFMqMRNQaST943UmtB8VM4EYhVSg/d4yyNTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfCVMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388314AbfCVMIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E68821916;
        Fri, 22 Mar 2019 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256518;
        bh=AQqpYqdxLMQw/vqH56cUslHi8pQ+V6BoMJLbFPlFIQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBnJR4pHbPd7WNE/Maz0wWzBy8Xbo1ukgUEQRM4rtCMfMPmExbnA+nQHPRGHUz3Nt
         8J/shouiyXiQMDrJC61Hr6/v58G2/vr2XESa+ridUeM5LTj3j9SB0MFmXt8aIQ72nZ
         LkxQ7oCI+Qd4thplBsJSyctaa7VkuAxe8Jv6Ii+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 4.19 213/280] serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO
Date:   Fri, 22 Mar 2019 12:16:06 +0100
Message-Id: <20190322111333.329917441@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 7abab1605139bc41442864c18f9573440f7ca105 upstream.

If RX is disabled while there are still unprocessed bytes in RX FIFO,
cdns_uart_handle_rx() called from interrupt handler will get stuck in
the receive loop as read bytes will not get removed from the RX FIFO
and CDNS_UART_SR_RXEMPTY bit will never get set.

Avoid the stuck handler by checking first if RX is disabled. port->lock
protects against race with RX-disabling functions.

This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
xuartps: Fix RX hang, and TX corruption in termios call") which fixed a
similar issue in cdns_uart_set_termios().
The behavior can also be easily verified by e.g. setting
CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
following loop will then get stuck.

Resetting the FIFO using RXRST would not set RXEMPTY either so simply
issuing a reset after RX-disable would not work.

I observe this frequently on a ZynqMP board during heavy RX load at 1M
baudrate when the reader process exits and thus RX gets disabled.

Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/xilinx_uartps.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -362,7 +362,13 @@ static irqreturn_t cdns_uart_isr(int irq
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_RXMASK)
+
+	/*
+	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
+	 * as read bytes will not be removed from the FIFO.
+	 */
+	if (isrstatus & CDNS_UART_IXR_RXMASK &&
+	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);


