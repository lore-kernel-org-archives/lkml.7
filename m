Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A687020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UyOnULD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDIKHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:22 -0400
Received: from mail-eopbgr710046.outbound.protection.outlook.com ([40.107.71.46]:20905
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfDIKHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8ldoAaRKvQA6aCh4sahZP6dqibxAHoT0k3zfkvTSVI=;
 b=UyOnULD5Yu6sy0VZIiMQw2looaz1058vid7PpUG7/o56VHGbAxJc4q5DkYRcIRtaC2x0GLt5E22Vaod/vhhuVtFpjR1FjqR7nRUYuzIlDVmSN4AY5nPOwzYn4IrPEke0aadyKqUwX0cT0EVQx7SXPa0qvRra53Yn2f4yqkkzDb0=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.19; Tue, 9 Apr
 2019 10:07:13 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:13 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 9 Apr 2019 11:07:04 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 9 Apr 2019 11:07:04 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=57788 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hDnei-0007SJ-I9; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Date:   Tue, 9 Apr 2019 11:06:43 +0100
Message-ID: <1554804414-206099-2-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(316002)(7636002)(16586007)(106002)(50226002)(8936002)(305945005)(246002)(36906005)(110136005)(54906003)(76130400001)(28376004)(8676002)(5660300002)(9786002)(60926002)(356004)(6666004)(71366001)(50466002)(336012)(26826003)(2201001)(48376002)(36756003)(4326008)(93146003)(7696005)(51416003)(2906002)(476003)(2616005)(956004)(446003)(107886003)(26005)(11346002)(76176011)(47776003)(186003)(106466001)(478600001)(44832011)(126002)(426003)(486006)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3830;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055d9c71-3742-4336-8889-08d6bcd32316
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR02MB3830;
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB3830B497D00ED3A0BEC24D3ACB2D0@DM5PR02MB3830.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: q1J2b7OgAha9q57zbkIq6hIA+KWPVZvn1Vt71xfmbSHeYPdhtwgrblUfN+sp6gMY+qLm3/y32dEjF+ARohI5SaCcmskre52aZtuWP5mYLxrAt33jcmhZpSfaaOml8GEfo/ExXwscLklDm768k1fEOZTqv1HwCWYS3tEhXk0xWv9b1pCS214E7EGePIsEWBmlwbFPR6qL70zTTc7It+vUYArRDN61R6wILH8Gov7S8tPBEBakFwodYYYgVvC6W9RALc5t36xeFoJfWMExUDhdYulPakhEfU3tRJT62J8LpBx2Q/qMyn0P6ZWNsXZg+Vu8AQu+N8MLYKYn2UEDB+w3PVd/Bt9yfmlBrAfjbM8SjJ4+fpAPb6m9IkGQ5UpxaUPH3geaUhLyW9oqn9grZGzV/CtfzaJSHPPwVSRYeVcciVs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:13.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d9c71-3742-4336-8889-08d6bcd32316
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Soft Decision Forward Error Correction (SDFEC) Engine
bindings which is available for the Zynq UltraScale+ RFSoC
FPGA's.

Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
---
 .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt

diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
new file mode 100644
index 0000000..425b6a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
@@ -0,0 +1,58 @@
+* Xilinx SDFEC(16nm) IP *
+
+The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
+which provides high-throughput LDPC and Turbo Code implementations.
+The LDPC decode & encode functionality is capable of covering a range of
+customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
+principally covers codes used by LTE. The FEC Engine offers significant
+power and area savings versus implementations done in the FPGA fabric.
+
+
+Required properties:
+- compatible: Must be "xlnx,sd-fec-1.1"
+- clock-names : List of input clock names from the following:
+    - "core_clk", Main processing clock for processing core (required)
+    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
+    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
+    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
+    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
+    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
+    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
+    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
+- clocks : Clock phandles (see clock_bindings.txt for details).
+- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
+  location and length.
+- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
+  being used.
+- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
+  driven with a fixed value and is not present on the device, a value of 1
+  configures the DIN_WORDS to be block based, while a value of 2 configures the
+  DIN_WORDS input to be supplied for each AXI transaction.
+- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
+  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
+  of "4x128b".
+- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interface is
+  driven with a fixed value and is not present on the device, a value of 1
+  configures the DOUT_WORDS to be block based, while a value of 2 configures the
+  DOUT_WORDS input to be supplied for each AXI transaction.
+- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of 1
+  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
+  of "4x128b".
+Optional properties:
+- interrupts: should contain SDFEC interrupt number
+
+Example
+---------------------------------------
+	sd_fec_0: sd-fec@a0040000 {
+		compatible = "xlnx,sd-fec-1.1";
+		clock-names = "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_status_aclk","m_axis_dout_aclk";
+		clocks = <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>, <&misc_clk_1>;
+		reg = <0x0 0xa0040000 0x0 0x40000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 89 4>;
+		xlnx,sdfec-code = "ldpc";
+		xlnx,sdfec-din-words = <0>;
+		xlnx,sdfec-din-width = <2>;
+		xlnx,sdfec-dout-words = <0>;
+		xlnx,sdfec-dout-width = <1>;
+	};
-- 
2.7.4

