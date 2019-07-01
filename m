Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A853C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87A1208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xGSJD16T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGAFhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:37:55 -0400
Received: from mail-eopbgr780045.outbound.protection.outlook.com ([40.107.78.45]:9760
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbfGAFhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8KIoRpl+4FW2unzwthd45gQGD7fobv7LrzhR+W+2mY=;
 b=xGSJD16Tvmts+TdHal0SgIU8D9+iuOgeBi6V6+v08P6bA+oDfWSjKUzBjTbgpecpon9ITfeBwP8EUwjOVjPBSWxLdr3UAyRGGm2QJ7kD/ZET1UGVZVMFZMIdFjKe5wL/g2AdQ+8ID3keXJcEphTvggKoFLz+8nKtir81GBT7kz0=
Received: from SN4PR0201CA0032.namprd02.prod.outlook.com
 (2603:10b6:803:2e::18) by BY5PR02MB6324.namprd02.prod.outlook.com
 (2603:10b6:a03:1f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Mon, 1 Jul
 2019 05:37:53 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0032.outlook.office365.com
 (2603:10b6:803:2e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Mon, 1 Jul 2019 05:37:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:37:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53301 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhp0h-0006Z9-KF; Sun, 30 Jun 2019 22:37:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhp0c-0006Vc-Gw; Sun, 30 Jun 2019 22:37:46 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615bZW5024757;
        Sun, 30 Jun 2019 22:37:35 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhp0R-0006UM-47; Sun, 30 Jun 2019 22:37:35 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4CAFA121726; Mon,  1 Jul 2019 11:07:34 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     robh+dt@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        manish.narani@xilinx.com, sudeep.holla@arm.com,
        rrichter@cavium.com, gregory.clement@bootlin.com,
        amit.kucheria@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: zynqmp: Add ZynqMP SDHCI compatible string
Date:   Mon,  1 Jul 2019 11:07:32 +0530
Message-Id: <1561959452-22915-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(199004)(189003)(16586007)(42186006)(106002)(966005)(478600001)(316002)(44832011)(126002)(476003)(4326008)(486006)(70586007)(70206006)(36386004)(63266004)(50466002)(50226002)(72206003)(5660300002)(47776003)(103686004)(36756003)(305945005)(51416003)(81156014)(81166006)(14444005)(8676002)(6266002)(336012)(426003)(356004)(2616005)(186003)(26005)(6306002)(8936002)(2906002)(52956003)(48376002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae3bc95-876f-43af-cec3-08d6fde642c3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY5PR02MB6324;
X-MS-TrafficTypeDiagnostic: BY5PR02MB6324:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BY5PR02MB63247EB84535C3B55C75E9D6C1F90@BY5PR02MB6324.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ScAECnxM3Ok2YwLv5rr4uodfUPwLQdw5yT177HRRrmQqmmziArSwp8M1512Mpmy7cLTCYYxStyta8SGCjfYAEK4gxcRoNoDkoxOtmn6PQ/3fMA8ZpdhGRE1IXZU/QZ9NQByA1/bD9HhbC4Y6L6OhmKTWOjnl2aNVngjyCz6G5vj+3Y6v72hESXWTBP2BRHqZjZfavQUrKRGOX2hjgi/+lRvqf1lBOrhdHAgQBbvchfqTDAVges9h3CqcfhUi9joD6YIsog/zSPO5ZtZNOR2cGASJzEKFceAr2K8LFddohg5IKvTVYrVGD/PObI2Srth0S/8Rzgw2ruxagMW6ICzYYw4b1TRz1AJ/ZDjS7PDsQKJwPbpj1aM8Gn1uUnOHBa/2xQKzDxJGSQoIappLMmmz8rki2sJ5HtuoKYrbFDlXuvQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:37:52.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae3bc95-876f-43af-cec3-08d6fde642c3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new compatible string for ZynqMP SD Host Controller for its use
in the Arasan SDHCI driver for some of the ZynqMP specific operations.
Add required properties for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
This patch depends on the below series of patches:
https://lkml.org/lkml/2019/7/1/25

Changes in v2:
	- Added clock-names for SD card clocks for getting clocks in the driver
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi |  4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
index 306ad21..24c04a1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
@@ -177,11 +177,11 @@
 };
 
 &sdhci0 {
-	clocks = <&clk200 &clk200>;
+	clocks = <&clk200>, <&clk200>, <&sdhci0 0>, <&sdhci0 1>;
 };
 
 &sdhci1 {
-	clocks = <&clk200 &clk200>;
+	clocks = <&clk200>, <&clk200>, <&sdhci1 0>, <&sdhci1 1>;
 };
 
 &spi0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9aa6734..4c21346 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -493,21 +493,27 @@
 		};
 
 		sdhci0: mmc@ff160000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
-			clock-names = "clk_xin", "clk_ahb";
+			clock-names = "clk_xin", "clk_ahb",
+				      "clk_sdcard", "clk_sample";
+			#clock-cells = <1>;
+			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 		};
 
 		sdhci1: mmc@ff170000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
-			clock-names = "clk_xin", "clk_ahb";
+			clock-names = "clk_xin", "clk_ahb",
+				      "clk_sdcard", "clk_sample";
+			#clock-cells = <1>;
+			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.1.1

