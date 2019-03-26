Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC220685
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RG+KAOGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfCZObz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:31:55 -0400
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:20672
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731656AbfCZOby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1W4PULmrJMAGcxNSvirolPwOpfpF5mrkJTnNjlTsxc=;
 b=RG+KAOGxA6tmfpsNgRUOTJvlhJJq8KXHjApRFIIfzOLJf07c4b/FxZNa+d3+8xlbOHXZFOJihYrmUgq1Kz6aeMwJzz2FNEqaxuXgPwaXuLYyH6/PJ3g4vcqU83gahqTr9HH84nghpx4ZqOOPKaWaFflPX5vFo1avt0CLPB2KLyw=
Received: from SN4PR0201CA0034.namprd02.prod.outlook.com
 (2603:10b6:803:2e::20) by SN1PR02MB1663.namprd02.prod.outlook.com
 (2a01:111:e400:5230::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.16; Tue, 26 Mar
 2019 14:31:51 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0034.outlook.office365.com
 (2603:10b6:803:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Tue, 26 Mar 2019 14:31:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 14:31:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55742 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7G-0005aV-RT; Tue, 26 Mar 2019 07:31:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n7B-0002zx-Nb; Tue, 26 Mar 2019 07:31:45 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2QEVZJ0031992;
        Tue, 26 Mar 2019 07:31:36 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n71-0002t5-BF; Tue, 26 Mar 2019 07:31:35 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 2/6] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Tue, 26 Mar 2019 20:01:25 +0530
Message-ID: <20190326143129.2608-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190326143129.2608-1-nava.manne@xilinx.com>
References: <20190326143129.2608-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(5660300002)(486006)(2201001)(51416003)(106466001)(76176011)(47776003)(50226002)(7696005)(478600001)(36386004)(8936002)(476003)(2616005)(107886003)(336012)(14444005)(446003)(426003)(305945005)(6666004)(110136005)(316002)(126002)(48376002)(11346002)(16586007)(4326008)(9786002)(50466002)(81156014)(2906002)(8676002)(26005)(36756003)(1076003)(81166006)(106002)(63266004)(356004)(186003)(77096007)(921003)(2101003)(5001870100001)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1663;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b27df2-d970-4c7f-c51b-08d6b1f7c992
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:SN1PR02MB1663;
X-MS-TrafficTypeDiagnostic: SN1PR02MB1663:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB16634787A5F5DD4456B33B49C25F0@SN1PR02MB1663.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nceo4nMsnNAL3TUoteCgjVFCefi7SZrVcEvmDz0vzcSZ0Bft3gooqzm9QAnQxyj1AWknvMvsE4gHenChGVy9duFW0JhXRtOv65V9dJQ6IATI8n9oGIpYXu9LTog67XTUNpUqfgK9M3/OU3B03tGMWUC7WwPF97k27NYJUSI4dcsJzyWynuXrzauPZnhJbvKAwNj883IK3DhEkUSrv+bpYmGy00350qTr9U6o9YtuqGSFElw1caJEZac35Hqn+PrLK4j2U3hS+4fcT0hjI3d7IxshCpChkwf6vfzr7+avs7MJGMA2XJsSdcwaum29HOhd+1FS+o8SiXr7m99LWtS46dqEt02xLS+GAiSQUEMzEsPvNJA0x7cnFrgCbxV6yXwFfHNk2fE0pIA2v89Iog5rkF+uFVJbzkHGPVdW1uZ8w/U=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 14:31:51.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b27df2-d970-4c7f-c51b-08d6b1f7c992
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1663
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

