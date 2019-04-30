Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12618C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC21721655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyOEivJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfD3BW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:22:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfD3BWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:22:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so1640280plb.1;
        Mon, 29 Apr 2019 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyq7XsF7BNdC5zFoADwb0oshhkuj91CQd2vxvhaEuJA=;
        b=SyOEivJZuMRcKf8BzXSw/KkD3C16LIp3BGAq1TlnKcV4wDsiyoT9mDLZXkzx8a1/rI
         BEPEqTPcb951ID/DP/ok6do1wfcuFwSHoC33YUy2U9q7AsXpEqcr1671P/6ccX+GzMZX
         k6Sr6lwIiHGeJloQXrcidDc/qutVSPGJl1mMH03W9mxCWmY6eePW3xSzYLiIV1X3fHsp
         XKQCzPEHC0n8b5K3wgRt2dn0bBUmVQ29QkK47+iZyHxwxOdux5uWj9hDad9vZ1uftiWL
         fsVCt7WwGWA8/JkoS0FtSl/gAhVZ7IsUBVhtpXkRMYHw/qNyUiZtjbEU96oYKv+YHk+3
         Mx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyq7XsF7BNdC5zFoADwb0oshhkuj91CQd2vxvhaEuJA=;
        b=Dei14TFQXpnSXdx9FcurIC3o0pzWVMuU4YXvDD/3hbg8fCBDXOnglp+ubBRtJoykev
         TzrFBRPAObWB9t4WqQyfPM6cRyKTvd8eVd08It7i3l2Clre62Z8ir+Q8JTk1SaEwIjUQ
         MGaGVHr/kUZeTsrxlgtlla8+/Sz2zyT0nECk/Yf0yFX1KYu8sWRxCeCZaeH3sLHzhUCt
         yLVY7tQJ9TfJSIoQCH0A4mjy6WGLCcm7PMT0mnKGXKxmz9MFqbfMPJAeFUjAIg5gOwPb
         tblU+rasHZWTUZnxlLLXe7PDnCNoFQWAZiL2ckAqOCPEe7wCEpbUVxoHefglRJ9koFZW
         oNsA==
X-Gm-Message-State: APjAAAVW2GRnFha9lY24t/aNfWNY/ao4w+2Barwl7IkKDh4YP3hh+ydb
        +14gyxhBgsTvyiuGgC/tZWg=
X-Google-Smtp-Source: APXvYqwjllRUrhMvRfk1VXPh+sv2pFEFCJUnIEn9d7vFL8WusQNwQ+X6nufHAqfy+lqpWep48RPRtA==
X-Received: by 2002:a17:902:7205:: with SMTP id ba5mr45141406plb.285.1556587366008;
        Mon, 29 Apr 2019 18:22:46 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id k186sm59003856pfc.137.2019.04.29.18.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:22:45 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V9 3/4] USB: serial: f81232: add high baud rate support
Date:   Tue, 30 Apr 2019 09:22:31 +0800
Message-Id: <1556587352-19500-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 had 4 clocksource 1.846/18.46/14.77/24MHz and baud rates
can be up to 1.5Mbits with 24MHz.

F81232 Clock registers (106h)

Bit1-0:     Clock source selector
                    00: 1.846MHz.
                    01: 18.46MHz.
                    10: 24MHz.
                    11: 14.77MHz.

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
	1: change the baud_base in f81232_get_serial_info()

 drivers/usb/serial/f81232.c | 105 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index f0de20a818cd..6a1e6a27ce16 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -28,7 +28,8 @@ static const struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 /* Maximum baudrate for F81232 */
-#define F81232_MAX_BAUDRATE		115200
+#define F81232_MAX_BAUDRATE		1500000
+#define F81232_DEF_BAUDRATE		9600
 
 /* USB Control EP parameter */
 #define F81232_REGISTER_REQUEST		0xa0
@@ -44,18 +45,42 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
 #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
 
+/*
+ * F81232 Clock registers (106h)
+ *
+ * Bit1-0:	Clock source selector
+ *			00: 1.846MHz.
+ *			01: 18.46MHz.
+ *			10: 24MHz.
+ *			11: 14.77MHz.
+ */
+#define F81232_CLK_REGISTER		0x106
+#define F81232_CLK_1_846_MHZ		0
+#define F81232_CLK_18_46_MHZ		BIT(0)
+#define F81232_CLK_24_MHZ		BIT(1)
+#define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
+#define F81232_CLK_MASK			GENMASK(1, 0)
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
 
