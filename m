Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE4CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DCD2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405071AbfJWLX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:23:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:29700 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404825AbfJWLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="398010774"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4C9B253F; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] thunderbolt: Add helper macro to iterate over switch ports
Date:   Wed, 23 Oct 2019 14:21:37 +0300
Message-Id: <20191023112154.64235-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are quite many places in the driver where we iterate over each
port in the switch. To make it bit more convenient, add a macro that can
be used to iterate over each port and convert existing call sites to use it.

This is based on code by Lukas Wunner.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c     | 12 +++-----
 drivers/thunderbolt/switch.c  | 57 ++++++++++++++++++-----------------
 drivers/thunderbolt/tb.c      | 54 ++++++++++++++++-----------------
 drivers/thunderbolt/tb.h      | 11 +++++++
 drivers/thunderbolt/xdomain.c |  5 ++-
 5 files changed, 74 insertions(+), 65 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 245588f691e7..24625880692e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1893,14 +1893,12 @@ static int icm_suspend(struct tb *tb)
  */
 static void icm_unplug_children(struct tb_switch *sw)
 {
-	unsigned int i;
+	struct tb_port *port;
 
 	if (tb_route(sw))
 		sw->is_unplugged = true;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
-
+	tb_switch_for_each_port(sw, port) {
 		if (port->xdomain)
 			port->xdomain->is_unplugged = true;
 		else if (tb_port_has_remote(port))
@@ -1936,11 +1934,9 @@ static void remove_unplugged_switch(struct tb_switch *sw)
 
 static void icm_free_unplugged_children(struct tb_switch *sw)
 {
-	unsigned int i;
-
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
+	struct tb_port *port;
 
+	tb_switch_for_each_port(sw, port) {
 		if (port->xdomain && port->xdomain->is_unplugged) {
 			tb_xdomain_remove(port->xdomain);
 			port->xdomain = NULL;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 18905ca68061..e4014053c21a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1390,14 +1390,14 @@ static const struct attribute_group *switch_groups[] = {
 static void tb_switch_release(struct device *dev)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
-	int i;
+	struct tb_port *port;
 
 	dma_port_free(sw->dma_port);
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (!sw->ports[i].disabled) {
-			ida_destroy(&sw->ports[i].in_hopids);
-			ida_destroy(&sw->ports[i].out_hopids);
+	tb_switch_for_each_port(sw, port) {
+		if (!port->disabled) {
+			ida_destroy(&port->in_hopids);
+			ida_destroy(&port->out_hopids);
 		}
 	}
 
@@ -1859,7 +1859,7 @@ int tb_switch_add(struct tb_switch *sw)
  */
 void tb_switch_remove(struct tb_switch *sw)
 {
-	int i;
+	struct tb_port *port;
 
 	if (sw->rpm) {
 		pm_runtime_get_sync(&sw->dev);
@@ -1867,13 +1867,13 @@ void tb_switch_remove(struct tb_switch *sw)
 	}
 
 	/* port 0 is the switch itself and never has a remote */
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i])) {
-			tb_switch_remove(sw->ports[i].remote->sw);
-			sw->ports[i].remote = NULL;
-		} else if (sw->ports[i].xdomain) {
-			tb_xdomain_remove(sw->ports[i].xdomain);
-			sw->ports[i].xdomain = NULL;
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_has_remote(port)) {
+			tb_switch_remove(port->remote->sw);
+			port->remote = NULL;
+		} else if (port->xdomain) {
+			tb_xdomain_remove(port->xdomain);
+			port->xdomain = NULL;
 		}
 	}
 
@@ -1893,7 +1893,8 @@ void tb_switch_remove(struct tb_switch *sw)
  */
 void tb_sw_set_unplugged(struct tb_switch *sw)
 {
-	int i;
+	struct tb_port *port;
+
 	if (sw == sw->tb->root_switch) {
 		tb_sw_WARN(sw, "cannot unplug root switch\n");
 		return;
@@ -1903,17 +1904,19 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 		return;
 	}
 	sw->is_unplugged = true;
-	for (i = 0; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i]))
-			tb_sw_set_unplugged(sw->ports[i].remote->sw);
-		else if (sw->ports[i].xdomain)
-			sw->ports[i].xdomain->is_unplugged = true;
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_has_remote(port))
+			tb_sw_set_unplugged(port->remote->sw);
+		else if (port->xdomain)
+			port->xdomain->is_unplugged = true;
 	}
 }
 
 int tb_switch_resume(struct tb_switch *sw)
 {
-	int i, err;
+	struct tb_port *port;
+	int err;
+
 	tb_sw_dbg(sw, "resuming switch\n");
 
 	/*
@@ -1961,9 +1964,7 @@ int tb_switch_resume(struct tb_switch *sw)
 		return err;
 
 	/* check for surviving downstream switches */
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
-
+	tb_switch_for_each_port(sw, port) {
 		if (!tb_port_has_remote(port) && !port->xdomain)
 			continue;
 
@@ -1987,14 +1988,16 @@ int tb_switch_resume(struct tb_switch *sw)
 
 void tb_switch_suspend(struct tb_switch *sw)
 {
-	int i, err;
+	struct tb_port *port;
+	int err;
+
 	err = tb_plug_events_active(sw, false);
 	if (err)
 		return;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i]))
