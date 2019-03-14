Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD762070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KbItkbe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCNOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:01:26 -0400
Received: from mail-eopbgr750078.outbound.protection.outlook.com ([40.107.75.78]:10496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbfCNOBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1W4PULmrJMAGcxNSvirolPwOpfpF5mrkJTnNjlTsxc=;
 b=KbItkbe0p1TCulxTsAVeq6zmbwzogqU+cpByRwLSgDECnKnyVvQGuYa7dO2atgSXbYRCbtLU9fNnatabvxHHOUnOAY3umsuqgoLxTT3e5x+AgcMzpQahHsNNWk1K5UnxGp1fQ2ZCnyzsoBMMyA+zb5DGXpP5FSFHPABCqFmDLec=
Received: from BL0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:207:3d::34)
 by DM6PR02MB4346.namprd02.prod.outlook.com (2603:10b6:5:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Thu, 14 Mar
 2019 14:01:21 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BL0PR02CA0057.outlook.office365.com
 (2603:10b6:207:3d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 14:01:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Thu, 14 Mar 2019 14:01:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52348 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4QvA-0002kD-Ax; Thu, 14 Mar 2019 07:01:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qv5-0005KL-5w; Thu, 14 Mar 2019 07:01:15 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qv0-0004xG-8f; Thu, 14 Mar 2019 07:01:10 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v4 2/6] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Thu, 14 Mar 2019 19:31:18 +0530
Message-ID: <20190314140122.23372-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190314140122.23372-1-nava.manne@xilinx.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(136003)(376002)(2980300002)(199004)(189003)(336012)(426003)(305945005)(486006)(50226002)(316002)(16586007)(81166006)(8676002)(81156014)(446003)(476003)(126002)(11346002)(2906002)(110136005)(2616005)(106002)(8936002)(478600001)(51416003)(7696005)(76176011)(14444005)(47776003)(356004)(9786002)(186003)(1076003)(26005)(77096007)(5660300002)(4326008)(63266004)(106466001)(107886003)(50466002)(2201001)(48376002)(36386004)(36756003)(921003)(2101003)(1121003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4346;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c85455-9b0c-4a62-4728-08d6a885898b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB4346;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4346:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43467CA2DA3CE820A46A8A43C24B0@DM6PR02MB4346.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RdvtmtOKdRfUPowWCCQL97KHBoYcWeoBsHRb6OLSeyY5B0uAKtomZ6amKiRFVgQJF8UAgsavNSGqDZKQ6L3K05zJPT5+U6KizBykepMk6NNSZsrvbOgckMLm3FXZ4YuHlBI5GewTFocFEefyeMQbQV1D72K6EqRNkTnRQH/6B1FhvVzRIsYM1XDONvIuRl0Md0kQ+NZx1junoRgSa5OD2UyXUelqkuNUClr5OC2k5tqxu0B23/8TQ9Zj+DlzAYgJoAVlSdeFWGZmN9cgxFlxnsLKDrBLsa12fRAQeTSpHEUp+mUfdfQu4Oh4ck9fQjXyRwRTxp8CtuvmnIvkeJ0nNSl2vBeoEJzlBEpVpkGm+SrGSTQPQLqcU/nOZvxN7HAbGChPVgJxeu9I1/M2l1oLmQJ520lhOGzP0reJE0CSNto=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 14:01:20.9475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c85455-9b0c-4a62-4728-08d6a885898b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../power/reset/xlnx,zynqmp-power.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 000000000000..d366f1eb623a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
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
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.18.0

