Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF24C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000020848
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LtAAygdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgACIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:30:27 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5527 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgACIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:30:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0efb910000>; Fri, 03 Jan 2020 00:30:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:30:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:30:24 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:30:24 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:30:24 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0efb9d0010>; Fri, 03 Jan 2020 00:30:23 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v1 1/2] soc/tegra: fuse: Add Tegra194 support
Date:   Fri, 3 Jan 2020 16:30:17 +0800
Message-ID: <20200103083018.10575-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103083018.10575-1-jckuo@nvidia.com>
References: <20200103083018.10575-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578040209; bh=dijRJwgAKWW5MfcZeD2dYrl92h15fEfjCaIfZ783sXs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LtAAygdWP549eZLLtmF5fnZLE6/Z8VxWLQd3X8EAawl+UAmWYhQx6RIbTu50tpK+A
         Iylj6LvVJgMXCLfNh6ppKTO2y1o9LIwW8zl/1EMohIalkb5NXX+AdX2BiZ2xWa5h0J
         f4ZlSPOPm3bzjrz/QZaAt6bPUGuuSXtPMjOtTqVe67tJKu7qVAYPtn3QGmL1IE+wZ9
         1Q9ZmnyYaZdpbA18ufZ3qvbUqZF+u4LJRDN10lLIKOuRE+I3nxGJoEvKbAtnVnDdJZ
         QpzG0p97wZtRMILHjOhBMAv3WL5ObET3NmkoaUGb47mvm8jQ3zFhEfYjKgGzmkevVF
         JEW94jV2qanYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds Tegra194 fuse/apbmisc support.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c    |  3 +++
 drivers/soc/tegra/fuse/fuse-tegra30.c  | 29 ++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h          |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 606abbe55bba..802717b9f6a3 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -49,6 +49,9 @@ static struct tegra_fuse *fuse = &(struct tegra_fuse) {
 };
 
 static const struct of_device_id tegra_fuse_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_194_SOC
+	{ .compatible = "nvidia,tegra194-efuse", .data = &tegra194_fuse_soc },
+#endif
 #ifdef CONFIG_ARCH_TEGRA_186_SOC
 	{ .compatible = "nvidia,tegra186-efuse", .data = &tegra186_fuse_soc },
 #endif
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index b8daaf5b7291..f68f4e1c215d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -320,3 +320,32 @@ const struct tegra_fuse_soc tegra186_fuse_soc = {
 	.num_lookups = ARRAY_SIZE(tegra186_fuse_lookups),
 };
 #endif
+
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
+	{
+		.nvmem_name = "fuse",
+		.cell_name = "xusb-pad-calibration",
+		.dev_id = "3520000.padctl",
+		.con_id = "calibration",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "xusb-pad-calibration-ext",
+		.dev_id = "3520000.padctl",
+		.con_id = "calibration-ext",
+	},
+};
+
+static const struct tegra_fuse_info tegra194_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x300,
+	.spare = 0x280,
+};
+
+const struct tegra_fuse_soc tegra194_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.info = &tegra194_fuse_info,
+	.lookups = tegra194_fuse_lookups,
+	.num_lookups = ARRAY_SIZE(tegra194_fuse_lookups),
+};
+#endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 0f74c2c34af0..94a059e577a1 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -108,4 +108,8 @@ extern const struct tegra_fuse_soc tegra210_fuse_soc;
 extern const struct tegra_fuse_soc tegra186_fuse_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_194_SOC
+extern const struct tegra_fuse_soc tegra194_fuse_soc;
+#endif
+
 #endif
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index a2fd6ccd48f9..7e608f682391 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -63,6 +63,7 @@ u32 tegra_read_ram_code(void)
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
 	{ .compatible = "nvidia,tegra186-misc", },
+	{ .compatible = "nvidia,tegra194-misc", },
 	{},
 };
 
-- 
2.17.1

