Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F791C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9144222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j0I2Ntvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfJDQ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:29:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19892 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJDQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:29:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9773610004>; Fri, 04 Oct 2019 09:29:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 09:29:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Oct 2019 09:29:18 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 16:29:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 16:29:18 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.223]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d97735b0002>; Fri, 04 Oct 2019 09:29:17 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 2/7] usb: host: xhci-tegra: Add Tegra194 XHCI support
Date:   Sat, 5 Oct 2019 00:29:01 +0800
Message-ID: <20191004162906.4818-3-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162906.4818-1-jckuo@nvidia.com>
References: <20191004162906.4818-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570206561; bh=F5NvidTqkBflYCsK6RSZEEvKrv7+50v+R2S3BdPx1kk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=j0I2NtvxLJ2ep0SMSd2DOg9VuYYXGC9OxTojihlstp/RtzfZXajpu0RowM6enryHx
         2tPbEG7a2fEvMlHNq7TlbuwKXY4xgojP8g9u+mQMFqTy1mTZRHG1kZymw+UGJu+5Nd
         T0SdK0q5nl3thwO0BorivzXPuqEXCMttlD8e7+bQZx4t2hgnJ2clNfseiLRwxhN9Mt
         gIYwwqMjplxyAA2rlEZsj7ZFOcdLIJ/tSYifAujRz+qUtiMCQ67at91QwSKQaUbhhm
         sd1JeGordvIP5mIK4fo6qo+iSV4868PQ7qTcX1O07bTiEtmcXw2wEfOLeEprQMM+wr
         A469ZURl42jEg==
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
Changes in v3: none
Changes in v2: none

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

