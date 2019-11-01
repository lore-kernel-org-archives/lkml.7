Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E70C47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24B7208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MtHQvotd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfKAGGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:06:17 -0400
Received: from mail-eopbgr790055.outbound.protection.outlook.com ([40.107.79.55]:58400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728724AbfKAGGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMsC36rwyqb8T6F3jjkVcrWsNi8yJs5ZqUAepwSsLlcmFCI/2HMv3JMaBPJXJiXslVTZIJAfNW82ny8AkNPKgvQYLIdPZR0xdL6win7vjuUxWpi+CSncehahXHyBy9JNtNXAJMvbn2sk2fWDX8jBxtVgqhwihUEJT9yLxRbFw0WK5j9Urdh4rWPGlp2TnNlZ81bky5fz2hAVh6NQCZLOr8/NG51IaSl16PfRgpZhTmGhwR2F2IpKuA/jrccN+IX7+T6bm/YKbh++5phOu94OHHmolb4+//ORTr7Ai+IDKGciF1Ht1ZfLbtQZG6taqOeESNz+MWUnzabiiL9N2HTClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eQy9sbl57qj64wcfahgY/DCazAuE05WULs7Rq44dFw=;
 b=lKsQHN/0FeknM1ViTNxES83TGizpSSemaI53gE4lfL4vB5Z8E6nt4nB+xsFpRIvsSOJ90MsawsnNwPURVZ63mWUrVMtFfyxOBYY31Ee5sFcGqxDALyMgDEUOeasCpJqP5X4T7QFu22YtFUWNrdPruAc+Mg+07UuhZc75WvcIKfqmgl2ijm/QohCe/6G/iluQAumkTaUuz63tzSHvfet9SGZzVlcPtK9mkd9fixoE7nt8KwtNvDJV4ZZFW/xx7ZwmkhSED6xtj8e71axpAACDKmUMmY0QnCoAff2hCnMXiQTbsUxm6ow1QGL8Nibt2LKtbLPE8iy6jiXJThkpCrtxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eQy9sbl57qj64wcfahgY/DCazAuE05WULs7Rq44dFw=;
 b=MtHQvotdXCh+AD2Y1oH2Kpcv+YA3q7hEzSSGuuJOOKFrhboFqCVjqfhh9Nx1Kz3wMOgCjURzHuwn10RK0jLq7U3wFxH0HQgUNNeG+vNsEq6GjxzI9FVnuiJ71IKmsHXXFUJ41gNdBKjMKFKQ+jRhzOIhoz8zcPrYB15kEOk4XVk=
Received: from MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14)
 by SN4PR0201MB3407.namprd02.prod.outlook.com (2603:10b6:803:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Fri, 1 Nov
 2019 06:06:10 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR02CA0004.outlook.office365.com
 (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 06:06:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4X-0005mP-D3; Thu, 31 Oct 2019 23:06:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4S-0007dN-8O; Thu, 31 Oct 2019 23:06:04 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165wr5005663;
        Thu, 31 Oct 2019 23:05:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4L-0007Zt-Ly; Thu, 31 Oct 2019 23:05:58 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E131212123B; Fri,  1 Nov 2019 11:35:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 1/8] mmc: sdhci-of-arasan: Separate out clk related data to another structure
Date:   Fri,  1 Nov 2019 11:35:46 +0530
Message-Id: <1572588353-110682-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(8676002)(5660300002)(305945005)(2616005)(36386004)(70586007)(70206006)(50466002)(48376002)(51416003)(76176011)(44832011)(126002)(476003)(426003)(16586007)(26005)(336012)(11346002)(47776003)(103686004)(14444005)(186003)(446003)(316002)(81156014)(8936002)(6666004)(50226002)(356004)(81166006)(478600001)(107886003)(486006)(2906002)(6266002)(36756003)(42186006)(4326008)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3407;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6852aa3d-a119-499c-7439-08d75e919777
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3407:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3407D78058C7FF4198195F95C1620@SN4PR0201MB3407.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MC1vZ3ThYXCYYq0dmVNMjhCQhUqhOG5Sxja9BhhTz1Ub4CrkI4Zu6RFdK9UoFCZ96J3dPEjqtUrdGecbMz8xCw8IZRsgqx4hRorQSIHf8Chr6m1uANRmKTHZ1p/N28EJGr3BbtIkBE5WUKKTNZG3BOMKO/znCCUkjft92CPQTbFUmvDfaZ1BlBYRhOhicM2ka8uPVdyZdPJepjOjsJsDbp098nnKLVIWpz+PimlfOHv2+CFhuh2T2R+2qnhKhHGHnA6N99SqOmzBVwV704DMoX9bSm3NXFHmbMxySea2NA5R8NFSheqR9Mg5QDuL4d5OEDUUFCQ+nEHbDlnAUc3e8CQYvgAbYBm01/bUOUWqCM57j9hunQUj5jVqGk3pvGzfTnHfIP4IUox2EoEhzU74vYYwe0xM9lYsv96WMwXLuQZ5yazcPDCGcYp6X5QbaBj4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:09.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6852aa3d-a119-499c-7439-08d75e919777
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the code readability, use two different structs, one for
clock provider data and one for mmc platform data.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 31 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 7023cbec4017..701b6cc0f9a3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -71,14 +71,23 @@ struct sdhci_arasan_soc_ctl_map {
 	bool					hiword_update;
 };
 
+/**
+ * struct sdhci_arasan_clk_data
+ * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
+ * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
+ */
+struct sdhci_arasan_clk_data {
+	struct clk_hw	sdcardclk_hw;
+	struct clk      *sdcardclk;
+};
+
 /**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
  * @is_phy_on:		True if the PHY is on; false if not.
- * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
- * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
+ * @clk_data:		Struct for the Arasan Controller Clock Data.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
  */
@@ -89,8 +98,7 @@ struct sdhci_arasan_data {
 	bool		is_phy_on;
 
 	bool		has_cqe;
-	struct clk_hw	sdcardclk_hw;
-	struct clk      *sdcardclk;
+	struct sdhci_arasan_clk_data clk_data;
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
@@ -520,8 +528,10 @@ static unsigned long sdhci_arasan_sdcardclk_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
 
 {
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
 	struct sdhci_arasan_data *sdhci_arasan =
-		container_of(hw, struct sdhci_arasan_data, sdcardclk_hw);
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 
 	return host->mmc->actual_clock;
@@ -633,6 +643,7 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 				       struct clk *clk_xin,
 				       struct device *dev)
 {
+	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
 	struct device_node *np = dev->of_node;
 	struct clk_init_data sdcardclk_init;
 	const char *parent_clk_name;
@@ -655,13 +666,13 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
 	sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
-	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
-	sdhci_arasan->sdcardclk =
-		devm_clk_register(dev, &sdhci_arasan->sdcardclk_hw);
-	sdhci_arasan->sdcardclk_hw.init = NULL;
+	clk_data->sdcardclk_hw.init = &sdcardclk_init;
+	clk_data->sdcardclk =
+		devm_clk_register(dev, &clk_data->sdcardclk_hw);
+	clk_data->sdcardclk_hw.init = NULL;
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
-				  sdhci_arasan->sdcardclk);
+				  clk_data->sdcardclk);
 	if (ret)
 		dev_err(dev, "Failed to add clock provider\n");
 
-- 
2.17.1

