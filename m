Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC85C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7C2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfDJNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:38:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:36706 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbfDJNhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="149663054"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2019 06:37:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 56D9168E; Wed, 10 Apr 2019 16:36:55 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com, Joe Perches <joe@perches.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v4 19/36] thunderbolt: Extend tunnel creation to more than 2 adjacent switches
Date:   Wed, 10 Apr 2019 16:36:36 +0300
Message-Id: <20190410133653.88061-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can allocate hop IDs per port on a path, we can take
advantage of this and create tunnels covering longer paths than just
between two adjacent switches. PCIe actually does not need this as it
is typically a daisy chain between two adjacent switches but this way we
do not need to hard-code creation of the tunnel.

While there add name to struct tb_path to make debugging easier, and
update kernel-doc comments.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 121 ++++++++++++++++++++++++++++++-----
 drivers/thunderbolt/tb.h     |  54 ++++++++++++----
 drivers/thunderbolt/tunnel.c |  56 ++++------------
 3 files changed, 163 insertions(+), 68 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 8c2e19a6117a..a7cdac7f6808 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -31,23 +31,100 @@ static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 }
 
 /**
- * tb_path_alloc() - allocate a thunderbolt path
+ * tb_path_alloc() - allocate a thunderbolt path between two ports
+ * @tb: Domain pointer
+ * @src: Source port of the path
+ * @src_hopid: HopID used for the first ingress port in the path
+ * @dst: Destination port of the path
+ * @dst_hopid: HopID used for the last egress port in the path
+ * @link_nr: Preferred link if there are dual links on the path
+ * @name: Name of the path
+ *
+ * Creates path between two ports starting with given @src_hopid. Reserves
+ * HopIDs for each port (they can be different from @src_hopid depending on
+ * how many HopIDs each port already have reserved). If there are dual
+ * links on the path, prioritizes using @link_nr.
  *
  * Return: Returns a tb_path on success or NULL on failure.
  */
-struct tb_path *tb_path_alloc(struct tb *tb, int num_hops)
+struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
+			      struct tb_port *dst, int dst_hopid, int link_nr,
+			      const char *name)
 {
-	struct tb_path *path = kzalloc(sizeof(*path), GFP_KERNEL);
+	struct tb_port *in_port, *out_port;
+	int in_hopid, out_hopid;
+	struct tb_path *path;
+	size_t num_hops;
+	int i, ret;
+
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return NULL;
+
+	/*
+	 * Number of hops on a path is the distance between the two
+	 * switches plus the source adapter port.
+	 */
+	num_hops = abs(tb_route_length(tb_route(src->sw)) -
+		       tb_route_length(tb_route(dst->sw))) + 1;
+
 	path->hops = kcalloc(num_hops, sizeof(*path->hops), GFP_KERNEL);
 	if (!path->hops) {
 		kfree(path);
 		return NULL;
 	}
+
+	in_hopid = src_hopid;
+	out_port = NULL;
+
+	for (i = 0; i < num_hops; i++) {
+		in_port = tb_next_port_on_path(src, dst, out_port);
+		if (!in_port)
+			goto err;
+
+		if (in_port->dual_link_port && in_port->link_nr != link_nr)
+			in_port = in_port->dual_link_port;
+
+		ret = tb_port_alloc_in_hopid(in_port, in_hopid, in_hopid);
+		if (ret < 0)
+			goto err;
+		in_hopid = ret;
+
+		out_port = tb_next_port_on_path(src, dst, in_port);
+		if (!out_port)
+			goto err;
+
+		if (out_port->dual_link_port && out_port->link_nr != link_nr)
+			out_port = out_port->dual_link_port;
+
+		if (i == num_hops - 1)
+			ret = tb_port_alloc_out_hopid(out_port, dst_hopid,
+						      dst_hopid);
+		else
+			ret = tb_port_alloc_out_hopid(out_port, -1, -1);
+
+		if (ret < 0)
+			goto err;
+		out_hopid = ret;
+
+		path->hops[i].in_hop_index = in_hopid;
+		path->hops[i].in_port = in_port;
+		path->hops[i].in_counter_index = -1;
+		path->hops[i].out_port = out_port;
+		path->hops[i].next_hop_index = out_hopid;
+
+		in_hopid = out_hopid;
+	}
+
 	path->tb = tb;
 	path->path_length = num_hops;
+	path->name = name;
+
 	return path;
+
+err:
+	tb_path_free(path);
+	return NULL;
 }
 
 /**
@@ -55,10 +132,24 @@ struct tb_path *tb_path_alloc(struct tb *tb, int num_hops)
  */
 void tb_path_free(struct tb_path *path)
 {
+	int i;
+
 	if (path->activated) {
 		tb_WARN(path->tb, "trying to free an activated path\n")
 		return;
 	}
+
+	for (i = 0; i < path->path_length; i++) {
+		const struct tb_path_hop *hop = &path->hops[i];
+
+		if (hop->in_port)
+			tb_port_release_in_hopid(hop->in_port,
+						 hop->in_hop_index);
+		if (hop->out_port)
+			tb_port_release_out_hopid(hop->out_port,
+						  hop->next_hop_index);
+	}
+
 	kfree(path->hops);
 	kfree(path);
 }
