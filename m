Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVuvOIRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfC2I3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:29:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfC2I24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:28:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so694489pfm.11;
        Fri, 29 Mar 2019 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2m9R9NREa9VGalybY5Mom3wHFgPLYsbrTO9tvJbZ0FA=;
        b=dVuvOIRXF9eH4X8BPxi53/6YoIJcMDrVruTzMEB1ZZ/lJ84u37qfpHm2sNCtadJ4UP
         dKNWRTiQCENalgy13UWe42bOAks2X8keO+2bNgkQ8i4XXz9ohjhOM6GavqN+cpPxvnF/
         sBlxid34ndo5KA5+W+f2y/5TxIYFYUWbi9tL8+yn5E01bLyD5D4X/6MzE3TqRYMoHb9x
         4X3REtxyX0hyAIdvP3OIc0Qg82eqgL+L6chhbSjQLO2na+a25DRdhAJ5vpgw8JKnznaP
         sMXlLiKk9IbHIWQsXLJ+v+m6sHHUyoYVV6uqe+b5AHRippn1qs5xevBHq9xf5J4drBxE
         quiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2m9R9NREa9VGalybY5Mom3wHFgPLYsbrTO9tvJbZ0FA=;
        b=H0zhj+bnbFgSAHKVUgIWr9eQKOg9zW3/BF5uUutofhF7q567Saa/pPX0R74bTvIlKS
         iFF8V6tU8j6X7atNdb6BKApmENtpIpqDVNOGY7YJpAK37cuyIG8Ce1/Y1qsbBzm6mPC/
         qaP5RvNNgsJ26vH9tPTn9NDImKoCvHO/Ir7XdTwivmYRQDYhyoiwLc9W+aD5J84qWk2W
         tyE/ImlbaGOjnS/F/DxoJjFcoIm9LNkmQGuPFDixfPd1xtmWEH3dhyoezGClUyhgt+NW
         L4Aakjsib7koxNu9sg9yUCCscYeIkVcrqau4e1SIJOk6LqAUbmxx4bJyfGczVdNDT2Ag
         M1Dg==
X-Gm-Message-State: APjAAAUqlxYekLvhrbfqZltKZTkiP+zvkKMEgOvfAWxKkfme4ri7T80i
        AL6JxvFNwPUZ5jt73oWf2sY=
X-Google-Smtp-Source: APXvYqx1aGUjU0U/VK/+r2eYUXva1lsw1FOYFIQQRKpo5a1tuC43Cu2sHY1aqTu/1RpvPt8ZTH57yA==
X-Received: by 2002:a62:1ac3:: with SMTP id a186mr45206215pfa.48.1553848135423;
        Fri, 29 Mar 2019 01:28:55 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id a65sm3867408pgc.72.2019.03.29.01.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 01:28:54 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 3/3] USB: serial: f81232: implement break control
Date:   Fri, 29 Mar 2019 16:28:42 +0800
Message-Id: <1553848122-1227-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553848122-1227-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1553848122-1227-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index e7862997b6e4..9377b827313a 100644
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

