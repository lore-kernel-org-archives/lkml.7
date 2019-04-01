Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6327120896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6CMGb2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfDAGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:01:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44460 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfDAGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:01:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so3917030pll.11;
        Sun, 31 Mar 2019 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WYOkD4WgtON7NhXbdDKs2RAxRCJMONjiGs3aKy+Ykfk=;
        b=T6CMGb2bOCzDyzaHbl6Ln381abefwxUHUn4bBBotbbbHsX12iLD1FgvtTX34yAv2jP
         qNgGiUNGoDEg5C1fBvhEdUg+Wk9+NyPVuRdE51wMzwxlO4bw0TFtKSO2uEHlsAytyjQa
         Yr/PPFGynUHglFc2xcfIXkhWwpwC73W9PdxGgEWeHePhByhaUY//5BNjApRcKeLbPK4U
         iZGuqQLahdVEAcDfjuLYaDJWAVjmC30W7XZcxNLNADg5KqnOLC3soQ/qeYwvFfmIktT8
         HOmuEXN/ymdh2xS6qsC6AkH1JXY4YtXjtKk8Rp3yLKVRgV6nC8V3wiStZkwRVOOm28V6
         mm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WYOkD4WgtON7NhXbdDKs2RAxRCJMONjiGs3aKy+Ykfk=;
        b=HhqCc3kb7yG7fyIW+INAaVYtvhsQsIuPd6Y6DxlilNfLUfbzbnC/eM5C2AZx5PkiMU
         VzWXKO+dXW8Wxf1qhY6gSfVo4chSDNEvPIb2yaf6kfF/Vmb7Fm4h9+JKUDbvQMlxhCkL
         FI0u1IG8+wWSynzH4cAeIFYofGISfiKYh6C0zHn/ARdZTpMiKBw04kQ7jzhP7o42TdI5
         ctWE9H+oOx2nWdwuz7F5a6uGwtbPm8cZzhXWPQ/V/UkMjkSsu4TYjYji/5OV5nSEyCIw
         xUxyr7w4lzih8MlQMFFpeK9wiKZxJw5+heVulhJEsGl3ZFgE5PVOTmiPVV6r4QBiF+Ok
         DZxg==
X-Gm-Message-State: APjAAAWLsW5fkkCNGGjtfoeT8vhU8uGf6tZwVnjUAcpnRTITxgtGOFL1
        pLBsm4BiqnJ7zuRz9vSasDQ=
X-Google-Smtp-Source: APXvYqxzhKeH71Tc1IGBxU26XIHkXfg2XbjzPJtp5hOoYvfP8iyGdiNFoomhGmaTUtrHqY3DWR6Csw==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr4090769pll.12.1554098462172;
        Sun, 31 Mar 2019 23:01:02 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id d129sm8529761pfa.142.2019.03.31.23.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 23:01:01 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [RESEND PATCH V3 1/3] USB: serial: f81232: clear overrun flag
Date:   Mon,  1 Apr 2019 14:00:51 +0800
Message-Id: <1554098453-31278-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v3:
	1: Add flush_work(&port_priv->lsr_work) in f81232_suspend().

v2:
	1: Add flush_work(&port_priv->lsr_work) in f81232_close().

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

