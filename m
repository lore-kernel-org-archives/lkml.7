Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71474206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfDDSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:22:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:44486 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfDDSW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 11:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="220617785"
Received: from qcummins-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.110.11])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2019 11:22:08 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 1/3] soundwire: fix style issues
Date:   Thu,  4 Apr 2019 13:22:02 -0500
Message-Id: <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Visual inspections confirmed by checkpatch.pl --strict expose a number
of style issues, specifically parameter alignment is inconsistent as
if different contributors used different styles. Before we restart
support for SoundWire with Sound Open Firmware on Intel platforms,
let's clean all this.

Fix Kconfig help, spelling, SPDX format, alignment, spurious
parentheses, bool comparisons to true/false, macro argument
protection.

No new functionality added.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Kconfig          |   2 +-
 drivers/soundwire/bus.c            |  87 ++++++++--------
 drivers/soundwire/bus.h            |  16 +--
 drivers/soundwire/bus_type.c       |   4 +-
 drivers/soundwire/cadence_master.c |  87 ++++++++--------
 drivers/soundwire/cadence_master.h |  22 ++--
 drivers/soundwire/intel.c          |  89 ++++++++--------
 drivers/soundwire/intel.h          |   4 +-
 drivers/soundwire/intel_init.c     |  12 +--
 drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
 drivers/soundwire/slave.c          |  10 +-
 drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
 12 files changed, 314 insertions(+), 296 deletions(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 19c8efb9a5ee..84876a74874f 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig SOUNDWIRE
 	bool "SoundWire support"
-	---help---
+	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
 	  typically related to audio functions. SoundWire interface is
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cbfedfc20ef..691a31df9732 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -49,7 +49,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	}
 
 	/*
-	 * Device numbers in SoundWire are 0 thru 15. Enumeration device
+	 * Device numbers in SoundWire are 0 through 15. Enumeration device
 	 * number (0), Broadcast device number (15), Group numbers (12 and
 	 * 13) and Master device number (14) are not used for assignment so
 	 * mask these and other higher bits.
@@ -172,7 +172,8 @@ static inline int do_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 }
 
 static inline int do_transfer_defer(struct sdw_bus *bus,
-			struct sdw_msg *msg, struct sdw_defer *defer)
+				    struct sdw_msg *msg,
+				    struct sdw_defer *defer)
 {
 	int retry = bus->prop.err_threshold;
 	enum sdw_command_response resp;
@@ -224,7 +225,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 	ret = do_transfer(bus, msg);
 	if (ret != 0 && ret != -ENODATA)
 		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
-				msg->dev_num, ret);
+			msg->dev_num, ret);
 
 	if (msg->page)
 		sdw_reset_page(bus, msg->dev_num);
@@ -243,7 +244,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
  * Caller needs to hold the msg_lock lock while calling this
  */
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
-				struct sdw_defer *defer)
+		       struct sdw_defer *defer)
 {
 	int ret;
 
@@ -253,7 +254,7 @@ int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 	ret = do_transfer_defer(bus, msg, defer);
 	if (ret != 0 && ret != -ENODATA)
 		dev_err(bus->dev, "Defer trf on Slave %d failed:%d\n",
-				msg->dev_num, ret);
+			msg->dev_num, ret);
 
 	if (msg->page)
 		sdw_reset_page(bus, msg->dev_num);
@@ -261,9 +262,8 @@ int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 	return ret;
 }
 
-
 int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
-		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
+		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
 {
 	memset(msg, 0, sizeof(*msg));
 	msg->addr = addr; /* addr is 16 bit and truncated here */
@@ -284,7 +284,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	if (addr < SDW_REG_OPTIONAL_PAGE) { /* 32k but no page */
 		if (slave && !slave->prop.paging_support)
 			return 0;
-		/* no need for else as that will fall thru to paging */
+		/* no need for else as that will fall-through to paging */
 	}
 
 	/* paging mandatory */
@@ -323,7 +323,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	int ret;
 
 	ret = sdw_fill_msg(&msg, slave, addr, count,
-			slave->dev_num, SDW_MSG_FLAG_READ, val);
+			   slave->dev_num, SDW_MSG_FLAG_READ, val);
 	if (ret < 0)
 		return ret;
 
@@ -351,7 +351,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	int ret;
 
 	ret = sdw_fill_msg(&msg, slave, addr, count,
-			slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
 	if (ret < 0)
 		return ret;
 
@@ -417,10 +417,10 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
 
-	if ((slave->id.unique_id != id.unique_id) ||
-	    (slave->id.mfg_id != id.mfg_id) ||
-	    (slave->id.part_id != id.part_id) ||
-	    (slave->id.class_id != id.class_id))
+	if (slave->id.unique_id != id.unique_id ||
+	    slave->id.mfg_id != id.mfg_id ||
+	    slave->id.part_id != id.part_id ||
+	    slave->id.class_id != id.class_id)
 		return -ENODEV;
 
 	return 0;
@@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 		mutex_unlock(&slave->bus->bus_lock);
 		if (dev_num < 0) {
 			dev_err(slave->bus->dev, "Get dev_num failed: %d",
-								dev_num);
+				dev_num);
 			return dev_num;
 		}
 	} else {
 		dev_info(slave->bus->dev,
-				"Slave already registered dev_num:%d",
-				slave->dev_num);
+			 "Slave already registered dev_num:%d",
+			 slave->dev_num);
 
 		/* Clear the slave->dev_num to transfer message on device 0 */
 		dev_num = slave->dev_num;
@@ -485,7 +485,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 }
 
 void sdw_extract_slave_id(struct sdw_bus *bus,
-			u64 addr, struct sdw_slave_id *id)
+			  u64 addr, struct sdw_slave_id *id)
 {
 	dev_dbg(bus->dev, "SDW Slave Addr: %llx", addr);
 
@@ -525,7 +525,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 	/* No Slave, so use raw xfer api */
 	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
-			SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
+			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
 	if (ret < 0)
 		return ret;
 
@@ -573,7 +573,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 			}
 		}
 
-		if (found == false) {
+		if (!found) {
 			/* TODO: Park this device in Group 13 */
 			dev_err(bus->dev, "Slave Entry not found");
 		}
@@ -592,7 +592,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 }
 
 static void sdw_modify_slave_status(struct sdw_slave *slave,
-				enum sdw_slave_status status)
+				    enum sdw_slave_status status)
 {
 	mutex_lock(&slave->bus->bus_lock);
 	slave->status = status;
@@ -600,7 +600,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 }
 
 int sdw_configure_dpn_intr(struct sdw_slave *slave,
-			int port, bool enable, int mask)
+			   int port, bool enable, int mask)
 {
 	u32 addr;
 	int ret;
@@ -620,7 +620,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
 	if (ret < 0)
 		dev_err(slave->bus->dev,
-				"SDW_DPN_INTMASK write failed:%d", val);
+			"SDW_DPN_INTMASK write failed:%d", val);
 
 	return ret;
 }
@@ -644,7 +644,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
-				"SDW_SCP_INTMASK1 write failed:%d", ret);
+			"SDW_SCP_INTMASK1 write failed:%d", ret);
 		return ret;
 	}
 
@@ -659,7 +659,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
-				"SDW_DP0_INTMASK read failed:%d", ret);
+			"SDW_DP0_INTMASK read failed:%d", ret);
 		return val;
 	}
 
@@ -674,7 +674,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	status = sdw_read(slave, SDW_DP0_INT);
 	if (status < 0) {
 		dev_err(slave->bus->dev,
-				"SDW_DP0_INT read failed:%d", status);
+			"SDW_DP0_INT read failed:%d", status);
 		return status;
 	}
 
