Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2344BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE79E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfC1MiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:31885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="129431626"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1365E1608; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 26/36] thunderbolt: Add support for Display Port tunnels
Date:   Thu, 28 Mar 2019 15:36:23 +0300
Message-Id: <20190328123633.42882-27-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display Port tunnels are somewhat more complex than PCIe tunnels as it
requires 3 tunnels (AUX Rx/Tx and Video). In addition we are not
supposed to create the tunnels immediately when a DP OUT is enumerated.
Instead we need to wait until we get hotplug event to that adapter port
or check if the port has HPD set before tunnels can be established. This
adds Display Port tunneling support to the software connection manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 111 ++++++++++++++
 drivers/thunderbolt/tb.c      | 129 +++++++++++++---
 drivers/thunderbolt/tb.h      |  17 +++
 drivers/thunderbolt/tb_regs.h |  22 +++
 drivers/thunderbolt/tunnel.c  | 277 +++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tunnel.h  |  23 +++
 6 files changed, 554 insertions(+), 25 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 9462e6982061..1de1afa24182 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -747,6 +747,10 @@ bool tb_port_is_enabled(struct tb_port *port)
 	case TB_TYPE_PCIE_DOWN:
 		return tb_pci_port_is_enabled(port);
 
+	case TB_TYPE_DP_HDMI_IN:
+	case TB_TYPE_DP_HDMI_OUT:
+		return tb_dp_port_is_enabled(port);
+
 	default:
 		return false;
 	}
@@ -779,6 +783,113 @@ int tb_pci_port_enable(struct tb_port *port, bool enable)
 	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
 }
 
+/**
+ * tb_dp_port_hpd_is_active() - Is HPD already active
+ * @port: DP out port to check
+ *
+ * Checks if the DP OUT adapter port has HDP bit already set.
+ */
+int tb_dp_port_hpd_is_active(struct tb_port *port)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 2, 1);
+	if (ret)
+		return ret;
+
+	return !!(data & TB_DP_HDP);
+}
+
+/**
+ * tb_dp_port_hpd_clear() - Clear HPD from DP IN port
+ * @port: Port to clear HPD
+ *
+ * If the DP IN port has HDP set, this function can be used to clear it.
+ */
+int tb_dp_port_hpd_clear(struct tb_port *port)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+	if (ret)
+		return ret;
+
+	data |= TB_DP_HPDC;
+	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+}
+
+/**
+ * tb_dp_port_set_hops() - Set video/aux Hop IDs for DP port
+ * @port: DP IN/OUT port to set hops
+ * @video: Video Hop ID
+ * @aux_tx: AUX TX Hop ID
+ * @aux_rx: AUX RX Hop ID
+ *
+ * Programs specified Hop IDs for DP IN/OUT port.
+ */
+int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
+			unsigned int aux_tx, unsigned int aux_rx)
+{
+	u32 data[2];
+	int ret;
+
+	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
+			   ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	data[0] &= ~TB_DP_VIDEO_HOPID_MASK;
+	data[1] &= ~(TB_DP_AUX_RX_HOPID_MASK | TB_DP_AUX_TX_HOPID_MASK);
+
+	data[0] |= (video << TB_DP_VIDEO_HOPID_SHIFT) & TB_DP_VIDEO_HOPID_MASK;
+	data[1] |= aux_tx & TB_DP_AUX_TX_HOPID_MASK;
+	data[1] |= (aux_rx << TB_DP_AUX_RX_HOPID_SHIFT) & TB_DP_AUX_RX_HOPID_MASK;
+
+	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
+			     ARRAY_SIZE(data));
+}
+
+/**
+ * tb_dp_port_is_enabled() - Is DP adapter port enabled
+ * @port: DP adapter port to check
+ */
+bool tb_dp_port_is_enabled(struct tb_port *port)
+{
+	u32 data;
+
+	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+		return false;
+
+	return !!(data & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
+}
+
+/**
+ * tb_dp_port_enable() - Enables/disables DP paths of a port
+ * @port: DP IN/OUT port
+ * @enable: Enable/disable DP path
+ *
+ * Once Hop IDs are programmed DP paths can be enabled or disabled by
+ * calling this function.
+ */
+int tb_dp_port_enable(struct tb_port *port, bool enable)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+	if (ret)
+		return ret;
+
+	if (enable)
+		data |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
+	else
+		data &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
+
+	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+}
+
 /* switch utility functions */
 
 static void tb_dump_switch(struct tb *tb, struct tb_regs_switch_header *sw)
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 903922a16d64..c5e96e7ac37a 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -28,6 +28,32 @@ struct tb_cm {
 	bool hotplug_active;
 };
 
