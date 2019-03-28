Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46362183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfC1Mid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:49143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="218369189"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AB311C64; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 19/36] thunderbolt: Extend tunnel creation to more than 2 adjacent switches
Date:   Thu, 28 Mar 2019 15:36:16 +0300
Message-Id: <20190328123633.42882-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
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

While there add name to struct tb_path to make debugging easier.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 121 ++++++++++++++++++++++++++++++-----
 drivers/thunderbolt/tb.h     |   5 +-
 drivers/thunderbolt/tunnel.c |  56 ++++------------
 3 files changed, 124 insertions(+), 58 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 97f37f86fb75..d3f5df779d8d 100644
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
+		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
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
@@ -136,12 +227,12 @@ void tb_path_deactivate(struct tb_path *path)
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
@@ -164,12 +255,12 @@ int tb_path_activate(struct tb_path *path)
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
index c797512dfb05..1c7d67a829d3 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -184,6 +184,7 @@ enum tb_path_port {
  */
 struct tb_path {
 	struct tb *tb;
+	const char *name;
 	int nfc_credits; /* non flow controlled credits */
 	enum tb_path_port ingress_shared_buffer;
 	enum tb_path_port egress_shared_buffer;
@@ -504,7 +505,9 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
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

