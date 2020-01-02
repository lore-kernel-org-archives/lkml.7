Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC26217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005401;
	bh=ZE+Nkej9SxrPmkPD5oIex74WB1Y5UOZ//9qw5V7PLbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvjxFrl+bRAljge28xyPIU1Tvei58UDmrgFPulWZHi19xn979X+zBAuXyygMuuj93
	 IMPo750Mbl7O+OINzh1CT5fkpsOG6pqJiYBjkxskoyfFyi1qT9ijwwsYSsOPwU/xHU
	 xuOL1zeEmEsT4o3uJ2T12xwPb7lZnB5pQ7hgpmPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgABWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgABW0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D229721835;
        Thu,  2 Jan 2020 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003961;
        bh=ZE+Nkej9SxrPmkPD5oIex74WB1Y5UOZ//9qw5V7PLbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoQXGzv2sBBLdwcA/sl6XH1+D8AAloxT8ov98YkVHux0ngooX6La8G2eHSs1kEhqR
         WMKlmpHXRKgBGqQP2gUz3WYSnnJgLKcMmow7gs1H/Gh76pxAqGov+A7EEkoOh9j+QJ
         yaez2/qtMaGAKH2JigNw4BomeXE/+3RWpOfLdGuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Engraf <david.engraf@sysgo.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 72/91] tty/serial: atmel: fix out of range clock divider handling
Date:   Thu,  2 Jan 2020 23:07:54 +0100
Message-Id: <20200102220446.752202515@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Engraf <david.engraf@sysgo.com>

[ Upstream commit cb47b9f8630ae3fa3f5fbd0c7003faba7abdf711 ]

Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
register was already written thus the clock selection is ignored.

Fix by doing the baud rate calulation before setting the mode.

Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
Signed-off-by: David Engraf <david.engraf@sysgo.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191216085403.17050-1-david.engraf@sysgo.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 9ee41ba0e55b..367ce812743e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2183,27 +2183,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
-	/* set the mode, clock divisor, parity, stop bits and data size */
-	atmel_uart_writel(port, ATMEL_US_MR, mode);
-
-	/*
-	 * when switching the mode, set the RTS line state according to the
-	 * new mode, otherwise keep the former state
-	 */
-	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
-		unsigned int rts_state;
-
-		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
-			/* let the hardware control the RTS line */
-			rts_state = ATMEL_US_RTSDIS;
-		} else {
-			/* force RTS line to low level */
-			rts_state = ATMEL_US_RTSEN;
-		}
-
-		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
-	}
-
 	/*
 	 * Set the baud rate:
 	 * Fractional baudrate allows to setup output frequency more
@@ -2229,6 +2208,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	quot = cd | fp << ATMEL_US_FP_OFFSET;
 
 	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
+
+	/* set the mode, clock divisor, parity, stop bits and data size */
+	atmel_uart_writel(port, ATMEL_US_MR, mode);
+
+	/*
+	 * when switching the mode, set the RTS line state according to the
+	 * new mode, otherwise keep the former state
+	 */
+	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
+		unsigned int rts_state;
+
+		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
+			/* let the hardware control the RTS line */
+			rts_state = ATMEL_US_RTSDIS;
+		} else {
+			/* force RTS line to low level */
+			rts_state = ATMEL_US_RTSEN;
+		}
+
+		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
+	}
+
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
 
-- 
2.20.1



