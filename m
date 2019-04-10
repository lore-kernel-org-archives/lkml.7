Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134320854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfDJNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:40:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:46418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732413AbfDJNhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="336622800"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2019 06:37:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 85696799; Wed, 10 Apr 2019 16:36:55 +0300 (EEST)
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
Subject: [PATCH v4 24/36] thunderbolt: Generalize port finding routines to support all port types
Date:   Wed, 10 Apr 2019 16:36:41 +0300
Message-Id: <20190410133653.88061-25-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be needing these routines to find Display Port adapters as well
so modify them to take port type as the second parameter.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 16 ++++++++++++++++
 drivers/thunderbolt/tb.c     | 35 +++++++++++++++++------------------
 drivers/thunderbolt/tb.h     |  1 +
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 00aec2124f79..028e9a293382 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -730,6 +730,22 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
 	return next;
 }
 
+/**
+ * tb_port_is_enabled() - Is the adapter port enabled
+ * @port: Port to check
+ */
+bool tb_port_is_enabled(struct tb_port *port)
+{
+	switch (port->config.type) {
+	case TB_TYPE_PCIE_UP:
+	case TB_TYPE_PCIE_DOWN:
+		return tb_pci_port_is_enabled(port);
+
+	default:
+		return false;
+	}
+}
+
 /**
  * tb_pci_port_is_enabled() - Is the PCIe adapter port enabled
  * @port: PCIe port to check
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index fb01396a62a9..903922a16d64 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -180,40 +180,39 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 	}
 }
 
-
 /**
- * find_pci_up_port() - return the first PCIe up port on @sw or NULL
+ * tb_find_port() - return the first port of @type on @sw or NULL
+ * @sw: Switch to find the port from
+ * @type: Port type to look for
  */
-static struct tb_port *tb_find_pci_up_port(struct tb_switch *sw)
+static struct tb_port *tb_find_port(struct tb_switch *sw,
+				    enum tb_port_type type)
 {
 	int i;
 	for (i = 1; i <= sw->config.max_port_number; i++)
-		if (sw->ports[i].config.type == TB_TYPE_PCIE_UP)
+		if (sw->ports[i].config.type == type)
 			return &sw->ports[i];
 	return NULL;
 }
 
 /**
- * find_unused_down_port() - return the first inactive PCIe down port on @sw
+ * tb_find_unused_port() - return the first inactive port on @sw
+ * @sw: Switch to find the port on
+ * @type: Port type to look for
  */
-static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
+static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
+					   enum tb_port_type type)
 {
 	int i;
-	int cap;
-	int res;
-	int data;
+
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		if (tb_is_upstream_port(&sw->ports[i]))
 			continue;
-		if (sw->ports[i].config.type != TB_TYPE_PCIE_DOWN)
-			continue;
-		cap = sw->ports[i].cap_adap;
-		if (!cap)
+		if (sw->ports[i].config.type != type)
 			continue;
-		res = tb_port_read(&sw->ports[i], &data, TB_CFG_PORT, cap, 1);
-		if (res < 0)
+		if (!sw->ports[i].cap_adap)
 			continue;
-		if (data & 0x80000000)
+		if (tb_port_is_enabled(&sw->ports[i]))
 			continue;
 		return &sw->ports[i];
 	}
@@ -255,7 +254,7 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
 	}
 
 out:
-	return tb_find_unused_down_port(sw);
+	return tb_find_unused_port(sw, TB_TYPE_PCIE_DOWN);
 }
 
 static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
@@ -265,7 +264,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 	struct tb_switch *parent_sw;
 	struct tb_tunnel *tunnel;
 
-	up = tb_find_pci_up_port(sw);
+	up = tb_find_port(sw, TB_TYPE_PCIE_UP);
 	if (!up)
 		return 0;
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 260360ec59a9..e6040c9f68fa 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -576,6 +576,7 @@ struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
+bool tb_port_is_enabled(struct tb_port *port);
 
 bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
-- 
2.20.1

