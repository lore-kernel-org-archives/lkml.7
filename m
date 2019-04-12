Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71664C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2411F20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 22:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJgFTYQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLWps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:45:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40268 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfDLWpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 18:45:47 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so18371863itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iY6XRV6z4QH7U0FQXaTjHwTWnz+FcCMh9XOUwYR/u9w=;
        b=PJgFTYQh0GfuYfu+NnehROL8Bz/dw3Xrmd6fUqQiighZ1esKpEQs4wz4OGoScT1+DY
         sGmaPthMUlfc0WS6844eeVaIEMEuLsIMQx+4AivRa6szlmM470pcNsI0uUEMInjeYF3c
         pORR/K24INRqRMnoMQ1PV5dtWJpCizqRFQ6Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iY6XRV6z4QH7U0FQXaTjHwTWnz+FcCMh9XOUwYR/u9w=;
        b=cWMK5h4gfkhPC9obYZBLgZFBNed4Q17BPr9DHwPb7dWOpr0+W34yG3SK7rV9VU1CQg
         upCu56ptZ1NIPSkA/T6e59+d4MncnRwehUuJte49KEZ52d4qzqXy3s8S4MYecP9wuOcJ
         +XhmjJkX+4ep/B3/oMz+T6wM3e28TZMc9sYt416B35pqjAl3C7deo2kmHnwLS1pg7DIa
         kZo8k80oH6dGICRfRu6CUk7eROrtw+cqX2uiYdQUWOFAVYzqtxY0l36nFftLEOdIY7AN
         0lDhuda2Eoq0VAFss9H9J/YBsKphHkOr3QgzIKt7o7YEkxrWRjnlGKJgXWOayfbnxV+U
         H35w==
X-Gm-Message-State: APjAAAUSWc2S/ry9wZWsc7BHdSW3RLWPdx9PXAcO87ms4tiIQui9mGqM
        GlWyhmdcqWGCFZEr9zhKGq2Gdg==
X-Google-Smtp-Source: APXvYqxV8kLoiIfvFPWs1hfpmpHW1w0flIc6wNZrkN6f+Pp5TJ+/risDOoRV3cW/8Qk9qeZkhoUPpQ==
X-Received: by 2002:a24:64d7:: with SMTP id t206mr6889153itc.89.1555109146622;
        Fri, 12 Apr 2019 15:45:46 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id l68sm4674059itb.29.2019.04.12.15.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:45:46 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, bartfab@chromium.org, lamzin@google.com,
        jchwong@google.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Add telemetry data char device interface
Date:   Fri, 12 Apr 2019 16:45:39 -0600
Message-Id: <20190412224539.161321-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wilco Embedded Controller is able to send telemetry data
which is useful for enterprise applications. A daemon running on
the OS sends a command to the EC via write() to char device,
and can read the response with a read() request.
Both the request and the response are in an opaque
binary format so that information which is proprietary to the
enterprise service provider is secure.

The character device will appear as /dev/wilco_telemN, where N is some
small non-negative integer, starting with 0. Only one process may have
the file descriptor open at a time. The calling userspace program needs
to keep the device file descriptor open between the calls to write() and
read() in order to preserve the response. Either 32 or 256 bytes of data
are expected for arguments, and the same number of bytes will be
returned.

For testing purposes, if the EC receives a byte sequence beginning with
0, it will return an inverted copy of the input sequence. For an
example, run the simple python script from
https://gist.github.com/52ab07c8519b56c0ec671d3338760516

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Kconfig     |   7 +
 drivers/platform/chrome/wilco_ec/Makefile    |   2 +
 drivers/platform/chrome/wilco_ec/core.c      |  13 +
 drivers/platform/chrome/wilco_ec/telemetry.c | 312 +++++++++++++++++++
 include/linux/platform_data/wilco-ec.h       |   2 +
 5 files changed, 336 insertions(+)
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index e09e4cebe9b4..7846f6146b78 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -18,3 +18,10 @@ config WILCO_EC_DEBUGFS
 	  manipulation and allow for testing arbitrary commands.  This
 	  interface is intended for debug only and will not be present
 	  on production devices.
