Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA28C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D5D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBECxKjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfETSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:38:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35648 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:38:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so368403wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QefnsvwV3d7y65V0/j2nW7pHukGB8D2WmP+WVKnMlIQ=;
        b=KBECxKjGA5xCv9a1o+snOgsUUJD68d0TAtUrPBibx++X/DXEjQy3l4l7REcbRK12dj
         CsbMf9EC4kQZ59sWHbglpE0OAMt05ZiaskBpgo1OymMjBWPFFI09+ecDdv1PEdaYsrYx
         JKFLXoxhfmMxvzYQHuUdBiyVpc1t2MLtOdGWdUjYMIREDZ5k1Dfct0RP0um/pCvPkeRz
         L+6Dingo+H2gBtH/bbv2UVddT/O7O1Set1bW5di+N62iYRer8ejVVOhFEg0qvLjJV8Go
         X/DGqMomCd9JvcmgDakQkvA5z/N6BmhmOekxyo0oBBBR8PenMpi/u8GFH+kUSuG0M+4a
         fuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QefnsvwV3d7y65V0/j2nW7pHukGB8D2WmP+WVKnMlIQ=;
        b=XM2By9RDJAmRXV3m09rkUMjwnuuRCjd9vBEbu4T+lrKoOmicn1aHnYuRgGLlTmlaxR
         /BPPyJuv6amLvZhYSfGe4+SDGu0MvP8cua/SInKdeo0RNTjQ/VzjPZVxHfonK/uLKqKc
         07LnQ8j0XT3c/Qf1Rc5C1nv+IYIiQWDgBdXIjfcL8IwJpDrwll1Bmc5AiMmldBk7VT++
         4ddMOA2zruhVjPwDELVmooa7924USMf3vGpOOnWIhV/JacxKa5dUtpduBLreVaaw30gc
         26l0VDXrRoV6bhX66fDoQ4POZlWkijpvIrkGWqRGnYYqMQVAUxjbVHrGGSZ/xrjYbpwX
         nXWw==
X-Gm-Message-State: APjAAAXkM7KfAneUGBxPkTIzxxYG9gGmEkri5uFpA2C7Gk32llGD67Bs
        4PpL/E6ykzkwjkGzlbWn+3FrjQ==
X-Google-Smtp-Source: APXvYqxhw/eMY6lJtu6rgMmt3g2Nme0rl/8xFpmZ5o0h0dksezQ5TAgIqGhpzlxFBG9U33SkCbiVDw==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr378016wms.142.1558377532506;
        Mon, 20 May 2019 11:38:52 -0700 (PDT)
Received: from localhost.localdomain (139.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.139])
        by smtp.gmail.com with ESMTPSA id m13sm17332790wrs.87.2019.05.20.11.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:38:51 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, gregkh@linuxfoundation.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org
Cc:     jslaby@suse.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Date:   Mon, 20 May 2019 20:38:48 +0200
Message-Id: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
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

Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

