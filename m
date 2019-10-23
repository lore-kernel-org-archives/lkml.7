Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C22CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EB02084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436606AbfJWV3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:29:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:24158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407509AbfJWV2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:28:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="399541197"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 14:28:48 -0700
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
Subject: [PATCH 07/14] soundwire: add initial definitions for sdw_master_device
Date:   Wed, 23 Oct 2019 16:28:16 -0500
Message-Id: <20191023212823.608-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want an explicit support for the SoundWire Master device, add
the definitions, following the Grey Bus example.

Open: do we need to set a variable when dealing with the master uevent?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Makefile         |  2 +-
 drivers/soundwire/bus_type.c       | 16 +++++---
 drivers/soundwire/master.c         | 62 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h      | 35 +++++++++++++++++
 include/linux/soundwire/sdw_type.h |  9 +++++
 5 files changed, 117 insertions(+), 7 deletions(-)
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
index 5df095f4e12f..cf33f63773f0 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -49,21 +49,25 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 
 static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
+	struct sdw_master_device *md;
 	struct sdw_slave *slave;
 	char modalias[32];
 
-	if (is_sdw_slave(dev)) {
+	if (is_sdw_md(dev)) {
+		md = to_sdw_master_device(dev);
+		/* TODO: do we need to call add_uevent_var() ? */
+	} else if (is_sdw_slave(dev)) {
 		slave = to_sdw_slave_device(dev);
+
+		sdw_slave_modalias(slave, modalias, sizeof(modalias));
+
+		if (add_uevent_var(env, "MODALIAS=%s", modalias))
+			return -ENOMEM;
 	} else {
 		dev_warn(dev, "uevent for unknown Soundwire type\n");
 		return -EINVAL;
 	}
 
-	sdw_slave_modalias(slave, modalias, sizeof(modalias));
-
-	if (add_uevent_var(env, "MODALIAS=%s", modalias))
-		return -ENOMEM;
-
 	return 0;
 }
 
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
new file mode 100644
index 000000000000..6210098c892b
--- /dev/null
+++ b/drivers/soundwire/master.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
+	}
+
+	return md;
+}
+EXPORT_SYMBOL(sdw_md_add);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d6e5a0e42819..6f8b6a0cbcb7 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -573,6 +573,16 @@ struct sdw_slave {
 #define to_sdw_slave_device(d) \
 	container_of(d, struct sdw_slave, dev)
 
+struct sdw_master_device {
+	struct device dev;
+	int link_id;
+	struct sdw_md_driver *driver;
+	void *pdata; /* core does not touch */
+};
+
+#define to_sdw_master_device(d)	\
+	container_of(d, struct sdw_master_device, dev)
+
 struct sdw_driver {
 	const char *name;
 
@@ -587,6 +597,26 @@ struct sdw_driver {
 	struct device_driver driver;
 };
 
+struct sdw_md_driver {
+	/* initializations and allocations */
+	int (*probe)(struct sdw_master_device *md, void *link_ctx);
+	/* hardware enablement, all clock/power dependencies are available */
+	int (*startup)(struct sdw_master_device *md);
+	/* hardware disabled */
+	int (*shutdown)(struct sdw_master_device *md);
+	/* free all resources */
+	int (*remove)(struct sdw_master_device *md);
+	/*
+	 * enable/disable driver control while in clock-stop mode,
+	 * typically in always-on/D0ix modes. When the driver yields
+	 * control, another entity in the system (typically firmware
+	 * running on an always-on microprocessor) is responsible to
+	 * tracking Slave-initiated wakes
+	 */
+	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
+					    bool state);
+};
+
 #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
 	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
 	  .driver_data = (unsigned long)(_drv_data) }
@@ -776,6 +806,11 @@ struct sdw_bus {
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
index c681b3426478..463d6d018d56 100644
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
 
+static inline int is_sdw_md(const struct device *dev)
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

