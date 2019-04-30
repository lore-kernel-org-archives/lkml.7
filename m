Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C8021655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nplkksJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfD3BWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:22:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34887 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbfD3BWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:22:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so6227521pfh.2;
        Mon, 29 Apr 2019 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14BtYvopEGYF3ZyX/uprrfiK7My6iDbeW5Kct6Ko73U=;
        b=nplkksJwpY6fgI5iJvv5KU0Ks/zSTkh+fr7UVRw5o0CqPzmEuk+VHDefPvenM/2HrO
         NCjOx+1e0KMG94NEfDxm5qVGCjPklp2QnqVBWIJ1AeDxiYf9bI6MKpBkZ8q3KKpdwwv3
         V3dev3KJ0lzk4mCS3llYiGEhf+jofS7Q+HyzSYBEAP/rGnd07j2Pb6mlfP3mrxK5pfbs
         9uDA1JnssqHBgqdfNIh+WofAKY3qFwFu+PX3btxPf2chTknzY3cS/X0280i80xEOvVHG
         qegRmBwatwTzkqMwG5Tn8bvjYU3DwCskpM9dXmVRuxEn3dA/r29URAryWJ50XsUSMEBh
         E8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14BtYvopEGYF3ZyX/uprrfiK7My6iDbeW5Kct6Ko73U=;
        b=bkiN7k3tU2RovOsvdUjBd5hkWP8FDTSvcFvXhNO6N3/yF8PAHIEJdZcnTE8cMgnxhK
         W7tq9Y9s25NuXF33WWg3RIIbrQcxkG0Gqw2spW5mxD+f7yuErzCzf5jKoZVbw31bYrKy
         0QyIrphqTS5m8nTTI6A0KOSyhS7b3cs524PEQbWti4IKzWXx4sZc2fYXSHVi7gMYOlnO
         wvZC4vQcd9kA/q/cDP0Z/rPb8gWtszudEH63GmpaI6m346fX9ncTkIhvsTdkkK9FtMsN
         SzZE4JDqPEvcvebmFKXgaf0Pi+LTjrmUmvx9UkO2w504+lmu//0pjUyOncDlnXSH9WNq
         kbvQ==
X-Gm-Message-State: APjAAAVxjm2uvqXhzT9QhCdg5ncbTEfs4f+F1o/cAb7Tg8KrxQzourlr
        3N6ThyHzcuLqyftIqtYSoec=
X-Google-Smtp-Source: APXvYqwbKT8sggQIxWyPbcv7B73rzvWgAB9NGay/Tkv1ZV8WIg4+0s0TZsiTmORgm/fT02eiQ2iFfw==
X-Received: by 2002:a63:7:: with SMTP id 7mr4583794pga.108.1556587367869;
        Mon, 29 Apr 2019 18:22:47 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id s74sm353739pfs.26.2019.04.29.18.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:22:47 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V9 4/4] USB: serial: f81232: implement break control
Date:   Tue, 30 Apr 2019 09:22:32 +0800
Message-Id: <1556587352-19500-4-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v9:
	1: no change

v8:
	1: no change

v7:
	1: no change

v6:
	1: no change

v5:
	1: no change

v4:
	1: no change

v3:
	1: using shadow_lcr to save LCR in f81232_break_ctl()

 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 6a1e6a27ce16..562c9babd144 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
@@ -377,13 +378,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
-	/* FIXME - Stubbed out for now */
+	struct usb_serial_port *port = tty->driver_data;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	int status;
 
-	/*
-	 * break_state = -1 to turn on break, and 0 to turn off break
-	 * see drivers/char/tty_io.c to see it used.
-	 * last_set_data_urb_value NEVER has the break bit set in it.
-	 */
+	mutex_lock(&priv->lock);
+
+	if (break_state)
+		priv->shadow_lcr |= UART_LCR_SBC;
+	else
+		priv->shadow_lcr &= ~UART_LCR_SBC;
+
+	status = f81232_set_register(port, LINE_CONTROL_REGISTER,
+					priv->shadow_lcr);
+	if (status)
+		dev_err(&port->dev, "set break failed: %d\n", status);
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_find_clk(speed_t baudrate)
@@ -519,6 +530,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -572,11 +584,16 @@ static void f81232_set_termios(struct tty_struct *tty,
 		break;
 	}
 
+	mutex_lock(&priv->lock);
+
+	new_lcr |= (priv->shadow_lcr & UART_LCR_SBC);
 	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
 	if (status) {
 		dev_err(&port->dev, "%s failed to set LCR: %d\n",
 			__func__, status);
 	}
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_tiocmget(struct tty_struct *tty)
-- 
2.7.4

