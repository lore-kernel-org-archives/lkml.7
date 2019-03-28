Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D235C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4920811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfC1MjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:39:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:9515 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="145991023"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D1105D74; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 22/36] thunderbolt: Add support for full PCIe daisy chains
Date:   Thu, 28 Mar 2019 15:36:19 +0300
Message-Id: <20190328123633.42882-23-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the software connection manager (tb.c) has only supported
creating a single PCIe tunnel, no PCIe device daisy chaining has been
supported so far. This updates the software connection manager so that
it now can create PCIe tunnels for full chain of six devices.

Because PCIe allows DMA and opens possibility for DMA attacks we change
security level to "user" meaning that PCIe tunneling requires that the
userspace authorizes the devices first. This makes it possible to block
PCIe tunneling completely while still allowing other types of tunnels to
be automatically created.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 174 +++++++++++++++++++++++----------------
 drivers/thunderbolt/tb.h |  27 ++++++
 2 files changed, 129 insertions(+), 72 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a62695a99835..cfc451c938fd 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - bus logic (NHI independent)
+ * Thunderbolt driver - bus logic (NHI independent)
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -84,6 +85,7 @@ static void tb_scan_switch(struct tb_switch *sw)
  */
 static void tb_scan_port(struct tb_port *port)
 {
+	struct tb_cm *tcm = tb_priv(port->sw->tb);
 	struct tb_port *upstream_port;
 	struct tb_switch *sw;
 
@@ -112,7 +114,13 @@ static void tb_scan_port(struct tb_port *port)
 		return;
 	}
 
-	sw->authorized = true;
+	/*
+	 * Do not send uevents until we have discovered all existing
+	 * tunnels and know which switches were authorized already by
+	 * the boot firmware.
+	 */
+	if (!tcm->hotplug_active)
+		dev_set_uevent_suppress(&sw->dev, true);
 
 	if (tb_switch_add(sw)) {
 		tb_switch_put(sw);
@@ -212,72 +220,78 @@ static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
 	return NULL;
 }
 
-/**
- * tb_activate_pcie_devices() - scan for and activate PCIe devices
- *
- * This method is somewhat ad hoc. For now it only supports one device
- * per port and only devices at depth 1.
- */
-static void tb_activate_pcie_devices(struct tb *tb)
+static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
+					 const struct tb_port *port)
 {
-	int i;
-	int cap;
-	u32 data;
-	struct tb_switch *sw;
-	struct tb_port *up_port;
-	struct tb_port *down_port;
-	struct tb_tunnel *tunnel;
-	struct tb_cm *tcm = tb_priv(tb);
+	/*
+	 * To keep plugging devices consistently in the same PCIe
+	 * hierarchy, do mapping here for root switch downstream PCIe
+	 * ports.
+	 */
+	if (!tb_route(sw)) {
+		int phy_port = tb_phy_port_from_link(port->port);
+		int index;
 
-	/* scan for pcie devices at depth 1*/
-	for (i = 1; i <= tb->root_switch->config.max_port_number; i++) {
-		if (tb_is_upstream_port(&tb->root_switch->ports[i]))
-			continue;
-		if (tb->root_switch->ports[i].config.type != TB_TYPE_PORT)
-			continue;
-		if (!tb->root_switch->ports[i].remote)
-			continue;
-		sw = tb->root_switch->ports[i].remote->sw;
-		up_port = tb_find_pci_up_port(sw);
-		if (!up_port) {
-			tb_sw_info(sw, "no PCIe devices found, aborting\n");
-			continue;
-		}
+		/*
+		 * Hard-coded Thunderbolt port to PCIe down port mapping
+		 * per controller.
+		 */
+		if (tb_switch_is_cr(sw))
+			index = !phy_port ? 6 : 7;
+		else if (tb_switch_is_fr(sw))
+			index = !phy_port ? 6 : 8;
+		else
+			goto out;
+
+		/* Validate the hard-coding */
+		if (WARN_ON(index > sw->config.max_port_number))
+			goto out;
+		if (WARN_ON(!tb_port_is_pcie_down(&sw->ports[index])))
+			goto out;
+		if (WARN_ON(tb_pci_port_is_enabled(&sw->ports[index])))
+			goto out;
+
+		return &sw->ports[index];
+	}
 
-		/* check whether port is already activated */
-		cap = up_port->cap_adap;
-		if (!cap)
-			continue;
-		if (tb_port_read(up_port, &data, TB_CFG_PORT, cap, 1))
-			continue;
-		if (data & 0x80000000) {
-			tb_port_info(up_port,
-				     "PCIe port already activated, aborting\n");
-			continue;
-		}
+out:
+	return tb_find_unused_down_port(sw);
+}
 
-		down_port = tb_find_unused_down_port(tb->root_switch);
-		if (!down_port) {
-			tb_port_info(up_port,
-				     "All PCIe down ports are occupied, aborting\n");
-			continue;
-		}
-		tunnel = tb_tunnel_alloc_pci(tb, up_port, down_port);
-		if (!tunnel) {
-			tb_port_info(up_port,
-				     "PCIe tunnel allocation failed, aborting\n");
-			continue;
-		}
+static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
+{
+	struct tb_port *up, *down, *port;
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_switch *parent_sw;
+	struct tb_tunnel *tunnel;
 
-		if (tb_tunnel_activate(tunnel)) {
-			tb_port_info(up_port,
-				     "PCIe tunnel activation failed, aborting\n");
-			tb_tunnel_free(tunnel);
-			continue;
-		}
+	up = tb_find_pci_up_port(sw);
+	if (!up)
+		return 0;
 
-		list_add(&tunnel->list, &tcm->tunnel_list);
+	/*
+	 * Look up available down port. Since we are chaining it should
+	 * be found right above this switch.
+	 */
+	parent_sw = tb_to_switch(sw->dev.parent);
+	port = tb_port_at(tb_route(sw), parent_sw);
+	down = tb_find_pcie_down(parent_sw, port);
+	if (!down)
+		return 0;
+
+	tunnel = tb_tunnel_alloc_pci(tb, up, down);
+	if (!tunnel)
+		return -ENOMEM;
+
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(up,
+			     "PCIe tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		return -EIO;
 	}
+
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	return 0;
 }
 
 /* hotplug handling */
@@ -344,16 +358,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 	} else {
 		tb_port_info(port, "hotplug: scanning\n");
 		tb_scan_port(port);
-		if (!port->remote) {
+		if (!port->remote)
 			tb_port_info(port, "hotplug: no switch found\n");
-		} else if (port->remote->sw->config.depth > 1) {
-			tb_sw_warn(port->remote->sw,
-				   "hotplug: chaining not supported\n");
-		} else {
-			tb_sw_info(port->remote->sw,
-				   "hotplug: activating pcie devices\n");
-			tb_activate_pcie_devices(tb);
-		}
 	}
 
 put_sw:
