Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CF1ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0278A2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfJALjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:17382 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732591AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="220968923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C456300; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/22] thunderbolt: Add support for lane bonding
Date:   Tue,  1 Oct 2019 14:38:14 +0300
Message-Id: <20191001113830.13028-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lane bonding allows aggregating the two 10/20 Gb/s (depending on the
generation) lanes into a single 20/40 Gb/s bonded link. This allows
sharing the full bandwidth more efficiently. In order to establish lane
bonding we need to check that the lane bonding is possible through LC
and that both end of the link actually supports 2x widths. This also
means that all the paths should be established through the primary port
so update tb_path_alloc() to handle this as well.

Lane bonding is supported starting from Falcon Ridge (2nd generation)
controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         |  17 ++
 drivers/thunderbolt/icm.c                     |  18 +-
 drivers/thunderbolt/lc.c                      |  28 ++
 drivers/thunderbolt/path.c                    |  30 +-
 drivers/thunderbolt/switch.c                  | 274 ++++++++++++++++++
 drivers/thunderbolt/tb.c                      |  21 ++
 drivers/thunderbolt/tb.h                      |  10 +
 drivers/thunderbolt/tb_msgs.h                 |   2 +
 drivers/thunderbolt/tb_regs.h                 |  20 ++
 drivers/thunderbolt/tunnel.c                  |  19 +-
 10 files changed, 429 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index b21fba14689b..2c9166f6fa97 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -104,6 +104,23 @@ Contact:	thunderbolt-software@lists.01.org
 Description:	This attribute contains name of this device extracted from
 		the device DROM.
 
+What:		/sys/bus/thunderbolt/devices/.../link_speed
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Description:	This attribute reports the current upstream link speed
+		in Gb/s per lane. If there are two lanes they both are
+		running at the same speed. Use link_width to determine
+		whether the two lanes are bonded or not.
+
+What:		/sys/bus/thunderbolt/devices/.../link_width
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Description:	This attribute reports the current upstream link width.
+		It is 1 for single lane link (or two single lane links)
+		and 2 for bonded dual lane link.
+
 What:		/sys/bus/thunderbolt/devices/.../vendor
 Date:		Sep 2017
 KernelVersion:	4.13
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6550f68f92ce..9c9c6ea2b790 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -567,7 +567,8 @@ static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
 				    size_t ep_name_size, u8 connection_id,
 				    u8 connection_key, u8 link, u8 depth,
 				    enum tb_security_level security_level,
-				    bool authorized, bool boot)
+				    bool authorized, bool boot, bool dual_lane,
+				    bool speed_gen3)
 {
 	const struct intel_vss *vss;
 	struct tb_switch *sw;
@@ -592,6 +593,8 @@ static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
 	sw->authorized = authorized;
 	sw->security_level = security_level;
 	sw->boot = boot;
+	sw->link_speed = speed_gen3 ? 20 : 10;
+	sw->link_width = dual_lane ? 2 : 1;
 	init_completion(&sw->rpm_complete);
 
 	vss = parse_intel_vss(ep_name, ep_name_size);
@@ -697,11 +700,11 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		(const struct icm_fr_event_device_connected *)hdr;
 	enum tb_security_level security_level;
 	struct tb_switch *sw, *parent_sw;
+	bool boot, dual_lane, speed_gen3;
 	struct icm *icm = tb_priv(tb);
 	bool authorized = false;
 	struct tb_xdomain *xd;
 	u8 link, depth;
-	bool boot;
 	u64 route;
 	int ret;
 
@@ -714,6 +717,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
 			 ICM_FLAGS_SLEVEL_SHIFT;
 	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
+	dual_lane = pkg->hdr.flags & ICM_FLAGS_DUAL_LANE;
+	speed_gen3 = pkg->hdr.flags & ICM_FLAGS_SPEED_GEN3;
 
 	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
 		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
@@ -814,7 +819,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
 		   sizeof(pkg->ep_name), pkg->connection_id,
 		   pkg->connection_key, link, depth, security_level,
-		   authorized, boot);
+		   authorized, boot, dual_lane, speed_gen3);
 
 	tb_switch_put(parent_sw);
 }