@@ -133,12 +224,12 @@ void tb_path_deactivate(struct tb_path *path)
 		tb_WARN(path->tb, "trying to deactivate an inactive path\n");
 		return;
 	}
-	tb_info(path->tb,
-		"deactivating path from %llx:%x to %llx:%x\n",
-		tb_route(path->hops[0].in_port->sw),
-		path->hops[0].in_port->port,
-		tb_route(path->hops[path->path_length - 1].out_port->sw),
-		path->hops[path->path_length - 1].out_port->port);
+	tb_dbg(path->tb,
+	       "deactivating %s path from %llx:%x to %llx:%x\n",
+	       path->name, tb_route(path->hops[0].in_port->sw),
+	       path->hops[0].in_port->port,
+	       tb_route(path->hops[path->path_length - 1].out_port->sw),
+	       path->hops[path->path_length - 1].out_port->port);
 	__tb_path_deactivate_hops(path, 0);
 	__tb_path_deallocate_nfc(path, 0);
 	path->activated = false;
@@ -161,12 +252,12 @@ int tb_path_activate(struct tb_path *path)
 		return -EINVAL;
 	}
 
-	tb_info(path->tb,
-		"activating path from %llx:%x to %llx:%x\n",
-		tb_route(path->hops[0].in_port->sw),
-		path->hops[0].in_port->port,
-		tb_route(path->hops[path->path_length - 1].out_port->sw),
-		path->hops[path->path_length - 1].out_port->port);
+	tb_dbg(path->tb,
+	       "activating %s path from %llx:%x to %llx:%x\n",
+	       path->name, tb_route(path->hops[0].in_port->sw),
+	       path->hops[0].in_port->port,
+	       tb_route(path->hops[path->path_length - 1].out_port->sw),
+	       path->hops[path->path_length - 1].out_port->port);
 
 	/* Clear counters. */
 	for (i = path->path_length - 1; i >= 0; i--) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 11d5ab53ad36..322bbdc00d95 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -147,11 +147,22 @@ struct tb_port {
 
 /**
  * struct tb_path_hop - routing information for a tb_path
+ * @in_port: Ingress port of a switch
+ * @out_port: Egress port of a switch where the packet is routed out
+ *	      (must be on the same switch than @in_port)
+ * @in_hop_index: HopID where the path configuration entry is placed in
+ *		  the path config space of @in_port.
+ * @in_counter_index: Used counter index (not used in the driver
+ *		      currently, %-1 to disable)
+ * @next_hop_index: HopID of the packet when it is routed out from @out_port
  *
  * Hop configuration is always done on the IN port of a switch.
  * in_port and out_port have to be on the same switch. Packets arriving on
  * in_port with "hop" = in_hop_index will get routed to through out_port. The
- * next hop to take (on out_port->remote) is determined by next_hop_index.
+ * next hop to take (on out_port->remote) is determined by
+ * next_hop_index. When routing packet to another switch (out->remote is
+ * set) the @next_hop_index must match the @in_hop_index of that next
+ * hop to make routing possible.
  *
  * in_counter_index is the index of a counter (in TB_CFG_COUNTERS) on the in
  * port.
@@ -160,31 +171,50 @@ struct tb_path_hop {
 	struct tb_port *in_port;
 	struct tb_port *out_port;
 	int in_hop_index;
-	int in_counter_index; /* write -1 to disable counters for this hop. */
+	int in_counter_index;
 	int next_hop_index;
 };
 
 /**
  * enum tb_path_port - path options mask
+ * @TB_PATH_NONE: Do not activate on any hop on path
+ * @TB_PATH_SOURCE: Activate on the first hop (out of src)
+ * @TB_PATH_INTERNAL: Activate on the intermediate hops (not the first/last)
+ * @TB_PATH_DESTINATION: Activate on the last hop (into dst)
+ * @TB_PATH_ALL: Activate on all hops on the path
  */
 enum tb_path_port {
 	TB_PATH_NONE = 0,
-	TB_PATH_SOURCE = 1, /* activate on the first hop (out of src) */
-	TB_PATH_INTERNAL = 2, /* activate on other hops (not the first/last) */
-	TB_PATH_DESTINATION = 4, /* activate on the last hop (into dst) */
+	TB_PATH_SOURCE = 1,
+	TB_PATH_INTERNAL = 2,
+	TB_PATH_DESTINATION = 4,
 	TB_PATH_ALL = 7,
 };
 
 /**
  * struct tb_path - a unidirectional path between two ports
+ * @tb: Pointer to the domain structure
+ * @name: Name of the path (used for debugging)
+ * @nfc_credits: Number of non flow controlled credits allocated for the path
+ * @ingress_shared_buffer: Shared buffering used for ingress ports on the path
+ * @egress_shared_buffer: Shared buffering used for egress ports on the path
+ * @ingress_fc_enable: Flow control for ingress ports on the path
+ * @egress_fc_enable: Flow control for egress ports on the path
+ * @priority: Priority group if the path
+ * @weight: Weight of the path inside the priority group
+ * @drop_packages: Drop packages from queue tail or head
+ * @activated: Is the path active
+ * @hops: Path hops
+ * @path_length: How many hops the path uses
  *
- * A path consists of a number of hops (see tb_path_hop). To establish a PCIe
- * tunnel two paths have to be created between the two PCIe ports.
- *
+ * A path consists of a number of hops (see &struct tb_path_hop). To
+ * establish a PCIe tunnel two paths have to be created between the two
+ * PCIe ports.
  */
 struct tb_path {
 	struct tb *tb;
-	int nfc_credits; /* non flow controlled credits */
+	const char *name;
+	int nfc_credits;
 	enum tb_path_port ingress_shared_buffer;
 	enum tb_path_port egress_shared_buffer;
 	enum tb_path_port ingress_fc_enable;
@@ -195,7 +225,7 @@ struct tb_path {
 	bool drop_packages;
 	bool activated;
 	struct tb_path_hop *hops;
-	int path_length; /* number of hops */
+	int path_length;
 };
 
 /* HopIDs 0-7 are reserved by the Thunderbolt protocol */
@@ -503,7 +533,9 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
-struct tb_path *tb_path_alloc(struct tb *tb, int num_hops);
+struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
+			      struct tb_port *dst, int dst_hopid, int link_nr,
+			      const char *name);
 void tb_path_free(struct tb_path *path);
 int tb_path_activate(struct tb_path *path);
 void tb_path_deactivate(struct tb_path *path);
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 20ce28276f7a..91d7e00516b4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -12,6 +12,9 @@
 #include "tunnel.h"
 #include "tb.h"
 
