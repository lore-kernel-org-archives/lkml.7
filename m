Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F24C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23D220659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ea8v4tKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfJBIBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:01:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10662 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfJBIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:01:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9459500004>; Wed, 02 Oct 2019 01:01:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 01:01:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Oct 2019 01:01:12 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Oct
 2019 08:01:12 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Oct 2019 08:01:12 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.102]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9459460002>; Wed, 02 Oct 2019 01:01:11 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 2/6] usb: host: xhci-tegra: Add Tegra194 XHCI support
Date:   Wed, 2 Oct 2019 16:00:47 +0800
Message-ID: <20191002080051.11142-3-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002080051.11142-1-jckuo@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570003280; bh=w8t9puLKTTif/ZtbLM6Pd69XMc6h1g6hTRIsID24Rok=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ea8v4tKEvPtY0R1mJNji+ZvXTQcO82sLqhY+xgOHr23u54MHiIlpYr5Jc85Esmr/J
         LHiHKNZcVkpu06KhR37cyWH83L94ObZ2MNzH2vhrybOyGMs6u6gZ1WYNkZxPAPnTRa
         mWh9+kg1Mv1RdRlCzkVxDhePb1vt++dCOuCB/XAx7aZminwpZT49JQlxYG4a84ivCS
         0oP6gwdeAUa8aI6+n0CPJrXmAaXAfF4Sh4RV+00S9TSlTJlPqFThrFLRhxvJ92oxTW
         rNJ1JH7WPsi+4m7qk7yhvkVbI3khsyua/6eMHjcXwXnqq9pVQqacdSSZmg6r9t3jbq
         CYdtrXOWALjeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds Tegra194 XUSB host mode controller support. This is
very similar to the existing Tegra124/Tegra210/Tegra186 XHCI, except
  1. the number of ports and PHYs differs
  2. the IPFS wrapper being removed
  3. mailbox registers address changes

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index add6b8fb40e1..f19d39874a3b 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1460,10 +1460,40 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	},
 };
 
+static const char * const tegra194_supply_names[] = {
+};
+
+static const struct tegra_xusb_phy_type tegra194_phy_types[] = {
+	{ .name = "usb3", .num = 4, },
+	{ .name = "usb2", .num = 4, },
+};
+
+static const struct tegra_xusb_soc tegra194_soc = {
+	.firmware = "nvidia/tegra194/xusb.bin",
+	.supply_names = tegra194_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra194_supply_names),
+	.phy_types = tegra194_phy_types,
+	.num_types = ARRAY_SIZE(tegra194_phy_types),
+	.ports = {
+		.usb3 = { .offset = 0, .count = 4, },
+		.usb2 = { .offset = 4, .count = 4, },
+	},
+	.scale_ss_clock = false,
+	.has_ipfs = false,
+	.mbox = {
+		.cmd = 0x68,
+		.data_in = 0x6c,
+		.data_out = 0x70,
+		.owner = 0x74,
+	},
+};
+MODULE_FIRMWARE("nvidia/tegra194/xusb.bin");
+
 static const struct of_device_id tegra_xusb_of_match[] = {
 	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_soc },
 	{ .compatible = "nvidia,tegra210-xusb", .data = &tegra210_soc },
 	{ .compatible = "nvidia,tegra186-xusb", .data = &tegra186_soc },
+	{ .compatible = "nvidia,tegra194-xusb", .data = &tegra194_soc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
-- 
2.17.1

