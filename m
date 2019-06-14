Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0326CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7BB21744
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RacRPZB6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pbKdAEYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:13:53 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50852 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbfFNPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:13:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EF3R82019686;
        Fri, 14 Jun 2019 08:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EvtLGW0QPy8bCBPyv9XjVufr+PVjVP0YmApk8hR39II=;
 b=RacRPZB6foCOx40nQWGMJgoji2r+YILZGdqquwKm+yzz6Hb0g1LNX5FLYoO7zospny/R
 zCQaNFFTWIEfjHELdl4rvLCeOID+9DI9lMq37ytAzbptlBax5ksSrTE4LIrB3SApwkG0
 i4dXH1pTOn+w1c1MCc/Za6nVknMYcWTICorsfGpQJuemwiGwUiZXYgjR87NQjHAXYneX
 pNi7ka3cLTY+e2v9aXc6TMvr2JLBHKZR4WgAbi1yJn9hx2E6FayswH8wXv9UO1sXi8ld
 Cu5n5g0TAI4DjkCqT6P+qso/SLVEKJ2ZB9fWkPXM33gWS05bq5Hkuj58rTqAAOJKqRjK RA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2052.outbound.protection.outlook.com [104.47.34.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2t33th1w81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 08:13:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvtLGW0QPy8bCBPyv9XjVufr+PVjVP0YmApk8hR39II=;
 b=pbKdAEYb2zPzfzWa9Cx9LSrn9xFCdlBIGZfRZPFcwC5C1eHVxWDcQZsVaPaQBTOu7rKnYpfV5KvjIxOBSjBe1BtYNP01TAHIe66CcseSovpotMc6En4OqKPnbPq6ufHXvRxyWUoR1vsidrmPzwiihawkkZlxsInvXLy2DEk2cng=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by BY5PR07MB6966.namprd07.prod.outlook.com (2603:10b6:a03:1e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Fri, 14 Jun
 2019 15:13:26 +0000
Received: from CO1NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Fri, 14 Jun 2019 15:13:25 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT039.mail.protection.outlook.com (10.152.96.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2008.7 via Frontend Transport; Fri, 14 Jun 2019 15:13:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x5EFDIUh009921
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 14 Jun 2019 11:13:20 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 14 Jun 2019 17:13:17 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 17:13:17 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x5EFDH45006464;
        Fri, 14 Jun 2019 16:13:17 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x5EFDGen006413;
        Fri, 14 Jun 2019 16:13:16 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>
Subject: [v3 2/2] dt-bindings: nand: Add Cadence NAND controller driver
Date:   Fri, 14 Jun 2019 16:13:01 +0100
Message-ID: <20190614151301.5371-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190614150956.31244-1-piotrs@cadence.com>
References: <20190614150956.31244-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(39850400004)(136003)(346002)(376002)(2980300002)(36092001)(199004)(189003)(6916009)(50466002)(70206006)(86362001)(305945005)(107886003)(5660300002)(4326008)(70586007)(50226002)(8676002)(81156014)(81166006)(8936002)(1076003)(87636003)(26005)(51416003)(26826003)(478600001)(53936002)(186003)(76176011)(126002)(2906002)(2351001)(48376002)(76130400001)(2616005)(476003)(11346002)(446003)(426003)(36756003)(486006)(7416002)(336012)(16586007)(316002)(42186006)(54906003)(69596002)(6666004)(356004)(47776003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6966;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97527be1-c8bc-473b-3c44-08d6f0dad802
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BY5PR07MB6966;
X-MS-TrafficTypeDiagnostic: BY5PR07MB6966:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6966525A36486F1ECDC92F76DDEE0@BY5PR07MB6966.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0068C7E410
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oJMaZHg3xjt//VC+Kb+oCN+Yiizz2yYoWvq5054qWCtYS8Azy1UWZh9hX4R0LU14YpatpIcEExBqMVtY09ndFwPcPxB/PyDlyMV2D4XD+ifo8qklMnFEsjSyapmtObGtJxwf9RnzxmzgzLUuoog/gBegQql5r35nzXN/Gtr7uRr+SesC4Fj/btD07E4bj2BoBYCrp+RbvwX5ggrFUf/t+EvEY1IN9NbtmYJKerGK/DI5CHil7gelcEaoLSCD6ZuGjBAEc6NZ1k/FEzxxCAq82zx3+78amPRap57at9ZEYCHW2ndR3wSOebvpqfEo7A30WsOM11AwbQtgd/ASspy2fduaeT4BCn+HCBHSyW012QESMSW3W35UunTDFqcwAX0iMqa86gx3FM9ZIm/QPIX56B198Tm5ADFuZWvKKZkCTrA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2019 15:13:23.2542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97527be1-c8bc-473b-3c44-08d6f0dad802
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6966
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v3:
- add unit suffix for board_delay 
- move child description to proper place
- remove prefix cadence_ for reg and sdma fields
Changes for v2:
- remove chip dependends parameters from dts bindings
- add names for register ranges in dts bindings
- add generic bindings to describe NAND chip representation
---
 .../bindings/mtd/cadence-nand-controller.txt       | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
new file mode 100644
index 000000000000..e485b87075bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
@@ -0,0 +1,51 @@
+* Cadence NAND controller
+
+Required properties:
+  - compatible : "cdns,hpnfc"
+  - reg : Contains two entries, each of which is a tuple consisting of a
+	  physical address and length. The first entry is the address and
+	  length of the controller register set. The second entry is the
+	  address and length of the Slave DMA data port.
+  - reg-names: should contain "reg" and "sdma"
+  - interrupts : The interrupt number.
+  - clocks: phandle of the controller core clock (nf_clk).
+
+Optional properties:
+  - dmas: shall reference DMA channel associated to the NAND controller
+  - cdns,board-delay_ps : Estimated Board delay. The value includes the total
+    round trip delay for the signals and is used for deciding on values
+    associated with data read capture. The example formula for SDR mode is
+    the following:
+    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
+    + DQ PAD delay
+
+Children nodes represent the available NAND chips.
+
+Required properties of NAND chips:
+  - reg: shall contain the native Chip Select ids from 0 to max supported by
+    the cadence nand flash controller
+
+
+See Documentation/devicetree/bindings/mtd/nand.txt for more details on
+generic bindings.
+
+Example:
+
+nand_controller: nand-controller @60000000 {
+
+	  compatible = "cdns,hpnfc";
+	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
+	  reg-names = "reg", "sdma";
+	  clocks = <&nf_clk>;
+	  cdns,board-delay_ps = <4830>;
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
-- 
2.15.0

