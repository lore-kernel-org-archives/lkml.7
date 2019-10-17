Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A9FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IU2aHUGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440378AbfJQOrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:47:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35515 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440344AbfJQOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571323636; x=1602859636;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DhO81u4ZNcMxwucobpy3G4tWaQ8N0edqIV6MQOrjO4w=;
  b=IU2aHUGumledk0nNowrgsI42+eLkn9RmUtV0Zm01MChovK1p5/5Gkv9p
   Nv3oQJvXT3dFV7PjgRB/2Wu4MjL1pwslNeeTr834Eq8dC7iPV+Wln++AF
   E3l62hJucLPCpL0pnOFe1J9stX6/rk+ghuWPKx/GoKnk8wR4u2AD4I8xK
   o=;
X-IronPort-AV: E=Sophos;i="5.67,308,1566864000"; 
   d="scan'208";a="759881823"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 17 Oct 2019 14:47:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 29913240B9F;
        Thu, 17 Oct 2019 14:47:13 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 17 Oct 2019 14:47:13 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.160.153) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 17 Oct 2019 14:47:07 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH 1/1] ahci: Add support for Amazon's Annapurna Labs SATA controller
Date:   Thu, 17 Oct 2019 15:46:53 +0100
Message-ID: <20191017144653.3429-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D14UWB004.ant.amazon.com (10.43.161.137) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Amazon's Annapurna Labs SATA
controller.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/ata/ahci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dd92faf197d5..8ac7e806aa97 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -56,6 +56,7 @@ enum board_ids {
 	board_ahci_yes_fbs,
 
 	/* board IDs for specific chipsets in alphabetical order */
+	board_ahci_al,
 	board_ahci_avn,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
@@ -167,6 +168,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	/* by chipsets */
+	[board_ahci_al] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP | AHCI_HFLAG_NO_MSI),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_avn] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -415,6 +423,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800 */
 	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */
 
+	/* Amazon's Annapurna Labs support */
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031),
+		.class = PCI_CLASS_STORAGE_SATA_AHCI,
+		.class_mask = 0xffffff,
+		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-- 
2.17.1

