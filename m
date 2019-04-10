Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfDJNml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:42:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:48802 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbfDJNhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="134566079"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 06:36:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7C6491D7; Wed, 10 Apr 2019 16:36:54 +0300 (EEST)
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
Subject: [PATCH v4 03/36] thunderbolt: Drop duplicated get_switch_at_route()
Date:   Wed, 10 Apr 2019 16:36:20 +0300
Message-Id: <20190410133653.88061-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tb_switch_find_by_route() does the same already so use it instead and
remove duplicated get_switch_at_route().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/icm.c    | 12 ++++++++----
 drivers/thunderbolt/switch.c | 18 ------------------
 drivers/thunderbolt/tb.c     |  9 ++++++---
 drivers/thunderbolt/tb.h     |  1 -
 4 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 8b7f9131e9d1..7c923e16a7d8 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -798,9 +798,11 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	 * connected another host to the same port, remove the switch
 	 * first.
 	 */
-	sw = get_switch_at_route(tb->root_switch, route);
-	if (sw)
+	sw = tb_switch_find_by_route(tb, route);
+	if (sw) {
 		remove_switch(sw);
+		tb_switch_put(sw);
+	}
 
 	sw = tb_switch_find_by_link_depth(tb, link, depth);
 	if (!sw) {
@@ -1143,9 +1145,11 @@ icm_tr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	 * connected another host to the same port, remove the switch
 	 * first.
 	 */
-	sw = get_switch_at_route(tb->root_switch, route);
-	if (sw)
+	sw = tb_switch_find_by_route(tb, route);
+	if (sw) {
 		remove_switch(sw);
+		tb_switch_put(sw);
+	}
 
 	sw = tb_switch_find_by_route(tb, get_parent_route(route));
 	if (!sw) {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 504365d46827..5c2c0201ae7f 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -644,24 +644,6 @@ int tb_switch_reset(struct tb *tb, u64 route)
 	return res.err;
 }
 
-struct tb_switch *get_switch_at_route(struct tb_switch *sw, u64 route)
-{
-	u8 next_port = route; /*
-			       * Routes use a stride of 8 bits,
-			       * eventhough a port index has 6 bits at most.
-			       * */
-	if (route == 0)
-		return sw;
-	if (next_port > sw->config.max_port_number)
-		return NULL;
-	if (tb_is_upstream_port(&sw->ports[next_port]))
-		return NULL;
-	if (!sw->ports[next_port].remote)
-		return NULL;
-	return get_switch_at_route(sw->ports[next_port].remote->sw,
-				   route >> TB_ROUTE_SHIFT);
-}
-
 /**
  * tb_plug_events_active() - enable/disable plug events on a switch
  *
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 30e02c716f6c..d8f4ed0f2ef8 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -258,7 +258,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 	if (!tcm->hotplug_active)
 		goto out; /* during init, suspend or shutdown */
 
-	sw = get_switch_at_route(tb->root_switch, ev->route);
+	sw = tb_switch_find_by_route(tb, ev->route);
 	if (!sw) {
 		tb_warn(tb,
 			"hotplug event from non existent switch %llx:%x (unplug: %d)\n",
@@ -269,14 +269,14 @@ static void tb_handle_hotplug(struct work_struct *work)
 		tb_warn(tb,
 			"hotplug event from non existent port %llx:%x (unplug: %d)\n",
 			ev->route, ev->port, ev->unplug);
-		goto out;
+		goto put_sw;
 	}
 	port = &sw->ports[ev->port];
 	if (tb_is_upstream_port(port)) {
 		tb_warn(tb,
 			"hotplug event for upstream port %llx:%x (unplug: %d)\n",
 			ev->route, ev->port, ev->unplug);
-		goto out;
+		goto put_sw;
 	}
 	if (ev->unplug) {
 		if (port->remote) {
@@ -306,6 +306,9 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_activate_pcie_devices(tb);
 		}
 	}
+
+put_sw:
+	tb_switch_put(sw);
 out:
 	mutex_unlock(&tb->lock);
 	kfree(ev);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 8058ea02d572..aea668c40d27 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -399,7 +399,6 @@ void tb_switch_suspend(struct tb_switch *sw);
 int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb *tb, u64 route);
 void tb_sw_set_unplugged(struct tb_switch *sw);
-struct tb_switch *get_switch_at_route(struct tb_switch *sw, u64 route);
 struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
-- 
2.20.1

