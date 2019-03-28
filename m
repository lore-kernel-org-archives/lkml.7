Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4412173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfC1MhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:37:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:31892 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfC1Mgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="311139592"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5DCB317D1; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
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
Subject: [PATCH v3 32/36] thunderbolt: Add support for XDomain connections
Date:   Thu, 28 Mar 2019 15:36:29 +0300
Message-Id: <20190328123633.42882-33-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two domains (hosts) can be connected through a Thunderbolt cable and in
that case they can start software services such as networking over the
high-speed DMA paths. Now that we have all the basic building blocks in
place to create DMA tunnels over the Thunderbolt fabric we can add this
support to the software connection manager as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c |  29 +++++-
 drivers/thunderbolt/tb.c     | 167 ++++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 460f2bcad40a..a5345a6225bd 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1845,6 +1845,8 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 	for (i = 0; i <= sw->config.max_port_number; i++) {
 		if (tb_port_has_remote(&sw->ports[i]))
 			tb_sw_set_unplugged(sw->ports[i].remote->sw);
+		else if (sw->ports[i].xdomain)
+			sw->ports[i].xdomain->is_unplugged = true;
 	}
 }
 
@@ -1860,6 +1862,17 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (tb_route(sw)) {
 		u64 uid;
 
+		/*
+		 * Check first that we can still read the switch config
+		 * space. It may be that there is now another domain
+		 * connected.
+		 */
+		err = tb_cfg_get_upstream_port(sw->tb->ctl, tb_route(sw));
+		if (err < 0) {
+			tb_sw_info(sw, "switch not present anymore\n");
+			return err;
+		}
+
 		err = tb_drom_read_uid_only(sw, &uid);
 		if (err) {
 			tb_sw_warn(sw, "uid read failed\n");
@@ -1890,14 +1903,22 @@ int tb_switch_resume(struct tb_switch *sw)
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		struct tb_port *port = &sw->ports[i];
 
-		if (!tb_port_has_remote(port))
+		if (!tb_port_has_remote(port) && !port->xdomain)
 			continue;
 
-		if (tb_wait_for_port(port, true) <= 0
-			|| tb_switch_resume(port->remote->sw)) {
+		if (tb_wait_for_port(port, true) <= 0) {
 			tb_port_warn(port,
 				     "lost during suspend, disconnecting\n");
-			tb_sw_set_unplugged(port->remote->sw);
+			if (tb_port_has_remote(port))
+				tb_sw_set_unplugged(port->remote->sw);
+			else if (port->xdomain)
+				port->xdomain->is_unplugged = true;
+		} else if (tb_port_has_remote(port)) {
+			if (tb_switch_resume(port->remote->sw)) {
+				tb_port_warn(port,
+					     "lost during suspend, disconnecting\n");
+				tb_sw_set_unplugged(port->remote->sw);
+			}
 		}
 	}
 	return 0;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c5e82c4dcb64..e39fc1e35e6b 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -101,6 +101,28 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 	}
 }
 
+static void tb_scan_xdomain(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	struct tb *tb = sw->tb;
+	struct tb_xdomain *xd;
+	u64 route;
+
+	route = tb_downstream_route(port);
+	xd = tb_xdomain_find_by_route(tb, route);
+	if (xd) {
+		tb_xdomain_put(xd);
+		return;
+	}
+
+	xd = tb_xdomain_alloc(tb, &sw->dev, route, tb->root_switch->uuid,
+			      NULL);
+	if (xd) {
+		tb_port_at(route, sw)->xdomain = xd;
+		tb_xdomain_add(xd);
+	}
+}
+
 static void tb_scan_port(struct tb_port *port);
 
 /**
@@ -143,19 +165,36 @@ static void tb_scan_port(struct tb_port *port)
 	if (tb_wait_for_port(port, false) <= 0)
 		return;
 	if (port->remote) {
-		tb_port_WARN(port, "port already has a remote!\n");
+		tb_port_dbg(port, "port already has a remote\n");
 		return;
 	}
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
-	if (IS_ERR(sw))
+	if (IS_ERR(sw)) {
+		/*
+		 * If there is an error accessing the connected switch
+		 * it may be connected to another domain. Also we allow
+		 * the other domain to be connected to a max depth switch.
+		 */
+		if (PTR_ERR(sw) == -EIO || PTR_ERR(sw) == -EADDRNOTAVAIL)
+			tb_scan_xdomain(port);
 		return;
+	}
 
 	if (tb_switch_configure(sw)) {
 		tb_switch_put(sw);
 		return;
 	}
 
