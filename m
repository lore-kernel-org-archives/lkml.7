Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80976217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfC1MjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:39:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:34153 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138136885"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 05:36:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7FF7E9E5; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 16/36] thunderbolt: Add functions for allocating and releasing HopIDs
Date:   Thu, 28 Mar 2019 15:36:13 +0300
Message-Id: <20190328123633.42882-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each port has a separate path configuration space that is used for
finding the next hop (switch) in the path. HopID is an index to this
configuration space. HopIDs 0 - 7 are reserved by the protocol.

In order to get next available HopID for each direction we provide two
pairs of helper functions that can be used to allocate and release
HopIDs for a given port.

While there remove obsolete TODO comment.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi.c    |  3 +-
 drivers/thunderbolt/switch.c | 87 +++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tb.h     | 11 +++++
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9aa44f9762a3..cac1ead5e302 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -27,8 +27,7 @@
  * use this ring for anything else.
  */
 #define RING_E2E_UNUSED_HOPID	2
-/* HopIDs 0-7 are reserved by the Thunderbolt protocol */
-#define RING_FIRST_USABLE_HOPID	8
+#define RING_FIRST_USABLE_HOPID	TB_PATH_MIN_HOPID
 
 /*
  * Minimal number of vectors when we use MSI-X. Two for control channel
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index b132439618da..30f3d6a9fe90 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -594,11 +594,88 @@ static int tb_init_port(struct tb_port *port)
 
 	tb_dump_port(port->sw->tb, &port->config);
 
-	/* TODO: Read dual link port, DP port and more from EEPROM. */
+	/* Control port does not need HopID allocation */
+	if (port->port) {
+		ida_init(&port->in_hopids);
+		ida_init(&port->out_hopids);
+	}
+
 	return 0;
 
 }
 
+static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
+			       int max_hopid)
+{
+	int port_max_hopid;
+	struct ida *ida;
+
+	if (in) {
+		port_max_hopid = port->config.max_in_hop_id;
+		ida = &port->in_hopids;
+	} else {
+		port_max_hopid = port->config.max_out_hop_id;
+		ida = &port->out_hopids;
+	}
+
+	/* HopIDs 0-7 are reserved */
+	if (min_hopid < TB_PATH_MIN_HOPID)
+		min_hopid = TB_PATH_MIN_HOPID;
+
+	if (max_hopid < 0 || max_hopid > port_max_hopid)
+		max_hopid = port_max_hopid;
+
+	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+}
+
+/**
+ * tb_port_alloc_in_hopid() - Allocate input HopID from port
+ * @port: Port to allocate HopID for
+ * @min_hopid: Minimum acceptable input HopID
+ * @max_hopid: Maximum acceptable input HopID
+ *
+ * Return: HopID between @min_hopid and @max_hopid or negative errno in
+ * case of error.
+ */
+int tb_port_alloc_in_hopid(struct tb_port *port, int min_hopid, int max_hopid)
+{
+	return tb_port_alloc_hopid(port, true, min_hopid, max_hopid);
+}
+
+/**
+ * tb_port_alloc_out_hopid() - Allocate output HopID from port
+ * @port: Port to allocate HopID for
+ * @min_hopid: Minimum acceptable output HopID
+ * @max_hopid: Maximum acceptable output HopID
+ *
+ * Return: HopID between @min_hopid and @max_hopid or negative errno in
+ * case of error.
+ */
+int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
+{
+	return tb_port_alloc_hopid(port, false, min_hopid, max_hopid);
+}
+
+/**
+ * tb_port_release_in_hopid() - Release allocated input HopID from port
+ * @port: Port whose HopID to release
+ * @hopid: HopID to release
+ */
+void tb_port_release_in_hopid(struct tb_port *port, int hopid)
+{
+	ida_simple_remove(&port->in_hopids, hopid);
+}
+
+/**
+ * tb_port_release_out_hopid() - Release allocated output HopID from port
+ * @port: Port whose HopID to release
+ * @hopid: HopID to release
+ */
+void tb_port_release_out_hopid(struct tb_port *port, int hopid)
+{
+	ida_simple_remove(&port->out_hopids, hopid);
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
@@ -1055,9 +1132,17 @@ static const struct attribute_group *switch_groups[] = {
 static void tb_switch_release(struct device *dev)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
+	int i;
 
 	dma_port_free(sw->dma_port);
 
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		if (!sw->ports[i].disabled) {
+			ida_destroy(&sw->ports[i].in_hopids);
+			ida_destroy(&sw->ports[i].out_hopids);
+		}
+	}
+
 	kfree(sw->uuid);
 	kfree(sw->device_name);
 	kfree(sw->vendor_name);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index d1f8e9722f33..1cb5009195f9 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -127,6 +127,8 @@ struct tb_switch {
  * @dual_link_port: If the switch is connected using two ports, points
  *		    to the other port.
  * @link_nr: Is this primary or secondary port on the dual_link.
+ * @in_hopids: Currently allocated input HopIDs
+ * @out_hopids: Currently allocated output HopIDs
  */
 struct tb_port {
 	struct tb_regs_port_header config;
@@ -139,6 +141,8 @@ struct tb_port {
 	bool disabled;
 	struct tb_port *dual_link_port;
 	u8 link_nr:1;
+	struct ida in_hopids;
+	struct ida out_hopids;
 };
 
 /**
@@ -194,6 +198,9 @@ struct tb_path {
 	int path_length; /* number of hops */
 };
 
+/* HopIDs 0-7 are reserved by the Thunderbolt protocol */
+#define TB_PATH_MIN_HOPID	8
+
 /**
  * struct tb_cm_ops - Connection manager specific operations vector
  * @driver_ready: Called right after control channel is started. Used by
@@ -453,6 +460,10 @@ static inline bool tb_switch_is_er(const struct tb_switch *sw)
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
+int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
+void tb_port_release_in_hopid(struct tb_port *port, int hopid);
+int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
+void tb_port_release_out_hopid(struct tb_port *port, int hopid);
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
-- 
2.20.1