+struct tb_hotplug_event {
+	struct work_struct work;
+	struct tb *tb;
+	u64 route;
+	u8 port;
+	bool unplug;
+};
+
+static void tb_handle_hotplug(struct work_struct *work);
+
+static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
+{
+	struct tb_hotplug_event *ev;
+
+	ev = kmalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return;
+
+	ev->tb = tb;
+	ev->route = route;
+	ev->port = port;
+	ev->unplug = unplug;
+	INIT_WORK(&ev->work, tb_handle_hotplug);
+	queue_work(tb->wq, &ev->work);
+}
+
 /* enumeration & hot plug handling */
 
 static void tb_discover_tunnels(struct tb_switch *sw)
@@ -42,6 +68,10 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 
 		port = &sw->ports[i];
 		switch (port->config.type) {
+		case TB_TYPE_DP_HDMI_IN:
+			tunnel = tb_tunnel_discover_dp(tb, port);
+			break;
+
 		case TB_TYPE_PCIE_DOWN:
 			tunnel = tb_tunnel_discover_pci(tb, port);
 			break;
@@ -50,16 +80,19 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 			break;
 		}
 
-		if (tunnel) {
+		if (!tunnel)
+			continue;
+
+		if (tb_tunnel_is_pci(tunnel)) {
 			struct tb_switch *parent = tunnel->dst_port->sw;
 
 			while (parent != tunnel->src_port->sw) {
 				parent->boot = true;
 				parent = tb_switch_parent(parent);
 			}
-
-			list_add_tail(&tunnel->list, &tcm->tunnel_list);
 		}
+
+		list_add_tail(&tunnel->list, &tcm->tunnel_list);
 	}
 
 	for (i = 1; i <= sw->config.max_port_number; i++) {
@@ -91,6 +124,15 @@ static void tb_scan_port(struct tb_port *port)
 
 	if (tb_is_upstream_port(port))
 		return;
+
+	if (tb_port_is_dpout(port) && tb_dp_port_hpd_is_active(port) == 1 &&
+	    !tb_dp_port_is_enabled(port)) {
+		tb_port_dbg(port, "DP adapter HPD set, queuing hotplug\n");
+		tb_queue_hotplug(port->sw->tb, tb_route(port->sw), port->port,
+				 false);
+		return;
+	}
+
 	if (port->config.type != TB_TYPE_PORT)
 		return;
 	if (port->dual_link_port && port->link_nr)
@@ -139,6 +181,26 @@ static void tb_scan_port(struct tb_port *port)
 	tb_scan_switch(sw);
 }
 
+static int tb_free_tunnel(struct tb *tb, enum tb_tunnel_type type,
+			  struct tb_port *src_port, struct tb_port *dst_port)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_tunnel *tunnel;
+
+	list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
+		if (tunnel->type == type &&
+		    ((src_port && src_port == tunnel->src_port) ||
+		     (dst_port && dst_port == tunnel->dst_port))) {
+			tb_tunnel_deactivate(tunnel);
+			list_del(&tunnel->list);
+			tb_tunnel_free(tunnel);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 /**
  * tb_free_invalid_tunnels() - destroy tunnels of devices that have gone away
  */
@@ -257,6 +319,44 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
 	return tb_find_unused_port(sw, TB_TYPE_PCIE_DOWN);
 }
 
