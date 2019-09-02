Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCC8217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfIBJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:53:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfIBJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D77F928CBA0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 03/10] mfd / platform: cros_ec: Miscellaneous character device to talk with the EC
Date:   Mon,  2 Sep 2019 11:53:02 +0200
Message-Id: <20190902095309.18574-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's a driver to talk with the ChromeOS Embedded Controller via a
miscellaneous character device, it creates an entry in /dev for every
instance and implements basic file operations for communicating with the
Embedded Controller with an userspace application. The API is moved to
the uapi folder, which is supposed to contain the user space API of the
kernel.

Note that this will replace current character device interface
implemented in the cros-ec-dev driver in the MFD subsystem. The idea is
to move all the functionality that extends the bounds of what MFD was
designed to platform/chrome subsystem.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v7: None
Changes in v6:
- Move cros_ec_chardev.h to include/linux/platform_data

Changes in v5:
- Prefix the versions strings with CROS_EC_DEV_VERSION (Gwendal)

Changes in v4: None
Changes in v3:
- Fix 'linux/mfd/cros_ec.h' is not exported (reported by lkp)

Changes in v2:
- Remove the list, and the lock, as are not needed (Greg Kroah-Hartman)
- Remove dev_info in probe, anyway we will see the chardev or not if the
  probe fails (Greg Kroah-Hartman)

 drivers/mfd/cros_ec_dev.c                     |   4 +-
 drivers/platform/chrome/Kconfig               |  11 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_chardev.c     | 251 ++++++++++++++++++
 .../linux/platform_data/cros_ec_chardev.h     |  10 +-
 5 files changed, 272 insertions(+), 5 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
 rename drivers/mfd/cros_ec_dev.h => include/linux/platform_data/cros_ec_chardev.h (83%)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 41dccced5026..4c96445b1bf5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -7,15 +7,17 @@
 
 #include <linux/fs.h>
 #include <linux/mfd/core.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/platform_data/cros_ec_chardev.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
-#include "cros_ec_dev.h"
 
 #define DRV_NAME "cros-ec-dev"
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index eaeb04e07335..bd3524bd6b37 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -136,6 +136,17 @@ config CROS_KBD_LED_BACKLIGHT
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_kbd_led_backlight.
 
