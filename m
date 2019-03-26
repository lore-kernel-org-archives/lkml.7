Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39748C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496520857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Nxr7JptZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfCZObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:31:51 -0400
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:57024
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZObt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ry9Ezl38Yybh13NF9Ac+lUiGMwCpHSGLVsBt/YaFg=;
 b=Nxr7JptZNYfGP32ugwf+rn+fAWfkitW52sgz3CjngEb20dYz3dacDsejCEFSV+G5A8IMZhyVCaWL09MbD6fY6ieHQkRyqcK5LppMYowexkMJJjRH54P8TOW03bYVidZW7W07iuZ/YSA98QrHkQYXWh6s/ncYSEPsUyP8T+8BsrU=
Received: from SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) by BN7PR02MB5235.namprd02.prod.outlook.com
 (2603:10b6:408:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Tue, 26 Mar
 2019 14:31:41 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by SN4PR0201CA0046.outlook.office365.com
 (2603:10b6:803:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 14:31:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.11
 via Frontend Transport; Tue, 26 Mar 2019 14:31:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n76-0003nd-IR; Tue, 26 Mar 2019 07:31:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n71-0002xg-Ek; Tue, 26 Mar 2019 07:31:35 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2QEVT6P031972;
        Tue, 26 Mar 2019 07:31:29 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n6v-0002t5-7Z; Tue, 26 Mar 2019 07:31:29 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 1/6] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Tue, 26 Mar 2019 20:01:24 +0530
Message-ID: <20190326143129.2608-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190326143129.2608-1-nava.manne@xilinx.com>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(486006)(126002)(476003)(47776003)(5660300002)(77096007)(478600001)(2201001)(305945005)(4326008)(2616005)(8936002)(316002)(51416003)(7696005)(106002)(107886003)(50226002)(76176011)(110136005)(16586007)(26005)(9786002)(106466001)(11346002)(356004)(2906002)(6666004)(426003)(36386004)(81166006)(50466002)(48376002)(446003)(81156014)(8676002)(63266004)(36756003)(336012)(1076003)(186003)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5235;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab36b0bf-13e8-4453-c5b5-08d6b1f7c380
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:BN7PR02MB5235;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5235:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB52359214CE3E4700EAF65739C25F0@BN7PR02MB5235.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fIbY7mmS6eMayvKY2m+6RB5cY2h8Feis5GipcwBiw+lypk/FN+nNqKWks/uFaVBwOnpX2YCl5CT+b1gby8CRDSgH0EH4b/+mT03H28sVX3FM54GUXBQufZ0/hc4SyaiQTskgRwnvTf9eIWNLIOv1v6upIH2sWxKooWPJ579iMcdRvbtCk47KpwLWjQol5n7GZFrWqMEGVkZhXXaqMZa+YoEbs31/2gxGSFGIL+N54w0CxlccHOaKYU1MtgdoQ5I2pAiAl0/iQQ9Kb7LX5BQ0D/lMoVVOthQoxhmYdWnQG7up/+pzGfvN2F/nz9gThDm13Ca9knrjt4dt6MZcnS1voRqw8D3sr0P2xh1qVprot6dRGzyUqm/1tGCiyfKuVtVHYcw00GGWLlLLNC4pl4XOzdZriPaFzEgqnyGBvXe/2+c=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 14:31:41.2126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab36b0bf-13e8-4453-c5b5-08d6b1f7c380
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/xlnx,zynqmp-genpd.txt      | 34 ++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h | 39 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 000000000000..3c7f2378e146
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 2>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 000000000000..1bc9636098ca
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	0
+#define		PD_USB_1	1
+#define		PD_SATA		2
+#define		PD_SPI_0	3
+#define		PD_SPI_1	4
+#define		PD_UART_0	5
+#define		PD_UART_1	6
+#define		PD_ETH_0	7
+#define		PD_ETH_1	8
+#define		PD_ETH_2	9
+#define		PD_ETH_3	10
+#define		PD_I2C_0	11
+#define		PD_I2C_1	12
+#define		PD_DP		13
+#define		PD_GDMA		14
+#define		PD_ADMA		15
+#define		PD_TTC_0	16
+#define		PD_TTC_1	17
+#define		PD_TTC_2	18
+#define		PD_TTC_3	19
+#define		PD_SD_0		20
+#define		PD_SD_1		21
+#define		PD_NAND		22
+#define		PD_QSPI		23
+#define		PD_GPIO		24
+#define		PD_CAN_0	25
+#define		PD_CAN_1	26
+#define		PD_PCIE		27
+#define		PD_GPU		28
+
+#endif
-- 
2.18.0