-static int calc_baud_divisor(speed_t baudrate)
+static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
+static u8 const clock_table[] = { F81232_CLK_1_846_MHZ, F81232_CLK_14_77_MHZ,
+				F81232_CLK_18_46_MHZ, F81232_CLK_24_MHZ };
+
+static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
 {
-	return DIV_ROUND_CLOSEST(F81232_MAX_BAUDRATE, baudrate);
+	if (!baudrate)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(clockrate, baudrate);
 }
 
 static int f81232_get_register(struct usb_serial_port *port, u16 reg, u8 *val)
@@ -129,6 +154,21 @@ static int f81232_set_register(struct usb_serial_port *port, u16 reg, u8 val)
 	return status;
 }
 
+static int f81232_set_mask_register(struct usb_serial_port *port, u16 reg,
+					u8 mask, u8 val)
+{
+	int status;
+	u8 tmp;
+
+	status = f81232_get_register(port, reg, &tmp);
+	if (status)
+		return status;
+
+	tmp = (tmp & ~mask) | (val & mask);
+
+	return f81232_set_register(port, reg, tmp);
+}
+
 static void f81232_read_msr(struct usb_serial_port *port)
 {
 	int status;
@@ -346,13 +386,53 @@ static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 	 */
 }
 
-static void f81232_set_baudrate(struct usb_serial_port *port, speed_t baudrate)
+static int f81232_find_clk(speed_t baudrate)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(baudrate_table); ++idx) {
+		if (baudrate <= baudrate_table[idx] &&
+				baudrate_table[idx] % baudrate == 0)
+			return idx;
+	}
+
+	return -EINVAL;
+}
+
+static void f81232_set_baudrate(struct tty_struct *tty,
+				struct usb_serial_port *port, speed_t baudrate,
+				speed_t old_baudrate)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 lcr;
 	int divisor;
 	int status = 0;
+	int i;
+	int idx;
+	speed_t baud_list[] = {baudrate, old_baudrate, F81232_DEF_BAUDRATE};
+
+	for (i = 0; i < ARRAY_SIZE(baud_list); ++i) {
+		idx = f81232_find_clk(baud_list[i]);
+		if (idx >= 0) {
+			baudrate = baud_list[i];
+			tty_encode_baud_rate(tty, baudrate, baudrate);
+			break;
+		}
+	}
+
+	if (idx < 0)
+		return;
 
-	divisor = calc_baud_divisor(baudrate);
+	priv->baud_base = baudrate_table[idx];
+	divisor = calc_baud_divisor(baudrate, priv->baud_base);
+
+	status = f81232_set_mask_register(port, F81232_CLK_REGISTER,
+			F81232_CLK_MASK, clock_table[idx]);
+	if (status) {
+		dev_err(&port->dev, "%s failed to set CLK_REG: %d\n",
+			__func__, status);
+		return;
+	}
 
 	status = f81232_get_register(port, LINE_CONTROL_REGISTER,
 			 &lcr); /* get LCR */
@@ -442,6 +522,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
+	speed_t old_baud;
 
 	/* Don't change anything if nothing has changed */
 	if (old_termios && !tty_termios_hw_change(&tty->termios, old_termios))
@@ -454,11 +535,12 @@ static void f81232_set_termios(struct tty_struct *tty,
 
 	baudrate = tty_get_baud_rate(tty);
 	if (baudrate > 0) {
-		if (baudrate > F81232_MAX_BAUDRATE) {
-			baudrate = F81232_MAX_BAUDRATE;
-			tty_encode_baud_rate(tty, baudrate, baudrate);
-		}
-		f81232_set_baudrate(port, baudrate);
+		if (old_termios)
+			old_baud = tty_termios_baud_rate(old_termios);
+		else
+			old_baud = F81232_DEF_BAUDRATE;
+
+		f81232_set_baudrate(tty, port, baudrate, old_baud);
 	}
 
 	if (C_PARENB(tty)) {
@@ -595,11 +677,12 @@ static int f81232_get_serial_info(struct tty_struct *tty,
 		struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 
 	ss->type = PORT_16550A;
 	ss->line = port->minor;
 	ss->port = port->port_number;
-	ss->baud_base = F81232_MAX_BAUDRATE;
+	ss->baud_base = priv->baud_base;
 	return 0;
 }
 
-- 
2.7.4

