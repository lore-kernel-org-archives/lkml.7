Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D2C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919B921D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nikYCR46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfKGHRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:17:53 -0500
Received: from mail-eopbgr800049.outbound.protection.outlook.com ([40.107.80.49]:3038
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbfKGHRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:17:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf9S88V1wwkUvkZrcYyQtKjjR4pclavSTEl8njO/uFC3x0QfUCgxvPzVe8nNpytQQoBWgbv0nWBqvXrjFJ2L1cy+lJZ2JU0c5xW5SpcqDbWJNfQ9J2FsS+grE6LoDYvT276v57a1QZXVDnxSbEKMChP7ZdV+Br2amUXU1uprGcFzadNTgkGLlUD/K1UH24QmMxq0LA1WhLmUkCxxFW6zAr+pMIQL6aC+bEkxRBMK8dFEn0ToyZz5gUjgH+B8V+/6lHlj1uVxhtQvCOoSQMeKJzao8V54K0s6kitJq1Shw1NkouMXlZWyS9GSHVjxntUwG3PULLleMtdbzRIRQ+X6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HBq+gr2xsK6vrWo1DTAQOBZUV6EI3uRQ6ViorGWSAs=;
 b=IY6QG/1ePNMhk05/xPwwdElJoUSlbLgQajPEFcQGKYFov9S+cTckP8VdSM2bTasl0jn6VCX+3fR/ljNlKsCDVbC5/5u4WeIvyHF1CJaZIy2wvW98+9M0n6Devg6W3f8RF9iJaJ9774Bn/LMYRffzmmasH8CqPmz23LS8L7zXTtQxJDIdOrtRHYw8vU0G3hyvzB/LjKqAEMJ9fvu2MBTpaD5Bb7WAAOGdsC5+25LA6uEv9MZSPg/ktDt++afTYvbzgv/qoURAIYZfobK9ydLeyTJBNiPC5Ec2igAe8/jzP/JIkH2hbDjGoLnOmVp+JEa+d7IsNb/9aStSuaN3pXWM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HBq+gr2xsK6vrWo1DTAQOBZUV6EI3uRQ6ViorGWSAs=;
 b=nikYCR46sDL19wk4lcSzJTr3DXq5I/bK0LUMqLjIMAV+T3RO5aEfaMd+ojC49ErJUwWAtu4VjXnXiXrsLMfGeRA5g8GgC80XNMQrCfc+D24O0NJ/dEX3ywACZR2Ybgqi7gu9ZYwf0NqKgd1gBWHd0tkJjFb9AAgh23LOwYAg8Go=
Received: from DM6PR02CA0057.namprd02.prod.outlook.com (2603:10b6:5:177::34)
 by BN6PR02MB2353.namprd02.prod.outlook.com (2603:10b6:404:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Thu, 7 Nov
 2019 07:17:49 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR02CA0057.outlook.office365.com
 (2603:10b6:5:177::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 07:17:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 07:17:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSc38-0006R9-AQ; Wed, 06 Nov 2019 23:17:46 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSc33-0003Vl-7E; Wed, 06 Nov 2019 23:17:41 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA77HZcL024405;
        Wed, 6 Nov 2019 23:17:35 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSc2x-0003VM-6X; Wed, 06 Nov 2019 23:17:35 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] dt-bindings: clock: Add bindings for versal clock driver
Date:   Wed,  6 Nov 2019 23:16:52 -0800
Message-Id: <1573111012-29095-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(47776003)(478600001)(50226002)(8676002)(305945005)(8936002)(81166006)(5660300002)(107886003)(81156014)(9786002)(70206006)(106002)(54906003)(26005)(426003)(186003)(2616005)(4326008)(476003)(36756003)(70586007)(44832011)(7696005)(126002)(486006)(51416003)(14444005)(2906002)(16586007)(50466002)(6666004)(316002)(356004)(336012)(48376002)(36386004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2353;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:3;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af5f01ba-78ae-46dd-0f20-08d763529722
X-MS-TrafficTypeDiagnostic: BN6PR02MB2353:
X-Microsoft-Antispam-PRVS: <BN6PR02MB235334F5FDA9D4A88353C3CCB7780@BN6PR02MB2353.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Rg9tomUrQllUs9qFXn6OTCzdIDC4Ko6/Lo/wCpk3fNTbuAvSJaCOpeE0B/D1kf7ez8fL/bnEwZNiEArS7AArmqeyKL1MraKjJmVWm5luZwXoLAv91FnaDVCIYEeIxOzYd8pbq+6SjSBV3MQcFpm1WnJuEfHKdF2OEXcxXb+CnIC4G35VxOvqjIXiAfUdBrvzRlw8nXztnGDvrjU8Z4EoWrBnQQIKqCTT+IwnG/+Lixjp6pwZ3p32A65+BV9M23bAA6+SEStURuzAqhhWIn+UANOinGRyvirppa5eV/BkO+5kXQrIvvuvcZ3ZdWJlDM1MYMKOn9oz0vjogVCjjZKnogmxXoA+r5O6TV8AH5zXxLnh08q1iihPwv3DRpsPucBgU8bFJgCvx5dbWz9KNf0dNcZDlLVO7r5J+4E6yEkbb9r0t/OxNDRAUDbBXhAH0n0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 07:17:46.8372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f01ba-78ae-46dd-0f20-08d763529722
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx Versal clock driver
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 .../devicetree/bindings/clock/xlnx,versal-clk.txt  |  48 ++++++++
 include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt
 create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h

diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt
new file mode 100644
index 0000000..398e751
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt
@@ -0,0 +1,48 @@
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Xilinx Versal
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Xilinx versal clock tree. It reads
+required input clock frequencies from the devicetree and acts as clock provider
+for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,versal-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for Xilinx Versal clock controller:
+
+The Xilinx Versal has one primary and two alternative reference clock inputs.
+These required clock inputs are:
+ - ref_clk
+ - alt_ref_clk
+ - pl_alt_ref_clk
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx-versal-clk.h.
+
+-------
+Example
+-------
+
+firmware {
+	versal_firmware: versal-firmware {
+		compatible = "xlnx,versal-firmware";
+		method = "smc";
+		versal_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,versal-clk";
+			clocks = <&ref_clk>, <&alt_ref_clk>, <&pl_alt_ref_clk>;
+			clock-names = "ref_clk", "alt_ref_clk", "pl_alt_ref_clk";
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/xlnx-versal-clk.h b/include/dt-bindings/clock/xlnx-versal-clk.h
new file mode 100644
index 0000000..264d634
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx-versal-clk.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2019 Xilinx Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_VERSAL_H
+#define _DT_BINDINGS_CLK_VERSAL_H
+
+#define PMC_PLL					1
+#define APU_PLL					2
+#define RPU_PLL					3
+#define CPM_PLL					4
+#define NOC_PLL					5
+#define PLL_MAX					6
+#define PMC_PRESRC				7
+#define PMC_POSTCLK				8
+#define PMC_PLL_OUT				9
+#define PPLL					10
+#define NOC_PRESRC				11
+#define NOC_POSTCLK				12
+#define NOC_PLL_OUT				13
+#define NPLL					14
+#define APU_PRESRC				15
+#define APU_POSTCLK				16
+#define APU_PLL_OUT				17
+#define APLL					18
+#define RPU_PRESRC				19
+#define RPU_POSTCLK				20
+#define RPU_PLL_OUT				21
+#define RPLL					22
+#define CPM_PRESRC				23
+#define CPM_POSTCLK				24
+#define CPM_PLL_OUT				25
+#define CPLL					26
+#define PPLL_TO_XPD				27
+#define NPLL_TO_XPD				28
+#define APLL_TO_XPD				29
+#define RPLL_TO_XPD				30
+#define EFUSE_REF				31
+#define SYSMON_REF				32
+#define IRO_SUSPEND_REF				33
+#define USB_SUSPEND				34
+#define SWITCH_TIMEOUT				35
+#define RCLK_PMC				36
+#define RCLK_LPD				37
+#define WDT					38
+#define TTC0					39
+#define TTC1					40
+#define TTC2					41
+#define TTC3					42
+#define GEM_TSU					43
+#define GEM_TSU_LB				44
+#define MUXED_IRO_DIV2				45
+#define MUXED_IRO_DIV4				46
+#define PSM_REF					47
+#define GEM0_RX					48
+#define GEM0_TX					49
+#define GEM1_RX					50
+#define GEM1_TX					51
+#define CPM_CORE_REF				52
+#define CPM_LSBUS_REF				53
+#define CPM_DBG_REF				54
+#define CPM_AUX0_REF				55
+#define CPM_AUX1_REF				56
+#define QSPI_REF				57
+#define OSPI_REF				58
+#define SDIO0_REF				59
+#define SDIO1_REF				60
+#define PMC_LSBUS_REF				61
+#define I2C_REF					62
+#define TEST_PATTERN_REF			63
+#define DFT_OSC_REF				64
+#define PMC_PL0_REF				65
+#define PMC_PL1_REF				66
+#define PMC_PL2_REF				67
+#define PMC_PL3_REF				68
+#define CFU_REF					69
+#define SPARE_REF				70
+#define NPI_REF					71
+#define HSM0_REF				72
+#define HSM1_REF				73
+#define SD_DLL_REF				74
+#define FPD_TOP_SWITCH				75
+#define FPD_LSBUS				76
+#define ACPU					77
+#define DBG_TRACE				78
+#define DBG_FPD					79
+#define LPD_TOP_SWITCH				80
+#define ADMA					81
+#define LPD_LSBUS				82
+#define CPU_R5					83
+#define CPU_R5_CORE				84
+#define CPU_R5_OCM				85
+#define CPU_R5_OCM2				86
+#define IOU_SWITCH				87
+#define GEM0_REF				88
+#define GEM1_REF				89
+#define GEM_TSU_REF				90
+#define USB0_BUS_REF				91
+#define UART0_REF				92
+#define UART1_REF				93
+#define SPI0_REF				94
+#define SPI1_REF				95
+#define CAN0_REF				96
+#define CAN1_REF				97
+#define I2C0_REF				98
+#define I2C1_REF				99
+#define DBG_LPD					100
+#define TIMESTAMP_REF				101
+#define DBG_TSTMP				102
+#define CPM_TOPSW_REF				103
+#define USB3_DUAL_REF				104
+#define OUTCLK_MAX				105
+#define REF_CLK					106
+#define PL_ALT_REF_CLK				107
+#define MUXED_IRO				108
+#define PL_EXT					109
+#define PL_LB					110
+#define MIO_50_OR_51				111
+#define MIO_24_OR_25				112
+
+#endif
-- 
2.7.4

