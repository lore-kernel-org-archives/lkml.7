Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F8820811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfC1MjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:39:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:35002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126619159"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 05:36:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 91351AE4; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 17/36] thunderbolt: Assign remote for both ports in case of dual link
Date:   Thu, 28 Mar 2019 15:36:14 +0300
Message-Id: <20190328123633.42882-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver only assigns remote port for the primary port if in
case of dual link. This makes things such as walking from one port to
another more complex than necessary because the code needs to change
from secondary to primary port if the path that is established is
created using secondary links.

In order to always assign both remote pointers we need to prevent the
scanning code from following the secondary link. Failing to do that
might cause problems as the same switch may be enumerated twice (or
removed in case of unplug). Handle that properly by introducing a new
function tb_port_has_remote() that returns true only for the primary
port. We also update tb_is_upstream_port() to support both dual link
ports, make it take const port pointer and move it below
tb_upstream_port() to keep similar functions close.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c     | 33 ++++++++++---------------------
 drivers/thunderbolt/switch.c  | 21 ++++++++++----------
 drivers/thunderbolt/tb.c      | 30 +++++++++++++++++++---------
 drivers/thunderbolt/tb.h      | 37 ++++++++++++++++++++++++++++++-----
 drivers/thunderbolt/xdomain.c |  5 +----
 5 files changed, 74 insertions(+), 52 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index bec360eef6cf..805958e53c58 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1761,16 +1761,10 @@ static void icm_unplug_children(struct tb_switch *sw)
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
 
-		if (tb_is_upstream_port(port))
-			continue;
-		if (port->xdomain) {
+		if (port->xdomain)
 			port->xdomain->is_unplugged = true;
-			continue;
-		}
-		if (!port->remote)
-			continue;
-
-		icm_unplug_children(port->remote->sw);
+		else if (tb_port_has_remote(port))
+			icm_unplug_children(port->remote->sw);
 	}
 }
 
@@ -1781,23 +1775,16 @@ static void icm_free_unplugged_children(struct tb_switch *sw)
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
 
-		if (tb_is_upstream_port(port))
-			continue;
-
 		if (port->xdomain && port->xdomain->is_unplugged) {
 			tb_xdomain_remove(port->xdomain);
 			port->xdomain = NULL;
-			continue;
-		}
-
-		if (!port->remote)
-			continue;
-
-		if (port->remote->sw->is_unplugged) {
-			tb_switch_remove(port->remote->sw);
-			port->remote = NULL;
-		} else {
-			icm_free_unplugged_children(port->remote->sw);
+		} else if (tb_port_has_remote(port)) {
+			if (port->remote->sw->is_unplugged) {
+				tb_switch_remove(port->remote->sw);
+				port->remote = NULL;
+			} else {
+				icm_free_unplugged_children(port->remote->sw);
+			}
 		}
 	}
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 30f3d6a9fe90..6f98b3d6eb2a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1580,14 +1580,13 @@ void tb_switch_remove(struct tb_switch *sw)
 
 	/* port 0 is the switch itself and never has a remote */
 	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_is_upstream_port(&sw->ports[i]))
-			continue;
-		if (sw->ports[i].remote)
+		if (tb_port_has_remote(&sw->ports[i])) {
 			tb_switch_remove(sw->ports[i].remote->sw);
-		sw->ports[i].remote = NULL;
-		if (sw->ports[i].xdomain)
+			sw->ports[i].remote = NULL;
+		} else if (sw->ports[i].xdomain) {
 			tb_xdomain_remove(sw->ports[i].xdomain);
-		sw->ports[i].xdomain = NULL;
+			sw->ports[i].xdomain = NULL;
+		}
 	}
 
 	if (!sw->is_unplugged)
@@ -1617,7 +1616,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 	}
 	sw->is_unplugged = true;
 	for (i = 0; i <= sw->config.max_port_number; i++) {
-		if (!tb_is_upstream_port(&sw->ports[i]) && sw->ports[i].remote)
+		if (tb_port_has_remote(&sw->ports[i]))
 			tb_sw_set_unplugged(sw->ports[i].remote->sw);
 	}
 }
@@ -1663,10 +1662,10 @@ int tb_switch_resume(struct tb_switch *sw)
 	/* check for surviving downstream switches */
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
-		if (tb_is_upstream_port(port))
-			continue;
-		if (!port->remote)
+
+		if (!tb_port_has_remote(port))
 			continue;
