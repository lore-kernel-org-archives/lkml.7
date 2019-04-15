Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34344C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE5B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ezRKCATt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfDOHSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:18:45 -0400
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:43473
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfDOHSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSLEkMQpCXqTE+Pj9v9fVmruqPTczpOx6UiwiLhLMyI=;
 b=ezRKCATtAbJAcZT3OkQzQI99Re6iE8DCg1CHXn1HxfoEiDpHUb9Ino85/EK5/ZZKJtgLgj2TxiBGopzyTaf6TUts5yeK2cOwA/QoUxJO92OzWwrowLulCtfCfsulXjOHNzwoqYC9qnAF7Dpk3tIH51Dxg1QudDNR6engExkFeeA=
Received: from MWHPR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:301:73::20) by BL2PR02MB2001.namprd02.prod.outlook.com
 (2a01:111:e400:c749::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.17; Mon, 15 Apr
 2019 07:18:41 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0043.outlook.office365.com
 (2603:10b6:301:73::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.16 via Frontend
 Transport; Mon, 15 Apr 2019 07:18:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 07:18:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvt1-0007BZ-7u; Mon, 15 Apr 2019 00:18:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsw-0006rY-4o; Mon, 15 Apr 2019 00:18:34 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3F7INXA029755;
        Mon, 15 Apr 2019 00:18:23 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsk-0006nQ-Gm; Mon, 15 Apr 2019 00:18:22 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Mon, 15 Apr 2019 12:47:47 +0530
Message-ID: <20190415071748.32275-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415071748.32275-1-nava.manne@xilinx.com>
References: <20190415071748.32275-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(199004)(189003)(36386004)(48376002)(47776003)(9786002)(8676002)(81166006)(11346002)(8936002)(50226002)(426003)(81156014)(476003)(126002)(106466001)(486006)(2616005)(50466002)(446003)(305945005)(2906002)(36756003)(336012)(63266004)(186003)(26005)(478600001)(77096007)(7696005)(6666004)(356004)(51416003)(1076003)(16586007)(5660300002)(316002)(76176011)(106002)(2201001)(110136005)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2001;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db26d1ba-9b0c-423b-e554-08d6c1729597
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR02MB2001;
X-MS-TrafficTypeDiagnostic: BL2PR02MB2001:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB20018EB8D19A122ED366F999C22B0@BL2PR02MB2001.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Uw4YnbEekFU3XAGX4mN7cfJDWd6i73UubRJZrwl8wzDsQIuXfEgzvjncSknnH9Crl+rImc64V8AgYXZl/SGqTdjpFcWbKmaGc2CLTNK6EL8Xnlfg8QILbx/7yKe5/GrHWZArSRSnYLvKujy9rinBvuDjepySq/meBfTERBE3o0yzc4RGpzM1Jy8HKgdOI/cuWL3ik4qum3uwid/148AJaYdJ65m7gKVhjq3GqIjcbJAWNrKrvU2KinZWO2OvdlNm/vc29w6cdLFx5L85OlwYAcTrTvDUUMg2KtMl5PCI/AaPF2lo0A5JzVgtij9OpR+aHSpnREN/SQaBA/7VZlUvkebAxn3ln4q9R1NKTgaRQN50rb1QOfQVViD668ySUst6QlcmU3Wiiu07mX1ny+mDQGCo/keT9bKsqd1a8J+fDGY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 07:18:39.7977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db26d1ba-9b0c-423b-e554-08d6c1729597
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
Changes for v5:
		-None.

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..3052bf619dd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,25 @@
+Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
+The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
+Programmable Logic (PL). The configuration uses  the firmware interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example for full FPGA configuration:
+
+	fpga-region0 {
+		compatible = "fpga-region";
+		fpga-mgr = <&zynqmp_pcap>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+	};
+
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+			zynqmp_pcap: pcap {
+				compatible = "xlnx,zynqmp-pcap-fpga";
+			};
+		};
+	};
-- 
2.18.0

