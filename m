Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64338CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE821479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nFUEjYV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfJ2Kbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:31:36 -0400
Received: from mail-eopbgr720085.outbound.protection.outlook.com ([40.107.72.85]:6946
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbfJ2KbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7OupckCauu2yNuAFnGV+qTZp0WbnPE8JEqf8PH3YnPCRE1v3eJ3DaALXsOUPm4D0MUtdWoy1GUP5H+YKkVkhq1Z2Hm+lJ0kasX/KPjLcfSLwDpaApdyIhgZbPN2GXVNPvgygExg4CqIfr5SQpCExbaAX+r9FH0YhEdUmyJ120FN7uyjOC3lFuxwnUiyKtnhX7sxiupibWvJJLVVs9end9Gpd/CBWhNg2/uhSUXI9lMV7ADg5+g5axiAxgoRin4Ad43jLlP6gzM+O8NFcC3ZdoXbEpZd+Dj65dbN8FhqyM1NW59T+EVuEMJK3m3WX2qVyemjSbURDAePrDTy5zcswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fu793N4HcGPsyWzUeRtHJTuiLzmOVqRI0dySVzggGs=;
 b=P0leDE5brCsC4sFc4aIwzD+HCYugr6sDXZmeOrupjRF0P5VZlWjeourg4qjsXJDGJKqsu5jIbwwfjPHeM58DbOJi7qF5LUfneKUYjYYMpMDGcIAi82fpSVhcC+xt59Z4u2FEMNln6fuGri0QgbAs53NZ1k+aFUJMWm9Na/FY6ECP21qjRdk1cTFOq0pHs4nFzXalC4G+qm/gk1P+Vt9ZNDye4POICaIIsThxrsDGxmdVRYiV3OmBWxTP3xG2k/lvpa9ffc+eVkT4h8fXg52FeEavPmEqxnykibhHbhL9BboDLlayLSvKt7BU2ZfRInP1BKeiF7EsEhbER/r1rsYpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fu793N4HcGPsyWzUeRtHJTuiLzmOVqRI0dySVzggGs=;
 b=nFUEjYV6uLVVqUcQliH1Q//OZOP/RjalBCQJU/dMVcl7w+4dgZ1qPU0/fbj+lAsflAr0G2aBZ1CRPZLIsazrtqagTNX47hGPeTNGMjxVaCa9oKevWZz1BlW+441PHeaNsQb+S6jl59rSXYpbRMprOHOaduLVuup1j5cwchraPTE=
Received: from MWHPR02CA0017.namprd02.prod.outlook.com (2603:10b6:300:4b::27)
 by BN6PR02MB2177.namprd02.prod.outlook.com (2603:10b6:404:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 10:31:02 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR02CA0017.outlook.office365.com
 (2603:10b6:300:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Tue, 29 Oct 2019 10:31:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 10:31:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOmD-0002u0-Mi; Tue, 29 Oct 2019 03:31:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOm8-0005qH-Hf; Tue, 29 Oct 2019 03:30:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iPOly-0005lD-6v; Tue, 29 Oct 2019 03:30:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 86632121800; Tue, 29 Oct 2019 16:00:44 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v4 8/8] mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
Date:   Tue, 29 Oct 2019 16:00:42 +0530
Message-Id: <1572345042-101207-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(376002)(199004)(189003)(81166006)(8936002)(8676002)(44832011)(81156014)(70206006)(50226002)(70586007)(4326008)(305945005)(186003)(426003)(2616005)(446003)(476003)(486006)(14444005)(126002)(11346002)(336012)(2906002)(47776003)(356004)(5660300002)(76176011)(51416003)(26005)(478600001)(36756003)(16586007)(106002)(42186006)(107886003)(36386004)(316002)(6266002)(48376002)(50466002)(103686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2177;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667bd9b7-6f4d-4fea-1ba2-08d75c5b18c2
X-MS-TrafficTypeDiagnostic: BN6PR02MB2177:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2177A3D3AC81B5DFFD49132EC1610@BN6PR02MB2177.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpqKicsedkMDl2dqnjFlAhrouHrRG9VDlfZiErXFfE+exkb7FTpjU6zW8XkcecjfynVGQ/CaiK5XuUlfrpZx2qgLOscgkeOb2dUnkKH/9eV1F5+ZaWajJqSvIxj8JrNJyzh80CargZ4oFspsfVRqKUjMvTghxQUvAjaoasRBDGIsOdUV4H348wUfwvqdgon6FC0H7TPGblCN4qZK84SJ/7VTgEvyH9AlkDZ1QTzyW7Fp8FrKUcbHXUv1+5JM9rguTgenxNCsYMW/J7Qcel75PHfKQQm5HWfVfxTBKJkmecgE0RtaJhKAfUk5M8FEdEimA85hfMJqlyQHjaiPScAGZqh0JAguLN+Xt7wm2sLhb/qEBu7xvMRUTT4+AATB0NyfZrjjnaG0mJDEQg1mFMdQubzUh7YiQ0dOqu4V9NBmlXxPH0vN8rwkKfY5qbwas5wn
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 10:31:02.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667bd9b7-6f4d-4fea-1ba2-08d75c5b18c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from taps set by auto tuning, ZynqMP platform has feature to set
the tap values manually. Add support to set tap delay values in HW via
ZynqMP SoC framework.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 206 ++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 18eb6cffd269..f488c8bb2be3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -22,6 +22,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -32,6 +33,10 @@
 
 #define PHY_CLK_TOO_SLOW_HZ		400000
 
+/* Default settings for ZynqMP Clock Phases */
+#define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
+#define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This allows
@@ -80,6 +85,7 @@ struct sdhci_arasan_soc_ctl_map {
  * @clk_phase_in:	Array of Input Clock Phase Delays for all speed modes
  * @clk_phase_out:	Array of Output Clock Phase Delays for all speed modes
  * @set_clk_delays:	Function pointer for setting Clock Delays
+ * @clk_of_data:	Platform specific runtime clock data storage pointer
  */
 struct sdhci_arasan_clk_data {
 	struct clk_hw	sdcardclk_hw;
@@ -89,6 +95,11 @@ struct sdhci_arasan_clk_data {
 	int		clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
 	int		clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
 	void		(*set_clk_delays)(struct sdhci_host *host);
+	void		*clk_of_data;
+};
+
+struct sdhci_arasan_zynqmp_clk_data {
+	const struct zynqmp_eemi_ops *eemi_ops;
 };
 
 /**
@@ -525,6 +536,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "arasan,sdhci-4.9a",
 		.data = &sdhci_arasan_data,
 	},
+	{
+		.compatible = "xlnx,zynqmp-8.9a",
+		.data = &sdhci_arasan_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
@@ -583,6 +598,150 @@ static const struct clk_ops arasan_sampleclk_ops = {
 	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
 };
 
+/**
+ * sdhci_zynqmp_sdcardclk_set_phase - Set the SD Output Clock Tap Delays
+ *
+ * Set the SD Output Clock Tap Delays for Output path
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees		The clock phase shift between 0 - 359.
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
+
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
+		clk_data->clk_of_data;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 node_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 : NODE_SD_1;
+	u8 tap_delay, tap_max = 0;
+	int ret;
+
+	/*
+	 * This is applicable for SDHCI_SPEC_300 and above
+	 * ZynqMP does not set phase for <=25MHz clock.
+	 * If degrees is zero, no need to do anything.
+	 */
+	if (host->version < SDHCI_SPEC_300 ||
+	    host->timing == MMC_TIMING_LEGACY ||
+	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+		return 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		/* For 50MHz clock, 30 Taps are available */
+		tap_max = 30;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		/* For 100MHz clock, 15 Taps are available */
+		tap_max = 15;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		/* For 200MHz clock, 8 Taps are available */
+		tap_max = 8;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	ret = eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+			      PM_TAPDELAY_OUTPUT, tap_delay, NULL);
+	if (ret)
+		pr_err("Error setting Output Tap Delay\n");
+
+	return ret;
+}
+
+static const struct clk_ops zynqmp_sdcardclk_ops = {
+	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
+	.set_phase = sdhci_zynqmp_sdcardclk_set_phase,
+};
+
+/**
+ * sdhci_zynqmp_sampleclk_set_phase - Set the SD Input Clock Tap Delays
+ *
+ * Set the SD Input Clock Tap Delays for Input path
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @degrees		The clock phase shift between 0 - 359.
+ * Return: 0 on success and error value on error
+ */
+static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
+
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
+		clk_data->clk_of_data;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 node_id = !strcmp(clk_name, "clk_in_sd0") ? NODE_SD_0 : NODE_SD_1;
+	u8 tap_delay, tap_max = 0;
+	int ret;
+
+	/*
+	 * This is applicable for SDHCI_SPEC_300 and above
+	 * ZynqMP does not set phase for <=25MHz clock.
+	 * If degrees is zero, no need to do anything.
+	 */
+	if (host->version < SDHCI_SPEC_300 ||
+	    host->timing == MMC_TIMING_LEGACY ||
+	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+		return 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		/* For 50MHz clock, 120 Taps are available */
+		tap_max = 120;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		/* For 100MHz clock, 60 Taps are available */
+		tap_max = 60;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+		/* For 200MHz clock, 30 Taps are available */
+		tap_max = 30;
+	default:
+		break;
+	}
+
+	tap_delay = (degrees * tap_max) / 360;
+
+	/* Set the Clock Phase */
+	ret = eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+			      PM_TAPDELAY_INPUT, tap_delay, NULL);
+	if (ret)
+		pr_err("Error setting Input Tap Delay\n");
+
+	return ret;
+}
+
+static const struct clk_ops zynqmp_sampleclk_ops = {
+	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
+	.set_phase = sdhci_zynqmp_sampleclk_set_phase,
+};
+
 /**
  * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
  *
@@ -708,6 +867,10 @@ static void arasan_dt_read_clk_phase(struct device *dev,
 static void arasan_dt_parse_clk_phases(struct device *dev,
 				       struct sdhci_arasan_clk_data *clk_data)
 {
+	int *iclk_phase, *oclk_phase;
+	u32 mio_bank = 0;
+	int i;
+
 	/*
 	 * This has been kept as a pointer and is assigned a function here.
 	 * So that different controller variants can assign their own handling
@@ -715,6 +878,22 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 	 */
 	clk_data->set_clk_delays = sdhci_arasan_set_clk_delays;
 
+	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a")) {
+		iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_ICLK_PHASE;
+		oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_OCLK_PHASE;
+
+		of_property_read_u32(dev->of_node, "xlnx,mio-bank", &mio_bank);
+		if (mio_bank == 2) {
+			oclk_phase[MMC_TIMING_UHS_SDR104] = 90;
+			oclk_phase[MMC_TIMING_MMC_HS200] = 90;
+		}
+
+		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
+			clk_data->clk_phase_in[i] = iclk_phase[i];
+			clk_data->clk_phase_out[i] = oclk_phase[i];
+		}
+	}
+
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
 				 "arasan-clk-phase-legacy");
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
@@ -773,7 +952,10 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.parent_names = &parent_clk_name;
 	sdcardclk_init.num_parents = 1;
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
-	sdcardclk_init.ops = &arasan_sdcardclk_ops;
+	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
+		sdcardclk_init.ops = &zynqmp_sdcardclk_ops;
+	else
+		sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
 	clk_data->sdcardclk_hw.init = &sdcardclk_init;
 	clk_data->sdcardclk =
