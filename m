Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF47CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5572084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404893AbfJWLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:21010 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404696AbfJWLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="349365432"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 301A04E7; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 05/25] thunderbolt: Convert PCIe adapter register names to follow the USB4 spec
Date:   Wed, 23 Oct 2019 14:21:34 +0300
Message-Id: <20191023112154.64235-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that USB4 spec has names for these PCIe adapter registers we can use
them instead. This makes it easier to match certain register to the spec.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 10 ++++++----
 drivers/thunderbolt/tb_regs.h |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index afc725cf27c9..e3fd2c33dafc 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -803,10 +803,11 @@ bool tb_pci_port_is_enabled(struct tb_port *port)
 {
 	u32 data;
 
-	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+	if (tb_port_read(port, &data, TB_CFG_PORT,
+			 port->cap_adap + ADP_PCIE_CS_0, 1))
 		return false;
 
-	return !!(data & TB_PCI_EN);
+	return !!(data & ADP_PCIE_CS_0_PE);
 }
 
 /**
@@ -816,10 +817,11 @@ bool tb_pci_port_is_enabled(struct tb_port *port)
  */
 int tb_pci_port_enable(struct tb_port *port, bool enable)
 {
-	u32 word = enable ? TB_PCI_EN : 0x0;
+	u32 word = enable ? ADP_PCIE_CS_0_PE : 0x0;
 	if (!port->cap_adap)
 		return -ENXIO;
-	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
+	return tb_port_write(port, &word, TB_CFG_PORT,
+			     port->cap_adap + ADP_PCIE_CS_0, 1);
 }
 
 /**
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index d0858db9f904..4be9df354527 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -241,8 +241,8 @@ struct tb_regs_port_header {
 #define TB_DP_REMOTE_CAP		0x5
 
 /* PCIe adapter registers */
-
-#define TB_PCI_EN			BIT(31)
+#define ADP_PCIE_CS_0				0x00
+#define ADP_PCIE_CS_0_PE			BIT(31)
 
 /* Hop register from TB_CFG_HOPS. 8 byte per entry. */
 struct tb_regs_hop {
-- 
2.23.0

