Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367B12146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="suJ5TkmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCSMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:40 -0400
Received: from mail-eopbgr750041.outbound.protection.outlook.com ([40.107.75.41]:17214
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbfCSMEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGDiPzGpbDRRn9mMhNP6z9lCIRAtpDWXOU55/ipNuqg=;
 b=suJ5TkmROGLCZEa4Iz9NNt6eiRPva5X4/6/T1rY6PUWqZnnDOkZXYY+4ZiwSER28tlB8jg/Z/NSrF2Xpn7b9DXdkRnmuBeT1hLoLyDVPge5Xzy96LsdtFehbeO6XbYqF1JZyXtXXLBTYtOETJemUdoI540IbvAyA1Yh4O87Qsck=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by BN8PR02MB5908.namprd02.prod.outlook.com (2603:10b6:408:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:34 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:33 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:32 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:32 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTs-0003Ch-Gq; Tue, 19 Mar 2019 12:04:32 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Date:   Tue, 19 Mar 2019 12:04:13 +0000
Message-ID: <1552997064-432700-2-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(189003)(199004)(50466002)(356004)(14444005)(2201001)(7696005)(51416003)(8676002)(48376002)(186003)(107886003)(71366001)(26005)(76176011)(26826003)(246002)(5024004)(6666004)(5660300002)(478600001)(60926002)(486006)(7636002)(47776003)(305945005)(36756003)(28376004)(44832011)(9786002)(93146003)(8746002)(106466001)(8936002)(110136005)(316002)(106002)(336012)(50226002)(4326008)(54906003)(476003)(446003)(126002)(956004)(11346002)(2906002)(36906005)(2616005)(426003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5908;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6e98055-1981-4239-535c-08d6ac630d39
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN8PR02MB5908;
X-MS-TrafficTypeDiagnostic: BN8PR02MB5908:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN8PR02MB59089B0F9C963A55B1C95B8BCB400@BN8PR02MB5908.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m5CsqgrV+oFhdZttlmdBALE18GF1+zFYp+Z01l29E5qRjVdVK/wGpTEM5MzlrAeQ1YMePX+/B/xTWBxbXce/A3joy6KIHfFcCt6JCyVx5mPXzqyfj7kWm/MbOmoG8MgvO9yb1cLaKwMOZtbXa1lnROQdipHh7ARKQR8kIFmi2C5iCKJ/9xJ9i1xpaCiL2CwBqlmEt/hxG7xuqGip9UF2zhn4d/qis2YJaspZjMU2eX53Nfj4TMLy03xAsqp2Lckgz6DXoCQFG0x7V9/JrH+n4TPme3EjG8Lv1Bj69CdDGJJdXEWZ3a2mWrOB82vtzcxFYNLqp4Toe61ECnnHCHFl6IIIbPeeMdfktuGMPKxb/B8GRZ+vBuei4k+XN9FYxGWTrxryFQuQcOhMFP7EbAKzVHfdUhheVF1ZOgxXgQXLYqY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:33.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e98055-1981-4239-535c-08d6ac630d39
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5908
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
 .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++=
++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt

diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Docum=
entation/devicetree/bindings/misc/xlnx,sd-fec.txt
new file mode 100644
index 0000000..8af0adc
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
@@ -0,0 +1,58 @@
+* Xilinx SDFEC(16nm) IP *
+
+The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP blo=
ck
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
+    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (require=
d)
+    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
+    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock=
 (optional)
+    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock=
 (optional)
+    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optiona=
l)
+    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface cl=
ock (optional)
+    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clo=
ck (optional)
+- clocks : Clock phandles (see clock_bindings.txt for details).
+- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
+  location and length.
+- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
+  being used.
+- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface =
is
+  driven with a fixed value and is not present on the device, a value of 1
+  configures the DIN_WORDS to be block based, while a value of 2 configure=
s the
+  DIN_WORDS input to be supplied for each AXI transaction.
+- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
+  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a=
 width
+  of "4x128b".
+- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interfac=
e is
+  driven with a fixed value and is not present on the device, a value of 1
+  configures the DOUT_WORDS to be block based, while a value of 2 configur=
es the
+  DOUT_WORDS input to be supplied for each AXI transaction.
+- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of =
1
+  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a=
 width
+  of "4x128b".
+Optional properties:
+- interrupts: should contain SDFEC interrupt number
+
+Example
+---------------------------------------
+       sd_fec_0: sd-fec@a0040000 {
+               compatible =3D "xlnx,sd-fec-1.1";
+               clock-names =3D "core_clk", "s_axi_aclk", "s_axis_ctrl_aclk=
", "s_axis_din_aclk", "m_axis_status_aclk", "m_axis_dout_aclk";
+               clocks =3D <&misc_clk_2>, <&misc_clk_0>, <&misc_clk_1>, <&m=
isc_clk_1>, <&misc_clk_1>, <&misc_clk_1>;
+               reg =3D <0x0 0xa0040000 0x0 0x40000>;
+               interrupt-parent =3D <&gic>;
+               interrupts =3D <0 89 4>;
+               xlnx,sdfec-code =3D "ldpc";
+               xlnx,sdfec-din-words =3D <0>;
+               xlnx,sdfec-din-width =3D <2>;
+               xlnx,sdfec-dout-words =3D <0>;
+               xlnx,sdfec-dout-width =3D <1>;
+       };
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
