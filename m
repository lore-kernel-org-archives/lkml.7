Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F4C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F2205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419581;
	bh=v0D3pV/YhXiqKMHowf+fL2GWT6Ro/wazB0YfW1Entuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9T84efvSqCOhCQ/cTVLPb6k2P91Rj5VY/kX+pmuKVgfqh9zrGn7x6Qgrfmv4Tjza
	 3NKKDtLTdDG5Y8nn2nIvIuN+v0UJOu872JGxFD3xTPhTUM9n14Tsvd3iNqyj5AWhVW
	 PmVudsj+ZzPb/meDoL9muFBF/mA8y7HzzOWPu7RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfGRDM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391527AbfGRDMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:52 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F642077C;
        Thu, 18 Jul 2019 03:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419572;
        bh=v0D3pV/YhXiqKMHowf+fL2GWT6Ro/wazB0YfW1Entuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSKPL2ZoqUJjvjWiRHlP/sYhZK+Q/i7YGvS0zIvSL1QnnXKPVE7kG+PE4bQOGTQss
         nEcWrhpytEZEpm6DiEYji3qN/F9DRJv9uRbM49KSKKiZ974N5b/BGt8XNSDsWDFZ/h
         Lqbb/AtnfqJEbPk2PJ75SV4AhAtAnx3YzwpQzrYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Barta <o.barta89@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.9 31/54] Revert "serial: 8250: Dont service RX FIFO if interrupts are disabled"
Date:   Thu, 18 Jul 2019 12:02:01 +0900
Message-Id: <20190718030051.844858216@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Barta <o.barta89@gmail.com>

commit 3f2640ed7be838c3f05c0d2b0f7c7508e7431e48 upstream.

This reverts commit 2e9fe539108320820016f78ca7704a7342788380.

Reading LSR unconditionally but processing the error flags only if
UART_IIR_RDI bit was set before in IIR may lead to a loss of transmission
error information on UARTs where the transmission error flags are cleared
by a read of LSR. Information are lost in case an error is detected right
before the read of LSR while processing e.g. an UART_IIR_THRI interrupt.

Signed-off-by: Oliver Barta <o.barta89@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 2e9fe5391083 ("serial: 8250: Don't service RX FIFO if interrupts are disabled")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_port.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1814,8 +1814,7 @@ int serial8250_handle_irq(struct uart_po
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI) &&
-	    iir & UART_IIR_RDI) {
+	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}


