Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C0214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165634;
	bh=+32QTppgj0QPB5BsnaKX6PbZDtgOhoCGdmIOSRxloK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nSGmx6GtPAYQwkXNkjQ5c6QNxywsyoqzpjCL+S1Yie7XrSulgrFmYFnvKmTJ9Lgxr
	 DBwGXdmbPTewlizyKWWOEZ+TjtWXRsKzNHFdTicaIeO+SU7/WA9tCJ+8jyUuXue8DD
	 VCEcecVcSx88qSqoaVM0pZIhnUKmzmocIgGqdrGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfDBAkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDBAka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:40:30 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BD32133D;
        Tue,  2 Apr 2019 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165628;
        bh=+32QTppgj0QPB5BsnaKX6PbZDtgOhoCGdmIOSRxloK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klYoc0BWwQKN4hn5Si4tq5v5TGibrkkIN23Qn/FhF4DmdR3BtLK1cECSHhBGGLxQG
         Dd4nKz+LTqnYoDA5VyM8V78eI9HPofoXViWatZz2kRO74PE6F2JoX9xxNV8IMc6jQQ
         +j5fNIhrEkT8dOgLuXVkaxPNFKvskzkRy7Gg2xZM=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v15 1/6] media: Media Device Allocator API
Date:   Mon,  1 Apr 2019 18:40:19 -0600
Message-Id: <59a53c1529395d365f569e20ca5632c5a1e4b13b.1554155703.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554155701.git.shuah@kernel.org>
References: <cover.1554155701.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Media Device Allocator API to allows multiple drivers share a media device.
This API solves a very common use-case for media devices where one physical
device (an USB stick) provides both audio and video. When such media device
exposes a standard USB Audio class, a proprietary Video class, two or more
independent drivers will share a single physical USB bridge. In such cases,
it is necessary to coordinate access to the shared resource.

Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 Documentation/media/kapi/mc-core.rst |  41 ++++++++
 drivers/media/Makefile               |   6 ++
 drivers/media/media-dev-allocator.c  | 135 +++++++++++++++++++++++++++
 include/media/media-dev-allocator.h  |  63 +++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h

diff --git a/Documentation/media/kapi/mc-core.rst b/Documentation/media/kapi/mc-core.rst
index f930725e0d6b..05bba0b61748 100644
--- a/Documentation/media/kapi/mc-core.rst
+++ b/Documentation/media/kapi/mc-core.rst
@@ -259,6 +259,45 @@ Subsystems should facilitate link validation by providing subsystem specific
 helper functions to provide easy access for commonly needed information, and
 in the end provide a way to use driver-specific callbacks.
 
+Media Controller Device Allocator API
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When the media device belongs to more than one driver, the shared media
+device is allocated with the shared struct device as the key for look ups.
+
+The shared media device should stay in registered state until the last
+driver unregisters it. In addition, the media device should be released when
+all the references are released. Each driver gets a reference to the media
+device during probe, when it allocates the media device. If media device is
+already allocated, the allocate API bumps up the refcount and returns the
+existing media device. The driver puts the reference back in its disconnect
+routine when it calls :c:func:`media_device_delete()`.
+
+The media device is unregistered and cleaned up from the kref put handler to
+ensure that the media device stays in registered state until the last driver
+unregisters the media device.
+
+**Driver Usage**
+
+Drivers should use the appropriate media-core routines to manage the shared
+media device life-time handling the two states:
+1. allocate -> register -> delete
+2. get reference to already registered device -> delete
+
+call :c:func:`media_device_delete()` routine to make sure the shared media
+device delete is handled correctly.
+
+**driver probe:**
+Call :c:func:`media_device_usb_allocate()` to allocate or get a reference
+Call :c:func:`media_device_register()`, if media devnode isn't registered
+
+**driver disconnect:**
+Call :c:func:`media_device_delete()` to free the media_device. Freeing is
+handled by the kref put handler.
+
+API Definitions
+^^^^^^^^^^^^^^^
+
 .. kernel-doc:: include/media/media-device.h
 
 .. kernel-doc:: include/media/media-devnode.h
