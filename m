Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240642073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdJaQVIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfDPI1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:27:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33977 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfDPI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:27:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so9981317pgq.1;
        Tue, 16 Apr 2019 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uhAEkyyjkNnZbB0S3fzuTsDrada7JnXbrIJMvnrBSrI=;
        b=KdJaQVIrbFlAZU1oWu6iHq0Mj3DGxdpIxkVS/fchNgdNzh3Y1bwSDEg6/AzfXu9oq/
         pzd8ZWXE8MwHJg7agrQWGKDIUi5YMls3FRjjjKv3ZBE8bYtpPYrmGu817ttu6zg0Fu8l
         5+2KToS1+o6eh61WVQmIY1xFxu94TRP5Qt6HEVftCPnlhstjeBmgQ0tzCqPGDFdm4Rvi
         rQpbBGx90IRjwAHSe2q4lmaBJnnu7n6Ldyzai1B5zsB7WGyg6aI/22fSItPd6htsh9oV
         CSk/IuoG2IvzwdZmbbvYR8Ti8ojzUqMumGzmSYaGVG0dTP+b3GL1k/mgcSuLG2XDMynk
         fZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uhAEkyyjkNnZbB0S3fzuTsDrada7JnXbrIJMvnrBSrI=;
        b=PyS+LACe5eU88Bx1Fh3ebvCcJ0AqCyg0Cl8TyrG+RyHg9rNbnj6G/1mNoDSIlK5uMc
         VKGifa6XDh6r52t/bJxzAnlXkDiVBbDm5AYdkR3JASyULX+bUI6kN91D3SepTK2dwipI
         1P5ksNFKrnrhguc95qp88q+yXiawYiqK3Qz3ytUlH79tKHd6Nl5SLRUNR6PrLhaV+t1T
         yjI4MA76j7jay+IVCVV1U2ngcbLeAQJtP6fEWPlYqHU7QbEdAZiqC98KN8Vn50mxXjwM
         0MrpI4c4yEHa8OIi35mtjO0xcJsD64GwH24wKrIqOCOqu0C4JVdB1o8L4AUM7L+PxFL0
         9nGA==
X-Gm-Message-State: APjAAAXZz2ieYXTnqcYViyiCCyW3qfEN1q8x14V8qA6EgE6GWXy3CZJs
        v3nTy4Ivw69PFWFcg3EKVMa9y9cI
X-Google-Smtp-Source: APXvYqyUSMKnqCZoxSun45hgeV9BOtz5Hrr2nbAqLEzPXmLGnCL+4AZHiwU177fj41velZ7pkqz13g==
X-Received: by 2002:a65:6144:: with SMTP id o4mr74941023pgv.247.1555403229593;
        Tue, 16 Apr 2019 01:27:09 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id w1sm47325757pfw.101.2019.04.16.01.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:27:09 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V7 1/4] USB: serial: f81232: clear overrun flag
Date:   Tue, 16 Apr 2019 16:27:02 +0800
Message-Id: <1555403225-3430-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v7:
	1: Remove serial->suspending check
	2: Add port priv is_port_open to save port open state. We'll
	   register interrupt-in urb in f81232_resume() when port is
	   opened.
	3: Using usb_kill_urb for read/interrupt urb to ensure urb
	   stopped.

V6:
	1: Add deferred_lsr_work_needed to re-trigger when f81232_resume()

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

 drivers/usb/serial/f81232.c | 97 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..18d3fcf2907a 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -41,12 +41,15 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define FIFO_CONTROL_REGISTER		(0x02 + SERIAL_BASE_ADDRESS)
 #define LINE_CONTROL_REGISTER		(0x03 + SERIAL_BASE_ADDRESS)
 #define MODEM_CONTROL_REGISTER		(0x04 + SERIAL_BASE_ADDRESS)
+#define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
 #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
 
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	bool is_port_open;
+	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
@@ -282,6 +285,7 @@ static void f81232_read_int_callback(struct urb *urb)
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -315,6 +319,7 @@ static void f81232_process_read_urb(struct urb *urb)
 
 			if (lsr & UART_LSR_OE) {
 				port->icount.overrun++;
+				schedule_work(&priv->lsr_work);
 				tty_insert_flip_char(&port->port, 0,
 						TTY_OVERRUN);
 			}
@@ -528,37 +533,52 @@ static int f81232_tiocmset(struct tty_struct *tty,
 
 static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	int result;
-
-	result = f81232_port_enable(port);
-	if (result)
-		return result;
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+	int result = 0;
 
 	/* Setup termios */
 	if (tty)
 		f81232_set_termios(tty, port, NULL);
 
+	mutex_lock(&port_priv->lock);
+
+	result = f81232_port_enable(port);
+	if (result)
+		goto end;
+
 	result = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (result) {
 		dev_err(&port->dev, "%s - failed submitting interrupt urb,"
 			" error %d\n", __func__, result);
-		return result;
+		goto end;
 	}
 
 	result = usb_serial_generic_open(tty, port);
 	if (result) {
 		usb_kill_urb(port->interrupt_in_urb);
-		return result;
+		goto end;
 	}
 
-	return 0;
+	port_priv->is_port_open = true;
+end:
+	mutex_unlock(&port_priv->lock);
+
+	return result;
 }
 
 static void f81232_close(struct usb_serial_port *port)
 {
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+
+	mutex_lock(&port_priv->lock);
+
 	f81232_port_disable(port);
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
+	flush_work(&port_priv->lsr_work);
+	port_priv->is_port_open = false;
+
+	mutex_unlock(&port_priv->lock);
 }
 
 static void f81232_dtr_rts(struct usb_serial_port *port, int on)
@@ -603,6 +623,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
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
@@ -613,6 +648,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -632,6 +668,49 @@ static int f81232_port_remove(struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
+{
+	struct usb_serial_port *port = serial->port[0];
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i)
+		usb_kill_urb(port->read_urbs[i]);
+
+	usb_kill_urb(port->interrupt_in_urb);
+
+	if (port_priv)
+		flush_work(&port_priv->lsr_work);
+
+	return 0;
+}
+
+static int f81232_resume(struct usb_serial *serial)
+{
+	struct usb_serial_port *port = serial->port[0];
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+	int result = 0;
+
+	mutex_lock(&port_priv->lock);
+
+	if (port_priv && port_priv->is_port_open) {
+		result = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
+		if (result) {
+			dev_err(&port->dev,
+					"%s: submit interrupt urb failed: %d",
+					__func__, result);
+			goto end;
+		}
+	}
+
+	result = usb_serial_generic_resume(serial);
+
+end:
+	mutex_unlock(&port_priv->lock);
+
+	return result;
+}
+
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -655,6 +734,8 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

