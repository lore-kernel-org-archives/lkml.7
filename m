Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578F2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnBhIe3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfDBF0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:26:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33931 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBF0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:26:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5752858pfd.1;
        Mon, 01 Apr 2019 22:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h1Rz7FwUlQEs1imjf/fXLo8qWzMks7/g0ibmUh4oRGU=;
        b=gnBhIe3db80scY67sTeM5vmQ9QYZEucaHsor4mSR+WtlL6NVWb9CAwd3Cdtruffkr4
         Xhxh+k0ytVBMME0Ixp7Uqt+YrNHgQF/N4UyTdBGVSMBZMLGCY/5HZPt+0I10wBEmqSEx
         sXER5NWKBehnVCMX751BlI45QnLoZnGZElykAc8DXnGep2f0NHKtCe1EFmnpwXLDghBW
         +MZUYdtDVahocsJIafQV2z8UFEw/pmWE7T7oQWztKyv3cBXJR41tQLm0TBlq2I86n7xd
         QMZQCJJGiryZj7gxW/t3143kc/soqzMq2Fu5gKymjIi+m3yMHzySeW+aC0ISOaIoOdoM
         B01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h1Rz7FwUlQEs1imjf/fXLo8qWzMks7/g0ibmUh4oRGU=;
        b=kB+mC04hUypnPfA5kyTBtabaRN0vn6MltGELm0z7lu2hkRI2FLjKP5r0rRjF94R7ZF
         5GO400j52z3oI2UWWzLcvTbSK1YYeS8bctODbfbzdBSy4FGEQx9bpFDrgt2NRKwcuQe4
         6ajiQVqOqcp4TcnHXlJVquftLkqNHA7eIkKb9xFR39kPexHO9JLTA68/9QiQ9XvbdPEb
         OVEdbQYvKZGRMiifYv8vcAODtQIgTqc0UFrT2pxWow1usuvDefD6en5GDvq2k/r/F9aH
         PIVFrQ1iTUEaSgFkykI94R9lQl7jQ0IoS+BbQt6Uk2RPwKcfSqQvbPfv78XHmdOMcMJL
         crvQ==
X-Gm-Message-State: APjAAAUZQGT1erD404JodLrah8i8aIus0lV+1uaEpnw/FOGHBTvo3DzB
        LhqTIu5mfb7/nVTYZg53hsw=
X-Google-Smtp-Source: APXvYqy1DTyrdD42hhtymhKApO8V4SfprjongD8AKAPxmXRxUEns89M+hLb2U6jTz7Wa/UlAx+xr0Q==
X-Received: by 2002:a63:5858:: with SMTP id i24mr64054459pgm.222.1554182801538;
        Mon, 01 Apr 2019 22:26:41 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id j71sm21867829pfc.6.2019.04.01.22.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 22:26:40 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V4 1/3] USB: serial: f81232: clear overrun flag
Date:   Tue,  2 Apr 2019 13:26:35 +0800
Message-Id: <1554182797-12815-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v4:
	1: Add serial->suspending check in f81232_lsr_worker() to avoid
	   re-trigger
	2: Add port_priv-lsr_work_resched to re-trigger LSR worker

v3:
	1: Add flush_work(&port_priv->lsr_work) in f81232_suspend().

v2:
	1: Add flush_work(&port_priv->lsr_work) in f81232_close().

 drivers/usb/serial/f81232.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..9345f13274e9 100644
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
+	bool lsr_work_resched;
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
@@ -556,9 +561,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
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
@@ -603,6 +611,28 @@ static void  f81232_interrupt_work(struct work_struct *work)
 	f81232_read_msr(priv->port);
 }
 
+static void f81232_lsr_worker(struct work_struct *work)
+{
+	struct f81232_private *priv;
+	struct usb_serial_port *port;
+	struct usb_serial *serial;
+	int status;
+	u8 tmp;
+
+	priv = container_of(work, struct f81232_private, lsr_work);
+	port = priv->port;
+	serial = port->serial;
+
+	if (serial->suspending) {
+		priv->lsr_work_resched = true;
+		return;
+	}
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (status)
+		dev_warn(&port->dev, "read LSR failed: %d\n", status);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -613,6 +643,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -632,6 +663,30 @@ static int f81232_port_remove(struct usb_serial_port *port)
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
+static int f81232_resume(struct usb_serial *serial)
+{
+	struct f81232_private *port_priv;
+
+	port_priv = usb_get_serial_port_data(serial->port[0]);
+
+	if (port_priv->lsr_work_resched) {
+		port_priv->lsr_work_resched = false;
+		schedule_work(&port_priv->lsr_work);
+	}
+
+	return usb_serial_generic_resume(serial);
+}
+
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -655,6 +710,8 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

