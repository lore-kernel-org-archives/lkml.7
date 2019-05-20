Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C87C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17766206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypVliwq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfETKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:34:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50294 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731376AbfETKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:34:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so12746998wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJaOf0A2/Xd/g+78Nlk/c2RYeLP2fm2K/KoH/Yw8zbU=;
        b=ypVliwq7SwcxaYxl4+KiThvD4LBr7BJikL4QOM8mIJ1xCwBblENKpU/2RMOMFrDXhu
         ZCEZ+yDmJHVEgB2KWcttKNH0OvBVItB+jFrmE7BTTwD7UMwrV7UnHc0PecqPCuAXmcOl
         w2B8sFUdppF3vAnZ8wUjq65AEXMemnsy26U6g+dAdMiY5pWxP8zvy//xpmBvZesOpLLq
         R4BfkZlqIvXbOShH6BB+h2YXfWzRxGcjEx2QEiua6ZQLxHMLi+WFyoThOP39eJ9meyvi
         A41aoqlxNOmH8Yr9WBqjUy42j43/Ff3Ui29P773BgS2uly+rHJXXsYmn/u/nIh+J7VuY
         /cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJaOf0A2/Xd/g+78Nlk/c2RYeLP2fm2K/KoH/Yw8zbU=;
        b=D8gTFkFRNW7DIQ7hOV4t/GwC3KnZWg7iuvFvXquYXbaYPkhXpfPwR2VehpUrpOw9Z4
         3NDnKLHJ/ozQBx42OtJgn7fbjug7ADpFcC3xV0tt+uMSlroVB1KRWTFtqE0lLz92fSwV
         cupAYtMe0SiEjpd86l3Hi5XkWfLVxh2NNRIHkXj+Fr8zhbDj8kONp4bpBYredbdI1CLF
         7KbDUeyLohteOLEee4zJxPvxvUEG8nodh4bzeaMEAY+zv5TSH9JHVvr9Soj5hp0lbRoT
         pWcdb8tKKocGkSpIHae1KiMes+aqewmdSqlJdnjXqPuxaoIXejdY/TzXQjqA4fMZSMOL
         2Rgg==
X-Gm-Message-State: APjAAAViyWISWf+jNn+NMm381ls335zOWCz6XJLNFRnoqukEqJGRtoZ1
        Kdi8WPllIzw66G+Iu8oE10GR+w==
X-Google-Smtp-Source: APXvYqwX9w3fvgtsddUeORMpPjPJpygGZ2d2dpnnMtIHE7PR28RyVQbZiw+0IFSL0wKLtzL2qxf8yA==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr20213217wmk.116.1558348481406;
        Mon, 20 May 2019 03:34:41 -0700 (PDT)
Received: from localhost.localdomain (139.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.139])
        by smtp.gmail.com with ESMTPSA id l2sm23451641wmf.16.2019.05.20.03.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:34:40 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        agsumit@qti.qualcomm.com
Subject: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
Date:   Mon, 20 May 2019 12:34:35 +0200
Message-Id: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the tty layer requests the uart to throttle, the current code
executing in msm_serial will trigger "Bad mode in Error Handler" and
generate an invalid stack frame in pstore before rebooting (that is if
pstore is indeed configured: otherwise the user shall just notice a
reboot with no further information dumped to the console).

This patch replaces the PIO byte accessor with the word accessor
already used in PIO mode.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 109096033bb1..23833ad952ba 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -860,6 +860,7 @@ static void msm_handle_tx(struct uart_port *port)
 	struct circ_buf *xmit = &msm_port->uart.state->xmit;
 	struct msm_dma *dma = &msm_port->tx_dma;
 	unsigned int pio_count, dma_count, dma_min;
+	char buf[4] = { 0 };
 	void __iomem *tf;
 	int err = 0;
 
@@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
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
-- 
2.21.0

