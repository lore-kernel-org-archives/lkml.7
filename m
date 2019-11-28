Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACEE215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfK1Ggl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:36:41 -0500
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:62030
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfK1Ggk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:36:40 -0500
Received: from SN6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:805:a2::25)
 by CH2PR02MB6965.namprd02.prod.outlook.com (2603:10b6:610:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19; Thu, 28 Nov
 2019 06:36:36 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by SN6PR02CA0012.outlook.office365.com
 (2603:10b6:805:a2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Thu, 28 Nov 2019 06:36:36 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:36:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPn-0007XO-K8; Wed, 27 Nov 2019 22:36:35 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPi-0005Ax-Gc; Wed, 27 Nov 2019 22:36:30 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6aTfd004526;
        Wed, 27 Nov 2019 22:36:29 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPg-00059i-Rz; Wed, 27 Nov 2019 22:36:29 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 01/10] dt-bindings: add documentation of xilinx clocking wizard
Date:   Thu, 28 Nov 2019 12:06:08 +0530
Message-Id: <54f8c5ce9c84265437734943f68e3ee4c2458bd5.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--9.763-7.0-31-1
X-imss-scan-details: No--9.763-7.0-31-1;No--9.763-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193965961956055;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6666004)(498600001)(70206006)(70586007)(356004)(9686003)(118296001)(6306002)(316002)(82202003)(50466002)(426003)(7696005)(51416003)(47776003)(16586007)(48376002)(446003)(36756003)(11346002)(76482006)(336012)(73392003)(305945005)(50226002)(2906002)(450100002)(26005)(76176011)(4326008)(9786002)(8676002)(86362001)(5660300002)(107886003)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6965;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1082838b-bb89-4d78-0762-08d773cd5113
X-MS-TrafficTypeDiagnostic: CH2PR02MB6965:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6965E2EFBE303EF639B9790A87470@CH2PR02MB6965.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7Qz/ogR44yPtzrSESdCu/uOIrKnr0zTtF99jOI2tlkCuXmLwCv9HWbIj3qh34lyY9XCd/GQu3nhsbqe1Cns5SwtfoYONTmdclMSIXV6gyub/0NQ8iOU8ozA58piDmljrlj4SKhVJwbhoHaEbyuuEmEa6Yes+R7AT1+0dIbot3FcU5qCvp/JW2CBFso1iV5dPcnonw8CyUQnfCg6Taj4y2D1Ni8dbknfHyetsed+8iEGvuOYt3NjN92YmmgH3CpluLYWrATozmqdHoM5Sqgha4bQQywVyXCbGSjmgLXxlum60jJBAmA7xaeI/TjpEUG16CYAgXhFQxl5EH4d50hFtrMtxIQ70VjMpymDXyXQREohABNI+E6HqdOHTzt9OYY+05yUVz4Hv00CLoECIaep62H9+dwOGf/BsEhGEYOl9WhG3m/eHvWisagVvxyLcbQJ49Tbk5/kb0j8a5AIkhW8vZN9euVYypDq2kDYpE8edUA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:36:36.0962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1082838b-bb89-4d78-0762-08d773cd5113
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add the devicetree binding for the xilinx clocking wizard.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../bindings/clock/xlnx,clocking-wizard.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt
new file mode 100644
index 0000000..aedac84
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt
@@ -0,0 +1,32 @@
+Binding for Xilinx Clocking Wizard IP Core
+
+This binding uses the common clock binding[1]. Details about the devices can be
+found in the product guide[2].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Clocking Wizard Product Guide
+http://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v5_1/pg065-clk-wiz.pdf
+
+Required properties:
+ - compatible: Must be 'xlnx,clocking-wizard'
+ - #clock-cells: Number of cells in a clock specifier. Should be 1
+ - reg: Base and size of the cores register space
+ - clocks: Handle to input clock
+ - clock-names: Tuple containing 'clk_in1' and 's_axi_aclk'
+ - clock-output-names: Names for the output clocks
+
+Optional properties:
+ - speed-grade: Speed grade of the device (valid values are 1..3)
+
+Example:
+	clock-generator@40040000 {
+		#clock-cells = <1>;
+		reg = <0x40040000 0x1000>;
+		compatible = "xlnx,clocking-wizard";
+		speed-grade = <1>;
+		clock-names = "clk_in1", "s_axi_aclk";
+		clocks = <&clkc 15>, <&clkc 15>;
+		clock-output-names = "clk_out0", "clk_out1", "clk_out2",
+				     "clk_out3", "clk_out4", "clk_out5",
+				     "clk_out6", "clk_out7";
+	};
-- 
2.1.1

