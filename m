Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D181C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DEB21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfJALiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:38:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:27911 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732669AbfJALim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="181663267"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 04:38:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 836B8592; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 15/22] thunderbolt: Make tb_find_port() available to other files
Date:   Tue,  1 Oct 2019 14:38:23 +0300
Message-Id: <20191001113830.13028-16-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be needing this when adding initial USB4 support so make it
available to other files in the driver as well. We also rename it to
tb_switch_find_port() to follow conventions used in switch.c.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 18 ++++++++++++++++++
 drivers/thunderbolt/tb.c     | 22 ++--------------------
 drivers/thunderbolt/tb.h     |  2 ++
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 87c74c916a7c..8bc5d46011f8 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2446,6 +2446,24 @@ struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route)
 	return NULL;
 }
 
+/**
+ * tb_switch_find_port() - return the first port of @type on @sw or NULL
+ * @sw: Switch to find the port from
+ * @type: Port type to look for
+ */
+struct tb_port *tb_switch_find_port(struct tb_switch *sw,
+				    enum tb_port_type type)
+{
+	int i;
+
+	tb_switch_for_each_port(sw, i) {
+		if (sw->ports[i].config.type == type)
+			return &sw->ports[i];
+	}
+
+	return NULL;
+}
+
 void tb_switch_exit(void)
 {
 	ida_destroy(&nvm_ida);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a3b7a18dc6d9..eab93e32cc4f 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -343,24 +343,6 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 	}
 }
 
-/**
- * tb_find_port() - return the first port of @type on @sw or NULL
- * @sw: Switch to find the port from
- * @type: Port type to look for
- */
-static struct tb_port *tb_find_port(struct tb_switch *sw,
-				    enum tb_port_type type)
-{
-	int i;
-
-	tb_switch_for_each_port(sw, i) {
-		if (sw->ports[i].config.type == type)
-			return &sw->ports[i];
-	}
-
-	return NULL;
-}
-
 /**
  * tb_find_unused_port() - return the first inactive port on @sw
  * @sw: Switch to find the port on
@@ -590,7 +572,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 	struct tb_switch *parent_sw;
 	struct tb_tunnel *tunnel;
 
-	up = tb_find_port(sw, TB_TYPE_PCIE_UP);
+	up = tb_switch_find_port(sw, TB_TYPE_PCIE_UP);
 	if (!up)
 		return 0;
 
@@ -628,7 +610,7 @@ static int tb_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 
 	sw = tb_to_switch(xd->dev.parent);
 	dst_port = tb_port_at(xd->route, sw);
-	nhi_port = tb_find_port(tb->root_switch, TB_TYPE_NHI);
+	nhi_port = tb_switch_find_port(tb->root_switch, TB_TYPE_NHI);
 
 	mutex_lock(&tb->lock);
 	tunnel = tb_tunnel_alloc_dma(tb, nhi_port, dst_port, xd->transmit_ring,
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 7a8cc56a2870..f4ce739bfd7a 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -533,6 +533,8 @@ void tb_switch_suspend(struct tb_switch *sw);
 int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb *tb, u64 route);
 void tb_sw_set_unplugged(struct tb_switch *sw);
+struct tb_port *tb_switch_find_port(struct tb_switch *sw,
+				    enum tb_port_type type);
 struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
-- 
2.23.0

