Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F84217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfC1Mgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:36:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:34158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfC1Mgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138136897"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 05:36:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8036A187E; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
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
Subject: [PATCH v3 35/36] thunderbolt: Reword output of tb_dump_hop()
Date:   Thu, 28 Mar 2019 15:36:32 +0300
Message-Id: <20190328123633.42882-36-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While tb_dump_hop() prints out necessary information it is in format
that is quite hard to read from the logs especially when one needs to
follow the path to see that the setup is correct.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 2dbfb3e1c3fc..44bdf08f3f68 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -13,21 +13,22 @@
 
 #include "tb.h"
 
-static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
+static void tb_dump_hop(const struct tb_path_hop *hop, const struct tb_regs_hop *regs)
 {
-	tb_port_dbg(port, " Hop through port %d to hop %d (%s)\n",
-		    hop->out_port, hop->next_hop,
-		    hop->enable ? "enabled" : "disabled");
+	const struct tb_port *port = hop->in_port;
+
+	tb_port_dbg(port, " In HopID: %d => Out port: %d Out HopID: %d\n",
+		    hop->in_hop_index, regs->out_port, regs->next_hop);
 	tb_port_dbg(port, "  Weight: %d Priority: %d Credits: %d Drop: %d\n",
-		    hop->weight, hop->priority,
-		    hop->initial_credits, hop->drop_packages);
+		    regs->weight, regs->priority,
+		    regs->initial_credits, regs->drop_packages);
 	tb_port_dbg(port, "   Counter enabled: %d Counter index: %d\n",
-		    hop->counter_enable, hop->counter);
+		    regs->counter_enable, regs->counter);
 	tb_port_dbg(port, "  Flow Control (In/Eg): %d/%d Shared Buffer (In/Eg): %d/%d\n",
-		    hop->ingress_fc, hop->egress_fc,
-		    hop->ingress_shared_buffer, hop->egress_shared_buffer);
+		    regs->ingress_fc, regs->egress_fc,
+		    regs->ingress_shared_buffer, regs->egress_shared_buffer);
 	tb_port_dbg(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
-		    hop->unknown1, hop->unknown2, hop->unknown3);
+		    regs->unknown1, regs->unknown2, regs->unknown3);
 }
 
 static struct tb_port *tb_path_find_dst_port(struct tb_port *src, int src_hopid,
@@ -503,9 +504,8 @@ int tb_path_activate(struct tb_path *path)
 					    & out_mask;
 		hop.unknown3 = 0;
 
-		tb_port_dbg(path->hops[i].in_port, "Writing hop %d, index %d",
-			    i, path->hops[i].in_hop_index);
-		tb_dump_hop(path->hops[i].in_port, &hop);
+		tb_port_dbg(path->hops[i].in_port, "Writing hop %d\n", i);
+		tb_dump_hop(&path->hops[i], &hop);
 		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
 				    2 * path->hops[i].in_hop_index, 2);
 		if (res) {
-- 
2.20.1

