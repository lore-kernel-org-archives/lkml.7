Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C108C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E89821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHLa4m5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCG0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:26:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44201 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:26:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so7506626pll.11;
        Tue, 02 Apr 2019 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DFRXXvHkZNBSc8cdxXqUjOY/AaTObOXefR9xJkuW0V0=;
        b=KHLa4m5VeTO4h55SzyPBnJV0PdTaLdANl+zJmkltmvIsVOUVcGUOjls7wNXdlnd9Zs
         ZlvGl6VQokSuyRVGkoDEhTbYxqf68gyIOT8qXBNWdh+OaFeMOzvImjD1Pt+rNQzBeWTy
         0LZfYkauEz5hI2ysCb3AOqQiVDG504Gwf3UswW9i5lIQs0WURqqXMmfn5u6WxeuVFKFo
         nMj3P7Kf74VAlPHZN7+O6/l+jV/B1x8jU6yanZ+QCVdWl+p7L67ROwWDlOciIruNxUTI
         44nrJ85EA+tGmUcse1go8sngrEzV2BAtymG3584v9hLtkVQSYRbTfNoIo4Bp7bYdR8Xz
         vCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DFRXXvHkZNBSc8cdxXqUjOY/AaTObOXefR9xJkuW0V0=;
        b=tiNFv7k7+la61x0aJUKUdJbb4Cs9ZVFQFO6+SeCDtIDR5ceFXTyFAdS3bIn625qKTO
         5te5q3YxzHYx4NEJPzWDva/KTPFQduVfTFaw5WLE8ShMUh6vYBWDIiK5qnnC/4KB7VnU
         HATd4d2gjM+67zLHGJrSiHaWq9U3zkjXNew/GafMq7ehaoi3GnoLjmchpw9fIr8446O7
         s8Tg9Yq4tn8RDyPNcVrCous0V79lE0jHswHgdYhntRnKxFUYy833iTcKOhPiqMY2HVrZ
         LEq9wpwwsteG2RB1JYYEoFBikX8voPuKQ2ya37fyDaYa6J1izXSFLnF917wDKrXCHGHA
         St0w==
X-Gm-Message-State: APjAAAV5YTOowxYWiz05bB5rPRmgWikUUVQty/9UY9eZlw2nnVoHT9m9
        T8L4xJWAIqkiracihiZ5lWE=
X-Google-Smtp-Source: APXvYqz8hSwvwlWHPaBUQgUU3njEL5oODYDOeaCPaddxJ9Lu47rmSicBqTtZGNYh+h84XlZLTVfBEw==
X-Received: by 2002:a17:902:e912:: with SMTP id cs18mr75409336plb.130.1554272800175;
        Tue, 02 Apr 2019 23:26:40 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id j28sm33842276pgb.46.2019.04.02.23.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 23:26:39 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V5 1/3] USB: serial: f81232: clear overrun flag
Date:   Wed,  3 Apr 2019 14:26:28 +0800
Message-Id: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v5:
	1: Source code base revert to v3 and remove all v4 changes.
	2: Add serial->suspending check in f81232_process_read_urb()
	   before schedule_work(&priv->lsr_work) to avoid race condition.

v4:
	1: Add serial->suspending check in f81232_lsr_worker() to avoid
	   re-trigger
	2: Add port_priv-lsr_work_resched to re-trigger LSR worker

v3:
	1: Add flush_work(&port_priv->lsr_work) in f81232_suspend().

v2:
	1: Add flush_work(&port_priv->lsr_work) in f81232_close().

 drivers/usb/serial/f81232.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..d8a0bb7a41f0 100644
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
@@ -282,6 +284,8 @@ static void f81232_read_int_callback(struct urb *urb)
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
+	struct usb_serial *serial = port->serial;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -315,6 +319,9 @@ static void f81232_process_read_urb(struct urb *urb)
 
 			if (lsr & UART_LSR_OE) {
 				port->icount.overrun++;
+
+				if (!serial->suspending)
+					schedule_work(&priv->lsr_work);
 				tty_insert_flip_char(&port->port, 0,
 						TTY_OVERRUN);
 			}
@@ -556,9 +563,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
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
@@ -603,6 +613,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
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
@@ -613,6 +638,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -632,6 +658,16 @@ static int f81232_port_remove(struct usb_serial_port *port)
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
@@ -655,6 +691,7 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

