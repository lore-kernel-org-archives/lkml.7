Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18EFC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950092080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EDgItxgi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tBEpfni/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfFYPWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:22:46 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47536 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728946AbfFYPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:22:45 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PFIeN5020897;
        Tue, 25 Jun 2019 08:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=axsMklROpfZit99IlYQJrDgrcEftVzRl/BKG3fJNoU8=;
 b=EDgItxgiAE8NcgaQ0XMESqBuXirPvP7v6H6MQyhOx2/ms9Xjs50KyQdBZ2eHVwbb/cBi
 ENCdD8IYwKunWgnGljikNTkv5JfdfsIWyvugco+j96PROYkskg+SZKvYPRhDsmX7ClBf
 HrHgSw8Ed2314ex5U1eItjOFudIMRrLmF4VVJCHRG9oGutTNGFBxYSfwOUAXjwuWlU3F
 do4t1LwkopPd9xUwZFyi2gLWePRuGM1tq2xhz8LjKOqe481KB5/K15gHWRahAnf5k4k5
 LrtaY1o4XyPVQSod3ZmOQPP5VIT+JEFl9iQRnmO/fYHO/ZJsvd9Se+Y866w7iAaFN7kq gg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2t9fwtx6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 08:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axsMklROpfZit99IlYQJrDgrcEftVzRl/BKG3fJNoU8=;
 b=tBEpfni/z83ciVRITG3pDiP038dFDEeN52PPVyLHlTERsNRMAAlc2Q9ah2SwWu4SNacNcRw3RKj7AtdMuK9TPexbPcdEZIdNJXwY5cfC/B9Kb7I2L97wczuGT0lfL/BGgbSCh1ZjiY+Wvsj/VapL3HM8eI/L8TTx0SxxJkGl5NA=
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by BY5PR07MB6968.namprd07.prod.outlook.com (2603:10b6:a03:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 15:22:31 +0000
Received: from DM3NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 15:22:30 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT051.mail.protection.outlook.com (10.152.98.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.6 via Frontend Transport; Tue, 25 Jun 2019 15:22:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x5PFMRWs001097
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 08:22:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Jun 2019 17:22:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Jun 2019 17:22:26 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x5PFMQqm021221;
        Tue, 25 Jun 2019 16:22:26 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x5PFMPuJ021210;
        Tue, 25 Jun 2019 16:22:25 +0100
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
Subject: [v4 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Date:   Tue, 25 Jun 2019 16:22:18 +0100
Message-ID: <20190625152218.21102-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190625151559.15270-1-piotrs@cadence.com>
References: <20190625151559.15270-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(316002)(336012)(6916009)(16586007)(446003)(11346002)(2616005)(426003)(2906002)(2351001)(486006)(87636003)(305945005)(478600001)(476003)(26826003)(126002)(47776003)(356004)(86362001)(6666004)(36756003)(7416002)(1076003)(246002)(7636002)(50466002)(51416003)(50226002)(5660300002)(186003)(8936002)(76130400001)(48376002)(70586007)(76176011)(4326008)(8676002)(42186006)(107886003)(54906003)(26005)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6968;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a7d20b-afce-459c-867f-08d6f980f06a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BY5PR07MB6968;
X-MS-TrafficTypeDiagnostic: BY5PR07MB6968:
X-Microsoft-Antispam-PRVS: <BY5PR07MB69689C3E196B069DE398E7D7DDE30@BY5PR07MB6968.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8nv+0DLaJ5amrSDzqs62STJQ9GEkinSg499+TfDS0o81k5DMoDUbyKlh3GPzG5IhrDvFqgVVnLFb5qX98b1/MD2de1HSJSCD2Owsynv+F5br+3r8nytOV7gPn7nhEYKDKDrxPNXXX8sXqn6oS4RPSRhbsY/A+hp68ie2n/k9oKEQ4tJw0o9YuPylOTwsUb6F2sqS+AfwVvbgfFzWA3jyZSSYHmYeq8LB7KoMikYajibTXAaEtYpGfkWp+3LNchBKOQCS4AY35orIRLkQjsXQ4ANDiwylCXCx3TzT6sB8QcgEKrNtBjqShnNjS0Ppr0R56FirTiFnM5XOsbjNCjgHVkJyzfG0hvhz4mjs364Qw2H9WRJpkh/x97jItbsoUD2v4G3iCUuXWh6RNQTmtL1NBcLlI1eWrNMaw3KNV/w56HI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 15:22:29.7792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7d20b-afce-459c-867f-08d6f980f06a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6968
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by Cadence NAND controller driver

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
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

