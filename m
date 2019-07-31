Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F75FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1B82089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfGaMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:48:34 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:56044 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:48:33 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id jQoX2000p05gfCL01QoXNu; Wed, 31 Jul 2019 14:48:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso1v-0000WE-JM; Wed, 31 Jul 2019 14:48:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hso1v-0003oQ-H8; Wed, 31 Jul 2019 14:48:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: core: Use DEVICE_ATTR_RW() helper macros
Date:   Wed, 31 Jul 2019 14:48:30 +0200
Message-Id: <20190731124830.14613-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i2c core sysfs attributes from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.
This requires renaming some functions.

Although no suitable macro exists for the delete_device attribute,
rename i2c_sysfs_delete_device() to delete_device_store() for
consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/i2c-core-base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f26ed495d38420b3..f66cfdf4d0e6b1d6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -451,15 +451,15 @@ static void i2c_client_dev_release(struct device *dev)
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
@@ -474,7 +474,7 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
-static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
+static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *i2c_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -1041,8 +1041,8 @@ EXPORT_SYMBOL_GPL(i2c_adapter_depth);
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
@@ -1097,7 +1097,7 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
+static DEVICE_ATTR_WO(new_device);
 
 /*
  * And of course let the users delete the devices they instantiated, if
@@ -1109,8 +1109,8 @@ static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
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
@@ -1153,7 +1153,7 @@ i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
 	return res;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, S_IWUSR, NULL,
-				   i2c_sysfs_delete_device);
+				  delete_device_store);
 
 static struct attribute *i2c_adapter_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.17.1

