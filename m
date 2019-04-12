Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748132084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpRkHZhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDLNhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:37:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34585 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:37:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so5248070pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/eeBxNIaGPUNtDIy8Rbo/z9wGzAZ57CUSOEu15OwXqk=;
        b=ZpRkHZhUbaTSjkrA0lT3YDbaxN8sYUvHSPRcZJpJ1U//aaScC+BTeXdpAcR3hCFBZB
         xp7MZoC32MVSNxJejRCCrPv47ll+hxVGFgcDdKVlV7Cyg4zP1FlnA9hBRVJdtptGRdpm
         V7sbJsYNMS/APKSzspTS7h7UJm+3vl0cHb9Sg3P9KAKTys2o7QuxfIF5/B7GHtoCfQeL
         Drq3QRW2qVcvCVV/gvW1ivxKdEEX88uoMYPJCTaRAdKzqVXfLEDxRWhtRXBXSb2ny+ad
         mvlJXj5DKCOHj6EWBGNiXwKX02KAjDh44t34Rcu9PN582D39rTpFAPhXCvdSxDT5Zo+R
         x99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/eeBxNIaGPUNtDIy8Rbo/z9wGzAZ57CUSOEu15OwXqk=;
        b=CcNLzpmLyKPAgRzmkZcu/w7EkTkjQ1BLvRUz4OCsmcrPws52cHO9YAqRDoCyaX9hO/
         RbhqJAcWGPObA9SxSNoCmh+pS2yx9upavEHlsZFAJPX8qQkk5cMu+Q1bwvVXo7t3NuOO
         uPgEwO2QRV1EEbbeiUqrBRVhNMIQO8YRzbmyRz4jXmIT6BODdf2LM01sG7kHqwVZrSIq
         SHcXxXleWDIR7lszQkOauurqpkDU+6smTpLfBk2t+QynBjVPhFSBJh+Sdq/NLLIBiS/i
         q4kWOhZSYdxVsSHr5hLPSvS/JfmBMtOY8/3BRm83OrxpJOTh7d6ohjuRB695sgR/b1UP
         fx2Q==
X-Gm-Message-State: APjAAAUHna1Cfbp5zGxN2KZLRVFL6iJvl98m2aswae6k+gdF90kI6R9M
        xoT38wez7466caJaPITLP3A=
X-Google-Smtp-Source: APXvYqzWPmWOBvyawshecA0XE9QTmglqvWDwzVZ0kRrSwiBaw0jJx0VRKK74ofhjkgZwB3eo39o93Q==
X-Received: by 2002:a63:b64:: with SMTP id a36mr54031930pgl.58.1555076239142;
        Fri, 12 Apr 2019 06:37:19 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-232-61.dynamic-ip.hinet.net. [114.36.232.61])
        by smtp.gmail.com with ESMTPSA id f63sm77473661pfc.180.2019.04.12.06.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:37:18 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 4/4 V2] Add support for SUNIX Multi-IO board
Date:   Fri, 12 Apr 2019 21:36:53 +0800
Message-Id: <20190412133653.3932-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a reincarnation of the first version of the
fix which has been discussed as not a correct approach.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 drivers/mfd/sunix/snx_ieee1284.c     | 144 ++++++
 drivers/mfd/sunix/snx_ieee1284_ops.c | 228 ++++++++++
 drivers/mfd/sunix/snx_lp.c           | 603 +++++++++++++++++++++++++
 drivers/mfd/sunix/snx_lp.h           |  94 ++++
 drivers/mfd/sunix/snx_parallel.c     | 388 ++++++++++++++++
 drivers/mfd/sunix/snx_ppdev.c        | 402 +++++++++++++++++
 drivers/mfd/sunix/snx_ppdev.h        |  15 +
 drivers/mfd/sunix/snx_share.c        | 634 +++++++++++++++++++++++++++
 10 files changed, 2515 insertions(+)
 create mode 100644 drivers/mfd/sunix/snx_ieee1284.c
 create mode 100644 drivers/mfd/sunix/snx_ieee1284_ops.c
 create mode 100644 drivers/mfd/sunix/snx_lp.c
 create mode 100644 drivers/mfd/sunix/snx_lp.h
 create mode 100644 drivers/mfd/sunix/snx_parallel.c
 create mode 100644 drivers/mfd/sunix/snx_ppdev.c
 create mode 100644 drivers/mfd/sunix/snx_ppdev.h
 create mode 100644 drivers/mfd/sunix/snx_share.c
 