+
+config WILCO_EC_TELEMETRY
+	tristate "Enable querying telemetry data from EC"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support to query opaque binary
+	  telemetrydata from /dev/wilco_telem using write() and then read().
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..b4aa6d26a3df 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_ec_telem-objs			:= telemetry.o
+obj-$(CONFIG_WILCO_EC_TELEMETRY)	+= wilco_ec_telem.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..517d9627fecc 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device that will be found by the telemetry driver. */
+	ec->telem_pdev = platform_device_register_data(dev, "wilco_telem",
+						       PLATFORM_DEVID_AUTO,
+						       NULL, 0);
+	if (IS_ERR(ec->telem_pdev)) {
+		dev_err(dev, "Failed to create telemetry platform device\n");
+		ret = PTR_ERR(ec->telem_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +114,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->telem_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
new file mode 100644
index 000000000000..6b3dc84bd0f2
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Telemetry communication for Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * The Wilco Embedded Controller is able to send telemetry data
+ * which is useful for enterprise applications. A daemon running on
+ * the OS sends a command to the EC via a write() to a char device, and
+ * can read the response with a read() request. Both the request
+ * and the response are in an opaque binary format so that information
+ * which is proprietary to the enterprise service provider is secure.
+ *
+ * The character device will appear as /dev/wilco_telemN, where N is some
+ * small non-negative integer, starting with 0. Only one process may have
+ * the file descriptor open at a time. The calling userspace program needs
+ * to keep the device file descriptor open between the calls to write() and
+ * read() in order to preserve the response. Either 32 or 256 bytes of data
+ * are expected for arguments, and the same number of bytes will be
+ * returned.
+ *
+ * For testing purposes, if the EC receives a byte sequence beginning with
+ * 0, it will return an inverted copy of the input sequence. For an
+ * example, run the simple python script from
+ * https://gist.github.com/52ab07c8519b56c0ec671d3338760516
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define TELEM_DEV_NAME		"wilco_telem"
+#define TELEM_CLASS_NAME	TELEM_DEV_NAME
+#define DRV_NAME		TELEM_DEV_NAME
+#define TELEM_DEV_NAME_FMT	(TELEM_DEV_NAME "%d")
+static struct class telem_class = {
+	.owner	= THIS_MODULE,
+	.name	= TELEM_CLASS_NAME,
+};
+
+/* Keep track of all the device numbers used. */
+#define TELEM_MAX_DEV 128
+static int telem_major;
+static DEFINE_IDA(telem_ida);
+
+/**
+ * struct telem_device_data - Data for a Wilco EC device that queries telemetry.
+ * @cdev: Char dev that userspace reads and polls from.
+ * @dev: Device associated with the %cdev.
+ * @ec: Wilco EC that we will be communicating with using the mailbox interface.
+ * @available: Boolean of if the device can be opened.
+ */
+struct telem_device_data {
+	struct device dev;
+	struct cdev cdev;
+	struct wilco_ec_device *ec;
+	atomic_t available;
+};
+
+/**
+ * struct telem_session_data - Data that exists between open() and release().
+ * @dev_data: Pointer to get back to the device data and EC.
+ * @request: Argument buffer of opaque binary data sent to EC.
+ * @response: Response buffer of opaque binary data from EC.
+ * @msg_size: Number of bytes in request and response.
+ * @has_msg: Is there data available to read from a previous write?
+ */
+struct telem_session_data {
+	struct telem_device_data *dev_data;
+	u8 request[EC_MAILBOX_DATA_SIZE_EXTENDED];
+	u8 response[EC_MAILBOX_DATA_SIZE_EXTENDED];
+	int msg_size;
+	bool has_msg;
+};
+
+/**
+ * telem_open() - Callback for when the device node is opened.
+ * @inode: inode for this char device node.
+ * @filp: file for this char device node.
+ *
+ * We need to ensure that after writing a command to the device,
+ * the same userspace process reads the corresponding result.
+ * Therefore, we increment a refcount on opening the device, so that
+ * only one process can communicate with the EC at a time.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int telem_open(struct inode *inode, struct file *filp)
+{
+	struct telem_device_data *dev_data;
+	struct telem_session_data *sess_data;
+
+	/* Ensure device isn't already open */
+	dev_data = container_of(inode->i_cdev, struct telem_device_data, cdev);
+	if (atomic_cmpxchg(&dev_data->available, 1, 0) == 0)
+		return -EBUSY;
+
+	sess_data = kzalloc(sizeof(*sess_data), GFP_KERNEL);
+	if (!sess_data) {
+		atomic_set(&dev_data->available, 1);
+		return -ENOMEM;
+	}
+	sess_data->dev_data = dev_data;
+	sess_data->has_msg = false;
+
+	nonseekable_open(inode, filp);
+	filp->private_data = sess_data;
+
+	return 0;
+}
+
+static ssize_t telem_write(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *pos)
+{
+	struct telem_session_data *sess_data = filp->private_data;
+	struct wilco_ec_message msg;
+	int ret;
+
+	if (count != EC_MAILBOX_DATA_SIZE &&
+	    count != EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EINVAL;
+	sess_data->msg_size = count;
+
+	if (copy_from_user(sess_data->request, buf, count))
+		return -EFAULT;
+
+	if (sess_data->msg_size == EC_MAILBOX_DATA_SIZE) {
+		msg.type = WILCO_EC_MSG_TELEMETRY_SHORT;
+		msg.flags = 0;
+	} else {
+		msg.type = WILCO_EC_MSG_TELEMETRY_LONG;
+		msg.flags = WILCO_EC_FLAG_EXTENDED_DATA;
+	}
+	msg.request_data = sess_data->request;
+	msg.request_size = sess_data->msg_size;
+	msg.response_data = sess_data->response;
+	msg.response_size = sess_data->msg_size;
+
+	ret = wilco_ec_mailbox(sess_data->dev_data->ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (ret != sess_data->msg_size)
+		return -EMSGSIZE;
+
+	sess_data->has_msg = true;
+
+	return count;
+}
+
+static ssize_t telem_read(struct file *filp, char __user *buf, size_t count,
+			  loff_t *pos)
+{
+	struct telem_session_data *sess_data = filp->private_data;
+
+	if (!sess_data->has_msg)
+		return -ENODATA;
+	if (count != sess_data->msg_size)
+		return -EINVAL;
+
+	if (copy_to_user(buf, sess_data->response, sess_data->msg_size))
+		return -EFAULT;
+
+	sess_data->has_msg = false;
+
+	return sess_data->msg_size;
+}
+
+static int telem_release(struct inode *inode, struct file *filp)
+{
+	struct telem_session_data *sess_data = filp->private_data;
+
+	atomic_set(&sess_data->dev_data->available, 1);
+	kfree(sess_data);
+
+	return 0;
+}
+
+static const struct file_operations telem_fops = {
+	.open = telem_open,
+	.write = telem_write,
+	.read = telem_read,
+	.release = telem_release,
+	.llseek = no_llseek,
+	.owner = THIS_MODULE,
+};
+
+/**
+ * telem_device_probe() - Callback when creating a new device.
+ * @pdev: platform device that we will be receiving telems from.
+ *
+ * This finds a free minor number for the device, allocates and initializes
+ * some device data, and creates a new device and char dev node.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int telem_device_probe(struct platform_device *pdev)
+{
+	struct telem_device_data *dev_data;
+	dev_t dev_num;
+	int error, minor;
+
+	/* Get the next available device number */
+	minor = ida_alloc_max(&telem_ida, TELEM_MAX_DEV-1, GFP_KERNEL);
+	if (minor < 0) {
+		error = minor;
+		dev_err(&pdev->dev, "Failed to find minor number: %d", error);
+		return error;
+	}
+
+	dev_data = devm_kzalloc(&pdev->dev, sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data) {
+		ida_simple_remove(&telem_ida, minor);
+		return -ENOMEM;
+	}
+
+	/* Initialize the device data */
+	dev_data->ec = dev_get_drvdata(pdev->dev.parent);
+	atomic_set(&dev_data->available, 1);
+	platform_set_drvdata(pdev, dev_data);
+
+	/* Initialize the device */
+	dev_num = MKDEV(telem_major, minor);
+	dev_data->dev.devt = dev_num;
+	dev_data->dev.class = &telem_class;
+	dev_set_name(&dev_data->dev, TELEM_DEV_NAME_FMT, minor);
+	device_initialize(&dev_data->dev);
+
+	/* Initialize the character device and add it to userspace */;
+	cdev_init(&dev_data->cdev, &telem_fops);
+	error = cdev_device_add(&dev_data->cdev, &dev_data->dev);
+	if (error) {
+		ida_simple_remove(&telem_ida, minor);
+		return error;
+	}
+
+	return 0;
+}
+
+static int telem_device_remove(struct platform_device *pdev)
+{
+	struct telem_device_data *dev_data = platform_get_drvdata(pdev);
+
+	cdev_device_del(&dev_data->cdev, &dev_data->dev);
+	ida_simple_remove(&telem_ida, MINOR(dev_data->dev.devt));
+
+	return 0;
+}
+
+static struct platform_driver telem_driver = {
+	.probe = telem_device_probe,
+	.remove = telem_device_remove,
+	.driver = {
+		.name = DRV_NAME,
+	},
+};
+
+static int __init telem_module_init(void)
+{
+	dev_t dev_num = 0;
+	int ret;
+
+	ret = class_register(&telem_class);
+	if (ret) {
+		pr_warn(DRV_NAME ": Failed registering class: %d", ret);
+		return ret;
+	}
+
+	/* Request the kernel for device numbers, starting with minor=0 */
+	ret = alloc_chrdev_region(&dev_num, 0, TELEM_MAX_DEV, TELEM_DEV_NAME);
+	if (ret) {
+		pr_warn(DRV_NAME ": Failed allocating dev numbers: %d", ret);
+		goto destroy_class;
+	}
+	telem_major = MAJOR(dev_num);
+
+	ret = platform_driver_register(&telem_driver);
+	if (ret < 0) {
+		pr_warn(DRV_NAME ": Failed registering driver: %d\n", ret);
+		goto unregister_region;
+	}
+
+	return 0;
+
+unregister_region:
+	unregister_chrdev_region(MKDEV(telem_major, 0), TELEM_MAX_DEV);
+destroy_class:
+	class_unregister(&telem_class);
+	ida_destroy(&telem_ida);
+	return ret;
+}
+
+static void __exit telem_module_exit(void)
+{
+	platform_driver_unregister(&telem_driver);
+	unregister_chrdev_region(MKDEV(telem_major, 0), TELEM_MAX_DEV);
+	class_unregister(&telem_class);
+	ida_destroy(&telem_ida);
+}
+
+module_init(telem_module_init);
+module_exit(telem_module_exit);
+
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_DESCRIPTION("Wilco EC telemetry driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..ec0f9c06be01 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @telem_pdev: The child platform_device used by the telemetry sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *telem_pdev;
 };
 
 /**
-- 
2.20.1

