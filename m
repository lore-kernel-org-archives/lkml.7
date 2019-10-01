Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B05C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C8B21A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbfJALjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:27909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="181663253"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 452B948B; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 09/22] thunderbolt: Convert basic adapter register names to follow the USB4 spec
Date:   Tue,  1 Oct 2019 14:38:17 +0300
Message-Id: <20191001113830.13028-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that USB4 spec has names for these basic registers we can use them
instead. This makes it easier to match certain register to the spec.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 18 +++++++++---------
 drivers/thunderbolt/tb_regs.h | 15 ++++++++-------
 drivers/thunderbolt/tunnel.c  | 10 +++++-----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index f7547287be68..8d17398e3349 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -553,17 +553,17 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 	if (credits == 0 || port->sw->is_unplugged)
 		return 0;
 
-	nfc_credits = port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+	nfc_credits = port->config.nfc_credits & ADP_CS_4_NFC_BUFFERS_MASK;
 	nfc_credits += credits;
 
-	tb_port_dbg(port, "adding %d NFC credits to %lu",
-		    credits, port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK);
+	tb_port_dbg(port, "adding %d NFC credits to %lu", credits,
+		    port->config.nfc_credits & ADP_CS_4_NFC_BUFFERS_MASK);
 
-	port->config.nfc_credits &= ~TB_PORT_NFC_CREDITS_MASK;
+	port->config.nfc_credits &= ~ADP_CS_4_NFC_BUFFERS_MASK;
 	port->config.nfc_credits |= nfc_credits;
 
 	return tb_port_write(port, &port->config.nfc_credits,
-			     TB_CFG_PORT, 4, 1);
+			     TB_CFG_PORT, ADP_CS_4, 1);
 }
 
 /**
@@ -578,14 +578,14 @@ int tb_port_set_initial_credits(struct tb_port *port, u32 credits)
 	u32 data;
 	int ret;
 
-	ret = tb_port_read(port, &data, TB_CFG_PORT, 5, 1);
+	ret = tb_port_read(port, &data, TB_CFG_PORT, ADP_CS_5, 1);
 	if (ret)
 		return ret;
 
-	data &= ~TB_PORT_LCA_MASK;
-	data |= (credits << TB_PORT_LCA_SHIFT) & TB_PORT_LCA_MASK;
+	data &= ~ADP_CS_5_LCA_MASK;
+	data |= (credits << ADP_CS_5_LCA_SHIFT) & ADP_CS_5_LCA_MASK;
 
-	return tb_port_write(port, &data, TB_CFG_PORT, 5, 1);
+	return tb_port_write(port, &data, TB_CFG_PORT, ADP_CS_5, 1);
 }
 
 /**
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 6d4e072f1f63..0ac22fc26a5f 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -211,13 +211,14 @@ struct tb_regs_port_header {
 
 } __packed;
 
-/* DWORD 4 */
-#define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
-#define TB_PORT_MAX_CREDITS_SHIFT	20
-#define TB_PORT_MAX_CREDITS_MASK	GENMASK(26, 20)
-/* DWORD 5 */
-#define TB_PORT_LCA_SHIFT		22
-#define TB_PORT_LCA_MASK		GENMASK(28, 22)
+/* Basic adapter configuration registers */
+#define ADP_CS_4				0x04
+#define ADP_CS_4_NFC_BUFFERS_MASK		GENMASK(9, 0)
+#define ADP_CS_4_TOTAL_BUFFERS_MASK		GENMASK(29, 20)
+#define ADP_CS_4_TOTAL_BUFFERS_SHIFT		20
+#define ADP_CS_5				0x05
+#define ADP_CS_5_LCA_MASK			GENMASK(28, 22)
+#define ADP_CS_5_LCA_SHIFT			22
 
 /* Lane adapter registers */
 #define LANE_ADP_CS_0				0x00
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index ff55a114825a..c901fa488478 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -341,12 +341,12 @@ static void tb_dp_init_video_path(struct tb_path *path, bool discover)
 	path->weight = 1;
 
 	if (discover) {
-		path->nfc_credits = nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+		path->nfc_credits = nfc_credits & ADP_CS_4_NFC_BUFFERS_MASK;
 	} else {
 		u32 max_credits;
 
-		max_credits = (nfc_credits & TB_PORT_MAX_CREDITS_MASK) >>
-			TB_PORT_MAX_CREDITS_SHIFT;
+		max_credits = (nfc_credits & ADP_CS_4_TOTAL_BUFFERS_MASK) >>
+			ADP_CS_4_TOTAL_BUFFERS_SHIFT;
 		/* Leave some credits for AUX path */
 		path->nfc_credits = min(max_credits - 2, 12U);
 	}
@@ -495,8 +495,8 @@ static u32 tb_dma_credits(struct tb_port *nhi)
 {
 	u32 max_credits;
 
-	max_credits = (nhi->config.nfc_credits & TB_PORT_MAX_CREDITS_MASK) >>
-		TB_PORT_MAX_CREDITS_SHIFT;
+	max_credits = (nhi->config.nfc_credits & ADP_CS_4_TOTAL_BUFFERS_MASK) >>
+		ADP_CS_4_TOTAL_BUFFERS_SHIFT;
 	return min(max_credits, 13U);
 }
 
-- 
2.23.0