-			tb_switch_suspend(sw->ports[i].remote->sw);
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_has_remote(port))
+			tb_switch_suspend(port->remote->sw);
 	}
 
 	tb_lc_set_sleep(sw);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 1f7a9e1cc09c..49589b38ff12 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -61,12 +61,10 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 	struct tb *tb = sw->tb;
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_port *port;
-	int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, port) {
 		struct tb_tunnel *tunnel = NULL;
 
-		port = &sw->ports[i];
 		switch (port->config.type) {
 		case TB_TYPE_DP_HDMI_IN:
 			tunnel = tb_tunnel_discover_dp(tb, port);
@@ -95,9 +93,9 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 		list_add_tail(&tunnel->list, &tcm->tunnel_list);
 	}
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i]))
-			tb_discover_tunnels(sw->ports[i].remote->sw);
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_has_remote(port))
+			tb_discover_tunnels(port->remote->sw);
 	}
 }
 
@@ -130,9 +128,10 @@ static void tb_scan_port(struct tb_port *port);
  */
 static void tb_scan_switch(struct tb_switch *sw)
 {
-	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++)
-		tb_scan_port(&sw->ports[i]);
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port)
+		tb_scan_port(port);
 }
 
 /**
@@ -263,10 +262,9 @@ static void tb_free_invalid_tunnels(struct tb *tb)
  */
 static void tb_free_unplugged_children(struct tb_switch *sw)
 {
-	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
+	struct tb_port *port;
 
+	tb_switch_for_each_port(sw, port) {
 		if (!tb_port_has_remote(port))
 			continue;
 
@@ -289,10 +287,13 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 static struct tb_port *tb_find_port(struct tb_switch *sw,
 				    enum tb_port_type type)
 {
-	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++)
-		if (sw->ports[i].config.type == type)
-			return &sw->ports[i];
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port) {
+		if (port->config.type == type)
+			return port;
+	}
+
 	return NULL;
 }
 
@@ -304,18 +305,18 @@ static struct tb_port *tb_find_port(struct tb_switch *sw,
 static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
 					   enum tb_port_type type)
 {
-	int i;
+	struct tb_port *port;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_is_upstream_port(&sw->ports[i]))
+	tb_switch_for_each_port(sw, port) {
+		if (tb_is_upstream_port(port))
 			continue;
-		if (sw->ports[i].config.type != type)
+		if (port->config.type != type)
 			continue;
-		if (!sw->ports[i].cap_adap)
+		if (port->cap_adap)
 			continue;
-		if (tb_port_is_enabled(&sw->ports[i]))
+		if (tb_port_is_enabled(port))
 			continue;
-		return &sw->ports[i];
+		return port;
 	}
 	return NULL;
 }
@@ -734,11 +735,10 @@ static int tb_resume_noirq(struct tb *tb)
 
 static int tb_free_unplugged_xdomains(struct tb_switch *sw)
 {
-	int i, ret = 0;
-
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
+	struct tb_port *port;
+	int ret = 0;
 
+	tb_switch_for_each_port(sw, port) {
 		if (tb_is_upstream_port(port))
 			continue;
 		if (port->xdomain && port->xdomain->is_unplugged) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 455ca490ea87..4c77d5264660 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -530,6 +530,17 @@ struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
 struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route);
 
+/**
+ * tb_switch_for_each_port() - Iterate over each switch port
+ * @sw: Switch whose ports to iterate
+ * @p: Port used as iterator
+ *
+ * Iterates over each switch port skipping the control port (port %0).
+ */
+#define tb_switch_for_each_port(sw, p)					\
+	for ((p) = &(sw)->ports[1];					\
+	     (p) <= &(sw)->ports[(sw)->config.max_port_number]; (p)++)
+
 static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
 {
 	if (sw)
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 4e17a7c7bf0a..880d784398a3 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1404,10 +1404,9 @@ struct tb_xdomain_lookup {
 static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 	const struct tb_xdomain_lookup *lookup)
 {
-	int i;
+	struct tb_port *port;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
+	tb_switch_for_each_port(sw, port) {
 		struct tb_xdomain *xd;
 
 		if (port->xdomain) {
-- 
2.23.0

