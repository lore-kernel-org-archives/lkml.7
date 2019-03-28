Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A0C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343C82183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfC1Mgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:36:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:13995 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfC1Mgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="332831925"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2019 05:36:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C4A52CC1; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 21/36] thunderbolt: Discover preboot PCIe paths the boot firmware established
Date:   Thu, 28 Mar 2019 15:36:18 +0300
Message-Id: <20190328123633.42882-22-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Apple Macs the boot firmware (EFI) connects all devices automatically
when the system is started, before it hands over to the OS. Instead of
ignoring we discover all those PCIe tunnels and record them using our
internal structures, just like we do when a device is connected after
the OS is already up.

By doing this we can properly tear down tunnels when devices are
disconnected. Also this allows us to resume the existing tunnels after
system suspend/resume cycle.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 204 +++++++++++++++++++++++++++++++----
 drivers/thunderbolt/switch.c |  14 +++
 drivers/thunderbolt/tb.c     |  39 +++++++
 drivers/thunderbolt/tb.h     |  16 +++
 drivers/thunderbolt/tunnel.c |  86 ++++++++++++++-
 drivers/thunderbolt/tunnel.h |   4 +-
 6 files changed, 338 insertions(+), 25 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index d3f5df779d8d..daef74548197 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - path/tunnel functionality
+ * Thunderbolt driver - path/tunnel functionality
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -12,7 +13,6 @@
 
 #include "tb.h"
 
-
 static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 {
 	tb_port_dbg(port, " Hop through port %d to hop %d (%s)\n",
@@ -30,6 +30,182 @@ static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 		    hop->unknown1, hop->unknown2, hop->unknown3);
 }
 
