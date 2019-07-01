Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3DC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36E8208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FvKJmWIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGAFaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:16 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:63216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfGAFaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=WllLa9hrLN+NLO3RT4Z/odiYLQw3FejHBRzbOh011zJTDEcFx7b35tKfSDjHOWMpIwmxsDnq6gXps+V/5neY6DRxu2d1969aBbfuAbheIhdOVH5lhlKn9jgxCn8QTREWyMetOSFRKlAArnLjQ2cTnRKdrl83zFNivSWlDC7wRr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHHG1YEKgeYnIJRIm2Uh0GedaxcByLgz2b1LqOlg8XM=;
 b=GFQIOKXs4Jx/lfJAEq36QQfty3wlGU5ZH6YNehsa1/Dhaf48PW+rpVR4uEZ4A/YiHKQaqIls+Yq506iKxP9Lxz5d+VxQpM+4s2FjZ2woINY87tcqFyEZPN5g9dp2f6LG9Pr9or9ModwdM3SfAWTjM6nqQF/OepAj9iUgoE9lwZI=
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHHG1YEKgeYnIJRIm2Uh0GedaxcByLgz2b1LqOlg8XM=;
 b=FvKJmWIU0vRf68eiGW/JCukY5p0Ry4VZR4n61QTGTsgDIWHIyN2BWPmE/HIjVBEz2qV2qO62widErleqkq2gLx5KHXvqMJonjsMOJbdx8HbGFL3+32Y+n6MISZTlRKkdIPypbZ/C0EnKvhNMtx+IQvqmya/OyL98rhYS8IKXrrU=
Received: from DM6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:5:1c::49) by
 SN4PR0201MB3407.namprd02.prod.outlook.com (2603:10b6:803:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 1 Jul
 2019 05:30:07 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0036.outlook.office365.com
 (2603:10b6:5:1c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35962 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotC-0006To-4t; Sun, 30 Jun 2019 22:30:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot7-0003EO-15; Sun, 30 Jun 2019 22:30:01 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615TtWn023626;
        Sun, 30 Jun 2019 22:29:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot1-0003CQ-1t; Sun, 30 Jun 2019 22:29:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 398CD121735; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 04/11] mmc: sdhci-of-arasan: Separate out clk related data to another structure
Date:   Mon,  1 Jul 2019 10:59:44 +0530
Message-Id: <1561958991-21935-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(189003)(199004)(63266004)(2906002)(4326008)(70586007)(70206006)(72206003)(26005)(5660300002)(76176011)(103686004)(305945005)(6266002)(51416003)(81156014)(8676002)(81166006)(8936002)(36386004)(7416002)(186003)(50226002)(6666004)(356004)(50466002)(52956003)(426003)(336012)(47776003)(446003)(48376002)(44832011)(486006)(476003)(126002)(478600001)(2616005)(11346002)(16586007)(36756003)(42186006)(316002)(106002)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3407;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd5b626-a667-4d5f-68a9-08d6fde52d8b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN4PR0201MB3407;
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3407:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3407D2A831C23D9D4788AA0FC1F90@SN4PR0201MB3407.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jy/kJuDbKPbfdGajJkpOGx72bZwsS7xqF15uLBaNNhpwerQxqujQTZmX6vOjGFlfiKy0ftWn+gRCc/xDQkzHEbv4fevVBaGf2pru6sVdis3Irp3eNBgTDtd7yQIYMkCEjzyL6iXO08Xx2TTAT72gvuSbIvdTLpp49xPdax2W6wVCKJuAhhmbbomYkqpwfgkVzJFlHfvVcDNwFZW7h8Mv6+FUEvo5Y6KafICz6mPXfZ+OzoIdPIMtOujWr3r9skzVMQ1t+OnUCK1+QrEl+7TtmZWZUJWGYOgrmQth8JApAcKkk9Q+n1+vzm0jBpXwgPUBENHp00ttGawLhfhkrzAIKQyHfEHwMO5uwMBtT1SBCGbPAXr9vWtFnMRpjNdk8PxQAMVH1n9MNYSwd8FenNIql4gSbE4a78bPOLSPuZTDJ4c=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:06.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd5b626-a667-4d5f-68a9-08d6fde52d8b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
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
 drivers/mmc/host/sdhci-of-arasan.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d60a2e8..c7586f5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -72,13 +72,22 @@ struct sdhci_arasan_soc_ctl_map {
 };
 
 /**
+ * struct sdhci_arasan_clk_data
+ * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
+ * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
+ */
+struct sdhci_arasan_clk_data {
+	struct clk_hw	sdcardclk_hw;
+	struct clk      *sdcardclk;
+};
+
+/**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
+ * @clk_data:		Struct for the Arasan Controller Clock Data.
  * @is_phy_on:		True if the PHY is on; false if not.
- * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
- * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
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
@@ -505,8 +513,10 @@ static unsigned long sdhci_arasan_sdcardclk_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
 
 {
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
 	struct sdhci_arasan_data *sdhci_arasan =
-		container_of(hw, struct sdhci_arasan_data, sdcardclk_hw);
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 
 	return host->mmc->actual_clock;
@@ -618,6 +628,7 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 				       struct clk *clk_xin,
 				       struct device *dev)
 {
+	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
 	struct device_node *np = dev->of_node;
 	struct clk_init_data sdcardclk_init;
 	const char *parent_clk_name;
@@ -640,25 +651,25 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
 	sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
-	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
-	ret = devm_clk_hw_register(dev, &sdhci_arasan->sdcardclk_hw);
+	clk_data->sdcardclk_hw.init = &sdcardclk_init;
+	ret = devm_clk_hw_register(dev, &clk_data->sdcardclk_hw);
 	if (ret) {
 		dev_err(dev, "Failed to register SD clk_hw\n");
 		return ret;
 	}
-	sdhci_arasan->sdcardclk_hw.init = NULL;
+	clk_data->sdcardclk_hw.init = NULL;
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get,
-				     &sdhci_arasan->sdcardclk_hw);
+				     &clk_data->sdcardclk_hw);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider\n");
 		return ret;
 	}
 
-	sdhci_arasan->sdcardclk = devm_clk_get(dev, "clk_sdcard");
-	if (IS_ERR(sdhci_arasan->sdcardclk)) {
+	clk_data->sdcardclk = devm_clk_get(dev, "clk_sdcard");
+	if (IS_ERR(clk_data->sdcardclk)) {
 		dev_err(dev, "sdcardclk clock not found.\n");
-		ret = PTR_ERR(sdhci_arasan->sdcardclk);
+		ret = PTR_ERR(clk_data->sdcardclk);
 	}
 
 	return ret;
-- 
2.1.1

