Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74225C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E312183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfC1MiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:9515 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="156023601"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2019 05:36:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 767E4187A; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
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
Subject: [PATCH v3 34/36] thunderbolt: Make rest of the logging to happen at debug level
Date:   Thu, 28 Mar 2019 15:36:31 +0300
Message-Id: <20190328123633.42882-35-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver can handle every possible tunnel types there is no
point to log everything as info level so turn these to happen at debug
level instead.

While at it remove duplicated tunnel activation log message
(tb_tunnel_activate() calls tb_tunnel_restart() which print the same
message).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/ctl.c    |  2 +-
 drivers/thunderbolt/icm.c    |  2 +-
 drivers/thunderbolt/path.c   |  6 +++---
 drivers/thunderbolt/switch.c | 19 +++++++++----------
 drivers/thunderbolt/tb.c     | 11 +++++------
 drivers/thunderbolt/tunnel.c |  6 ++----
 6 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 73b386de4d15..2427d73be731 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -720,7 +720,7 @@ int tb_cfg_error(struct tb_ctl *ctl, u64 route, u32 port,
 		.port = port,
 		.error = error,
 	};
-	tb_ctl_info(ctl, "resetting error on %llx:%x.\n", route, port);
+	tb_ctl_dbg(ctl, "resetting error on %llx:%x.\n", route, port);
 	return tb_ctl_tx(ctl, &pkg, sizeof(pkg), TB_CFG_PKG_ERROR);
 }
 
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index d1f6ec89763c..597507bbd8ed 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1568,7 +1568,7 @@ static int icm_firmware_start(struct tb *tb, struct tb_nhi *nhi)
 	if (val & REG_FW_STS_ICM_EN)
 		return 0;
 
-	dev_info(&nhi->pdev->dev, "starting ICM firmware\n");
+	dev_dbg(&nhi->pdev->dev, "starting ICM firmware\n");
 
 	ret = icm_firmware_reset(tb, nhi);
 	if (ret)
diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index d06fe8bf8872..2dbfb3e1c3fc 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -503,8 +503,8 @@ int tb_path_activate(struct tb_path *path)
 					    & out_mask;
 		hop.unknown3 = 0;
 
-		tb_port_info(path->hops[i].in_port, "Writing hop %d, index %d",
-			     i, path->hops[i].in_hop_index);
+		tb_port_dbg(path->hops[i].in_port, "Writing hop %d, index %d",
+			    i, path->hops[i].in_hop_index);
 		tb_dump_hop(path->hops[i].in_port, &hop);
 		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
 				    2 * path->hops[i].in_hop_index, 2);
@@ -515,7 +515,7 @@ int tb_path_activate(struct tb_path *path)
 		}
 	}
 	path->activated = true;
-	tb_info(path->tb, "path activation complete\n");
+	tb_dbg(path->tb, "path activation complete\n");
 	return 0;
 err:
 	tb_WARN(path->tb, "path activation failed\n");
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a5345a6225bd..c1b016574fb4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -493,23 +493,22 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 		if (state < 0)
 			return state;
 		if (state == TB_PORT_DISABLED) {
-			tb_port_info(port, "is disabled (state: 0)\n");
+			tb_port_dbg(port, "is disabled (state: 0)\n");
 			return 0;
 		}
 		if (state == TB_PORT_UNPLUGGED) {
 			if (wait_if_unplugged) {
 				/* used during resume */
-				tb_port_info(port,
-					     "is unplugged (state: 7), retrying...\n");
+				tb_port_dbg(port,
+					    "is unplugged (state: 7), retrying...\n");
 				msleep(100);
 				continue;
 			}
-			tb_port_info(port, "is unplugged (state: 7)\n");
+			tb_port_dbg(port, "is unplugged (state: 7)\n");
 			return 0;
 		}
 		if (state == TB_PORT_UP) {
-			tb_port_info(port,
-				     "is connected, link is up (state: 2)\n");
+			tb_port_dbg(port, "is connected, link is up (state: 2)\n");
 			return 1;
 		}
 
@@ -517,9 +516,9 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 		 * After plug-in the state is TB_PORT_CONNECTING. Give it some
 		 * time.
 		 */
-		tb_port_info(port,
-			     "is connected, link is not up (state: %d), retrying...\n",
-			     state);
+		tb_port_dbg(port,
+			    "is connected, link is not up (state: %d), retrying...\n",
+			    state);
 		msleep(100);
 	}
 	tb_port_warn(port,
@@ -585,7 +584,7 @@ int tb_port_set_initial_credits(struct tb_port *port, u32 credits)
 int tb_port_clear_counter(struct tb_port *port, int counter)
 {
 	u32 zero[3] = { 0, 0, 0 };
-	tb_port_info(port, "clearing counter %d\n", counter);
+	tb_port_dbg(port, "clearing counter %d\n", counter);
 	return tb_port_write(port, zero, TB_CFG_COUNTERS, 3 * counter, 3);
 }
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e39fc1e35e6b..1f7a9e1cc09c 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -556,18 +556,17 @@ static void tb_handle_hotplug(struct work_struct *work)
 		} else if (tb_port_is_dpout(port)) {
 			tb_teardown_dp(tb, port);
 		} else {
-			tb_port_info(port,
-				     "got unplug event for disconnected port, ignoring\n");
+			tb_port_dbg(port,
+				   "got unplug event for disconnected port, ignoring\n");
 		}
 	} else if (port->remote) {
-		tb_port_info(port,
-			     "got plug event for connected port, ignoring\n");
+		tb_port_dbg(port, "got plug event for connected port, ignoring\n");
 	} else {
 		if (tb_port_is_null(port)) {
-			tb_port_info(port, "hotplug: scanning\n");
+			tb_port_dbg(port, "hotplug: scanning\n");
 			tb_scan_port(port);
 			if (!port->remote)
-				tb_port_info(port, "hotplug: no switch found\n");
+				tb_port_dbg(port, "hotplug: no switch found\n");
 		} else if (tb_port_is_dpout(port)) {
 			tb_tunnel_dp(tb, port);
 		}
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 9f9b26b12d0a..31d0234837e4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -611,7 +611,7 @@ int tb_tunnel_restart(struct tb_tunnel *tunnel)
 {
 	int res, i;
 
-	tb_tunnel_info(tunnel, "activating\n");
+	tb_tunnel_dbg(tunnel, "activating\n");
 
 	/*
 	 * Make sure all paths are properly disabled before enabling
@@ -660,8 +660,6 @@ int tb_tunnel_activate(struct tb_tunnel *tunnel)
 {
 	int i;
 
-	tb_tunnel_info(tunnel, "activating\n");
-
 	for (i = 0; i < tunnel->npaths; i++) {
 		if (tunnel->paths[i]->activated) {
 			tb_tunnel_WARN(tunnel,
@@ -681,7 +679,7 @@ void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
 {
 	int i;
 
-	tb_tunnel_info(tunnel, "deactivating\n");
+	tb_tunnel_dbg(tunnel, "deactivating\n");
 
 	if (tunnel->activate)
 		tunnel->activate(tunnel, false);
-- 
2.20.1