@@ -737,7 +737,7 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 }
 
 static int sdw_handle_port_interrupt(struct sdw_slave *slave,
-		int port, u8 *slave_status)
+				     int port, u8 *slave_status)
 {
 	u8 clear = 0, impl_int_mask;
 	int status, status2, ret, count = 0;
@@ -750,7 +750,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	status = sdw_read(slave, addr);
 	if (status < 0) {
 		dev_err(slave->bus->dev,
-				"SDW_DPN_INT read failed:%d", status);
+			"SDW_DPN_INT read failed:%d", status);
 
 		return status;
 	}
@@ -774,7 +774,6 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		impl_int_mask = SDW_DPN_INT_IMPDEF1 |
 			SDW_DPN_INT_IMPDEF2 | SDW_DPN_INT_IMPDEF3;
 
-
 		if (status & impl_int_mask) {
 			clear |= impl_int_mask;
 			*slave_status = clear;
@@ -784,7 +783,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		ret = sdw_write(slave, addr, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_DPN_INT write failed:%d", ret);
+				"SDW_DPN_INT write failed:%d", ret);
 			return ret;
 		}
 
@@ -792,7 +791,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 		status2 = sdw_read(slave, addr);
 		if (status2 < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_DPN_INT read failed:%d", status2);
+				"SDW_DPN_INT read failed:%d", status2);
 			return status2;
 		}
 		status &= status2;
@@ -823,14 +822,14 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	buf = ret = sdw_read(slave, SDW_SCP_INT1);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
-					"SDW_SCP_INT1 read failed:%d", ret);
+			"SDW_SCP_INT1 read failed:%d", ret);
 		return ret;
 	}
 
 	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
 	if (ret < 0) {
 		dev_err(slave->bus->dev,
-					"SDW_SCP_INT2/3 read failed:%d", ret);
+			"SDW_SCP_INT2/3 read failed:%d", ret);
 		return ret;
 	}
 
@@ -869,7 +868,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		port = port >> SDW_REG_SHIFT(SDW_SCP_INT1_PORT0_3);
 		for_each_set_bit(bit, &port, 8) {
 			sdw_handle_port_interrupt(slave, bit,
-						&port_status[bit]);
+						  &port_status[bit]);
 
 		}
 
@@ -898,11 +897,11 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 
 		/* Update the Slave driver */
-		if (slave_notify && (slave->ops) &&
-					(slave->ops->interrupt_callback)) {
+		if (slave_notify && slave->ops &&
+		    slave->ops->interrupt_callback) {
 			slave_intr.control_port = clear;
 			memcpy(slave_intr.port, &port_status,
-						sizeof(slave_intr.port));
+			       sizeof(slave_intr.port));
 
 			slave->ops->interrupt_callback(slave, &slave_intr);
 		}
@@ -911,7 +910,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		ret = sdw_write(slave, SDW_SCP_INT1, clear);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_SCP_INT1 write failed:%d", ret);
+				"SDW_SCP_INT1 write failed:%d", ret);
 			return ret;
 		}
 
@@ -922,14 +921,14 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		_buf = ret = sdw_read(slave, SDW_SCP_INT1);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_SCP_INT1 read failed:%d", ret);
+				"SDW_SCP_INT1 read failed:%d", ret);
 			return ret;
 		}
 
 		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
 			dev_err(slave->bus->dev,
-					"SDW_SCP_INT2/3 read failed:%d", ret);
+				"SDW_SCP_INT2/3 read failed:%d", ret);
 			return ret;
 		}
 
@@ -955,9 +954,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 }
 
 static int sdw_update_slave_status(struct sdw_slave *slave,
-				enum sdw_slave_status status)
+				   enum sdw_slave_status status)
 {
-	if ((slave->ops) && (slave->ops->update_status))
+	if (slave->ops && slave->ops->update_status)
 		return slave->ops->update_status(slave, status);
 
 	return 0;
@@ -969,7 +968,7 @@ static int sdw_update_slave_status(struct sdw_slave *slave,
  * @status: Status for all Slave(s)
  */
 int sdw_handle_slave_status(struct sdw_bus *bus,
-			enum sdw_slave_status status[])
+			    enum sdw_slave_status status[])
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
@@ -1030,7 +1029,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 		default:
 			dev_err(bus->dev, "Invalid slave %d status:%d",
-							i, status[i]);
+				i, status[i]);
 			break;
 		}
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index c77de05b8100..3048ca153f22 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_BUS_H
 #define __SDW_BUS_H
@@ -16,7 +16,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
 #endif
 
 void sdw_extract_slave_id(struct sdw_bus *bus,
-			u64 addr, struct sdw_slave_id *id);
+			  u64 addr, struct sdw_slave_id *id);
 
 enum {
 	SDW_MSG_FLAG_READ = 0,
@@ -116,19 +116,19 @@ struct sdw_master_runtime {
 };
 
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
-				enum sdw_data_direction direction,
-				unsigned int port_num);
+					    enum sdw_data_direction direction,
+					    unsigned int port_num);
 int sdw_configure_dpn_intr(struct sdw_slave *slave, int port,
-					bool enable, int mask);
+			   bool enable, int mask);
 
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
-				struct sdw_defer *defer);
+		       struct sdw_defer *defer);
 
 #define SDW_READ_INTR_CLEAR_RETRY	10
 
 int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
-		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
+		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
 
 /* Read-Modify-Write Slave register */
 static inline int
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 283b2832728e..2655602f0cfb 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -107,7 +107,7 @@ static int sdw_drv_probe(struct device *dev)
 		slave->prop.clk_stop_timeout = 300;
 
 	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
-					slave->prop.clk_stop_timeout);
+					     slave->prop.clk_stop_timeout);
 
 	return 0;
 }
@@ -148,7 +148,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 
 	if (!drv->probe) {
 		pr_err("driver %s didn't provide SDW probe routine\n",
-							drv->name);
+		       drv->name);
 		return -EINVAL;
 	}
 
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index cb6a331f448a..5786a2e0be84 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -42,7 +42,6 @@
 #define CDNS_MCP_CONTROL_CMD_ACCEPT		BIT(1)
 #define CDNS_MCP_CONTROL_BLOCK_WAKEUP		BIT(0)
 
-
 #define CDNS_MCP_CMDCTRL			0x8
 #define CDNS_MCP_SSPSTAT			0xC
 #define CDNS_MCP_FRAME_SHAPE			0x10
@@ -226,9 +225,9 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 /*
  * IO Calls
  */
