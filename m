Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8EDC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9122072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLQIRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:17:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36759 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:17:52 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ih839-0000yH-65; Tue, 17 Dec 2019 09:17:47 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ih837-0002IV-Mf; Tue, 17 Dec 2019 09:17:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/3] tty: new helper function tty_kopen_shared
Date:   Tue, 17 Dec 2019 09:17:16 +0100
Message-Id: <20191217081718.23807-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191217081718.23807-1-u.kleine-koenig@pengutronix.de>
References: <20191217081718.23807-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function gives a struct tty_struct for a given device number.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/tty_io.c | 27 +++++++++++++++++++++++++++
 include/linux/tty.h  |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d9f54c7d94f2..584025117cd3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1925,6 +1925,33 @@ struct tty_struct *tty_kopen(dev_t device)
 }
 EXPORT_SYMBOL_GPL(tty_kopen);
 
+/*
+ * Caller gets a reference on (non-error) ttys, that must be disposed using
+ * tty_kref_put().
+ */
+struct tty_struct *tty_kopen_shared(dev_t device)
+{
+	struct tty_struct *tty;
+	struct tty_driver *driver;
+	int index = -1;
+
+	mutex_lock(&tty_mutex);
+	driver = tty_lookup_driver(device, NULL, &index);
+	if (IS_ERR(driver)) {
+		tty = ERR_CAST(driver);
+		goto err_lookup_driver;
+	}
+
+	tty = tty_driver_lookup_tty(driver, NULL, index);
+
+	tty_driver_kref_put(driver);
+err_lookup_driver:
+
+	mutex_unlock(&tty_mutex);
+	return tty;
+}
+EXPORT_SYMBOL(tty_kopen_shared);
+
 /**
  *	tty_open_by_driver	-	open a tty device
  *	@device: dev_t of device to open
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..616268eb1613 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -412,6 +412,7 @@ extern struct tty_struct *get_current_tty(void);
 extern int __init tty_init(void);
 extern const char *tty_name(const struct tty_struct *tty);
 extern struct tty_struct *tty_kopen(dev_t device);
+extern struct tty_struct *tty_kopen_shared(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
 extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
-- 
2.24.0

