Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405121479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfEHIEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:04:30 -0400
Received: from HC210-202-87-179.vdslpro.static.apol.com.tw ([210.202.87.179]:37363
        "EHLO ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726428AbfEHIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:04:29 -0400
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 08 May 2019 15:55:05 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id x487sx1P075750;
        Wed, 8 May 2019 15:54:59 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 8 May 2019 15:55:00 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] drm/bridge: it6505 driver add char device feature.
Date:   Wed, 8 May 2019 15:48:42 +0800
Message-ID: <1557301722-20827-4-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557301722-20827-1-git-send-email-allen.chen@ite.com.tw>
References: <1557301722-20827-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw x487sx1P075750
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Chen <allen.chen@ite.com.tw>

This add can let us find it6505 char device in the /dev file and use read/write function to let the driver be hold.

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>

---
 drivers/gpu/drm/bridge/ite-it6505.c | 131 ++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 13079a8..1529e61 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -70,6 +70,13 @@
 /* if use this define will enable SHA debug */
 /* #define SHA_DEBUG */
 
+/* register char device for it6505 */
+#define IT6505_CLASS_NAME "it6505_class"
+#define IT6505_DEVICE_NAME "it6505_device"
+#define IT6505_MAX_DEV 128
+/* The device major number */
+static int it6505_major_num;
+
 enum sys_status {
 	SYS_UNPLUG = 0,
 	SYS_HPD,
@@ -144,6 +151,8 @@ struct it6505 {
 	struct it6505_platform_data pdata;
 	struct mutex lock;
 	struct regmap *regmap;
+	struct cdev cdev;
+	struct device class_dev;
 	struct it6505_dp_port *port;
 	/* thread sequence control */
 	struct semaphore sem_notifier;
@@ -2502,6 +2511,80 @@ static int it6505_init_pdata(struct it6505 *it6505)
 	return PTR_ERR_OR_ZERO(pdata->gpiod_reset);
 }
 
+static int it6505_open(struct inode *inode, struct file *file)
+{
+	struct it6505 *ctx = container_of(inode->i_cdev, struct it6505, cdev);
+
+	DRM_DEBUG_DRIVER("[%s]: successful", __func__);
+	if (!ctx)
+		DRM_DEBUG_DRIVER("[%s]:get it6505 struct fail!", __func__);
+	file->private_data = ctx;
+	get_device(&ctx->class_dev);
+	return 0;
+}
+
+static int it6505_release(struct inode *inode, struct file *file)
+{
+	struct it6505 *ctx = file->private_data;
+
+	DRM_DEBUG_DRIVER("[%s]: successful", __func__);
+	put_device(&ctx->class_dev);
+	return 0;
+}
+
+static ssize_t it6505_read(struct file *file, char *buf,
+			   size_t count, loff_t *ptr)
+{
+	struct it6505 *ctx = file->private_data;
+	char kbuff[16];
+	size_t len;
+
+	DRM_DEBUG_DRIVER("[%s]start count=%zu", __func__, count);
+	DRM_DEBUG_DRIVER("it6505_drv_hold:%d", ctx->it6505_drv_hold);
+	len = snprintf(kbuff, sizeof(kbuff), "%d", ctx->it6505_drv_hold);
+	len = min3(count, len, sizeof(kbuff));
+	return copy_to_user(buf, kbuff, len) ? -EFAULT : len;
+}
+
+static ssize_t it6505_write(struct file *file, const char *buff,
+			    size_t count, loff_t *ptr)
+{
+	struct it6505 *ctx = file->private_data;
+	char kbuff[16];
+	int num;
+
+	DRM_DEBUG_DRIVER("[%s]start count=%zu", __func__, count);
+	count = min(count, sizeof(kbuff) - 1);
+	if (copy_from_user(kbuff, buff, count))
+		return -EFAULT;
+	kbuff[count] = '\0';
+	if (kstrtoint(kbuff, 10, &num) < 0)
+		return -EINVAL;
+	ctx->it6505_drv_hold = num;
+	DRM_DEBUG_DRIVER("set it6505_drv_hold:%d", ctx->it6505_drv_hold);
+	return count;
+}
+
+static struct class it6505_class_file = {
+	.owner          = THIS_MODULE,
+	.name           = IT6505_CLASS_NAME,
+};
+
+static const struct file_operations it6505_fops = {
+	.owner = THIS_MODULE,
+	.read  = it6505_read,
+	.write = it6505_write,
+	.open  = it6505_open,
+	.release = it6505_release
+};
+
+static void it6505_release_device(struct device *dev)
+{
+	struct it6505 *ctx = container_of(dev, struct it6505, class_dev);
+
+	kfree(ctx);
+}
+
 static int it6505_i2c_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -2575,8 +2658,38 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	ctx->bridge.funcs = &it6505_bridge_funcs;
 
 	drm_bridge_add(&ctx->bridge);
+	device_initialize(&ctx->class_dev);
+	ctx->class_dev.parent = &client->dev;
+	ctx->class_dev.release = it6505_release_device;
+	cdev_init(&ctx->cdev, &it6505_fops);
+	err = dev_set_name(&ctx->class_dev, "%s", IT6505_DEVICE_NAME);
+	DRM_DEBUG_DRIVER("[%s] dev_set_name:%s",
+			 __func__, err ? "failed" : "success");
+	if (err) {
+		DRM_DEBUG_DRIVER("dev_set_name failed => %d", err);
+		goto put_class_dev;
+	}
+	/*
+	 * Add the class device
+	 * Link to the character device for creating the /dev entry
+	 * in devtmpfs.
+	 */
+	ctx->class_dev.devt = MKDEV(it6505_major_num, 0);
+	ctx->class_dev.class = &it6505_class_file;
+
+	/* We can now add the sysfs class, we know which parameter to show */
+	err = cdev_device_add(&ctx->cdev, &ctx->class_dev);
+	if (err) {
+		DRM_DEBUG_DRIVER("cdev_device_add failed => %d",
+				 err);
+		goto put_class_dev;
+	}
 	DRM_DEBUG_DRIVER("[%s]end", __func__);
 	return 0;
+
+put_class_dev:
+	put_device(&ctx->class_dev);
+	return err;
 }
 
 static int it6505_remove(struct i2c_client *client)
@@ -2616,16 +2729,34 @@ struct i2c_driver it6505_i2c_driver = {
 
 static int __init it6505_init(void)
 {
+	int err;
+	dev_t dev = 0;
+
 	DRM_DEBUG_DRIVER("[%s]start", __func__);
+	/* Register the device class */
+	err = class_register(&it6505_class_file);
+	err = alloc_chrdev_region(&dev, 0, IT6505_MAX_DEV,
+			IT6505_DEVICE_NAME);
+	it6505_major_num = MAJOR(dev);
+	if (err < 0) {
+		DRM_DEBUG_DRIVER("alloc_chrdev_region() fail!");
+		goto failed_chrdevreg;
+	}
 	i2c_add_driver(&it6505_i2c_driver);
 	DRM_DEBUG_DRIVER("[%s]end", __func__);
 	return 0;
+
+failed_chrdevreg:
+	class_unregister(&it6505_class_file);
+	return err;
 }
 
 static void __exit it6505_exit(void)
 {
 	DRM_DEBUG_DRIVER("[%s]start", __func__);
 	i2c_del_driver(&it6505_i2c_driver);
+	unregister_chrdev(it6505_major_num, IT6505_DEVICE_NAME);
+	class_unregister(&it6505_class_file);
 	DRM_DEBUG_DRIVER("[%s]end", __func__);
 }
 
-- 
1.9.1

