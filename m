Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC522238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UI9D/ZJ3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MVorw9uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfGYPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:00:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44782 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388491AbfGYPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:00:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PEvjla001791;
        Thu, 25 Jul 2019 08:00:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=RKSmBSFcduIj50cvykuC55ARP0U2FL40+czvJ7Gdhuw=;
 b=UI9D/ZJ3b4jDRP3RiiO3Kjv8yn8pGbx+DlRKecisKYY/IJpZG3NMWXiNu1ADOpNcf4wT
 5qdvW704n/BaiucM+7c7P6j0VClejcFIr87QeqJJfO/w92Fe/VfhLbkeV0rU5CC2cxVW
 VNPpp2J8fnxZMs3wo/Vl8xTZtFgt2KVLyHhcIhjp0ThNfxYYgwcKWOYN7tXbkkaxpx8u
 J1VXv0SiWzvSM64TXRMMGMGQBx3yPjxdFP6GXaFbP/DToYdxEIpr9r21Tfmmf33tpyS4
 P9LEyTuGuOA3RKukreG6ueZTgj0pHGvhUeYlBVviPkRQQAaZSQquuvccVFJfo/XNuUdG 4A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ty9h4h4y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 08:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrz4MvVHYJiBNzT0jbNXYUEvAt1pPXMQN4/8CkAecbBldu8cSITI3InDgI0X5d+oWbmyH4KmVbuNrI4bTpRtUNo5B/sMzrKMGjNlu333vXgMMXBeZTbneVcIuow4tP5bjVe8dj5wILvMdPUv8cSra7+1lRg0Q6Mw/lDrhMjLNVF9g42wu3xF/fMH2b6gwUQDuAmE89RK03oz/leyhAR2OOBCI6stLPODoc8qYTzUWpqYjy/+XfD/34bBJNYLiIk0HVN8UZLyDaJ9SvPMReVIV5p+i+Q2FBrJKP49vNenBNiHx5eV1Fua7FgmF62wHaRZPwd7fGXr6tgUZUESq0MhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKSmBSFcduIj50cvykuC55ARP0U2FL40+czvJ7Gdhuw=;
 b=gr+KEc8MGqmeo1q4AI5ERYwutfj165qVWxCRGFxjONaFEA90AqtR9vJVfOQdF5rsoNlJfxeGEswh/7zruny3Q4EWRyumEfO6KRsM93rtQdxeaJyMB6d2/3BtCRwumeT/ZeaMF9FavFniUBFU/gFeNiZFtm4ubHv9nrF0wCi09SxcLcDxX9IpgLoO9vqcWOkCGKqUR9gfh86B9hyXZYAeFV8nRVQ7LJ+LwGGQjW29yjBS+RccnDzDDKjSfZQ4WSlE2shK+WhBx6OrMmRRegtTlC/OdSh12f5/z81MvjcPXreElCwlQaYrE4mx5R7cTKDdUzIp4tQNBmT1eJyGSE4dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 158.140.1.28) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKSmBSFcduIj50cvykuC55ARP0U2FL40+czvJ7Gdhuw=;
 b=MVorw9uBp/KNpOSTQUAJb0GL0LTXOExPNmuNoh4Od/8YJB1HubZLwHbq+COojpI4PfgfAHI5IUK802wCr8q8x6Lyy55j7PY7upSFGKnojec0mSujQxk5FXyQZC3ZpbrjhuyvWexRrIDNwN8G5FrapXwJa6yQWpKIT9MJM6nkLNc=
Received: from CY1PR07CA0038.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::48) by BN8PR07MB6964.namprd07.prod.outlook.com
 (2603:10b6:408:d6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Thu, 25 Jul
 2019 15:00:04 +0000
Received: from CO1NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by CY1PR07CA0038.outlook.office365.com
 (2a01:111:e400:c60a::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14 via Frontend
 Transport; Thu, 25 Jul 2019 15:00:04 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT040.mail.protection.outlook.com (10.152.96.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.7 via Frontend Transport; Thu, 25 Jul 2019 15:00:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x6PF01CL024431
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 25 Jul 2019 08:00:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 25 Jul 2019 16:59:59 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 25 Jul 2019 16:59:59 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6PF00nn014162;
        Thu, 25 Jul 2019 16:00:00 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6PExxkm014160;
        Thu, 25 Jul 2019 15:59:59 +0100
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>
Subject: [v5 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Date:   Thu, 25 Jul 2019 15:59:55 +0100
Message-ID: <20190725145955.13951-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190725145804.8886-1-piotrs@cadence.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(36092001)(199004)(189003)(50226002)(1076003)(446003)(6916009)(107886003)(7636002)(305945005)(186003)(11346002)(8676002)(48376002)(126002)(7416002)(426003)(2616005)(476003)(486006)(4326008)(50466002)(8936002)(246002)(87636003)(76176011)(478600001)(316002)(47776003)(86362001)(336012)(54906003)(42186006)(2351001)(36756003)(16586007)(5660300002)(76130400001)(356004)(70586007)(70206006)(6666004)(26005)(2906002)(26826003)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR07MB6964;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb91d21-ffe2-4454-a650-08d71110c668
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN8PR07MB6964;
X-MS-TrafficTypeDiagnostic: BN8PR07MB6964:
X-Microsoft-Antispam-PRVS: <BN8PR07MB69645869615063D89020E537DDC10@BN8PR07MB6964.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0109D382B0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vePt/Q2NmJFkNPkb7jAlSkS5XpX1Kh42th8/zqSEtD2EJT4fncac9pjoo4R9+xkn0fRvPOqRJRh+gGIpkuxgo/cvqSz7AJ81uXxIQ9FDoEv5kbA/Y567UCmpvI3/25RuT27OgooWwIky4qLZRRkUJ2th4BAzVxEnnCemWO6mS7ItL1sgi1Qcgl4E9CwoDw89vrRk4TpTLid9U1ZktK5m3PhlXx+1bvmqzDuaArQpx14RxNGpI5O4pqjjvREJYwSSRtcLwnR4vvu1lP1Wap2H5fxb/+W7eglzTgNbdkuQHYoSE/V5DDIEheSnjIgyz+xw2vvqcU0BBtoj2KCFHcWqMugy7QsbBSCcrTQd/c9l/533susvMdt5ZA+R/EqnJAtX1nf5T6XvPH7VOwhOmMmmmAudostI3tGaoKC6qnTSKdE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2019 15:00:03.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb91d21-ffe2-4454-a650-08d71110c668
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6964
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by Cadence NAND controller driver

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
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
 .../bindings/mtd/cadence-nand-controller.txt       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
new file mode 100644
index 000000000000..423547a3f993
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
@@ -0,0 +1,50 @@
+* Cadence NAND controller
+
+Required properties:
+  - compatible : "cdns,hp-nfc"
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
+
+See Documentation/devicetree/bindings/mtd/nand.txt for more details on
+generic bindings.
+
+Example:
+
+nand_controller: nand-controller @60000000 {
+	  compatible = "cdns,hp-nfc";
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
-- 
2.15.0