@@ -1142,10 +1147,10 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 {
 	const struct icm_tr_event_device_connected *pkg =
 		(const struct icm_tr_event_device_connected *)hdr;
+	bool authorized, boot, dual_lane, speed_gen3;
 	enum tb_security_level security_level;
 	struct tb_switch *sw, *parent_sw;
 	struct tb_xdomain *xd;
-	bool authorized, boot;
 	u64 route;
 
 	icm_postpone_rescan(tb);
@@ -1163,6 +1168,8 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
 			 ICM_FLAGS_SLEVEL_SHIFT;
 	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
+	dual_lane = pkg->hdr.flags & ICM_FLAGS_DUAL_LANE;
+	speed_gen3 = pkg->hdr.flags & ICM_FLAGS_SPEED_GEN3;
 
 	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
 		tb_info(tb, "switch at %llx was rejected by ICM firmware because topology limit exceeded\n",
@@ -1207,7 +1214,8 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 
 	sw = add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
 			sizeof(pkg->ep_name), pkg->connection_id, 0, 0, 0,
-			security_level, authorized, boot);
+			security_level, authorized, boot, dual_lane,
+			speed_gen3);
 	if (!IS_ERR(sw) && force_rtd3)
 		sw->rpm = true;
 
diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index af38076088f6..df56523eb822 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -177,3 +177,31 @@ int tb_lc_set_sleep(struct tb_switch *sw)
 
 	return 0;
 }
+
+/**
+ * tb_lc_lane_bonding_possible() - Is lane bonding possible towards switch
+ * @sw: Switch to check
+ *
+ * Checks whether conditions for lane bonding from parent to @sw are
+ * possible.
+ */
+bool tb_lc_lane_bonding_possible(struct tb_switch *sw)
+{
+	struct tb_port *up;
+	int cap, ret;
+	u32 val;
+
+	if (sw->generation < 2)
+		return false;
+
+	up = tb_upstream_port(sw);
+	cap = find_port_lc_cap(up);
+	if (cap < 0)
+		return false;
+
+	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_ATTR, 1);
+	if (ret)
+		return false;
+
+	return !!(val & TB_LC_PORT_ATTR_BE);
+}
diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index afe5f8391ebf..6cf66597d5d8 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -220,7 +220,8 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
  * Creates path between two ports starting with given @src_hopid. Reserves
  * HopIDs for each port (they can be different from @src_hopid depending on
  * how many HopIDs each port already have reserved). If there are dual
- * links on the path, prioritizes using @link_nr.
+ * links on the path, prioritizes using @link_nr but takes into account
+ * that the lanes may be bonded.
  *
  * Return: Returns a tb_path on success or NULL on failure.
  */
@@ -259,7 +260,9 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 		if (!in_port)
 			goto err;
 
-		if (in_port->dual_link_port && in_port->link_nr != link_nr)
+		/* When lanes are bonded primary link must be used */
+		if (!in_port->bonded && in_port->dual_link_port &&
+		    in_port->link_nr != link_nr)
 			in_port = in_port->dual_link_port;
 
 		ret = tb_port_alloc_in_hopid(in_port, in_hopid, in_hopid);
@@ -271,8 +274,27 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 		if (!out_port)
 			goto err;
 
-		if (out_port->dual_link_port && out_port->link_nr != link_nr)
-			out_port = out_port->dual_link_port;
+		/*
+		 * Pick up right port when going from non-bonded to
+		 * bonded or from bonded to non-bonded.
+		 */
+		if (out_port->dual_link_port) {
+			if (!in_port->bonded && out_port->bonded &&
+			    out_port->link_nr) {
+				/*
+				 * Use primary link when going from
+				 * non-bonded to bonded.
+				 */
+				out_port = out_port->dual_link_port;
+			} else if (!out_port->bonded &&
+				   out_port->link_nr != link_nr) {
+				/*
+				 * If out port is not bonded follow
+				 * link_nr.
+				 */
+				out_port = out_port->dual_link_port;
+			}
+		}
 
 		if (i == num_hops - 1)
 			ret = tb_port_alloc_out_hopid(out_port, dst_hopid,
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cc2670dd2698..2b00ea7a979a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -775,6 +775,132 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
 	return next;
 }
 
