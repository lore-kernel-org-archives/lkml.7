Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2290C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C881321A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfJALkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:40:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:8631 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732555AbfJALij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="274967152"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1E93124C; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/22] thunderbolt: Add helper macros to iterate over switch ports
Date:   Tue,  1 Oct 2019 14:38:13 +0300
Message-Id: <20191001113830.13028-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are quite many places in the driver where we iterate over each
port in the switch skipping. To make it bit more consistent provide set
of helper macros that can be used to do this and convert the existing
call sites to these.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c     |  4 ++--
 drivers/thunderbolt/switch.c  | 17 ++++++-----------
 drivers/thunderbolt/tb.c      | 26 +++++++++++++-------------
 drivers/thunderbolt/tb.h      | 35 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/xdomain.c |  2 +-
 5 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 245588f691e7..6550f68f92ce 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1898,7 +1898,7 @@ static void icm_unplug_children(struct tb_switch *sw)
 	if (tb_route(sw))
 		sw->is_unplugged = true;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		struct tb_port *port = &sw->ports[i];
 
 		if (port->xdomain)
@@ -1938,7 +1938,7 @@ static void icm_free_unplugged_children(struct tb_switch *sw)
 {
 	unsigned int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		struct tb_port *port = &sw->ports[i];
 
 		if (port->xdomain && port->xdomain->is_unplugged) {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index f9efd670d032..cc2670dd2698 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1386,7 +1386,7 @@ static void tb_switch_release(struct device *dev)
 
 	dma_port_free(sw->dma_port);
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		if (!sw->ports[i].disabled) {
 			ida_destroy(&sw->ports[i].in_hopids);
 			ida_destroy(&sw->ports[i].out_hopids);
@@ -1850,7 +1850,7 @@ void tb_switch_remove(struct tb_switch *sw)
 	}
 
 	/* port 0 is the switch itself and never has a remote */
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		if (tb_port_has_remote(&sw->ports[i])) {
 			tb_switch_remove(sw->ports[i].remote->sw);
 			sw->ports[i].remote = NULL;
@@ -1886,7 +1886,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 		return;
 	}
 	sw->is_unplugged = true;
-	for (i = 0; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		if (tb_port_has_remote(&sw->ports[i]))
 			tb_sw_set_unplugged(sw->ports[i].remote->sw);
 		else if (sw->ports[i].xdomain)
@@ -1944,12 +1944,9 @@ int tb_switch_resume(struct tb_switch *sw)
 		return err;
 
 	/* check for surviving downstream switches */
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_connected_port(sw, i) {
 		struct tb_port *port = &sw->ports[i];
 
-		if (!tb_port_has_remote(port) && !port->xdomain)
-			continue;
-
 		if (tb_wait_for_port(port, true) <= 0) {
 			tb_port_warn(port,
 				     "lost during suspend, disconnecting\n");
@@ -1975,10 +1972,8 @@ void tb_switch_suspend(struct tb_switch *sw)
 	if (err)
 		return;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i]))
-			tb_switch_suspend(sw->ports[i].remote->sw);
-	}
+	tb_switch_for_each_remote_port(sw, i)
+		tb_switch_suspend(sw->ports[i].remote->sw);
 
 	tb_lc_set_sleep(sw);
 }
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 541295be9bfc..ab42f0fea787 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -63,7 +63,7 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 	struct tb_port *port;
 	int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		struct tb_tunnel *tunnel = NULL;
 
 		port = &sw->ports[i];
@@ -95,10 +95,8 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 		list_add_tail(&tunnel->list, &tcm->tunnel_list);
 	}
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		if (tb_port_has_remote(&sw->ports[i]))
-			tb_discover_tunnels(sw->ports[i].remote->sw);
-	}
+	tb_switch_for_each_remote_port(sw, i)
+		tb_discover_tunnels(sw->ports[i].remote->sw);
 }
 
 static void tb_scan_xdomain(struct tb_port *port)
@@ -131,7 +129,8 @@ static void tb_scan_port(struct tb_port *port);
 static void tb_scan_switch(struct tb_switch *sw)
 {
 	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++)
+
+	tb_switch_for_each_port(sw, i)
 		tb_scan_port(&sw->ports[i]);
 }
 
@@ -267,11 +266,9 @@ static void tb_free_invalid_tunnels(struct tb *tb)
 static void tb_free_unplugged_children(struct tb_switch *sw)
 {
 	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++) {
-		struct tb_port *port = &sw->ports[i];
 
-		if (!tb_port_has_remote(port))
-			continue;
+	tb_switch_for_each_remote_port(sw, i) {
+		struct tb_port *port = &sw->ports[i];
 
 		if (port->remote->sw->is_unplugged) {
 			tb_switch_remove(port->remote->sw);
@@ -293,9 +290,12 @@ static struct tb_port *tb_find_port(struct tb_switch *sw,
 				    enum tb_port_type type)
 {
 	int i;
-	for (i = 1; i <= sw->config.max_port_number; i++)
+
+	tb_switch_for_each_port(sw, i) {
 		if (sw->ports[i].config.type == type)
 			return &sw->ports[i];
+	}
+
 	return NULL;
 }
 
@@ -309,7 +309,7 @@ static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
 {
 	int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		if (tb_is_upstream_port(&sw->ports[i]))
 			continue;
 		if (sw->ports[i].config.type != type)
@@ -739,7 +739,7 @@ static int tb_free_unplugged_xdomains(struct tb_switch *sw)
 {
 	int i, ret = 0;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		struct tb_port *port = &sw->ports[i];
 
 		if (tb_is_upstream_port(port))
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 455ca490ea87..b723b86f4e72 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -530,6 +530,41 @@ struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
 struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route);
 
+/**
+ * tb_switch_for_each_port() - Iterate over each switch port
+ * @sw: Switch whose ports to iterate
+ * @i: Port index inside @sw->ports[] array
+ *
+ * Iterates over each switch port except control port.
+ */
+#define tb_switch_for_each_port(sw, i)					\
+	for (i = 1; i <= sw->config.max_port_number; i++)
+
+/**
+ * tb_switch_for_each_remote_port() - Iterate over each port that has remote
+ * @sw: Switch whose ports to iterate
+ * @i: Port index inside @sw->ports[] array
+ *
+ * Iterates over all ports that have another switch connected
+ * downstream.
+ */
+#define tb_switch_for_each_remote_port(sw, i)				\
+	tb_switch_for_each_port(sw, i)					\
+		if (!tb_port_has_remote(&sw->ports[i])) {} else
+
+/**
+ * tb_switch_for_each_connected_port() - Iterate over each connected port
+ * @sw: Switch whose ports to iterate
+ * @i: Port index inside @sw->ports[] array
+ *
+ * Iterates over each connected port. This means each port that has
+ * either a switch or remote host (XDomain) connected.
+ */
+#define tb_switch_for_each_connected_port(sw, i)			\
+	tb_switch_for_each_port(sw, i)					\
+		if (!tb_port_has_remote(&sw->ports[i]) &&		\
+		    !sw->ports[i].xdomain) {} else
+
 static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
 {
 	if (sw)
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 4e17a7c7bf0a..37ef0b4da1cf 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1406,7 +1406,7 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 {
 	int i;
 
-	for (i = 1; i <= sw->config.max_port_number; i++) {
+	tb_switch_for_each_port(sw, i) {
 		struct tb_port *port = &sw->ports[i];
 		struct tb_xdomain *xd;
 
-- 
2.23.0

