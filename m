Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388782064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405048AbfJWLXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:23:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:63100 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404831AbfJWLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="210009628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6DDAC5BA; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 11/25] thunderbolt: Add default linking between lane adapters if not provided by DROM
Date:   Wed, 23 Oct 2019 14:21:40 +0300
Message-Id: <20191023112154.64235-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently read how sibling lane adapter ports relate each other from
DROM (Device ROM). If the two lane adapter ports go through the same
physical connector these lanes can then be bonded together. However,
some cases DROM does not provide this information or it is missing
completely (host routers typically do not have DROM). In this case we
have hard-coded the relationship.

Expand this to work with both legacy devices where lane adapter ports 1
and 2, and 3 and 4 are always linked together, and with USB4 devices
where lane adapter 1 is always following lane adapter 0 or is disabled
completely (see USB4 section 5.2.1 for more information).

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
index 7e2cde5da31c..404a78a82746 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1926,6 +1926,36 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
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
@@ -2099,6 +2129,8 @@ int tb_switch_add(struct tb_switch *sw)
 			}
 		}
 
+		tb_switch_default_link_ports(sw);
+
 		ret = tb_switch_update_link_attributes(sw);
 		if (ret)
 			return ret;
-- 
2.23.0

