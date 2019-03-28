Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48816C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F862173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfC1Mkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:40:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:49140 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfC1Mgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="218369174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2019 05:36:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 13083705; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 06/36] thunderbolt: Do not allocate switch if depth is greater than 6
Date:   Thu, 28 Mar 2019 15:36:03 +0300
Message-Id: <20190328123633.42882-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maximum depth in Thunderbolt topology is 6 so make sure it is not
possible to allocate switches that exceed the depth limit.

While at it update tb_switch_alloc() to use upper/lower_32_bits()
following tb_switch_alloc_safe_mode().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c    |  5 ++---
 drivers/thunderbolt/switch.c | 18 ++++++++++++------
 drivers/thunderbolt/tb.h     |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 7c923e16a7d8..bec360eef6cf 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -42,7 +42,6 @@
 #define ICM_TIMEOUT			5000	/* ms */
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
-#define ICM_MAX_DEPTH			6
 
 /**
  * struct icm - Internal connection manager private data
@@ -714,7 +713,7 @@ icm_fr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
 
-	if (link > ICM_MAX_LINK || depth > ICM_MAX_DEPTH) {
+	if (link > ICM_MAX_LINK || depth > TB_SWITCH_MAX_DEPTH) {
 		tb_warn(tb, "invalid topology %u.%u, ignoring\n", link, depth);
 		return;
 	}
@@ -744,7 +743,7 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
 
-	if (link > ICM_MAX_LINK || depth > ICM_MAX_DEPTH) {
+	if (link > ICM_MAX_LINK || depth > TB_SWITCH_MAX_DEPTH) {
 		tb_warn(tb, "invalid topology %u.%u, ignoring\n", link, depth);
 		return;
 	}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7fa4ab076404..1e29c06947af 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1130,10 +1130,16 @@ static int tb_switch_get_generation(struct tb_switch *sw)
 struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route)
 {
-	int i;
-	int cap;
 	struct tb_switch *sw;
-	int upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
+	int upstream_port;
+	int i, cap, depth;
+
+	/* Make sure we do not exceed maximum topology limit */
+	depth = tb_route_length(route);
+	if (depth > TB_SWITCH_MAX_DEPTH)
+		return NULL;
+
+	upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
 	if (upstream_port < 0)
 		return NULL;
 
@@ -1150,9 +1156,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 
 	/* configure switch */
 	sw->config.upstream_port_number = upstream_port;
-	sw->config.depth = tb_route_length(route);
-	sw->config.route_lo = route;
-	sw->config.route_hi = route >> 32;
+	sw->config.depth = depth;
+	sw->config.route_hi = upper_32_bits(route);
+	sw->config.route_lo = lower_32_bits(route);
 	sw->config.enabled = 0;
 
 	/* initialize ports */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index f7b0c43c29a7..93c1ea21feeb 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -43,6 +43,7 @@ struct tb_switch_nvm {
 };
 
 #define TB_SWITCH_KEY_SIZE		32
+#define TB_SWITCH_MAX_DEPTH		6
 
 /**
  * struct tb_switch - a thunderbolt switch
-- 
2.20.1