+static int tb_port_get_link_speed(struct tb_port *port)
+{
+	u32 val, speed;
+	int ret;
+
+	if (!port->cap_phy)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_1, 1);
+	if (ret)
+		return ret;
+
+	speed = (val & LANE_ADP_CS_1_CURRENT_SPEED_MASK) >>
+		LANE_ADP_CS_1_CURRENT_SPEED_SHIFT;
+	return speed == LANE_ADP_CS_1_CURRENT_SPEED_GEN3 ? 20 : 10;
+}
+
+static int tb_port_get_link_width(struct tb_port *port)
+{
+	u32 val;
+	int ret;
+
+	if (!port->cap_phy)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_1, 1);
+	if (ret)
+		return ret;
+
+	return (val & LANE_ADP_CS_1_CURRENT_WIDTH_MASK) >>
+		LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT;
+}
+
+static bool tb_port_is_width_supported(struct tb_port *port, int width)
+{
+	u32 phy, widths;
+	int ret;
+
+	if (!port->cap_phy)
+		return false;
+
+	ret = tb_port_read(port, &phy, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_0, 1);
+	if (ret)
+		return ret;
+
+	widths = (phy & LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK) >>
+		LANE_ADP_CS_0_SUPPORTED_WIDTH_SHIFT;
+
+	return !!(widths & width);
+}
+
+static int tb_port_set_link_width(struct tb_port *port, unsigned int width)
+{
+	u32 val;
+	int ret;
+
+	if (!port->cap_phy)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_1, 1);
+	if (ret)
+		return ret;
+
+	val &= ~LANE_ADP_CS_1_TARGET_WIDTH_MASK;
+	switch (width) {
+	case 1:
+		val |= LANE_ADP_CS_1_TARGET_WIDTH_SINGLE <<
+			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
+		break;
+	case 2:
+		val |= LANE_ADP_CS_1_TARGET_WIDTH_DUAL <<
+			LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val |= LANE_ADP_CS_1_LB;
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_phy + LANE_ADP_CS_1, 1);
+}
+
+static int tb_port_lane_bonding_enable(struct tb_port *port)
+{
+	int ret;
+
+	/*
+	 * Enable lane bonding for both links if not already enabled by
+	 * for example the boot firmware.
+	 */
+	ret = tb_port_get_link_width(port);
+	if (ret == 1) {
+		ret = tb_port_set_link_width(port, 2);
+		if (ret)
+			return ret;
+	}
+
+	ret = tb_port_get_link_width(port->dual_link_port);
+	if (ret == 1) {
+		ret = tb_port_set_link_width(port->dual_link_port, 2);
+		if (ret) {
+			tb_port_set_link_width(port, 1);
+			return ret;
+		}
+	}
+
+	port->bonded = true;
+	port->dual_link_port->bonded = true;
+
+	return 0;
+}
+
+static void tb_port_lane_bonding_disable(struct tb_port *port)
+{
+	port->dual_link_port->bonded = false;
+	port->bonded = false;
+
+	tb_port_set_link_width(port->dual_link_port, 1);
+	tb_port_set_link_width(port, 1);
+}
+
 /**
  * tb_port_is_enabled() - Is the adapter port enabled
  * @port: Port to check
@@ -1166,6 +1292,26 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(key, 0600, key_show, key_store);
 
+static ssize_t link_speed_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	return sprintf(buf, "%u.0 Gb/s\n", sw->link_speed);
+
+}
+static DEVICE_ATTR_RO(link_speed);
+
+static ssize_t link_width_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	return sprintf(buf, "%u\n", sw->link_width);
+
+}
+static DEVICE_ATTR_RO(link_width);
+
 static void nvm_authenticate_start(struct tb_switch *sw)
 {
 	struct pci_dev *root_port;
@@ -1320,6 +1466,8 @@ static struct attribute *switch_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_device_name.attr,
 	&dev_attr_key.attr,
+	&dev_attr_link_speed.attr,
+	&dev_attr_link_width.attr,
 	&dev_attr_nvm_authenticate.attr,
 	&dev_attr_nvm_version.attr,
 	&dev_attr_vendor.attr,
@@ -1352,6 +1500,11 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 		    sw->security_level == TB_SECURITY_SECURE)
 			return attr->mode;
 		return 0;
+	} else if (attr == &dev_attr_link_speed.attr ||
+		   attr == &dev_attr_link_width.attr) {
+		if (tb_route(sw))
+			return attr->mode;
+		return 0;
 	} else if (attr == &dev_attr_nvm_authenticate.attr) {
 		if (sw->dma_port && !sw->no_nvm_upgrade)
 			return attr->mode;
@@ -1751,6 +1904,123 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 	return -ESHUTDOWN;
 }
 
+static bool tb_switch_lane_bonding_possible(struct tb_switch *sw)
+{
+	const struct tb_port *up = tb_upstream_port(sw);
+
+	if (!up->dual_link_port || !up->dual_link_port->remote)
+		return false;
+
+	return tb_lc_lane_bonding_possible(sw);
+}
+
+static int tb_switch_update_link_attributes(struct tb_switch *sw)
+{
+	struct tb_port *up;
+	bool change = false;
+	int ret;
+
+	if (!tb_route(sw) || tb_switch_is_icm(sw))
+		return 0;
+
+	up = tb_upstream_port(sw);
+
+	ret = tb_port_get_link_speed(up);
+	if (ret < 0)
+		return ret;
+	if (sw->link_speed != ret)
+		change = true;
+	sw->link_speed = ret;
+
+	ret = tb_port_get_link_width(up);
+	if (ret < 0)
+		return ret;
+	if (sw->link_width != ret)
+		change = true;
+	sw->link_width = ret;
+
+	/* Notify userspace that there is possible link attribute change */
+	if (device_is_registered(&sw->dev) && change)
+		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+
+	return 0;
+}
+
+/**
+ * tb_switch_lane_bonding_enable() - Enable lane bonding
+ * @sw: Switch to enable lane bonding
+ *
+ * Connection manager can call this function to enable lane bonding of a
+ * switch. If conditions are correct and both switches support the feature,
+ * lanes are bonded. It is safe to call this to any switch.
+ */
+int tb_switch_lane_bonding_enable(struct tb_switch *sw)
+{
+	struct tb_switch *parent = tb_to_switch(sw->dev.parent);
+	struct tb_port *up, *down;
+	u64 route = tb_route(sw);
+	int ret;
+
+	if (!route)
+		return 0;
+
+	if (!tb_switch_lane_bonding_possible(sw))
+		return 0;
+
+	up = tb_upstream_port(sw);
+	down = tb_port_at(route, parent);
+
+	if (!tb_port_is_width_supported(up, 2) ||
+	    !tb_port_is_width_supported(down, 2))
+		return 0;
+
+	ret = tb_port_lane_bonding_enable(up);
+	if (ret) {
+		tb_port_warn(up, "failed to enable lane bonding\n");
+		return ret;
+	}
+
+	ret = tb_port_lane_bonding_enable(down);
+	if (ret) {
+		tb_port_warn(down, "failed to enable lane bonding\n");
+		tb_port_lane_bonding_disable(up);
+		return ret;
+	}
+
+	tb_switch_update_link_attributes(sw);
+
+	tb_sw_dbg(sw, "lane bonding enabled\n");
+	return ret;
+}
+
+/**
+ * tb_switch_lane_bonding_disable() - Disable lane bonding
+ * @sw: Switch whose lane bonding to disable
+ *
+ * Disables lane bonding between @sw and parent. This can be called even
+ * if lanes were not bonded originally.
+ */
+void tb_switch_lane_bonding_disable(struct tb_switch *sw)
+{
+	struct tb_switch *parent = tb_to_switch(sw->dev.parent);
+	struct tb_port *up, *down;
+
+	if (!tb_route(sw))
+		return;
+
+	up = tb_upstream_port(sw);
+	if (!up->bonded)
+		return;
+
+	down = tb_port_at(tb_route(sw), parent);
+
+	tb_port_lane_bonding_disable(up);
+	tb_port_lane_bonding_disable(down);
+
+	tb_switch_update_link_attributes(sw);
+	tb_sw_dbg(sw, "lane bonding disabled\n");
+}
+
 /**
  * tb_switch_add() - Add a switch to the domain
  * @sw: Switch to add
@@ -1800,6 +2070,10 @@ int tb_switch_add(struct tb_switch *sw)
 			if (ret)
 				return ret;
 		}
+
+		ret = tb_switch_update_link_attributes(sw);
+		if (ret)
+			return ret;
 	}
 
 	ret = device_add(&sw->dev);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index ab42f0fea787..dbbe9afb9fb7 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -219,6 +219,10 @@ static void tb_scan_port(struct tb_port *port)
 		upstream_port->dual_link_port->remote = port->dual_link_port;
 	}
 
+	/* Enable lane bonding if supported */
+	if (tb_switch_lane_bonding_enable(sw))
+		tb_sw_warn(sw, "failed to enable lane bonding\n");
+
 	tb_scan_switch(sw);
 }
 
