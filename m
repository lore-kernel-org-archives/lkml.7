Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3829C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6188E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez27oy5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDCG0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:26:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43637 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfDCG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:26:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id m10so7505034plt.10;
        Tue, 02 Apr 2019 23:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSgiNEiAmccUSvUVAZdmUraEr6LWG63D8IydZdtnQ9Q=;
        b=Ez27oy5tv57Qm3PYk/3NYGZ+vVQk/P000G6ZRq3L96hDsLa4yXdKh2enWyqoQwxlNf
         rgQjMWaqS3jP3GgJ1EuRLuY1ZhBW0JIiCl52322l7DY3mRkAPZG1tSE4T7Yo4zlu+9+O
         gtFRfaJ4CdiPWpVFEAKWeiIGczzTfI/a7UpGNEljCfhY6Br0J1+1+CHBc8XRNY1I5pk9
         dNIEev4a96SL/tUApiaLkqd0MqXe6rkzZVr1qirpynEoAKYXGpSYH69x09YJKQabncde
         wfkgZN7aQbc4TRt1mOD8xc7whBqyzP6uEeC59BZ9c4oU29jM04q2AmKc72NgNtbYsSgG
         hgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hSgiNEiAmccUSvUVAZdmUraEr6LWG63D8IydZdtnQ9Q=;
        b=DV1Y1Ay05RmiQVzWErNw++Srq9C4NEaMvSVMshyF8QE8LywbRmaTHylf6HkO6WAAqq
         oB9inBsBU2qNWoTty4xryneBH3+9O9NxByU6k/00RKDktthbTMH/5ppmJkUL+hVYLsko
         uMbga9RSDo/KdjENXIJUcFzywXVKoifonnQH/LY6a8X8uYUT8RiHdG6BeQxFw+2wS1QR
         TkYSI+SEEDYrNafWrSGTprY2AyhZJFQzEAICNaVidrq5XWw9Zk++peufUIvFpXJlq6Sy
         +6F1SzvchNXeIru8PiWBzMiwa2AfXJKm1Rnel0pLRiMAumMlCnKEAR95r+5M/crzUXoA
         1Ecw==
X-Gm-Message-State: APjAAAUv9hgiyP/ehX7lVwsmML8t3LAWpzAvT5SqBm/Q3oIGzlMFGMOe
        RXN61aZld48w64yidSRqaA4=
X-Google-Smtp-Source: APXvYqwOOe5rN1bjMfC2W/dRpRJny18tIBl133uAsMJKKhaQFDSdgFkJf69Cxnb6QMs6cImsbXywwA==
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr689920plp.126.1554272804184;
        Tue, 02 Apr 2019 23:26:44 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id k4sm18621542pgk.1.2019.04.02.23.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 23:26:43 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V5 3/3] USB: serial: f81232: implement break control
Date:   Wed,  3 Apr 2019 14:26:30 +0800
Message-Id: <1554272790-26747-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v5:
	1: no change

v4:
	1: no change

v3:
	1: using shadow_lcr to save LCR in f81232_break_ctl()

 drivers/usb/serial/f81232.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 32eff8fad56a..fe28657b4064 100644
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
@@ -380,13 +381,23 @@ static void f81232_process_read_urb(struct urb *urb)
 
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
@@ -522,6 +533,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -575,11 +587,16 @@ static void f81232_set_termios(struct tty_struct *tty,
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

