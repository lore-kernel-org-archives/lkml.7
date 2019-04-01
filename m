Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8567C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587820643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L4ztBoe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfDAH7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:59:00 -0400
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:42311
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731944AbfDAH7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnuh9mcHOSu4WkhZ+/+OZNqmqwNw06EpspJRduRSuWA=;
 b=L4ztBoe3gGol5xRfcX+nBa/7JsGhjWR2gDNoQN1etL2zB7mFS9KV2YY4AnqlnEPRRe6ocSMQkf/wXSgygWdn2Vb1DpH4ORb+W8FdTV+nDV7NvWJYdPtkAHmE3NbUgmbSEBnVDtYQYTQo74T+IDoYdVFQU6D2kBUY+IYo/k6v+V4=
Received: from BN6PR02CA0090.namprd02.prod.outlook.com (2603:10b6:405:60::31)
 by SN6PR02MB5247.namprd02.prod.outlook.com (2603:10b6:805:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16; Mon, 1 Apr
 2019 07:58:55 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN6PR02CA0090.outlook.office365.com
 (2603:10b6:405:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.17 via Frontend
 Transport; Mon, 1 Apr 2019 07:58:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Mon, 1 Apr 2019 07:58:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48348 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArqH-0007n7-Uk; Mon, 01 Apr 2019 00:58:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArqC-0002sd-Ql; Mon, 01 Apr 2019 00:58:48 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x317wcGi010652;
        Mon, 1 Apr 2019 00:58:38 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArq1-0002ql-Ix; Mon, 01 Apr 2019 00:58:38 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>, <robh@kernel.org>
CC:     <michals@xilinx.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v2 1/3] dt-bindings: spi: Add device tree binding documentation for Zynq QSPI controller
Date:   Mon, 1 Apr 2019 13:28:32 +0530
Message-ID: <1554105512-18758-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(199004)(189003)(77096007)(81156014)(336012)(8676002)(126002)(486006)(16586007)(356004)(2201001)(5660300002)(47776003)(6346003)(476003)(51416003)(26005)(50466002)(478600001)(106466001)(8936002)(426003)(316002)(81166006)(54906003)(4326008)(63266004)(50226002)(7696005)(2616005)(106002)(110136005)(9786002)(36386004)(48376002)(2906002)(6666004)(107886003)(36756003)(186003)(305945005)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5247;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc77543-0740-4b86-cfd7-08d6b677e318
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB5247;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5247:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB52470587805D1A40C20C1FBDAF550@SN6PR02MB5247.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0994F5E0C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8sVJL3FOVtcwzgfvcALo3MFiJesUcevOx71zr3g5KRFLRDO98xXHFGY+Cgk0OKhe5/Bt+yGdsUY21TJJrCUaCtCpbPNDgRhiXNC2yGqW20yY+HQgmZN+UcCqUXAEUwMvFdy7uuiC2LSVPhB9GxnC9TXYQl+jRhaDssmOhA/4m3OVxLemlA2T+XyLPRnlry6z70wrw/Kf2CUNdjuu71kl/f90GHH93l906/dNy+bRWw84pY7zGMiyUybO68w3XidVVdP55XbpLX/Nj+SYR65fAyYCj1ZBIY1gY81nSJ5DFbu3ZqkdU9H6xFWeaNRsf5yzEWByPO/f5QnORtzDr8YA2y1lhZVbxCQanN4Cx2fgxYMiT7ZM2d//28Uvrn2RKBQRF4NDVdUbXJg1BrHmK/5WEfzF5bogQyM25pc304Unb00=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2019 07:58:54.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc77543-0740-4b86-cfd7-08d6b677e318
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dts binding document for Zynq SOC QSPI controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v2
 - None
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

