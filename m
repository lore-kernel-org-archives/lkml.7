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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5D1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96F4206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTf2QaeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfDCIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:40:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:40:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so3597738pgc.4;
        Wed, 03 Apr 2019 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aM2h7Uy7SZKtM8C0EfW2GUNH1XIUxG3SsKixMsxZK4Q=;
        b=jTf2QaePVkgzP5yVJgfn+3XMWUuVyIm3nnfI6zaTGX+gnpRNbS2EToVH+WbJyeSPw6
         IVExptzbgAqCP/W/h3CWEJip+zN2qJzZLCFcAPVJhOAen1qfanuE7et0Qp00aKZ/Gx/G
         7K8+SRF3+MJakxmvLjNr5qIcj0dSLy+RfdGrtHvPPuiY6GQofkBq1R0q3Xc3jcWJCqO3
         MqUrhiCD6Y6iHU2sea14k93WILx0vIownZPWnqSMnA0pW4y4JTMfdiZmAiGACpiJ7CTR
         a/4pJQ7zDK9Cio9Rn/dDaw7UsP2QGjO7Wb0UA6uT/PCDrkyjR9Uukr48PWGqCMtV8bu4
         gUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aM2h7Uy7SZKtM8C0EfW2GUNH1XIUxG3SsKixMsxZK4Q=;
        b=m10lRdGuIejrAOSyhSLdO6n8RSPFexwpclN3KVvkyPSyMFhdjylManeyj1ierYX1jZ
         6CaeA/0bw7EfiQx2Eb996FQBcusrfbwHFl4tHueX0waRBw+LInzPfA5KGiW7rtY0aYpv
         3jZAODPJtmmlKdJ0LUl/Ssdap5Z4VQMYKedkmwzP+sapwsbzRNmEb6nhkaq7fRTOitAp
         3m0pNhRMOveH/d8F79bvWT5gERNeVHWrnzu6Rg4f3KTsrtVECPSDtk1VH+oWJ9RXUdM2
         CqOc8rqDCpaz7sXA4tKMA9hlb9jgCXSXQCVmcrjoFifB6mP+UbNbxdWspu6XSsC3fEho
         iATQ==
X-Gm-Message-State: APjAAAUTui8xZOTvZrMHVnJ6yuHUKEE6F6BkpcWoNU5P4TNJM5FIIOHd
        F7JC4648E+7RqvLSPRmJdgo=
X-Google-Smtp-Source: APXvYqyDKux11Uf0SXqGFn79aEwz6/XhzcCO/Fz5loG25ods8KZLNlaHtvGzNdDp5vu/54KU7x69Xw==
X-Received: by 2002:a63:3190:: with SMTP id x138mr64048908pgx.273.1554280838057;
        Wed, 03 Apr 2019 01:40:38 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id d15sm22997514pfo.34.2019.04.03.01.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:40:37 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V6 1/3] USB: serial: f81232: clear overrun flag
Date:   Wed,  3 Apr 2019 16:40:30 +0800
Message-Id: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
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

 drivers/usb/serial/f81232.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..600e1f4d94e0 100644
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
+	bool deferred_lsr_work_needed;
+	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
@@ -282,6 +285,8 @@ static void f81232_read_int_callback(struct urb *urb)
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
+	struct usb_serial *serial = port->serial;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -315,6 +320,12 @@ static void f81232_process_read_urb(struct urb *urb)
 
 			if (lsr & UART_LSR_OE) {
 				port->icount.overrun++;
+
+				if (!serial->suspending)
+					schedule_work(&priv->lsr_work);
+				else
+					priv->deferred_lsr_work_needed = true;
+
 				tty_insert_flip_char(&port->port, 0,
 						TTY_OVERRUN);
 			}
@@ -556,9 +567,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
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
@@ -603,6 +617,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
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
@@ -613,6 +642,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
@@ -632,6 +662,29 @@ static int f81232_port_remove(struct usb_serial_port *port)
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
+	if (port_priv->deferred_lsr_work_needed) {
+		port_priv->deferred_lsr_work_needed = false;
+		schedule_work(&port_priv->lsr_work);
+	}
+
+	return usb_serial_generic_resume(serial);
+}
+
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -655,6 +708,8 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