+
 		if (tb_wait_for_port(port, true) <= 0
 			|| tb_switch_resume(port->remote->sw)) {
 			tb_port_warn(port,
@@ -1685,7 +1684,7 @@ void tb_switch_suspend(struct tb_switch *sw)
 		return;
 
 	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (!tb_is_upstream_port(&sw->ports[i]) && sw->ports[i].remote)
+		if (tb_port_has_remote(&sw->ports[i]))
 			tb_switch_suspend(sw->ports[i].remote->sw);
 	}
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 36dad0a00ac2..0485f4ef9a62 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -47,7 +47,9 @@ static void tb_scan_switch(struct tb_switch *sw)
  */
 static void tb_scan_port(struct tb_port *port)
 {
+	struct tb_port *upstream_port;
 	struct tb_switch *sw;
+
 	if (tb_is_upstream_port(port))
 		return;
 	if (port->config.type != TB_TYPE_PORT)
@@ -80,8 +82,15 @@ static void tb_scan_port(struct tb_port *port)
 		return;
 	}
 
-	port->remote = tb_upstream_port(sw);
-	tb_upstream_port(sw)->remote = port;
+	/* Link the switches using both links if available */
+	upstream_port = tb_upstream_port(sw);
+	port->remote = upstream_port;
+	upstream_port->remote = port;
+	if (port->dual_link_port && upstream_port->dual_link_port) {
+		port->dual_link_port->remote = upstream_port->dual_link_port;
+		upstream_port->dual_link_port->remote = port->dual_link_port;
+	}
+
 	tb_scan_switch(sw);
 }
 
@@ -111,13 +120,15 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 	int i;
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
-		if (tb_is_upstream_port(port))
-			continue;
-		if (!port->remote)
+
+		if (!tb_port_has_remote(port))
 			continue;
+
 		if (port->remote->sw->is_unplugged) {
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
+			if (port->dual_link_port)
+				port->dual_link_port->remote = NULL;
 		} else {
 			tb_free_unplugged_children(port->remote->sw);
 		}
@@ -273,18 +284,19 @@ static void tb_handle_hotplug(struct work_struct *work)
 	}
 	port = &sw->ports[ev->port];
 	if (tb_is_upstream_port(port)) {
-		tb_warn(tb,
-			"hotplug event for upstream port %llx:%x (unplug: %d)\n",
-			ev->route, ev->port, ev->unplug);
+		tb_dbg(tb, "hotplug event for upstream port %llx:%x (unplug: %d)\n",
+		       ev->route, ev->port, ev->unplug);
 		goto put_sw;
 	}
 	if (ev->unplug) {
-		if (port->remote) {
+		if (tb_port_has_remote(port)) {
 			tb_port_info(port, "unplugged\n");
 			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
+			if (port->dual_link_port)
+				port->dual_link_port->remote = NULL;
 		} else {
 			tb_port_info(port,
 				     "got unplug event for disconnected port, ignoring\n");
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 1cb5009195f9..5e317ca87786 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -270,6 +270,19 @@ static inline struct tb_port *tb_upstream_port(struct tb_switch *sw)
 	return &sw->ports[sw->config.upstream_port_number];
 }
 
+/**
+ * tb_is_upstream_port() - Is the port upstream facing
+ * @port: Port to check
+ *
+ * Returns true if @port is upstream facing port. In case of dual link
+ * ports both return true.
+ */
+static inline bool tb_is_upstream_port(const struct tb_port *port)
+{
+	const struct tb_port *upstream_port = tb_upstream_port(port->sw);
+	return port == upstream_port || port->dual_link_port == upstream_port;
+}
+
 static inline u64 tb_route(struct tb_switch *sw)
 {
 	return ((u64) sw->config.route_hi) << 32 | sw->config.route_lo;
@@ -285,6 +298,25 @@ static inline struct tb_port *tb_port_at(u64 route, struct tb_switch *sw)
 	return &sw->ports[port];
 }
 
+/**
+ * tb_port_has_remote() - Does the port have switch connected downstream
+ * @port: Port to check
+ *
+ * Returns true only when the port is primary port and that it has
+ * remote set.
+ */
+static inline bool tb_port_has_remote(const struct tb_port *port)
+{
+	if (tb_is_upstream_port(port))
+		return false;
+	if (!port->remote)
+		return false;
+	if (port->dual_link_port && port->link_nr)
+		return false;
+
+	return true;
+}
+
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
@@ -489,11 +521,6 @@ static inline int tb_route_length(u64 route)
 	return (fls64(route) + TB_ROUTE_SHIFT - 1) / TB_ROUTE_SHIFT;
 }
 
-static inline bool tb_is_upstream_port(struct tb_port *port)
-{
-	return port == tb_upstream_port(port->sw);
-}
-
 /**
  * tb_downstream_route() - get route to downstream switch
  *
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e2fc4543142d..7bae92bc486f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1293,9 +1293,6 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 		struct tb_port *port = &sw->ports[i];
 		struct tb_xdomain *xd;
 
-		if (tb_is_upstream_port(port))
-			continue;
-
 		if (port->xdomain) {
 			xd = port->xdomain;
 
@@ -1310,7 +1307,7 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 				   lookup->route == xd->route) {
 				return xd;
 			}
-		} else if (port->remote) {
+		} else if (tb_port_has_remote(port)) {
 			xd = switch_find_xdomain(port->remote->sw, lookup);
 			if (xd)
 				return xd;
-- 
2.20.1

