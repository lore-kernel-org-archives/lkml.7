Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B318C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FB6217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZX2sySY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDSCpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:45:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39127 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:45:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so1958641pfo.6;
        Thu, 18 Apr 2019 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGjxE57b+sAJtijpBTPtqZ9fwf0KWs86liucmXiKgLc=;
        b=FZX2sySY0mAIx85oNvUgXhxW4/mChLYkZ3MLfwdE0bSjaFdcxeKGyvyLGn9KWw2xA4
         a56YpT7SnA/kgLfsXUKIw0H8WhXIsVQC63BhyiFqtBh/DJ49Gz7ZVkk3admhaUCZbReB
         esalGMra5iMZnsyY+4zE1SWi0RG3bOtaAQKk2FLRMB1mMEOaD7Ilh2ST5NcrcmVLDUeU
         +RXCizDFRnSTCANhjj8voynyRSQF63xE3iqKAjJP8K2ksM3/RNymYQgyLg2F++sQFuKk
         K7VKIwuJNzcXr7KETSvhamXP/ApArbNZli+/ihFgzcGMbiZhcrU8IYge5ZVhQMJzZci6
         0BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGjxE57b+sAJtijpBTPtqZ9fwf0KWs86liucmXiKgLc=;
        b=WO8MOOQuq1X7MNnQTzwnQHFp17atZ6Z2/Sx+oRlem4qU8XCa+BFo1o7r90RuIX4Zoe
         AmEsha1Y+8WARo24955HRpdxlNB/GjlhHihnFAbbYnOh1t18kGnx48m0g2hIwSC6tzoc
         pJmyWt5gXfWa6EuvCc7qSzWfSAs7IJMCeEYNj5AUBzMn7pb+KgSEBvgGbjKFcyVZL2Io
         c5dkYXA230U+INVx0Zz8VTeBmtTCX+PDb3FGmrInCUGgeqnczeiFyMmOZcEhdwA2I3Uz
         mZNuwChwBo9L8Amt8/jY+y8vcocJsqz6kI2mBVPtBQNZHK5zza9GUqhQKB0QuWZjmAvb
         7cGA==
X-Gm-Message-State: APjAAAUnJ7etr+DpIIBbD40fV1IKqvJbDsZo63pUvQP5StZm3YsI8v3+
        7cRBvuJWDRIIhYZpw8iYLfM=
X-Google-Smtp-Source: APXvYqytEvGEN3UvH6ThjFtqihx/0qfRrRIxtpZJDUpo0KcNGbdmmPGz+7iaLwRYQQMXGYNZNCBCag==
X-Received: by 2002:a63:1359:: with SMTP id 25mr1447049pgt.92.1555641942177;
        Thu, 18 Apr 2019 19:45:42 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id c1sm3363317pgq.33.2019.04.18.19.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 19:45:41 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V8 1/4] USB: serial: f81232: clear overrun flag
Date:   Fri, 19 Apr 2019 10:45:30 +0800
Message-Id: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v8:
	1: Fix usb_submit_urb() in f81232_resume() with GFP_NOIO, not
	   GFP_KERNEL.

v7:
	1: Remove serial->suspending check
	2: Add port priv is_port_open to save port open state. We'll
	   register interrupt-in urb in f81232_resume() when port is
	   opened.
	3: Using usb_kill_urb for read/interrupt urb to ensure urb
	   stopped.

v6:
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
index 0dcdcb4b2cde..1f0dd4087d79 100644
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
+		result = usb_submit_urb(port->interrupt_in_urb, GFP_NOIO);
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

