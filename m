Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25632184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nJUu0nE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCNOC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:02:27 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:28639
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727666AbfCNOC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHuX/JW5DomH+ioJR/jPuAYoi5oOAl0hipDIyqgJQcg=;
 b=nJUu0nE+FXLE4OXJQQR1qQWprIV9ef1pKv0ibu3HTo8089R1TFcF/Zr0IB896YBalJ70SGu6uLDp9Q/2e2V1ECbIYeY4PUeRdPXgFSzGRtWXFQax8Fd+kgT4v/Wkt6kj21qXcHYN4Ec52OOy7rIPZuLresqIhQn7EeAH1pwkieE=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by CY4SPR00MB233.namprd02.prod.outlook.com (2603:10b6:903:17::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Thu, 14 Mar
 2019 14:02:22 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 14:02:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Thu, 14 Mar 2019 14:02:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qw9-0002Hz-1b; Thu, 14 Mar 2019 07:02:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qw3-0005dR-Tz; Thu, 14 Mar 2019 07:02:15 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qvy-0004xG-7a; Thu, 14 Mar 2019 07:02:10 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Thu, 14 Mar 2019 19:31:22 +0530
Message-ID: <20190314140122.23372-7-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190314140122.23372-1-nava.manne@xilinx.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(189003)(199004)(47776003)(478600001)(106002)(486006)(6666004)(356004)(50226002)(316002)(16586007)(2616005)(110136005)(76176011)(7696005)(186003)(50466002)(2906002)(51416003)(26005)(77096007)(81156014)(8676002)(48376002)(126002)(63266004)(106466001)(5660300002)(81166006)(305945005)(9786002)(36386004)(11346002)(8936002)(476003)(446003)(36756003)(2201001)(1076003)(426003)(336012)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4SPR00MB233;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 437aa16f-6655-44e4-ff7a-08d6a885adbd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4SPR00MB233;
X-MS-TrafficTypeDiagnostic: CY4SPR00MB233:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4SPR00MB233677C2593F4CA2DCBA0EDC24B0@CY4SPR00MB233.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xWfCqoDEVQRE82JMkBMRzVwF+/vObIxSOxW2XcB9Vd10tgOK1A1j5GoUwHXz5AFmPUWaCHgsJlX6gjWugA4GjRfCpmnq1e9TIaJaTeG4GrJa5jqw8B45eZinIfOfJza+52j+u8veS3aHKrsQCoFV+pqFzMqDkCuLw8A/8gZ9sJLUo6Ywgv/KufnMAGCkx+jfR1EL09RVMx4C8Vg1GlwTF0L8ttmYofC19WhekZEXVxjElPdZ1LXLcYYGvLfFbcWqmm0urMJDZ5fY20RMS0QWNABWcQ4BnCDXP5TI0Ux+0lPih8GO07kxBp/iuF9HIjpq0PTNXflYEH/ZuLLoXxuKd/cscEuYTDGQWaJLK493HKxkEHbEz/E+peW8tZzt4aIF+4lHz/p0uP0XSIAEOoB7Lmt0k8GiKhFTn9n+emdz6p0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 14:02:21.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437aa16f-6655-44e4-ff7a-08d6a885adbd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v4:
		-Modified binding description as suggested by Moritz Fischer.
Changes for v3:
                -Removed PCAP as a child node to the FW and Created
		 an independent node since PCAP driver is a consumer
		 not a provider.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt           | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..6d7f10775d9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,11 @@
+Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
+The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
+Programmable Logic (PL). The configuration uses  the firmware interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0

