Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC03C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DB1206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mfqXkWFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKTGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:47:58 -0500
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:41054
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbfKTGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+AHyAF+ATlFqtREe7BE4TZgdt/9ZydD6AfZUgE75OIIDlblI60VWrMBmTpAkaL5o/KpRuGjOQ2IrI7a/neqA6wpusflAewW449twQXLj7Wm9bcwt+P4C8Eqdc67kNrIAnLefwRB8HQDI5B7nvl6+VjsL6hJ0bOvpr2cL/yhnyR3c+lSX+m7l3yxuN608vtbjYus64LGkT1wzAR8zZ1hfdpGV6x+DVaIbFCU26fOBQUo7Z79t7S9K1OVCJJLWHrK8OvvbTYOaIHKFb+1vWXqAT2erVNWqbCkWNCUItWESkG7+ulLrsgeKl+dnSativh84U6yHa8Nn61Hi19j6yuK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyNuoP16Z/YOfgx2/n//zWRR2NSkAP2xIdiXXSSl73g=;
 b=UK8Her28SLPqdHukYAOOc7T/G1GefFuclmlTiaG3Gaff8552Jaq+Jpt0O8DbSeU0lsl+ch7t3bsxklAEto1cV3wg+GVoZqXw/iBpTOjzpF3zYI3Qmlba49DoMzj7Koa5EheYjrH2mvjaqDUZ50hyFBFGSE6c95ZOCwIXybBMBGZKlejZHFG2LaJA++CGyKy+HEOmRUGQVyJfWRX4g3JC4OFZ7z0287LXJVeMF0m6yWV2Zwni0ig5DzQrNDBIyy8oNStFqUkdjOW1NrWv68Ag92rmdvU83XR6ElW/SmkxyBbpU55iY7NtxO3WetoVtoiqEiXGn36Tgv2rLWX+Psdn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyNuoP16Z/YOfgx2/n//zWRR2NSkAP2xIdiXXSSl73g=;
 b=mfqXkWFUWrYjPwGxHvSXM3J1xJALNJWd63dug2Gy0Zqwo1/BzFpPphke2JIu9AXh8AmbsXP59wPTpSz63bd294NpkF8RAFmjAjg/CPgyLuInpS3HxNmI7FQKULmCAmYsfBOWFalWDmGUrc4PPhvNdsy4J/ycfmD8pTA4IIg4+18=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by SN1PR02MB3728.namprd02.prod.outlook.com (2603:10b6:802:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 20 Nov
 2019 06:47:49 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmF-000617-Gl; Tue, 19 Nov 2019 22:47:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-Cz; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6lcI3027301;
        Tue, 19 Nov 2019 22:47:38 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm5-00049H-Ms; Tue, 19 Nov 2019 22:47:38 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 07A871213B9; Wed, 20 Nov 2019 12:17:36 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 8/8] mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
Date:   Wed, 20 Nov 2019 12:17:29 +0530
Message-Id: <1574232449-13570-9-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(4326008)(305945005)(47776003)(186003)(2906002)(16586007)(50466002)(356004)(6666004)(103686004)(36756003)(107886003)(26005)(76176011)(106002)(36386004)(51416003)(478600001)(5660300002)(6266002)(2616005)(70586007)(44832011)(316002)(8936002)(48376002)(126002)(8676002)(426003)(336012)(81166006)(81156014)(476003)(446003)(14444005)(50226002)(42186006)(70206006)(11346002)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3728;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 579d7846-83f9-408b-7736-08d76d858e6e
X-MS-TrafficTypeDiagnostic: SN1PR02MB3728:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3728B389CE14642CFDD17F7CC14F0@SN1PR02MB3728.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otfsrFK/BabQFj8Ne5TqOB0hedgWzJGmSirxquQPqMLg78gQ5bG4yxzeSiTKeVrT5mndPgCoUsz/RmaB5g7jGj23sXqZ3OJZ8DuigD8Ea/ropW7mB+pKlRXOIfElaCfYkVD32Yu/WLrvIhlDEwqgQrQ4YpVT10QjozpoqDXRkprpJ65JXAvY2IXfqb9j7oq4ans+7zWeUylrzLtZUbyFzVujBOoTtZFCNorAS6jHHyA4z9xEkUrQNndLj1Ty8fkmjt29/le+aXnLrQSTs+UqfahOvpuiPiLSqAkY4lZ6CElmgFtNe0Xp8FcAoD/Xkjr8U/rSRmaTN/ot3fIMA0I77YLvj7/T58Onpqz88gykSvgyFwExUVldpAyGRYdZ6otmfHkq/MRt/WOIqWhHh2u5UWabMA7a9G102nJhvXT0mxh5DfOJZA2aLvBuVkewKCMZ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.0794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579d7846-83f9-408b-7736-08d76d858e6e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3728
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
index 9452ae01f6fa..228dbeef74a8 100644
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
@@ -709,6 +868,10 @@ static void arasan_dt_read_clk_phase(struct device *dev,
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
@@ -716,6 +879,22 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
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
 				 "clk-phase-legacy");
 	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
@@ -774,7 +953,10 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
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
@@ -823,7 +1005,10 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
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
@@ -1032,6 +1217,23 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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

