Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7EC31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317322184E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFNRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfFNRzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE08E106F;
        Fri, 14 Jun 2019 10:55:14 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D03763F718;
        Fri, 14 Jun 2019 10:55:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 15/28] drivers: Introduce class_find_device_by_devt() helper
Date:   Fri, 14 Jun 2019 18:54:10 +0100
Message-Id: <1560534863-15115-16-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to class_find_device() to search for a device
by the device type, reusing the generic match function. Also
convert the existing users.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c              |  9 +--------
 drivers/misc/mei/main.c          |  9 +--------
 drivers/s390/crypto/zcrypt_api.c | 11 +----------
 drivers/tty/tty_io.c             |  8 +-------
 include/linux/device.h           | 12 ++++++++++++
 5 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 053ee2e..e9746cf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2839,13 +2839,6 @@ struct device *device_create_with_groups(struct class *class,
 }
 EXPORT_SYMBOL_GPL(device_create_with_groups);
 
-static int __match_devt(struct device *dev, const void *data)
-{
-	const dev_t *devt = data;
-
-	return dev->devt == *devt;
-}
-
 /**
  * device_destroy - removes a device that was created with device_create()
  * @class: pointer to the struct class that this device was registered with
@@ -2858,7 +2851,7 @@ void device_destroy(struct class *class, dev_t devt)
 {
 	struct device *dev;
 
-	dev = class_find_device(class, NULL, &devt, __match_devt);
+	dev = class_find_device_by_devt(class, devt);
 	if (dev) {
 		put_device(dev);
 		device_unregister(dev);
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index ad02097..572502a 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -858,13 +858,6 @@ static ssize_t dev_state_show(struct device *device,
 }
 static DEVICE_ATTR_RO(dev_state);
 
-static int match_devt(struct device *dev, const void *data)
-{
-	const dev_t *devt = data;
-
-	return dev->devt == *devt;
-}
-
 /**
  * dev_set_devstate: set to new device state and notify sysfs file.
  *
@@ -880,7 +873,7 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 
 	dev->dev_state = state;
 
-	clsdev = class_find_device(mei_class, NULL, &dev->cdev.dev, match_devt);
+	clsdev = class_find_device_by_devt(mei_class, dev->cdev.dev);
 	if (clsdev) {
 		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
 		put_device(clsdev);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 38a5a47..150f623 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -133,12 +133,6 @@ struct zcdn_device {
 static int zcdn_create(const char *name);
 static int zcdn_destroy(const char *name);
 
-/* helper function, matches the devt value for find_zcdndev_by_devt() */
-static int __match_zcdn_devt(struct device *dev, const void *data)
-{
-	return dev->devt == *((dev_t *) data);
-}
-
 /*
  * Find zcdn device by name.
  * Returns reference to the zcdn device which needs to be released
@@ -158,10 +152,7 @@ static inline struct zcdn_device *find_zcdndev_by_name(const char *name)
  */
 static inline struct zcdn_device *find_zcdndev_by_devt(dev_t devt)
 {
-	struct device *dev =
-		class_find_device(zcrypt_class, NULL,
-				  (void *) &devt,
-				  __match_zcdn_devt);
+	struct device *dev = class_find_device_by_devt(zcrypt_class, devt);
 
 	return dev ? to_zcdn_dev(dev) : NULL;
 }
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 033ac7e..202f640 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2950,17 +2950,11 @@ void do_SAK(struct tty_struct *tty)
 
 EXPORT_SYMBOL(do_SAK);
 
-static int dev_match_devt(struct device *dev, const void *data)
-{
-	const dev_t *devt = data;
-	return dev->devt == *devt;
-}
-
 /* Must put_device() after it's unused! */
 static struct device *tty_get_device(struct tty_struct *tty)
 {
 	dev_t devt = tty_devnum(tty);
-	return class_find_device(tty_class, NULL, &devt, dev_match_devt);
+	return class_find_device_by_devt(tty_class, devt);
 }
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 52ac911..2effcc2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -522,6 +522,18 @@ class_find_device_by_fwnode(struct class *class,
 	return class_find_device(class, NULL, fwnode, device_match_fwnode);
 }
 
+/**
+ * class_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @class: class type
+ * @devt: device type of the device to match.
+ */
+static inline struct device *class_find_device_by_devt(struct class *class,
+						       dev_t devt)
+{
+	return class_find_device(class, NULL, &devt, device_match_devt);
+}
+
 struct class_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct class *class, struct class_attribute *attr,
-- 
2.7.4

