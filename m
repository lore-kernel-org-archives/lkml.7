Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C80AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77AF2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfC1Mi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:23135 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="130927824"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 512B916DD; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
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
Subject: [PATCH v3 31/36] thunderbolt: Make tb_switch_alloc() return ERR_PTR()
Date:   Thu, 28 Mar 2019 15:36:28 +0300
Message-Id: <20190328123633.42882-32-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to detect possible connections to other domains we need to be
able to find out why tb_switch_alloc() fails so make it return ERR_PTR()
instead. This allows the caller to differentiate between errors such as
-ENOMEM which comes from the kernel and for instance -EIO which comes
from the hardware when trying to access the possible switch.

Convert all the current call sites to handle this properly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c    |  6 +++---
 drivers/thunderbolt/switch.c | 36 ++++++++++++++++++++----------------
 drivers/thunderbolt/tb.c     |  6 +++---
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 805958e53c58..d1f6ec89763c 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -468,7 +468,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	pm_runtime_get_sync(&parent_sw->dev);
 
 	sw = tb_switch_alloc(parent_sw->tb, &parent_sw->dev, route);
-	if (!sw)
+	if (IS_ERR(sw))
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
@@ -1848,8 +1848,8 @@ static int icm_start(struct tb *tb)
 		tb->root_switch = tb_switch_alloc_safe_mode(tb, &tb->dev, 0);
 	else
 		tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
-	if (!tb->root_switch)
-		return -ENODEV;
+	if (IS_ERR(tb->root_switch))
+		return PTR_ERR(tb->root_switch);
 
 	/*
 	 * NVM upgrade has not been tested on Apple systems and they
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ecf53d986a5c..460f2bcad40a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1450,30 +1450,32 @@ static int tb_switch_get_generation(struct tb_switch *sw)
  * separately. The returned switch should be released by calling
  * tb_switch_put().
  *
- * Return: Pointer to the allocated switch or %NULL in case of failure
+ * Return: Pointer to the allocated switch or ERR_PTR() in case of
+ * failure.
  */
 struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route)
 {
 	struct tb_switch *sw;
 	int upstream_port;
-	int i, cap, depth;
+	int i, ret, depth;
 
 	/* Make sure we do not exceed maximum topology limit */
 	depth = tb_route_length(route);
 	if (depth > TB_SWITCH_MAX_DEPTH)
-		return NULL;
+		return ERR_PTR(-EADDRNOTAVAIL);
 
 	upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
 	if (upstream_port < 0)
-		return NULL;
+		return ERR_PTR(upstream_port);
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sw->tb = tb;
-	if (tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5))
+	ret = tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5);
+	if (ret)
 		goto err_free_sw_ports;
 
 	tb_dbg(tb, "current switch config:\n");
@@ -1489,8 +1491,10 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	/* initialize ports */
 	sw->ports = kcalloc(sw->config.max_port_number + 1, sizeof(*sw->ports),
 				GFP_KERNEL);
-	if (!sw->ports)
+	if (!sw->ports) {
+		ret = -ENOMEM;
 		goto err_free_sw_ports;
+	}
 
 	for (i = 0; i <= sw->config.max_port_number; i++) {
 		/* minimum setup for tb_find_cap and tb_drom_read to work */
@@ -1500,16 +1504,16 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 
 	sw->generation = tb_switch_get_generation(sw);
 
-	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_PLUG_EVENTS);
-	if (cap < 0) {
+	ret = tb_switch_find_vse_cap(sw, TB_VSE_CAP_PLUG_EVENTS);
+	if (ret < 0) {
 		tb_sw_warn(sw, "cannot find TB_VSE_CAP_PLUG_EVENTS aborting\n");
 		goto err_free_sw_ports;
 	}
-	sw->cap_plug_events = cap;
+	sw->cap_plug_events = ret;
 
-	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
-	if (cap > 0)
-		sw->cap_lc = cap;
+	ret = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
+	if (ret > 0)
+		sw->cap_lc = ret;
 
 	/* Root switch is always authorized */
 	if (!route)
@@ -1528,7 +1532,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	kfree(sw->ports);
 	kfree(sw);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /**
@@ -1543,7 +1547,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
  *
  * The returned switch must be released by calling tb_switch_put().
  *
- * Return: Pointer to the allocated switch or %NULL in case of failure
+ * Return: Pointer to the allocated switch or ERR_PTR() in case of failure
  */
 struct tb_switch *
 tb_switch_alloc_safe_mode(struct tb *tb, struct device *parent, u64 route)
@@ -1552,7 +1556,7 @@ tb_switch_alloc_safe_mode(struct tb *tb, struct device *parent, u64 route)
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sw->tb = tb;
 	sw->config.depth = tb_route_length(route);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 8a97a4e19638..c5e82c4dcb64 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -148,7 +148,7 @@ static void tb_scan_port(struct tb_port *port)
 	}
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
-	if (!sw)
+	if (IS_ERR(sw))
 		return;
 
 	if (tb_switch_configure(sw)) {
@@ -533,8 +533,8 @@ static int tb_start(struct tb *tb)
 	int ret;
 
 	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
-	if (!tb->root_switch)
-		return -ENOMEM;
+	if (IS_ERR(tb->root_switch))
+		return PTR_ERR(tb->root_switch);
 
 	/*
 	 * ICM firmware upgrade needs running firmware and in native
-- 
2.20.1