@@ -822,7 +1004,10 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 	sampleclk_init.parent_names = &parent_clk_name;
 	sampleclk_init.num_parents = 1;
 	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
-	sampleclk_init.ops = &arasan_sampleclk_ops;
+	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
+		sampleclk_init.ops = &zynqmp_sampleclk_ops;
+	else
+		sampleclk_init.ops = &arasan_sampleclk_ops;
 
 	clk_data->sampleclk_hw.init = &sampleclk_init;
 	clk_data->sampleclk =
@@ -1031,6 +1216,23 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_disable_all;
 
+	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
+		struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data;
+		const struct zynqmp_eemi_ops *eemi_ops;
+
+		zynqmp_clk_data = devm_kzalloc(&pdev->dev,
+					       sizeof(*zynqmp_clk_data),
+					       GFP_KERNEL);
+		eemi_ops = zynqmp_pm_get_eemi_ops();
+		if (IS_ERR(eemi_ops)) {
+			ret = PTR_ERR(eemi_ops);
+			goto unreg_clk;
+		}
+
+		zynqmp_clk_data->eemi_ops = eemi_ops;
+		sdhci_arasan->clk_data.clk_of_data = zynqmp_clk_data;
+	}
+
 	arasan_dt_parse_clk_phases(&pdev->dev, &sdhci_arasan->clk_data);
 
 	ret = mmc_of_parse(host->mmc);
-- 
2.17.1

