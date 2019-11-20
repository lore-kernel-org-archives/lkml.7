Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3304121850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N5xVdlBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKTGsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:48:15 -0500
Received: from mail-eopbgr700046.outbound.protection.outlook.com ([40.107.70.46]:19073
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfKTGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo+l686V/Mjc013BpMxGFz+A6rZ4FdFm9MLXGozAPAQegpsUdwQ7Szscu40UjfORPiJXgfLzChTuGUjVyqx/6x2P9IbTg0xIK3BfIP9JoKpRbizLFWoBM9idICDdufw9iZgWgjSKPlZLXcjrxhHuL6iL2eyEj+ybB2efAh16wEZq7fwxEdvwfS9lVU9I22c3cI+BcF2IILA1Wqm/tIVgFekSqLp653vSXAKpIq/RvX6kIRcndq5DcTLambsDu5nnnprNq6nB7AhzkFV788mcPljKlMJkXFDazrO7Uo+1giEwfqeb1Y7WYPQeFWQaHYeg9jP/YE1lbFQzFW66yG/ezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7qbsUFt6gIDpj2dYmDYOFz7It+gjHYfXKxGp9daL6Q=;
 b=Dh90V5rrQJJ0/ijR4xl+BLRmvf4gnNtluJ8J7X8zMrJkh3puzbSHz26atBDm8YUIs8UjvoC1vdDPBiMOrq2/Wu14AoIS0FAXoig5NYSrqaLE8ZNgkADBBjYhX3RXIsW4cA1BsF+1q0iQEB7H2PQwoxB7OmC2ah8VapANh3HjcsO6doi5ap8APGyiGHWO5FKrLDIbwVjxFluQvhMgUY2U7ePxyTJ5tP30ZU5BJln5kfFFsc1KK9tXkIvJ4dGey+/MLDVHzJ7C7hoOJa4xp8S/VovV0pdaj8RPoZZATF2pAd1d4X61jHl8+MoJwbfZJax8ztsWgtAzq+HlthJ/CsgBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7qbsUFt6gIDpj2dYmDYOFz7It+gjHYfXKxGp9daL6Q=;
 b=N5xVdlBjVLbDyab9jQwuzBpaEhXX8CgA57V4nH1S7qy9O1Lsg/5yvkhtNLpbCMWgRyYkNtiXkAvEJ3PGWlYXb8Qrzjsnvf0kSAdZCPL6Q8y8cvWhiOU9CIW//DbXA7l/gnfV9RQbEMkwquVF9OC8kmQpZqUy/HQBoMB1WLd42Y8=
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by DM6PR02MB4188.namprd02.prod.outlook.com (2603:10b6:5:97::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Wed, 20 Nov
 2019 06:47:48 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.30 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmF-00061A-NY; Tue, 19 Nov 2019 22:47:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-Jg; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6lb9Q001803;
        Tue, 19 Nov 2019 22:47:37 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm4-000492-LU; Tue, 19 Nov 2019 22:47:37 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id DF133121389; Wed, 20 Nov 2019 12:17:35 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 3/8] mmc: sdhci-of-arasan: Add sampling clock for a phy to use
Date:   Wed, 20 Nov 2019 12:17:24 +0530
Message-Id: <1574232449-13570-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(16586007)(316002)(2906002)(6666004)(42186006)(356004)(70586007)(44832011)(36756003)(186003)(48376002)(106002)(36386004)(26005)(76176011)(6266002)(4326008)(336012)(50466002)(486006)(107886003)(51416003)(305945005)(70206006)(476003)(50226002)(8936002)(14444005)(126002)(2616005)(81166006)(81156014)(478600001)(5660300002)(47776003)(8676002)(426003)(103686004)(446003)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4188;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06333818-2ff8-4a80-d6ab-08d76d858e98
X-MS-TrafficTypeDiagnostic: DM6PR02MB4188:
X-Microsoft-Antispam-PRVS: <DM6PR02MB41882B0B372A07C3025DAD99C14F0@DM6PR02MB4188.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF4Sc0SYNcTwNoVVds82uES3aAVhmAzU4AuF6kDIh5dqlZ3MBzHCay7xnsg7tOoPbX/ptU8ff/RTiViGMEUj1fmtb19r2BMR0FKhe/Oq3HbTR/2mWnxdLrkXIrvteeG8xr3tgVPBb7mxDxva7Rz2Q1CvfEdfjwny5A1AH9Cx8PN5GV47WOnyRvHJT1bMBGKu//6uk5Cg6T1oLmSAXZ4UDmNeZIEBHYwl7WxvI9QN8mC8+1SzOgHglFjU2ZRGiN4zT0xWEL70N3W8AVvRpwNTHw4cXCMs8u/WkAmqzJUe2P6tNi2ala13CDaPINv93rKWDb7cSGNPVEyLyXbTjT2K0xkne/QPd4W21lW/8lQqHe7n66pgmuv+WTy0UFNQWty2C/OaX5wOpekgTBQjNLi7KKllxHCk02Sx1j40H/reQ/kP4m/+LMhVX1k8jCsQMcph
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06333818-2ff8-4a80-d6ab-08d76d858e98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some operations like setting the clock delays may need to have
two clocks, one for output path and one for input path. Adding input
path clock for some phys to use.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 151 +++++++++++++++++++++++++----
 1 file changed, 134 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 701b6cc0f9a3..b75ba780f902 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -75,10 +75,14 @@ struct sdhci_arasan_soc_ctl_map {
  * struct sdhci_arasan_clk_data
  * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
  * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
+ * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
+ * @sampleclk:		Pointer to normal 'struct clock' for sampleclk_hw.
  */
 struct sdhci_arasan_clk_data {
 	struct clk_hw	sdcardclk_hw;
 	struct clk      *sdcardclk;
+	struct clk_hw	sampleclk_hw;
+	struct clk      *sampleclk;
 };
 
 /**
@@ -541,6 +545,33 @@ static const struct clk_ops arasan_sdcardclk_ops = {
 	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
 };
 
+/**
+ * sdhci_arasan_sampleclk_recalc_rate - Return the sampling clock rate
+ *
+ * Return the current actual rate of the sampling clock.  This can be used
+ * to communicate with out PHY.
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @parent_rate		The parent rate (should be rate of clk_xin).
+ * Returns the sample clock rate.
+ */
+static unsigned long sdhci_arasan_sampleclk_recalc_rate(struct clk_hw *hw,
+						      unsigned long parent_rate)
+
+{
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
+	struct sdhci_host *host = sdhci_arasan->host;
+
+	return host->mmc->actual_clock;
+}
+
+static const struct clk_ops arasan_sampleclk_ops = {
+	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
+};
+
 /**
  * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
  *
@@ -620,28 +651,21 @@ static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 }
 
 /**
- * sdhci_arasan_register_sdclk - Register the sdclk for a PHY to use
+ * sdhci_arasan_register_sdcardclk - Register the sdcardclk for a PHY to use
  *
  * Some PHY devices need to know what the actual card clock is.  In order for
  * them to find out, we'll provide a clock through the common clock framework
  * for them to query.
  *
- * Note: without seriously re-architecting SDHCI's clock code and testing on
- * all platforms, there's no way to create a totally beautiful clock here
- * with all clock ops implemented.  Instead, we'll just create a clock that can
- * be queried and set the CLK_GET_RATE_NOCACHE attribute to tell common clock
- * framework that we're doing things behind its back.  This should be sufficient
- * to create nice clean device tree bindings and later (if needed) we can try
- * re-architecting SDHCI if we see some benefit to it.
- *
  * @sdhci_arasan:	Our private data structure.
  * @clk_xin:		Pointer to the functional clock
  * @dev:		Pointer to our struct device.
  * Returns 0 on success and error value on error
  */
-static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
-				       struct clk *clk_xin,
-				       struct device *dev)
+static int
+sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
+				struct clk *clk_xin,
+				struct device *dev)
 {
 	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
 	struct device_node *np = dev->of_node;
@@ -649,10 +673,6 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	const char *parent_clk_name;
 	int ret;
 
-	/* Providing a clock to the PHY is optional; no error if missing */
-	if (!of_find_property(np, "#clock-cells", NULL))
-		return 0;
-
 	ret = of_property_read_string_index(np, "clock-output-names", 0,
 					    &sdcardclk_init.name);
 	if (ret) {
@@ -674,7 +694,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
 				  clk_data->sdcardclk);
 	if (ret)
-		dev_err(dev, "Failed to add clock provider\n");
+		dev_err(dev, "Failed to add sdcard clock provider\n");
+
+	return ret;
+}
+
+/**
+ * sdhci_arasan_register_sampleclk - Register the sampleclk for a PHY to use
+ *
+ * Some PHY devices need to know what the actual card clock is.  In order for
+ * them to find out, we'll provide a clock through the common clock framework
+ * for them to query.
+ *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ * Returns 0 on success and error value on error
+ */
+static int
+sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
+				struct clk *clk_xin,
+				struct device *dev)
+{
+	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
+	struct device_node *np = dev->of_node;
+	struct clk_init_data sampleclk_init;
+	const char *parent_clk_name;
+	int ret;
+
+	ret = of_property_read_string_index(np, "clock-output-names", 1,
+					    &sampleclk_init.name);
+	if (ret) {
+		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
+		return ret;
+	}
+
+	parent_clk_name = __clk_get_name(clk_xin);
+	sampleclk_init.parent_names = &parent_clk_name;
+	sampleclk_init.num_parents = 1;
+	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
+	sampleclk_init.ops = &arasan_sampleclk_ops;
+
+	clk_data->sampleclk_hw.init = &sampleclk_init;
+	clk_data->sampleclk =
+		devm_clk_register(dev, &clk_data->sampleclk_hw);
+	clk_data->sampleclk_hw.init = NULL;
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get,
+				  clk_data->sampleclk);
+	if (ret)
+		dev_err(dev, "Failed to add sample clock provider\n");
 
 	return ret;
 }
