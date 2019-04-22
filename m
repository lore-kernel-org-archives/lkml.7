Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B6C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C00420857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfDVG74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:59:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:2555 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVG7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:59:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 23:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,380,1549958400"; 
   d="scan'208";a="225548203"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2019 23:59:51 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: expose device state in sysfs
Date:   Mon, 22 Apr 2019 09:51:07 +0300
Message-Id: <20190422065107.32050-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422065107.32050-1-tomas.winkler@intel.com>
References: <20190422065107.32050-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Expose mei device state to user-space through sysfs.
This gives indication to applications that driver is in transition,
usefully mostly to detect link reset state.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-class-mei | 15 ++++++
 drivers/misc/mei/client.c                 |  2 +-
 drivers/misc/mei/init.c                   | 20 +++----
 drivers/misc/mei/main.c                   | 65 ++++++++++++++++++++---
 drivers/misc/mei/mei_dev.h                |  3 +-
 5 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index 17d7444a2397..a92d844f806e 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -65,3 +65,18 @@ Description:	Display the ME firmware version.
 		<platform>:<major>.<minor>.<milestone>.<build_no>.
 		There can be up to three such blocks for different
 		FW components.
+
+What:		/sys/class/mei/meiN/dev_state
+Date:		Mar 2019
+KernelVersion:	5.1
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Display the ME device state.
+
+		The device state can have following values:
+		INITIALIZING
+		INIT_CLIENTS
+		ENABLED
+		RESETTING
+		DISABLED
+		POWER_DOWN
+		POWER_UP
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 88b83c4bc5b7..1e3edbbacb1e 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -669,7 +669,7 @@ int mei_cl_unlink(struct mei_cl *cl)
 
 void mei_host_client_init(struct mei_device *dev)
 {
-	dev->dev_state = MEI_DEV_ENABLED;
+	mei_set_devstate(dev, MEI_DEV_ENABLED);
 	dev->reset_count = 0;
 
 	schedule_work(&dev->bus_rescan_work);
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index cc359ae968ce..b9fef773e71b 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -123,12 +123,12 @@ int mei_reset(struct mei_device *dev)
 
 	/* enter reset flow */
 	interrupts_enabled = state != MEI_DEV_POWER_DOWN;
-	dev->dev_state = MEI_DEV_RESETTING;
+	mei_set_devstate(dev, MEI_DEV_RESETTING);
 
 	dev->reset_count++;
 	if (dev->reset_count > MEI_MAX_CONSEC_RESET) {
 		dev_err(dev->dev, "reset: reached maximal consecutive resets: disabling the device\n");
-		dev->dev_state = MEI_DEV_DISABLED;
+		mei_set_devstate(dev, MEI_DEV_DISABLED);
 		return -ENODEV;
 	}
 
@@ -150,7 +150,7 @@ int mei_reset(struct mei_device *dev)
 
 	if (state == MEI_DEV_POWER_DOWN) {
 		dev_dbg(dev->dev, "powering down: end of reset\n");
-		dev->dev_state = MEI_DEV_DISABLED;
+		mei_set_devstate(dev, MEI_DEV_DISABLED);
 		return 0;
 	}
 
@@ -162,11 +162,11 @@ int mei_reset(struct mei_device *dev)
 
 	dev_dbg(dev->dev, "link is established start sending messages.\n");
 
-	dev->dev_state = MEI_DEV_INIT_CLIENTS;
+	mei_set_devstate(dev, MEI_DEV_INIT_CLIENTS);
 	ret = mei_hbm_start_req(dev);
 	if (ret) {
 		dev_err(dev->dev, "hbm_start failed ret = %d\n", ret);
-		dev->dev_state = MEI_DEV_RESETTING;
+		mei_set_devstate(dev, MEI_DEV_RESETTING);
 		return ret;
 	}
 
@@ -196,7 +196,7 @@ int mei_start(struct mei_device *dev)
 
 	dev->reset_count = 0;
 	do {
-		dev->dev_state = MEI_DEV_INITIALIZING;
+		mei_set_devstate(dev, MEI_DEV_INITIALIZING);
 		ret = mei_reset(dev);
 
 		if (ret == -ENODEV || dev->dev_state == MEI_DEV_DISABLED) {
@@ -231,7 +231,7 @@ int mei_start(struct mei_device *dev)
 	return 0;
 err:
 	dev_err(dev->dev, "link layer initialization failed.\n");
-	dev->dev_state = MEI_DEV_DISABLED;
+	mei_set_devstate(dev, MEI_DEV_DISABLED);
 	mutex_unlock(&dev->device_lock);
 	return -ENODEV;
 }
@@ -250,7 +250,7 @@ int mei_restart(struct mei_device *dev)
 
 	mutex_lock(&dev->device_lock);
 
-	dev->dev_state = MEI_DEV_POWER_UP;
+	mei_set_devstate(dev, MEI_DEV_POWER_UP);
 	dev->reset_count = 0;
 
 	err = mei_reset(dev);
@@ -301,7 +301,7 @@ void mei_stop(struct mei_device *dev)
 	dev_dbg(dev->dev, "stopping the device.\n");
 
 	mutex_lock(&dev->device_lock);
-	dev->dev_state = MEI_DEV_POWER_DOWN;
+	mei_set_devstate(dev, MEI_DEV_POWER_DOWN);
 	mutex_unlock(&dev->device_lock);
 	mei_cl_bus_remove_devices(dev);
 
@@ -314,7 +314,7 @@ void mei_stop(struct mei_device *dev)
 
 	mei_reset(dev);
 	/* move device to disabled state unconditionally */
-	dev->dev_state = MEI_DEV_DISABLED;
+	mei_set_devstate(dev, MEI_DEV_DISABLED);
 
 	mutex_unlock(&dev->device_lock);
 }
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index b454df214dde..ad02097d7fee 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -28,6 +28,12 @@
 #include "mei_dev.h"
 #include "client.h"
 
+static struct class *mei_class;
+static dev_t mei_devt;
+#define MEI_MAX_DEVS  MINORMASK
+static DEFINE_MUTEX(mei_minor_lock);
+static DEFINE_IDR(mei_idr);
+
 /**
  * mei_open - the open function
  *
@@ -829,12 +835,65 @@ static ssize_t fw_ver_show(struct device *device,
 }
 static DEVICE_ATTR_RO(fw_ver);
 
+/**
+ * dev_state_show - display device state
+ *
+ * @device: device pointer
+ * @attr: attribute pointer
+ * @buf:  char out buffer
+ *
+ * Return: number of the bytes printed into buf or error
+ */
+static ssize_t dev_state_show(struct device *device,
+			      struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	enum mei_dev_state dev_state;
+
+	mutex_lock(&dev->device_lock);
+	dev_state = dev->dev_state;
+	mutex_unlock(&dev->device_lock);
+
+	return sprintf(buf, "%s", mei_dev_state_str(dev_state));
+}
+static DEVICE_ATTR_RO(dev_state);
+
+static int match_devt(struct device *dev, const void *data)
+{
+	const dev_t *devt = data;
+
+	return dev->devt == *devt;
+}
+
+/**
+ * dev_set_devstate: set to new device state and notify sysfs file.
+ *
+ * @dev: mei_device
+ * @state: new device state
+ */
+void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
+{
+	struct device *clsdev;
+
+	if (dev->dev_state == state)
+		return;
+
+	dev->dev_state = state;
+
+	clsdev = class_find_device(mei_class, NULL, &dev->cdev.dev, match_devt);
+	if (clsdev) {
+		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
+		put_device(clsdev);
+	}
+}
+
 static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_status.attr,
 	&dev_attr_hbm_ver.attr,
 	&dev_attr_hbm_ver_drv.attr,
 	&dev_attr_tx_queue_limit.attr,
 	&dev_attr_fw_ver.attr,
+	&dev_attr_dev_state.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
@@ -858,12 +917,6 @@ static const struct file_operations mei_fops = {
 	.llseek = no_llseek
 };
 
-static struct class *mei_class;
-static dev_t mei_devt;
-#define MEI_MAX_DEVS  MINORMASK
-static DEFINE_MUTEX(mei_minor_lock);
-static DEFINE_IDR(mei_idr);
-
 /**
  * mei_minor_get - obtain next free device minor number
  *
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 3146df37ffb0..fca832fcac57 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -525,7 +525,6 @@ struct mei_device {
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
 
-
 	const struct mei_hw_ops *ops;
 	char hw[0] __aligned(sizeof(void *));
 };
@@ -584,6 +583,8 @@ int mei_restart(struct mei_device *dev);
 void mei_stop(struct mei_device *dev);
 void mei_cancel_work(struct mei_device *dev);
 
+void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state);
+
 int mei_dmam_ring_alloc(struct mei_device *dev);
 void mei_dmam_ring_free(struct mei_device *dev);
 bool mei_dma_ring_is_allocated(struct mei_device *dev);
-- 
2.20.1