+/* PCIe adapters use always HopID of 8 for both directions */
+#define TB_PCI_HOPID			8
+
 #define TB_PCI_PATH_DOWN		0
 #define TB_PCI_PATH_UP			1
 
@@ -86,21 +89,13 @@ static void tb_pci_init_path(struct tb_path *path)
  * Allocate a PCI tunnel. The ports must be of type TB_TYPE_PCIE_UP and
  * TB_TYPE_PCIE_DOWN.
  *
- * Currently only paths consisting of two hops are supported (that is the
- * ports must be on "adjacent" switches).
- *
- * The paths are hard-coded to use hop 8 (the only working hop id available on
- * my thunderbolt devices). Therefore at most ONE path per device may be
- * activated.
- *
  * Return: Returns a tb_tunnel on success or NULL on failure.
  */
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down)
 {
-	struct tb_path *path_to_up;
-	struct tb_path *path_to_down;
 	struct tb_tunnel *tunnel;
+	struct tb_path *path;
 
 	tunnel = tb_tunnel_alloc(tb, 2);
 	if (!tunnel)
@@ -110,46 +105,23 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	tunnel->src_port = down;
 	tunnel->dst_port = up;
 
-	path_to_up = tb_path_alloc(tb, 2);
-	if (!path_to_up) {
+	path = tb_path_alloc(tb, down, TB_PCI_HOPID, up, TB_PCI_HOPID, 0,
+			     "PCIe Down");
+	if (!path) {
 		tb_tunnel_free(tunnel);
 		return NULL;
 	}
-	tunnel->paths[TB_PCI_PATH_UP] = path_to_up;
+	tb_pci_init_path(path);
+	tunnel->paths[TB_PCI_PATH_UP] = path;
 
-	path_to_down = tb_path_alloc(tb, 2);
-	if (!path_to_down) {
+	path = tb_path_alloc(tb, up, TB_PCI_HOPID, down, TB_PCI_HOPID, 0,
+			     "PCIe Up");
+	if (!path) {
 		tb_tunnel_free(tunnel);
 		return NULL;
 	}
-	tunnel->paths[TB_PCI_PATH_DOWN] = path_to_down;
-
-	tb_pci_init_path(path_to_up);
-	tb_pci_init_path(path_to_down);
-
-	path_to_up->hops[0].in_port = down;
-	path_to_up->hops[0].in_hop_index = 8;
-	path_to_up->hops[0].in_counter_index = -1;
-	path_to_up->hops[0].out_port = tb_upstream_port(up->sw)->remote;
-	path_to_up->hops[0].next_hop_index = 8;
-
-	path_to_up->hops[1].in_port = tb_upstream_port(up->sw);
-	path_to_up->hops[1].in_hop_index = 8;
-	path_to_up->hops[1].in_counter_index = -1;
-	path_to_up->hops[1].out_port = up;
-	path_to_up->hops[1].next_hop_index = 8;
-
-	path_to_down->hops[0].in_port = up;
-	path_to_down->hops[0].in_hop_index = 8;
-	path_to_down->hops[0].in_counter_index = -1;
-	path_to_down->hops[0].out_port = tb_upstream_port(up->sw);
-	path_to_down->hops[0].next_hop_index = 8;
-
-	path_to_down->hops[1].in_port = tb_upstream_port(up->sw)->remote;
-	path_to_down->hops[1].in_hop_index = 8;
-	path_to_down->hops[1].in_counter_index = -1;
-	path_to_down->hops[1].out_port = down;
-	path_to_down->hops[1].next_hop_index = 8;
+	tb_pci_init_path(path);
+	tunnel->paths[TB_PCI_PATH_DOWN] = path;
 
 	return tunnel;
 }
-- 
2.20.1

