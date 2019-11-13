Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40476C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C81222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfKMPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:23:11 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:48016 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKMPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:23:10 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id RTP72100K5USYZQ01TP7FR; Wed, 13 Nov 2019 16:23:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iUuU7-00066b-Jn; Wed, 13 Nov 2019 16:23:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iUuU7-0003e5-HW; Wed, 13 Nov 2019 16:23:07 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] i2c: core: Use DEVICE_ATTR_*() helper macros
Date:   Wed, 13 Nov 2019 16:23:06 +0100
Message-Id: <20191113152306.13968-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i2c core sysfs attributes from DEVICE_ATTR() to
DEVICE_ATTR_*(), to reduce boilerplate.
This requires renaming some functions.

Although no suitable macro exists for the delete_device attribute,
rename i2c_sysfs_delete_device() to delete_device_store() for
consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
---
v2:
  - s/DEVICE_ATTR_RW/DEVICE_ATTR_*/ in summary and description,
  - Add Reviewed-by.
---
 drivers/i2c/i2c-core-base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 6a5183cffdfc3e82..c87bf5bcab3f1349 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -449,15 +449,15 @@ static void i2c_client_dev_release(struct device *dev)
 }
 
 static ssize_t
-show_name(struct device *dev, struct device_attribute *attr, char *buf)
+name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", dev->type == &i2c_client_type ?
 		       to_i2c_client(dev)->name : to_i2c_adapter(dev)->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);
 
 static ssize_t
-show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
+modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int len;
@@ -472,7 +472,7 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
-static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
+static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *i2c_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -1039,8 +1039,8 @@ EXPORT_SYMBOL_GPL(i2c_adapter_depth);
  * the user to provide incorrect parameters.
  */
 static ssize_t
-i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
-		     const char *buf, size_t count)
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	struct i2c_board_info info;
@@ -1095,7 +1095,7 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
+static DEVICE_ATTR_WO(new_device);
 
 /*
  * And of course let the users delete the devices they instantiated, if
@@ -1107,8 +1107,8 @@ static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
  * the user to delete the wrong device.
  */
 static ssize_t
-i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	struct i2c_client *client, *next;
@@ -1151,7 +1151,7 @@ i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
 	return res;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, S_IWUSR, NULL,
-				   i2c_sysfs_delete_device);
+				  delete_device_store);
 
 static struct attribute *i2c_adapter_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.17.1