@@ -266,3 +305,5 @@ in the end provide a way to use driver-specific callbacks.
 .. kernel-doc:: include/media/media-entity.h
 
 .. kernel-doc:: include/media/media-request.h
+
+.. kernel-doc:: include/media/media-dev-allocator.h
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 985d35ec6b29..4a330d0e5e40 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -6,6 +6,12 @@
 media-objs	:= media-device.o media-devnode.o media-entity.o \
 		   media-request.o
 
+ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
+	ifeq ($(CONFIG_USB),y)
+		media-objs += media-dev-allocator.o
+	endif
+endif
+
 #
 # I2C drivers should come before other drivers, otherwise they'll fail
 # when compiled as builtin drivers
diff --git a/drivers/media/media-dev-allocator.c b/drivers/media/media-dev-allocator.c
new file mode 100644
index 000000000000..ae17887dec59
--- /dev/null
+++ b/drivers/media/media-dev-allocator.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * media-dev-allocator.c - Media Controller Device Allocator API
+ *
+ * Copyright (c) 2019 Shuah Khan <shuah@kernel.org>
+ *
+ * Credits: Suggested by Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/*
+ * This file adds a global refcounted Media Controller Device Instance API.
+ * A system wide global media device list is managed and each media device
+ * includes a kref count. The last put on the media device releases the media
+ * device instance.
+ *
+ */
+
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include <media/media-device.h>
+#include <media/media-dev-allocator.h>
+
+static LIST_HEAD(media_device_list);
+static DEFINE_MUTEX(media_device_lock);
+
+struct media_device_instance {
+	struct media_device mdev;
+	struct module *owner;
+	struct list_head list;
+	struct kref refcount;
+};
+
+static inline struct media_device_instance *
+to_media_device_instance(struct media_device *mdev)
+{
+	return container_of(mdev, struct media_device_instance, mdev);
+}
+
+static void media_device_instance_release(struct kref *kref)
+{
+	struct media_device_instance *mdi =
+		container_of(kref, struct media_device_instance, refcount);
+
+	dev_dbg(mdi->mdev.dev, "%s: releasing Media Device\n", __func__);
+
+	mutex_lock(&media_device_lock);
+
+	media_device_unregister(&mdi->mdev);
+	media_device_cleanup(&mdi->mdev);
+
+	list_del(&mdi->list);
+	mutex_unlock(&media_device_lock);
+
+	kfree(mdi);
+}
+
+/* Callers should hold media_device_lock when calling this function */
+static struct media_device *__media_device_get(struct device *dev,
+						const char *module_name,
+						struct module *owner)
+{
+	struct media_device_instance *mdi;
+
+	list_for_each_entry(mdi, &media_device_list, list) {
+		if (mdi->mdev.dev != dev)
+			continue;
+
+		kref_get(&mdi->refcount);
+
+		/* get module reference for the media_device owner */
+		if (owner != mdi->owner && !try_module_get(mdi->owner))
+			dev_err(dev,
+				"%s: module %s get owner reference error\n",
+					__func__, module_name);
+		else
+			dev_dbg(dev, "%s: module %s got owner reference\n",
+					__func__, module_name);
+		return &mdi->mdev;
+	}
+
+	mdi = kzalloc(sizeof(*mdi), GFP_KERNEL);
+	if (!mdi)
+		return NULL;
+
+	mdi->owner = owner;
+	kref_init(&mdi->refcount);
+	list_add_tail(&mdi->list, &media_device_list);
+
+	dev_dbg(dev, "%s: Allocated media device for owner %s\n",
+			__func__, module_name);
+	return &mdi->mdev;
+}
+
+struct media_device *media_device_usb_allocate(struct usb_device *udev,
+					       const char *module_name,
+					       struct module *owner)
+{
+	struct media_device *mdev;
+
+	mutex_lock(&media_device_lock);
+	mdev = __media_device_get(&udev->dev, module_name, owner);
+	if (!mdev) {
+		mutex_unlock(&media_device_lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* check if media device is already initialized */
+	if (!mdev->dev)
+		__media_device_usb_init(mdev, udev, udev->product,
+					module_name);
+	mutex_unlock(&media_device_lock);
+	return mdev;
+}
+EXPORT_SYMBOL_GPL(media_device_usb_allocate);
+
+void media_device_delete(struct media_device *mdev, const char *module_name,
+			 struct module *owner)
+{
+	struct media_device_instance *mdi = to_media_device_instance(mdev);
+
+	mutex_lock(&media_device_lock);
+	/* put module reference for the media_device owner */
+	if (mdi->owner != owner) {
+		module_put(mdi->owner);
+		dev_dbg(mdi->mdev.dev,
+			"%s: module %s put owner module reference\n",
+			__func__, module_name);
+	}
+	mutex_unlock(&media_device_lock);
+	kref_put(&mdi->refcount, media_device_instance_release);
+}
+EXPORT_SYMBOL_GPL(media_device_delete);
diff --git a/include/media/media-dev-allocator.h b/include/media/media-dev-allocator.h
new file mode 100644
index 000000000000..b35ea6062596
--- /dev/null
+++ b/include/media/media-dev-allocator.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * media-dev-allocator.h - Media Controller Device Allocator API
+ *
+ * Copyright (c) 2019 Shuah Khan <shuah@kernel.org>
+ *
+ * Credits: Suggested by Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/*
+ * This file adds a global ref-counted Media Controller Device Instance API.
+ * A system wide global media device list is managed and each media device
+ * includes a kref count. The last put on the media device releases the media
+ * device instance.
+ */
+
+#ifndef _MEDIA_DEV_ALLOCATOR_H
+#define _MEDIA_DEV_ALLOCATOR_H
+
+struct usb_device;
+
+#if defined(CONFIG_MEDIA_CONTROLLER) && defined(CONFIG_USB)
+/**
+ * media_device_usb_allocate() - Allocate and return struct &media device
+ *
+ * @udev:		struct &usb_device pointer
+ * @module_name:	should be filled with %KBUILD_MODNAME
+ * @owner:		struct module pointer %THIS_MODULE for the driver.
+ *			%THIS_MODULE is null for a built-in driver.
+ *			It is safe even when %THIS_MODULE is null.
+ *
+ * This interface should be called to allocate a Media Device when multiple
+ * drivers share usb_device and the media device. This interface allocates
+ * &media_device structure and calls media_device_usb_init() to initialize
+ * it.
+ *
+ */
+struct media_device *media_device_usb_allocate(struct usb_device *udev,
+					       const char *module_name,
+					       struct module *owner);
+/**
+ * media_device_delete() - Release media device. Calls kref_put().
+ *
+ * @mdev:		struct &media_device pointer
+ * @module_name:	should be filled with %KBUILD_MODNAME
+ * @owner:		struct module pointer %THIS_MODULE for the driver.
+ *			%THIS_MODULE is null for a built-in driver.
+ *			It is safe even when %THIS_MODULE is null.
+ *
+ * This interface should be called to put Media Device Instance kref.
+ */
+void media_device_delete(struct media_device *mdev, const char *module_name,
+			 struct module *owner);
+#else
+static inline struct media_device *media_device_usb_allocate(
+			struct usb_device *udev, const char *module_name,
+			struct module *owner)
+			{ return NULL; }
+static inline void media_device_delete(
+			struct media_device *mdev, const char *module_name,
+			struct module *owner) { }
+#endif /* CONFIG_MEDIA_CONTROLLER && CONFIG_USB */
+#endif /* _MEDIA_DEV_ALLOCATOR_H */
-- 
2.17.1

