Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC28E2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:33:39 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:38969 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:33:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D1D98184FB;
        Wed,  3 Apr 2019 13:33:35 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id z_6qmRebuE7i; Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id C948E185BE;
        Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFCED1A08E;
        Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A49671A066;
        Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 986CC212A;
        Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 9526580D28; Wed,  3 Apr 2019 13:33:34 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] tty: Add NULL TTY driver
Date:   Wed,  3 Apr 2019 13:33:27 +0200
Message-Id: <20190403113327.3628-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no console driver is enabled (or if a non-present driver is selected
with something like console=null in an attempt to disable the console),
opening /dev/console errors out, and init scripts and other userspace
code that relies on the existence of a console will fail.  Symlinking
/dev/null to /dev/console does not solve the problem since /dev/null
does not behave like a real TTY.

To just provide a dummy console to userspace when no console driver is
available or desired, add a ttynull driver which simply discards all
writes.  It can be chosen on the command line in the standard way, i.e.
with console=ttynull.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/Kconfig   |  14 ++++++
 drivers/tty/Makefile  |   1 +
 drivers/tty/ttynull.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/tty/ttynull.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0a04bfc873e..d862f442f389 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -376,6 +376,20 @@ config PPC_EARLY_DEBUG_EHV_BC_HANDLE
 	  there simply will be no early console output.  This is true also
 	  if you don't boot under a hypervisor at all.
 
+config NULL_TTY
+	tristate "NULL TTY driver"
+	help
+	  Say Y here if you want a NULL TTY which simply discards messages.
+
+	  This is useful to allow userspace applications which expect a console
+	  device to work without modifications even when no console is
+	  available or desired.
+
+	  In order to use this driver, you should redirect the console to this
+	  TTY, or boot the kernel with console=ttynull.
+
+	  If unsure, say N.
+
 config GOLDFISH_TTY
 	tristate "Goldfish TTY Driver"
 	depends on GOLDFISH
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index c72cafdf32b4..020b1cd9294f 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ISI)		+= isicom.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
+obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
new file mode 100644
index 000000000000..17f05b7eb6d3
--- /dev/null
+++ b/drivers/tty/ttynull.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Axis Communications AB
+ *
+ * Based on ttyprintk.c:
+ *  Copyright (C) 2010 Samo Pogacnik
+ */
+
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+
+static const struct tty_port_operations ttynull_port_ops;
+static struct tty_driver *ttynull_driver;
+static struct tty_port ttynull_port;
+
+static int ttynull_open(struct tty_struct *tty, struct file *filp)
+{
+	return tty_port_open(&ttynull_port, tty, filp);
+}
+
+static void ttynull_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(&ttynull_port, tty, filp);
+}
+
+static void ttynull_hangup(struct tty_struct *tty)
+{
+	tty_port_hangup(&ttynull_port);
+}
+
+static int ttynull_write(struct tty_struct *tty, const unsigned char *buf,
+			 int count)
+{
+	return count;
+}
+
+static int ttynull_write_room(struct tty_struct *tty)
+{
+	return 65536;
+}
+
+static const struct tty_operations ttynull_ops = {
+	.open = ttynull_open,
+	.close = ttynull_close,
+	.hangup = ttynull_hangup,
+	.write = ttynull_write,
+	.write_room = ttynull_write_room,
+};
+
+static struct tty_driver *ttynull_device(struct console *c, int *index)
+{
+	*index = 0;
+	return ttynull_driver;
+}
+
+static struct console ttynull_console = {
+	.name = "ttynull",
+	.device = ttynull_device,
+};
+
+static int __init ttynull_init(void)
+{
+	struct tty_driver *driver;
+	int ret;
+
+	driver = tty_alloc_driver(1,
+		TTY_DRIVER_RESET_TERMIOS |
+		TTY_DRIVER_REAL_RAW |
+		TTY_DRIVER_UNNUMBERED_NODE);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
+
+	tty_port_init(&ttynull_port);
+	ttynull_port.ops = &ttynull_port_ops;
+
+	driver->driver_name = "ttynull";
+	driver->name = "ttynull";
+	driver->type = TTY_DRIVER_TYPE_CONSOLE;
+	driver->init_termios = tty_std_termios;
+	driver->init_termios.c_oflag = OPOST | OCRNL | ONOCR | ONLRET;
+	tty_set_operations(driver, &ttynull_ops);
+	tty_port_link_device(&ttynull_port, driver, 0);
+
+	ret = tty_register_driver(driver);
+	if (ret < 0) {
+		put_tty_driver(driver);
+		tty_port_destroy(&ttynull_port);
+		return ret;
+	}
+
+	ttynull_driver = driver;
+	register_console(&ttynull_console);
+
+	return 0;
+}
+
+static void __exit ttynull_exit(void)
+{
+	unregister_console(&ttynull_console);
+	tty_unregister_driver(ttynull_driver);
+	put_tty_driver(ttynull_driver);
+	tty_port_destroy(&ttynull_port);
+}
+
+module_init(ttynull_init);
+module_exit(ttynull_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.20.0

