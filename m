Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9C2214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="igKFr9f9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cdaR1mpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfIPMsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:48:07 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52538 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732712AbfIPMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:48:07 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GChtwU021285;
        Mon, 16 Sep 2019 05:47:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3d0JMMmUS7DD1SZs/Zm4jluSGkzEG8H+xRUjWofeyuk=;
 b=igKFr9f9ZUGTVSox2rwjutKU96bIYdxl9LUOkfTF3pw0FNveJgpXHKrYjORhrFQLtZVy
 iNUy2Ai/TDDAfv00Mztb0+vXhvUEOjH7SxvUNphBnUBOmCKYTkhciPylV5ltLxypCnti
 zvIBKBC6oUfZkQ4BPKTOpi//fZW0I/XvVwfvGw50ZlYQp1bOLLfb4y4cP9ApVVEeTUAY
 +WFR+CdtanfEVCp/JLYgSZYx6YxbsQHSXpTiPngonxf79G73jPqFOhUj1MFPNSG0P6dy
 /S8+Fy3nyQFihVDB2+dukr3srOIT6NbOT8v3casWtZtTYch/4eFKjJrgJQPbMe3G1rrf nw== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2v0usvq5ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 05:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf1H0v5sCHvx4xJHHPy1UOGW6x/44zQeZc/zaX/V/p5h/lrxmpZP/6s/bTeH4sxz192C7wWk1i9aWjvpJfQIgcMBFGseChTbWct2CueEjE4aAuDfvJfHDFtau9IrJHAs6+2AcBJYSjuza4Qfx2XZt2QMghi2jhvgLW8HLPl8W1zH1dtLcibQGrZW9S1YeAnT4SSLyr9AYRFERMXDnPZsI1pHGlDt8tNirjGFTvYfbH2luO4ONKnL01kgOaq7pXjVt9R4Wpep3gLGsRw+gcq3TyBb6ADuys2MMPYCGpaqpTiDBLaVzSuxqSEJI6ewNIlMJfE7yNFPi4UK3f7O0JBRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d0JMMmUS7DD1SZs/Zm4jluSGkzEG8H+xRUjWofeyuk=;
 b=Q1JeWpJ7UzRnTrOBxDyit0ieIL9pQDl6RcVkAemJ35otJO/XLItqFmF9Kl4z5ZODjA45yuv5KfKDQB0WPlkSwfNc2xQmnKaDwYVKgtA+knF00xd1rbfCXo+/2hPouzCkg9EX3qwhzSRG5zHYtIa5fY0uzodQTxJafim9yOtAkNlwGjZDXk95HbNLMNQIo0eWIp+MP5w+sxMwEsahBVx1DLj/P/OT9n5FxCP+NcD3CZXwDWkF3ABRBXNbTkUYFdw6nKC1UwXyWf76J8cFpSXkHySZ+1OVx4Xww1Tk6M/GWFrGBwbAY0p2DFTNW1CG4V8LPtbfzOHM3qmJpa29h4pyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d0JMMmUS7DD1SZs/Zm4jluSGkzEG8H+xRUjWofeyuk=;
 b=cdaR1mpoKEg+EVX8tauF6GS5R2nR3XkHXMcdg1B3bCQ/f5q/DHGgi+DPLCSclOyelaVZ90PKGmOtDrOGca7fogRolAg5EnZOiTBKCyUCtOI61Q7k5Adm1Ch6+iyMokFNQwoPRk5d9QEVQXgiejKLzMJIBOyIoghd8DaXUTCwlzQ=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 MWHPR07MB3008.namprd07.prod.outlook.com (2603:10b6:300:e1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Mon, 16 Sep 2019 12:47:33 +0000
Received: from BY2NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Mon, 16 Sep 2019 12:47:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT018.mail.protection.outlook.com (10.152.100.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.10 via Frontend Transport; Mon, 16 Sep 2019 12:47:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x8GClTYZ025245
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 16 Sep 2019 05:47:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 16 Sep 2019 14:47:29 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 16 Sep 2019 14:47:29 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x8GClSHt030821;
        Mon, 16 Sep 2019 13:47:28 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x8GClSqO030814;
        Mon, 16 Sep 2019 13:47:28 +0100
From:   Piotr Sroka <piotrs@cadence.com>
CC:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [v6 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Date:   Mon, 16 Sep 2019 13:46:34 +0100
Message-ID: <20190916124715.29941-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190916124342.24114-1-piotrs@cadence.com>
References: <20190916124342.24114-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(36092001)(199004)(189003)(36756003)(109986005)(186003)(42186006)(26005)(426003)(246002)(87636003)(336012)(51416003)(76176011)(316002)(478600001)(26826003)(47776003)(8676002)(50226002)(48376002)(8936002)(1671002)(50466002)(2906002)(16586007)(54906003)(356004)(6666004)(126002)(7416002)(4326008)(305945005)(7636002)(86362001)(76130400001)(2616005)(476003)(446003)(11346002)(70206006)(70586007)(1076003)(5660300002)(486006)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3008;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56320689-a7fc-4b2a-068d-08d73aa40afd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MWHPR07MB3008;
X-MS-TrafficTypeDiagnostic: MWHPR07MB3008:
X-Microsoft-Antispam-PRVS: <MWHPR07MB30081B3C4EA5CEC0E9FFFC60DD8C0@MWHPR07MB3008.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vlLhaKu3ndUJISGjWpxNRjV26S5Mejgf+HDfho0BbNKhbPqwIo4U2cWFQPyLXwW15wnTX2x7j2CRtuQqimy4+4AN1JLsVmHB+PbJ2Mfqykinuez3LVvqW/E3/gcR/lt8WkJ5CzkivKJi8HTLqNYvtH2mefyx6L7M0wM1q74hUX7BUuBaeEskXP49g0+cQ+7iI6o3xKuQSdf+Rb/cZG7FzvH5fvTUxoxhkomy/eDiSklVtTPkPb+tguZIAqWZPVzDh8cxTiZqoOkA5gKSp2C+aLkdepqSi2ZCJElnlS80VWx3yohwYPmgY+r2etlhXHCnXs5zGBsPF+WXRBwqd1c5JHyhDQuX4+mrVcT1KUQM9w4ryiS39Mn9wQBwnlAP2t8SOp9EZzN0aaxjJ8o+dcvv4/hdKCctzBUrisfgbZa5BJo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 12:47:32.9146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56320689-a7fc-4b2a-068d-08d73aa40afd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3008
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_06:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160136
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by Cadence NAND controller driver

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v6:
- add documentation for address-cells and size-cells
- remove not needed space
- put myself as maintainer of the Cadence nand driver bindings
Changes for v5:
- replace "_" by "-" in all properties
- change compatible name from cdns,hpnfc to cdns,hp-nfc
Changes for v4:
- add commit message
Changes for v3:
- add unit suffix for board_delay 
- move child description to proper place
- remove prefix cadence_ for reg and sdma fields
Changes for v2:
- remove chip dependends parameters from dts bindings
- add names for register ranges in dts bindings
- add generic bindings to describe NAND chip representation
---
 .../bindings/mtd/cadence-nand-controller.txt       | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
new file mode 100644
index 000000000000..f3893c4d3c6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
@@ -0,0 +1,53 @@
+* Cadence NAND controller
+
+Required properties:
+  - compatible : "cdns,hp-nfc"
+  - reg : Contains two entries, each of which is a tuple consisting of a
+	  physical address and length. The first entry is the address and
+	  length of the controller register set. The second entry is the
+	  address and length of the Slave DMA data port.
+  - reg-names: should contain "reg" and "sdma"
+  - #address-cells: should be 1. The cell encodes the chip select connection.
+  - #size-cells : should be 0.
+  - interrupts : The interrupt number.
+  - clocks: phandle of the controller core clock (nf_clk).
+
+Optional properties:
+  - dmas: shall reference DMA channel associated to the NAND controller
+  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
+    round trip delay for the signals and is used for deciding on values
+    associated with data read capture. The example formula for SDR mode is
+    the following:
+    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
+    + DQ PAD delay
+
+Child nodes represent the available NAND chips.
+
+Required properties of NAND chips:
+  - reg: shall contain the native Chip Select ids from 0 to max supported by
+    the cadence nand flash controller
+
+See Documentation/devicetree/bindings/mtd/nand.txt for more details on
+generic bindings.
+
+Example:
+
+nand_controller: nand-controller@60000000 {
+	  compatible = "cdns,hp-nfc";
+	  #address-cells = <1>;
+	  #size-cells = <0>;
+	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
+	  reg-names = "reg", "sdma";
+	  clocks = <&nf_clk>;
+	  cdns,board-delay-ps = <4830>;
+	  interrupts = <2 0>;
+	  nand@0 {
+	      reg = <0>;
+	      label = "nand-1";
+	  };
+	  nand@1 {
+	      reg = <1>;
+	      label = "nand-2";
+	  };
+
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 16e16445b88b..94d78f4e29ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3584,6 +3584,7 @@ M:	Piotr Sroka <piotrs@cadence.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/cadence-nand-controller.c
+F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.15.0

