Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB6C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD56206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZdM9rG8z";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="khxzs7D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfFEKMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:12:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:55538 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfFEKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:12:39 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 06:12:38 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x559uvC3008600;
        Wed, 5 Jun 2019 03:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=ZdM9rG8ziWPV4xjQM+CfhAbsOToXInSQlBy2csPdgKzfOpbXO/MJLhSn5Oc4EIZNVx1H
 HneMVEcdoopoylqB3XVJXeJbx9shYSGHINAbVo6d+bapkwUXIOEYWGHEaUnxBlUaDMdr
 DN+aWOf8hUbWc3YkwXBYgWib7lphUN9AyFfHGNa7qrO3FIfQl4XM/hrm7lEBRS1xi8ob
 s6f3MD4GAsQi9b3g7yZMeTmywZCIYzxhhv4078pFOZeda6pc6UKBiBU+DMeFuJHaVAIB
 T47Wpt9zgYdOPexIehwpJDu1A0OzJMoqdA96786cqe25/6yIqXNZphIY4U5H7tcI4CCA LA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2sunwry5m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 03:04:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=khxzs7D11Xk3J0JSlawqWKIsalMcoVDHmRVl/ztrby1lPUaeTehtdisEDsJPKj+TU0jyphXoezHs1Mjz2anarwCkbaZcJGzgfcfQjSZTg10okiDJIqAmnWjh4sVBkyYGU3X4y/JpPNqudMN9g+jH0QvrmAhrjwz8IEQx7WhMhes=
Received: from CO2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:100::31) by
 CY1PR07MB2491.namprd07.prod.outlook.com (2a01:111:e400:c61a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Wed, 5 Jun
 2019 10:04:17 +0000
Received: from BY2NAM05FT027.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by CO2PR07CA0063.outlook.office365.com
 (2603:10b6:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Wed, 5 Jun 2019 10:04:17 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT027.mail.protection.outlook.com (10.152.100.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.10 via Frontend Transport; Wed, 5 Jun 2019 10:04:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x55A4Dqq028887
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 5 Jun 2019 03:04:16 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 5 Jun 2019 12:04:12 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 5 Jun 2019 12:04:12 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x55A4C1L017294;
        Wed, 5 Jun 2019 11:04:12 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x55A4CwN017282;
        Wed, 5 Jun 2019 11:04:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Wed, 5 Jun 2019 11:03:45 +0100
Message-ID: <1559729030-16390-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1559729030-16390-1-git-send-email-pawell@cadence.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(36092001)(5660300002)(42186006)(86362001)(4326008)(2351001)(4720700003)(107886003)(76130400001)(70206006)(8676002)(70586007)(7636002)(76176011)(51416003)(11346002)(6666004)(356004)(36756003)(2906002)(16586007)(47776003)(246002)(305945005)(478600001)(7416002)(50226002)(26005)(316002)(8936002)(50466002)(186003)(48376002)(6916009)(54906003)(446003)(476003)(336012)(2616005)(486006)(26826003)(87636003)(126002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2491;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61fb69f9-eabb-4598-e747-08d6e99d2ba0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY1PR07MB2491;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2491:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2491C204544F5C6DAE47B6E9DD160@CY1PR07MB2491.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: e3BTCZ6J6X15GUH96E395ik2Zh1gyWdx1sDwHyWKpNGDxi7F+8X0sXFXHLdBRRsx5fW4u6Hs5kYmF2YIkXKXkie+WGgCxQl+3ldgP7d27zl1NX4JyfT9vN+LKl9f4TRb21iornmUcaUcyiH4fGblerZ3BtENWVhcIw4M7Znre9UjASZaksEQ/LtGoc8Md4owYQ/sWWfRk5/87xHsGEe96KwAFSOmoEwSw8RvPCKct01H5jmrqFc9FKsJ5EfTHayhixQyZZnXPpYXWCqaLVCK7HbVcdlUTf5w5iTfy8pfcOGxx7God9kr39OEdZQziMFupoD849pLBoQLiyWD7VQLA3SWKW+M0DEcHa/5QMi27b7MVGll4MPDsgscGfgljDBZoAxrwh/9EuonXbzWp7x7yE3SX3a1C/Xn3qC9mw84xds=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 10:04:16.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fb69f9-eabb-4598-e747-08d6e99d2ba0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2491
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
 .../devicetree/bindings/usb/cdns-usb3.txt     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
new file mode 100644
index 000000000000..1d2b449e3cb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
@@ -0,0 +1,30 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register areas.
+	 Controller has 3 different regions:
+	 region 1 - HOST registers area
+	 region 2 - DEVICE registers area
+	 region 3 - OTG/DRD registers area
+  - reg-names - register memory area names:
+	"xhci" - for HOST registers space
+	"dev" - for DEVICE registers space
+	"otg" - for OTG/DRD registers space
+  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
+  - interrupts: Interrupts used by cdns3 controller.
+
+Optional properties:
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+                   "full-speed"; refer to usb/generic.txt
+ - dr_mode: Should be one of "host", "peripheral" or "otg".
+ - phys: reference to the USB PHY
+
+Example:
+	usb@f3000000 {
+		compatible = "cdns,usb3-1.0.1";
+		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
+			0xf3010000 0x10000	/* memory area for DEVICE registers */
+			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
+		reg-names = "xhci", "dev", "otg";
+	};
-- 
2.17.1