-static enum sdw_command_response cdns_fill_msg_resp(
-			struct sdw_cdns *cdns,
-			struct sdw_msg *msg, int count, int offset)
+static enum sdw_command_response
+cdns_fill_msg_resp(struct sdw_cdns *cdns,
+		   struct sdw_msg *msg, int count, int offset)
 {
 	int nack = 0, no_ack = 0;
 	int i;
@@ -263,7 +262,7 @@ static enum sdw_command_response cdns_fill_msg_resp(
 
 static enum sdw_command_response
 _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
-				int offset, int count, bool defer)
+	       int offset, int count, bool defer)
 {
 	unsigned long time;
 	u32 base, i, data;
@@ -296,7 +295,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 
 	/* wait for timeout or response */
 	time = wait_for_completion_timeout(&cdns->tx_complete,
-				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
 	if (!time) {
 		dev_err(cdns->dev, "IO transfer timed out\n");
 		msg->len = 0;
@@ -306,8 +305,8 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	return cdns_fill_msg_resp(cdns, msg, count, offset);
 }
 
-static enum sdw_command_response cdns_program_scp_addr(
-			struct sdw_cdns *cdns, struct sdw_msg *msg)
+static enum sdw_command_response
+cdns_program_scp_addr(struct sdw_cdns *cdns, struct sdw_msg *msg)
 {
 	int nack = 0, no_ack = 0;
 	unsigned long time;
@@ -336,7 +335,7 @@ static enum sdw_command_response cdns_program_scp_addr(
 	cdns_writel(cdns, base, data[1]);
 
 	time = wait_for_completion_timeout(&cdns->tx_complete,
-				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
 	if (!time) {
 		dev_err(cdns->dev, "SCP Msg trf timed out\n");
 		msg->len = 0;
@@ -410,7 +409,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
 		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
-				CDNS_MCP_CMD_LEN, false);
+				     CDNS_MCP_CMD_LEN, false);
 		if (ret < 0)
 			goto exit;
 	}
@@ -419,7 +418,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 		goto exit;
 
 	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
-			msg->len % CDNS_MCP_CMD_LEN, false);
+			     msg->len % CDNS_MCP_CMD_LEN, false);
 
 exit:
 	return ret;
@@ -428,7 +427,7 @@ EXPORT_SYMBOL(cdns_xfer_msg);
 
 enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
-		struct sdw_msg *msg, struct sdw_defer *defer)
+		    struct sdw_msg *msg, struct sdw_defer *defer)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int cmd = 0, ret;
@@ -483,7 +482,7 @@ static void cdns_read_response(struct sdw_cdns *cdns)
 }
 
 static int cdns_update_slave_status(struct sdw_cdns *cdns,
-					u32 slave0, u32 slave1)
+				    u32 slave0, u32 slave1)
 {
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
@@ -526,8 +525,8 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
 			dev_warn(cdns->dev,
-					"Slave reported multiple Status: %d\n",
-					status[i]);
+				 "Slave reported multiple Status: %d\n",
+				 status[i]);
 			/*
 			 * TODO: we need to reread the status here by
 			 * issuing a PING cmd
@@ -566,11 +565,12 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 
 		if (cdns->defer) {
 			cdns_fill_msg_resp(cdns, cdns->defer->msg,
-					cdns->defer->length, 0);
+					   cdns->defer->length, 0);
 			complete(&cdns->defer->complete);
 			cdns->defer = NULL;
-		} else
+		} else {
 			complete(&cdns->tx_complete);
+		}
 	}
 
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
@@ -592,7 +592,7 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 	if (int_status & CDNS_MCP_INT_SLAVE_MASK) {
 		/* Mask the Slave interrupt and wake thread */
 		cdns_updatel(cdns, CDNS_MCP_INTMASK,
-				CDNS_MCP_INT_SLAVE_MASK, 0);
+			     CDNS_MCP_INT_SLAVE_MASK, 0);
 
 		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
 		ret = IRQ_WAKE_THREAD;
@@ -625,7 +625,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id)
 	/* clear and unmask Slave interrupt now */
 	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
 	cdns_updatel(cdns, CDNS_MCP_INTMASK,
-			CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
+		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
 
 	return IRQ_HANDLED;
 }
@@ -639,9 +639,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 	u32 mask;
 
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
-				CDNS_MCP_SLAVE_INTMASK0_MASK);
+		    CDNS_MCP_SLAVE_INTMASK0_MASK);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
-				CDNS_MCP_SLAVE_INTMASK1_MASK);
+		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
 	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
 		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
@@ -663,7 +663,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	_cdns_enable_interrupt(cdns);
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
-			CDNS_MCP_CONFIG_UPDATE_BIT);
+			     CDNS_MCP_CONFIG_UPDATE_BIT);
 	if (ret < 0)
 		dev_err(cdns->dev, "Config update timedout");
 
@@ -672,8 +672,8 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
 static int cdns_allocate_pdi(struct sdw_cdns *cdns,
-			struct sdw_cdns_pdi **stream,
-			u32 num, u32 pdi_offset)
+			     struct sdw_cdns_pdi **stream,
+			     u32 num, u32 pdi_offset)
 {
 	struct sdw_cdns_pdi *pdi;
 	int i;
@@ -701,7 +701,7 @@ static int cdns_allocate_pdi(struct sdw_cdns *cdns,
  * @config: Stream configurations
  */
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
-			struct sdw_cdns_stream_config config)
+		      struct sdw_cdns_stream_config config)
 {
 	struct sdw_cdns_streams *stream;
 	int offset, i, ret;
@@ -770,7 +770,7 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	cdns->num_ports += stream->num_pdi;
 
 	cdns->ports = devm_kcalloc(cdns->dev, cdns->num_ports,
-				sizeof(*cdns->ports), GFP_KERNEL);
+				   sizeof(*cdns->ports), GFP_KERNEL);
 	if (!cdns->ports) {
 		ret = -ENOMEM;
 		return ret;
@@ -796,7 +796,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	/* Exit clock stop */
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
-			CDNS_MCP_CONTROL_CLK_STOP_CLR);
+			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
 	if (ret < 0) {
 		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
 		return ret;
@@ -816,7 +816,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	/* Set cmd accept mode */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
-					CDNS_MCP_CONTROL_CMD_ACCEPT);
+		     CDNS_MCP_CONTROL_CMD_ACCEPT);
 
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
@@ -873,7 +873,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 EXPORT_SYMBOL(cdns_bus_conf);
 
 static int cdns_port_params(struct sdw_bus *bus,
-		struct sdw_port_params *p_params, unsigned int bank)
+			    struct sdw_port_params *p_params, unsigned int bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_config = 0, dpn_config_off;
@@ -898,8 +898,8 @@ static int cdns_port_params(struct sdw_bus *bus,
 }
 
 static int cdns_transport_params(struct sdw_bus *bus,
-			struct sdw_transport_params *t_params,
-			enum sdw_reg_bank bank)
+				 struct sdw_transport_params *t_params,
+				 enum sdw_reg_bank bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_offsetctrl = 0, dpn_offsetctrl_off;
@@ -952,7 +952,7 @@ static int cdns_transport_params(struct sdw_bus *bus,
 }
 
 static int cdns_port_enable(struct sdw_bus *bus,
-		struct sdw_enable_ch *enable_ch, unsigned int bank)
+			    struct sdw_enable_ch *enable_ch, unsigned int bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_chnen_off, ch_mask;
@@ -988,7 +988,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_probe);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-		void *stream, bool pcm, int direction)
+			void *stream, bool pcm, int direction)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dma_data *dma;
@@ -1026,12 +1026,13 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * Find and return a free PDI for a given PDI array
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
-		unsigned int num, struct sdw_cdns_pdi *pdi)
+					  unsigned int num,
+					  struct sdw_cdns_pdi *pdi)
 {
 	int i;
 
 	for (i = 0; i < num; i++) {
-		if (pdi[i].assigned == true)
+		if (pdi[i].assigned)
 			continue;
 		pdi[i].assigned = true;
 		return &pdi[i];
@@ -1050,8 +1051,8 @@ static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
  * @pdi: PDI to be used
  */
 void sdw_cdns_config_stream(struct sdw_cdns *cdns,
-				struct sdw_cdns_port *port,
-				u32 ch, u32 dir, struct sdw_cdns_pdi *pdi)
+			    struct sdw_cdns_port *port,
+			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi)
 {
 	u32 offset, val = 0;
 
@@ -1076,13 +1077,13 @@ EXPORT_SYMBOL(sdw_cdns_config_stream);
  * @ch_count: Channel count
  */
 static int cdns_get_num_pdi(struct sdw_cdns *cdns,
-		struct sdw_cdns_pdi *pdi,
-		unsigned int num, u32 ch_count)
+			    struct sdw_cdns_pdi *pdi,
+			    unsigned int num, u32 ch_count)
 {
 	int i, pdis = 0;
 
 	for (i = 0; i < num; i++) {
-		if (pdi[i].assigned == true)
+		if (pdi[i].assigned)
 			continue;
 
 		if (pdi[i].ch_count < ch_count)
@@ -1139,8 +1140,8 @@ EXPORT_SYMBOL(sdw_cdns_get_stream);
  * @dir: Data direction
  */
 int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
-			struct sdw_cdns_streams *stream,
-			struct sdw_cdns_port *port, u32 ch, u32 dir)
+			  struct sdw_cdns_streams *stream,
+			  struct sdw_cdns_port *port, u32 ch, u32 dir)
 {
 	struct sdw_cdns_pdi *pdi = NULL;
 
@@ -1167,7 +1168,7 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 EXPORT_SYMBOL(sdw_cdns_alloc_stream);
 
 void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *dai)
+		       struct snd_soc_dai *dai)
 {
 	struct sdw_cdns_dma_data *dma;
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index eb902b19c5a4..fe2af62958b1 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-17 Intel Corporation. */
 #include <sound/soc.h>
 
 #ifndef __SDW_CADENCE_H
@@ -160,24 +160,24 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
-			struct sdw_cdns_stream_config config);
+		      struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
 int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			struct sdw_cdns_streams *stream,
 			u32 ch, u32 dir);
 int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
