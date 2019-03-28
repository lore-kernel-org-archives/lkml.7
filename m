Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE12082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DkLHg40F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfC1LQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:16:21 -0400
Received: from mail-eopbgr810059.outbound.protection.outlook.com ([40.107.81.59]:3424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfC1LQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/uOF9plOsoQvsH2OfgvdtVPCIZwyioQWAoM1ljBFmY=;
 b=DkLHg40FFpvY0hYTi8wH73z2I8FLXsHPwSh47Y3vGo95AgzBV2wL6CQBvM3J5HdwszxQ1DaXrsFu/C/OMY1LMVPW+TGB1oFXb4V97WvRBVtkWKHxpFqGzBFCwjHKWXg+DiD6ur7Vra7YCya3hshih1Ln7xd22KEJkuTaCRWRILo=
Received: from CY4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:903:18::19)
 by SN6PR02MB5248.namprd02.prod.outlook.com (2603:10b6:805:70::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.17; Thu, 28 Mar
 2019 11:16:15 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0009.outlook.office365.com
 (2603:10b6:903:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.16 via Frontend
 Transport; Thu, 28 Mar 2019 11:16:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Thu, 28 Mar 2019 11:16:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56427 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T14-0002eV-Lh; Thu, 28 Mar 2019 04:16:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T0z-0000en-IX; Thu, 28 Mar 2019 04:16:09 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2SBG4Qc000597;
        Thu, 28 Mar 2019 04:16:04 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T0u-0000TW-5v; Thu, 28 Mar 2019 04:16:04 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>, <robh@kernel.org>
CC:     <michals@xilinx.com>, <mark.rutland@arm.com>,
        <horms+renesas@verge.net.au>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH 1/3] dt-bindings: spi: Add device tree binding documentation for Zynq QSPI controller
Date:   Thu, 28 Mar 2019 16:46:00 +0530
Message-ID: <1553771760-2011-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(2201001)(8676002)(6666004)(356004)(36756003)(478600001)(7696005)(51416003)(2906002)(5660300002)(336012)(426003)(77096007)(47776003)(305945005)(4326008)(106466001)(106002)(186003)(54906003)(110136005)(16586007)(63266004)(8936002)(107886003)(9786002)(36386004)(486006)(2616005)(316002)(476003)(126002)(50226002)(50466002)(48376002)(81156014)(81166006)(26005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5248;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e93cd64-3051-4073-b336-08d6b36ecb1f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB5248;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5248:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB5248F25B37C4FD784834E540AF590@SN6PR02MB5248.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0990C54589
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TZN/6WMpqj740fby1NHSEshsXrx3sG3easCH2gy2voOwv5SqEymR+cMHrgJEuHQbh79Smw90czUq7iIjX9phLxwNxzHKjO71qYUIsKZS6ap3B6Da2CQrb1khbYF9ih5ILZGtN1wm/7dbBm9I9sS0YaJzioNluVpgNn9nr7vyTgyfOpNTmU7AZjHckXF6fzXnSEgWx/JemTdb6H7toiYsIuwH40M+RLAzJo/qz/urpCMilDt1fu5Comw5W/CQk7TKbG2pJ9uU1WzvXyhkIDgJunVD++B435z4DGwUYVnht3tbwSp5lHYrhWiXVn3KIMfDVcBZnd+5lleqJJIKJEncVTTVsbQ5waX/j1pGINAmxVYwkQMceBZZg2d4T9NOFs9lVxpMO9VE6NYf5AiuO9JJvfhAmVGox11WA1Xuc/smBAA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2019 11:16:15.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e93cd64-3051-4073-b336-08d6b36ecb1f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dts binding document for Zynq SOC QSPI controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 .../devicetree/bindings/spi/spi-zynq-qspi.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
new file mode 100644
index 0000000..16b734a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
@@ -0,0 +1,25 @@
+Xilinx Zynq QSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-qspi-1.0".
+- reg			: Physical base address and size of QSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi@e000d000 {
+		compatible = "xlnx,zynq-qspi-1.0";
+		reg = <0xe000d000 0x1000>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 19 4>;
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clkc 10>, <&clkc 43>;
+		num-cs = <1>;
+	};
-- 
2.7.4

