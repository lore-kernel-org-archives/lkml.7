Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69579C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152820850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfDJNkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:40:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:46418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732378AbfDJNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:37:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="222229018"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2019 06:36:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AF7C140D; Wed, 10 Apr 2019 16:36:54 +0300 (EEST)
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
Subject: [PATCH v4 07/36] thunderbolt: Enable TMU access when accessing port space on legacy devices
Date:   Wed, 10 Apr 2019 16:36:24 +0300
Message-Id: <20190410133653.88061-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
References: <20190410133653.88061-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light Ridge and Eagle Ridge both need to have TMU access enabled before
port space can be fully accessed so make sure it happens on those. This
allows us to get rid of the offset quirk in tb_port_find_cap().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/cap.c | 69 +++++++++++++++++++++++++++++----------
 drivers/thunderbolt/tb.h  | 10 ++++++
 2 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/thunderbolt/cap.c b/drivers/thunderbolt/cap.c
index 9553305c63ea..a58585b4e6d9 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -13,6 +13,7 @@
 
 #define CAP_OFFSET_MAX		0xff
 #define VSE_CAP_OFFSET_MAX	0xffff
+#define TMU_ACCESS_EN		BIT(20)
 
 struct tb_cap_any {
 	union {
@@ -22,28 +23,38 @@ struct tb_cap_any {
 	};
 } __packed;
 
-/**
- * tb_port_find_cap() - Find port capability
- * @port: Port to find the capability for
- * @cap: Capability to look
- *
- * Returns offset to start of capability or %-ENOENT if no such
- * capability was found. Negative errno is returned if there was an
- * error.
- */
-int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+static int tb_port_enable_tmu(struct tb_port *port, bool enable)
 {
-	u32 offset;
+	struct tb_switch *sw = port->sw;
+	u32 value, offset;
+	int ret;
 
 	/*
-	 * DP out adapters claim to implement TMU capability but in
-	 * reality they do not so we hard code the adapter specific
-	 * capability offset here.
+	 * Legacy devices need to have TMU access enabled before port
+	 * space can be fully accessed.
 	 */
-	if (port->config.type == TB_TYPE_DP_HDMI_OUT)
-		offset = 0x39;
+	if (tb_switch_is_lr(sw))
+		offset = 0x26;
+	else if (tb_switch_is_er(sw))
+		offset = 0x2a;
+	else
+		return 0;
+
+	ret = tb_sw_read(sw, &value, TB_CFG_SWITCH, offset, 1);
+	if (ret)
+		return ret;
+
+	if (enable)
+		value |= TMU_ACCESS_EN;
 	else
-		offset = 0x1;
+		value &= ~TMU_ACCESS_EN;
+
+	return tb_sw_write(sw, &value, TB_CFG_SWITCH, offset, 1);
+}
+
+static int __tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+{
+	u32 offset = 1;
 
 	do {
 		struct tb_cap_any header;
@@ -62,6 +73,30 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
 	return -ENOENT;
 }
 
+/**
+ * tb_port_find_cap() - Find port capability
+ * @port: Port to find the capability for
+ * @cap: Capability to look
+ *
+ * Returns offset to start of capability or %-ENOENT if no such
+ * capability was found. Negative errno is returned if there was an
+ * error.
+ */
+int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
+{
+	int ret;
+
+	ret = tb_port_enable_tmu(port, true);
+	if (ret)
+		return ret;
+
+	ret = __tb_port_find_cap(port, cap);
+
+	tb_port_enable_tmu(port, false);
+
+	return ret;
+}
+
 static int tb_switch_find_cap(struct tb_switch *sw, enum tb_switch_cap cap)
 {
 	int offset = sw->config.first_cap_offset;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 93c1ea21feeb..a166265dfcf9 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -436,6 +436,16 @@ static inline struct tb_switch *tb_to_switch(struct device *dev)
 	return NULL;
 }
 
+static inline bool tb_switch_is_lr(const struct tb_switch *sw)
+{
+	return sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE;
+}
+
+static inline bool tb_switch_is_er(const struct tb_switch *sw)
+{
+	return sw->config.device_id == PCI_DEVICE_ID_INTEL_EAGLE_RIDGE;
+}
+
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
-- 
2.20.1

