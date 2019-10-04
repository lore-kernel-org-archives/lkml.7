Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2939C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE67222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eUmy4fi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfJDQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:29:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14621 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfJDQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:29:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d97735b0000>; Fri, 04 Oct 2019 09:29:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 09:29:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Oct 2019 09:29:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 16:29:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 16:29:15 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.223]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9773580000>; Fri, 04 Oct 2019 09:29:15 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 1/7] xhci: tegra: Parameterize mailbox register addresses
Date:   Sat, 5 Oct 2019 00:29:00 +0800
Message-ID: <20191004162906.4818-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162906.4818-1-jckuo@nvidia.com>
References: <20191004162906.4818-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570206556; bh=3J5CM+iShX9HnmBqSs2UYEG11DDpBrM4rxQ1znZIh+U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eUmy4fi2HQpgNm1FqexzzEpBX7cSNQTYIqoHrS09MWnawU8l3FPd0maATha4pVAZp
         OhKBlj1YCKKXj7+9EVM++3C4L/QSV+52nMnWIseVLbJZ5QqSiA/+vMc/dIo0BRCioj
         adAUNLOHOImt+3ss6BB+6n8Gd4EkbVhzoC+TT02GcAdmB5TtFwn+jLOZu4gDA8PY3N
         PbSKY/W5tmk8HQ4TKTyW/dxbeo5fS0NiBnNf53SdgmkWTPJzxsB7v6WwzeRnucOCMb
         ioReypJVw8IjuTv8JWSqzCw06/6O5uggVp8gM1iQmypqP059olQzn1uoW2yf/r9fqk
         B847JLa4+RBkg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 XUSB host controller has rearranged mailbox registers. This
commit makes mailbox registers address a part of "soc" data so that
xhci-tegra driver can be used for Tegra194.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v3: none
Changes in v2: none

 drivers/usb/host/xhci-tegra.c | 58 +++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2ff7c911fbd0..add6b8fb40e1 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -42,19 +42,18 @@
 #define XUSB_CFG_CSB_BASE_ADDR			0x800
 
 /* FPCI mailbox registers */
-#define XUSB_CFG_ARU_MBOX_CMD			0x0e4
+/* XUSB_CFG_ARU_MBOX_CMD */
 #define  MBOX_DEST_FALC				BIT(27)
 #define  MBOX_DEST_PME				BIT(28)
 #define  MBOX_DEST_SMI				BIT(29)
 #define  MBOX_DEST_XHCI				BIT(30)
 #define  MBOX_INT_EN				BIT(31)
-#define XUSB_CFG_ARU_MBOX_DATA_IN		0x0e8
+/* XUSB_CFG_ARU_MBOX_DATA_IN and XUSB_CFG_ARU_MBOX_DATA_OUT */
 #define  CMD_DATA_SHIFT				0
 #define  CMD_DATA_MASK				0xffffff
 #define  CMD_TYPE_SHIFT				24
 #define  CMD_TYPE_MASK				0xff
-#define XUSB_CFG_ARU_MBOX_DATA_OUT		0x0ec
-#define XUSB_CFG_ARU_MBOX_OWNER			0x0f0
+/* XUSB_CFG_ARU_MBOX_OWNER */
 #define  MBOX_OWNER_NONE			0
 #define  MBOX_OWNER_FW				1
 #define  MBOX_OWNER_SW				2
@@ -146,6 +145,13 @@ struct tegra_xusb_phy_type {
 	unsigned int num;
 };
 
+struct tega_xusb_mbox_regs {
+	u16 cmd;
+	u16 data_in;
+	u16 data_out;
+	u16 owner;
+};
+
 struct tegra_xusb_soc {
 	const char *firmware;
 	const char * const *supply_names;
@@ -160,6 +166,8 @@ struct tegra_xusb_soc {
 		} usb2, ulpi, hsic, usb3;
 	} ports;
 
+	struct tega_xusb_mbox_regs mbox;
+
 	bool scale_ss_clock;
 	bool has_ipfs;
 };
