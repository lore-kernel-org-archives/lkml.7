Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94E21655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7QlO3Pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfD3BWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:22:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42955 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3BWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:22:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so5932678pln.9;
        Mon, 29 Apr 2019 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EoMvgvSdq7xp2mVjAhF0hgkQM6qSVYMsPBoCdVngzjI=;
        b=c7QlO3Pm+qLe5755G7xHlb6GhkRlzAhC70A+iC1eY4JRlIEANWoK/iDWrhbpzc0LMC
         DgKZDg8E7TAdA461+vb7nL1RWYJNwnkHf3aalSXmz9b4cAvStJFzEouR2Gfo4FTsPPeh
         T3vx6/uqECBqh64qGPU7efV0rOyA3QYS3A2ytwX0xgReD/g/36sJQOJHHphiIIfL7iEN
         hNKoftGwFfcCtVGv9vOKz+L2TRKNS95s9m94/uw3Wlqtl+EVMFW4GwcylLN1owJ0WpqB
         D+ehNtkz2gZIHnEHqjF4/TYW8lGET4f4ECWnjpgAKaY94N3XggTk8kXWK/OP/umUKsQY
         kXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EoMvgvSdq7xp2mVjAhF0hgkQM6qSVYMsPBoCdVngzjI=;
        b=b7OBGq6t1bYD7VNEwI0vcpIYfvrv/7B85MBnzZfWG4kTpGBzHCDttf87HqrrWjVxhu
         trx+kpZPZeos/54+dsTN/zH0hHaBlSQZCBujjvAQ3uxnRaXkdvyBPEEmAXHD1zbPx4fF
         z1n1jNojQLg54bln3/s9LWaZBRWmdfQPEi2BG6sAHSttjPjB9Tc31hsyEVIaFTl6H1NC
         rp8IB44Bh7AzvhWOzRA8cNVPNO8C1TO3vwP5gbFNeIfVxnN+gcBa0nFWrYzQWfhQ86uH
         zn/RYJJ7A1x8E44rX6D7KZAvBHoae3usGV0F6jePghRSpjDfCcOtT79MZuF8ZzIkOc7a
         vgzA==
X-Gm-Message-State: APjAAAXww0CE/HEp62vH/6VPq3ROFWCAFflkDgiX9KZVfPbNmRjUwvqU
        ZqMuo1dsgMUtebybgmkyUhI=
X-Google-Smtp-Source: APXvYqw/LEUE+KiL7EniyAU18MXAjpCPXJormtvvZLg/UGUm3s4DAWZritdQghy25tajK8dfJMFg7g==
X-Received: by 2002:a17:902:7e04:: with SMTP id b4mr44288169plm.211.1556587362108;
        Mon, 29 Apr 2019 18:22:42 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id y3sm11207510pfe.9.2019.04.29.18.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:22:41 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V9 1/4] USB: serial: f81232: fix interrupt worker not stop
Date:   Tue, 30 Apr 2019 09:22:29 +0800
Message-Id: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 will use interrupt worker to handle MSR change.
This patch will fix the issue that interrupt work should stop
in close() and suspend().

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v9:
	1: change the sequence from patch index from 2 to 1.
	2: using tty_port_initialized() to determinate port open state.

v8:
	1: no change

v7:
	1: first introduce to this series patch.

 drivers/usb/serial/f81232.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 0dcdcb4b2cde..d43ec999bc5e 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -556,9 +556,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 static void f81232_close(struct usb_serial_port *port)
 {
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+
 	f81232_port_disable(port);
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
+	flush_work(&port_priv->interrupt_work);
 }
 
 static void f81232_dtr_rts(struct usb_serial_port *port, int on)
@@ -632,6 +635,40 @@ static int f81232_port_remove(struct usb_serial_port *port)
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
+		flush_work(&port_priv->interrupt_work);
+
+	return 0;
+}
+
+static int f81232_resume(struct usb_serial *serial)
+{
+	struct usb_serial_port *port = serial->port[0];
+	int result;
+
+	if (tty_port_initialized(&port->port)) {
+		result = usb_submit_urb(port->interrupt_in_urb, GFP_NOIO);
+		if (result) {
+			dev_err(&port->dev, "submit interrupt urb failed: %d",
+					result);
+			return result;
+		}
+	}
+
+	return usb_serial_generic_resume(serial);
+}
+
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -655,6 +692,8 @@ static struct usb_serial_driver f81232_device = {
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-- 
2.7.4

