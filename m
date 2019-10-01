Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9700AC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D2921906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfJALjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:27910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="181663255"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 34CC3419; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 07/22] thunderbolt: Add default linking between ports if not provided by DROM
Date:   Tue,  1 Oct 2019 14:38:15 +0300
Message-Id: <20191001113830.13028-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cases the DROM information is not correct or is simply missing.
This prevents establishing lane bonding even if it would be possible
otherwise. To make this work better provide default linking between
ports if DROM has not provided that information.

This works with legacy devices where ports 1 and 2, and 3 and 4 are
linked together and also with USB4.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/eeprom.c | 11 -----------
 drivers/thunderbolt/switch.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index ee5196479854..8dd7de0cc826 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -514,17 +514,6 @@ int tb_drom_read(struct tb_switch *sw)
 		 * no entries). Hardcode the configuration here.
 		 */
 		tb_drom_read_uid_only(sw, &sw->uid);
-
-		sw->ports[1].link_nr = 0;
-		sw->ports[2].link_nr = 1;
-		sw->ports[1].dual_link_port = &sw->ports[2];
-		sw->ports[2].dual_link_port = &sw->ports[1];
-
-		sw->ports[3].link_nr = 0;
-		sw->ports[4].link_nr = 1;
-		sw->ports[3].dual_link_port = &sw->ports[4];
-		sw->ports[4].dual_link_port = &sw->ports[3];
-
 		return 0;
 	}
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 2b00ea7a979a..f7547287be68 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1904,6 +1904,36 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 	return -ESHUTDOWN;
 }
 
+static void tb_switch_default_link_ports(struct tb_switch *sw)
+{
+	int i;
+
+	for (i = 1; i <= sw->config.max_port_number; i += 2) {
+		struct tb_port *port = &sw->ports[i];
+		struct tb_port *subordinate;
+
+		if (!tb_port_is_null(port))
+			continue;
+
+		/* Check for the subordinate port */
+		if (i == sw->config.max_port_number ||
+		    !tb_port_is_null(&sw->ports[i + 1]))
+			continue;
+
+		/* Link them if not already done so (by DROM) */
+		subordinate = &sw->ports[i + 1];
+		if (!port->dual_link_port && !subordinate->dual_link_port) {
+			port->link_nr = 0;
+			port->dual_link_port = subordinate;
+			subordinate->link_nr = 1;
+			subordinate->dual_link_port = port;
+
+			tb_sw_dbg(sw, "linked ports %d <-> %d\n",
+				  port->port, subordinate->port);
+		}
+	}
+}
+
 static bool tb_switch_lane_bonding_possible(struct tb_switch *sw)
 {
 	const struct tb_port *up = tb_upstream_port(sw);
@@ -2071,6 +2101,8 @@ int tb_switch_add(struct tb_switch *sw)
 				return ret;
 		}
 
+		tb_switch_default_link_ports(sw);
+
 		ret = tb_switch_update_link_attributes(sw);
 		if (ret)
 			return ret;
-- 
2.23.0