+static int tb_tunnel_dp(struct tb *tb, struct tb_port *out)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_switch *sw = out->sw;
+	struct tb_tunnel *tunnel;
+	struct tb_port *in;
+
+	if (tb_port_is_enabled(out))
+		return 0;
+
+	do {
+		sw = tb_to_switch(sw->dev.parent);
+		if (!sw)
+			return 0;
+		in = tb_find_unused_port(sw, TB_TYPE_DP_HDMI_IN);
+	} while (!in);
+
+	tunnel = tb_tunnel_alloc_dp(tb, in, out);
+	if (!tunnel) {
+		tb_port_dbg(out, "DP tunnel allocation failed\n");
+		return -ENOMEM;
+	}
+
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(out, "DP tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		return -EIO;
+	}
+
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	return 0;
+}
+
+static void tb_teardown_dp(struct tb *tb, struct tb_port *out)
+{
+	tb_free_tunnel(tb, TB_TUNNEL_DP, NULL, out);
+}
+
 static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 {
 	struct tb_port *up, *down, *port;
@@ -295,14 +395,6 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 
 /* hotplug handling */
 
-struct tb_hotplug_event {
-	struct work_struct work;
-	struct tb *tb;
-	u64 route;
-	u8 port;
-	bool unplug;
-};
-
 /**
  * tb_handle_hotplug() - handle hotplug event
  *
@@ -347,6 +439,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 			port->remote = NULL;
 			if (port->dual_link_port)
 				port->dual_link_port->remote = NULL;
+		} else if (tb_port_is_dpout(port)) {
+			tb_teardown_dp(tb, port);
 		} else {
 			tb_port_info(port,
 				     "got unplug event for disconnected port, ignoring\n");
@@ -360,6 +454,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_scan_port(port);
 			if (!port->remote)
 				tb_port_info(port, "hotplug: no switch found\n");
+		} else if (tb_port_is_dpout(port)) {
+			tb_tunnel_dp(tb, port);
 		}
 	}
 
@@ -379,7 +475,6 @@ static void tb_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 			    const void *buf, size_t size)
 {
 	const struct cfg_event_pkg *pkg = buf;
-	struct tb_hotplug_event *ev;
 	u64 route;
 
 	if (type != TB_CFG_PKG_EVENT) {
@@ -395,15 +490,7 @@ static void tb_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 			pkg->port);
 	}
 
-	ev = kmalloc(sizeof(*ev), GFP_KERNEL);
-	if (!ev)
-		return;
-	INIT_WORK(&ev->work, tb_handle_hotplug);
-	ev->tb = tb;
-	ev->route = route;
-	ev->port = pkg->port;
-	ev->unplug = pkg->unplug;
-	queue_work(tb->wq, &ev->work);
+	tb_queue_hotplug(tb, route, pkg->port, pkg->unplug);
 }
 
 static void tb_stop(struct tb *tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index d802d8c5a953..dd7808f9de39 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -335,6 +335,16 @@ static inline bool tb_port_is_pcie_up(const struct tb_port *port)
 	return port && port->config.type == TB_TYPE_PCIE_UP;
 }
 
+static inline bool tb_port_is_dpin(const struct tb_port *port)
+{
+	return port && port->config.type == TB_TYPE_DP_HDMI_IN;
+}
+
+static inline bool tb_port_is_dpout(const struct tb_port *port)
+{
+	return port && port->config.type == TB_TYPE_DP_HDMI_OUT;
+}
+
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
@@ -551,6 +561,13 @@ bool tb_port_is_enabled(struct tb_port *port);
 bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
+int tb_dp_port_hpd_is_active(struct tb_port *port);
+int tb_dp_port_hpd_clear(struct tb_port *port);
+int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
+			unsigned int aux_tx, unsigned int aux_rx);
+bool tb_dp_port_is_enabled(struct tb_port *port);
+int tb_dp_port_enable(struct tb_port *port, bool enable);
+
 struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 				 struct tb_port *dst, int dst_hopid,
 				 struct tb_port **last, const char *name);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 74c0f4a5606d..3ce705184e2c 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -213,6 +213,28 @@ struct tb_regs_port_header {
 
 /* DWORD 4 */
 #define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
+#define TB_PORT_MAX_CREDITS_SHIFT	20
+#define TB_PORT_MAX_CREDITS_MASK	GENMASK(26, 20)
+
+/* Display Port adapter registers */
+
+/* DWORD 0 */
+#define TB_DP_VIDEO_HOPID_SHIFT		16
+#define TB_DP_VIDEO_HOPID_MASK		GENMASK(26, 16)
+#define TB_DP_AUX_EN			BIT(30)
+#define TB_DP_VIDEO_EN			BIT(31)
+/* DWORD 1 */
+#define TB_DP_AUX_TX_HOPID_MASK		GENMASK(10, 0)
+#define TB_DP_AUX_RX_HOPID_SHIFT	11
+#define TB_DP_AUX_RX_HOPID_MASK		GENMASK(21, 11)
+/* DWORD 2 */
+#define TB_DP_HDP			BIT(6)
+/* DWORD 3 */
+#define TB_DP_HPDC			BIT(9)
+/* DWORD 4 */
+#define TB_DP_LOCAL_CAP			0x4
+/* DWORD 5 */
+#define TB_DP_REMOTE_CAP		0x5
 
 /* PCIe adapter registers */
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 71c712300326..21d3393c6e9c 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -18,14 +18,26 @@
 #define TB_PCI_PATH_DOWN		0
 #define TB_PCI_PATH_UP			1
 
+/* DP adapters use HopID 8 for AUX and 9 for Video */
+#define TB_DP_AUX_TX_HOPID		8
+#define TB_DP_AUX_RX_HOPID		8
+#define TB_DP_VIDEO_HOPID		9
+
+#define TB_DP_VIDEO_PATH_OUT		0
+#define TB_DP_AUX_PATH_OUT		1
+#define TB_DP_AUX_PATH_IN		2
+
+static const char * const tb_tunnel_names[] = { "PCI", "DP" };
+
 #define __TB_TUNNEL_PRINT(level, tunnel, fmt, arg...)                   \
 	do {                                                            \
 		struct tb_tunnel *__tunnel = (tunnel);                  \
-		level(__tunnel->tb, "%llx:%x <-> %llx:%x (PCI): " fmt,  \
+		level(__tunnel->tb, "%llx:%x <-> %llx:%x (%s): " fmt,   \
 		      tb_route(__tunnel->src_port->sw),                 \
 		      __tunnel->src_port->port,                         \
 		      tb_route(__tunnel->dst_port->sw),                 \
 		      __tunnel->dst_port->port,                         \
+		      tb_tunnel_names[__tunnel->type],			\
 		      ## arg);                                          \
 	} while (0)
 
@@ -38,7 +50,8 @@
 #define tb_tunnel_dbg(tunnel, fmt, arg...) \
 	__TB_TUNNEL_PRINT(tb_dbg, tunnel, fmt, ##arg)
 
-static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
+static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths,
+					 enum tb_tunnel_type type)
 {
 	struct tb_tunnel *tunnel;
 
@@ -55,6 +68,7 @@ static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
 	INIT_LIST_HEAD(&tunnel->list);
 	tunnel->tb = tb;
 	tunnel->npaths = npaths;
+	tunnel->type = type;
 
 	return tunnel;
 }
@@ -104,7 +118,7 @@ struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down)
 	if (!tb_pci_port_is_enabled(down))
 		return NULL;
 
-	tunnel = tb_tunnel_alloc(tb, 2);
+	tunnel = tb_tunnel_alloc(tb, 2, TB_TUNNEL_PCI);
 	if (!tunnel)
 		return NULL;
 
@@ -179,7 +193,7 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	struct tb_tunnel *tunnel;
 	struct tb_path *path;
 
-	tunnel = tb_tunnel_alloc(tb, 2);
+	tunnel = tb_tunnel_alloc(tb, 2, TB_TUNNEL_PCI);
 	if (!tunnel)
 		return NULL;
 
@@ -208,6 +222,255 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	return tunnel;
 }
 
+static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
+{
+	struct tb_port *out = tunnel->dst_port;
+	struct tb_port *in = tunnel->src_port;
+	u32 in_dp_cap, out_dp_cap;
+	int ret;
+
+	/*
+	 * Copy DP_LOCAL_CAP register to DP_REMOTE_CAP register for
+	 * newer generation hardware.
+	 */
+	if (in->sw->generation < 2 || out->sw->generation < 2)
+		return 0;
+
+	/* Read both DP_LOCAL_CAP registers */
+	ret = tb_port_read(in, &in_dp_cap, TB_CFG_PORT,
+			   in->cap_adap + TB_DP_LOCAL_CAP, 1);
+	if (ret)
+		return ret;
+
+	ret = tb_port_read(out, &out_dp_cap, TB_CFG_PORT,
+			   out->cap_adap + TB_DP_LOCAL_CAP, 1);
+	if (ret)
+		return ret;
+
+	/* Write IN local caps to OUT remote caps */
+	ret = tb_port_write(out, &in_dp_cap, TB_CFG_PORT,
+			    out->cap_adap + TB_DP_REMOTE_CAP, 1);
+	if (ret)
+		return ret;
+
+	return tb_port_write(in, &out_dp_cap, TB_CFG_PORT,
+			     in->cap_adap + TB_DP_REMOTE_CAP, 1);
+}
+
+static int tb_dp_activate(struct tb_tunnel *tunnel, bool active)
+{
+	int ret;
+
+	if (active) {
+		struct tb_path **paths;
+		int last;
+
+		paths = tunnel->paths;
+		last = paths[TB_DP_VIDEO_PATH_OUT]->path_length - 1;
+
+		tb_dp_port_set_hops(tunnel->src_port,
+			paths[TB_DP_VIDEO_PATH_OUT]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_OUT]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_IN]->hops[last].next_hop_index);
+
+		tb_dp_port_set_hops(tunnel->dst_port,
+			paths[TB_DP_VIDEO_PATH_OUT]->hops[last].next_hop_index,
+			paths[TB_DP_AUX_PATH_IN]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_OUT]->hops[last].next_hop_index);
+	} else {
+		tb_dp_port_hpd_clear(tunnel->src_port);
+		tb_dp_port_set_hops(tunnel->src_port, 0, 0, 0);
+		if (tb_port_is_dpout(tunnel->dst_port))
+			tb_dp_port_set_hops(tunnel->dst_port, 0, 0, 0);
+	}
+
+	ret = tb_dp_port_enable(tunnel->src_port, active);
+	if (ret)
+		return ret;
+
+	if (tb_port_is_dpout(tunnel->dst_port))
+		return tb_dp_port_enable(tunnel->dst_port, active);
+
+	return 0;
+}
+
+static void tb_dp_init_aux_path(struct tb_path *path)
+{
+	int i;
+
+	path->egress_fc_enable = TB_PATH_SOURCE | TB_PATH_INTERNAL;
+	path->egress_shared_buffer = TB_PATH_NONE;
+	path->ingress_fc_enable = TB_PATH_ALL;
+	path->ingress_shared_buffer = TB_PATH_NONE;
+	path->priority = 2;
+	path->weight = 1;
+
+	for (i = 0; i < path->path_length; i++)
+		path->hops[i].initial_credits = 1;
+}
+
+static void tb_dp_init_video_path(struct tb_path *path, bool discover)
+{
+	u32 nfc_credits = path->hops[0].in_port->config.nfc_credits;
+
+	path->egress_fc_enable = TB_PATH_NONE;
+	path->egress_shared_buffer = TB_PATH_NONE;
+	path->ingress_fc_enable = TB_PATH_NONE;
+	path->ingress_shared_buffer = TB_PATH_NONE;
+	path->priority = 1;
+	path->weight = 1;
+
+	if (discover) {
+		path->nfc_credits = nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+	} else {
+		u32 max_credits;
+
+		max_credits = (nfc_credits & TB_PORT_MAX_CREDITS_MASK) >>
+			TB_PORT_MAX_CREDITS_SHIFT;
+		/* Leave some credits for AUX path */
+		path->nfc_credits = min(max_credits - 2, 12U);
+	}
+}
+
+/**
+ * tb_tunnel_discover_dp() - Discover existing Display Port tunnels
+ * @tb: Pointer to the domain structure
+ * @in: DP in adapter
+ *
+ * If @in adapter is active, follows the tunnel to the DP out adapter
+ * and back. Returns the discovered tunnel or %NULL if there was no
+ * tunnel.
+ *
+ * Return: DP tunnel or %NULL if no tunnel found.
+ */
+struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_port *port;
+	struct tb_path *path;
+
+	if (!tb_dp_port_is_enabled(in))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->init = tb_dp_xchg_caps;
+	tunnel->activate = tb_dp_activate;
+	tunnel->src_port = in;
+
+	path = tb_path_discover(in, TB_DP_VIDEO_HOPID, NULL, -1,
+				&tunnel->dst_port, "Video");
+	if (!path) {
+		/* Just disable the DP IN port */
+		tb_dp_port_enable(in, false);
+		goto err_free;
+	}
+	tunnel->paths[TB_DP_VIDEO_PATH_OUT] = path;
+	tb_dp_init_video_path(tunnel->paths[TB_DP_VIDEO_PATH_OUT], true);
+
+	path = tb_path_discover(in, TB_DP_AUX_TX_HOPID, NULL, -1, NULL, "AUX TX");
+	if (!path)
+		goto err_deactivate;
+	tunnel->paths[TB_DP_AUX_PATH_OUT] = path;
+	tb_dp_init_aux_path(tunnel->paths[TB_DP_AUX_PATH_OUT]);
+
+	path = tb_path_discover(tunnel->dst_port, -1, in, TB_DP_AUX_RX_HOPID,
+				&port, "AUX RX");
+	if (!path)
+		goto err_deactivate;
+	tunnel->paths[TB_DP_AUX_PATH_IN] = path;
+	tb_dp_init_aux_path(tunnel->paths[TB_DP_AUX_PATH_IN]);
+
+	/* Validate that the tunnel is complete */
+	if (!tb_port_is_dpout(tunnel->dst_port)) {
+		tb_port_warn(in, "path does not end on a DP adapter, cleaning up\n");
+		goto err_deactivate;
+	}
+
+	if (!tb_dp_port_is_enabled(tunnel->dst_port))
+		goto err_deactivate;
+
+	if (!tb_dp_port_hpd_is_active(tunnel->dst_port))
+		goto err_deactivate;
+
+	if (port != tunnel->src_port) {
+		tb_tunnel_warn(tunnel, "path is not complete, cleaning up\n");
+		goto err_deactivate;
+	}
+
+	tb_tunnel_dbg(tunnel, "discovered\n");
+	return tunnel;
+
+err_deactivate:
+	tb_tunnel_deactivate(tunnel);
+err_free:
+	tb_tunnel_free(tunnel);
+
+	return NULL;
+}
+
+/**
+ * tb_tunnel_alloc_dp() - allocate a Display Port tunnel
+ * @tb: Pointer to the domain structure
+ * @in: DP in adapter port
+ * @out: DP out adapter port
+ *
+ * Allocates a tunnel between @in and @out that is capable of tunneling
+ * Display Port traffic.
+ *
+ * Return: Returns a tb_tunnel on success or NULL on failure.
+ */
+struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
+				     struct tb_port *out)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path **paths;
+	struct tb_path *path;
+
+	if (WARN_ON(!in->cap_adap || !out->cap_adap))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->init = tb_dp_xchg_caps;
+	tunnel->activate = tb_dp_activate;
+	tunnel->src_port = in;
+	tunnel->dst_port = out;
+
+	paths = tunnel->paths;
+
+	path = tb_path_alloc(tb, in, TB_DP_VIDEO_HOPID, out, TB_DP_VIDEO_HOPID,
+			     1, "Video");
+	if (!path)
+		goto err_free;
+	tb_dp_init_video_path(path, false);
+	paths[TB_DP_VIDEO_PATH_OUT] = path;
+
+	path = tb_path_alloc(tb, in, TB_DP_AUX_TX_HOPID, out,
+			     TB_DP_AUX_TX_HOPID, 1, "AUX TX");
+	if (!path)
+		goto err_free;
+	tb_dp_init_aux_path(path);
+	paths[TB_DP_AUX_PATH_OUT] = path;
+
+	path = tb_path_alloc(tb, out, TB_DP_AUX_RX_HOPID, in,
+			     TB_DP_AUX_RX_HOPID, 1, "AUX RX");
+	if (!path)
+		goto err_free;
+	tb_dp_init_aux_path(path);
+	paths[TB_DP_AUX_PATH_IN] = path;
+
+	return tunnel;
+
+err_free:
+	tb_tunnel_free(tunnel);
+	return NULL;
+}
+
 /**
  * tb_tunnel_free() - free a tunnel
  * @tunnel: Tunnel to be freed
@@ -278,6 +541,12 @@ int tb_tunnel_restart(struct tb_tunnel *tunnel)
 		}
 	}
 
+	if (tunnel->init) {
+		res = tunnel->init(tunnel);
+		if (res)
+			return res;
+	}
+
 	for (i = 0; i < tunnel->npaths; i++) {
 		res = tb_path_activate(tunnel->paths[i]);
 		if (res)
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 07bf587bed80..0373779f43ba 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -11,6 +11,11 @@
 
 #include "tb.h"
 
+enum tb_tunnel_type {
+	TB_TUNNEL_PCI,
+	TB_TUNNEL_DP,
+};
+
 /**
  * struct tb_tunnel - Tunnel between two ports
  * @tb: Pointer to the domain
@@ -19,8 +24,10 @@
  *	      tunnels may be %NULL or null adapter port instead.
  * @paths: All paths required by the tunnel
  * @npaths: Number of paths in @paths
+ * @init: Optional tunnel specific initialization
  * @activate: Optional tunnel specific activation/deactivation
  * @list: Tunnels are linked using this field
+ * @type: Type of the tunnel
  */
 struct tb_tunnel {
 	struct tb *tb;
@@ -28,18 +35,34 @@ struct tb_tunnel {
 	struct tb_port *dst_port;
 	struct tb_path **paths;
 	size_t npaths;
+	int (*init)(struct tb_tunnel *tunnel);
 	int (*activate)(struct tb_tunnel *tunnel, bool activate);
 	struct list_head list;
+	enum tb_tunnel_type type;
 };
 
 struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down);
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down);
+struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in);
+struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
+				     struct tb_port *out);
+
 void tb_tunnel_free(struct tb_tunnel *tunnel);
 int tb_tunnel_activate(struct tb_tunnel *tunnel);
 int tb_tunnel_restart(struct tb_tunnel *tunnel);
 void tb_tunnel_deactivate(struct tb_tunnel *tunnel);
 bool tb_tunnel_is_invalid(struct tb_tunnel *tunnel);
 
+static inline bool tb_tunnel_is_pci(const struct tb_tunnel *tunnel)
+{
+	return tunnel->type == TB_TUNNEL_PCI;
+}
+
+static inline bool tb_tunnel_is_dp(const struct tb_tunnel *tunnel)
+{
+	return tunnel->type == TB_TUNNEL_DP;
+}
+
 #endif
 
-- 
2.20.1

