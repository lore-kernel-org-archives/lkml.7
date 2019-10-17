Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F15C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB472089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lQlA+FCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437525AbfJQH3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:29:11 -0400
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:63717
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbfJQH3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4FL/ZFXQed/a+qK7KQHxP/A9G8nMelxSwSGHvTvhGc7QLDnifwIo8ENdK17EZYoWb7u76nNuYPb4ItSnVTW/cpKR5onAxmFyP51mofUVJ+5zdqneDNg/1AHYyGQjIYRhUkeF6XGXbD8lK9WQZONgz70PSRpgMt5gdleOgnXpPvFCXQHu/Yb0q3jxmArLPun76VAiMq8kPBAK6armnKXwOVG0rvLsh388pEBDBwsjBKzSV1OYVI7Qtt+btRCPJL/GvxTYULrTWMJwfILppMiErkasuotrgL+8z3uiVuica+uwcpPGleiaPHqBEqypGfd0PZMCYlvwI51gtoiG8w1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMfAzsyqMPPGfucBwNh0qd5/alzzrUS1OAmJjylVj+Q=;
 b=GmvGQMz1cxqn/UqkA5qamCkX+RVa5YPoBioRakc5khP7fnfNVnux1pqBSDWkdakjw+LSvwxffk2DIOLqdar1/mNIFrWovnW06gTXdkifpRqTna+UngCe9DF+imbpo17EylZXUEOKg7LIMOHntzTzMLHlU7NXEpUwDzsZVshfR6LEg/7dtthw7Fqlb1i7DXdTsRckbho5Bq76C7l9T9Z3bqrobkNUSo9/nAivNxR3upCNMO0k/Xkb6eijBr153KCoI/w8qsq89peF6QMn/d9vDGBDJbPcN7EX7LMNoB+H+Xw/wPTuwGXeqdxXlubhMeC3kyZ7ai5kGM3P40SxR87vdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMfAzsyqMPPGfucBwNh0qd5/alzzrUS1OAmJjylVj+Q=;
 b=lQlA+FCvlxFv/DqVKisdMww7rsxOS1MoC3D5HgHvp9nMpRTswPkEsTg+SKVeaDgGvZFSXVgRW5jve5iy3kSZXDjpGrjai6ybkGzD6b1Jp2b+d8MPqT1BdtetVMatPRN2/swFYTjeN9K48VtOtnTNZwZGmuqBD9R0IHcfR7CijO8=
Received: from SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) by SN6PR02MB5278.namprd02.prod.outlook.com
 (2603:10b6:805:71::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Thu, 17 Oct
 2019 07:29:08 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0051.outlook.office365.com
 (2603:10b6:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 17 Oct 2019 07:29:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 17 Oct 2019 07:29:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iL0Db-0006ys-31; Thu, 17 Oct 2019 00:29:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iL0DV-0008Dr-Vg; Thu, 17 Oct 2019 00:29:02 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9H7SsOt025562;
        Thu, 17 Oct 2019 00:28:55 -0700
Received: from [172.23.64.104] (helo=xhdvnc123.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iL0DO-0008Ax-K4; Thu, 17 Oct 2019 00:28:54 -0700
Received: by xhdvnc123.xilinx.com (Postfix, from userid 16987)
        id CE98643A9A; Thu, 17 Oct 2019 12:58:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com, arnd@arndb.de,
        horms+renesas@verge.net.au, khilman@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: [PATCH v3] arm64: zynqmp: Add ZynqMP SDHCI compatible string
Date:   Thu, 17 Oct 2019 12:58:51 +0530
Message-Id: <1571297331-99924-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(42186006)(50466002)(70206006)(70586007)(50226002)(4326008)(81156014)(8676002)(6266002)(48376002)(81166006)(305945005)(8936002)(36756003)(356004)(107886003)(6306002)(478600001)(103686004)(106002)(966005)(26005)(486006)(2616005)(14444005)(44832011)(126002)(51416003)(2906002)(316002)(16586007)(336012)(47776003)(36386004)(5660300002)(426003)(476003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5278;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da123ac8-646e-4796-598d-08d752d3b240
X-MS-TrafficTypeDiagnostic: SN6PR02MB5278:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR02MB5278980D059C0CF217933780C16D0@SN6PR02MB5278.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHIVWo5zQYp/xyVxiaimnPtW/tQfQpftfDnYQUMO7q5TegNgFv34GDGYkEKT/AeGTiOL6Cvt7z5cli0H1/9R59f6QKycLmR3mTy5TeIFdVd9NhRD6Qd20+ib/1/J9B5QowckmhmLA+L2l3S/afTqvyC5Hq1mm1c0E3f9eivKyu8k1V/rLVHtND978SsB+mD7rIX+cvInijE7RfclNemxuWTcnlpraT2o/O3I8XXgG1EvGxZaInYGlBSv0li4AUbQUED9RjVXX1Nb1zka0PBZqw/ouexonBS0Lvj341W35pleNDingPszQjUWiVTIhShsYIgYt6c7tAc3p+eFy7BSAxKs4K78+KXnKvKYSHLeQhAgUjp5lXrdmtQKqRLAvikWdxNMqHHDcgUtZFRk76jlfnVpV9UAwAxuXYCrbnjTUiiH//Cho7ddBLXyL3HlEnS6PGvX2xrSEF1oP7ppbd+3nQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 07:29:07.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da123ac8-646e-4796-598d-08d752d3b240
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5278
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
https://lkml.org/lkml/2019/10/17/37

Changes in v2:
	- Added clock-names for SD card clocks for getting clocks in the driver

Changes in v3:
	- Reverted "Added clock-names for SD card clocks for getting clocks in the driver"
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9aa67340a4d8..c7b8c3c28aa7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -494,20 +494,26 @@
 
 		sdhci0: mmc@ff160000 {
 			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#clock-cells = <1>;
+			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 		};
 
 		sdhci1: mmc@ff170000 {
 			compatible = "arasan,sdhci-8.9a";
+			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
+			#clock-cells = <1>;
+			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.17.1

