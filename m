Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915ABC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B2D206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi5Tmppc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfDCIkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:40:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33337 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfDCIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:40:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so5798168plo.0;
        Wed, 03 Apr 2019 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlyKAeR1mEcrMfe+fwc6wsVdLhc2SdEq/zOCkkdLvP8=;
        b=oi5TmppckJJBLh5Y5SQjFrJl0OMNgTyVQ5klqlZ3Eqmn4518SQlbM2UgYLJrzDeLVW
         WvufHklUUCt1TV85IaITVsDBWsm7U30SS3utc3xwqPfVxtjjGBEs/0GSBbx8XFmfK/np
         jxh/+LOJWE99g69ruLuQB/oTwRmSXjDNAuXsJix5c18iki9T5rALl7BSZjcxgZEooeWf
         udXdnfz1KgzfXz6C1YMTHalnKAkwvUvmqFOqN9MsnQd35RDWOLxCmeH9gPWmlH2R1FVM
         gGqGxwLuRBXvKmw/q3SGExpbjMC/T4qiAENHcxmW+IJzE8avSVxwUdr5l7hp6DKcze4v
         Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hlyKAeR1mEcrMfe+fwc6wsVdLhc2SdEq/zOCkkdLvP8=;
        b=AbD5wKV+aiF830hyLZW24s36Om0No267ucgmAGjmqJRZVsAGLevUu/5BpOoyBzVSwF
         tBY8p6mFFY4ubW8TqWQ6aSByALAZTsNNlfoBtRRzsjQjMSbbkm6enerC9cTBZv4CO//c
         94+LFuoCb4LP7E2Dgu+KYpi4v3D31NMgAI/ZPpuOv0JepCSEPH3/PB+4anMxaUZD9Avd
         xGkDF31ficIvMwYOaPVVNYRGSf1jyijnTBWqfTXfc/T/ZwNc8Oxgf1ntaSJyWy3kq33k
         mRJQzm4HjjchclCtuAS7QUIiM/OoZGY+/i1VL1+PdbOETFQpFlixm+dXn1CidJe8Ak0c
         uCjA==
X-Gm-Message-State: APjAAAXQyeiB1z+nr3Bc1RsnIbQjJsdpLWzfTRqM8kSlchHdJB85kJEp
        Phs2m1Y++m0HmfQ8y/AOnnk=
X-Google-Smtp-Source: APXvYqx3RWB9Hd+qlo/thlRSj3MjABovFTI+PhkoFof78R36MpqObFNs/xKOCcMeGHv9uKSV34fvgw==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr75538400plc.238.1554280841622;
        Wed, 03 Apr 2019 01:40:41 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id z8sm20389082pgz.3.2019.04.03.01.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:40:41 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V6 3/3] USB: serial: f81232: implement break control
Date:   Wed,  3 Apr 2019 16:40:32 +0800
Message-Id: <1554280832-29286-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
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
index 2c0c904dbc33..f60f636c927a 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	u8 shadow_lcr;
 	bool deferred_lsr_work_needed;
 	speed_t baud_base;
 	struct work_struct lsr_work;
@@ -384,13 +385,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
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
@@ -526,6 +537,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -579,11 +591,16 @@ static void f81232_set_termios(struct tty_struct *tty,
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