+static struct tb_port *tb_path_find_dst_port(struct tb_port *src, int src_hopid,
+					     int dst_hopid)
+{
+	struct tb_port *port, *out_port = NULL;
+	struct tb_regs_hop hop;
+	struct tb_switch *sw;
+	int i, ret, hopid;
+
+	hopid = src_hopid;
+	port = src;
+
+	for (i = 0; port && i < TB_PATH_MAX_HOPS; i++) {
+		sw = port->sw;
+
+		ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hopid, 2);
+		if (ret) {
+			tb_port_warn(port, "failed to read path at %d\n", hopid);
+			return NULL;
+		}
+
+		if (!hop.enable)
+			return NULL;
+
+		out_port = &sw->ports[hop.out_port];
+		hopid = hop.next_hop;
+		port = out_port->remote;
+	}
+
+	return out_port && hopid == dst_hopid ? out_port : NULL;
+}
+
+static int tb_path_find_src_hopid(struct tb_port *src,
+	const struct tb_port *dst, int dst_hopid)
+{
+	struct tb_port *out;
+	int i;
+
+	for (i = TB_PATH_MIN_HOPID; i <= src->config.max_in_hop_id; i++) {
+		out = tb_path_find_dst_port(src, i, dst_hopid);
+		if (out == dst)
+			return i;
+	}
+
+	return 0;
+}
+
+/**
+ * tb_path_discover() - Discover a path
+ * @src: First input port of a path
+ * @src_hopid: Starting HopID of a path (%-1 if don't care)
+ * @dst: Expected destination port of the path (%NULL if don't care)
+ * @dst_hopid: HopID to the @dst (%-1 if don't care)
+ * @last: Last port is filled here if not %NULL
+ * @name: Name of the path
+ *
+ * Follows a path starting from @src and @src_hopid to the last output
+ * port of the path. Allocates HopIDs for the visited ports. Call
+ * tb_path_free() to release the path and allocated HopIDs when the path
+ * is not needed anymore.
+ *
+ * Note function discovers also incomplete paths so caller should check
+ * that the @dst port is the expected one. If it is not, the path can be
+ * cleaned up by calling tb_path_deactivate() before tb_path_free().
+ *
+ * Return: Discovered path on success, %NULL in case of failure
+ */
+struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
+				 struct tb_port *dst, int dst_hopid,
+				 struct tb_port **last, const char *name)
+{
+	struct tb_port *out_port;
+	struct tb_regs_hop hop;
+	struct tb_path *path;
+	struct tb_switch *sw;
+	struct tb_port *p;
+	size_t num_hops;
+	int ret, i, h;
+
+	if (src_hopid < 0 && dst) {
+		/*
+		 * For incomplete paths the intermediate HopID can be
+		 * different from the one used by the protocol adapter
+		 * so in that case find a path that ends on @dst with
+		 * matching @dst_hopid. That should give us the correct
+		 * HopID for the @src.
+		 */
+		src_hopid = tb_path_find_src_hopid(src, dst, dst_hopid);
+		if (!src_hopid)
+			return NULL;
+	}
+
+	p = src;
+	h = src_hopid;
+	num_hops = 0;
+
+	for (i = 0; p && i < TB_PATH_MAX_HOPS; i++) {
+		sw = p->sw;
+
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		if (ret) {
+			tb_port_warn(p, "failed to read path at %d\n", h);
+			return NULL;
+		}
+
+		/* If the hop is not enabled we got an incomplete path */
+		if (!hop.enable)
+			break;
+
+		out_port = &sw->ports[hop.out_port];
+		if (last)
+			*last = out_port;
+
+		h = hop.next_hop;
+		p = out_port->remote;
+		num_hops++;
+	}
+
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
+	if (!path)
+		return NULL;
+
+	path->name = name;
+	path->tb = src->sw->tb;
+	path->path_length = num_hops;
+	path->activated = true;
+
+	path->hops = kcalloc(num_hops, sizeof(*path->hops), GFP_KERNEL);
+	if (!path->hops) {
+		kfree(path);
+		return NULL;
+	}
+
+	p = src;
+	h = src_hopid;
+
+	for (i = 0; i < num_hops; i++) {
+		int next_hop;
+
+		sw = p->sw;
+
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		if (ret) {
+			tb_port_warn(p, "failed to read path at %d\n", h);
+			goto err;
+		}
+
+		if (tb_port_alloc_in_hopid(p, h, h) < 0)
+			goto err;
+
+		out_port = &sw->ports[hop.out_port];
+		next_hop = hop.next_hop;
+
+		if (tb_port_alloc_out_hopid(out_port, next_hop, next_hop) < 0) {
+			tb_port_release_in_hopid(p, h);
+			goto err;
+		}
+
+		path->hops[i].in_port = p;
+		path->hops[i].in_hop_index = h;
+		path->hops[i].in_counter_index = -1;
+		path->hops[i].out_port = out_port;
+		path->hops[i].next_hop_index = next_hop;
+
+		h = next_hop;
+		p = out_port->remote;
+	}
+
+	return path;
+
+err:
+	tb_port_warn(src, "failed to discover path starting at HopID %d\n",
+		     src_hopid);
+	tb_path_free(path);
+	return NULL;
+}
+
 /**
  * tb_path_alloc() - allocate a thunderbolt path between two ports
  * @tb: Domain pointer
@@ -286,30 +462,14 @@ int tb_path_activate(struct tb_path *path)
 	for (i = path->path_length - 1; i >= 0; i--) {
 		struct tb_regs_hop hop = { 0 };
 
-		/*
-		 * We do (currently) not tear down paths setup by the firmeware.
-		 * If a firmware device is unplugged and plugged in again then
-		 * it can happen that we reuse some of the hops from the (now
-		 * defunct) firmeware path. This causes the hotplug operation to
-		 * fail (the pci device does not show up). Clearing the hop
-		 * before overwriting it fixes the problem.
-		 *
-		 * Should be removed once we discover and tear down firmeware
-		 * paths.
-		 */
-		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
-				    2 * path->hops[i].in_hop_index, 2);
-		if (res) {
-			__tb_path_deactivate_hops(path, i);
-			__tb_path_deallocate_nfc(path, 0);
-			goto err;
-		}
+		/* If it is left active deactivate it first */
+		__tb_path_deactivate_hop(path->hops[i].in_port,
+				path->hops[i].in_hop_index);
 
 		/* dword 0 */
 		hop.next_hop = path->hops[i].next_hop_index;
 		hop.out_port = path->hops[i].out_port->port;