-			struct sdw_cdns_streams *stream,
-			struct sdw_cdns_port *port, u32 ch, u32 dir);
+			  struct sdw_cdns_streams *stream,
+			  struct sdw_cdns_port *port, u32 ch, u32 dir);
 void sdw_cdns_config_stream(struct sdw_cdns *cdns, struct sdw_cdns_port *port,
-			u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
+			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
 void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai);
+		       struct snd_soc_dai *dai);
 int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
-				void *stream, int direction);
+			    void *stream, int direction);
 int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
-				void *stream, int direction);
+			    void *stream, int direction);
 
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
@@ -187,7 +187,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
 enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
-		struct sdw_msg *msg, struct sdw_defer *defer);
+		    struct sdw_msg *msg, struct sdw_defer *defer);
 
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
@@ -195,5 +195,5 @@ cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-		void *stream, bool pcm, int direction);
+			void *stream, bool pcm, int direction);
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd8d034cfec1..a5a8b0e06bbf 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -23,18 +23,18 @@
 #define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
 
-#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * x)
-#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * x)
-#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * x)
-#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * x)
-#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * x)
-#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * x)
-
-#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * x)
-#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * x)
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * x)
+#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
+#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
+#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
+#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * (x))
+#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * (x))
+#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * (x))
+
+#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
 
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
@@ -81,7 +81,7 @@
 #define SDW_SHIM_WAKESTS_STATUS		BIT(0)
 
 /* Intel ALH Register definitions */
-#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * x))
+#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
 
 #define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
@@ -235,7 +235,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	/* Set SyncCPU bit */
 	sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-				SDW_SHIM_SYNC_SYNCCPU);
+			      SDW_SHIM_SYNC_SYNCCPU);
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Failed to set sync period: %d", ret);
 
@@ -246,7 +246,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
  * PDI routines
  */
 static void intel_pdi_init(struct sdw_intel *sdw,
-			struct sdw_cdns_stream_config *config)
+			   struct sdw_cdns_stream_config *config)
 {
 	void __iomem *shim = sdw->res->shim;
 	unsigned int link_id = sdw->instance;
@@ -295,9 +295,9 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 }
 
 static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
-				struct sdw_cdns_pdi *pdi,
-				unsigned int num_pdi,
-				unsigned int *num_ch, bool pcm)
+				   struct sdw_cdns_pdi *pdi,
+				   unsigned int num_pdi,
+				   unsigned int *num_ch, bool pcm)
 {
 	int i, ch_count = 0;
 
@@ -312,16 +312,16 @@ static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
 }
 
 static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
-				struct sdw_cdns_streams *stream, bool pcm)
+				      struct sdw_cdns_streams *stream, bool pcm)
 {
 	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
-			&stream->num_ch_bd, pcm);
+				&stream->num_ch_bd, pcm);
 
 	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
-			&stream->num_ch_in, pcm);
+				&stream->num_ch_in, pcm);
 
 	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
-			&stream->num_ch_out, pcm);
+				&stream->num_ch_out, pcm);
 
 	return 0;
 }
@@ -386,9 +386,9 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 }
 
 static int intel_config_stream(struct sdw_intel *sdw,
-			struct snd_pcm_substream *substream,
-			struct snd_soc_dai *dai,
-			struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai,
+			       struct snd_pcm_hw_params *hw_params, int link_id)
 {
 	if (sdw->res->ops && sdw->res->ops->config_stream)
 		return sdw->res->ops->config_stream(sdw->res->arg,
@@ -453,7 +453,7 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
 
 	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-					SDW_SHIM_SYNC_SYNCGO);
+			      SDW_SHIM_SYNC_SYNCGO);
 	if (ret < 0)
 		dev_err(sdw->cdns.dev, "Post bank switch failed: %d", ret);
 
@@ -465,14 +465,14 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  */
 
 static struct sdw_cdns_port *intel_alloc_port(struct sdw_intel *sdw,
-				u32 ch, u32 dir, bool pcm)
+					      u32 ch, u32 dir, bool pcm)
 {
 	struct sdw_cdns *cdns = &sdw->cdns;
 	struct sdw_cdns_port *port = NULL;
 	int i, ret = 0;
 
 	for (i = 0; i < cdns->num_ports; i++) {
-		if (cdns->ports[i].assigned == true)
+		if (cdns->ports[i].assigned)
 			continue;
 
 		port = &cdns->ports[i];
@@ -525,8 +525,8 @@ static void intel_port_cleanup(struct sdw_cdns_dma_data *dma)
 }
 
 static int intel_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_soc_dai *dai)
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -574,7 +574,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	/* Inform DSP about PDI stream number */
 	for (i = 0; i < dma->nr_ports; i++) {
 		ret = intel_config_stream(sdw, substream, dai, params,
-				dma->port[i]->pdi->intel_alh_id);
+					  dma->port[i]->pdi->intel_alh_id);
 		if (ret)
 			goto port_error;
 	}
@@ -604,7 +604,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
-				pconfig, dma->nr_ports, dma->stream);
+				    pconfig, dma->nr_ports, dma->stream);
 	if (ret) {
 		dev_err(cdns->dev, "add master to stream failed:%d", ret);
 		goto stream_error;
@@ -635,7 +635,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
 	if (ret < 0)
 		dev_err(dai->dev, "remove master from stream %s failed: %d",
-							dma->stream->name, ret);
+			dma->stream->name, ret);
 
 	intel_port_cleanup(dma);
 	kfree(dma->port);
@@ -643,13 +643,13 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
-					void *stream, int direction)
+				    void *stream, int direction)
 {
 	return cdns_set_sdw_stream(dai, stream, true, direction);
 }
 
 static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
-					void *stream, int direction)
+				    void *stream, int direction)
 {
 	return cdns_set_sdw_stream(dai, stream, false, direction);
 }
@@ -673,9 +673,9 @@ static const struct snd_soc_component_driver dai_component = {
 };
 
 static int intel_create_dai(struct sdw_cdns *cdns,
-			struct snd_soc_dai_driver *dais,
-			enum intel_pdi_type type,
-			u32 num, u32 off, u32 max_ch, bool pcm)
+			    struct snd_soc_dai_driver *dais,
+			    enum intel_pdi_type type,
+			    u32 num, u32 off, u32 max_ch, bool pcm)
 {
 	int i;
 
@@ -685,7 +685,7 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 	 /* TODO: Read supported rates/formats from hardware */
 	for (i = off; i < (off + num); i++) {
 		dais[i].name = kasprintf(GFP_KERNEL, "SDW%d Pin%d",
-					cdns->instance, i);
+					 cdns->instance, i);
 		if (!dais[i].name)
 			return -ENOMEM;
 
@@ -786,7 +786,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 		return ret;
 
 	return snd_soc_register_component(cdns->dev, &dai_component,
-				dais, num_dai);
+					  dais, num_dai);
 }
 
 static int intel_prop_read(struct sdw_bus *bus)
@@ -797,7 +797,7 @@ static int intel_prop_read(struct sdw_bus *bus)
 	/* BIOS is not giving some values correctly. So, lets override them */
 	bus->prop.num_freq = 1;
 	bus->prop.freq = devm_kcalloc(bus->dev, sizeof(*bus->prop.freq),
-					bus->prop.num_freq, GFP_KERNEL);
+				      bus->prop.num_freq, GFP_KERNEL);
 	if (!bus->prop.freq)
 		return -ENOMEM;
 
