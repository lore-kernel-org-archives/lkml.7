Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D05216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/pE20HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfD3BWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:22:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37915 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3BWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:22:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so6224870pfo.5;
        Mon, 29 Apr 2019 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/34HtZ0ItBu2q8PiQCCmitcY2PUSurP/IKvZz4bka9M=;
        b=J/pE20HByyCtHTBS0K8ialHsJw49MhV1FCQBXAT8dgF5VJ/P9TMTmVGydpAmM3BXD6
         cJ2H8/4ZhNzHF/w03baN6TTQWLvqV+9FWKZ2lq4tntBV2oOrr76LvRkmb3Y7wR/ZE5pV
         V4AV49b2tZUiczidPJHQ9YCrR1oPQT3bqNFRCQVDZqiYFrFzu2tS9+e0khnhPyB6zU3L
         Mu+dzyifzVS5FWjCgVJe/u4Kg8YWJmTD+rLs16BMZ7GBx+xQK5knl1gR3tWu4U7DBY/K
         UKNocCw7KXUjFR6+ZLZCCdBBRJ01QP9NU2AaiXe0fUuJUeMKP2AHmn+KSxsVzVuoXqMb
         iwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/34HtZ0ItBu2q8PiQCCmitcY2PUSurP/IKvZz4bka9M=;
        b=Gcv/rtGejbMdCVqn0WiRixRG0s0M4DSbzI4B2TL1oiSxCrw6qnH8tppvCD2ByOIkGR
         BMdeH/VZXz7FxH/dlQbYCORIYwEzyPDd3qzkTfDzD3tvkoSrrCpnBHoJsekgoKhjZlhQ
         d5DVduHVutMda3fvH6WE4zJp7riYCHbZ9sBeW6rLr5yhlj5714+FsR2gLjkIMF64XbRV
         A+M0mgB7lxXhw+DpYOdIkvCk8TdLBsZJ1Iz+5OTCdaJiSOLcnamv5HHKQkFwkCX9kyx/
         xve/6NZYJTrocSO5cPM70IEw4OxD1LC4hAYPnyupG1CJTOkqjOa2ZyLhShnwTcJnIsct
         p1zA==
X-Gm-Message-State: APjAAAUjlT89FaOpTY6z/zc8jaLBm+tyS4pz40lZpHgIUSrGbZPzgEgq
        zjeAptrorFhDvtaS+F2WkHA=
X-Google-Smtp-Source: APXvYqwc9yTp5jx88vjrv51gs13PdtFbfK3bdbaikArQGi2tAAdy+yEmclh1GV3Q5mK30ulNRfsyAw==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr336712pfd.116.1556587364185;
        Mon, 29 Apr 2019 18:22:44 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id m8sm53912262pgn.59.2019.04.29.18.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:22:43 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V9 2/4] USB: serial: f81232: clear overrun flag
Date:   Tue, 30 Apr 2019 09:22:30 +0800
Message-Id: <1556587352-19500-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v9:
	1: change the patch index from 1 to 2.

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

 drivers/usb/serial/f81232.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index d43ec999bc5e..f0de20a818cd 100644
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
@@ -562,6 +566,7 @@ static void f81232_close(struct usb_serial_port *port)
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
 	flush_work(&port_priv->interrupt_work);
+	flush_work(&port_priv->lsr_work);
 }
 
 static void f81232_dtr_rts(struct usb_serial_port *port, int on)
@@ -606,6 +611,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
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
@@ -616,6 +636,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -646,8 +667,10 @@ static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 
 	usb_kill_urb(port->interrupt_in_urb);
 
-	if (port_priv)
+	if (port_priv) {
 		flush_work(&port_priv->interrupt_work);
+		flush_work(&port_priv->lsr_work);
+	}
 
 	return 0;
 }
-- 
2.7.4

