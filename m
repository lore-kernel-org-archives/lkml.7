Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF79C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87668208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLnayBw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfIWCY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:24:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42664 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfIWCY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:24:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so7105909pgp.9;
        Sun, 22 Sep 2019 19:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aY/BKnDI/88NXwfuI9VMBOVirG9SdPdDsfV1k3v+hLY=;
        b=mLnayBw3yrjgoV4kgyUTkALYEhAoITnSQ7AAH6NKyRN7qa+4zsy4WW1qkA3MLVZ3r+
         a1YUH1s4v/BATnwqzJDFLnzNrJDnfSGbMKqv3+2CHjNfxtywVWI9Pm/GJylVTNRrVszm
         +o7WBSFVBvVo0fkjmyNque+iU7+GvysvHWlE3cRxZWOdQJ000tzpUBoUgei9W8FF6HeL
         63xn96Zue15ScgHuggJ7VbESf28TQh/J6teuXjqSTz3NuQ3KRV0M2f6tkiApguCDIsEZ
         OPzrY0NHRPocdN/jI7odRojfgpF+bvbXsLHkGshmID8Desi82E2J0mGCGGLb/vxU3fKE
         Cc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aY/BKnDI/88NXwfuI9VMBOVirG9SdPdDsfV1k3v+hLY=;
        b=lJEZZmdlFNu4A2mCELjsQowkqS5ccwEXJdSxv97qFKqFk+PJcz48TMdgHFZbm+JI3o
         OgCJpvjs9ijMoy760RaHON37j2DVlP/ZAqqiIdo7kiIl2Leteijg5MoozZNYiQUlFlMX
         7oM40algwL27aop0/wLrsVzWF67/k16gekivuowOvEIx3A7fy6n3UuQjOOKkRuSIXHkV
         7N9lZsjwLYT1tmz7FaUY1TUbdDESCp7jLJ3gctBcdb/Eq3fTFowIqCs9UOfjCUJ/jxx6
         RG8xtHTRdsMqiN0ozd6xE9f6Z3Br5WkGhTDTfYDcJZCuaGhlTmyouF3gbMcezFqggE9g
         5UBA==
X-Gm-Message-State: APjAAAVL7bD32rNXu3DxyCRivOkmuu4mUmXW9VD7RSYCEIXJ1TL08CYL
        KSWpOk0HfySL/scU5GdtEyuJ8X8e
X-Google-Smtp-Source: APXvYqyc11+ML3LCRK9q6OJyAt8Kj6lnHbHIdfpDpWRXrhydB0oSUNszpJfYl9HHw5vsyshtt6kucg==
X-Received: by 2002:a65:5186:: with SMTP id h6mr26981100pgq.304.1569205497619;
        Sun, 22 Sep 2019 19:24:57 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q30sm10348854pja.18.2019.09.22.19.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:24:57 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 1/7] USB: serial: f81232: Extract LSR handler
Date:   Mon, 23 Sep 2019 10:24:43 +0800
Message-Id: <20190923022449.10952-2-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract LSR handler to function.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 53 +++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 43fa1f0716b7..c07d376c743d 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -322,10 +322,38 @@ static void f81232_read_int_callback(struct urb *urb)
 			__func__, retval);
 }
 
+static char f81232_handle_lsr(struct usb_serial_port *port, u8 lsr)
+{
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	char tty_flag = TTY_NORMAL;
+
+	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
+		return tty_flag;
+
+	if (lsr & UART_LSR_BI) {
+		tty_flag = TTY_BREAK;
+		port->icount.brk++;
+		usb_serial_handle_break(port);
+	} else if (lsr & UART_LSR_PE) {
+		tty_flag = TTY_PARITY;
+		port->icount.parity++;
+	} else if (lsr & UART_LSR_FE) {
+		tty_flag = TTY_FRAME;
+		port->icount.frame++;
+	}
+
+	if (lsr & UART_LSR_OE) {
+		port->icount.overrun++;
+		schedule_work(&priv->lsr_work);
+		tty_insert_flip_char(&port->port, 0, TTY_OVERRUN);
+	}
+
+	return tty_flag;
+}
+
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -341,29 +369,8 @@ static void f81232_process_read_urb(struct urb *urb)
 	/* bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]... */
 
 	for (i = 0; i < urb->actual_length; i += 2) {
-		tty_flag = TTY_NORMAL;
 		lsr = data[i];
-
-		if (lsr & UART_LSR_BRK_ERROR_BITS) {
-			if (lsr & UART_LSR_BI) {
-				tty_flag = TTY_BREAK;
-				port->icount.brk++;
-				usb_serial_handle_break(port);
-			} else if (lsr & UART_LSR_PE) {
-				tty_flag = TTY_PARITY;
-				port->icount.parity++;
-			} else if (lsr & UART_LSR_FE) {
-				tty_flag = TTY_FRAME;
-				port->icount.frame++;
-			}
-
-			if (lsr & UART_LSR_OE) {
-				port->icount.overrun++;
-				schedule_work(&priv->lsr_work);
-				tty_insert_flip_char(&port->port, 0,
-						TTY_OVERRUN);
-			}
-		}
+		tty_flag = f81232_handle_lsr(port, lsr);
 
 		if (port->port.console && port->sysrq) {
 			if (usb_serial_handle_sysrq_char(port, data[i + 1]))
-- 
2.17.1