@@ -872,12 +872,11 @@ static int intel_probe(struct platform_device *pdev)
 	intel_pdi_ch_update(sdw);
 
 	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq,
-			sdw_cdns_thread, IRQF_SHARED, KBUILD_MODNAME,
-			&sdw->cdns);
+	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq, sdw_cdns_thread,
+				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-				sdw->res->irq);
+			sdw->res->irq);
 		goto err_init;
 	}
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index c1a5bac6212e..71050e5f643d 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-// Copyright(c) 2015-17 Intel Corporation.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_INTEL_LOCAL_H
 #define __SDW_INTEL_LOCAL_H
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 5c8a20d99878..5123c8f79591 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -67,7 +67,7 @@ static struct sdw_intel_ctx
 	/* Found controller, find links supported */
 	count = 0;
 	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
-				  "mipi-sdw-master-count", &count, 1);
+					    "mipi-sdw-master-count", &count, 1);
 
 	/* Don't fail on error, continue and use hw value */
 	if (ret) {
@@ -85,7 +85,7 @@ static struct sdw_intel_ctx
 	/* Check count is within bounds */
 	if (count > SDW_MAX_LINKS) {
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
-						count, SDW_MAX_LINKS);
+			count, SDW_MAX_LINKS);
 		return NULL;
 	}
 
@@ -145,7 +145,7 @@ static struct sdw_intel_ctx
 }
 
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
-					void *cdata, void **return_value)
+				     void *cdata, void **return_value)
 {
 	struct sdw_intel_res *res = cdata;
 	struct acpi_device *adev;
@@ -172,9 +172,9 @@ void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-					parent_handle, 1,
-					sdw_intel_acpi_cb,
-					NULL, res, NULL);
+				     parent_handle, 1,
+				     sdw_intel_acpi_cb,
+				     NULL, res, NULL);
 	if (ACPI_FAILURE(status))
 		return NULL;
 
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index fdeba0c3b589..2bf4046e68b6 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -35,11 +35,12 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	int nval, i;
 
 	device_property_read_u32(bus->dev,
-			"mipi-sdw-sw-interface-revision", &prop->revision);
+				 "mipi-sdw-sw-interface-revision",
+				 &prop->revision);
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-			"mipi-sdw-master-%d-subproperties", bus->link_id);
+		 "mipi-sdw-master-%d-subproperties", bus->link_id);
 
 	link = device_get_named_child_node(bus->dev, name);
 	if (!link) {
@@ -48,15 +49,16 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	}
 
 	if (fwnode_property_read_bool(link,
-			"mipi-sdw-clock-stop-mode0-supported") == true)
+				      "mipi-sdw-clock-stop-mode0-supported"))
 		prop->clk_stop_mode = SDW_CLK_STOP_MODE0;
 
 	if (fwnode_property_read_bool(link,
-			"mipi-sdw-clock-stop-mode1-supported") == true)
+				      "mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
 
 	fwnode_property_read_u32(link,
-			"mipi-sdw-max-clock-frequency", &prop->max_freq);
+				 "mipi-sdw-max-clock-frequency",
+				 &prop->max_freq);
 
 	nval = fwnode_property_read_u32_array(link,
 			"mipi-sdw-clock-frequencies-supported", NULL, 0);
@@ -64,7 +66,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 		prop->num_freq = nval;
 		prop->freq = devm_kcalloc(bus->dev, prop->num_freq,
-				sizeof(*prop->freq), GFP_KERNEL);
+					  sizeof(*prop->freq), GFP_KERNEL);
 		if (!prop->freq)
 			return -ENOMEM;
 
@@ -91,44 +93,47 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 		prop->num_clk_gears = nval;
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
-				sizeof(*prop->clk_gears), GFP_KERNEL);
+					       sizeof(*prop->clk_gears),
+					       GFP_KERNEL);
 		if (!prop->clk_gears)
 			return -ENOMEM;
 
 		fwnode_property_read_u32_array(link,
-				"mipi-sdw-supported-clock-gears",
-				prop->clk_gears, prop->num_clk_gears);
+					       "mipi-sdw-supported-clock-gears",
+					       prop->clk_gears,
+					       prop->num_clk_gears);
 	}
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-rate",
-			&prop->default_frame_rate);
+				 &prop->default_frame_rate);
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-row-size",
-			&prop->default_row);
+				 &prop->default_row);
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
-			&prop->default_col);
+				 &prop->default_col);
 
 	prop->dynamic_frame =  fwnode_property_read_bool(link,
 			"mipi-sdw-dynamic-frame-shape");
 
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
-			&prop->err_threshold);
+				 &prop->err_threshold);
 
 	return 0;
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
 
 static int sdw_slave_read_dp0(struct sdw_slave *slave,
-		struct fwnode_handle *port, struct sdw_dp0_prop *dp0)
+			      struct fwnode_handle *port,
+			      struct sdw_dp0_prop *dp0)
 {
 	int nval;
 
 	fwnode_property_read_u32(port, "mipi-sdw-port-max-wordlength",
-			&dp0->max_word);
+				 &dp0->max_word);
 
 	fwnode_property_read_u32(port, "mipi-sdw-port-min-wordlength",
-			&dp0->min_word);
+				 &dp0->min_word);
 
 	nval = fwnode_property_read_u32_array(port,
 			"mipi-sdw-port-wordlength-configs", NULL, 0);
@@ -136,8 +141,8 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 
 		dp0->num_words = nval;
 		dp0->words = devm_kcalloc(&slave->dev,
-				dp0->num_words, sizeof(*dp0->words),
-				GFP_KERNEL);
+					  dp0->num_words, sizeof(*dp0->words),
+					  GFP_KERNEL);
 		if (!dp0->words)
 			return -ENOMEM;
 
@@ -146,20 +151,21 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 				dp0->words, dp0->num_words);
 	}
 
-	dp0->flow_controlled = fwnode_property_read_bool(
-			port, "mipi-sdw-bra-flow-controlled");
+	dp0->flow_controlled = fwnode_property_read_bool(port,
+				"mipi-sdw-bra-flow-controlled");
 
-	dp0->simple_ch_prep_sm = fwnode_property_read_bool(
-			port, "mipi-sdw-simplified-channel-prepare-sm");
+	dp0->simple_ch_prep_sm = fwnode_property_read_bool(port,
+				"mipi-sdw-simplified-channel-prepare-sm");
 
-	dp0->device_interrupts = fwnode_property_read_bool(
-			port, "mipi-sdw-imp-def-dp0-interrupts-supported");
+	dp0->device_interrupts = fwnode_property_read_bool(port,
+				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
 	return 0;
 }
 
 static int sdw_slave_read_dpn(struct sdw_slave *slave,
-		struct sdw_dpn_prop *dpn, int count, int ports, char *type)
+			      struct sdw_dpn_prop *dpn, int count, int ports,
+			      char *type)
 {
 	struct fwnode_handle *node;
 	u32 bit, i = 0;
@@ -173,7 +179,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 	for_each_set_bit(bit, &addr, 32) {
 		snprintf(name, sizeof(name),
-			"mipi-sdw-dp-%d-%s-subproperties", bit, type);
+			 "mipi-sdw-dp-%d-%s-subproperties", bit, type);
 
 		dpn[i].num = bit;
 
@@ -184,9 +190,9 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		}
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
-					&dpn[i].max_word);
+					 &dpn[i].max_word);
 		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
-					&dpn[i].min_word);
+					 &dpn[i].min_word);
 
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-port-wordlength-configs", NULL, 0);
@@ -194,8 +200,9 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 			dpn[i].num_words = nval;
 			dpn[i].words = devm_kcalloc(&slave->dev,
-					dpn[i].num_words,
-					sizeof(*dpn[i].words), GFP_KERNEL);
+						    dpn[i].num_words,
+						    sizeof(*dpn[i].words),
+						    GFP_KERNEL);
 			if (!dpn[i].words)
 				return -ENOMEM;
 
