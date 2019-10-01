Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6AC21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfJALjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:17382 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732566AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="220968921"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 57EF151B; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 11/22] thunderbolt: Convert DP adapter register names to follow the USB4 spec
Date:   Tue,  1 Oct 2019 14:38:19 +0300
Message-Id: <20191001113830.13028-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that USB4 spec has names for these DP adapter registers we can use
them instead. This makes it easier to match certain register to the spec.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 50 ++++++++++++++++++++---------------
 drivers/thunderbolt/tb_regs.h | 32 ++++++++++------------
 drivers/thunderbolt/tunnel.c  |  8 +++---
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 2079e6065038..604cb3ef4985 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -961,11 +961,12 @@ int tb_dp_port_hpd_is_active(struct tb_port *port)
 	u32 data;
 	int ret;
 
-	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 2, 1);
+	ret = tb_port_read(port, &data, TB_CFG_PORT,
+			   port->cap_adap + ADP_DP_CS_2, 1);
 	if (ret)
 		return ret;
 
-	return !!(data & TB_DP_HDP);
+	return !!(data & ADP_DP_CS_2_HDP);
 }
 
 /**
@@ -979,12 +980,14 @@ int tb_dp_port_hpd_clear(struct tb_port *port)
 	u32 data;
 	int ret;
 
-	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+	ret = tb_port_read(port, &data, TB_CFG_PORT,
+			   port->cap_adap + ADP_DP_CS_3, 1);
 	if (ret)
 		return ret;
 
-	data |= TB_DP_HPDC;
-	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+	data |= ADP_DP_CS_3_HDPC;
+	return tb_port_write(port, &data, TB_CFG_PORT,
+			     port->cap_adap + ADP_DP_CS_3, 1);
 }
 
 /**
@@ -1002,20 +1005,23 @@ int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
 	u32 data[2];
 	int ret;
 
-	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
-			   ARRAY_SIZE(data));
+	ret = tb_port_read(port, data, TB_CFG_PORT,
+			   port->cap_adap + ADP_DP_CS_0, ARRAY_SIZE(data));
 	if (ret)
 		return ret;
 
-	data[0] &= ~TB_DP_VIDEO_HOPID_MASK;
-	data[1] &= ~(TB_DP_AUX_RX_HOPID_MASK | TB_DP_AUX_TX_HOPID_MASK);
+	data[0] &= ~ADP_DP_CS_0_VIDEO_HOPID_MASK;
+	data[1] &= ~ADP_DP_CS_1_AUX_RX_HOPID_MASK;
+	data[1] &= ~ADP_DP_CS_1_AUX_RX_HOPID_MASK;
 
-	data[0] |= (video << TB_DP_VIDEO_HOPID_SHIFT) & TB_DP_VIDEO_HOPID_MASK;
-	data[1] |= aux_tx & TB_DP_AUX_TX_HOPID_MASK;
-	data[1] |= (aux_rx << TB_DP_AUX_RX_HOPID_SHIFT) & TB_DP_AUX_RX_HOPID_MASK;
+	data[0] |= (video << ADP_DP_CS_0_VIDEO_HOPID_SHIFT) &
+		ADP_DP_CS_0_VIDEO_HOPID_MASK;
+	data[1] |= aux_tx & ADP_DP_CS_1_AUX_TX_HOPID_MASK;
+	data[1] |= (aux_rx << ADP_DP_CS_1_AUX_RX_HOPID_SHIFT) &
+		ADP_DP_CS_1_AUX_RX_HOPID_MASK;
 
-	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
-			     ARRAY_SIZE(data));
+	return tb_port_write(port, data, TB_CFG_PORT,
+			     port->cap_adap + ADP_DP_CS_0, ARRAY_SIZE(data));
 }
 
 /**
@@ -1026,11 +1032,11 @@ bool tb_dp_port_is_enabled(struct tb_port *port)
 {
 	u32 data[2];
 
-	if (tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
+	if (tb_port_read(port, data, TB_CFG_PORT, port->cap_adap + ADP_DP_CS_0,
 			 ARRAY_SIZE(data)))
 		return false;
 
-	return !!(data[0] & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
+	return !!(data[0] & (ADP_DP_CS_0_VE | ADP_DP_CS_0_AE));
 }
 
 /**
@@ -1046,18 +1052,18 @@ int tb_dp_port_enable(struct tb_port *port, bool enable)
 	u32 data[2];
 	int ret;
 
-	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
-			   ARRAY_SIZE(data));
+	ret = tb_port_read(port, data, TB_CFG_PORT,
+			  port->cap_adap + ADP_DP_CS_0, ARRAY_SIZE(data));
 	if (ret)
 		return ret;
 
 	if (enable)
-		data[0] |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
+		data[0] |= ADP_DP_CS_0_VE | ADP_DP_CS_0_AE;
 	else
-		data[0] &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
+		data[0] &= ~(ADP_DP_CS_0_VE | ADP_DP_CS_0_AE);
 
-	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
-			     ARRAY_SIZE(data));
+	return tb_port_write(port, data, TB_CFG_PORT,
+			     port->cap_adap + ADP_DP_CS_0, ARRAY_SIZE(data));
 }
 
 /* switch utility functions */
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index cd03d160634c..3a39490a954b 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -238,24 +238,20 @@ struct tb_regs_port_header {
 #define LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT	20
 
 /* Display Port adapter registers */
-
-/* DWORD 0 */
-#define TB_DP_VIDEO_HOPID_SHIFT		16
-#define TB_DP_VIDEO_HOPID_MASK		GENMASK(26, 16)
-#define TB_DP_AUX_EN			BIT(30)
-#define TB_DP_VIDEO_EN			BIT(31)
-/* DWORD 1 */
-#define TB_DP_AUX_TX_HOPID_MASK		GENMASK(10, 0)
-#define TB_DP_AUX_RX_HOPID_SHIFT	11
-#define TB_DP_AUX_RX_HOPID_MASK		GENMASK(21, 11)
-/* DWORD 2 */
-#define TB_DP_HDP			BIT(6)
-/* DWORD 3 */
-#define TB_DP_HPDC			BIT(9)
-/* DWORD 4 */
-#define TB_DP_LOCAL_CAP			0x4
-/* DWORD 5 */
-#define TB_DP_REMOTE_CAP		0x5
+#define ADP_DP_CS_0				0x00
+#define ADP_DP_CS_0_VIDEO_HOPID_MASK		GENMASK(26, 16)
+#define ADP_DP_CS_0_VIDEO_HOPID_SHIFT		16
+#define ADP_DP_CS_0_AE				BIT(30)
+#define ADP_DP_CS_0_VE				BIT(31)
+#define ADP_DP_CS_1_AUX_TX_HOPID_MASK		GENMASK(10, 0)
+#define ADP_DP_CS_1_AUX_RX_HOPID_MASK		GENMASK(21, 11)
+#define ADP_DP_CS_1_AUX_RX_HOPID_SHIFT		11
+#define ADP_DP_CS_2				0x02
+#define ADP_DP_CS_2_HDP				BIT(6)
+#define ADP_DP_CS_3				0x03
+#define ADP_DP_CS_3_HDPC			BIT(9)
+#define DP_LOCAL_CAP				0x04
+#define DP_REMOTE_CAP				0x05
 
 /* PCIe adapter registers */
 #define ADP_PCIE_CS_0				0x00
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index c901fa488478..3353396e0806 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -258,23 +258,23 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 
 	/* Read both DP_LOCAL_CAP registers */
 	ret = tb_port_read(in, &in_dp_cap, TB_CFG_PORT,
-			   in->cap_adap + TB_DP_LOCAL_CAP, 1);
+			   in->cap_adap + DP_LOCAL_CAP, 1);
 	if (ret)
 		return ret;
 
 	ret = tb_port_read(out, &out_dp_cap, TB_CFG_PORT,
-			   out->cap_adap + TB_DP_LOCAL_CAP, 1);
+			   out->cap_adap + DP_LOCAL_CAP, 1);
 	if (ret)
 		return ret;
 
 	/* Write IN local caps to OUT remote caps */
 	ret = tb_port_write(out, &in_dp_cap, TB_CFG_PORT,
-			    out->cap_adap + TB_DP_REMOTE_CAP, 1);
+			    out->cap_adap + DP_REMOTE_CAP, 1);
 	if (ret)
 		return ret;
 
 	return tb_port_write(in, &out_dp_cap, TB_CFG_PORT,
-			     in->cap_adap + TB_DP_REMOTE_CAP, 1);
+			     in->cap_adap + DP_REMOTE_CAP, 1);
 }
 
 static int tb_dp_activate(struct tb_tunnel *tunnel, bool active)
-- 
2.23.0