@@ -697,6 +766,54 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
+/**
+ * sdhci_arasan_register_sdclk - Register the sdcardclk for a PHY to use
+ *
+ * Some PHY devices need to know what the actual card clock is.  In order for
+ * them to find out, we'll provide a clock through the common clock framework
+ * for them to query.
+ *
+ * Note: without seriously re-architecting SDHCI's clock code and testing on
+ * all platforms, there's no way to create a totally beautiful clock here
+ * with all clock ops implemented.  Instead, we'll just create a clock that can
+ * be queried and set the CLK_GET_RATE_NOCACHE attribute to tell common clock
+ * framework that we're doing things behind its back.  This should be sufficient
+ * to create nice clean device tree bindings and later (if needed) we can try
+ * re-architecting SDHCI if we see some benefit to it.
+ *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ * Returns 0 on success and error value on error
+ */
+static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
+				       struct clk *clk_xin,
+				       struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	u32 num_clks = 0;
+	int ret;
+
+	/* Providing a clock to the PHY is optional; no error if missing */
+	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
+		return 0;
+
+	ret = sdhci_arasan_register_sdcardclk(sdhci_arasan, clk_xin, dev);
+	if (ret)
+		return ret;
+
+	if (num_clks) {
+		ret = sdhci_arasan_register_sampleclk(sdhci_arasan, clk_xin,
+						      dev);
+		if (ret) {
+			sdhci_arasan_unregister_sdclk(dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
 	struct sdhci_host *host = sdhci_arasan->host;
-- 
2.17.1

