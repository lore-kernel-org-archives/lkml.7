Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A983C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="KKo6NelW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfCFMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:02:05 -0500
Received: from tomli.me ([153.92.126.73]:46566 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbfCFMCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:02:01 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 9367809d;
        Wed, 6 Mar 2019 12:01:57 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Wed, 06 Mar 2019 12:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=uMmr+paLH3oxbIjnf44KpHw1/0fMpGkylyvaTPhBq3U=; b=KKo6NelW0sv6Xw/PqkehXS3OjYD/PJrRwMicq6IeoL7Uxh1zljCm+ev5VgSEqoIrz/Lh1sICdBr3SWflQ70UBmvrmwkHBFD9+IeHNTurksZ5v0FfNfdxvi4lC+bNf/LRonF51Smau4ogQIjwX/zsYGNeOK1oNIzc/BNyA3jdFgphwzF0w7ptHL8ThIGLTYg6A12C8lhc9tzh4HBj0Miso+CG/gnEdcMsOdgEFXkeI+DFZ8DMAQMPSWhRhhWIfok4fvEMo/gfTRMZiDn8J9kiaW5IILy+7gyrXu7/rQP0p1+CWLMMIH0EzQD1KHl7XQKbaQtspUe3Xvth1bz/+IQV6A==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] mips: loongson64: remove ec_kb3310b.c, use MFD driver.
Date:   Wed,  6 Mar 2019 20:01:09 +0800
Message-Id: <20190306120113.648-4-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306120113.648-1-tomli@tomli.me>
References: <20190306120113.648-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already converted the supporting code for ENE KB3310B
embedded controller as a separate MFD driver, and select it
as a dependency of LEMOTE_MACH2F.

This commit removes the original implementation of ec_kb3310b.c,
and converts all EC operations to use the utility function provided
by the yeeloong_kb3310b MFD driver instead.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/lemote-2f/Makefile     |   2 +-
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c | 129 --------------
 arch/mips/loongson64/lemote-2f/ec_kb3310b.h | 188 --------------------
 arch/mips/loongson64/lemote-2f/pm.c         |  18 +-
 arch/mips/loongson64/lemote-2f/reset.c      |   4 +-
 5 files changed, 12 insertions(+), 329 deletions(-)
 delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.h

diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index b5792c334cd5..ac97f14ea2b7 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += clock.o machtype.o irq.o reset.o dma.o ec_kb3310b.o
+obj-y += clock.o machtype.o irq.o reset.o dma.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
deleted file mode 100644
index 321822997e76..000000000000
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-04-20
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-
-#include "ec_kb3310b.h"
-
-static DEFINE_SPINLOCK(index_access_lock);
-static DEFINE_SPINLOCK(port_access_lock);
-
-unsigned char ec_read(unsigned short addr)
-{
-	unsigned char value;
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	value = inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-
-	return value;
-}
-EXPORT_SYMBOL_GPL(ec_read);
-
-void ec_write(unsigned short addr, unsigned char val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	outb(val, EC_IO_PORT_DATA);
-	/*  flush the write action */
-	inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-}
-EXPORT_SYMBOL_GPL(ec_write);
-
-/*
- * This function is used for EC command writes and corresponding status queries.
- */
-int ec_query_seq(unsigned char cmd)
-{
-	int timeout;
-	unsigned char status;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&port_access_lock, flags);
-
-	/* make chip goto reset mode */
-	udelay(EC_REG_DELAY);
-	outb(cmd, EC_CMD_PORT);
-	udelay(EC_REG_DELAY);
-
-	/* check if the command is received by ec */
-	timeout = EC_CMD_TIMEOUT;
-	status = inb(EC_STS_PORT);
-	while (timeout-- && (status & (1 << 1))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-
-	spin_unlock_irqrestore(&port_access_lock, flags);
-
-	if (timeout <= 0) {
-		printk(KERN_ERR "%s: deadable error : timeout...\n", __func__);
-		ret = -EINVAL;
-	} else
-		printk(KERN_INFO
-			   "(%x/%d)ec issued command %d status : 0x%x\n",
-			   timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ec_query_seq);
-
-/*
- * Send query command to EC to get the proper event number
- */
-int ec_query_event_num(void)
-{
-	return ec_query_seq(CMD_GET_EVENT_NUM);
-}
-EXPORT_SYMBOL(ec_query_event_num);
-
-/*
- * Get event number from EC
- *
- * NOTE: This routine must follow the query_event_num function in the
- * interrupt.
- */
-int ec_get_event_num(void)
-{
-	int timeout = 100;
-	unsigned char value;
-	unsigned char status;
-
-	udelay(EC_REG_DELAY);
-	status = inb(EC_STS_PORT);
-	udelay(EC_REG_DELAY);
-	while (timeout-- && !(status & (1 << 0))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-	if (timeout <= 0) {
-		pr_info("%s: get event number timeout.\n", __func__);
-
-		return -EINVAL;
-	}
-	value = inb(EC_DAT_PORT);
-	udelay(EC_REG_DELAY);
-
-	return value;
-}
-EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.h b/arch/mips/loongson64/lemote-2f/ec_kb3310b.h
deleted file mode 100644
index 5a3f1860d4d2..000000000000
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.h
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * KB3310B Embedded Controller
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-03-14
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef _EC_KB3310B_H
-#define _EC_KB3310B_H
-
-extern unsigned char ec_read(unsigned short addr);
-extern void ec_write(unsigned short addr, unsigned char val);
-extern int ec_query_seq(unsigned char cmd);
-extern int ec_query_event_num(void);
-extern int ec_get_event_num(void);
-
-typedef int (*sci_handler) (int status);
-extern sci_handler yeeloong_report_lid_status;
-
-#define SCI_IRQ_NUM 0x0A
-
-/*
- * The following registers are determined by the EC index configuration.
- * 1, fill the PORT_HIGH as EC register high part.
- * 2, fill the PORT_LOW as EC register low part.
- * 3, fill the PORT_DATA as EC register write data or get the data from it.
- */
-#define EC_IO_PORT_HIGH 0x0381
-#define EC_IO_PORT_LOW	0x0382
-#define EC_IO_PORT_DATA 0x0383
-
-/*
- * EC delay time is 500us for register and status access
- */
-#define EC_REG_DELAY	500	/* unit : us */
-#define EC_CMD_TIMEOUT	0x1000
-
-/*
- * EC access port for SCI communication
- */
-#define EC_CMD_PORT		0x66
-#define EC_STS_PORT		0x66
-#define EC_DAT_PORT		0x62
-#define CMD_INIT_IDLE_MODE	0xdd
-#define CMD_EXIT_IDLE_MODE	0xdf
-#define CMD_INIT_RESET_MODE	0xd8
-#define CMD_REBOOT_SYSTEM	0x8c
-#define CMD_GET_EVENT_NUM	0x84
-#define CMD_PROGRAM_PIECE	0xda
-
-/* temperature & fan registers */
-#define REG_TEMPERATURE_VALUE	0xF458
-#define REG_FAN_AUTO_MAN_SWITCH 0xF459
-#define BIT_FAN_AUTO		0
-#define BIT_FAN_MANUAL		1
-#define REG_FAN_CONTROL		0xF4D2
-#define BIT_FAN_CONTROL_ON	(1 << 0)
-#define BIT_FAN_CONTROL_OFF	(0 << 0)
-#define REG_FAN_STATUS		0xF4DA
-#define BIT_FAN_STATUS_ON	(1 << 0)
-#define BIT_FAN_STATUS_OFF	(0 << 0)
-#define REG_FAN_SPEED_HIGH	0xFE22
-#define REG_FAN_SPEED_LOW	0xFE23
-#define REG_FAN_SPEED_LEVEL	0xF4CC
-/* fan speed divider */
-#define FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
-
-/* battery registers */
-#define REG_BAT_DESIGN_CAP_HIGH		0xF77D
-#define REG_BAT_DESIGN_CAP_LOW		0xF77E
-#define REG_BAT_FULLCHG_CAP_HIGH	0xF780
-#define REG_BAT_FULLCHG_CAP_LOW		0xF781
-#define REG_BAT_DESIGN_VOL_HIGH		0xF782
-#define REG_BAT_DESIGN_VOL_LOW		0xF783
-#define REG_BAT_CURRENT_HIGH		0xF784
-#define REG_BAT_CURRENT_LOW		0xF785
-#define REG_BAT_VOLTAGE_HIGH		0xF786
-#define REG_BAT_VOLTAGE_LOW		0xF787
-#define REG_BAT_TEMPERATURE_HIGH	0xF788
-#define REG_BAT_TEMPERATURE_LOW		0xF789
-#define REG_BAT_RELATIVE_CAP_HIGH	0xF492
-#define REG_BAT_RELATIVE_CAP_LOW	0xF493
-#define REG_BAT_VENDOR			0xF4C4
-#define FLAG_BAT_VENDOR_SANYO		0x01
-#define FLAG_BAT_VENDOR_SIMPLO		0x02
-#define REG_BAT_CELL_COUNT		0xF4C6
-#define FLAG_BAT_CELL_3S1P		0x03
-#define FLAG_BAT_CELL_3S2P		0x06
-#define REG_BAT_CHARGE			0xF4A2
-#define FLAG_BAT_CHARGE_DISCHARGE	0x01
-#define FLAG_BAT_CHARGE_CHARGE		0x02
-#define FLAG_BAT_CHARGE_ACPOWER		0x00
-#define REG_BAT_STATUS			0xF4B0
-#define BIT_BAT_STATUS_LOW		(1 << 5)
-#define BIT_BAT_STATUS_DESTROY		(1 << 2)
-#define BIT_BAT_STATUS_FULL		(1 << 1)
-#define BIT_BAT_STATUS_IN		(1 << 0)
-#define REG_BAT_CHARGE_STATUS		0xF4B1
-#define BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
-#define BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
-#define REG_BAT_STATE			0xF482
-#define BIT_BAT_STATE_CHARGING		(1 << 1)
-#define BIT_BAT_STATE_DISCHARGING	(1 << 0)
-#define REG_BAT_POWER			0xF440
-#define BIT_BAT_POWER_S3		(1 << 2)
-#define BIT_BAT_POWER_ON		(1 << 1)
-#define BIT_BAT_POWER_ACIN		(1 << 0)
-
-/* other registers */
-/* Audio: rd/wr */
-#define REG_AUDIO_VOLUME	0xF46C
-#define REG_AUDIO_MUTE		0xF4E7
-#define REG_AUDIO_BEEP		0xF4D0
-/* USB port power or not: rd/wr */
-#define REG_USB0_FLAG		0xF461
-#define REG_USB1_FLAG		0xF462
-#define REG_USB2_FLAG		0xF463
-#define BIT_USB_FLAG_ON		1
-#define BIT_USB_FLAG_OFF	0
-/* LID */
-#define REG_LID_DETECT		0xF4BD
-#define BIT_LID_DETECT_ON	1
-#define BIT_LID_DETECT_OFF	0
-/* CRT */
-#define REG_CRT_DETECT		0xF4AD
-#define BIT_CRT_DETECT_PLUG	1
-#define BIT_CRT_DETECT_UNPLUG	0
-/* LCD backlight brightness adjust: 9 levels */
-#define REG_DISPLAY_BRIGHTNESS	0xF4F5
-/* Black screen Status */
-#define BIT_DISPLAY_LCD_ON	1
-#define BIT_DISPLAY_LCD_OFF	0
-/* LCD backlight control: off/restore */
-#define REG_BACKLIGHT_CTRL	0xF7BD
-#define BIT_BACKLIGHT_ON	1
-#define BIT_BACKLIGHT_OFF	0
-/* Reset the machine auto-clear: rd/wr */
-#define REG_RESET		0xF4EC
-#define BIT_RESET_ON		1
-/* Light the led: rd/wr */
-#define REG_LED			0xF4C8
-#define BIT_LED_RED_POWER	(1 << 0)
-#define BIT_LED_ORANGE_POWER	(1 << 1)
-#define BIT_LED_GREEN_CHARGE	(1 << 2)
-#define BIT_LED_RED_CHARGE	(1 << 3)
-#define BIT_LED_NUMLOCK		(1 << 4)
-/* Test led mode, all led on/off */
-#define REG_LED_TEST		0xF4C2
-#define BIT_LED_TEST_IN		1
-#define BIT_LED_TEST_OUT	0
-/* Camera on/off */
-#define REG_CAMERA_STATUS	0xF46A
-#define BIT_CAMERA_STATUS_ON	1
-#define BIT_CAMERA_STATUS_OFF	0
-#define REG_CAMERA_CONTROL	0xF7B7
-#define BIT_CAMERA_CONTROL_OFF	0
-#define BIT_CAMERA_CONTROL_ON	1
-/* Wlan Status */
-#define REG_WLAN		0xF4FA
-#define BIT_WLAN_ON		1
-#define BIT_WLAN_OFF		0
-#define REG_DISPLAY_LCD		0xF79F
-
-/* SCI Event Number from EC */
-enum {
-	EVENT_LID = 0x23,	/*  LID open/close */
-	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
-	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
-	EVENT_OVERTEMP,		/*  Over-temperature happened */
-	EVENT_CRT_DETECT,	/*  CRT is connected */
-	EVENT_CAMERA,		/*  Camera on/off */
-	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
-	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
-	EVENT_BLACK_SCREEN,	/*  Turn on/off backlight */
-	EVENT_AUDIO_MUTE,	/*  Mute on/off */
-	EVENT_DISPLAY_BRIGHTNESS,/* LCD backlight brightness adjust */
-	EVENT_AC_BAT,		/*  AC & Battery relative issue */
-	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
-	EVENT_WLAN,		/*  Wlan on/off */
-	EVENT_END
-};
-
-#endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson64/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
index 6859e934862d..4ee7e9864700 100644
--- a/arch/mips/loongson64/lemote-2f/pm.c
+++ b/arch/mips/loongson64/lemote-2f/pm.c
@@ -23,7 +23,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536_mfgpt.h>
-#include "ec_kb3310b.h"
+#include <linux/mfd/yeeloong_kb3310b.h>
 
 #define I8042_KBD_IRQ		1
 #define I8042_CTR_KBDINT	0x01
@@ -70,7 +70,7 @@ void setup_wakeup_events(void)
 		/* Wakeup CPU via SCI lid open event */
 		outb(irq_mask & ~(1 << PIC_CASCADE_IR), PIC_MASTER_IMR);
 		inb(PIC_MASTER_IMR);
-		outb(0xff & ~(1 << (SCI_IRQ_NUM - 8)), PIC_SLAVE_IMR);
+		outb(0xff & ~(1 << (KB3310B_SCI_IRQ_NUM - 8)), PIC_SLAVE_IMR);
 		inb(PIC_SLAVE_IMR);
 
 		break;
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(yeeloong_report_lid_status);
 static void yeeloong_lid_update_task(struct work_struct *work)
 {
 	if (yeeloong_report_lid_status)
-		yeeloong_report_lid_status(BIT_LID_DETECT_ON);
+		yeeloong_report_lid_status(KB3310B_BIT_LID_DETECT_ON);
 }
 
 int wakeup_loongson(void)
@@ -104,21 +104,21 @@ int wakeup_loongson(void)
 
 	if (irq == I8042_KBD_IRQ)
 		return 1;
-	else if (irq == SCI_IRQ_NUM) {
+	else if (irq == KB3310B_SCI_IRQ_NUM) {
 		int ret, sci_event;
 		/* query the event number */
-		ret = ec_query_seq(CMD_GET_EVENT_NUM);
+		ret = kb3310b_query_seq(KB3310B_CMD_GET_EVENT_NUM);
 		if (ret < 0)
 			return 0;
-		sci_event = ec_get_event_num();
+		sci_event = kb3310b_get_event_num();
 		if (sci_event < 0)
 			return 0;
-		if (sci_event == EVENT_LID) {
+		if (sci_event == KB3310B_EVENT_LID) {
 			int lid_status;
 			/* check the LID status */
-			lid_status = ec_read(REG_LID_DETECT);
+			lid_status = kb3310b_read(KB3310B_REG_LID_DETECT);
 			/* wakeup cpu when people open the LID */
-			if (lid_status == BIT_LID_DETECT_ON) {
+			if (lid_status == KB3310B_BIT_LID_DETECT_ON) {
 				/* If we call it directly here, the WARNING
 				 * will be sent out by getnstimeofday
 				 * via "WARN_ON(timekeeping_suspended);"
diff --git a/arch/mips/loongson64/lemote-2f/reset.c b/arch/mips/loongson64/lemote-2f/reset.c
index a26ca7fcd7e0..c5e2afbb8121 100644
--- a/arch/mips/loongson64/lemote-2f/reset.c
+++ b/arch/mips/loongson64/lemote-2f/reset.c
@@ -20,7 +20,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536.h>
-#include "ec_kb3310b.h"
+#include <linux/mfd/yeeloong_kb3310b.h>
 
 static void reset_cpu(void)
 {
@@ -81,7 +81,7 @@ static void ml2f_reboot(void)
 	reset_cpu();
 
 	/* sending an reset signal to EC(embedded controller) */
-	ec_write(REG_RESET, BIT_RESET_ON);
+	kb3310b_write(KB3310B_REG_RESET, KB3310B_BIT_RESET_ON);
 }
 
 #define yl2f89_reboot ml2f_reboot
-- 
2.20.1

