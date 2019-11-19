Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4BC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2872222DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XQPJ/vsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfKSGu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:50:57 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10776 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSGuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:50:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390d10000>; Mon, 18 Nov 2019 22:50:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:50:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:50:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:50:53 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:50:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390cc0001>; Mon, 18 Nov 2019 22:50:53 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/17] soc: tegra: pmc: Add helper function for PLLE IDDQ override
Date:   Mon, 18 Nov 2019 22:50:19 -0800
Message-ID: <1574146234-3871-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146257; bh=LhkgMNuqBPFAdLZm0FBQCFloGBfuJsr4cX4Hs0q+3mo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XQPJ/vsN9kjxaPcdssuE8V0+K+tY4ca5jUlYcnQHZvjlreMo4qy1RP3MqMkl1IB6k
         anHJ9o2sGyID7dIkmznCbvu1qwI1jI5yM7B9wErNdnbYk9y7uJ/SQihjWRYRPrgK4x
         Ed+Dzv+j2Mc8nGYNGqIukP+TrzVDg+ODY/iMqeuxmuPzDnyWSeWHa5QPhsM5pU864p
         GOZ7w5uSMO+TgyuHbk/IKHyApCVWF8v8BcIQihrTJRmYU9jJQ9J+MAetCKlP5nUw4s
         oUoO39fEHGHrD7YK5wmokOtMgTLAbXlrqDxQaPM8aYwUUFbzBifor94AQHOeKoDnKG
         WB79PiY/FEoLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has PLLE IDDQ mode override to allow software control
of PLLE power up or down.

PLLE is put in IDDQ mode by the hardware. Software can override
the PLLE IDDQ control by setting the IDDQ override bit and IDDQ
SWCTL bits in the PMC_SATA_PWRGT PMC register.

Currently Tegra clock driver overrides hardware IDDQ control and
clears PLLE IDDQ during PLLE training by direct Tegra PMC register
access. With this, when PMC is in secure mode any direct PMC register
access from non-secure mode will not go through.

This patch adds helper function for software control of PLLE IDDQ
to use by Tegra clock driver.

Helper function uses tegra_pmc_readl and tegra_pmc_writel which
handles both secure mode and non-secure mode PMC register access.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 22 ++++++++++++++++++++++
 include/soc/tegra/pmc.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 224e7cf8dc00..7a5aab0b993b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -108,6 +108,10 @@
 #define PMC_WAKE2_STATUS		0x168
 #define PMC_SW_WAKE2_STATUS		0x16c
 
+#define PMC_SATA_PWRGT			0x1ac
+#define PMC_SATA_PWRGT_PLLE_IDDQ_VALUE BIT(5)
+#define PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL BIT(4)
+
 #define PMC_SENSOR_CTRL			0x1b0
 #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
 #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
@@ -1177,6 +1181,24 @@ static void tegra_powergate_remove_all(struct device_node *parent)
 	of_node_put(np);
 }
 
+void tegra_pmc_clear_plle_iddq(void)
+{
+	u32 val;
+
+	val = tegra_pmc_readl(pmc, PMC_SATA_PWRGT);
+	val |= PMC_SATA_PWRGT_PLLE_IDDQ_VALUE;
+	tegra_pmc_writel(pmc, val, PMC_SATA_PWRGT);
+
+	val = tegra_pmc_readl(pmc, PMC_SATA_PWRGT);
+	val |= PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL;
+	tegra_pmc_writel(pmc, val, PMC_SATA_PWRGT);
+
+	val = tegra_pmc_readl(pmc, PMC_SATA_PWRGT);
+	val &= ~PMC_SATA_PWRGT_PLLE_IDDQ_VALUE;
+	tegra_pmc_writel(pmc, val, PMC_SATA_PWRGT);
+}
+EXPORT_SYMBOL(tegra_pmc_clear_plle_iddq);
+
 bool tegra_pmc_is_pllm_wb0_override_enabled(void)
 {
 	u32 val;
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index cbf23e0d3c55..2fdd60484765 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -25,6 +25,7 @@ bool tegra_pmc_is_pllm_wb0_enabled(void);
 void tegra_pmc_set_pllm_wb0_enable(bool enable);
 void tegra_pmc_get_pllm_wb0_mnp_overrides(u32 *divm, u32 *divn, u8 *divp);
 void tegra_pmc_set_pllm_wb0_mnp_overrides(u32 divm, u32 divn, u8 divp);
+void tegra_pmc_clear_plle_iddq(void);
 
 /*
  * powergate and I/O rail APIs
-- 
2.7.4

