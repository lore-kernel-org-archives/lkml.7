Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D99217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfC1MjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:39:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:35010 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126619161"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DD77BF9C; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
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
Subject: [PATCH v3 23/36] thunderbolt: Scan only valid NULL adapter ports in hotplug
Date:   Thu, 28 Mar 2019 15:36:20 +0300
Message-Id: <20190328123633.42882-24-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only way to expand Thunderbolt topology is through the NULL adapter
ports (typically ports 1, 2, 3 and 4). There is no point handling
Thunderbolt hotplug events on any other port.

Add a helper function (tb_port_is_null()) that can be used to determine
if the port is NULL port, and use it in software connection manager code
when hotplug event is handled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 10 ++++++----
 drivers/thunderbolt/tb.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index cfc451c938fd..fb01396a62a9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -356,10 +356,12 @@ static void tb_handle_hotplug(struct work_struct *work)
 		tb_port_info(port,
 			     "got plug event for connected port, ignoring\n");
 	} else {
-		tb_port_info(port, "hotplug: scanning\n");
-		tb_scan_port(port);
-		if (!port->remote)
-			tb_port_info(port, "hotplug: no switch found\n");
+		if (tb_port_is_null(port)) {
+			tb_port_info(port, "hotplug: scanning\n");
+			tb_scan_port(port);
+			if (!port->remote)
+				tb_port_info(port, "hotplug: no switch found\n");
+		}
 	}
 
 put_sw:
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index d810fb188937..5ca8be0db310 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -320,6 +320,11 @@ static inline bool tb_port_has_remote(const struct tb_port *port)
 	return true;
 }
 
+static inline bool tb_port_is_null(const struct tb_port *port)
+{
+	return port && port->port && port->config.type == TB_TYPE_PORT;
+}
+
 static inline bool tb_port_is_pcie_down(const struct tb_port *port)
 {
 	return port && port->config.type == TB_TYPE_PCIE_DOWN;
-- 
2.20.1

