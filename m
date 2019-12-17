Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46644C2D0D1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLQPHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:07:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:07:47 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihERp-0008EQ-US; Tue, 17 Dec 2019 16:07:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihERp-0000VS-BU; Tue, 17 Dec 2019 16:07:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 2/3] tty: new helper function tty_get_icount()
Date:   Tue, 17 Dec 2019 16:07:35 +0100
Message-Id: <20191217150736.1479-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191217150736.1479-1-u.kleine-koenig@pengutronix.de>
References: <20191217150736.1479-1-u.kleine-koenig@pengutronix.de>
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

For a given struct tty_struct this yields the corresponding statistics
about sent and received characters (and some more) which is needed to
implement an LED trigger for tty devices.

The new function is then used to simplify tty_tiocgicount().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/tty_io.c | 29 +++++++++++++++++++++++++----
 include/linux/tty.h  |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b718666ce73c..3e74e6cec1a6 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2492,15 +2492,36 @@ static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	return tty->ops->tiocmset(tty, set, clear);
 }
 
+/**
+ *	tty_get_icount		-	get tty statistics
+ *	@tty: tty device
+ *	@icount: output parameter
+ *
+ *	Gets a copy of the tty's icount statistics.
+ *
+ *	Locking: none (up to the driver)
+ */
+int tty_get_icount(struct tty_struct *tty,
+		   struct serial_icounter_struct *icount)
+{
+	memset(icount, 0, sizeof(*icount));
+
+	if (tty->ops->get_icount)
+		return tty->ops->get_icount(tty, icount);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tty_get_icount);
+
 static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 {
-	int retval = -EINVAL;
 	struct serial_icounter_struct icount;
-	memset(&icount, 0, sizeof(icount));
-	if (tty->ops->get_icount)
-		retval = tty->ops->get_icount(tty, &icount);
+	int retval;
+
+	retval = tty_get_icount(tty, &icount);
 	if (retval != 0)
 		return retval;
+
 	if (copy_to_user(arg, &icount, sizeof(icount)))
 		return -EFAULT;
 	return 0;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d0bcf3226fb2..40ea5c409619 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -495,6 +495,8 @@ extern void tty_unthrottle(struct tty_struct *tty);
 extern int tty_throttle_safe(struct tty_struct *tty);
 extern int tty_unthrottle_safe(struct tty_struct *tty);
 extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
+extern int tty_get_icount(struct tty_struct *tty,
+			  struct serial_icounter_struct *icount);
 extern int is_current_pgrp_orphaned(void);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
-- 
2.24.0

