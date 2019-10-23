Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD4BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8002064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405022AbfJWLXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:23:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:54237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404839AbfJWLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="201105229"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 88F551F5; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 14/25] thunderbolt: Add Display Port CM handshake for Titan Ridge devices
Date:   Wed, 23 Oct 2019 14:21:43 +0300
Message-Id: <20191023112154.64235-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Titan Ridge needs an additional connection manager handshake in order to
do proper Display Port tunneling so implement it here.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb_regs.h |  3 +++
 drivers/thunderbolt/tunnel.c  | 45 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 3a39490a954b..8d11b4a2d552 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -252,6 +252,9 @@ struct tb_regs_port_header {
 #define ADP_DP_CS_3_HDPC			BIT(9)
 #define DP_LOCAL_CAP				0x04
 #define DP_REMOTE_CAP				0x05
+#define DP_STATUS_CTRL				0x06
+#define DP_STATUS_CTRL_CMHS			BIT(25)
+#define DP_STATUS_CTRL_UF			BIT(26)
 
 /* PCIe adapter registers */
 #define ADP_PCIE_CS_0				0x00
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 3353396e0806..009c2683a386 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 
@@ -242,6 +243,42 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	return tunnel;
 }
 
+static int tb_dp_cm_handshake(struct tb_port *in, struct tb_port *out)
+{
+	int timeout = 10;
+	u32 val;
+	int ret;
+
+	/* Both ends need to support this */
+	if (!tb_switch_is_titan_ridge(in->sw) ||
+	    !tb_switch_is_titan_ridge(out->sw))
+		return 0;
+
+	ret = tb_port_read(out, &val, TB_CFG_PORT,
+			   out->cap_adap + DP_STATUS_CTRL, 1);
+	if (ret)
+		return ret;
+
+	val |= DP_STATUS_CTRL_UF | DP_STATUS_CTRL_CMHS;
+
+	ret = tb_port_write(out, &val, TB_CFG_PORT,
+			    out->cap_adap + DP_STATUS_CTRL, 1);
+	if (ret)
+		return ret;
+
+	do {
+		ret = tb_port_read(out, &val, TB_CFG_PORT,
+				   out->cap_adap + DP_STATUS_CTRL, 1);
+		if (ret)
+			return ret;
+		if (!(val & DP_STATUS_CTRL_CMHS))
+			return 0;
+		usleep_range(10, 100);
+	} while (timeout--);
+
+	return -ETIMEDOUT;
+}
+
 static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 {
 	struct tb_port *out = tunnel->dst_port;
@@ -256,6 +293,14 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 	if (in->sw->generation < 2 || out->sw->generation < 2)
 		return 0;
 
+	/*
+	 * Perform connection manager handshake between IN and OUT ports
+	 * before capabilities exchange can take place.
+	 */
+	ret = tb_dp_cm_handshake(in, out);
+	if (ret)
+		return ret;
+
 	/* Read both DP_LOCAL_CAP registers */
 	ret = tb_port_read(in, &in_dp_cap, TB_CFG_PORT,
 			   in->cap_adap + DP_LOCAL_CAP, 1);
-- 
2.23.0