-		/* TODO: figure out why these are good values */
-		hop.initial_credits = (i == path->path_length - 1) ? 16 : 7;
+		hop.initial_credits = path->hops[i].initial_credits;
 		hop.unknown1 = 0;
 		hop.enable = 1;
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ecd41f7b7649..00aec2124f79 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -730,6 +730,20 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
 	return next;
 }
 
+/**
+ * tb_pci_port_is_enabled() - Is the PCIe adapter port enabled
+ * @port: PCIe port to check
+ */
+bool tb_pci_port_is_enabled(struct tb_port *port)
+{
+	u32 data;
+
+	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+		return false;
+
+	return !!(data & TB_PCI_EN);
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 0485f4ef9a62..a62695a99835 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -29,6 +29,43 @@ struct tb_cm {
 
 /* enumeration & hot plug handling */
 
+static void tb_discover_tunnels(struct tb_switch *sw)
+{
+	struct tb *tb = sw->tb;
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_port *port;
+	int i;
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		struct tb_tunnel *tunnel = NULL;
+
+		port = &sw->ports[i];
+		switch (port->config.type) {
+		case TB_TYPE_PCIE_DOWN:
+			tunnel = tb_tunnel_discover_pci(tb, port);
+			break;
+
+		default:
+			break;
+		}
+
+		if (tunnel) {
+			struct tb_switch *parent = tunnel->dst_port->sw;
+
+			while (parent != tunnel->src_port->sw) {
+				parent->boot = true;
+				parent = tb_switch_parent(parent);
+			}
+
+			list_add_tail(&tunnel->list, &tcm->tunnel_list);
+		}
+	}
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		if (tb_port_has_remote(&sw->ports[i]))
+			tb_discover_tunnels(sw->ports[i].remote->sw);
+	}
+}
 
 static void tb_scan_port(struct tb_port *port);
 
@@ -408,6 +445,8 @@ static int tb_start(struct tb *tb)
 
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
+	/* Find out tunnels created by the boot firmware */
+	tb_discover_tunnels(tb->root_switch);
 	tb_activate_pcie_devices(tb);
 
 	/* Allow tb_handle_hotplug to progress events */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 1c7d67a829d3..6ce3832b6c99 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -162,6 +162,7 @@ struct tb_path_hop {
 	int in_hop_index;
 	int in_counter_index; /* write -1 to disable counters for this hop. */
 	int next_hop_index;
+	unsigned int initial_credits;
 };
 
 /**
@@ -201,6 +202,7 @@ struct tb_path {
 
 /* HopIDs 0-7 are reserved by the Thunderbolt protocol */
 #define TB_PATH_MIN_HOPID	8
