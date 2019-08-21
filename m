Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B86C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229422DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfHUS6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:58:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:47792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfHUS6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 11:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="262586628"
Received: from dbarua-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.198.189])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2019 11:58:36 -0700
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
Subject: [PATCH v3 1/4] soundwire: add debugfs support
Date:   Wed, 21 Aug 2019 13:58:18 -0500
Message-Id: <20190821185821.12690-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
References: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
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
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Makefile    |   4 +
 drivers/soundwire/bus.c       |   6 ++
 drivers/soundwire/bus.h       |  16 ++++
 drivers/soundwire/bus_type.c  |   3 +
 drivers/soundwire/debugfs.c   | 151 ++++++++++++++++++++++++++++++++++
 drivers/soundwire/slave.c     |   1 +
 include/linux/soundwire/sdw.h |   8 ++
 7 files changed, 189 insertions(+)
 create mode 100644 drivers/soundwire/debugfs.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index fd99a831b92a..34bbd36a9851 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -7,6 +7,10 @@
 soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
 
+ifdef CONFIG_DEBUG_FS
+soundwire-bus-objs += debugfs.o
+endif
+
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 50f9cc5eb5f6..728db3ebad6e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		}
 	}
 
+	sdw_bus_debugfs_init(bus);
+
 	/*
 	 * Device numbers in SoundWire are 0 through 15. Enumeration device
 	 * number (0), Broadcast device number (15), Group numbers (12 and
@@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_bus *bus = slave->bus;
 
+	sdw_slave_debugfs_exit(slave);
+
 	mutex_lock(&bus->bus_lock);
 
 	if (slave->dev_num) /* clear dev_num if assigned */
@@ -130,6 +134,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 void sdw_delete_bus_master(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+
+	sdw_bus_debugfs_exit(bus);
 }
 EXPORT_SYMBOL(sdw_delete_bus_master);
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 4429c51c5f86..9d6ea7e447ff 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -18,6 +18,22 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			  u64 addr, struct sdw_slave_id *id);
 
+#ifdef CONFIG_DEBUG_FS
+void sdw_bus_debugfs_init(struct sdw_bus *bus);
+void sdw_bus_debugfs_exit(struct sdw_bus *bus);
+void sdw_slave_debugfs_init(struct sdw_slave *slave);
+void sdw_slave_debugfs_exit(struct sdw_slave *slave);
+void sdw_debugfs_init(void);
+void sdw_debugfs_exit(void);
+#else
+static inline void sdw_bus_debugfs_init(struct sdw_bus *bus) {}
+static inline void sdw_bus_debugfs_exit(struct sdw_bus *bus) {}
+static inline void sdw_slave_debugfs_init(struct sdw_slave *slave) {}
+static inline void sdw_slave_debugfs_exit(struct sdw_slave *slave) {}
+static inline void sdw_debugfs_init(void) {}
+static inline void sdw_debugfs_exit(void) {}
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
index 000000000000..fb1140e82b86
--- /dev/null
+++ b/drivers/soundwire/debugfs.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2017-2019 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include "bus.h"
+
+static struct dentry *sdw_debugfs_root;
+
+void sdw_bus_debugfs_init(struct sdw_bus *bus)
+{
+	char name[16];
+
+	if (!sdw_debugfs_root)
+		return;
+
+	/* create the debugfs master-N */
+	snprintf(name, sizeof(name), "master-%d", bus->link_id);
+	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
+}
+
+void sdw_bus_debugfs_exit(struct sdw_bus *bus)
+{
+	debugfs_remove_recursive(bus->debugfs);
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
+static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
+{
+	struct sdw_slave *slave = s_file->private;
+	char *buf;
+	ssize_t ret;
+	int i, j;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+
+	/* DP0 non-banked registers */
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
+	for (i = SDW_DP0_INT; i <= SDW_DP0_PREPARECTRL; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	/* DP0 Bank 0 registers */
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
+	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	/* DP0 Bank 1 registers */
+	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+	ret += sdw_sprintf(slave, buf, ret,
+			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
+	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
+			i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	/* SCP registers */
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
+	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
+		ret += sdw_sprintf(slave, buf, ret, i);
+
+	/*
+	 * SCP Bank 0/1 registers are read-only and cannot be
+	 * retrieved from the Slave. The Master typically keeps track
+	 * of the current frame size so the information can be found
+	 * in other places
+	 */
+
+	/* DP1..14 registers */
+	for (i = 1; SDW_VALID_PORT_RANGE(i); i++) {
+
+		/* DPi registers */
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
+		for (j = SDW_DPN_INT(i); j <= SDW_DPN_PREPARECTRL(i); j++)
+			ret += sdw_sprintf(slave, buf, ret, j);
+
+		/* DPi Bank0 registers */
+		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+		for (j = SDW_DPN_CHANNELEN_B0(i);
+		     j <= SDW_DPN_LANECTRL_B0(i); j++)
+			ret += sdw_sprintf(slave, buf, ret, j);
+
+		/* DPi Bank1 registers */
+		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+		for (j = SDW_DPN_CHANNELEN_B1(i);
+		     j <= SDW_DPN_LANECTRL_B1(i); j++)
+			ret += sdw_sprintf(slave, buf, ret, j);
+	}
+
+	seq_printf(s_file, "%s", buf);
+	kfree(buf);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);
+
+void sdw_slave_debugfs_init(struct sdw_slave *slave)
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
+	slave->debugfs = d;
+}
+
+void sdw_slave_debugfs_exit(struct sdw_slave *slave)
+{
+	debugfs_remove_recursive(slave->debugfs);
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
index f39a5815e25d..4b522f6d1238 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -56,6 +56,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
 	}
+	sdw_slave_debugfs_init(slave);
 
 	return ret;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 131d49ef1cb4..2028318a4c62 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -542,6 +542,7 @@ struct sdw_slave_ops {
  * @bus: Bus handle
  * @ops: Slave callback ops
  * @prop: Slave properties
+ * @debugfs: Slave debugfs
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
  * @dev_num: Device Number assigned by Bus
@@ -553,6 +554,9 @@ struct sdw_slave {
 	struct sdw_bus *bus;
 	const struct sdw_slave_ops *ops;
 	struct sdw_slave_prop prop;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
 	struct list_head node;
 	struct completion *port_ready;
 	u16 dev_num;
@@ -729,6 +733,7 @@ struct sdw_master_ops {
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
+ * @debugfs: Bus debugfs
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  * @bank_switch_timeout: Bank switch timeout computed
@@ -748,6 +753,9 @@ struct sdw_bus {
 	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
 	struct list_head m_rt_list;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
-- 
2.20.1

