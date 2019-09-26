Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92993222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dT5gOX7d";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ikZC83xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfIZIOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:14:47 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30654 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbfIZIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:14:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8Q8Bti2024040;
        Thu, 26 Sep 2019 01:14:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3dH6Y8GITy8desbNPe3WzHJEhCPeLrBOUat9wJaAZrA=;
 b=dT5gOX7doNzsy78glh9sKkAvwt2eXJs6fg9qmAbs56vMQ6ZE97Pbzpf+hgfY5dhGjVPq
 tj6o/Pr5giG8hIV5bkB/DSGXJieYYSagxcvPFxmWl/09Uf0JPoY7UvEvig1voX3wsoDZ
 4aJI3mDEz3OXe2t09icnM4rvhSsrJzKNLcS+JCcWKlZW7ItRYmJacbKj7Ru3rJBo3GEa
 BoQWWJjIbAqaZN+vVuMRH88N4y1E7P5fyBucKKX0/BlGEploc1F1eSXPG7JCv5zyzvK9
 R3SfepGH5+TrLvmu2NyK7RWH1dZ0JNnsydFLGVmckBs5AeujAaLTKN30OV++bip6F5J3 eQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2v5ge0kj97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 01:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEK+wMNGnxGaSPYz7UtKM06MPW4/A6BZ5g+R0+OHw/HK0sMzJEIkuV1GxP2lGfQtD6zWrj9iVbakAN3okihmHR9laq5dme/GHLWEWpBcG1nJawhvyPyJ9rjvIVwNa0UtohfuxcAPwE6NMRi5Xy0ZlEHMeuJeXiNA/2IsgUqBC4RZuyKC8rcQroKaTeGCZn7Q+DhHHAX2PH3tGnHl9gIaClRi8zrjtnMRKA38kTXJ9piBMW/S5MgSfucymqWVTnylcW/HfR9/J1G/ZFq0f0aL3AK3apn2T68FcBuYKKWWWdoNsc165mCSy5woUr5KC6FF1FMoTLP9UwUYpYsi0WYlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dH6Y8GITy8desbNPe3WzHJEhCPeLrBOUat9wJaAZrA=;
 b=O3Q/fdbTYnzPdLXGIFPg70gwVVfAjNZ+GvrYRM2qQ3PWoGsrwrZQ5CXSq4Ac3vPb6B5w0DzImtiGp4R5uyLkyHP645fXV3up+r0R7km8QaomNA26rR+VgNSqmG8ibe6SOf2AxR+JqjbGw7iyuBua+cybGRGuIeTLUygVLcWbjiVQQrzIykhOHk0vyARmAbBTG5jcQN7GsyioVnOmjcbXG1UWeYcpyk+MU+Z9T6grAt+2EC273tNTpbI+5VlnUmzcsSm2mfA1wqHrACsWEPS9NRtzKed56g+Qi1qco8W+YjTKtBgvbk16ToI3hxZJLn0sgJNtMp6CikiVipLol4mIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=nod.at smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dH6Y8GITy8desbNPe3WzHJEhCPeLrBOUat9wJaAZrA=;
 b=ikZC83xMqmVU9YjpEyfQZ/nqM7fBxFpPtm6kdGuZjVliKRM4RU1ZR+3Fx9u2TEPbAFnbCsDtNDY+3PtIER5ZFYWD/3Ch7/fBaeHU7th6szb++kURsYwHLzqgg/jVPCrtVD3PzuFAH1yOz6xBd9bYCtXehBCKqFZHnSfF1jw7p00=
Received: from BYAPR07CA0071.namprd07.prod.outlook.com (2603:10b6:a03:60::48)
 by BYAPR07MB5333.namprd07.prod.outlook.com (2603:10b6:a03:62::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Thu, 26 Sep
 2019 08:14:23 +0000
Received: from BY2NAM05FT048.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by BYAPR07CA0071.outlook.office365.com
 (2603:10b6:a03:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 26 Sep 2019 08:14:23 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT048.mail.protection.outlook.com (10.152.100.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7 via Frontend Transport; Thu, 26 Sep 2019 08:14:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x8Q8EJmC027763
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 01:14:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 26 Sep 2019 10:14:19 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 26 Sep 2019 10:14:18 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x8Q8EIAt025355;
        Thu, 26 Sep 2019 09:14:18 +0100
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x8Q8EITs025353;
        Thu, 26 Sep 2019 09:14:18 +0100
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [v8 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Date:   Thu, 26 Sep 2019 09:13:21 +0100
Message-ID: <20190926081358.24212-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190926080924.19220-1-piotrs@cadence.com>
References: <20190926080924.19220-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(36092001)(246002)(2906002)(8936002)(50226002)(76130400001)(36756003)(11346002)(54906003)(126002)(86362001)(305945005)(316002)(76176011)(51416003)(70586007)(42186006)(7636002)(356004)(6666004)(446003)(7416002)(8676002)(1076003)(47776003)(26826003)(4326008)(5660300002)(478600001)(70206006)(2616005)(48376002)(336012)(87636003)(186003)(486006)(1671002)(50466002)(109986005)(426003)(476003)(16586007)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5333;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55af3d86-3f95-4aba-d3e5-08d7425989fa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR07MB5333;
X-MS-TrafficTypeDiagnostic: BYAPR07MB5333:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5333E0FFE0764E76659C0E28DD860@BYAPR07MB5333.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dUovJ5K2OS5r84SFPDNy2Vp12cA/fB3ZTFBnf+UyDTQ2Jf2fxh+6cY8xc6eL5D0V71gTfmDxsh9tD3P1kIf7Ijl2t6wMCsAhBxoBWn2bVPAuHE7f1xmNAYk7B1jcrEUIW+VPNbG7jgyG+B9EJvdFVFkiKZg7oGYxpqX8uSYdnwKnsqhh8biYHxIZ/AOh9K3ZuIFMbI/R+JBERCGhnrfJSDL5uvyfdqnynPo4DS4I3fBdQC58w5LO3T3GCHD6tHeQ47sf+geQ5ukCDXT0J/ojgToNemG+CCv/JPig1oBQX7YKE5M3Ek45ZoHd1Q1bZ/Gz26N9+w/cQlaa6h3p4rsYUbXQHwrYf9cOiCTYP32l6EALF2NiuBEQXHi25ZTJHv/5gRpyRXUOMcP30nQQvBbxu/joKQXfjBHClXqiUYUW7zg=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 08:14:23.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af3d86-3f95-4aba-d3e5-08d7425989fa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_03:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260080
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by Cadence NAND controller driver

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v8:
- none
Changes for v7:
- none
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

