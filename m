Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D99FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33F52073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNflRzjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDPI1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:27:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37776 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfDPI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:27:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so10032082pfr.4;
        Tue, 16 Apr 2019 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5uTlfZz5DwTBtUvlc5QPNIHwem/swcuwjq6p40/0VY=;
        b=RNflRzjsHjhIWFfIwlq7oJnM+EEFDqfLrr/XT5O4WoUqG0xI066W0/oUSPrkvrqOkM
         AIRgFTSsuPyK8Bll27tA0/dj6F4Q+NUCpEksW+2hc0OPXnl7UXyi0mhUeyz9/gukwI8/
         uSj4SJMrxjJOc1CJBBo/NcgPuW4uh3jHhhMR3f/CtAP4QUCaSj0Il+kJI2s1qTbJ6P7L
         r1YTbEpxay2WF2LX1qj/J181a9JlSisTkUyNJuR228muLODUzyQiMlAdOe/S6zFCPZgD
         OVc/MWRhgXUNPdWBjH/V9qTdZyYWs7GWzTEfOmmCqENRvbhObIb6lVpOZavPGDPSQprt
         Qlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5uTlfZz5DwTBtUvlc5QPNIHwem/swcuwjq6p40/0VY=;
        b=dOaFiN5AkDymRzzrA9eufnmMTb/9GlCSNlggHoNfHLSEqo0axLt4Wxm44olP5DgW8h
         FrVovBH9Q8Frb4lTOs6PN0VwFZroDlsbW92P3f6HS1yIZK59u+ai1XCOXOKPYGbY47TH
         Ak5AS67WKwcI58WZhfvbC8I5Mo0TU4gV8m1+SlqBN+KCSLa9mhu7PiFyhSQwDQgGTL1W
         A8QMZhMQhAbTfOjazqaQ553XDhvF8TBoWHSGY9MlAWdZcky1SlRnFHfxUTvaQr2p0JNc
         2hqAKVBDgu9GJKLHnNcq4xWj7Sel27k70xzH6ZLlA81dxZyeLs8J68JpwrcXTOEEWjrk
         /4hA==
X-Gm-Message-State: APjAAAXsO4rw3IBw/DJvLKjVkASaiOSOEZwGUacQo5+hrXIUHKDi8O0P
        lvddZK+G4kUFJo0aNHwteUM=
X-Google-Smtp-Source: APXvYqwA7e2CMMzUMqR8L0DUunqpQ0FdJhxbLsS8ZxbC9BCqpDzquADdJ8iSFGS4xy+Z1SC9LW1hPw==
X-Received: by 2002:a63:5466:: with SMTP id e38mr72790491pgm.340.1555403235381;
        Tue, 16 Apr 2019 01:27:15 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id o67sm113103500pga.55.2019.04.16.01.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:27:14 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V7 4/4] USB: serial: f81232: implement break control
Date:   Tue, 16 Apr 2019 16:27:05 +0800
Message-Id: <1555403225-3430-4-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555403225-3430-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1555403225-3430-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v7:
	1: no change

v6:
	1: no change

v5:
	1: no change

v4:
	1: no change

v3:
	1: using shadow_lcr to save LCR in f81232_break_ctl()

 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 474834ddbb89..839163ef0040 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	bool is_port_open;
 	speed_t baud_base;
 	struct work_struct lsr_work;
@@ -378,13 +379,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
-	/* FIXME - Stubbed out for now */
+	struct usb_serial_port *port = tty->driver_data;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	int status;
 
-	/*
-	 * break_state = -1 to turn on break, and 0 to turn off break
-	 * see drivers/char/tty_io.c to see it used.
-	 * last_set_data_urb_value NEVER has the break bit set in it.
-	 */
+	mutex_lock(&priv->lock);
+
+	if (break_state)
+		priv->shadow_lcr |= UART_LCR_SBC;
+	else
+		priv->shadow_lcr &= ~UART_LCR_SBC;
+
+	status = f81232_set_register(port, LINE_CONTROL_REGISTER,
+					priv->shadow_lcr);
+	if (status)
+		dev_err(&port->dev, "set break failed: %d\n", status);
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_find_clk(speed_t baudrate)
@@ -520,6 +531,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -573,11 +585,16 @@ static void f81232_set_termios(struct tty_struct *tty,
 		break;
 	}
 
+	mutex_lock(&priv->lock);
+
+	new_lcr |= (priv->shadow_lcr & UART_LCR_SBC);
 	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
 	if (status) {
 		dev_err(&port->dev, "%s failed to set LCR: %d\n",
 			__func__, status);
 	}
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_tiocmget(struct tty_struct *tty)
-- 
2.7.4