@@ -205,28 +212,28 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		}
 
 		fwnode_property_read_u32(node, "mipi-sdw-data-port-type",
-				&dpn[i].type);
+					 &dpn[i].type);
 
 		fwnode_property_read_u32(node,
-				"mipi-sdw-max-grouping-supported",
-				&dpn[i].max_grouping);
+					 "mipi-sdw-max-grouping-supported",
+					 &dpn[i].max_grouping);
 
 		dpn[i].simple_ch_prep_sm = fwnode_property_read_bool(node,
 				"mipi-sdw-simplified-channelprepare-sm");
 
 		fwnode_property_read_u32(node,
-				"mipi-sdw-port-channelprepare-timeout",
-				&dpn[i].ch_prep_timeout);
+					 "mipi-sdw-port-channelprepare-timeout",
+					 &dpn[i].ch_prep_timeout);
 
 		fwnode_property_read_u32(node,
 				"mipi-sdw-imp-def-dpn-interrupts-supported",
 				&dpn[i].device_interrupts);
 
 		fwnode_property_read_u32(node, "mipi-sdw-min-channel-number",
-				&dpn[i].min_ch);
+					 &dpn[i].min_ch);
 
 		fwnode_property_read_u32(node, "mipi-sdw-max-channel-number",
-				&dpn[i].max_ch);
+					 &dpn[i].max_ch);
 
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-channel-number-list", NULL, 0);
@@ -234,7 +241,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 			dpn[i].num_ch = nval;
 			dpn[i].ch = devm_kcalloc(&slave->dev, dpn[i].num_ch,
-					sizeof(*dpn[i].ch), GFP_KERNEL);
+						 sizeof(*dpn[i].ch),
+						 GFP_KERNEL);
 			if (!dpn[i].ch)
 				return -ENOMEM;
 
@@ -265,13 +273,13 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				"mipi-sdw-modes-supported", &dpn[i].modes);
 
 		fwnode_property_read_u32(node, "mipi-sdw-max-async-buffer",
-				&dpn[i].max_async_buffer);
+					 &dpn[i].max_async_buffer);
 
 		dpn[i].block_pack_mode = fwnode_property_read_bool(node,
 				"mipi-sdw-block-packing-mode");
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
-				&dpn[i].port_encoding);
+					 &dpn[i].port_encoding);
 
 		/* TODO: Read audio mode */
 
@@ -293,7 +301,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	int num_of_ports, nval, i, dp0 = 0;
 
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
-				&prop->mipi_revision);
+				 &prop->mipi_revision);
 
 	prop->wake_capable = device_property_read_bool(dev,
 				"mipi-sdw-wake-up-unavailable");
@@ -311,10 +319,10 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-simplified-clockstopprepare-sm-supported");
 
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
-			&prop->clk_stop_timeout);
+				 &prop->clk_stop_timeout);
 
 	device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
-			&prop->ch_prep_timeout);
+				 &prop->ch_prep_timeout);
 
 	device_property_read_u32(dev,
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
@@ -333,13 +341,13 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-port15-read-behavior", &prop->p15_behave);
 
 	device_property_read_u32(dev, "mipi-sdw-master-count",
-				&prop->master_count);
+				 &prop->master_count);
 
 	device_property_read_u32(dev, "mipi-sdw-source-port-list",
-				&prop->source_ports);
+				 &prop->source_ports);
 
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
-				&prop->sink_ports);
+				 &prop->sink_ports);
 
 	/* Read dp0 properties */
 	port = device_get_named_child_node(dev, "mipi-sdw-dp-0-subproperties");
@@ -348,7 +356,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	} else {
 
 		prop->dp0_prop = devm_kzalloc(&slave->dev,
-				sizeof(*prop->dp0_prop), GFP_KERNEL);
+					      sizeof(*prop->dp0_prop),
+					      GFP_KERNEL);
 		if (!prop->dp0_prop)
 			return -ENOMEM;
 
@@ -364,23 +373,25 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	/* Allocate memory for set bits in port lists */
 	nval = hweight32(prop->source_ports);
 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
-				sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+					  sizeof(*prop->src_dpn_prop),
+					  GFP_KERNEL);
 	if (!prop->src_dpn_prop)
 		return -ENOMEM;
 
 	/* Read dpn properties for source port(s) */
 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
-			prop->source_ports, "source");
+			   prop->source_ports, "source");
 
 	nval = hweight32(prop->sink_ports);
 	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
-				sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+					   sizeof(*prop->sink_dpn_prop),
+					   GFP_KERNEL);
 	if (!prop->sink_dpn_prop)
 		return -ENOMEM;
 
 	/* Read dpn properties for sink port(s) */
 	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
-			prop->sink_ports, "sink");
+			   prop->sink_ports, "sink");
 
 	/* some ports are bidirectional so check total ports by ORing */
 	nval = prop->source_ports | prop->sink_ports;
@@ -388,7 +399,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 
 	/* Allocate port_ready based on num_of_ports */
 	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
-				sizeof(*slave->port_ready), GFP_KERNEL);
+					 sizeof(*slave->port_ready),
+					 GFP_KERNEL);
 	if (!slave->port_ready)
 		return -ENOMEM;
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index ac103bd0c176..f39a5815e25d 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -14,7 +14,7 @@ static void sdw_slave_release(struct device *dev)
 }
 
 static int sdw_slave_add(struct sdw_bus *bus,
-		struct sdw_slave_id *id, struct fwnode_handle *fwnode)
+			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
 {
 	struct sdw_slave *slave;
 	int ret;
@@ -30,8 +30,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
 
 	/* name shall be sdw:link:mfg:part:class:unique */
 	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
-			bus->link_id, id->mfg_id, id->part_id,
-			id->class_id, id->unique_id);
+		     bus->link_id, id->mfg_id, id->part_id,
+		     id->class_id, id->unique_id);
 
 	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
@@ -84,11 +84,11 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 		acpi_status status;
 
 		status = acpi_evaluate_integer(adev->handle,
-					METHOD_NAME__ADR, NULL, &addr);
+					       METHOD_NAME__ADR, NULL, &addr);
 
 		if (ACPI_FAILURE(status)) {
 			dev_err(bus->dev, "_ADR resolution failed: %x\n",
-							status);
+				status);
 			return status;
 		}
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index bd879b1a76c8..e3d2bc5cba80 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -53,9 +53,9 @@ static int sdw_find_row_index(int row)
 	return 0;
 }
 static int _sdw_program_slave_port_params(struct sdw_bus *bus,
-				struct sdw_slave *slave,
-				struct sdw_transport_params *t_params,
-				enum sdw_dpn_type type)
+					  struct sdw_slave *slave,
+					  struct sdw_transport_params *t_params,
+					  enum sdw_dpn_type type)
 {
 	u32 addr1, addr2, addr3, addr4;
 	int ret;
@@ -119,8 +119,8 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 }
 
 static int sdw_program_slave_port_params(struct sdw_bus *bus,
-			struct sdw_slave_runtime *s_rt,
-			struct sdw_port_runtime *p_rt)
+					 struct sdw_slave_runtime *s_rt,
+					 struct sdw_port_runtime *p_rt)
 {
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	struct sdw_port_params *p_params = &p_rt->port_params;
@@ -131,8 +131,8 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 	u8 wbuf;
 
 	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
-					s_rt->direction,
-					t_params->port_num);
+					  s_rt->direction,
+					  t_params->port_num);
 	if (!dpn_prop)
 		return -EINVAL;
 