diff --git a/drivers/mfd/sunix/snx_ieee1284.c b/drivers/mfd/sunix/snx_ieee1284.c
new file mode 100644
index 000000000000..94adf24e53e1
--- /dev/null
+++ b/drivers/mfd/sunix/snx_ieee1284.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+
+static void sunix_parport_ieee1284_wakeup(struct parport *port)
+{
+	up(&port->physport->ieee1284.irq);
+}
+
+static void sunix_timeout_waiting_on_port(struct timer_list *t)
+{
+	struct parport *port = from_timer(port, t, timer);
+
+	sunix_parport_ieee1284_wakeup(port);
+}
+
+int sunix_parport_wait_event(struct parport *port, signed long timeout)
+{
+	int ret;
+
+	if (!port->physport->cad->timeout)
+		return 1;
+
+	timer_setup(&port->timer, sunix_timeout_waiting_on_port, 0);
+	mod_timer(&port->timer, jiffies + timeout);
+
+	ret = down_interruptible(&port->physport->ieee1284.irq);
+
+	if (!del_timer(&port->timer) && !ret)
+		ret = 1;
+
+	return      ret;
+}
+
+
+int sunix_parport_poll_peripheral(struct parport *port, unsigned char mask,
+unsigned char result, int usec)
+{
+	int count = usec / 5 + 2;
+	int i;
+	unsigned char status;
+
+	for (i = 0; i < count; i++) {
+		status = sunix_parport_read_status(port);
+
+		if ((status & mask) == result)
+			return 0;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		if (need_resched())
+			break;
+
+		if (i >= 2)
+			udelay(5);
+
+	}
+
+	return 1;
+}
+
+
+int sunix_parport_wait_peripheral(struct parport *port,
+unsigned char mask, unsigned char result)
+{
+	int ret;
+	int usec;
+	unsigned long deadline;
+	unsigned char status;
+
+	usec = port->physport->spintime;
+
+	if (!port->physport->cad->timeout)
+		usec = 35000;
+
+	ret = sunix_parport_poll_peripheral(port, mask, result, usec);
+
+	if (ret != 1)
+		return ret;
+
+	if (!port->physport->cad->timeout)
+		return 1;
+
+	deadline = jiffies + (HZ + 24) / 25;
+
+	while (time_before(jiffies, deadline)) {
+		int ret;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		ret = sunix_parport_wait_event(port, (HZ + 99) / 100);
+		if (ret < 0)
+			return ret;
+
+		status = sunix_parport_read_status(port);
+		if ((status & mask) == result)
+			return 0;
+
+		if (!ret)
+			schedule_timeout_interruptible(msecs_to_jiffies(10));
+	}
+
+	return 1;
+}
+
+
+int sunix_parport_negotiate(struct parport *port, int mode)
+{
+	if (mode == IEEE1284_MODE_COMPAT)
+		return 0;
+
+	return -1;
+}
+
+
+ssize_t sunix_parport_write(struct parport *port,
+const void *buffer, size_t len)
+{
+	ssize_t ret;
+
+	ret = port->ops->compat_write_data(port, buffer, len, 0);
+
+	return ret;
+}
+
+
+ssize_t sunix_parport_read(struct parport *port, void *buffer, size_t len)
+{
+	return -ENODEV;
+}
+
+
+long sunix_parport_set_timeout(struct pardevice *dev, long inactivity)
+{
+	long int old = dev->timeout;
+
+	dev->timeout = inactivity;
+
+	if (dev->port->physport->cad == dev)
+		sunix_parport_ieee1284_wakeup(dev->port);
+
+	return old;
+}
diff --git a/drivers/mfd/sunix/snx_ieee1284_ops.c b/drivers/mfd/sunix/snx_ieee1284_ops.c
new file mode 100644
index 000000000000..5e0a80d36953
--- /dev/null
+++ b/drivers/mfd/sunix/snx_ieee1284_ops.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+
+
+size_t sunix_parport_ieee1284_write_compat(struct parport *port,
+const void *buffer, size_t len, int flags)
+{
+	int no_irq = 1;
+	ssize_t count = 0;
+	const unsigned char *addr = buffer;
+	unsigned char byte;
+	struct pardevice *dev = port->physport->cad;
+	unsigned char ctl = (PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT);
+
+	if (port->irq != PARPORT_IRQ_NONE) {
+		sunix_parport_enable_irq(port);
+		no_irq = 0;
+	}
+
+	port->physport->ieee1284.phase = IEEE1284_PH_FWD_DATA;
+	sunix_parport_write_control(port, ctl);
+	sunix_parport_data_forward(port);
+
+	while (count < len) {
+		unsigned long expire = jiffies + dev->timeout;
+		long wait = (HZ + 99) / 100;
+		unsigned char mask = (PARPORT_STATUS_ERROR |
+		PARPORT_STATUS_BUSY);
+		unsigned char val = (PARPORT_STATUS_ERROR |
+		PARPORT_STATUS_BUSY);
+
+		do {
+			if (!sunix_parport_wait_peripheral(port, mask, val))
+				goto ready;
+
+			if ((sunix_parport_read_status(port) &
+			(PARPORT_STATUS_PAPEROUT | PARPORT_STATUS_SELECT |
+			PARPORT_STATUS_ERROR)) != (PARPORT_STATUS_SELECT |
+			PARPORT_STATUS_ERROR))
+				goto stop;
+
+			if (!time_before(jiffies, expire))
+				break;
+
+			if (count && no_irq) {
+				sunix_parport_release(dev);
+
+				schedule_timeout_interruptible(wait);
+
+				sunix_parport_claim_or_block(dev);
+			} else {
+				sunix_parport_wait_event(port, wait);
+			}
+
+			if (signal_pending(current))
+				break;
+
+			wait *= 2;
+		} while (time_before(jiffies, expire));
+
+		if (signal_pending(current))
+			break;
+
+		break;
+
+ready:
+		byte = *addr++;
+		sunix_parport_write_data(port, byte);
+		udelay(1);
+
+		sunix_parport_write_control(port, ctl | PARPORT_CONTROL_STROBE);
+		udelay(1);
+
+		sunix_parport_write_control(port, ctl);
+		udelay(1);
+
+		count++;
+
+		if (time_before(jiffies, expire)) {
+			if (!sunix_parport_yield_blocking(dev) &&
+			need_resched())
+				schedule();
+		}
+	}
+stop:
+	port->physport->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
+
+	return count;
+}
+
+size_t sunix_parport_ieee1284_epp_write_data(struct parport *port,
+const void *buffer, size_t len, int flags)
+{
+	unsigned char *bp = (unsigned char *) buffer;
+	size_t ret = 0;
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
+	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
+	PARPORT_CONTROL_INIT, PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
+
+	port->ops->data_forward(port);
+
+	for (; len > 0; len--, bp++) {
+		sunix_parport_write_data(port, *bp);
+		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD,
+		PARPORT_CONTROL_AUTOFD);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		0, 10))
+			break;
+
+		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD, 0);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		PARPORT_STATUS_BUSY, 5))
+			break;
+
+		ret++;
+	}
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
+	return ret;
+}
+
+
+size_t sunix_parport_ieee1284_epp_read_data(struct parport *port,
+void *buffer, size_t len, int flags)
+{
+	unsigned char *bp = (unsigned char *) buffer;
+	unsigned int ret = 0;
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
+	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
+	PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
+
+	port->ops->data_reverse(port);
+
+	for (; len > 0; len--, bp++) {
+		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD,
+		PARPORT_CONTROL_AUTOFD);
+
+		if (sunix_parport_wait_peripheral(port, PARPORT_STATUS_BUSY, 0))
+			break;
+
+		*bp = sunix_parport_read_data(port);
+
+		sunix_parport_frob_control(port, PARPORT_CONTROL_AUTOFD, 0);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		PARPORT_STATUS_BUSY, 5))
+			break;
+
+		ret++;
+	}
+	port->ops->data_forward(port);
+	return ret;
+}
+
+
+size_t sunix_parport_ieee1284_epp_write_addr(struct parport *port,
+const void *buffer, size_t len, int flags)
+{
+	unsigned char *bp = (unsigned char *)buffer;
+	size_t ret = 0;
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
+	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
+	PARPORT_CONTROL_INIT, PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);
+
+	port->ops->data_forward(port);
+
+	for (; len > 0; len--, bp++) {
+		sunix_parport_write_data(port, *bp);
+		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
+		PARPORT_CONTROL_SELECT);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		0, 10))
+			break;
+
+		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT, 0);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		PARPORT_STATUS_BUSY, 5))
+			break;
+
+		ret++;
+	}
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE, 0);
+	return ret;
+}
+
+size_t sunix_parport_ieee1284_epp_read_addr(struct parport *port,
+void *buffer, size_t len, int flags)
+{
+	unsigned char *bp = (unsigned char *) buffer;
+	unsigned int ret = 0;
+
+	sunix_parport_frob_control(port, PARPORT_CONTROL_STROBE |
+	PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT |
+	PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
+
+	port->ops->data_reverse(port);
+
+	for (; len > 0; len--, bp++) {
+		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
+		PARPORT_CONTROL_SELECT);
+
+		if (sunix_parport_wait_peripheral(port, PARPORT_STATUS_BUSY, 0))
+			break;
+
+		*bp = sunix_parport_read_data(port);
+
+		sunix_parport_frob_control(port, PARPORT_CONTROL_SELECT,
+		PARPORT_CONTROL_SELECT);
+
+		if (sunix_parport_poll_peripheral(port, PARPORT_STATUS_BUSY,
+		PARPORT_STATUS_BUSY, 5))
+			break;
+
+		ret++;
+	}
+
+	port->ops->data_forward(port);
+	return ret;
+}
+
diff --git a/drivers/mfd/sunix/snx_lp.c b/drivers/mfd/sunix/snx_lp.c
new file mode 100644
index 000000000000..da6d45db134a
--- /dev/null
+++ b/drivers/mfd/sunix/snx_lp.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "snx_common.h"
+#include "snx_lp.h"
+
+static int SNX_PAL_MAJOR;
+
+#define SNX_LP_NO SNX_PAR_TOTAL_MAX
+
+static struct snx_lp_struct snx_lp_table[SNX_LP_NO];
+static unsigned int snx_lp_count;
+static struct class *snx_lp_class;
+
+#define SNX_LP_PREEMPT_REQUEST 1
+#define SNX_LP_PARPORT_CLAIMED 2
+
+#ifdef CONFIG_LP_CONSOLE
+static struct parport *console_registered;
+#endif
+
+
+#define r_dtr(x)	(sunix_parport_read_data(snx_lp_table[(x)].dev->port))
+#define r_str(x)	(sunix_parport_read_status(snx_lp_table[(x)].dev->port))
+#define w_ctr(x, y)	do { sunix_parport_write_control(snx_lp_table[(x)].dev->port, (y)); } while (0)
+#define w_dtr(x, y)	do { sunix_parport_write_data(snx_lp_table[(x)].dev->port, (y)); } while (0)
+
+static void snx_lp_claim_parport_or_block(struct snx_lp_struct *this_lp)
+{
+	if (!test_and_set_bit(SNX_LP_PARPORT_CLAIMED, &this_lp->bits))
+		sunix_parport_claim_or_block(this_lp->dev);
+}
+
+
+static void snx_lp_release_parport(struct snx_lp_struct *this_lp)
+{
+	if (test_and_clear_bit(SNX_LP_PARPORT_CLAIMED, &this_lp->bits))
+		sunix_parport_release(this_lp->dev);
+}
+
+
+static int snx_lp_preempt(void *handle)
+{
+	struct snx_lp_struct *this_lp = (struct snx_lp_struct *)handle;
+
+	set_bit(SNX_LP_PREEMPT_REQUEST, &this_lp->bits);
+	return 1;
+}
+
+
+static int snx_lp_negotiate(struct parport *port, int mode)
+{
+	if (sunix_parport_negotiate(port, mode) != 0) {
+		mode = IEEE1284_MODE_COMPAT;
+		sunix_parport_negotiate(port, mode);
+	}
+	return (mode);
+}
+
+
+static int snx_lp_reset(int minor)
+{
+	int retval;
+
+	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+
+	w_ctr(minor, SNX_LP_PSELECP);
+
+	udelay(SNX_LP_DELAY);
+
+	w_ctr(minor, SNX_LP_PSELECP | SNX_LP_PINITP);
+
+	retval = r_str(minor);
+
+	snx_lp_release_parport(&snx_lp_table[minor]);
+	return retval;
+}
+
+
+static void snx_lp_error(int minor)
+{
+	DEFINE_WAIT(wait);
+
+	int polling;
+
+	if (SNX_LP_F(minor) & SNX_LP_ABORT)
+		return;
+
+	polling = snx_lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE;
+
+	if (polling)
+		snx_lp_release_parport(&snx_lp_table[minor]);
+
+	prepare_to_wait(&snx_lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
+
+	schedule_timeout(SNX_LP_TIMEOUT_POLLED);
+	finish_wait(&snx_lp_table[minor].waitq, &wait);
+
+	if (polling)
+		snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+	else
+		sunix_parport_yield_blocking(snx_lp_table[minor].dev);
+
+}
+
+
+static int snx_lp_check_status(int minor)
+{
+	int error = 0;
+	unsigned int last = snx_lp_table[minor].last_error;
+	unsigned char status = r_str(minor);
+
+	if ((status & SNX_LP_PERRORP) && !(SNX_LP_F(minor) & SNX_LP_CAREFUL)) {
+		last = 0;
+	} else if ((status & SNX_LP_POUTPA)) {
+		if (last != SNX_LP_POUTPA) {
+			last = SNX_LP_POUTPA;
+			pr_info("SNX Info : lp%d port out of paper.\n", minor);
+		}
+		error = -ENOSPC;
+	} else if (!(status & SNX_LP_PSELECD)) {
+		if (last != SNX_LP_PSELECD) {
+			last = SNX_LP_PSELECD;
+			pr_info("SNX Info : lp%d port off-line.\n", minor);
+		}
+		error = -EIO;
+	} else if (!(status & SNX_LP_PERRORP)) {
+		if (last != SNX_LP_PERRORP) {
+			last = SNX_LP_PERRORP;
+			pr_info("SNX Info : lp%d port on fire.\n", minor);
+		}
+		error = -EIO;
+	} else {
+		last = 0;
+	}
+
+	snx_lp_table[minor].last_error = last;
+
+	if (last != 0)
+		snx_lp_error(minor);
+
+	return error;
+}
+
+
+static int snx_lp_wait_ready(int minor, int nonblock)
+{
+	int error = 0;
+
+	if (snx_lp_table[minor].current_mode != IEEE1284_MODE_COMPAT)
+		return 0;
+
+
+	do {
+		error = snx_lp_check_status(minor);
+
+		if (error && (nonblock || (SNX_LP_F(minor) & SNX_LP_ABORT)))
+			break;
+
+
+		if (signal_pending(current)) {
+			error = -EINTR;
+			break;
+		}
+	} while (error);
+
+	return error;
+}
+
+static ssize_t snx_lp_write(struct file *file,
+const char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned int minor = iminor(file->f_path.dentry->d_inode);
+
+	struct parport *port = snx_lp_table[minor].dev->port;
+	char *kbuf = snx_lp_table[minor].lp_buffer;
+
+	ssize_t retv = 0;
+	ssize_t written;
+	size_t copy_size = count;
+	int nonblock = ((file->f_flags & O_NONBLOCK) ||
+	(SNX_LP_F(minor) & SNX_LP_ABORT));
+
+	if (copy_size > SNX_LP_BUFFER_SIZE)
+		copy_size = SNX_LP_BUFFER_SIZE;
+
+	if (mutex_lock_interruptible(&snx_lp_table[minor].port_mutex))
+		return -EINTR;
+
+	if (copy_from_user(kbuf, buf, copy_size)) {
+		retv = -EFAULT;
+		goto out_unlock;
+	}
+
+	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+
+	snx_lp_table[minor].current_mode = snx_lp_negotiate(
+	port, snx_lp_table[minor].best_mode);
+
+	sunix_parport_set_timeout(snx_lp_table[minor].dev, (nonblock ?
+	SNX_PARPORT_INACTIVITY_O_NONBLOCK : snx_lp_table[minor].timeout));
+
+	retv = snx_lp_wait_ready(minor, nonblock);
+
+	do {
+		written = sunix_parport_write(port, kbuf, copy_size);
+		if (written > 0) {
+			copy_size -= written;
+			count -= written;
+			buf  += written;
+			retv += written;
+		}
+
+		if (signal_pending(current)) {
+			if (retv == 0)
+				retv = -EINTR;
+
+			break;
+		}
+
+		if (copy_size > 0) {
+			int error;
+
+			sunix_parport_negotiate(snx_lp_table[minor].dev->port,
+			IEEE1284_MODE_COMPAT);
+			snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
+
+			error = snx_lp_wait_ready(minor, nonblock);
+
+			if (error) {
+				if (retv == 0)
+					retv = error;
+
+				break;
+			} else if (nonblock) {
+				if (retv == 0)
+					retv = -EAGAIN;
+
+				break;
+			}
+
+			sunix_parport_yield_blocking(snx_lp_table[minor].dev);
+			snx_lp_table[minor].current_mode = snx_lp_negotiate(
+			port, snx_lp_table[minor].best_mode);
+
+		} else if (need_resched()) {
+			schedule();
+		}
+
+		if (count) {
+			copy_size = count;
+			if (copy_size > SNX_LP_BUFFER_SIZE)
+				copy_size = SNX_LP_BUFFER_SIZE;
+
+
+			if (copy_from_user(kbuf, buf, copy_size)) {
+				if (retv == 0)
+					retv = -EFAULT;
+
+				break;
+			}
+		}
+	} while (count > 0);
+
+	if (test_and_clear_bit(SNX_LP_PREEMPT_REQUEST,
+		&snx_lp_table[minor].bits)) {
+		pr_info("SNX Info : lp%d releasing parport.\n", minor);
+		sunix_parport_negotiate(snx_lp_table[minor].dev->port,
+		IEEE1284_MODE_COMPAT);
+
+		snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
+
+		snx_lp_release_parport(&snx_lp_table[minor]);
+	}
+
+out_unlock:
+
+	mutex_unlock(&snx_lp_table[minor].port_mutex);
+
+	return retv;
+}
+
+static int snx_lp_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+
+	if (minor >= SNX_LP_NO)
+		return -ENXIO;
+
+
+	if ((SNX_LP_F(minor) & SNX_LP_EXIST) == 0)
+		return -ENXIO;
+
+
+	if (test_and_set_bit(SNX_LP_BUSY_BIT_POS, &SNX_LP_F(minor)))
+		return -EBUSY;
+
+
+	if ((SNX_LP_F(minor) & SNX_LP_ABORTOPEN) &&
+						!(file->f_flags & O_NONBLOCK)) {
+		int status;
+
+		snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+		status = r_str(minor);
+		snx_lp_release_parport(&snx_lp_table[minor]);
+
+		if (status & SNX_LP_POUTPA) {
+			pr_info("SNX Error: lp%d out of paper.\n", minor);
+			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
+			return -ENOSPC;
+		} else if (!(status & SNX_LP_PSELECD)) {
+			pr_info("SNX Error: lp%d off-line.\n", minor);
+			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
+			return -EIO;
+		} else if (!(status & SNX_LP_PERRORP)) {
+			pr_info("SNX Error: lp%d printer error.\n", minor);
+			SNX_LP_F(minor) &= ~SNX_LP_BUSY;
+			return -EIO;
+		}
+	}
+
+	snx_lp_table[minor].lp_buffer = kzalloc(SNX_LP_BUFFER_SIZE, GFP_KERNEL);
+
+	if (!snx_lp_table[minor].lp_buffer) {
+		SNX_LP_F(minor) &= ~SNX_LP_BUSY;
+		return -ENOMEM;
+	}
+
+	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+
+	if ((snx_lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
+		!sunix_parport_negotiate(snx_lp_table[minor].dev->port,
+		IEEE1284_MODE_ECP)) {
+		pr_info("SNX Info : lp%d ECP mode.\n", minor);
+		snx_lp_table[minor].best_mode = IEEE1284_MODE_ECP;
+	} else {
+		snx_lp_table[minor].best_mode = IEEE1284_MODE_COMPAT;
+	}
+
+	sunix_parport_negotiate(snx_lp_table[minor].dev->port,
+	IEEE1284_MODE_COMPAT);
+
+	snx_lp_release_parport(&snx_lp_table[minor]);
+	snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
+
+	return 0;
+}
+
+
+static int snx_lp_release(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+
+	snx_lp_claim_parport_or_block(&snx_lp_table[minor]);
+	sunix_parport_negotiate(snx_lp_table[minor].dev->port,
+	IEEE1284_MODE_COMPAT);
+
+	snx_lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
+	snx_lp_release_parport(&snx_lp_table[minor]);
+	kfree(snx_lp_table[minor].lp_buffer);
+	snx_lp_table[minor].lp_buffer = NULL;
+	SNX_LP_F(minor) &= ~SNX_LP_BUSY;
+
+	return 0;
+}
+
+static const struct file_operations lp_fops = {
+	.owner		= THIS_MODULE,
+	.write		= snx_lp_write,
+	.open		= snx_lp_open,
+	.release	= snx_lp_release,
+};
+
+#ifdef CONFIG_LP_CONSOLE
+#define SNX_CONSOLE_LP 0
+
+#define SNX_CONSOLE_LP_STRICT	1
+
+static void snx_lp_console_write(struct console *co,
+const char *s, unsigned int count)
+{
+	struct snx_pardevice *dev = snx_lp_table[SNX_CONSOLE_LP].dev;
+	struct snx_parport *port = dev->port;
+	ssize_t written;
+
+	if (sunix_parport_claim(dev))
+		return;
+
+	sunix_parport_set_timeout(dev, 0);
+
+	sunix_parport_negotiate(port, IEEE1284_MODE_COMPAT);
+
+	do {
+		ssize_t canwrite = count;
+		char *lf = memchr(s, '\n', count);
+
+		if (lf)
+			canwrite = lf - s;
+
+		if (canwrite > 0) {
+			written = sunix_parport_write(port, s, canwrite);
+
+			if (written <= 0)
+				continue;
+
+			s += written;
+			count -= written;
+			canwrite -= written;
+		}
+
+		if (lf && canwrite <= 0) {
+			const char *crlf = "\r\n";
+			int i = 2;
+
+			s++;
+			count--;
+			do {
+				written = sunix_parport_write(port, crlf, i);
+				if (written > 0)
+					i -= written, crlf += written;
+
+			} while (i > 0 && (SNX_CONSOLE_LP_STRICT ||
+				written > 0));
+		}
+	} while (count > 0 && (SNX_CONSOLE_LP_STRICT || written > 0));
+
+	sunix_parport_release(dev);
+}
+
+static struct console snx_lpcons = {
+	.name		= "lx",
+	.write		= snx_lp_consle_write,
+	.flags		= CON_PRINTBUFFER,
+};
+
+#endif
+
+static int snx_parport_nr[SNX_LP_NO] = {0, 1, 2, 3};
+static int reset;
+
+
+static int snx_lp_register(int nr, struct parport *port)
+{
+	snx_lp_table[nr].dev = sunix_parport_register_device(port, "lx",
+	snx_lp_preempt, NULL, NULL, 0, (void *) &snx_lp_table[nr]);
+
+	if (snx_lp_table[nr].dev == NULL)
+		return 1;
+
+
+	snx_lp_table[nr].flags |= SNX_LP_EXIST;
+
+	if (reset)
+		snx_lp_reset(nr);
+
+
+	device_create(snx_lp_class, NULL, MKDEV(SNX_PAL_MAJOR, nr),
+	NULL, "lp%d", nr);
+
+	pr_info("SNX Info : lp%d port using %s (%s).\n", nr, port->name,
+	(port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
+
+
+#ifdef CONFIG_LP_CONSOLE
+
+	if (!nr) {
+		if (port->modes & PARPORT_MODE_SAFEININT) {
+			register_console(&snx_lpcons);
+			console_registered = port;
+			pr_info("SNX Info : lp%d port console ready.\n",
+			CONSOLE_LP);
+		} else {
+			pr_info("SNX Info : lp%d port cannot run console on %s.\n",
+			CONSOLE_LP, port->name);
+		}
+	}
+#endif
+
+	return 0;
+}
+
+
+static void snx_lp_attach(struct parport *port)
+{
+	unsigned int i;
+
+	for (i = 0; i < SNX_LP_NO; i++) {
+		if (port->number == snx_parport_nr[i]) {
+			if (!snx_lp_register(i, port))
+				snx_lp_count++;
+
+			break;
+		}
+	}
+}
+
+static void snx_lp_detach(struct parport *port)
+{
+
+#ifdef CONFIG_LP_CONSOLE
+	if (console_registered == port) {
+		unregister_console(&snx_lpcons);
+		console_registered = NULL;
+	}
+#endif
+
+}
+
+static struct parport_driver lp_driver = {
+	.name = "lx",
+	.attach = snx_lp_attach,
+	.detach = snx_lp_detach,
+};
+
+
+static int snx_lp_init(void)
+{
+	int i, err = 0;
+
+	for (i = 0; i < SNX_LP_NO; i++) {
+		snx_lp_table[i].dev = NULL;
+		snx_lp_table[i].flags = 0;
+		snx_lp_table[i].chars = SNX_LP_INIT_CHAR;
+		snx_lp_table[i].time = SNX_LP_INIT_TIME;
+		snx_lp_table[i].wait = SNX_LP_INIT_WAIT;
+		snx_lp_table[i].lp_buffer = NULL;
+		snx_lp_table[i].last_error = 0;
+		init_waitqueue_head(&snx_lp_table[i].waitq);
+		init_waitqueue_head(&snx_lp_table[i].dataq);
+
+		mutex_init(&snx_lp_table[i].port_mutex);
+
+		snx_lp_table[i].timeout = 10 * HZ;
+	}
+
+	SNX_PAL_MAJOR = register_chrdev(0, "lx", &lp_fops);
+
+	if (SNX_PAL_MAJOR < 0) {
+		pr_info("SNX Error: lp unable to get major\n");
+		return -EIO;
+	}
+
+	snx_lp_class = class_create(THIS_MODULE, "sprinter");
+
+	if (IS_ERR(snx_lp_class)) {
+		err = PTR_ERR(snx_lp_class);
+		goto out_reg;
+	}
+
+	if (sunix_parport_register_driver(&lp_driver)) {
+		pr_info("SNX Error: lp unable to register with parport.\n");
+		err = -EIO;
+		goto out_class;
+	}
+
+	if (!snx_lp_count)
+		pr_info("SNX Warng: lp driver loaded but no devices found.\n");
+
+
+	return 0;
+
+out_class:
+
+	class_destroy(snx_lp_class);
+
+out_reg:
+
+	unregister_chrdev(SNX_PAL_MAJOR, "lx");
+	return err;
+}
+
+int sunix_par_lp_init(void)
+{
+	int status = 0;
+
+	status = snx_lp_init();
+	return status;
+}
+
+void sunix_par_lp_exit(void)
+{
+	unsigned int offset;
+
+	sunix_parport_unregister_driver(&lp_driver);
+
+#ifdef CONFIG_LP_CONSOLE
+	unregister_console(&snx_lpcons);
+#endif
+
+	unregister_chrdev(SNX_PAL_MAJOR, "lx");
+
+	for (offset = 0; offset < SNX_LP_NO; offset++) {
+		if (snx_lp_table[offset].dev == NULL)
+			continue;
+
+		sunix_parport_unregister_device(snx_lp_table[offset].dev);
+
+		device_destroy(snx_lp_class, MKDEV(SNX_PAL_MAJOR, offset));
+
+	}
+
+	class_destroy(snx_lp_class);
+}
+
diff --git a/drivers/mfd/sunix/snx_lp.h b/drivers/mfd/sunix/snx_lp.h
new file mode 100644
index 000000000000..a0929642834c
--- /dev/null
+++ b/drivers/mfd/sunix/snx_lp.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SNX_LP_H
+#define _LINUX_SNX_LP_H
+
+#include <linux/mutex.h>
+
+#define SNX_LP_EXIST		0x0001
+#define SNX_LP_SELEC		0x0002
+#define SNX_LP_BUSY		0x0004
+#define SNX_LP_BUSY_BIT_POS	2
+#define SNX_LP_OFFL		0x0008
+#define SNX_LP_NOPA		0x0010
+#define SNX_LP_ERR		0x0020
+#define SNX_LP_ABORT		0x0040
+#define SNX_LP_CAREFUL		0x0080
+#define SNX_LP_ABORTOPEN	0x0100
+
+#define SNX_LP_TRUST_IRQ_	0x0200
+#define SNX_LP_NO_REVERSE	0x0400
+#define SNX_LP_DATA_AVAIL	0x0800
+
+#define SNX_LP_PBUSY		0x80
+#define SNX_LP_PACK		0x40
+#define SNX_LP_POUTPA		0x20
+#define SNX_LP_PSELECD		0x10
+#define SNX_LP_PERRORP		0x08
+
+#define SNX_LP_INIT_CHAR	1000
+#define SNX_LP_INIT_WAIT	1
+#define SNX_LP_INIT_TIME	2
+
+#define SNX_LPCHAR		0x0601
+#define SNX_LPTIME		0x0602
+#define SNX_LPABORT		0x0604
+#define SNX_LPSETIRQ	0x0605
+#define SNX_LPGETIRQ	0x0606
+#define SNX_LPWAIT		0x0608
+
+#define SNX_LPCAREFUL		0x0609
+#define SNX_LPABORTOPEN		0x060a
+#define SNX_LPGETSTATUS		0x060b
+#define SNX_LPRESET			0x060c
+
+#define SNX_LPGETFLAGS		0x060e
+#define SNX_LPSETTIMEOUT	0x060f
+
+#define SNX_LP_TIMEOUT_INTERRUPT	(60 * HZ)
+#define SNX_LP_TIMEOUT_POLLED		(10 * HZ)
+
+#define SNX_LP_PARPORT_UNSPEC	-4
+#define SNX_LP_PARPORT_AUTO	-3
+#define SNX_LP_PARPORT_OFF	-2
+#define SNX_LP_PARPORT_NONE	-1
+
+#define SNX_LP_F(minor)		snx_lp_table[(minor)].flags
+#define SNX_LP_CHAR(minor)	snx_lp_table[(minor)].chars
+#define SNX_LP_TIME(minor)	snx_lp_table[(minor)].time
+#define SNX_LP_WAIT(minor)	snx_lp_table[(minor)].wait
+#define SNX_LP_IRQ(minor)	snx_lp_table[(minor)].dev->port->irq
+#define SNX_LP_BUFFER_SIZE PAGE_SIZE
+#define SNX_LP_BASE(x)			snx_lp_table[(x)].dev->port->base
+
+
+struct snx_lp_struct {
+	struct pardevice	*dev;
+	unsigned long		flags;
+	unsigned int		chars;
+	unsigned int		time;
+	unsigned int		wait;
+	char			*lp_buffer;
+
+	wait_queue_head_t	waitq;
+
+	unsigned int		last_error;
+	struct mutex		port_mutex;
+
+	wait_queue_head_t	dataq;
+
+	long			timeout;
+	unsigned int		best_mode;
+	unsigned int		current_mode;
+	unsigned long		bits;
+};
+
+
+#define SNX_LP_PINTEN		0x10
+#define SNX_LP_PSELECP		0x08
+#define SNX_LP_PINITP		0x04
+#define SNX_LP_PAUTOLF		0x02
+#define SNX_LP_PSTROBE		0x01
+#define SNX_LP_DUMMY		0x00
+#define SNX_LP_DELAY		50
+
+#endif
diff --git a/drivers/mfd/sunix/snx_parallel.c b/drivers/mfd/sunix/snx_parallel.c
new file mode 100644
index 000000000000..17fdc48cd9b6
--- /dev/null
+++ b/drivers/mfd/sunix/snx_parallel.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+
+static LIST_HEAD(snx_ports_list);
+
+static DEFINE_SPINLOCK(snx_ports_lock);
+
+
+static inline unsigned char sunix_parport_pc_read_control(struct parport *p)
+{
+	const unsigned char rm = (PARPORT_CONTROL_STROBE |
+							PARPORT_CONTROL_AUTOFD |
+							PARPORT_CONTROL_INIT |
+							PARPORT_CONTROL_SELECT);
+
+	const struct sunix_par_port *priv = p->physport->private_data;
+
+	return priv->ctr & rm;
+}
+
+static inline void sunix_parport_pc_disable_irq(struct parport *p)
+{
+	__sunix_parport_pc_frob_control(p, 0x10, 0x00);
+}
+
+
+static void sunix_frob_econtrol(struct parport *, unsigned char,
+unsigned char);
+
+// ECR modes
+#define ECR_SPP 00
+#define ECR_PS2 01
+#define ECR_PPF 02
+#define ECR_ECP 03
+#define ECR_EPP 04
+#define ECR_VND 05
+#define ECR_TST 06
+#define ECR_CNF 07
+#define ECR_MODE_MASK 0xe0
+#define ECR_WRITE(p, v) sunix_frob_econtrol((p), 0xff, (v))
+
+
+static void sunix_frob_econtrol(struct parport *pb, unsigned char m,
+unsigned char v)
+{
+	unsigned char ectr = 0;
+
+	if (m != 0xff)
+		ectr = inb(SNX_ECR(pb));
+
+	outb((ectr & ~m) ^ v, SNX_ECR(pb));
+}
+
+
+static inline void sunix_frob_set_mode(struct parport *p, int mode)
+{
+	sunix_frob_econtrol(p, ECR_MODE_MASK, mode << 5);
+}
+
+static int sunix_clear_epp_timeout(struct parport *pb)
+{
+	unsigned char dsr;
+
+	dsr = sunix_parport_pc_read_status(pb);
+
+	if (!(dsr & 0x01))
+		return 1;
+
+	sunix_parport_pc_read_status(pb);
+	dsr = sunix_parport_pc_read_status(pb);
+
+	outb(dsr | 0x01, SNX_DSR(pb));
+	outb(dsr & 0xfe, SNX_DSR(pb));
+
+	dsr = sunix_parport_pc_read_status(pb);
+
+	return !(dsr & 0x01);
+}
+
+static void parport_pc_init_state(struct pardevice *dev,
+struct parport_state *s)
+{
+	s->u.pc.ctr = 0xc;
+	if (dev->irq_func && dev->port->irq != PARPORT_IRQ_NONE)
+		s->u.pc.ctr |= 0x10;
+
+	s->u.pc.ecr = 0x34;
+}
+
+static void parport_pc_save_state(struct parport *p,
+struct parport_state *s)
+{
+	const struct sunix_par_port *priv = p->physport->private_data;
+
+	s->u.pc.ctr = priv->ctr;
+
+	if (priv->ecr)
+		s->u.pc.ecr = inb(SNX_ECR(p));
+}
+
+static void sunix_parport_pc_restore_state(struct parport *p,
+struct parport_state *s)
+{
+	struct sunix_par_port *priv = p->physport->private_data;
+
+	register unsigned char c = s->u.pc.ctr & priv->ctr_writable;
+
+	outb(c, SNX_DCR(p));
+	priv->ctr = c;
+
+	if (priv->ecr)
+		ECR_WRITE(p, s->u.pc.ecr);
+}
+
+
+static const struct parport_operations parport_pc_ops = {
+	.write_data			= parport_pc_write_data,
+	.read_data			= parport_pc_read_data,
+	.write_control		= parport_pc_write_control,
+	.read_control		= parport_pc_read_control,
+	.frob_control		= parport_pc_frob_control,
+	.read_status		= parport_pc_read_status,
+	.enable_irq			= parport_pc_enable_irq,
+	.disable_irq		= parport_pc_disable_irq,
+	.data_forward		= parport_pc_data_forward,
+	.data_reverse		= parport_pc_data_reverse,
+	.init_state			= parport_pc_init_state,
+	.save_state			= parport_pc_save_state,
+	.restore_state		= sunix_parport_pc_restore_state,
+	.compat_write_data	= sunix_parport_ieee1284_write_compat,
+	.owner				= THIS_MODULE,
+};
+
+
+static int sunix_parport_SPP_supported(struct parport *pb)
+{
+	unsigned char dcr, w;
+
+	sunix_clear_epp_timeout(pb);
+
+	w = 0xc;
+	outb(w, SNX_DCR(pb));
+
+	dcr = inb(SNX_DCR(pb));
+
+	if ((dcr & 0xf) == w) {
+		w = 0xe;
+		outb(w, SNX_DCR(pb));
+		dcr = inb(SNX_DCR(pb));
+		outb(0xc, SNX_DCR(pb));
+
+		if ((dcr & 0xf) == w)
+			return PARPORT_MODE_PCSPP;
+	}
+
+	w = 0xaa;
+	sunix_parport_pc_write_data(pb, w);
+
+	dcr = sunix_parport_pc_read_data(pb);
+
+	if (dcr == w) {
+		w = 0x55;
+		sunix_parport_pc_write_data(pb, w);
+		dcr = sunix_parport_pc_read_data(pb);
+
+		if (dcr == w)
+			return PARPORT_MODE_PCSPP;
+	}
+
+	return 0;
+}
+
+static int sunix_parport_ECR_present(struct parport *pb)
+{
+	struct sunix_par_port *priv = pb->private_data;
+	unsigned char r = 0xc;
+
+	outb(r, SNX_DCR(pb));
+
+	if ((inb(SNX_ECR(pb)) & 0x3) == (r & 0x3)) {
+		outb(r ^ 0x2, SNX_DCR(pb));
+
+		r = inb(SNX_DCR(pb));
+
+		if ((inb(SNX_ECR(pb)) & 0x2) == (r & 0x2))
+			goto no_reg;
+	}
+
+	if ((inb(SNX_ECR(pb)) & 0x3) != 0x1)
+		goto no_reg;
+
+	ECR_WRITE(pb, 0x34);
+
+	if (inb(SNX_ECR(pb)) != 0x35)
+		goto no_reg;
+
+	priv->ecr = 1;
+	outb(0xc, SNX_DCR(pb));
+
+
+	sunix_frob_set_mode(pb, ECR_SPP);
+
+	return 1;
+
+no_reg:
+	outb(0xc, SNX_DCR(pb));
+	return 0;
+}
+
+static int  sunix_parport_PS2_supported(struct parport *pb)
+{
+	return 0;
+}
+
+static int  sunix_parport_EPP_supported(struct parport *pb)
+{
+	return 0;
+}
+
+
+static int  sunix_parport_ECPEPP_supported(struct parport *pb)
+{
+	return 0;
+}
+
+static int  sunix_parport_ECPPS2_supported(struct parport *pb)
+{
+	return 0;
+}
+
+struct parport *sunix_parport_pc_probe_port(struct sunix_par_port *priv)
+{
+	struct parport_operations *ops = NULL;
+	struct parport *p = NULL;
+	struct resource *base_res;
+	struct resource	*ecr_res = NULL;
+
+	if (!priv)
+		goto out1;
+
+	ops = kzalloc(sizeof(struct parport_operations), GFP_KERNEL);
+	if (!ops)
+		goto out1;
+
+	p = sunix_parport_register_port(priv, ops);
+	if (!p)
+		goto out2;
+
+	base_res = request_region(p->base, SNX_PAR_ADDRESS_LENGTH,
+	"snx_par_base");
+	if (!base_res)
+		goto out3;
+
+	memcpy(ops, &parport_pc_ops, sizeof(struct parport_operations));
+
+	priv->ctr = 0xc;
+	priv->ctr_writable = ~0x10;
+	priv->ecr = 0;
+	priv->fifo_depth = 0;
+	priv->dma_buf = NULL;
+	priv->dma_handle = 0;
+	INIT_LIST_HEAD(&priv->list);
+
+	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
+	p->private_data = priv;
+
+	if (p->base_hi) {
+		ecr_res = request_region(p->base_hi, SNX_PAR_ADDRESS_LENGTH,
+		"snx_par_ehan");
+		if (ecr_res)
+			sunix_parport_ECR_present(p);
+
+		if (!sunix_parport_EPP_supported(p))
+			sunix_parport_ECPEPP_supported(p);
+	}
+
+	if (!sunix_parport_SPP_supported(p))
+		goto out4;
+
+	if (priv->ecr)
+		sunix_parport_ECPPS2_supported(p);
+	else
+		sunix_parport_PS2_supported(p);
+
+	p->size = (p->modes & PARPORT_MODE_EPP)?8:3;
+
+	pr_info("SNX Info : %s - PC-style at 0x%lx", p->name, p->base);
+	if (p->base_hi && priv->ecr)
+		pr_info(" (0x%lx)\n", p->base_hi);
+
+	if (priv->ecr)
+		ECR_WRITE(p, 0x34);
+
+	sunix_parport_pc_write_data(p, 0);
+
+	sunix_parport_pc_data_forward(p);
+
+
+	spin_lock(&snx_ports_lock);
+	list_add(&priv->list, &snx_ports_list);
+	spin_unlock(&snx_ports_lock);
+
+	sunix_parport_announce_port(p);
+
+	return p;
+
+out4:
+	if (ecr_res)
+		release_region(p->base_hi, SNX_PAR_ADDRESS_LENGTH);
+
+	release_region(p->base, SNX_PAR_ADDRESS_LENGTH);
+
+out3:
+	sunix_parport_put_port(p);
+
+out2:
+	kfree(ops);
+
+out1:
+	return NULL;
+}
+
+
+void sunix_parport_pc_unregister_port(struct parport *p)
+{
+	struct sunix_par_port *priv = p->private_data;
+	struct parport_operations *ops = p->ops;
+
+	sunix_parport_remove_port(p);
+
+	spin_lock(&snx_ports_lock);
+	list_del_init(&priv->list);
+	spin_unlock(&snx_ports_lock);
+
+	release_region(p->base, SNX_PAR_ADDRESS_LENGTH);
+
+	if (p->base_hi)
+		release_region(p->base_hi, SNX_PAR_ADDRESS_LENGTH);
+
+	sunix_parport_put_port(p);
+
+	kfree(ops);
+}
+
+
+int sunix_par_parport_init(void)
+{
+	struct sunix_par_port *pp = NULL;
+	int status = 0;
+	int i;
+
+	for (i = 0; i < SNX_PAR_TOTAL_MAX; i++) {
+		pp = &sunix_par_table[i];
+
+		if ((pp->base > 0) && (pp->chip_flag != SUNNONE_HWID)) {
+			pp->port = sunix_parport_pc_probe_port(pp);
+			if (!pp->port) {
+				status = -ENODEV;
+				break;
+			}
+		}
+
+		if (status != 0)
+			break;
+	}
+
+	return status;
+}
+
+
+void sunix_par_parport_exit(void)
+{
+	spin_lock(&snx_ports_lock);
+	while (!list_empty(&snx_ports_list)) {
+		struct sunix_par_port *priv;
+		struct parport *port;
+
+		priv = list_entry(snx_ports_list.next, struct sunix_par_port,
+		list);
+
+		port = priv->port;
+		spin_unlock(&snx_ports_lock);
+		sunix_parport_pc_unregister_port(port);
+		spin_lock(&snx_ports_lock);
+	}
+	spin_unlock(&snx_ports_lock);
+}
+
diff --git a/drivers/mfd/sunix/snx_ppdev.c b/drivers/mfd/sunix/snx_ppdev.c
new file mode 100644
index 000000000000..003839820340
--- /dev/null
+++ b/drivers/mfd/sunix/snx_ppdev.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_ppdev.h"
+
+#define SNX_PARPORT_MAX 4
+#define SNX_CHRDEV "sppdev"
+
+static int SNX_PPD_MAJOR;
+
+struct snx_pp_struct {
+	struct pardevice	*pdev;
+	wait_queue_head_t	irq_wait;
+	atomic_t		irqc;
+	unsigned int	flags;
+	int				irqresponse;
+	unsigned char	irqctl;
+	struct ieee1284_info	state;
+	struct ieee1284_info	saved_state;
+	long	default_inactivity;
+};
+
+
+#define SNX_PP_CLAIMED    (1<<0)
+#define SNX_PP_EXCL       (1<<1)
+
+#define SNX_PP_INTERRUPT_TIMEOUT	(10 * HZ)
+#define SNX_PP_BUFFER_SIZE	1024
+#define SNX_PARDEVICE_MAX	SNX_PAR_TOTAL_MAX
+
+
+static inline void snx_pp_enable_irq(struct snx_pp_struct *pp)
+{
+	struct parport *port = pp->pdev->port;
+
+	port->ops->enable_irq(port);
+}
+
+
+static ssize_t snx_pp_read(struct file *file,
+char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned int minor = iminor(file_inode(file));
+	struct snx_pp_struct *pp = file->private_data;
+	char *kbuffer;
+	ssize_t bytes_read = 0;
+	struct parport *pport;
+	int mode;
+
+	if (!(pp->flags & SNX_PP_CLAIMED)) {
+		pr_info("SNX Warng: %x claim the port first\n", minor);
+		return -EINVAL;
+	}
+
+	if (count == 0)
+		return 0;
+
+	kbuffer = kzalloc(min_t(size_t, count, SNX_PP_BUFFER_SIZE), GFP_KERNEL);
+
+	if (!kbuffer)
+		return -ENOMEM;
+
+	pport = pp->pdev->port;
+	mode = pport->ieee1284.mode & ~(IEEE1284_DEVICEID | IEEE1284_ADDR);
+
+	sunix_parport_set_timeout(pp->pdev,
+		(file->f_flags & O_NONBLOCK) ?
+		SNX_PARPORT_INACTIVITY_O_NONBLOCK : pp->default_inactivity);
+
+	while (bytes_read == 0)	{
+
+		ssize_t need = min_t(unsigned long, count, SNX_PP_BUFFER_SIZE);
+
+		if (mode == IEEE1284_MODE_EPP) {
+			int flags = 0;
+			size_t (*fn)(struct parport *, void *, size_t, int);
+
+			if (pp->flags & SNX_PP_W91284PIC)
+				flags |= PARPORT_W91284PIC;
+
+			if (pp->flags & SNX_PP_FASTREAD)
+				flags |= PARPORT_EPP_FAST;
+
+			if (pport->ieee1284.mode & IEEE1284_ADDR)
+				fn = pport->ops->epp_read_addr;
+			else
+				fn = pport->ops->epp_read_data;
+
+			bytes_read = (*fn)(pport, kbuffer, need, flags);
+		} else {
+			bytes_read = sunix_parport_read(pport, kbuffer, need);
+		}
+
+		if (bytes_read != 0)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			bytes_read = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			bytes_read = -ERESTARTSYS;
+			break;
+		}
+
+		cond_resched();
+
+	}
+
+	sunix_parport_set_timeout(pp->pdev, pp->default_inactivity);
+
+	if (bytes_read > 0 && copy_to_user(buf, kbuffer, bytes_read))
+		bytes_read = -EFAULT;
+
+	kfree(kbuffer);
+	snx_pp_enable_irq(pp);
+
+	return bytes_read;
+}
+
+static ssize_t snx_pp_write(struct file *file,
+const char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned int minor = iminor(file->f_path.dentry->d_inode);
+	struct snx_pp_struct *pp = file->private_data;
+	char *kbuffer;
+	ssize_t bytes_written = 0;
+	ssize_t wrote;
+	int mode;
+	struct parport *pport;
+
+	if (!(pp->flags & SNX_PP_CLAIMED)) {
+		pr_info("SNX Warng: %x claim the port first\n", minor);
+		return -EINVAL;
+	}
+
+	kbuffer = kzalloc(min_t(size_t, count, SNX_PP_BUFFER_SIZE), GFP_KERNEL);
+
+	if (!kbuffer)
+		return -ENOMEM;
+
+
+	pport = pp->pdev->port;
+	mode = pport->ieee1284.mode & ~(IEEE1284_DEVICEID | IEEE1284_ADDR);
+
+	sunix_parport_set_timeout(pp->pdev,
+		(file->f_flags & O_NONBLOCK) ?
+		SNX_PARPORT_INACTIVITY_O_NONBLOCK : pp->default_inactivity);
+
+	while (bytes_written < count) {
+
+		ssize_t n = min_t(unsigned long, count - bytes_written,
+			SNX_PP_BUFFER_SIZE);
+
+		if (copy_from_user(kbuffer, buf + bytes_written, n)) {
+			bytes_written = -EFAULT;
+			break;
+		}
+
+		if ((pp->flags & SNX_PP_FASTWRITE) && (mode ==
+		IEEE1284_MODE_EPP)) {
+			if (pport->ieee1284.mode & IEEE1284_ADDR) {
+				wrote = pport->ops->epp_write_addr(pport,
+				kbuffer, n, PARPORT_EPP_FAST);
+			} else {
+				wrote = pport->ops->epp_write_data(pport,
+				kbuffer, n, PARPORT_EPP_FAST);
+			}
+		} else {
+			wrote = sunix_parport_write(pp->pdev->port, kbuffer, n);
+		}
+
+		if (wrote <= 0) {
+			if (!bytes_written)
+				bytes_written = wrote;
+
+			break;
+		}
+
+		bytes_written += wrote;
+
+		if (file->f_flags & O_NONBLOCK) {
+			if (!bytes_written)
+				bytes_written = -EAGAIN;
+
+			break;
+		}
+
+		if (signal_pending(current)) {
+			if (!bytes_written)
+				bytes_written = -EINTR;
+
+			break;
+		}
+
+		cond_resched();
+	}
+
+	sunix_parport_set_timeout(pp->pdev, pp->default_inactivity);
+
+	kfree(kbuffer);
+	snx_pp_enable_irq(pp);
+
+	return bytes_written;
+}
+
+
+static enum ieee1284_phase snx_init_phase(int mode)
+{
+		switch (mode & ~(IEEE1284_DEVICEID | IEEE1284_ADDR)) {
+		case IEEE1284_MODE_NIBBLE:
+		case IEEE1284_MODE_BYTE:
+			return IEEE1284_PH_REV_IDLE;
+	}
+
+	return IEEE1284_PH_FWD_IDLE;
+}
+
+static int snx_pp_open(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+
+	struct snx_pp_struct *pp;
+
+	if (minor >= PARPORT_MAX)
+		return -ENXIO;
+
+	pp = kzalloc(sizeof(struct snx_pp_struct), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pp->state.mode = IEEE1284_MODE_COMPAT;
+	pp->state.phase = snx_init_phase(pp->state.mode);
+	pp->flags = 0;
+	pp->irqresponse = 0;
+	atomic_set(&pp->irqc, 0);
+
+	init_waitqueue_head(&pp->irq_wait);
+
+
+	pp->pdev = NULL;
+	file->private_data = pp;
+
+	return 0;
+}
+
+
+static int snx_pp_release(struct inode *inode, struct file *file)
+{
+	unsigned int minor = iminor(inode);
+	struct snx_pp_struct *pp = file->private_data;
+	int compat_negot;
+
+	compat_negot = 0;
+	if (!(pp->flags & SNX_PP_CLAIMED) && pp->pdev &&
+	(pp->state.mode != IEEE1284_MODE_COMPAT)) {
+		struct ieee1284_info *info;
+
+		sunix_parport_claim_or_block(pp->pdev);
+
+		pp->flags |= SNX_PP_CLAIMED;
+		info = &pp->pdev->port->ieee1284;
+		pp->saved_state.mode = info->mode;
+		pp->saved_state.phase = info->phase;
+		info->mode = pp->state.mode;
+		info->phase = pp->state.phase;
+		compat_negot = 1;
+	} else if ((pp->flags & SNX_PP_CLAIMED) && pp->pdev &&
+			(pp->pdev->port->ieee1284.mode !=
+			IEEE1284_MODE_COMPAT)) {
+		compat_negot = 2;
+	}
+
+	if (compat_negot) {
+		sunix_parport_negotiate(pp->pdev->port, IEEE1284_MODE_COMPAT);
+		pr_info("SNX Warng: %x negotiated", minor);
+		pr_info("back to compatibility mode\n");
+	}
+
+
+	if (pp->flags & SNX_PP_CLAIMED) {
+		struct ieee1284_info *info;
+
+		info = &pp->pdev->port->ieee1284;
+		pp->state.mode = info->mode;
+		pp->state.phase = info->phase;
+		info->mode = pp->saved_state.mode;
+		info->phase = pp->saved_state.phase;
+
+		sunix_parport_release(pp->pdev);
+
+		if (compat_negot != 1)
+			pr_info("SNX Warng: %x released ", minor);
+			pr_info("pardevice because user-space forgot\n");
+
+	}
+
+
+	if (pp->pdev) {
+		const char *name = pp->pdev->name;
+
+		sunix_parport_unregister_device(pp->pdev);
+		kfree(name);
+		pp->pdev = NULL;
+	}
+
+	kfree(pp);
+	return 0;
+}
+
+
+static unsigned int snx_pp_poll(struct file *file, poll_table *wait)
+{
+	struct snx_pp_struct *pp = file->private_data;
+	unsigned int mask = 0;
+
+	poll_wait(file, &pp->irq_wait, wait);
+
+	if (atomic_read(&pp->irqc))
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+
+static const struct file_operations pp_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= snx_pp_read,
+	.write		= snx_pp_write,
+	.poll		= snx_pp_poll,
+
+	.open		= snx_pp_open,
+	.release	= snx_pp_release,
+};
+
+static struct class *snx_ppdev_class;
+
+static void snx_pp_attach(struct parport *port)
+{
+	device_create(snx_ppdev_class, NULL,
+		MKDEV(SNX_PPD_MAJOR, port->number),
+		NULL, "parport%d", port->number);
+}
+
+static void snx_pp_detach(struct parport *port)
+{
+	device_destroy(snx_ppdev_class, MKDEV(SNX_PPD_MAJOR, port->number));
+}
+
+static struct parport_driver snx_pp_driver = {
+	.name		= SNX_CHRDEV,
+	.attach		= snx_pp_attach,
+	.detach		= snx_pp_detach,
+};
+
+int sunix_par_ppdev_init(void)
+{
+
+	int err = 0;
+
+	SNX_PPD_MAJOR = register_chrdev(0, SNX_CHRDEV, &pp_fops);
+
+	if (SNX_PPD_MAJOR < 0) {
+		pr_err("SNX Error: unable to get major\n");
+		return -EIO;
+	}
+
+	snx_ppdev_class = class_create(THIS_MODULE, SNX_CHRDEV);
+	if (IS_ERR(snx_ppdev_class)) {
+		err = PTR_ERR(snx_ppdev_class);
+		goto out_chrdev;
+	}
+
+
+	if (sunix_parport_register_driver(&snx_pp_driver)) {
+		pr_err("SNX Error: unable to register with parport\n");
+		goto out_class;
+	}
+
+	goto out;
+
+out_class:
+	class_destroy(snx_ppdev_class);
+out_chrdev:
+
+	unregister_chrdev(SNX_PPD_MAJOR, SNX_CHRDEV);
+
+out:
+
+
+	return err;
+}
+
+
+void sunix_par_ppdev_exit(void)
+{
+	sunix_parport_unregister_driver(&snx_pp_driver);
+	class_destroy(snx_ppdev_class);
+
+	unregister_chrdev(SNX_PPD_MAJOR, SNX_CHRDEV);
+}
+
diff --git a/drivers/mfd/sunix/snx_ppdev.h b/drivers/mfd/sunix/snx_ppdev.h
new file mode 100644
index 000000000000..887e5e837475
--- /dev/null
+++ b/drivers/mfd/sunix/snx_ppdev.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include "snx_common.h"
+
+#define SNX_PP_IOCTL	'p'
+
+#define SNX_PP_FASTWRITE	BIT(2)
+#define SNX_PP_FASTREAD		BIT(3)
+#define SNX_PP_W91284PIC	BIT(4)
+
+struct snx_ppdev_frob_struct {
+	unsigned char mask;
+	unsigned char val;
+};
+
+
diff --git a/drivers/mfd/sunix/snx_share.c b/drivers/mfd/sunix/snx_share.c
new file mode 100644
index 000000000000..327661b4ff50
--- /dev/null
+++ b/drivers/mfd/sunix/snx_share.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "snx_common.h"
+#define SNX_PARPORT_DEFAULT_TIMESLICE	(HZ/5)
+
+int		sunix_parport_default_spintime;
+static struct parport *sunix_parport_get_port(struct parport *port);
+struct parport *sunix_parport_find_base(unsigned long base);
+
+unsigned long sunix_parport_default_timeslice = SNX_PARPORT_DEFAULT_TIMESLICE;
+int sunix_parport_default_spintime = DEFAULT_SPIN_TIME;
+
+static LIST_HEAD(snx_portlist);
+static DEFINE_SPINLOCK(snx_full_list_lock);
+
+static DEFINE_SPINLOCK(snx_parportlist_lock);
+
+static LIST_HEAD(snx_all_ports);
+static LIST_HEAD(snx_drivers);
+
+static DEFINE_SEMAPHORE(snx_registration_lock);
+
+static void sunix_dead_write_lines(
+struct parport *p, unsigned char b)
+{}
+static unsigned char sunix_dead_read_lines(
+struct parport *p)
+{ return 0; }
+static unsigned char sunix_dead_frob_lines(
+struct parport *p, unsigned char b, unsigned char c)
+{ return 0; }
+static void sunix_dead_onearg(struct parport *p)
+{}
+static void sunix_dead_initstate(
+struct pardevice *d, struct parport_state *s)
+{}
+static void sunix_dead_state(
+struct parport *p, struct parport_state *s)
+{}
+static size_t sunix_dead_write(
+struct parport *p, const void *b, size_t l, int f)
+{ return 0; }
+static size_t sunix_dead_read(
+struct parport *p, void *b, size_t l, int f)
+{ return 0; }
+
+
+static struct parport_operations	dead_ops = {
+	.write_data			= sunix_dead_write_lines,
+	.read_data			= sunix_dead_read_lines,
+	.write_control		= sunix_dead_write_lines,
+	.read_control		= sunix_dead_read_lines,
+	.frob_control		= sunix_dead_frob_lines,
+	.read_status		= sunix_dead_read_lines,
+	.enable_irq			= sunix_dead_onearg,
+	.disable_irq		= sunix_dead_onearg,
+	.data_forward		= sunix_dead_onearg,
+	.data_reverse		= sunix_dead_onearg,
+	.init_state			= sunix_dead_initstate,
+	.save_state			= sunix_dead_state,
+	.restore_state		= sunix_dead_state,
+	.epp_write_data		= sunix_dead_write,
+	.epp_read_data		= sunix_dead_read,
+	.epp_write_addr		= sunix_dead_write,
+	.epp_read_addr		= sunix_dead_read,
+	.ecp_write_data		= sunix_dead_write,
+	.ecp_read_data		= sunix_dead_read,
+	.ecp_write_addr		= sunix_dead_write,
+	.compat_write_data	= sunix_dead_write,
+	.nibble_read_data	= sunix_dead_read,
+	.byte_read_data		= sunix_dead_read,
+	.owner				= NULL,
+
+};
+
+
+static void sunix_attach_driver_chain(struct parport *port)
+{
+	struct parport_driver *drv;
+
+	list_for_each_entry(drv, &snx_drivers, list) drv->attach(port);
+}
+
+static void sunix_detach_driver_chain(struct parport *port)
+{
+	struct parport_driver *drv;
+
+	list_for_each_entry(drv, &snx_drivers, list) drv->detach(port);
+}
+
+int sunix_parport_register_driver(struct parport_driver *drv)
+{
+	struct parport *port;
+
+	down(&snx_registration_lock);
+
+	list_for_each_entry(port, &snx_portlist, list) drv->attach(port);
+	list_add(&drv->list, &snx_drivers);
+
+	up(&snx_registration_lock);
+
+	return 0;
+}
+
+void sunix_parport_unregister_driver(struct parport_driver *drv)
+{
+	struct parport *port;
+
+	down(&snx_registration_lock);
+
+	list_del_init(&drv->list);
+	list_for_each_entry(port, &snx_portlist, list) drv->detach(port);
+
+	up(&snx_registration_lock);
+}
+
+static void sunix_free_port(struct parport *port)
+{
+	int d;
+
+	spin_lock(&snx_full_list_lock);
+	list_del(&port->full_list);
+	spin_unlock(&snx_full_list_lock);
+
+	for (d = 0; d < 5; d++) {
+		kfree(port->probe_info[d].class_name);
+		kfree(port->probe_info[d].mfr);
+		kfree(port->probe_info[d].model);
+		kfree(port->probe_info[d].cmdset);
+		kfree(port->probe_info[d].description);
+	}
+
+	kfree(port->name);
+	kfree(port);
+}
+
+static struct parport *sunix_parport_get_port(struct parport *port)
+{
+	atomic_inc(&port->ref_count);
+	return port;
+}
+
+
+void sunix_parport_put_port(struct parport *port)
+{
+	if (atomic_dec_and_test(&port->ref_count))
+		sunix_free_port(port);
+}
+
+
+struct parport *sunix_parport_register_port(struct sunix_par_port *priv,
+struct parport_operations *ops)
+{
+	struct list_head *l = NULL;
+	struct parport *tmp = NULL;
+	int num;
+	int device;
+	char *name;
+
+	if ((!priv) || (!ops))
+		return NULL;
+
+
+	tmp = kzalloc(sizeof(struct parport), GFP_KERNEL);
+
+	if (!tmp)
+		return NULL;
+
+
+	memset(tmp, 0, sizeof(struct parport));
+
+	tmp->base = priv->base;
+	tmp->irq = priv->irq;
+
+	tmp->base_hi = priv->base_hi;
+
+	tmp->muxport = tmp->daisy = tmp->muxsel = -1;
+	tmp->modes = 0;
+
+	INIT_LIST_HEAD(&tmp->list);
+
+	tmp->devices = tmp->cad = NULL;
+	tmp->flags = 0;
+	tmp->ops = ops;
+	tmp->physport = tmp;
+
+	memset(tmp->probe_info, 0, 5 * sizeof(struct parport_device_info));
+
+	rwlock_init(&tmp->cad_lock);
+	spin_lock_init(&tmp->waitlist_lock);
+	spin_lock_init(&tmp->pardevice_lock);
+	tmp->ieee1284.mode = IEEE1284_MODE_COMPAT;
+	tmp->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
+
+	sema_init(&tmp->ieee1284.irq, 0);
+
+	tmp->spintime = sunix_parport_default_spintime;
+
+	atomic_set(&tmp->ref_count, 1);
+
+	INIT_LIST_HEAD(&tmp->full_list);
+
+	name = kzalloc(20, GFP_KERNEL);
+	if (!name)
+		return NULL;
+
+	spin_lock(&snx_full_list_lock);
+
+	for (l = snx_all_ports.next, num = 2; l != &snx_all_ports;
+		l = l->next, num++) {
+		struct parport *p = list_entry(l, struct parport,
+		full_list);
+
+		if (p->number != num)
+			break;
+
+	}
+
+	tmp->portnum = tmp->number = num;
+
+	list_add_tail(&tmp->full_list, l);
+
+	spin_unlock(&snx_full_list_lock);
+
+
+	sprintf(name, "parport%d", tmp->portnum = tmp->number);
+	tmp->name = name;
+
+	for (device = 0; device < 5; device++)
+		tmp->probe_info[device].class = PARPORT_CLASS_LEGACY;
+
+	tmp->waithead = tmp->waittail = NULL;
+
+	return tmp;
+}
+
+
+void sunix_parport_announce_port(struct parport *port)
+{
+	int i;
+
+	down(&snx_registration_lock);
+
+	spin_lock_irq(&snx_parportlist_lock);
+
+	list_add_tail(&port->list, &snx_portlist);
+
+	for (i = 1; i < 3; i++) {
+		struct parport *slave = port->slaves[i-1];
+
+		if (slave)
+			list_add_tail(&slave->list, &snx_portlist);
+
+	}
+	spin_unlock_irq(&snx_parportlist_lock);
+
+	sunix_attach_driver_chain(port);
+
+	for (i = 1; i < 3; i++) {
+		struct parport *slave = port->slaves[i-1];
+
+		if (slave)
+			sunix_attach_driver_chain(slave);
+
+	}
+
+	up(&snx_registration_lock);
+}
+
+
+void sunix_parport_remove_port(struct parport *port)
+{
+	int i;
+
+	down(&snx_registration_lock);
+
+	sunix_detach_driver_chain(port);
+
+	port->ops = &dead_ops;
+	spin_lock(&snx_parportlist_lock);
+	list_del_init(&port->list);
+
+	for (i = 1; i < 3; i++) {
+		struct parport *slave = port->slaves[i-1];
+
+		if (slave)
+			list_del_init(&slave->list);
+
+	}
+
+	spin_unlock(&snx_parportlist_lock);
+
+	up(&snx_registration_lock);
+
+	for (i = 1; i < 3; i++) {
+		struct parport *slave = port->slaves[i-1];
+
+		if (slave)
+			sunix_parport_put_port(slave);
+
+	}
+
+}
+
+struct pardevice *sunix_parport_register_device(
+	struct parport	*port,
+	const char			*name,
+	int					(*pf)(void *),
+	void	(*kf)(void *),
+	void	(*irq_func)(void *),
+	int		flags,
+	void	*handle
+	)
+{
+	struct pardevice *tmp;
+
+	if (port->physport->flags & PARPORT_FLAG_EXCL) {
+		pr_info("SNX Warng: %s no more devices allowed\n", port->name);
+		return NULL;
+	}
+
+	if (flags & PARPORT_DEV_LURK) {
+		if (!pf || !kf) {
+			pr_info("SNX Error: %s refused to register lurking device (%s)\n",
+			port->name, name);
+			return NULL;
+		}
+	}
+
+	sunix_parport_get_port(port);
+
+	tmp = kzalloc(sizeof(struct pardevice), GFP_KERNEL);
+	if (tmp == NULL)
+		goto out;
+
+	tmp->state = kzalloc(sizeof(struct parport_state), GFP_KERNEL);
+	if (tmp->state == NULL)
+		goto out_free_pardevice;
+
+	tmp->name = name;
+	tmp->port = port;
+	tmp->daisy = -1;
+	tmp->preempt = pf;
+	tmp->wakeup = kf;
+	tmp->private = handle;
+	tmp->flags = flags;
+	tmp->irq_func = irq_func;
+	tmp->waiting = 0;
+	tmp->timeout = 5 * HZ;
+
+	tmp->prev = NULL;
+
+	spin_lock(&port->physport->pardevice_lock);
+
+	if (flags & PARPORT_DEV_EXCL) {
+		if (port->physport->devices) {
+			spin_unlock(&port->physport->pardevice_lock);
+			pr_info("SNX Error: %s cannot grant exclusive access for device %s\n",
+			port->name, name);
+			goto out_free_all;
+		}
+		port->flags |= PARPORT_FLAG_EXCL;
+	}
+
+	tmp->next = port->physport->devices;
+	wmb();
+
+	if (port->physport->devices)
+		port->physport->devices->prev = tmp;
+
+	port->physport->devices = tmp;
+	spin_unlock(&port->physport->pardevice_lock);
+
+	init_waitqueue_head(&tmp->wait_q);
+	tmp->timeslice = sunix_parport_default_timeslice;
+	tmp->waitnext = tmp->waitprev = NULL;
+
+	port->ops->init_state(tmp, tmp->state);
+	return tmp;
+
+out_free_all:
+	kfree(tmp->state);
+
+out_free_pardevice:
+	kfree(tmp);
+
+out:
+	sunix_parport_put_port(port);
+
+	return NULL;
+}
+
+
+void sunix_parport_unregister_device(struct pardevice *dev)
+{
+	struct parport *port;
+
+	if (dev == NULL)
+		return;
+
+	port = dev->port->physport;
+
+	if (port->cad == dev) {
+		pr_info("SNX Warng: %s, %s forgot to release port\n",
+		port->name, dev->name);
+		sunix_parport_release(dev);
+	}
+
+	spin_lock(&port->pardevice_lock);
+	if (dev->next)
+		dev->next->prev = dev->prev;
+
+	if (dev->prev)
+		dev->prev->next = dev->next;
+	else
+		port->devices = dev->next;
+
+	if (dev->flags & PARPORT_DEV_EXCL)
+		port->flags &= ~PARPORT_FLAG_EXCL;
+
+	spin_unlock(&port->pardevice_lock);
+
+	spin_lock(&port->waitlist_lock);
+	if (dev->waitprev || dev->waitnext || port->waithead == dev) {
+		if (dev->waitprev)
+			dev->waitprev->waitnext = dev->waitnext;
+		else
+			port->waithead = dev->waitnext;
+
+		if (dev->waitnext)
+			dev->waitnext->waitprev = dev->waitprev;
+		else
+			port->waittail = dev->waitprev;
+	}
+
+	spin_unlock(&port->waitlist_lock);
+
+	kfree(dev->state);
+	kfree(dev);
+
+	sunix_parport_put_port(port);
+}
+
+
+struct parport *sunix_parport_find_number(int number)
+{
+	struct parport *port, *result = NULL;
+
+	spin_lock(&snx_parportlist_lock);
+
+	list_for_each_entry(port, &snx_portlist, list) {
+		if (port->number == number) {
+			result = sunix_parport_get_port(port);
+			break;
+		}
+	}
+	spin_unlock(&snx_parportlist_lock);
+	return result;
+}
+
+
+struct parport *sunix_parport_find_base(unsigned long base)
+{
+	struct parport *port, *result = NULL;
+
+	spin_lock(&snx_parportlist_lock);
+
+	list_for_each_entry(port, &snx_portlist, list) {
+		if (port->base == base) {
+			result = sunix_parport_get_port(port);
+			break;
+		}
+	}
+
+	spin_unlock(&snx_parportlist_lock);
+
+	return result;
+}
+
+
+int sunix_parport_claim(struct pardevice *dev)
+{
+	struct pardevice *oldcad;
+	struct parport *port = dev->port->physport;
+	unsigned long flags;
+
+	if (port->cad == dev) {
+		pr_info("SNX Info : %s, %s already owner\n",
+		dev->port->name, dev->name);
+		return 0;
+	}
+
+	write_lock_irqsave(&port->cad_lock, flags);
+	oldcad = port->cad;
+	if (oldcad != NULL) {
+		if (oldcad->preempt) {
+			if (oldcad->preempt(oldcad->private))
+				goto blocked;
+
+			port->ops->save_state(port, dev->state);
+		} else {
+			goto blocked;
+		}
+
+		if (port->cad != oldcad) {
+			pr_info("SNX Error: %s, %s released port when preempted!\n",
+			port->name, oldcad->name);
+			if (port->cad)
+				goto blocked;
+
+		}
+	}
+
+	if (dev->waiting & 1) {
+		dev->waiting = 0;
+
+		spin_lock_irq(&port->waitlist_lock);
+
+		if (dev->waitprev)
+			dev->waitprev->waitnext = dev->waitnext;
+		else
+			port->waithead = dev->waitnext;
+
+		if (dev->waitnext)
+			dev->waitnext->waitprev = dev->waitprev;
+		else
+			port->waittail = dev->waitprev;
+
+		spin_unlock_irq(&port->waitlist_lock);
+		dev->waitprev = dev->waitnext = NULL;
+	}
+
+	port->cad = dev;
+
+	port->ops->restore_state(port, dev->state);
+	write_unlock_irqrestore(&port->cad_lock, flags);
+	dev->time = jiffies;
+
+	return 0;
+
+blocked:
+	if (dev->waiting & 2 || dev->wakeup) {
+		spin_lock(&port->waitlist_lock);
+		if (test_and_set_bit(0, &dev->waiting) == 0) {
+			dev->waitnext = NULL;
+			dev->waitprev = port->waittail;
+			if (port->waittail) {
+				port->waittail->waitnext = dev;
+				port->waittail = dev;
+			} else {
+				port->waithead = port->waittail = dev;
+			}
+		}
+
+		spin_unlock(&port->waitlist_lock);
+	}
+
+	write_unlock_irqrestore(&port->cad_lock, flags);
+	return -EAGAIN;
+}
+
+
+int sunix_parport_claim_or_block(struct pardevice *dev)
+{
+	int r;
+
+	dev->waiting = 2;
+
+	r = sunix_parport_claim(dev);
+
+	if (r == -EAGAIN) {
+
+		pr_info("SNX Warng: %s returned -EAGAIN\n", dev->name);
+
+		if (dev->waiting) {
+
+			wait_event_interruptible(dev->wait_q, !dev->waiting);
+
+			if (signal_pending(current))
+				return -EINTR;
+
+			r = 1;
+		} else {
+			r = 0;
+		}
+	}
+	dev->waiting = 0;
+
+	return r;
+}
+
+
+void sunix_parport_release(struct pardevice *dev)
+{
+	struct parport *port = dev->port->physport;
+	struct pardevice *pd;
+	unsigned long flags;
+
+	write_lock_irqsave(&port->cad_lock, flags);
+	if (port->cad != dev) {
+		write_unlock_irqrestore(&port->cad_lock, flags);
+		pr_info("SNX Warng: %s, %s tried to release parport when notowner\n",
+		port->name, dev->name);
+		return;
+	}
+
+	port->cad = NULL;
+	write_unlock_irqrestore(&port->cad_lock, flags);
+
+	port->ops->save_state(port, dev->state);
+
+	for (pd = port->waithead; pd; pd = pd->waitnext) {
+		if (pd->waiting & 2) {
+			sunix_parport_claim(pd);
+			if (waitqueue_active(&pd->wait_q)) /* */
+				wake_up_interruptible(&pd->wait_q);
+
+			return;
+		} else if (pd->wakeup) {
+			pd->wakeup(pd->private);
+
+			if (dev->port->cad)
+				return;
+
+		} else {
+			pr_info("SNX Warng: %s don't know how to wake %s\n",
+			port->name, pd->name);
+		}
+	}
+
+	for (pd = port->devices; (port->cad == NULL) && pd; pd = pd->next) {
+		if (pd->wakeup && pd != dev)
+			pd->wakeup(pd->private);
+	}
+}
-- 
2.17.1

