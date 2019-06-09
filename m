Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2CC206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099186;
	bh=op1gChslQGxNPa936LUqZEqpWuej5GsHZdQxDraDVkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QzpRzmS/SkOzs2SjBrQjNPArWFxnaGytRHPgg522jM7K2Gu0O0KrFaZU2zZ0jDXGG
	 XPPBS7iQKf7SGwv4a4TTOVDyeY5kTfJ9W2RwpEjQkSCSewJD+OuiRh03Ew86M2ATbD
	 Vv8ftpJD1Av1IhKAXTQG6+eeBCdvbCTOJGYV/A/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbfFIQxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732333AbfFIQxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58DC8204EC;
        Sun,  9 Jun 2019 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099182;
        bh=op1gChslQGxNPa936LUqZEqpWuej5GsHZdQxDraDVkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWfWQ4eMhjWLSEWUtqE13N30Z8F8+oZ8Z/ZCTEK0xkyDthClvEofe+dHyPGtnNPdn
         PMOeVr6q/xZyq1n6rTksjBcM48wipe6prYfano6O4A4kVSN0lDcGxPr0XC+kyX+yma
         nuGHR4UD5kfRXqeJNNa4V1+LGtuHwaHWoUUQKYLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 4.9 40/83] tty: serial: msm_serial: Fix XON/XOFF
Date:   Sun,  9 Jun 2019 18:42:10 +0200
Message-Id: <20190609164131.277962861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

commit 61c0e37950b88bad590056286c1d766b1f167f4e upstream.

When the tty layer requests the uart to throttle, the current code
executing in msm_serial will trigger "Bad mode in Error Handler" and
generate an invalid stack frame in pstore before rebooting (that is if
pstore is indeed configured: otherwise the user shall just notice a
reboot with no further information dumped to the console).

This patch replaces the PIO byte accessor with the word accessor
already used in PIO mode.

Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/msm_serial.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -868,6 +868,7 @@ static void msm_handle_tx(struct uart_po
 	struct circ_buf *xmit = &msm_port->uart.state->xmit;
 	struct msm_dma *dma = &msm_port->tx_dma;
 	unsigned int pio_count, dma_count, dma_min;
+	char buf[4] = { 0 };
 	void __iomem *tf;
 	int err = 0;
 
@@ -877,10 +878,12 @@ static void msm_handle_tx(struct uart_po
 		else
 			tf = port->membase + UART_TF;
 
+		buf[0] = port->x_char;
+
 		if (msm_port->is_uartdm)
 			msm_reset_dm_count(port, 1);
 
-		iowrite8_rep(tf, &port->x_char, 1);
+		iowrite32_rep(tf, buf, 1);
 		port->icount.tx++;
 		port->x_char = 0;
 		return;


