Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F235C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C472075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be1A/4kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDBF0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:26:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:26:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so5958247pgk.0;
        Mon, 01 Apr 2019 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSPQ7DGVhBjhVIpC2feD1Zf1Ln5mj7QIJLWAJErFVR8=;
        b=be1A/4khegj3mIW9Gsrt9X2ep0KdCNXs6dz41ASwBfq2DIBgJ/1ttK+wzjpFYsQPhK
         YzBtE7MDPsfEJaD7eEhrcnx+qpQCCRRkOTzuAdooWeK2+xdzCqfHqRcFXlbqXrWkC2DQ
         mbVOWFhmuYANWizeIyDBnzTfRhNGYnMP0419OySztGGDQzEUcJR8sgG0w3rAKcw9u1ot
         jNRa2zfODowOGpXAaujbeSbYTrWZZUp29E39FVUcWqrZXs1/dWoygzHBeWcbntLm3rP5
         1ma72KqfoLJNHrfxuZy8zV5koO4ykso7uSwVKQFLrNC3DJ75JRmsyNWRIMu9UO2ZGSnZ
         RYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSPQ7DGVhBjhVIpC2feD1Zf1Ln5mj7QIJLWAJErFVR8=;
        b=F/uPokKHcD3U1s/opRAenlMFphR2cF3a/tPEWNgX84iQqga6+9KaR8SAnDr6SHlyvJ
         TbtKbqEfq5GjSjU2gIXlNECoEWDU1e7ueU2SlmvMt5uCnfdzGEl7zgoA/ELwo5u2oRvM
         yZlv3jvudQ4GUbD3ZiD0u6FKL9UKlLY27l2kGzrNj5ZhR9ltvfZDrk+s7EPrAo+tza+o
         RHzeffkE7sikZGE7R7/YAZS4qiGnRDqCEXCIpPbvsj8V/4P4sBRoFQqKsms0MLzR9H5K
         dgoBrTBDcxBIGKIOZmNKqGPOdJtk6ltcY2o2opsHr6WWQciG3pe8tQb4XA+BzFyYQS1z
         tCxQ==
X-Gm-Message-State: APjAAAUbR/fsqafK/kFQizWhXN62NxhQ2VNLRLNtnWxoyWGPS8tnA36a
        ZWHnAHsp7MnN/p5JbBvUmzY=
X-Google-Smtp-Source: APXvYqxOzTAj5Phn1SxrnTUYKb2QkToYaHVqQoKlKJE+BYNZ+E2L7dgtHInn3bchY1nPiUklXIwzqg==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr52581017pgc.238.1554182805315;
        Mon, 01 Apr 2019 22:26:45 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id d75sm30535482pga.66.2019.04.01.22.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 22:26:44 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V4 3/3] USB: serial: f81232: implement break control
Date:   Tue,  2 Apr 2019 13:26:37 +0800
Message-Id: <1554182797-12815-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554182797-12815-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554182797-12815-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v4:
	1: no change

v3:
	1: using shadow_lcr to save LCR in f81232_break_ctl()

 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 37da345acafd..763a51222384 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	speed_t baud_base;
 	bool lsr_work_resched;
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

