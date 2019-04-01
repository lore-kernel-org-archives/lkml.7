Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3425D2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLLmPsql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfDAGBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:01:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfDAGBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:01:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so4187427pgf.2;
        Sun, 31 Mar 2019 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpXIoYhXE68l45eFbZRWHOq9B2GvE4k6QbLfjHgrv5E=;
        b=hLLmPsql7Oj2AB69FAN6WGX/oeNy/YrpHtIS+v+4zVU0H7PtVqCjNjbAXpinbcTb27
         ORZCQ1f3z2zjcOGqw5sNXPbrOCs2OoUuchJmEhjMBa3X/UMpte6gWyArEroTmYk53hNz
         0Kyrv61iDXLC6NCoFqkAGRSdzDqNjXPR+ObInqDIP1GrAAmmEbM/4SOnGptfefHNlZ9Q
         qXUuDFE9bOCECwEGOSGbS3Dbq9EiIaazv8+5l6XDF7qPeJ0Iq+6lh6iHFGctmtkk8uGs
         uiieXMLVqC0WRMsHKxOUzyNbgXsoMcRo/VdCWflA471MgI+0qd1Jt0e1YF8JSPy0o5I4
         xXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpXIoYhXE68l45eFbZRWHOq9B2GvE4k6QbLfjHgrv5E=;
        b=tNKq/wli2MY+XUQ7E1e61K+w0/2MpCHya3R0icRo5UPdpoRJUa0RYBD3KQqL16Idxd
         brQZQVPrcVIMpfhCx1AfP+IhFqX0YI3ipuCV6tYxJjbArC3ky5XfoH9zdVtxDuIuKTQM
         x4SRjhJKGsSREjzoYmEb9Jr5iwo9IDUuS2Y69VOZjH7Wp73EkmgMxtK5eDp2jZxya9QD
         7bEjRz/03lxiD3cJU1JlcgoJqSkFQCPzpnCALMbVihKcdwkpxgb8wW7F0R3jGJsQ/3Wp
         Ee4lMYyAj48dvHzdvSCQm/9ME97w8bfRdqSdkHU1txD1MEW/KdJeYZVpQTD2WtAlv0i4
         XoJQ==
X-Gm-Message-State: APjAAAUdEgNFA6/2AxSgZOIP8VWWw6H3nDxN0G3ap8OAmhX8aI7SWXmZ
        VdFDkBVagcQYWPTwvZepaLQ=
X-Google-Smtp-Source: APXvYqw/ArMqD17kN2GBqRcWimcsY1CN3a2yh9kPZabiYJvxka0mPFBUlcfkUwcb3f6OUdPo+IfjDQ==
X-Received: by 2002:aa7:9193:: with SMTP id x19mr52060206pfa.108.1554098465783;
        Sun, 31 Mar 2019 23:01:05 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id d129sm8530692pfa.142.2019.03.31.23.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 23:01:05 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [RESEND PATCH V3 3/3] USB: serial: f81232: implement break control
Date:   Mon,  1 Apr 2019 14:00:53 +0800
Message-Id: <1554098453-31278-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v3:
	1: using shadow_lcr to save LCR in f81232_break_ctl()

 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index e7862997b6e4..9377b827313a 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
@@ -377,13 +378,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
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
@@ -519,6 +530,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -572,11 +584,16 @@ static void f81232_set_termios(struct tty_struct *tty,
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