@@ -216,7 +216,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 
 	if (dpn_prop->type != SDW_DPN_SIMPLE) {
 		ret = _sdw_program_slave_port_params(bus, s_rt->slave,
-						t_params, dpn_prop->type);
+						     t_params, dpn_prop->type);
 		if (ret < 0)
 			dev_err(&s_rt->slave->dev,
 				"Transport reg write failed for port: %d",
@@ -227,7 +227,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 }
 
 static int sdw_program_master_port_params(struct sdw_bus *bus,
-		struct sdw_port_runtime *p_rt)
+					  struct sdw_port_runtime *p_rt)
 {
 	int ret;
 
@@ -244,8 +244,8 @@ static int sdw_program_master_port_params(struct sdw_bus *bus,
 		return ret;
 
 	return bus->port_ops->dpn_set_port_params(bus,
-				&p_rt->port_params,
-				bus->params.next_bank);
+						  &p_rt->port_params,
+						  bus->params.next_bank);
 }
 
 /**
@@ -292,8 +292,9 @@ static int sdw_program_port_params(struct sdw_master_runtime *m_rt)
  * actual enable/disable is done with a bank switch
  */
 static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
-				struct sdw_slave_runtime *s_rt,
-				struct sdw_port_runtime *p_rt, bool en)
+					  struct sdw_slave_runtime *s_rt,
+					  struct sdw_port_runtime *p_rt,
+					  bool en)
 {
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	u32 addr;
@@ -322,7 +323,8 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
 }
 
 static int sdw_enable_disable_master_ports(struct sdw_master_runtime *m_rt,
-			struct sdw_port_runtime *p_rt, bool en)
+					   struct sdw_port_runtime *p_rt,
+					   bool en)
 {
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	struct sdw_bus *bus = m_rt->bus;
@@ -336,7 +338,8 @@ static int sdw_enable_disable_master_ports(struct sdw_master_runtime *m_rt,
 	/* Perform Master port channel(s) enable/disable */
 	if (bus->port_ops->dpn_port_enable_ch) {
 		ret = bus->port_ops->dpn_port_enable_ch(bus,
-				&enable_ch, bus->params.next_bank);
+							&enable_ch,
+							bus->params.next_bank);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"Master chn_en write failed:%d port:%d",
@@ -370,7 +373,7 @@ static int sdw_enable_disable_ports(struct sdw_master_runtime *m_rt, bool en)
 	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 		list_for_each_entry(s_port, &s_rt->port_list, port_node) {
 			ret = sdw_enable_disable_slave_ports(m_rt->bus, s_rt,
-							s_port, en);
+							     s_port, en);
 			if (ret < 0)
 				return ret;
 		}
@@ -387,7 +390,8 @@ static int sdw_enable_disable_ports(struct sdw_master_runtime *m_rt, bool en)
 }
 
 static int sdw_do_port_prep(struct sdw_slave_runtime *s_rt,
-		struct sdw_prepare_ch prep_ch, enum sdw_port_prep_ops cmd)
+			    struct sdw_prepare_ch prep_ch,
+			    enum sdw_port_prep_ops cmd)
 {
 	const struct sdw_slave_ops *ops = s_rt->slave->ops;
 	int ret;
@@ -405,8 +409,9 @@ static int sdw_do_port_prep(struct sdw_slave_runtime *s_rt,
 }
 
 static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
-			struct sdw_slave_runtime *s_rt,
-			struct sdw_port_runtime *p_rt, bool prep)
+				       struct sdw_slave_runtime *s_rt,
+				       struct sdw_port_runtime *p_rt,
+				       bool prep)
 {
 	struct completion *port_ready = NULL;
 	struct sdw_dpn_prop *dpn_prop;
@@ -420,8 +425,8 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	prep_ch.ch_mask = p_rt->ch_mask;
 
 	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
-					s_rt->direction,
-					prep_ch.num);
+					  s_rt->direction,
+					  prep_ch.num);
 	if (!dpn_prop) {
 		dev_err(bus->dev,
 			"Slave Port:%d properties not found", prep_ch.num);
@@ -442,7 +447,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	 */
 	if (prep && intr) {
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-						dpn_prop->device_interrupts);
+					     dpn_prop->device_interrupts);
 		if (ret < 0)
 			return ret;
 	}
@@ -456,7 +461,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 
 		if (prep)
 			ret = sdw_update(s_rt->slave, addr,
-					0xFF, p_rt->ch_mask);
+					 0xFF, p_rt->ch_mask);
 		else
 			ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
 
@@ -486,13 +491,14 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	/* Disable interrupt after Port de-prepare */
 	if (!prep && intr)
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-						dpn_prop->device_interrupts);
+					     dpn_prop->device_interrupts);
 
 	return ret;
 }
 
 static int sdw_prep_deprep_master_ports(struct sdw_master_runtime *m_rt,
-				struct sdw_port_runtime *p_rt, bool prep)
+					struct sdw_port_runtime *p_rt,
+					bool prep)
 {
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	struct sdw_bus *bus = m_rt->bus;
@@ -510,7 +516,7 @@ static int sdw_prep_deprep_master_ports(struct sdw_master_runtime *m_rt,
 		ret = ops->dpn_port_prep(bus, &prep_ch);
 		if (ret < 0) {
 			dev_err(bus->dev, "Port prepare failed for port:%d",
-					t_params->port_num);
+				t_params->port_num);
 			return ret;
 		}
 	}
@@ -535,7 +541,7 @@ static int sdw_prep_deprep_ports(struct sdw_master_runtime *m_rt, bool prep)
 	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
 			ret = sdw_prep_deprep_slave_ports(m_rt->bus, s_rt,
-							p_rt, prep);
+							  p_rt, prep);
 			if (ret < 0)
 				return ret;
 		}
@@ -579,7 +585,7 @@ static int sdw_notify_config(struct sdw_master_runtime *m_rt)
 			ret = slave->ops->bus_config(slave, &bus->params);
 			if (ret < 0)
 				dev_err(bus->dev, "Notify Slave: %d failed",
-								slave->dev_num);
+					slave->dev_num);
 			return ret;
 		}
 	}
@@ -658,7 +664,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 		addr = SDW_SCP_FRAMECTRL_B0;
 
 	sdw_fill_msg(wr_msg, NULL, addr, 1, SDW_BROADCAST_DEV_NUM,
-					SDW_MSG_FLAG_WRITE, wbuf);
+		     SDW_MSG_FLAG_WRITE, wbuf);
 	wr_msg->ssp_sync = true;
 
 	/*
@@ -873,7 +879,7 @@ EXPORT_SYMBOL(sdw_alloc_stream);
 
 static struct sdw_master_runtime
 *sdw_find_master_rt(struct sdw_bus *bus,
-			struct sdw_stream_runtime *stream)
+		    struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = NULL;
 
@@ -897,8 +903,8 @@ static struct sdw_master_runtime
  */
 static struct sdw_master_runtime
 *sdw_alloc_master_rt(struct sdw_bus *bus,
-			struct sdw_stream_config *stream_config,
-			struct sdw_stream_runtime *stream)
+		     struct sdw_stream_config *stream_config,
+		     struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
 
@@ -941,8 +947,8 @@ static struct sdw_master_runtime
  */
 static struct sdw_slave_runtime
 *sdw_alloc_slave_rt(struct sdw_slave *slave,
-			struct sdw_stream_config *stream_config,
-			struct sdw_stream_runtime *stream)
+		    struct sdw_stream_config *stream_config,
+		    struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt = NULL;
 
