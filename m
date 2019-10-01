Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A585A21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbfJALiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:38:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:49106 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732572AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="197830157"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 626D656A; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 12/22] thunderbolt: Add Display Port CM handshake for Titan Ridge devices
Date:   Tue,  1 Oct 2019 14:38:20 +0300
Message-Id: <20191001113830.13028-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Titan Ridge devices and newer need an additional connection manager
handshake in order to do proper Display Port tunneling so implement it
here.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb_regs.h |  3 +++
 drivers/thunderbolt/tunnel.c  | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
index 3353396e0806..369800110e5e 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 
@@ -242,6 +243,41 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	return tunnel;
 }
 
+static int tb_dp_cm_handshake(struct tb_port *in, struct tb_port *out)
+{
+	int timeout = 10;
+	u32 val;
+	int ret;
+
+	/* Both ends need to support this */
+	if (!tb_switch_is_tr(in->sw) || !tb_switch_is_tr(out->sw))
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
@@ -256,6 +292,14 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
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

