Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF84C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD0C2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935045;
	bh=nkZ6Tz3khAsmsQ82x8OX7tgmPnhebC4vG3Vhlk1ApSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Li8h0G2zlX45vPSv8e9xhZAtGFJhajCehyL+RFGz4YaneLQhY9yzf/ygXx2Ysy+F+
	 bbnl7W2h/cJwpTaK2G/108zha5zYc5N+CJSgDEk9yOo5EBj5Qt+0CLFd2/N0TRDAQm
	 N5ta8E58XSSzLfeJZUdTvro+3FxvRYRxGOhgzLsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfGLMbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfGLMaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:30:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4538208E4;
        Fri, 12 Jul 2019 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934608;
        bh=nkZ6Tz3khAsmsQ82x8OX7tgmPnhebC4vG3Vhlk1ApSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXGuPqGonQg3DEFhh+7fDppnA1UTKy6xvdDVyLjC+kTBEtlHOgpwPZXsWkM7DLo9Z
         dOUDhWC12upUN3oYIlpqKGaLyKDtsPDZCR1pvvGP8iIFPUzJp+pNMR0zrarh+tLUrU
         I/pK/UW/pTHRepEM7PAKKTLly/OTyHoQsTgVMOnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Barta <o.barta89@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.1 110/138] Revert "serial: 8250: Dont service RX FIFO if interrupts are disabled"
Date:   Fri, 12 Jul 2019 14:19:34 +0200
Message-Id: <20190712121632.977789469@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
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
@@ -1869,8 +1869,7 @@ int serial8250_handle_irq(struct uart_po
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI) &&
-	    iir & UART_IIR_RDI) {
+	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}


