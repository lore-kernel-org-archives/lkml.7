Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442AEC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12533216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGYXlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfGYXlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874633"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:40:59 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 01/40] soundwire: add debugfs support
Date:   Thu, 25 Jul 2019 18:39:53 -0500
Message-Id: <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base debugfs mechanism for SoundWire bus by creating soundwire
root and master-N and slave-x hierarchy.

Also add SDW Slave SCP, DP0 and DP-N register debug file.

Registers not implemented will print as "XX"

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
is the use of scnprintf to avoid known issues with snprintf.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Makefile    |   4 +-
 drivers/soundwire/bus.c       |   6 ++
 drivers/soundwire/bus.h       |  24 ++++++
 drivers/soundwire/bus_type.c  |   3 +
 drivers/soundwire/debugfs.c   | 156 ++++++++++++++++++++++++++++++++++
 drivers/soundwire/slave.c     |   1 +
 include/linux/soundwire/sdw.h |   4 +
 7 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/debugfs.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index fd99a831b92a..88990cac48a7 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,7 +4,9 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o \
+			debugfs.o
+
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fe745830a261..5ad4109dc72f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		}
 	}
 
+	bus->debugfs = sdw_bus_debugfs_init(bus);
+
 	/*
 	 * Device numbers in SoundWire are 0 through 15. Enumeration device
 	 * number (0), Broadcast device number (15), Group numbers (12 and
@@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_bus *bus = slave->bus;
 
+	sdw_slave_debugfs_exit(slave->debugfs);
+
 	mutex_lock(&bus->bus_lock);
 
 	if (slave->dev_num) /* clear dev_num if assigned */
@@ -130,6 +134,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 void sdw_delete_bus_master(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+
+	sdw_bus_debugfs_exit(bus->debugfs);
 }
 EXPORT_SYMBOL(sdw_delete_bus_master);
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 3048ca153f22..06ac4adb0074 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -18,6 +18,30 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus);
+void sdw_bus_debugfs_exit(struct dentry *d);
+struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave);
+void sdw_slave_debugfs_exit(struct dentry *d);
+void sdw_debugfs_init(void);
+void sdw_debugfs_exit(void);
+#else
+struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
+{ return NULL; }
+
+void sdw_bus_debugfs_exit(struct dentry *d) {}
+
+struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
+{ return NULL; }
+
+void sdw_slave_debugfs_exit(struct dentry *d) {}
+
+void sdw_debugfs_init(void) {}
+
+void sdw_debugfs_exit(void) {}
+
+#endif
+
 enum {
 	SDW_MSG_FLAG_READ = 0,
 	SDW_MSG_FLAG_WRITE,
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 2655602f0cfb..4a465f55039f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -6,6 +6,7 @@
 #include <linux/pm_domain.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include "bus.h"
 
 /**
  * sdw_get_device_id - find the matching SoundWire device id
@@ -177,11 +178,13 @@ EXPORT_SYMBOL_GPL(sdw_unregister_driver);
 
 static int __init sdw_bus_init(void)
 {
+	sdw_debugfs_init();
 	return bus_register(&sdw_bus_type);
 }
 
 static void __exit sdw_bus_exit(void)
 {
+	sdw_debugfs_exit();
 	bus_unregister(&sdw_bus_type);
 }
 
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
new file mode 100644
index 000000000000..8d86e100516e
--- /dev/null
+++ b/drivers/soundwire/debugfs.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2017-19 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include "bus.h"
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *sdw_debugfs_root;
+#endif
+
+struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
+{
+	struct dentry *d;
+	char name[16];
+
+	if (!sdw_debugfs_root)
+		return NULL;
+
+	/* create the debugfs master-N */
+	snprintf(name, sizeof(name), "master-%d", bus->link_id);
+	d = debugfs_create_dir(name, sdw_debugfs_root);
+
+	return d;
+}
+
+void sdw_bus_debugfs_exit(struct dentry *d)
+{
+	debugfs_remove_recursive(d);
+}
+
+#define RD_BUF (3 * PAGE_SIZE)
+
+static ssize_t sdw_sprintf(struct sdw_slave *slave,
+			   char *buf, size_t pos, unsigned int reg)
+{
+	int value;
+
+	value = sdw_read(slave, reg);
+
+	if (value < 0)
+		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
+	else
+		return scnprintf(buf + pos, RD_BUF - pos,
+				"%3x\t%2x\n", reg, value);
+}
+
+static ssize_t sdw_slave_reg_read(struct file *file, char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct sdw_slave *slave = file->private_data;
+	unsigned int reg;
+	char *buf;
+	ssize_t ret;
+	int i, j;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
+
+	for (i = 0; i < 6; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
+	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+	ret += sdw_sprintf(slave, buf, ret,
+			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
+	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
+			i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
+	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
+	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
+	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
+
+	for (i = 1; i < 14; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
+		reg = SDW_DPN_INT(i);
+		for (j = 0; j < 6; j++)
+			ret += sdw_sprintf(slave, buf, ret, reg + j);
+
+		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+		reg = SDW_DPN_CHANNELEN_B0(i);
+		for (j = 0; j < 9; j++)
+			ret += sdw_sprintf(slave, buf, ret, reg + j);
+
+		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+		reg = SDW_DPN_CHANNELEN_B1(i);
+		for (j = 0; j < 9; j++)
+			ret += sdw_sprintf(slave, buf, ret, reg + j);
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations sdw_slave_reg_fops = {
+	.open = simple_open,
+	.read = sdw_slave_reg_read,
+	.llseek = default_llseek,
+};
+
+struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
+{
+	struct dentry *master;
+	struct dentry *d;
+	char name[32];
+
+	master = slave->bus->debugfs;
+
+	/* create the debugfs slave-name */
+	snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
+	d = debugfs_create_dir(name, master);
+
+	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);
+
+	return d;
+}
+
+void sdw_slave_debugfs_exit(struct dentry *d)
+{
+	debugfs_remove_recursive(d);
+}
+
+void sdw_debugfs_init(void)
+{
+	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
+}
+
+void sdw_debugfs_exit(void)
+{
+	debugfs_remove_recursive(sdw_debugfs_root);
+}
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a5815e25d..34d8bb995f45 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -56,6 +56,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
 	}
+	slave->debugfs = sdw_slave_debugfs_init(slave);
 
 	return ret;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3b231472464a..a49028e9d666 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -544,6 +544,7 @@ struct sdw_slave_ops {
  * @bus: Bus handle
  * @ops: Slave callback ops
  * @prop: Slave properties
+ * @debugfs: Slave debugfs
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
  * @dev_num: Device Number assigned by Bus
@@ -555,6 +556,7 @@ struct sdw_slave {
 	struct sdw_bus *bus;
 	const struct sdw_slave_ops *ops;
 	struct sdw_slave_prop prop;
+	struct dentry *debugfs;
 	struct list_head node;
 	struct completion *port_ready;
 	u16 dev_num;
@@ -731,6 +733,7 @@ struct sdw_master_ops {
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
+ * @debugfs: Bus debugfs
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  * @bank_switch_timeout: Bank switch timeout computed
@@ -750,6 +753,7 @@ struct sdw_bus {
 	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
 	struct list_head m_rt_list;
+	struct dentry *debugfs;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
-- 
2.20.1

