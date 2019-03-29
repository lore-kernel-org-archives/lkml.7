Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87022183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjLb2wFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfC2I2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:28:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38764 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfC2I2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:28:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so860976pgl.5;
        Fri, 29 Mar 2019 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+3bF15K6lz4BxqsdjjUiHaldC7eqbYzn7GVr+HvXNcg=;
        b=hjLb2wFU7+kEUGJioZBQYdAe3FqH/rd9M54rI/LtRK5912oT/Rj5VzkBJza+BN4woN
         OeYwBLqGCrnVsZmXAeuZEhUEZOySgiqP7ByWlHReRubdA0uRAkUps+a3/jieVt5tNsb/
         MM+I7njcjeilTamP604W5jBZf1VWddW2VuZ8sVMio5zcqICpcPA+71oBH5eCEGetbKfS
         MTcJXuez8FXNgwa2A+gr6HITs2IS3jcyKiLWmcRXcqImUB67JyJd49KN7ei3ukFamEVS
         aUGSnqcA7GnioOL870WgPwfenDf4NWw7/Mwfbk62ZPuagC4n1uPeHqWhgcwwVXP+16wr
         2deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+3bF15K6lz4BxqsdjjUiHaldC7eqbYzn7GVr+HvXNcg=;
        b=Pk+Ev/v7pWIBZ4q6QVPXyjTY0sAVcN8Ov35k7ZcslH6OXE3DIqCnyBIex6nkT1/Bv1
         gFWnBJpanGHun91ryEfC8ITuRK0ht1Bra/yauOAHzZktqYpiY528zUOKzfQgpK/H8bZM
         WOFEjjGHzK2NqoabGJWRwNZDp3T7Vs0galF8fmhqn4iv3+H0JYBI0dcJhiY6DHGY60ny
         xKUgbBxZqWHxBD1D4DQLYsq9WRYC0vIna/2JocJxdxMVzzC4vXogzHJWXeVC1HzyK4kY
         W45Qxn6z0JZMIQvvFChJ6XuuDfZSP7iBPdTIi2MJOvvhTV9E+FsuLZLAk/iv9JNkzVh9
         fhyQ==
X-Gm-Message-State: APjAAAWKJ1WlJHzLo2mypw+G2i50zmJfJMK4hCNTz2fePsDjLoxmti/z
        DTRZLk+p0s4VfeMSm5kSpO8=
X-Google-Smtp-Source: APXvYqw4OXCeCXEQF6RgeqJXbMiGX+/d+aTF+g3XA42pneit4Uy4PpTzcOPG6heVZeQJINNNPJbnPQ==
X-Received: by 2002:a62:ac08:: with SMTP id v8mr1698137pfe.42.1553848130915;
        Fri, 29 Mar 2019 01:28:50 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id o5sm1891861pgc.16.2019.03.29.01.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 01:28:50 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V3 1/3] USB: serial: f81232: clear overrun flag
Date:   Fri, 29 Mar 2019 16:28:40 +0800
Message-Id: <1553848122-1227-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 will report data and LSR with bulk like following format:
bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...

LSR will auto clear frame/parity/break error flag when reading by H/W,
but overrrun will only cleared when reading LSR. So this patch add a
worker to read LSR when overrun and flush the worker on close() &
suspend().

Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..722a184db9fa 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -41,12 +41,14 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define FIFO_CONTROL_REGISTER		(0x02 + SERIAL_BASE_ADDRESS)
 #define LINE_CONTROL_REGISTER		(0x03 + SERIAL_BASE_ADDRESS)
 #define MODEM_CONTROL_REGISTER		(0x04 + SERIAL_BASE_ADDRESS)
+#define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
 #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
 
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
@@ -282,6 +284,7 @@ static void f81232_read_int_callback(struct urb *urb)
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -315,6 +318,7 @@ static void f81232_process_read_urb(struct urb *urb)
 
 			if (lsr & UART_LSR_OE) {
 				port->icount.overrun++;
+				schedule_work(&priv->lsr_work);
 				tty_insert_flip_char(&port->port, 0,
 						TTY_OVERRUN);
 			}
@@ -556,9 +560,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 static void f81232_close(struct usb_serial_port *port)
 {
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+
 	f81232_port_disable(port);
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
+	flush_work(&port_priv->lsr_work);
 }
 
 static void f81232_dtr_rts(struct usb_serial_port *port, int on)
@@ -603,6 +610,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
 	f81232_read_msr(priv->port);
 }
 
+static void f81232_lsr_worker(struct work_struct *work)
+{
+	struct f81232_private *priv;
+	struct usb_serial_port *port;
+	int status;
+	u8 tmp;
+
+	priv = container_of(work, struct f81232_private, lsr_work);
+	port = priv->port;
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (status)
+		dev_warn(&port->dev, "read LSR failed: %d\n", status);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -613,6 +635,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -632,6 +655,16 @@ static int f81232_port_remove(struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
+{
+	struct f81232_private *port_priv;
+
+	port_priv = usb_get_serial_port_data(serial->port[0]);
+	flush_work(&port_priv->lsr_work);
+
+	return 0;
+}
+
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -655,6 +688,7 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

