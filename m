Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF26C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4DC20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfDJNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:41:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:23980 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbfDJNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="130178552"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Apr 2019 06:37:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 486ED666; Wed, 10 Apr 2019 16:36:55 +0300 (EEST)
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
Subject: [PATCH v4 18/36] thunderbolt: Add helper function to iterate from one port to another
Date:   Wed, 10 Apr 2019 16:36:35 +0300
Message-Id: <20190410133653.88061-19-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to be able to walk from one port to another when we are creating
paths where there are multiple switches between two ports. For this
reason introduce a new function tb_next_port_on_path().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/switch.c | 54 ++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h     |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 6f98b3d6eb2a..ecd41f7b7649 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -676,6 +676,60 @@ void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 	ida_simple_remove(&port->out_hopids, hopid);
 }
 
+/**
+ * tb_next_port_on_path() - Return next port for given port on a path
+ * @start: Start port of the walk
+ * @end: End port of the walk
+ * @prev: Previous port (%NULL if this is the first)
+ *
+ * This function can be used to walk from one port to another if they
+ * are connected through zero or more switches. If the @prev is dual
+ * link port, the function follows that link and returns another end on
+ * that same link.
+ *
+ * If the @end port has been reached, return %NULL.
+ *
+ * Domain tb->lock must be held when this function is called.
+ */
+struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
+				     struct tb_port *prev)
+{
+	struct tb_port *next;
+
+	if (!prev)
+		return start;
+
+	if (prev->sw == end->sw) {
+		if (prev == end)
+			return NULL;
+		return end;
+	}
+
+	if (start->sw->config.depth < end->sw->config.depth) {
+		if (prev->remote &&
+		    prev->remote->sw->config.depth > prev->sw->config.depth)
+			next = prev->remote;
+		else
+			next = tb_port_at(tb_route(end->sw), prev->sw);
+	} else {
+		if (tb_is_upstream_port(prev)) {
+			next = prev->remote;
+		} else {
+			next = tb_upstream_port(prev->sw);
+			/*
+			 * Keep the same link if prev and next are both
+			 * dual link ports.
+			 */
+			if (next->dual_link_port &&
+			    next->link_nr != prev->link_nr) {
+				next = next->dual_link_port;
+			}
+		}
+	}
+
+	return next;
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 43bc4f490021..11d5ab53ad36 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -495,6 +495,8 @@ int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_in_hopid(struct tb_port *port, int hopid);
 int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_out_hopid(struct tb_port *port, int hopid);
+struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port *end,
+				     struct tb_port *prev);
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
-- 
2.20.1

