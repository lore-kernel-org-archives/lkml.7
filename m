Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9506217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfC1MkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:40:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:49140 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfC1Mgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="218369177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2019 05:36:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B591880; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 10/36] thunderbolt: Configure lanes when switch is initialized
Date:   Thu, 28 Mar 2019 15:36:07 +0300
Message-Id: <20190328123633.42882-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt 2 devices and beyond need to have additional bits set in
link controller specific registers. This includes two bits in LC_SX_CTRL
that tell the link controller which lane is connected and whether it is
upstream facing or not.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/lc.c      | 114 ++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c  |   9 +++
 drivers/thunderbolt/tb.h      |   2 +
 drivers/thunderbolt/tb_regs.h |  11 ++++
 4 files changed, 136 insertions(+)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 2134a55ed837..a5dddf176546 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -19,3 +19,117 @@ int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid)
 		return -EINVAL;
 	return tb_sw_read(sw, uuid, TB_CFG_SWITCH, sw->cap_lc + TB_LC_FUSE, 4);
 }
+
+static int read_lc_desc(struct tb_switch *sw, u32 *desc)
+{
+	if (!sw->cap_lc)
+		return -EINVAL;
+	return tb_sw_read(sw, desc, TB_CFG_SWITCH, sw->cap_lc + TB_LC_DESC, 1);
+}
+
+static int find_port_lc_cap(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	int start, phys, ret, size;
+	u32 desc;
+
+	ret = read_lc_desc(sw, &desc);
+	if (ret)
+		return ret;
+
+	/* Start of port LC registers */
+	start = (desc & TB_LC_DESC_SIZE_MASK) >> TB_LC_DESC_SIZE_SHIFT;
+	size = (desc & TB_LC_DESC_PORT_SIZE_MASK) >> TB_LC_DESC_PORT_SIZE_SHIFT;
+	phys = tb_phy_port_from_link(port->port);
+
+	return sw->cap_lc + start + phys * size;
+}
+
+static int tb_lc_configure_lane(struct tb_port *port, bool configure)
+{
+	bool upstream = tb_is_upstream_port(port);
+	struct tb_switch *sw = port->sw;
+	u32 ctrl, lane;
+	int cap, ret;
+
+	if (sw->generation < 2)
+		return 0;
+
+	cap = find_port_lc_cap(port);
+	if (cap < 0)
+		return cap;
+
+	ret = tb_sw_read(sw, &ctrl, TB_CFG_SWITCH, cap + TB_LC_SX_CTRL, 1);
+	if (ret)
+		return ret;
+
+	/* Resolve correct lane */
+	if (port->port % 2)
+		lane = TB_LC_SX_CTRL_L1C;
+	else
+		lane = TB_LC_SX_CTRL_L2C;
+
+	if (configure) {
+		ctrl |= lane;
+		if (upstream)
+			ctrl |= TB_LC_SX_CTRL_UPSTREAM;
+	} else {
+		ctrl &= ~lane;
+		if (upstream)
+			ctrl &= ~TB_LC_SX_CTRL_UPSTREAM;
+	}
+
+	return tb_sw_write(sw, &ctrl, TB_CFG_SWITCH, cap + TB_LC_SX_CTRL, 1);
+}
+
+/**
+ * tb_lc_configure_link() - Let LC know about configured link
+ * @sw: Switch that is being added
+ *
+ * Informs LC of both parent switch and @sw that there is established
+ * link between the two.
+ */
+int tb_lc_configure_link(struct tb_switch *sw)
+{
+	struct tb_port *up, *down;
+	int ret;
+
+	if (!sw->config.enabled || !tb_route(sw))
+		return 0;
+
+	up = tb_upstream_port(sw);
+	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
+
+	/* Configure parent link toward this switch */
+	ret = tb_lc_configure_lane(down, true);
+	if (ret)
+		return ret;
+
+	/* Configure upstream link from this switch to the parent */
+	ret = tb_lc_configure_lane(up, true);
+	if (ret)
+		tb_lc_configure_lane(down, false);
+
+	return ret;
+}
+
+/**
+ * tb_lc_unconfigure_link() - Let LC know about unconfigured link
+ * @sw: Switch to unconfigure
+ *
+ * Informs LC of both parent switch and @sw that the link between the
+ * two does not exist anymore.
+ */
+void tb_lc_unconfigure_link(struct tb_switch *sw)
+{
+	struct tb_port *up, *down;
+
+	if (sw->is_unplugged || !sw->config.enabled || !tb_route(sw))
+		return;
+
+	up = tb_upstream_port(sw);
+	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
+
+	tb_lc_configure_lane(up, false);
+	tb_lc_configure_lane(down, false);
+}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 63ff4c753d89..dd218dc4781b 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1276,6 +1276,10 @@ int tb_switch_configure(struct tb_switch *sw)
 	if (ret)
 		return ret;
 
+	ret = tb_lc_configure_link(sw);
+	if (ret)
+		return ret;
+
 	return tb_plug_events_active(sw, true);
 }
 
@@ -1486,6 +1490,7 @@ void tb_switch_remove(struct tb_switch *sw)
 
 	if (!sw->is_unplugged)
 		tb_plug_events_active(sw, false);
+	tb_lc_unconfigure_link(sw);
 
 	tb_switch_nvm_remove(sw);
 
@@ -1545,6 +1550,10 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (err)
 		return err;
 
+	err = tb_lc_configure_link(sw);
+	if (err)
+		return err;
+
 	err = tb_plug_events_active(sw, true);
 	if (err)
 		return err;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e52d39b25266..69e0534224d8 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -465,6 +465,8 @@ int tb_drom_read(struct tb_switch *sw);
 int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
+int tb_lc_configure_link(struct tb_switch *sw);
+void tb_lc_unconfigure_link(struct tb_switch *sw);
 
 static inline int tb_route_length(u64 route)
 {
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 4895ae9f0b40..e0f867dad5cf 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -238,6 +238,17 @@ struct tb_regs_hop {
 } __packed;
 
 /* Common link controller registers */
+#define TB_LC_DESC			0x02
+#define TB_LC_DESC_SIZE_SHIFT		8
+#define TB_LC_DESC_SIZE_MASK		GENMASK(15, 8)
+#define TB_LC_DESC_PORT_SIZE_SHIFT	16
+#define TB_LC_DESC_PORT_SIZE_MASK	GENMASK(27, 16)
 #define TB_LC_FUSE			0x03
 
+/* Link controller registers */
+#define TB_LC_SX_CTRL			0x96
+#define TB_LC_SX_CTRL_L1C		BIT(16)
+#define TB_LC_SX_CTRL_L2C		BIT(20)
+#define TB_LC_SX_CTRL_UPSTREAM		BIT(30)
+
 #endif
-- 
2.20.1

