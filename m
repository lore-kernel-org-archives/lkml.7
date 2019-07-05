Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FFC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D737216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hqBpG0Yo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dc/1T49m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfGEK6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:58:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:3182 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727483AbfGEK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:58:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65AsFXi009229;
        Fri, 5 Jul 2019 03:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=hqBpG0YoxlvowSjIReBPqAMp+rIJ431Ge7O9pM67H4zwghJj3PtMSMG22PK4IZS65+lF
 z1H5KdjY6o1CuEfQyAItWlow2gbKZ59gAYzpNN7WPke6ljQY5BpdBX4ECkX8DsycjMDI
 6v2AL3HFGmO3nVZwMgHNp4+wfdPCXJLYKpRu/mSF7PcN6xvhuDb6KskizsdV/TBPx4mN
 wDUyHUKmPOha0Z029EawtanDCgW6mFb0i49pJh/B19hcof8uIwRJrqBkH8zFxfksw5Er
 Ka9hymRcqJEEFOA/+nOAGdqu9WSQr7MCZ5ZugHTVkTgBnYnb8KfGqHrEXtix1fxag5eP rQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tgwvj80td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 03:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=dc/1T49mEJb7Eb+ajeXsrWH8cree3SvNRUeOCqNRGTF7st8tc4HKL8CZ2ythbZ8G7Nmjv6E7KLhbTd3YJgF9tqek5jkQfn2NIH0XIaDWBHw8TfxVZispgnTGczkiQrYeDJFNREc3/k9gvVMPjKrBGGOQI+nAoIiXg5OR7b2GUnI=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by BN6PR07MB3043.namprd07.prod.outlook.com (2603:10b6:404:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Fri, 5 Jul
 2019 10:57:45 +0000
Received: from DM3NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20 via Frontend
 Transport; Fri, 5 Jul 2019 10:57:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT009.mail.protection.outlook.com (10.152.98.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.8 via Frontend Transport; Fri, 5 Jul 2019 10:57:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x65AvecX001356
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 5 Jul 2019 03:57:42 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Jul 2019 12:57:39 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 12:57:39 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x65AvdI3017652;
        Fri, 5 Jul 2019 11:57:39 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x65AvdDv017651;
        Fri, 5 Jul 2019 11:57:39 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v9 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Fri, 5 Jul 2019 11:57:13 +0100
Message-ID: <1562324238-16655-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562324238-16655-1-git-send-email-pawell@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(36092001)(189003)(199004)(76176011)(107886003)(486006)(126002)(476003)(2616005)(2351001)(51416003)(11346002)(446003)(26005)(8936002)(8676002)(426003)(36756003)(16586007)(70206006)(5660300002)(42186006)(316002)(186003)(76130400001)(54906003)(70586007)(336012)(50466002)(48376002)(6666004)(4326008)(86362001)(50226002)(356004)(478600001)(246002)(26826003)(7636002)(47776003)(305945005)(7416002)(4720700003)(2906002)(87636003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3043;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66220d1-5190-455d-b47c-08d701379bf1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR07MB3043;
X-MS-TrafficTypeDiagnostic: BN6PR07MB3043:
X-Microsoft-Antispam-PRVS: <BN6PR07MB304327BA5740493C17F4231DDDF50@BN6PR07MB3043.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 008960E8EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hGcJeUPArtOXjmm866NPIYm0TSbgxe8EELNuZobUNDoc8He1ynU+kiL/JKp6D2MObfITVtpKm1xY8+DqpyEaAm25PgbO3a6LTiFd3iLEhN9yOPrJ/waKK3ymH5ql+T0DS9fAec20f0D4usxa9brvj9sp/t+7aSlulkodizOy/t+V/uAVC5dWAN7EgEYa4isG/rNLoBeaST9ar1khIT+fETEN/q/4hLjC3+pU1Lybr7oixiMpVX5dQnLMY3xo/y1yD4YvCt3znT7Ujhj5kl3GFsSWBwJwgb8KZrmREX/LLGklxoAESjl1nmQc01qtHPjfNr3Qr/+MIVOh+Uap8PErr4YfYR/KzJp9DsDOVuiS+BeLYb1JuVIkGzbnTEqOr3h/C5nzcpaHS4qJFPgQ0itCQboSRWGhNSiFAqLUpeDIoJ4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2019 10:57:43.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66220d1-5190-455d-b47c-08d701379bf1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3043
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/cdns-usb3.txt     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
new file mode 100644
index 000000000000..b7dc606d37b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
@@ -0,0 +1,45 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+ - reg: Physical base address and size of the controller's register areas.
+	 Controller has 3 different regions:
+	 - HOST registers area
+	 - DEVICE registers area
+	 - OTG/DRD registers area
+ - reg-names - register memory area names:
+	"xhci" - for HOST registers space
+	"dev" - for DEVICE registers space
+	"otg" - for OTG/DRD registers space
+ - compatible: Should contain: "cdns,usb3"
+ - interrupts: Interrupts used by cdns3 controller:
+	"host" - interrupt used by XHCI driver.
+	"peripheral" - interrupt used by device driver
+	"otg" - interrupt used by DRD/OTG  part of driver
+
+Optional properties:
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+                   "full-speed"; refer to usb/generic.txt
+ - dr_mode: Should be one of "host", "peripheral" or "otg".
+ - phys: reference to the USB PHY
+ - phy-names: from the *Generic PHY* bindings;
+	Supported names are:
+	- cdns3,usb2-phy
+	- cdns3,usb3-phy
+
+ - cdns,on-chip-buff-size : size of memory intended as internal memory for endpoints
+	buffers expressed in KB
+
+Example:
+	usb@f3000000 {
+		compatible = "cdns,usb3";
+		interrupts = <GIC_USB_IRQ 7 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_USB_IRQ  8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host", "peripheral", "otg";
+		reg = <0xf3000000 0x10000>,	/* memory area for HOST registers */
+			<0xf3010000 0x10000>,	/* memory area for DEVICE registers */
+			<0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
+		reg-names = "xhci", "dev", "otg";
+		phys = <&usb2_phy>, <&usb3_phy>;
+		phy-names = "cdns3,usb2-phy", "cnds3,usb3-phy";
+	};
-- 
2.17.1

