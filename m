Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0021473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETU39y/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDCG0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:26:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCG0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:26:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7502657pll.13;
        Tue, 02 Apr 2019 23:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KpyUlTtCPDXPCptqsdtE2VC4bY/0TzrOm6bvZ79h+y4=;
        b=ETU39y/J8MMSySgKFMh5VrbxH4tiw0K27HW92Nj9FLuwuPK8tu6NbVwWplHwxxQf6W
         0t7ngUxMTKLDHxz139pdxkHUyKGCr//rPgF7KcftnhZsdF6YnrzxLA/3V8iBPhqFk3vB
         hdFI7UCIAEAy4w5EBJAMH8BBiDWlcls6yAwXtHKhm92mdQ63PwEhqbEoB9iDt4EPNgKg
         TPGwizd9LTIKM0UyjZog64JLAobI+SKSE7DKKCGuoTdF/lQDYg31t8qaVudscbUttqo1
         49ilgaE6Jq21m4DSdapz0QmNWEVjZjACGas45EA/KL9WYmBHGju4w17T15op9bi8mNvJ
         1qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KpyUlTtCPDXPCptqsdtE2VC4bY/0TzrOm6bvZ79h+y4=;
        b=Gb0MIzVvsUCTBXW72C3CQ3y2KGrCsCLq0NmJbJfF8kGPsvEG9j0YUiIR/D68tOYgeD
         puUbH83w/FABbDEb3wRCTr+IY1DXNQ39x2fyKjc4Nscjz/926sTRWarRkgwOO23GFPKH
         O9QgOPE/GU9DqiUOGBxJ/RCmopyHiKD7YDH8otUe6UDAnCE0Jrjt5D3g+otg98uikm78
         UWTKMxaYzsNqA4CaOqiANlw98o73M1A9dV6xhneCp7g+Ubo+W4QaOhpXa1x08wr2mG16
         OTlBLc3JDBGNTcJgK3G8T/cQ4Bca4DNX86qlWMR5RY1GMwMdmzEB8bmffdu9bBwDHXjq
         er0w==
X-Gm-Message-State: APjAAAUWN/onfWeqTGVajODgh5MFdqL/f8FvEfgLOEgazTtvNna9oZLw
        kK8iD9qtwRXetQYRATd42Lo=
X-Google-Smtp-Source: APXvYqxydML28zvXij3H1chQ14BR3qZ2dBUhO6S+qQxSa+Oi6Ih0IDithvdwlyOk/Zv/8uGy1VCdmg==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr7274587plt.187.1554272802366;
        Tue, 02 Apr 2019 23:26:42 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id g64sm35035003pfg.13.2019.04.02.23.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 23:26:41 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V5 2/3] USB: serial: f81232: add high baud rate support
Date:   Wed,  3 Apr 2019 14:26:29 +0800
Message-Id: <1554272790-26747-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554272790-26747-1-git-send-email-hpeter+linux_kernel@gmail.com>
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
v5:
	1: no change

v4:
	1: no change

v3:
	1: change the baud_base in f81232_get_serial_info()

 drivers/usb/serial/f81232.c | 105 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index d8a0bb7a41f0..32eff8fad56a 100644
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
@@ -349,13 +389,53 @@ static void f81232_break_ctl(struct tty_struct *tty, int break_state)
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
 
-	divisor = calc_baud_divisor(baudrate);
+	if (idx < 0)
+		return;
+
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
@@ -445,6 +525,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
+	speed_t old_baud;
 
 	/* Don't change anything if nothing has changed */
 	if (old_termios && !tty_termios_hw_change(&tty->termios, old_termios))
@@ -457,11 +538,12 @@ static void f81232_set_termios(struct tty_struct *tty,
 
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
@@ -597,11 +679,12 @@ static int f81232_get_serial_info(struct tty_struct *tty,
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