+	/*
+	 * If there was previously another domain connected remove it
+	 * first.
+	 */
+	if (port->xdomain) {
+		tb_xdomain_remove(port->xdomain);
+		port->xdomain = NULL;
+	}
+
 	/*
 	 * Do not send uevents until we have discovered all existing
 	 * tunnels and know which switches were authorized already by
@@ -393,6 +432,65 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 	return 0;
 }
 
+static int tb_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_port *nhi_port, *dst_port;
+	struct tb_tunnel *tunnel;
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	dst_port = tb_port_at(xd->route, sw);
+	nhi_port = tb_find_port(tb->root_switch, TB_TYPE_NHI);
+
+	mutex_lock(&tb->lock);
+	tunnel = tb_tunnel_alloc_dma(tb, nhi_port, dst_port, xd->transmit_ring,
+				     xd->transmit_path, xd->receive_ring,
+				     xd->receive_path);
+	if (!tunnel) {
+		mutex_unlock(&tb->lock);
+		return -ENOMEM;
+	}
+
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(nhi_port,
+			     "DMA tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		mutex_unlock(&tb->lock);
+		return -EIO;
+	}
+
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	mutex_unlock(&tb->lock);
+	return 0;
+}
+
+static void __tb_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	struct tb_port *dst_port;
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	dst_port = tb_port_at(xd->route, sw);
+
+	/*
+	 * It is possible that the tunnel was already teared down (in
+	 * case of cable disconnect) so it is fine if we cannot find it
+	 * here anymore.
+	 */
+	tb_free_tunnel(tb, TB_TUNNEL_DMA, NULL, dst_port);
+}
+
+static int tb_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	if (!xd->is_unplugged) {
+		mutex_lock(&tb->lock);
+		__tb_disconnect_xdomain_paths(tb, xd);
+		mutex_unlock(&tb->lock);
+	}
+	return 0;
+}
+
 /* hotplug handling */
 
 /**
@@ -432,13 +530,29 @@ static void tb_handle_hotplug(struct work_struct *work)
 	}
 	if (ev->unplug) {
 		if (tb_port_has_remote(port)) {
-			tb_port_info(port, "unplugged\n");
+			tb_port_dbg(port, "switch unplugged\n");
 			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 			if (port->dual_link_port)
 				port->dual_link_port->remote = NULL;
+		} else if (port->xdomain) {
+			struct tb_xdomain *xd = tb_xdomain_get(port->xdomain);
+
+			tb_port_dbg(port, "xdomain unplugged\n");
+			/*
+			 * Service drivers are unbound during
+			 * tb_xdomain_remove() so setting XDomain as
+			 * unplugged here prevents deadlock if they call
+			 * tb_xdomain_disable_paths(). We will tear down
+			 * the path below.
+			 */
+			xd->is_unplugged = true;
+			tb_xdomain_remove(xd);
+			port->xdomain = NULL;
+			__tb_disconnect_xdomain_paths(tb, xd);
+			tb_xdomain_put(xd);
 		} else if (tb_port_is_dpout(port)) {
 			tb_teardown_dp(tb, port);
 		} else {
@@ -500,8 +614,16 @@ static void tb_stop(struct tb *tb)
 	struct tb_tunnel *n;
 
 	/* tunnels are only present after everything has been initialized */
-	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
+	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
+		/*
+		 * DMA tunnels require the driver to be functional so we
+		 * tear them down. Other protocol tunnels can be left
+		 * intact.
+		 */
+		if (tb_tunnel_is_dma(tunnel))
+			tb_tunnel_deactivate(tunnel);
 		tb_tunnel_free(tunnel);
+	}
 	tb_switch_remove(tb->root_switch);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
@@ -611,13 +733,50 @@ static int tb_resume_noirq(struct tb *tb)
 	return 0;
 }
 
+static int tb_free_unplugged_xdomains(struct tb_switch *sw)
+{
+	int i, ret = 0;
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		struct tb_port *port = &sw->ports[i];
+
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->xdomain && port->xdomain->is_unplugged) {
+			tb_xdomain_remove(port->xdomain);
+			port->xdomain = NULL;
+			ret++;
+		} else if (port->remote) {
+			ret += tb_free_unplugged_xdomains(port->remote->sw);
+		}
+	}
+
+	return ret;
+}
+
+static void tb_complete(struct tb *tb)
+{
+	/*
+	 * Release any unplugged XDomains and if there is a case where
+	 * another domain is swapped in place of unplugged XDomain we
+	 * need to run another rescan.
+	 */
+	mutex_lock(&tb->lock);
+	if (tb_free_unplugged_xdomains(tb->root_switch))
+		tb_scan_switch(tb->root_switch);
+	mutex_unlock(&tb->lock);
+}
+
 static const struct tb_cm_ops tb_cm_ops = {
 	.start = tb_start,
 	.stop = tb_stop,
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
+	.complete = tb_complete,
 	.handle_event = tb_handle_event,
 	.approve_switch = tb_tunnel_pci,
+	.approve_xdomain_paths = tb_approve_xdomain_paths,
+	.disconnect_xdomain_paths = tb_disconnect_xdomain_paths,
 };
 
 struct tb *tb_probe(struct tb_nhi *nhi)
-- 
2.20.1

