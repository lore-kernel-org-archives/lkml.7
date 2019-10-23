Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111EFCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59DD2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405080AbfJWLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:23:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:63098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404682AbfJWLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="223150872"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 57ACE579; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 09/25] thunderbolt: Refactor add_switch() into two functions
Date:   Wed, 23 Oct 2019 14:21:38 +0300
Message-Id: <20191023112154.64235-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently add_switch() takes a huge amount of parameters that makes it
hard to maintain. Instead of passing all those parameters we can split
the function into two parts (alloc and add) and fill the additional
switch fields directly in the functions calling those.

While there remove redundant error logging in case kmemdup() fails.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 110 +++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 24625880692e..d9caac77e08c 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -147,6 +147,17 @@ static const struct intel_vss *parse_intel_vss(const void *ep_name, size_t size)
 	return NULL;
 }
 
+static bool intel_vss_is_rtd3(const void *ep_name, size_t size)
+{
+	const struct intel_vss *vss;
+
+	vss = parse_intel_vss(ep_name, size);
+	if (vss)
+		return !!(vss->flags & INTEL_VSS_FLAGS_RTD3);
+
+	return false;
+}
+
 static inline struct tb *icm_to_tb(struct icm *icm)
 {
 	return ((void *)icm - sizeof(struct tb));
@@ -562,58 +573,42 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 	return 0;
 }
 
-static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
-				    const uuid_t *uuid, const u8 *ep_name,
-				    size_t ep_name_size, u8 connection_id,
-				    u8 connection_key, u8 link, u8 depth,
-				    enum tb_security_level security_level,
-				    bool authorized, bool boot)
+static struct tb_switch *alloc_switch(struct tb_switch *parent_sw, u64 route,
+				      const uuid_t *uuid)
 {
-	const struct intel_vss *vss;
+	struct tb *tb = parent_sw->tb;
 	struct tb_switch *sw;
-	int ret;
 
-	pm_runtime_get_sync(&parent_sw->dev);
-
-	sw = tb_switch_alloc(parent_sw->tb, &parent_sw->dev, route);
-	if (IS_ERR(sw))
-		goto out;
+	sw = tb_switch_alloc(tb, &parent_sw->dev, route);
+	if (IS_ERR(sw)) {
+		tb_warn(tb, "failed to allocate switch at %llx\n", route);
+		return sw;
+	}
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
 	if (!sw->uuid) {
-		tb_sw_warn(sw, "cannot allocate memory for switch\n");
 		tb_switch_put(sw);
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
-	sw->connection_id = connection_id;
-	sw->connection_key = connection_key;
-	sw->link = link;
-	sw->depth = depth;
-	sw->authorized = authorized;
-	sw->security_level = security_level;
-	sw->boot = boot;
+
 	init_completion(&sw->rpm_complete);
+	return sw;
+}
 
-	vss = parse_intel_vss(ep_name, ep_name_size);
-	if (vss)
-		sw->rpm = !!(vss->flags & INTEL_VSS_FLAGS_RTD3);
+static int add_switch(struct tb_switch *parent_sw, struct tb_switch *sw)
+{
+	u64 route = tb_route(sw);
+	int ret;
 
 	/* Link the two switches now */
 	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
 	tb_upstream_port(sw)->remote = tb_port_at(route, parent_sw);
 
 	ret = tb_switch_add(sw);
-	if (ret) {
+	if (ret)
 		tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
-		tb_switch_put(sw);
-		sw = ERR_PTR(ret);
-	}
 
-out:
-	pm_runtime_mark_last_busy(&parent_sw->dev);
-	pm_runtime_put_autosuspend(&parent_sw->dev);
-
-	return sw;
+	return ret;
 }
 
 static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
@@ -811,10 +806,25 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
-		   sizeof(pkg->ep_name), pkg->connection_id,
-		   pkg->connection_key, link, depth, security_level,
-		   authorized, boot);
+	pm_runtime_get_sync(&parent_sw->dev);
+
+	sw = alloc_switch(parent_sw, route, &pkg->ep_uuid);
+	if (!IS_ERR(sw)) {
+		sw->connection_id = pkg->connection_id;
+		sw->connection_key = pkg->connection_key;
+		sw->link = link;
+		sw->depth = depth;
+		sw->authorized = authorized;
+		sw->security_level = security_level;
+		sw->boot = boot;
+		sw->rpm = intel_vss_is_rtd3(pkg->ep_name, sizeof(pkg->ep_name));
+
+		if (add_switch(parent_sw, sw))
+			tb_switch_put(sw);
+	}
+
+	pm_runtime_mark_last_busy(&parent_sw->dev);
+	pm_runtime_put_autosuspend(&parent_sw->dev);
 
 	tb_switch_put(parent_sw);
 }
@@ -1205,11 +1215,25 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 		return;
 	}
 
-	sw = add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
-			sizeof(pkg->ep_name), pkg->connection_id, 0, 0, 0,
-			security_level, authorized, boot);
-	if (!IS_ERR(sw) && force_rtd3)
-		sw->rpm = true;
+	pm_runtime_get_sync(&parent_sw->dev);
+
+	sw = alloc_switch(parent_sw, route, &pkg->ep_uuid);
+	if (!IS_ERR(sw)) {
+		sw->connection_id = pkg->connection_id;
+		sw->authorized = authorized;
+		sw->security_level = security_level;
+		sw->boot = boot;
+		sw->rpm = force_rtd3;
+		if (!sw->rpm)
+			sw->rpm = intel_vss_is_rtd3(pkg->ep_name,
+						    sizeof(pkg->ep_name));
+
+		if (add_switch(parent_sw, sw))
+			tb_switch_put(sw);
+	}
+
+	pm_runtime_mark_last_busy(&parent_sw->dev);
+	pm_runtime_put_autosuspend(&parent_sw->dev);
 
 	tb_switch_put(parent_sw);
 }
-- 
2.23.0

