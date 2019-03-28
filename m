Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038F217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfC1MiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:38:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:9523 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfC1Mgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="286671461"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 063C410F5; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
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
Subject: [PATCH v3 25/36] thunderbolt: Rework NFC credits handling
Date:   Thu, 28 Mar 2019 15:36:22 +0300
Message-Id: <20190328123633.42882-26-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFC (non flow control) credits is actually 20-bit field so update
tb_port_add_nfc_credits() to handle this properly. This allows us to set
NFC credits for Display Port path in subsequent patches.

Also make sure the function does not update the hardware if the
underlying switch is already unplugged.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 20 +++++++++++++-------
 drivers/thunderbolt/tb_regs.h |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 028e9a293382..9462e6982061 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -537,14 +537,20 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
  */
 int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 {
-	if (credits == 0)
+	u32 nfc_credits;
+
+	if (credits == 0 || port->sw->is_unplugged)
 		return 0;
-	tb_port_info(port,
-		     "adding %#x NFC credits (%#x -> %#x)",
-		     credits,
-		     port->config.nfc_credits,
-		     port->config.nfc_credits + credits);
-	port->config.nfc_credits += credits;
+
+	nfc_credits = port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+	nfc_credits += credits;
+
+	tb_port_dbg(port, "adding %d NFC credits to %lu",
+		    credits, port->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK);
+
+	port->config.nfc_credits &= ~TB_PORT_NFC_CREDITS_MASK;
+	port->config.nfc_credits |= nfc_credits;
+
 	return tb_port_write(port, &port->config.nfc_credits,
 			     TB_CFG_PORT, 4, 1);
 }
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 75e935acade5..74c0f4a5606d 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -211,6 +211,9 @@ struct tb_regs_port_header {
 
 } __packed;
 
+/* DWORD 4 */
+#define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
+
 /* PCIe adapter registers */
 
 #define TB_PCI_EN			BIT(31)
-- 
2.20.1

