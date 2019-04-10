Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1466C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A23D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfDJNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:40:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:15448 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732409AbfDJNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="335521013"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2019 06:37:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A905B8C1; Wed, 10 Apr 2019 16:36:55 +0300 (EEST)
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
Subject: [PATCH v4 27/36] thunderbolt: Do not tear down tunnels when driver is unloaded
Date:   Wed, 10 Apr 2019 16:36:44 +0300
Message-Id: <20190410133653.88061-28-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have capability to discover existing tunnels during driver
load there is no point tearing down tunnels when the driver gets
unloaded. Instead we can just leave them running. If user disconnects
devices while there is no Thunderbolt driver loaded, tunneled protocol
hotplug happens and is handled by the corresponding driver (pciehp in
case of PCIe tunnel, GFX driver in case of DP tunnel).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 10 ++++------
 drivers/thunderbolt/tb.c     |  4 +---
 drivers/thunderbolt/tunnel.c | 10 +---------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 670a12e60d66..3fc92881a197 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -304,17 +304,15 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 }
 
 /**
- * tb_path_free() - free a deactivated path
+ * tb_path_free() - free a path
+ * @path: Path to free
+ *
+ * Frees a path. The path does not need to be deactivated.
  */
 void tb_path_free(struct tb_path *path)
 {
 	int i;
 
-	if (path->activated) {
-		tb_WARN(path->tb, "trying to free an activated path\n")
-		return;
-	}
-
 	for (i = 0; i < path->path_length; i++) {
 		const struct tb_path_hop *hop = &path->hops[i];
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c5e96e7ac37a..8a97a4e19638 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -500,10 +500,8 @@ static void tb_stop(struct tb *tb)
 	struct tb_tunnel *n;
 
 	/* tunnels are only present after everything has been initialized */
-	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
-		tb_tunnel_deactivate(tunnel);
+	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_free(tunnel);
-	}
 	tb_switch_remove(tb->root_switch);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 21d3393c6e9c..0bc6639c6e74 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -475,7 +475,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
  * tb_tunnel_free() - free a tunnel
  * @tunnel: Tunnel to be freed
  *
- * The tunnel must have been deactivated.
+ * Frees a tunnel. The tunnel does not need to be deactivated.
  */
 void tb_tunnel_free(struct tb_tunnel *tunnel)
 {
@@ -484,14 +484,6 @@ void tb_tunnel_free(struct tb_tunnel *tunnel)
 	if (!tunnel)
 		return;
 
-	for (i = 0; i < tunnel->npaths; i++) {
-		if (tunnel->paths[i] && tunnel->paths[i]->activated) {
-			tb_tunnel_WARN(tunnel,
-				       "trying to free an activated tunnel\n");
-			return;
-		}
-	}
-
 	for (i = 0; i < tunnel->npaths; i++) {
 		if (tunnel->paths[i])
 			tb_path_free(tunnel->paths[i]);
-- 
2.20.1

