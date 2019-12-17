Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC137C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB15206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfLQVDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:03:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:15620 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfLQVDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:03:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="240560994"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:31 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v5 08/17] soundwire: add initial definitions for sdw_master_device
Date:   Tue, 17 Dec 2019 15:03:05 -0600
Message-Id: <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want an explicit support for the SoundWire Master device, add
the definitions, following the Greybus example of a 'Host Device'.

A parent (such as the Intel audio controller) would use sdw_md_add()
to create the device, passing a driver as a parameter. The
sdw_md_release() would be called when put_device() is invoked by the
parent. We use the shortcut 'md' for 'master device' to avoid very
long function names.

The 'Master Device' driver exposes interfaces for
probe/startup/shutdown/remove and a placeholder for autonomous clock
stop support (when the bus control is handed over to a lower-power
solution, typically in D0ix modes).

Module namespace support is added in a separate patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Makefile         |  2 +-
 drivers/soundwire/bus_type.c       |  5 ++-
 drivers/soundwire/master.c         | 63 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h      | 38 ++++++++++++++++++
 include/linux/soundwire/sdw_type.h |  9 +++++
 5 files changed, 115 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soundwire/master.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 563894e5ecaf..89b29819dd3a 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,7 +4,7 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 ifdef CONFIG_DEBUG_FS
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 605bc7ae57a8..2e4e8c2e629f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -66,7 +66,10 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 		 * callback is set to use this function for a
 		 * different device type (e.g. Master or Monitor)
 		 */
-		dev_err(dev, "uevent for unknown Soundwire type\n");
+		if (is_sdw_master_device(dev))
+			dev_err(dev, "uevent for SoundWire Master type\n");
+		else
+			dev_err(dev, "uevent for unknown Soundwire type\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
new file mode 100644
index 000000000000..b018c561708e
--- /dev/null
+++ b/drivers/soundwire/master.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0)
+// Copyright(c) 2019 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include "bus.h"
+
+static void sdw_md_release(struct device *dev)
+{
+	struct sdw_master_device *md = to_sdw_master_device(dev);
+
+	kfree(md);
+}
+
+struct device_type sdw_md_type = {
+	.name =		"soundwire_master",
+	.release =	sdw_md_release,
+};
+
+struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
+				     struct device *parent,
+				     struct fwnode_handle *fwnode,
+				     int link_id)
+{
+	struct sdw_master_device *md;
+	int ret;
+
+	if (!driver->probe) {
+		dev_err(parent, "mandatory probe callback missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return ERR_PTR(-ENOMEM);
+
+	md->link_id = link_id;
+
+	md->driver = driver;
+
+	md->dev.parent = parent;
+	md->dev.fwnode = fwnode;
+	md->dev.bus = &sdw_bus_type;
+	md->dev.type = &sdw_md_type;
+	md->dev.dma_mask = md->dev.parent->dma_mask;
+	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
+
+	ret = device_register(&md->dev);
+	if (ret) {
+		dev_err(parent, "Failed to add master: ret %d\n", ret);
+		/*
+		 * On err, don't free but drop ref as this will be freed
+		 * when release method is invoked.
+		 */
+		put_device(&md->dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return md;
+}
+EXPORT_SYMBOL_GPL(sdw_md_add);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 5b1180f1e6b5..f73c355de5e5 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -585,6 +585,16 @@ struct sdw_slave {
 #define to_sdw_slave_device(d) \
 	container_of(d, struct sdw_slave, dev)
 
+struct sdw_master_device {
+	struct device dev;
+	int link_id;
+	struct sdw_md_driver *driver;
+	void *pdata;
+};
+
+#define to_sdw_master_device(d)	\
+	container_of(d, struct sdw_master_device, dev)
+
 struct sdw_driver {
 	const char *name;
 
@@ -599,6 +609,29 @@ struct sdw_driver {
 	struct device_driver driver;
 };
 
+/**
+ * struct sdw_md_driver - SoundWire 'Master Device' driver
+ *
+ * @probe: initializations and allocation (hardware may not be enabled yet)
+ * @startup: initialization handled after the hardware is enabled, all
+ * clock/power dependencies are available
+ * @shutdown: cleanups before hardware is disabled (optional)
+ * @free: free all remaining resources
+ * @autonomous_clock_stop_enable: enable/disable driver control while
+ * in clock-stop mode, typically in always-on/D0ix modes. When the driver
+ * yields control, another entity in the system (typically firmware
+ * running on an always-on microprocessor) is responsible to tracking
+ * Slave-initiated wakes
+ */
+struct sdw_md_driver {
+	int (*probe)(struct sdw_master_device *md, void *link_ctx);
+	int (*startup)(struct sdw_master_device *md);
+	int (*shutdown)(struct sdw_master_device *md);
+	int (*remove)(struct sdw_master_device *md);
+	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
+					    bool state);
+};
+
 #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
 	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
 	  .driver_data = (unsigned long)(_drv_data) }
@@ -788,6 +821,11 @@ struct sdw_bus {
 int sdw_add_bus_master(struct sdw_bus *bus);
 void sdw_delete_bus_master(struct sdw_bus *bus);
 
+struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
+				     struct device *parent,
+				     struct fwnode_handle *fwnode,
+				     int link_id);
+
 /**
  * sdw_port_config: Master or Slave Port configuration
  *
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index c681b3426478..a2a5ea7843a6 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -6,15 +6,24 @@
 
 extern struct bus_type sdw_bus_type;
 extern struct device_type sdw_slave_type;
+extern struct device_type sdw_md_type;
 
 static inline int is_sdw_slave(const struct device *dev)
 {
 	return dev->type == &sdw_slave_type;
 }
 
+static inline int is_sdw_master_device(const struct device *dev)
+{
+	return dev->type == &sdw_md_type;
+}
+
 #define to_sdw_slave_driver(_drv) \
 	container_of(_drv, struct sdw_driver, driver)
 
+#define to_sdw_md_driver(_drv) \
+	container_of(_drv, struct sdw_md_driver, driver)
+
 #define sdw_register_slave_driver(drv) \
 	__sdw_register_slave_driver(drv, THIS_MODULE)
 
-- 
2.20.1

