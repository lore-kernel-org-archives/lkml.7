Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76815C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E9021537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="v+McrwDz";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="WTWXNyOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfGKOIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:08:44 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:52836 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfGKOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:08:43 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6BDiL5l013216
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:45:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id; s=pp;
 bh=HAfyE5vq9jpBhAxZyoPTsOZYx8qRQEzm7LzCZOVxA98=;
 b=v+McrwDzvUBlxfhM4JXCv751WY6xwI82KPoF4l4JQXxcyP0XiO8nxnkW45TCU1xUEwDo
 PYaL/LwxjrpcVxCGv2OVgPGGgOaFLEFE2kwMuPtfUh9iSrPkDoS87DDFVWROcnN19S8R
 SXXFd6Rqq2HXNZzF4etWTE0mmzV75Zv53QCirw93yWb5cxY1DlCyY/js4EC8ClhO3mws
 UFWm6cahYUvS/24aRadFklsHu+Hw+1/LUSaiEmUjx5Lk8jm55fjnBA2l4jLJqGtJZMkO
 UV/fblJkvbb+gjuEJXnSJKy+W3p7Kmvs6rUOlXCPJ8LD/0vKIrfliA1gRsfcEUpTUcAm pw== 
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        by mx08-00252a01.pphosted.com with ESMTP id 2tmd5x1cky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:45:41 +0100
Received: by mail-wr1-f71.google.com with SMTP id x2so2617897wru.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HAfyE5vq9jpBhAxZyoPTsOZYx8qRQEzm7LzCZOVxA98=;
        b=WTWXNyOkcpQK+c9/4XM99fDdN6Xw6N4Pf4s3OftsAduPOlc7F4gWSMlWvzRk527WP7
         NSzT5Ww/VHnysyjVyRMBJT9VqXCV0ziwFbz2xLEVPlYNJBaAj8jLfxD1blF2EQPRgCeV
         yW8kpQ/RE5tDpERwMj4w7dXEC9j8k+Aut4G4WMnbuEqgEw0ihaSviX1lgmb0+4HY/3o6
         OexeSwByhl4XKeetzY62qnHMl+qjk1ActnOV3Tj4SDd8EEYHGeGckPJYLLMZyEcxLr7u
         c9SyN9EyDxUhAUl6w21l8g57pn/AnBlgbDO+JZk8Neus2fA7Wk567DHBmFs0/pb8EbQu
         Z5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HAfyE5vq9jpBhAxZyoPTsOZYx8qRQEzm7LzCZOVxA98=;
        b=XX/4VGFzn0hyCZVPCncAQXcrBWregviylVfv9OavCAK1EkJxeqBquoFSZfD5lxgyRW
         SZm8egRTfQGNkaaghIBRENDYIFxs/+M4pa4y+F3XVsal477PbTPcWHArJuupZRsEreA9
         F3VqippaXgpkkYBlVfF1wwqxeMkp1PFCfAqyKKQ/JH4eO0HC+PnL00z9wCM9UXfOaKBP
         0MN43o4XL8KJAtgHGJ0IOQw8qhS+118KilCXSyKT3NExLWg+pPej49SuQ+xi1t9eq6zV
         DWAwHY6QxGydGPPW1z3Y6f9JdwYfmzgP4shxhGidKCM7xSBzHW2ZMhcnG8+BrEkU5k5N
         DC9A==
X-Gm-Message-State: APjAAAWgaL9JXp7mRfWXlLTpdhoWoMVlWP/EnVmOfDcGLXUDZF0bAQZw
        3/5KY3K6UjH1UVFZk9hYZ3HqpWgU4bN88xw17ow7AnAitnsdX30sYR9TJLmOKmICJPKVcZr+cMx
        phfFWuiNjjSbsmLUYZ7YRdtXc
X-Received: by 2002:adf:fe09:: with SMTP id n9mr5641586wrr.41.1562852740558;
        Thu, 11 Jul 2019 06:45:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypIrsedHEAbDW3NOuK+HEUYtQnaDEhNZw5HmIZ2Hrqn0o0Rd63sxvab+STDyw06/PvdsoJ7g==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr5641568wrr.41.1562852740312;
        Thu, 11 Jul 2019 06:45:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1098:3142:14:4d96:5e54:efaf:af7d])
        by smtp.gmail.com with ESMTPSA id z1sm6431022wrp.51.2019.07.11.06.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jul 2019 06:45:39 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Date:   Thu, 11 Jul 2019 14:45:32 +0100
Message-Id: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-11_02:2019-07-11,2019-07-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl011_tx_chars takes a "from_irq" parameter to reduce the number of
register accesses. When from_irq is true the function assumes that the
FIFO is half empty and writes up to half a FIFO's worth of bytes
without polling the FIFO status register, the reasoning being that
the function is being called as a result of the TX interrupt being
raised. This logic would work were it not for the fact that
pl011_rx_chars, called from pl011_int before pl011_tx_chars, releases
the spinlock before calling tty_flip_buffer_push.

A user thread writing to the UART claims the spinlock and ultimately
calls pl011_tx_chars with from_irq set to false. This reverts to the
older logic that polls the FIFO status register before sending every
byte. If this happen on an SMP system during the section of the IRQ
handler where the spinlock has been released, then by the time the TX
interrupt handler is called, the FIFO may already be full, and any
further writes are likely to be lost.

The fix involves adding a per-port flag that is true iff running from
within the interrupt handler and the spinlock has not yet been released.
This flag is then used as the value for the from_irq parameter of
pl011_tx_chars, causing polling to be used in the unsafe case.

Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/tty/serial/amba-pl011.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33..70c1dc9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -270,6 +270,7 @@ struct uart_amba_port {
 	unsigned int		old_cr;		/* state during shutdown */
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
+	bool			irq_locked;	/* in irq, unreleased lock */
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	bool			using_tx_dma;
@@ -814,6 +815,7 @@ __acquires(&uap->port.lock)
 		return;
 
 	/* Avoid deadlock with the DMA engine callback */
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	dmaengine_terminate_all(uap->dmatx.chan);
 	spin_lock(&uap->port.lock);
@@ -941,6 +943,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		fifotaken = pl011_fifo_to_tty(uap);
 	}
 
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	dev_vdbg(uap->port.dev,
 		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
@@ -1349,6 +1352,7 @@ __acquires(&uap->port.lock)
 {
 	pl011_fifo_to_tty(uap);
 
+	uap->irq_locked = 0;
 	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(&uap->port.state->port);
 	/*
@@ -1483,6 +1487,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	int handled = 0;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
+	uap->irq_locked = 1;
 	status = pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1502,7 +1507,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
 			if (status & UART011_TXIS)
-				pl011_tx_chars(uap, true);
+				pl011_tx_chars(uap, uap->irq_locked);
 
 			if (pass_counter-- == 0)
 				break;
-- 
2.7.4

