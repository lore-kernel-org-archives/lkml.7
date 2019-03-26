Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23627C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB50B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xg7wAzFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfCZOcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:32:18 -0400
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:47520
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfCZOcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdSkJV8gcOwZQ8Nw9mTj/bS60aCIk9EofATZ+LHkWqo=;
 b=xg7wAzFlxDCKX+OBYaZk2iBu8Kis5pWOBeX/c2TM1x9zEJbHAN9Y0Np5LTqYD/7k7BWW/CPl7yMSV8aSgfUZcGzr263x8cOU6MKM39NVBVBfxYVa3TGg4oLdZETPsnvkQn+40CdWm28nyOXY7m2tyw98jQjWOUVdpmpbmE1KmS0=
Received: from CY4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:903:18::18)
 by BLUSPR8PMB96.namprd02.prod.outlook.com (2a01:111:e400:8ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Tue, 26 Mar
 2019 14:32:13 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0008.outlook.office365.com
 (2603:10b6:903:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.18 via Frontend
 Transport; Tue, 26 Mar 2019 14:32:13 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=temperror action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 14:32:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7b-0003o2-8r; Tue, 26 Mar 2019 07:32:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7W-0003EX-5M; Tue, 26 Mar 2019 07:32:06 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2QEVxYj009375;
        Tue, 26 Mar 2019 07:32:00 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7P-0002t5-CQ; Tue, 26 Mar 2019 07:31:59 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Tue, 26 Mar 2019 20:01:29 +0530
Message-ID: <20190326143129.2608-7-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190326143129.2608-1-nava.manne@xilinx.com>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(199004)(189003)(5660300002)(8936002)(106466001)(50226002)(106002)(47776003)(2201001)(478600001)(36386004)(63266004)(48376002)(50466002)(2906002)(9786002)(305945005)(1076003)(76176011)(51416003)(7696005)(110136005)(316002)(16586007)(446003)(6666004)(63350400001)(63370400001)(81156014)(81166006)(426003)(8676002)(356004)(336012)(36756003)(2616005)(11346002)(486006)(126002)(476003)(77096007)(186003)(26005)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUSPR8PMB96;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a1f4be9-0a5d-49ba-16d3-08d6b1f7d5cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUSPR8PMB96;
X-MS-TrafficTypeDiagnostic: BLUSPR8PMB96:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUSPR8PMB96027CB24D1449AD5C3CF3C25F0@BLUSPR8PMB96.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: z2yzJAprD6S/1vvfEeZWgNYTUMGosNqRNKiiIYIdd5WSckvZXC5qfFpMAU2FbSHknmDKuWeVsSYC3mzGFCMLbkZUdNT4UCRFXaEQr/3hVqzIvygYVGr7SxtChmkOINhHGDQpXQGIKYDd5oVCAwb6njmYJfb6mfZjlBp44wuZoOpP9Kra1xMEY1v7bTHkmrKK6HOtrAvKzr21F9aXRje+qHV45k8IVyJ5bJwaQjQ3raqxMaAxkb5pEvYOrowHjpzUbIb5vBv02aEzIcYY8h1tV8sC+x0z+RcVzcWGgB/WAXMo/9tOTizfmE7nMeTSkdIb28DiP044qDqprjQLjIUhtWiVq1aASMjr58XJrwqy+SLP398ZHtj6jwYnTqPRnL80YgvuqFyKtLKsL3UWItcj9zQ6s2cgNRcFg7W0Fevo6Co=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 14:32:11.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f4be9-0a5d-49ba-16d3-08d6b1f7d5cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUSPR8PMB96
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v5:
		-Moved pcap node as a child to firwmare
		 node as suggested by Rob.
Changes for v4:
		-Modified binding description as suggested by Moritz Fischer.
Changes for v3:
		-Removed PCAP as a child node to the FW and Created
		 an independent node since PCAP driver is a consumer
		 not a provider.

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