@@ -414,6 +420,27 @@ static void tb_stop(struct tb *tb)
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
 
+static int tb_scan_finalize_switch(struct device *dev, void *data)
+{
+	if (tb_is_switch(dev)) {
+		struct tb_switch *sw = tb_to_switch(dev);
+
+		/*
+		 * If we found that the switch was already setup by the
+		 * boot firmware, mark it as authorized now before we
+		 * send uevent to userspace.
+		 */
+		if (sw->boot)
+			sw->authorized = 1;
+
+		dev_set_uevent_suppress(dev, false);
+		kobject_uevent(&dev->kobj, KOBJ_ADD);
+		device_for_each_child(dev, NULL, tb_scan_finalize_switch);
+	}
+
+	return 0;
+}
+
 static int tb_start(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -447,7 +474,9 @@ static int tb_start(struct tb *tb)
 	tb_scan_switch(tb->root_switch);
 	/* Find out tunnels created by the boot firmware */
 	tb_discover_tunnels(tb->root_switch);
-	tb_activate_pcie_devices(tb);
+	/* Make the discovered switches available to the userspace */
+	device_for_each_child(&tb->root_switch->dev, NULL,
+			      tb_scan_finalize_switch);
 
 	/* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
@@ -502,6 +531,7 @@ static const struct tb_cm_ops tb_cm_ops = {
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
 	.handle_event = tb_handle_event,
+	.approve_switch = tb_tunnel_pci,
 };
 
 struct tb *tb_probe(struct tb_nhi *nhi)
@@ -516,7 +546,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 	if (!tb)
 		return NULL;
 
-	tb->security_level = TB_SECURITY_NONE;
+	tb->security_level = TB_SECURITY_USER;
 	tb->cm_ops = &tb_cm_ops;
 
 	tcm = tb_priv(tb);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 6ce3832b6c99..d810fb188937 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -320,6 +320,11 @@ static inline bool tb_port_has_remote(const struct tb_port *port)
 	return true;
 }
 
+static inline bool tb_port_is_pcie_down(const struct tb_port *port)
+{
+	return port && port->config.type == TB_TYPE_PCIE_DOWN;
+}
+
 static inline bool tb_port_is_pcie_up(const struct tb_port *port)
 {
 	return port && port->config.type == TB_TYPE_PCIE_UP;
@@ -502,6 +507,28 @@ static inline bool tb_switch_is_er(const struct tb_switch *sw)
 	return sw->config.device_id == PCI_DEVICE_ID_INTEL_EAGLE_RIDGE;
 }
 
+static inline bool tb_switch_is_cr(const struct tb_switch *sw)
+{
+	switch (sw->config.device_id) {
+	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_2C:
+	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool tb_switch_is_fr(const struct tb_switch *sw)
+{
+	switch (sw->config.device_id) {
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
-- 
2.20.1