@@ -959,20 +965,19 @@ static struct sdw_slave_runtime
 }
 
 static void sdw_master_port_release(struct sdw_bus *bus,
-			struct sdw_master_runtime *m_rt)
+				    struct sdw_master_runtime *m_rt)
 {
 	struct sdw_port_runtime *p_rt, *_p_rt;
 
-	list_for_each_entry_safe(p_rt, _p_rt,
-			&m_rt->port_list, port_node) {
+	list_for_each_entry_safe(p_rt, _p_rt, &m_rt->port_list, port_node) {
 		list_del(&p_rt->port_node);
 		kfree(p_rt);
 	}
 }
 
 static void sdw_slave_port_release(struct sdw_bus *bus,
-			struct sdw_slave *slave,
-			struct sdw_stream_runtime *stream)
+				   struct sdw_slave *slave,
+				   struct sdw_stream_runtime *stream)
 {
 	struct sdw_port_runtime *p_rt, *_p_rt;
 	struct sdw_master_runtime *m_rt;
@@ -985,7 +990,7 @@ static void sdw_slave_port_release(struct sdw_bus *bus,
 				continue;
 
 			list_for_each_entry_safe(p_rt, _p_rt,
-					&s_rt->port_list, port_node) {
+						 &s_rt->port_list, port_node) {
 
 				list_del(&p_rt->port_node);
 				kfree(p_rt);
@@ -1003,7 +1008,7 @@ static void sdw_slave_port_release(struct sdw_bus *bus,
  * This function is to be called with bus_lock held.
  */
 static void sdw_release_slave_stream(struct sdw_slave *slave,
-			struct sdw_stream_runtime *stream)
+				     struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 	struct sdw_master_runtime *m_rt;
@@ -1011,7 +1016,7 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		/* Retrieve Slave runtime handle */
 		list_for_each_entry_safe(s_rt, _s_rt,
-					&m_rt->slave_rt_list, m_rt_node) {
+					 &m_rt->slave_rt_list, m_rt_node) {
 
 			if (s_rt->slave == slave) {
 				list_del(&s_rt->m_rt_node);
@@ -1034,7 +1039,7 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
  * no effect as Slave(s) runtime handle would already be freed up.
  */
 static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
-			struct sdw_stream_runtime *stream)
+				      struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
@@ -1057,14 +1062,14 @@ static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
  * This removes and frees port_rt and master_rt from a stream
  */
 int sdw_stream_remove_master(struct sdw_bus *bus,
-		struct sdw_stream_runtime *stream)
+			     struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt, *_m_rt;
 
 	mutex_lock(&bus->bus_lock);
 
 	list_for_each_entry_safe(m_rt, _m_rt,
-			&stream->master_list, stream_node) {
+				 &stream->master_list, stream_node) {
 
 		if (m_rt->bus != bus)
 			continue;
@@ -1092,7 +1097,7 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  * This removes and frees port_rt and slave_rt from a stream
  */
 int sdw_stream_remove_slave(struct sdw_slave *slave,
-		struct sdw_stream_runtime *stream)
+			    struct sdw_stream_runtime *stream)
 {
 	mutex_lock(&slave->bus->bus_lock);
 
@@ -1116,8 +1121,9 @@ EXPORT_SYMBOL(sdw_stream_remove_slave);
  * This function is to be called with bus_lock held.
  */
 static int sdw_config_stream(struct device *dev,
-		struct sdw_stream_runtime *stream,
-		struct sdw_stream_config *stream_config, bool is_slave)
+			     struct sdw_stream_runtime *stream,
+			     struct sdw_stream_config *stream_config,
+			     bool is_slave)
 {
 	/*
 	 * Update the stream rate, channel and bps based on data
@@ -1128,13 +1134,13 @@ static int sdw_config_stream(struct device *dev,
 	 * comparison and allow the value to be set and stored in stream
 	 */
 	if (stream->params.rate &&
-			stream->params.rate != stream_config->frame_rate) {
+	    stream->params.rate != stream_config->frame_rate) {
 		dev_err(dev, "rate not matching, stream:%s", stream->name);
 		return -EINVAL;
 	}
 
 	if (stream->params.bps &&
-			stream->params.bps != stream_config->bps) {
+	    stream->params.bps != stream_config->bps) {
 		dev_err(dev, "bps not matching, stream:%s", stream->name);
 		return -EINVAL;
 	}
@@ -1151,7 +1157,7 @@ static int sdw_config_stream(struct device *dev,
 }
 
 static int sdw_is_valid_port_range(struct device *dev,
-				struct sdw_port_runtime *p_rt)
+				   struct sdw_port_runtime *p_rt)
 {
 	if (!SDW_VALID_PORT_RANGE(p_rt->num)) {
 		dev_err(dev,
@@ -1162,9 +1168,10 @@ static int sdw_is_valid_port_range(struct device *dev,
 	return 0;
 }
 
-static struct sdw_port_runtime *sdw_port_alloc(struct device *dev,
-				struct sdw_port_config *port_config,
-				int port_index)
+static struct sdw_port_runtime
+*sdw_port_alloc(struct device *dev,
+		struct sdw_port_config *port_config,
+		int port_index)
 {
 	struct sdw_port_runtime *p_rt;
 
@@ -1179,9 +1186,9 @@ static struct sdw_port_runtime *sdw_port_alloc(struct device *dev,
 }
 
 static int sdw_master_port_config(struct sdw_bus *bus,
-			struct sdw_master_runtime *m_rt,
-			struct sdw_port_config *port_config,
-			unsigned int num_ports)
+				  struct sdw_master_runtime *m_rt,
+				  struct sdw_port_config *port_config,
+				  unsigned int num_ports)
 {
 	struct sdw_port_runtime *p_rt;
 	int i;
@@ -1204,9 +1211,9 @@ static int sdw_master_port_config(struct sdw_bus *bus,
 }
 
 static int sdw_slave_port_config(struct sdw_slave *slave,
-			struct sdw_slave_runtime *s_rt,
-			struct sdw_port_config *port_config,
-			unsigned int num_config)
+				 struct sdw_slave_runtime *s_rt,
+				 struct sdw_port_config *port_config,
+				 unsigned int num_config)
 {
 	struct sdw_port_runtime *p_rt;
 	int i, ret;
@@ -1248,10 +1255,10 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
  * @stream: SoundWire stream
  */
 int sdw_stream_add_master(struct sdw_bus *bus,
-		struct sdw_stream_config *stream_config,
-		struct sdw_port_config *port_config,
-		unsigned int num_ports,
-		struct sdw_stream_runtime *stream)
+			  struct sdw_stream_config *stream_config,
+			  struct sdw_port_config *port_config,
+			  unsigned int num_ports,
+			  struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = NULL;
 	int ret;
@@ -1273,8 +1280,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
 	if (!m_rt) {
 		dev_err(bus->dev,
-				"Master runtime config failed for stream:%s",
-				stream->name);
+			"Master runtime config failed for stream:%s",
+			stream->name);
 		ret = -ENOMEM;
 		goto unlock;
 	}
@@ -1313,10 +1320,10 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  *
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
-		struct sdw_stream_config *stream_config,
-		struct sdw_port_config *port_config,
-		unsigned int num_ports,
-		struct sdw_stream_runtime *stream)
+			 struct sdw_stream_config *stream_config,
+			 struct sdw_port_config *port_config,
+			 unsigned int num_ports,
+			 struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_master_runtime *m_rt;
@@ -1331,8 +1338,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	m_rt = sdw_alloc_master_rt(slave->bus, stream_config, stream);
 	if (!m_rt) {
 		dev_err(&slave->dev,
-				"alloc master runtime failed for stream:%s",
-				stream->name);
+			"alloc master runtime failed for stream:%s",
+			stream->name);
 		ret = -ENOMEM;
 		goto error;
 	}
@@ -1340,8 +1347,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	s_rt = sdw_alloc_slave_rt(slave, stream_config, stream);
 	if (!s_rt) {
 		dev_err(&slave->dev,
-				"Slave runtime config failed for stream:%s",
-				stream->name);
+			"Slave runtime config failed for stream:%s",
+			stream->name);
 		ret = -ENOMEM;
 		goto stream_error;
 	}
@@ -1385,8 +1392,8 @@ EXPORT_SYMBOL(sdw_stream_add_slave);
  * @port_num: Port number
  */
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
-				enum sdw_data_direction direction,
-				unsigned int port_num)
+					    enum sdw_data_direction direction,
+					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
 	u8 num_ports;
@@ -1501,7 +1508,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		ret = sdw_prep_deprep_ports(m_rt, true);
 		if (ret < 0) {
 			dev_err(bus->dev, "Prepare port(s) failed ret = %d",
-					ret);
+				ret);
 			return ret;
 		}
 	}
-- 
2.17.1

