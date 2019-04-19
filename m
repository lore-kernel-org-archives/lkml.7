Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DEC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAF72171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/jPeefr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDSCpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:45:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfDSCps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:45:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so1958720pfo.6;
        Thu, 18 Apr 2019 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=huet5IvXuGZORtjsh3mDCkw5xIOcvfTPvi/dI3SmUkE=;
        b=P/jPeefrTZ9ia6XkdAaGXpWPOoW0rlCOyndpS8aPKgrqsDGT2HGIYBGr4ek2Lwe3MR
         5gSd+qNsqpafx8Y8DNQw8F+hTQnVBFCbn2kQRGd0sLBz2xCkBiyfAHpWpg10LuIXOtdw
         jwa2YKaKZqAtSW4DIiYmhKZsNzdBzqSa/PdWrzY8KDGsg55kiwmHqPcwe/Ae2WSvqpNt
         hNUUck54iki+t775QC4oTKJSK8ZC12wwxQzXjSUSkKbLoEdwOsHxkVJ0WBDGckI1vmWD
         QG2UA7vlEf1I7B1yFFL0ejszsVmXm+OxmMb97fhoCnB2EJBQFMn6m0MahuZlZxmV4MBR
         UiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=huet5IvXuGZORtjsh3mDCkw5xIOcvfTPvi/dI3SmUkE=;
        b=krJPcLNqHN33xi8p4Fqmm8Vm0B6MFBYF210Yr39zizWdGkfwOPeo04u3GbLULM6zxv
         MKkT1kYrzZIQVCvN0DsfG+DEExhg6xyOAoguEoZ3LkpGeUG4LikkE7WFUybjbKUI6YVH
         uqnMK4ok1o3hjQkL55tNv74ehw4+h/Dx7Y1lDIQdyXdRj7dt1WIki0DuWyGnGb5aEx2b
         JKC4U8narcd3TbZz45VWMt//Yr0I4juze8uaAep3w3TAiWNqSpkOfCIWdxlkLVawINkK
         ELQUb6JwLDWjVoQDJspWes14BhF2TnSZqD4Ksuu2nQu7hruG2lfH8tAbD+USCem98iXm
         05yA==
X-Gm-Message-State: APjAAAUNt6zx+lYUDVu0SQ4XaOq9a9Eo9gXj+KJDeQ0jVi30m5ACr+Gi
        uIFEY+n68oT82b0fNJCH8TM=
X-Google-Smtp-Source: APXvYqwPGV1dhdsc9b334rrqCHLL2ti/PtTp6GWSj/U9VRU6GFND2UohUZydNf1SZg7iWXoS/6eTxg==
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr1116653pfq.201.1555641947595;
        Thu, 18 Apr 2019 19:45:47 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id i135sm4108844pgd.41.2019.04.18.19.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 19:45:47 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V8 4/4] USB: serial: f81232: implement break control
Date:   Fri, 19 Apr 2019 10:45:33 +0800
Message-Id: <1555641933-19336-4-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
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
index 3da70f406a81..d852bf3b8df8 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	bool is_port_open;
 	speed_t baud_base;
 	struct work_struct lsr_work;
@@ -378,13 +379,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
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
@@ -520,6 +531,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -573,11 +585,16 @@ static void f81232_set_termios(struct tty_struct *tty,
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