@@ -395,15 +403,15 @@ static int tegra_xusb_mbox_send(struct tegra_xusb *tegra,
 	 * ACK/NAK messages.
 	 */
 	if (!(msg->cmd == MBOX_CMD_ACK || msg->cmd == MBOX_CMD_NAK)) {
-		value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_OWNER);
+		value = fpci_readl(tegra, tegra->soc->mbox.owner);
 		if (value != MBOX_OWNER_NONE) {
 			dev_err(tegra->dev, "mailbox is busy\n");
 			return -EBUSY;
 		}
 
-		fpci_writel(tegra, MBOX_OWNER_SW, XUSB_CFG_ARU_MBOX_OWNER);
+		fpci_writel(tegra, MBOX_OWNER_SW, tegra->soc->mbox.owner);
 
-		value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_OWNER);
+		value = fpci_readl(tegra, tegra->soc->mbox.owner);
 		if (value != MBOX_OWNER_SW) {
 			dev_err(tegra->dev, "failed to acquire mailbox\n");
 			return -EBUSY;
@@ -413,17 +421,17 @@ static int tegra_xusb_mbox_send(struct tegra_xusb *tegra,
 	}
 
 	value = tegra_xusb_mbox_pack(msg);
-	fpci_writel(tegra, value, XUSB_CFG_ARU_MBOX_DATA_IN);
+	fpci_writel(tegra, value, tegra->soc->mbox.data_in);
 
-	value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_CMD);
+	value = fpci_readl(tegra, tegra->soc->mbox.cmd);
 	value |= MBOX_INT_EN | MBOX_DEST_FALC;
-	fpci_writel(tegra, value, XUSB_CFG_ARU_MBOX_CMD);
+	fpci_writel(tegra, value, tegra->soc->mbox.cmd);
 
 	if (wait_for_idle) {
 		unsigned long timeout = jiffies + msecs_to_jiffies(250);
 
 		while (time_before(jiffies, timeout)) {
-			value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_OWNER);
+			value = fpci_readl(tegra, tegra->soc->mbox.owner);
 			if (value == MBOX_OWNER_NONE)
 				break;
 
@@ -431,7 +439,7 @@ static int tegra_xusb_mbox_send(struct tegra_xusb *tegra,
 		}
 
 		if (time_after(jiffies, timeout))
-			value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_OWNER);
+			value = fpci_readl(tegra, tegra->soc->mbox.owner);
 
 		if (value != MBOX_OWNER_NONE)
 			return -ETIMEDOUT;
@@ -598,16 +606,16 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
 
 	mutex_lock(&tegra->lock);
 
-	value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_DATA_OUT);
+	value = fpci_readl(tegra, tegra->soc->mbox.data_out);
 	tegra_xusb_mbox_unpack(&msg, value);
 
-	value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_CMD);
+	value = fpci_readl(tegra, tegra->soc->mbox.cmd);
 	value &= ~MBOX_DEST_SMI;
-	fpci_writel(tegra, value, XUSB_CFG_ARU_MBOX_CMD);
+	fpci_writel(tegra, value, tegra->soc->mbox.cmd);
 
 	/* clear mailbox owner if no ACK/NAK is required */
 	if (!tegra_xusb_mbox_cmd_requires_ack(msg.cmd))
-		fpci_writel(tegra, MBOX_OWNER_NONE, XUSB_CFG_ARU_MBOX_OWNER);
+		fpci_writel(tegra, MBOX_OWNER_NONE, tegra->soc->mbox.owner);
 
 	tegra_xusb_mbox_handle(tegra, &msg);
 
@@ -1375,6 +1383,12 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	},
 	.scale_ss_clock = true,
 	.has_ipfs = true,
+	.mbox = {
+		.cmd = 0xe4,
+		.data_in = 0xe8,
+		.data_out = 0xec,
+		.owner = 0xf0,
+	},
 };
 MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");
 
@@ -1407,6 +1421,12 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	},
 	.scale_ss_clock = false,
 	.has_ipfs = true,
+	.mbox = {
+		.cmd = 0xe4,
+		.data_in = 0xe8,
+		.data_out = 0xec,
+		.owner = 0xf0,
+	},
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
@@ -1432,6 +1452,12 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	},
 	.scale_ss_clock = false,
 	.has_ipfs = false,
+	.mbox = {
+		.cmd = 0xe4,
+		.data_in = 0xe8,
+		.data_out = 0xec,
+		.owner = 0xf0,
+	},
 };
 
 static const struct of_device_id tegra_xusb_of_match[] = {
-- 
2.17.1