+#define TB_PATH_MAX_HOPS	7
 
 /**
  * struct tb_cm_ops - Connection manager specific operations vector
@@ -318,6 +320,11 @@ static inline bool tb_port_has_remote(const struct tb_port *port)
 	return true;
 }
 
+static inline bool tb_port_is_pcie_up(const struct tb_port *port)
+{
+	return port && port->config.type == TB_TYPE_PCIE_UP;
+}
+
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
@@ -480,6 +487,11 @@ static inline struct tb_switch *tb_to_switch(struct device *dev)
 	return NULL;
 }
 
+static inline struct tb_switch *tb_switch_parent(struct tb_switch *sw)
+{
+	return tb_to_switch(sw->dev.parent);
+}
+
 static inline bool tb_switch_is_lr(const struct tb_switch *sw)
 {
 	return sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE;
@@ -503,8 +515,12 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
+bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
+struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
+				 struct tb_port *dst, int dst_hopid,
+				 struct tb_port **last, const char *name);
 struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 			      struct tb_port *dst, int dst_hopid, int link_nr,
 			      const char *name);
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index e109578da175..71c712300326 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -35,6 +35,8 @@
 	__TB_TUNNEL_PRINT(tb_warn, tunnel, fmt, ##arg)
 #define tb_tunnel_info(tunnel, fmt, arg...) \
 	__TB_TUNNEL_PRINT(tb_info, tunnel, fmt, ##arg)
+#define tb_tunnel_dbg(tunnel, fmt, arg...) \
+	__TB_TUNNEL_PRINT(tb_dbg, tunnel, fmt, ##arg)
 
 static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
 {
@@ -65,7 +67,10 @@ static int tb_pci_activate(struct tb_tunnel *tunnel, bool activate)
 	if (res)
 		return res;
 
-	return tb_pci_port_enable(tunnel->dst_port, activate);
+	if (tb_port_is_pcie_up(tunnel->dst_port))
+		return tb_pci_port_enable(tunnel->dst_port, activate);
+
+	return 0;
 }
 
 static void tb_pci_init_path(struct tb_path *path)
@@ -78,6 +83,83 @@ static void tb_pci_init_path(struct tb_path *path)
 	path->weight = 1;
 	path->drop_packages = 0;
 	path->nfc_credits = 0;
+	path->hops[0].initial_credits = 7;
+	path->hops[1].initial_credits = 16;
+}
+
+/**
+ * tb_tunnel_discover_pci() - Discover existing PCIe tunnels
+ * @tb: Pointer to the domain structure
+ * @down: PCIe downstream adapter
+ *
+ * If @down adapter is active, follows the tunnel to the PCIe upstream
+ * adapter and back. Returns the discovered tunnel or %NULL if there was
+ * no tunnel.
+ */
+struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path *path;
+
+	if (!tb_pci_port_is_enabled(down))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 2);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->activate = tb_pci_activate;
+	tunnel->src_port = down;
+
+	/*
+	 * Discover both paths even if they are not complete. We will
+	 * clean them up by calling tb_tunnel_deactivate() below in that
+	 * case.
+	 */
+	path = tb_path_discover(down, TB_PCI_HOPID, NULL, -1,
+				&tunnel->dst_port, "PCIe Up");
+	if (!path) {
+		/* Just disable the downstream port */
+		tb_pci_port_enable(down, false);
+		goto err_free;
+	}
+	tunnel->paths[TB_PCI_PATH_UP] = path;
+	tb_pci_init_path(tunnel->paths[TB_PCI_PATH_UP]);
+
+	path = tb_path_discover(tunnel->dst_port, -1, down, TB_PCI_HOPID, NULL,
+				"PCIe Down");
+	if (!path)
+		goto err_deactivate;
+	tunnel->paths[TB_PCI_PATH_DOWN] = path;
+	tb_pci_init_path(tunnel->paths[TB_PCI_PATH_DOWN]);
+
+	/* Validate that the tunnel is complete */
+	if (!tb_port_is_pcie_up(tunnel->dst_port)) {
+		tb_port_warn(tunnel->dst_port,
+			     "path does not end on a PCIe adapter, cleaning up\n");
+		goto err_deactivate;
+	}
+
+	if (down != tunnel->src_port) {
+		tb_tunnel_warn(tunnel, "path is not complete, cleaning up\n");
+		goto err_deactivate;
+	}
+
+	if (!tb_pci_port_is_enabled(tunnel->dst_port)) {
+		tb_tunnel_warn(tunnel,
+			       "tunnel is not fully activated, cleaning up\n");
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
 }
 
 /**
@@ -253,7 +335,7 @@ void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
 		tunnel->activate(tunnel, false);
 
 	for (i = 0; i < tunnel->npaths; i++) {
-		if (tunnel->paths[i]->activated)
+		if (tunnel->paths[i] && tunnel->paths[i]->activated)
 			tb_path_deactivate(tunnel->paths[i]);
 	}
 }
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index b4e992165e56..07bf587bed80 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -15,7 +15,8 @@
  * struct tb_tunnel - Tunnel between two ports
  * @tb: Pointer to the domain
  * @src_port: Source port of the tunnel
- * @dst_port: Destination port of the tunnel
+ * @dst_port: Destination port of the tunnel. For discovered incomplete
+ *	      tunnels may be %NULL or null adapter port instead.
  * @paths: All paths required by the tunnel
  * @npaths: Number of paths in @paths
  * @activate: Optional tunnel specific activation/deactivation
@@ -31,6 +32,7 @@ struct tb_tunnel {
 	struct list_head list;
 };
 
+struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down);
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down);
 void tb_tunnel_free(struct tb_tunnel *tunnel);
-- 
2.20.1

