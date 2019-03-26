Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05E520857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G3023JA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfCZOb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:31:59 -0400
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:13805
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZOb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEPHlzCTOIWudqwGQoIfISPgdzP9S3GjioN7K859cP8=;
 b=G3023JA/RuGQBPEuABNBt9oL547358d3Ax2i84A+1A0rgsTKTi/w7GWwvtLoYeScx7SM22PlsHuIdsNjDgKEqkLcGWJiAxhcbl6PvpneHBVLLpvyG0G9FChe6hAFAkvYoWII8wZD95dN8yv4GX1l2A+lXx0DBVNyhfCCyF8zs8M=
Received: from MWHPR0201CA0077.namprd02.prod.outlook.com
 (2603:10b6:301:75::18) by MWHPR0201MB3401.namprd02.prod.outlook.com
 (2603:10b6:301:76::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.19; Tue, 26 Mar
 2019 14:31:52 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0077.outlook.office365.com
 (2603:10b6:301:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 14:31:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.11
 via Frontend Transport; Tue, 26 Mar 2019 14:31:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7G-0003nk-Oe; Tue, 26 Mar 2019 07:31:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7B-0002zx-Ka; Tue, 26 Mar 2019 07:31:45 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2QEVf1h032000;
        Tue, 26 Mar 2019 07:31:41 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n77-0002t5-2W; Tue, 26 Mar 2019 07:31:41 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 3/6] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Tue, 26 Mar 2019 20:01:26 +0530
Message-ID: <20190326143129.2608-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190326143129.2608-1-nava.manne@xilinx.com>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(305945005)(8936002)(50226002)(486006)(26005)(110136005)(2201001)(50466002)(77096007)(2616005)(81156014)(8676002)(478600001)(446003)(9786002)(106002)(426003)(316002)(81166006)(11346002)(126002)(336012)(48376002)(476003)(16586007)(2906002)(36386004)(76176011)(51416003)(14444005)(186003)(106466001)(7696005)(5660300002)(63266004)(36756003)(47776003)(1076003)(356004)(6666004)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3401;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2a14b1-b88c-48a2-dc38-08d6b1f7c998
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:MWHPR0201MB3401;
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3401:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34017013EFED9BB35FCD83EAC25F0@MWHPR0201MB3401.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6OS3HloLxNww+B5GV4NQOciJKY6cm6sQw1Vx02yGMPwUrliqzNJ8MUMSifHzy5XkFHXK4yIZhzOQfIAmX6bQOJVDAkcquCfprNmKHunlCuFJjrcy5mszkTTUAeGn7jprCO59eUYo0qeBK8sC/RzvFxVJUVXE8do+zWC5z4RjyCHymvAZF5FKXCcgdf2DvbPaV9CcMmR9TfHJYcjUeyV2rxYorCJQVaA3rCtudoxnI5wjQ7/aId4jbCH78j7rNQ6Fa8UPwaGUa/Yq13vKajgKY4D0XP/79KzmMw+FWwRY7lq9efnDicly4KH/6dn28hrLxAcFwK7tDqcavOS3bqOvA3YY+R5nK4NRpUeKBIfSW7KAAbp+oNXOg7H8LuqpcTcyFEGuBFmw4A3kdPqfUNvFyMWrPJQCn0LpFHIdVF/fsm4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 14:31:51.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a14b1-b88c-48a2-dc38-08d6b1f7c998
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 000000000000..27a45fe5ecf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,52 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_reset: reset-controller {
+			compatible = "xlnx,zynqmp-reset";
+			#reset-cells = <1>;
+		};
+	};
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+Device nodes that need access to reset lines should
+specify them as a reset phandle in their corresponding node as
+specified in reset.txt.
+
+For list of all valid reset indicies see
+<dt-bindings/reset/xlnx-zynqmp-resets.h>
+
+Example:
+
+serdes: zynqmp_phy@fd400000 {
+	...
+
+	resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+	reset-names = "sata_rst";
+
+	...
+};
diff --git a/include/dt-bindings/reset/xlnx-zynqmp-resets.h b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
new file mode 100644
index 000000000000..e295fd5d824e
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx-zynqmp-resets.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_RESETS_H
+#define _DT_BINDINGS_ZYNQMP_RESETS_H
+
+#define		ZYNQMP_RESET_PCIE_CFG		0
+#define		ZYNQMP_RESET_PCIE_BRIDGE	1
+#define		ZYNQMP_RESET_PCIE_CTRL		2
+#define		ZYNQMP_RESET_DP			3
+#define		ZYNQMP_RESET_SWDT_CRF		4
+#define		ZYNQMP_RESET_AFI_FM5		5
+#define		ZYNQMP_RESET_AFI_FM4		6
+#define		ZYNQMP_RESET_AFI_FM3		7
+#define		ZYNQMP_RESET_AFI_FM2		8
+#define		ZYNQMP_RESET_AFI_FM1		9
+#define		ZYNQMP_RESET_AFI_FM0		10
+#define		ZYNQMP_RESET_GDMA		11
+#define		ZYNQMP_RESET_GPU_PP1		12
+#define		ZYNQMP_RESET_GPU_PP0		13
+#define		ZYNQMP_RESET_GPU		14
+#define		ZYNQMP_RESET_GT			15
+#define		ZYNQMP_RESET_SATA		16
+#define		ZYNQMP_RESET_ACPU3_PWRON	17
+#define		ZYNQMP_RESET_ACPU2_PWRON	18
+#define		ZYNQMP_RESET_ACPU1_PWRON	19
+#define		ZYNQMP_RESET_ACPU0_PWRON	20
+#define		ZYNQMP_RESET_APU_L2		21
+#define		ZYNQMP_RESET_ACPU3		22
+#define		ZYNQMP_RESET_ACPU2		23
+#define		ZYNQMP_RESET_ACPU1		24
+#define		ZYNQMP_RESET_ACPU0		25
+#define		ZYNQMP_RESET_DDR		26
+#define		ZYNQMP_RESET_APM_FPD		27
+#define		ZYNQMP_RESET_SOFT		28
+#define		ZYNQMP_RESET_GEM0		29
+#define		ZYNQMP_RESET_GEM1		30
+#define		ZYNQMP_RESET_GEM2		31
+#define		ZYNQMP_RESET_GEM3		32
+#define		ZYNQMP_RESET_QSPI		33
+#define		ZYNQMP_RESET_UART0		34
+#define		ZYNQMP_RESET_UART1		35
+#define		ZYNQMP_RESET_SPI0		36
+#define		ZYNQMP_RESET_SPI1		37
+#define		ZYNQMP_RESET_SDIO0		38
+#define		ZYNQMP_RESET_SDIO1		39
+#define		ZYNQMP_RESET_CAN0		40
+#define		ZYNQMP_RESET_CAN1		41
+#define		ZYNQMP_RESET_I2C0		42
+#define		ZYNQMP_RESET_I2C1		43
+#define		ZYNQMP_RESET_TTC0		44
+#define		ZYNQMP_RESET_TTC1		45
+#define		ZYNQMP_RESET_TTC2		46
+#define		ZYNQMP_RESET_TTC3		47
+#define		ZYNQMP_RESET_SWDT_CRL		48
+#define		ZYNQMP_RESET_NAND		49
+#define		ZYNQMP_RESET_ADMA		50
+#define		ZYNQMP_RESET_GPIO		51
+#define		ZYNQMP_RESET_IOU_CC		52
+#define		ZYNQMP_RESET_TIMESTAMP		53
+#define		ZYNQMP_RESET_RPU_R50		54
+#define		ZYNQMP_RESET_RPU_R51		55
+#define		ZYNQMP_RESET_RPU_AMBA		56
+#define		ZYNQMP_RESET_OCM		57
+#define		ZYNQMP_RESET_RPU_PGE		58
+#define		ZYNQMP_RESET_USB0_CORERESET	59
+#define		ZYNQMP_RESET_USB1_CORERESET	60
+#define		ZYNQMP_RESET_USB0_HIBERRESET	61
+#define		ZYNQMP_RESET_USB1_HIBERRESET	62
+#define		ZYNQMP_RESET_USB0_APB		63
+#define		ZYNQMP_RESET_USB1_APB		64
+#define		ZYNQMP_RESET_IPI		65
+#define		ZYNQMP_RESET_APM_LPD		66
+#define		ZYNQMP_RESET_RTC		67
+#define		ZYNQMP_RESET_SYSMON		68
+#define		ZYNQMP_RESET_AFI_FM6		69
+#define		ZYNQMP_RESET_LPD_SWDT		70
+#define		ZYNQMP_RESET_FPD		71
+#define		ZYNQMP_RESET_RPU_DBG1		72
+#define		ZYNQMP_RESET_RPU_DBG0		73
+#define		ZYNQMP_RESET_DBG_LPD		74
+#define		ZYNQMP_RESET_DBG_FPD		75
+#define		ZYNQMP_RESET_APLL		76
+#define		ZYNQMP_RESET_DPLL		77
+#define		ZYNQMP_RESET_VPLL		78
+#define		ZYNQMP_RESET_IOPLL		79
+#define		ZYNQMP_RESET_RPLL		80
+#define		ZYNQMP_RESET_GPO3_PL_0		81
+#define		ZYNQMP_RESET_GPO3_PL_1		82
+#define		ZYNQMP_RESET_GPO3_PL_2		83
+#define		ZYNQMP_RESET_GPO3_PL_3		84
+#define		ZYNQMP_RESET_GPO3_PL_4		85
+#define		ZYNQMP_RESET_GPO3_PL_5		86
+#define		ZYNQMP_RESET_GPO3_PL_6		87
+#define		ZYNQMP_RESET_GPO3_PL_7		88
+#define		ZYNQMP_RESET_GPO3_PL_8		89
+#define		ZYNQMP_RESET_GPO3_PL_9		90
+#define		ZYNQMP_RESET_GPO3_PL_10		91
+#define		ZYNQMP_RESET_GPO3_PL_11		92
+#define		ZYNQMP_RESET_GPO3_PL_12		93
+#define		ZYNQMP_RESET_GPO3_PL_13		94
+#define		ZYNQMP_RESET_GPO3_PL_14		95
+#define		ZYNQMP_RESET_GPO3_PL_15		96
+#define		ZYNQMP_RESET_GPO3_PL_16		97
+#define		ZYNQMP_RESET_GPO3_PL_17		98
+#define		ZYNQMP_RESET_GPO3_PL_18		99
+#define		ZYNQMP_RESET_GPO3_PL_19		100
+#define		ZNQMP_RESET_GPO3_PL_20		101
+#define		ZYNQMP_RESET_GPO3_PL_21		102
+#define		ZYNQMP_RESET_GPO3_PL_22		103
+#define		ZYNQMP_RESET_GPO3_PL_23		104
+#define		ZYNQMP_RESET_GPO3_PL_24		105
+#define		ZYNQMP_RESET_GPO3_PL_25		106
+#define		ZYNQMP_RESET_GPO3_PL_26		107
+#define		ZYNQMP_RESET_GPO3_PL_27		108
+#define		ZYNQMP_RESET_GPO3_PL_28		109
+#define		ZYNQMP_RESET_GPO3_PL_29		110
+#define		ZYNQMP_RESET_GPO3_PL_30		111
+#define		ZYNQMP_RESET_GPO3_PL_31		112
+#define		ZYNQMP_RESET_RPU_LS		113
+#define		ZYNQMP_RESET_PS_ONLY		114
+#define		ZYNQMP_RESET_PL			115
+#define		ZYNQMP_RESET_PS_PL0		116
+#define		ZYNQMP_RESET_PS_PL1		117
+#define		ZYNQMP_RESET_PS_PL2		118
+#define		ZYNQMP_RESET_PS_PL3		119
+
+#endif
-- 
2.18.0