@@ -271,6 +275,7 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 		struct tb_port *port = &sw->ports[i];
 
 		if (port->remote->sw->is_unplugged) {
+			tb_switch_lane_bonding_disable(port->remote->sw);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 			if (port->dual_link_port)
@@ -536,6 +541,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_port_dbg(port, "switch unplugged\n");
 			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
+			tb_switch_lane_bonding_disable(port->remote->sw);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 			if (port->dual_link_port)
@@ -705,6 +711,20 @@ static int tb_suspend_noirq(struct tb *tb)
 	return 0;
 }
 
+static void tb_restore_children(struct tb_switch *sw)
+{
+	int i;
+
+	tb_switch_for_each_remote_port(sw, i) {
+		struct tb_port *port = &sw->ports[i];
+
+		if (tb_switch_lane_bonding_enable(port->remote->sw))
+			dev_warn(&sw->dev, "failed to restore lane bonding\n");
+
+		tb_restore_children(port->remote->sw);
+	}
+}
+
 static int tb_resume_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -718,6 +738,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_switch_resume(tb->root_switch);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
+	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_restart(tunnel);
 	if (!list_empty(&tcm->tunnel_list)) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index b723b86f4e72..e641dcebd50a 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -61,6 +61,8 @@ struct tb_switch_nvm {
  * @device: Device ID of the switch
  * @vendor_name: Name of the vendor (or %NULL if not known)
  * @device_name: Name of the device (or %NULL if not known)
+ * @link_speed: Speed of the link in Gb/s
+ * @link_width: Width of the link (1 or 2)
  * @generation: Switch Thunderbolt generation
  * @cap_plug_events: Offset to the plug events capability (%0 if not found)
  * @cap_lc: Offset to the link controller capability (%0 if not found)
@@ -97,6 +99,8 @@ struct tb_switch {
 	u16 device;
 	const char *vendor_name;
 	const char *device_name;
+	unsigned int link_speed;
+	unsigned int link_width;
 	unsigned int generation;
 	int cap_plug_events;
 	int cap_lc;
@@ -127,6 +131,7 @@ struct tb_switch {
  * @cap_adap: Offset of the adapter specific capability (%0 if not present)
  * @port: Port number on switch
  * @disabled: Disabled by eeprom
+ * @bonded: true if the port is bonded (two lanes combined as one)
  * @dual_link_port: If the switch is connected using two ports, points
  *		    to the other port.
  * @link_nr: Is this primary or secondary port on the dual_link.
@@ -142,6 +147,7 @@ struct tb_port {
 	int cap_adap;
 	u8 port;
 	bool disabled;
+	bool bonded;
 	struct tb_port *dual_link_port;
 	u8 link_nr:1;
 	struct ida in_hopids;
@@ -640,6 +646,9 @@ static inline bool tb_switch_is_icm(const struct tb_switch *sw)
 	return !sw->config.enabled;
 }
 
+int tb_switch_lane_bonding_enable(struct tb_switch *sw);
+void tb_switch_lane_bonding_disable(struct tb_switch *sw);
+
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_set_initial_credits(struct tb_port *port, u32 credits);
@@ -683,6 +692,7 @@ int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
 int tb_lc_configure_link(struct tb_switch *sw);
 void tb_lc_unconfigure_link(struct tb_switch *sw);
 int tb_lc_set_sleep(struct tb_switch *sw);
+bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
 
 static inline int tb_route_length(u64 route)
 {
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 4b641e4ee0c5..3705057723b6 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -122,6 +122,8 @@ struct icm_pkg_header {
 #define ICM_FLAGS_NO_KEY		BIT(1)
 #define ICM_FLAGS_SLEVEL_SHIFT		3
 #define ICM_FLAGS_SLEVEL_MASK		GENMASK(4, 3)
+#define ICM_FLAGS_DUAL_LANE		BIT(5)
+#define ICM_FLAGS_SPEED_GEN3		BIT(7)
 #define ICM_FLAGS_WRITE			BIT(7)
 
 struct icm_pkg_driver_ready {
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index deb9d4a977b9..6d4e072f1f63 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -219,6 +219,23 @@ struct tb_regs_port_header {
 #define TB_PORT_LCA_SHIFT		22
 #define TB_PORT_LCA_MASK		GENMASK(28, 22)
 
+/* Lane adapter registers */
+#define LANE_ADP_CS_0				0x00
+#define LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK	GENMASK(25, 20)
+#define LANE_ADP_CS_0_SUPPORTED_WIDTH_SHIFT	20
+#define LANE_ADP_CS_1				0x01
+#define LANE_ADP_CS_1_TARGET_WIDTH_MASK		GENMASK(9, 4)
+#define LANE_ADP_CS_1_TARGET_WIDTH_SHIFT	4
+#define LANE_ADP_CS_1_TARGET_WIDTH_SINGLE	0x1
+#define LANE_ADP_CS_1_TARGET_WIDTH_DUAL		0x3
+#define LANE_ADP_CS_1_LB			BIT(15)
+#define LANE_ADP_CS_1_CURRENT_SPEED_MASK	GENMASK(19, 16)
+#define LANE_ADP_CS_1_CURRENT_SPEED_SHIFT	16
+#define LANE_ADP_CS_1_CURRENT_SPEED_GEN2	0x8
+#define LANE_ADP_CS_1_CURRENT_SPEED_GEN3	0x4
+#define LANE_ADP_CS_1_CURRENT_WIDTH_MASK	GENMASK(25, 20)
+#define LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT	20
+
 /* Display Port adapter registers */
 
 /* DWORD 0 */
@@ -280,6 +297,9 @@ struct tb_regs_hop {
 #define TB_LC_FUSE			0x03
 
 /* Link controller registers */
+#define TB_LC_PORT_ATTR			0x8d
+#define TB_LC_PORT_ATTR_BE		BIT(12)
+
 #define TB_LC_SX_CTRL			0x96
 #define TB_LC_SX_CTRL_L1C		BIT(16)
 #define TB_LC_SX_CTRL_L2C		BIT(20)
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 5a99234826e7..ff55a114825a 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -90,6 +90,22 @@ static int tb_pci_activate(struct tb_tunnel *tunnel, bool activate)
 	return 0;
 }
 
+static int tb_initial_credits(const struct tb_switch *sw)
+{
+	/* If the path is complete sw is not NULL */
+	if (sw) {
+		/* More credits for faster link */
+		switch (sw->link_speed * sw->link_width) {
+		case 40:
+			return 32;
+		case 20:
+			return 24;
+		}
+	}
+
+	return 16;
+}
+
 static void tb_pci_init_path(struct tb_path *path)
 {
 	path->egress_fc_enable = TB_PATH_SOURCE | TB_PATH_INTERNAL;
@@ -101,7 +117,8 @@ static void tb_pci_init_path(struct tb_path *path)
 	path->drop_packages = 0;
 	path->nfc_credits = 0;
 	path->hops[0].initial_credits = 7;
-	path->hops[1].initial_credits = 16;
+	path->hops[1].initial_credits =
+		tb_initial_credits(path->hops[1].in_port->sw);
 }
 
 /**
-- 
2.23.0