+config CROS_EC_CHARDEV
+	tristate "ChromeOS EC miscdevice"
+	depends on MFD_CROS_EC_CHARDEV
+	default MFD_CROS_EC_CHARDEV
+	help
+	  This driver adds file operations support to talk with the
+	  ChromeOS EC from userspace via a character device.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_chardev.
+
 config CROS_EC_LIGHTBAR
 	tristate "Chromebook Pixel's lightbar support"
 	depends on MFD_CROS_EC_CHARDEV
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 12ff8de5ac7a..477ec3d1d1c9 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -15,6 +15,7 @@ cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
+obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
new file mode 100644
index 000000000000..174f940822c9
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Miscellaneous character driver for ChromeOS Embedded Controller
+ *
+ * Copyright 2014 Google, Inc.
+ * Copyright 2019 Google LLC
+ *
+ * This file is a rework and part of the code is ported from
+ * drivers/mfd/cros_ec_dev.c that was originally written by
+ * Bill Richardson.
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_chardev.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define DRV_NAME		"cros-ec-chardev"
+
+struct chardev_data {
+	struct cros_ec_dev *ec_dev;
+	struct miscdevice misc;
+};
+
+static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
+{
+	static const char * const current_image_name[] = {
+		"unknown", "read-only", "read-write", "invalid",
+	};
+	struct ec_response_get_version *resp;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
+	msg->insize = sizeof(*resp);
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0) {
+		snprintf(str, maxlen,
+			 "Unknown EC version, returned error: %d\n",
+			 msg->result);
+		goto exit;
+	}
+
+	resp = (struct ec_response_get_version *)msg->data;
+	if (resp->current_image >= ARRAY_SIZE(current_image_name))
+		resp->current_image = 3; /* invalid */
+
+	snprintf(str, maxlen, "%s\n%s\n%s\n%s\n", CROS_EC_DEV_VERSION,
+		 resp->version_string_ro, resp->version_string_rw,
+		 current_image_name[resp->current_image]);
+
+	ret = 0;
+exit:
+	kfree(msg);
+	return ret;
+}
+
+/*
+ * Device file ops
+ */
+static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
+{
+	struct miscdevice *mdev = filp->private_data;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(mdev->parent);
+
+	filp->private_data = ec_dev;
+	nonseekable_open(inode, filp);
+
+	return 0;
+}
+
+static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
+				     size_t length, loff_t *offset)
+{
+	char msg[sizeof(struct ec_response_get_version) +
+		 sizeof(CROS_EC_DEV_VERSION)];
+	struct cros_ec_dev *ec = filp->private_data;
+	size_t count;
+	int ret;
+
+	if (*offset != 0)
+		return 0;
+
+	ret = ec_get_version(ec, msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	count = min(length, strlen(msg));
+
+	if (copy_to_user(buffer, msg, count))
+		return -EFAULT;
+
+	*offset = count;
+	return count;
+}
+
+/*
+ * Ioctls
+ */
+static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
+{
+	struct cros_ec_command *s_cmd;
+	struct cros_ec_command u_cmd;
+	long ret;
+
+	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
+		return -EFAULT;
+
+	if (u_cmd.outsize > EC_MAX_MSG_BYTES ||
+	    u_cmd.insize > EC_MAX_MSG_BYTES)
+		return -EINVAL;
+
+	s_cmd = kmalloc(sizeof(*s_cmd) + max(u_cmd.outsize, u_cmd.insize),
+			GFP_KERNEL);
+	if (!s_cmd)
+		return -ENOMEM;
+
+	if (copy_from_user(s_cmd, arg, sizeof(*s_cmd) + u_cmd.outsize)) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	if (u_cmd.outsize != s_cmd->outsize ||
+	    u_cmd.insize != s_cmd->insize) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	s_cmd->command += ec->cmd_offset;
+	ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
+	/* Only copy data to userland if data was received. */
+	if (ret < 0)
+		goto exit;
+
+	if (copy_to_user(arg, s_cmd, sizeof(*s_cmd) + s_cmd->insize))
+		ret = -EFAULT;
+exit:
+	kfree(s_cmd);
+	return ret;
+}
+
+static long cros_ec_chardev_ioctl_readmem(struct cros_ec_dev *ec,
+					   void __user *arg)
+{
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	struct cros_ec_readmem s_mem = { };
+	long num;
+
+	/* Not every platform supports direct reads */
+	if (!ec_dev->cmd_readmem)
+		return -ENOTTY;
+
+	if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
+		return -EFAULT;
+
+	num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
+				  s_mem.buffer);
+	if (num <= 0)
+		return num;
+
+	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
+		return -EFAULT;
+
+	return num;
+}
+
+static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct cros_ec_dev *ec = filp->private_data;
+
+	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case CROS_EC_DEV_IOCXCMD:
+		return cros_ec_chardev_ioctl_xcmd(ec, (void __user *)arg);
+	case CROS_EC_DEV_IOCRDMEM:
+		return cros_ec_chardev_ioctl_readmem(ec, (void __user *)arg);
+	}
+
+	return -ENOTTY;
+}
+
+static const struct file_operations chardev_fops = {
+	.open		= cros_ec_chardev_open,
+	.read		= cros_ec_chardev_read,
+	.unlocked_ioctl	= cros_ec_chardev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= cros_ec_chardev_ioctl,
+#endif
+};
+
+static int cros_ec_chardev_probe(struct platform_device *pdev)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
+	struct cros_ec_platform *ec_platform = dev_get_platdata(ec_dev->dev);
+	struct chardev_data *data;
+
+	/* Create a char device: we want to create it anew */
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ec_dev = ec_dev;
+	data->misc.minor = MISC_DYNAMIC_MINOR;
+	data->misc.fops = &chardev_fops;
+	data->misc.name = ec_platform->ec_name;
+	data->misc.parent = pdev->dev.parent;
+
+	dev_set_drvdata(&pdev->dev, data);
+
+	return misc_register(&data->misc);
+}
+
+static int cros_ec_chardev_remove(struct platform_device *pdev)
+{
+	struct chardev_data *data = dev_get_drvdata(&pdev->dev);
+
+	misc_deregister(&data->misc);
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_chardev_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_ec_chardev_probe,
+	.remove = cros_ec_chardev_remove,
+};
+
+module_platform_driver(cros_ec_chardev_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
+MODULE_DESCRIPTION("ChromeOS EC Miscellaneous Character Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/cros_ec_dev.h b/include/linux/platform_data/cros_ec_chardev.h
similarity index 83%
rename from drivers/mfd/cros_ec_dev.h
rename to include/linux/platform_data/cros_ec_chardev.h
index 7a42c3ef50e4..6600b54f531c 100644
--- a/drivers/mfd/cros_ec_dev.h
+++ b/include/linux/platform_data/cros_ec_chardev.h
@@ -1,15 +1,17 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to userspace
+ * ChromeOS EC device interface.
  *
  * Copyright (C) 2014 Google, Inc.
  */
 
-#ifndef _CROS_EC_DEV_H_
-#define _CROS_EC_DEV_H_
+#ifndef _UAPI_LINUX_CROS_EC_DEV_H_
+#define _UAPI_LINUX_CROS_EC_DEV_H_
 
+#include <linux/bits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+
 #include <linux/mfd/cros_ec.h>
 
 #define CROS_EC_DEV_VERSION "1.0.0"
-- 
2.20.1

