Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5752089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sS3tX6tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfFKKHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:07:38 -0400
Received: from mail-eopbgr780050.outbound.protection.outlook.com ([40.107.78.50]:4096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404593AbfFKKHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZawdMzp8XdCQtc2qbhzmbLCvc/4EHpvHDS6IQHZqEVA=;
 b=sS3tX6tQyDlC9T751u9XXnlwO/t/77D/IMUTcPeYn50wmT/zpc83FCLx6PU58AIHqFM4LLDC+VB/5cNgckumRIznEH53EIUS2DK5WpeOmDX/XEFQXkpcewlQ/BzY9UletjWU4Feu5nLt/Ob7rcWaf/oYpQUJyjuLe8/d3qhV6lA=
Received: from MWHPR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:301:74::31) by BL0PR02MB4932.namprd02.prod.outlook.com
 (2603:10b6:208:53::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Tue, 11 Jun
 2019 10:07:32 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0018.outlook.office365.com
 (2603:10b6:301:74::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Tue, 11 Jun 2019 10:07:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Tue, 11 Jun 2019 10:07:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadgg-0005Qf-Uc; Tue, 11 Jun 2019 03:07:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadgb-0000TD-Qt; Tue, 11 Jun 2019 03:07:25 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hadgU-0000RI-2r; Tue, 11 Jun 2019 03:07:18 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 421C6121745; Tue, 11 Jun 2019 15:37:17 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com, chanho.min@lge.com, rrichter@cavium.com,
        leoyang.li@nxp.com, amit.kucheria@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: zynqmp: Add ZynqMP SDHCI compatible string
Date:   Tue, 11 Jun 2019 15:37:15 +0530
Message-Id: <1560247635-29281-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(26005)(36386004)(51416003)(50466002)(47776003)(186003)(2906002)(72206003)(48376002)(478600001)(4326008)(966005)(14444005)(5660300002)(356004)(103686004)(336012)(8676002)(2616005)(50226002)(6306002)(44832011)(8936002)(63266004)(70206006)(70586007)(426003)(486006)(476003)(81156014)(126002)(81166006)(305945005)(6266002)(52956003)(36756003)(106002)(42186006)(16586007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4932;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95326752-72f8-442d-f54c-08d6ee549e1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL0PR02MB4932;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4932:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4932F9B04CC4457FC53CD5C9C1ED0@BL0PR02MB4932.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: i2NGJO1/uEDDchyyoqO8/trSl4RtuZ8ikQ0V3PxG3liqRG6EG/WKnHLM5nEqeNM2ihoYogPI+BiWnMrtjvPzG0QlwXTBct7hEeXPPBh/Vr3+CGrvyH7hWFmAtPrWXg1D+8yLU5sFomnaR9P2QiFCVBps8kTycl0U2W0sR83YDNZLxtVSn+/7OAlQyncVPZltg/SVbPpv7CSqp2cwf1vTK1vi4rgBfD9guXlOBMH9jf5EFhnSbQZ65mW3Q4Nxu/ohZw2RuIBGJfPpdIxrZBpTHNyPKVYW8Mkb0DpJpD1j0hqEMVmGdQcJJ5sfR3sDtxVcx1Jy7ssQ8oroqtlQkLsm27y8cC4Zt/NzLAMtxGLk5tLHuF8TtaxAioE47anlHyKAFNV+ex0VgQIyfKvnrU1wYuy3ofett5/qoXCcp93oJY8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 10:07:31.5229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95326752-72f8-442d-f54c-08d6ee549e1d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4932
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
https://lkml.org/lkml/2019/6/11/286
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9aa6734..6da5b82 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -493,21 +493,25 @@
 		};
 
 		sdhci0: mmc@ff160000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			clock-output-names = "clk_sd0";
+			#clock-cells = <0>;
 		};
 
 		sdhci1: mmc@ff170000 {
-			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			clock-output-names = "clk_sd1";
+			#clock-cells = <0>;
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.1.1

