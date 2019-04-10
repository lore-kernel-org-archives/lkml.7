Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F175420854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WGrGJjOl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="l1C67a7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDJFPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:15:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47940 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbfDJFPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:15:54 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A5Ba69011873;
        Tue, 9 Apr 2019 22:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=WGrGJjOl6tLkQRBK3DoUwG5RVFn7EppogfAsauUl3mg1K/o8SqAuIeKope17/jEzzf0e
 fsi8f/FKjiicmb1E9rQOX2cLonM7i87sIQ1qzU0YkSNn8CM7VsqJTq8+3Z2RcjtouNsL
 wgTjSh6fmVVGgC67KoUL7elYXIbQXIG2NYDjzDIEMDqOJn2EqHBtIOF77OxXtuuHTAGV
 LZvZqeY8VXgQYOlu/z69zq2b2TIsSnvSLysBALmGuzUxTjT3mCrunaPaCnjlrjvjphR1
 CPdqfpFP3ofQ/8Ov/GIy0WXMgP7f5FZ13nLVkaCFQJaIhAIvADp1ebjGuoM1rR/5e40f wg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rr9dfytca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 22:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=l1C67a7bZvEA3o4+w+4lyAKiT8u5OuRg32DQ+gTStLP11fdz5HtxCpf+UmDClfHtgBggKScMNWuCAAIF5xZC2ooimjjSFei5gFe44tKO0MmxGZrsyJg25/8WYSQXBC7XW2dqmlhPgMncWzig9G5QKniNSnzfAtlO4s1YMWIJLvE=
Received: from DM6PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:94::25) by
 BYAPR07MB4711.namprd07.prod.outlook.com (2603:10b6:a02:f0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 05:15:30 +0000
Received: from BY2NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by DM6PR07CA0012.outlook.office365.com
 (2603:10b6:5:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.13 via Frontend
 Transport; Wed, 10 Apr 2019 05:15:29 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT023.mail.protection.outlook.com (10.152.100.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1792.7 via Frontend Transport; Wed, 10 Apr 2019 05:15:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FQQ6012370
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 9 Apr 2019 22:15:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 10 Apr 2019 07:15:25 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 10 Apr 2019 07:15:25 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FPEG017213;
        Wed, 10 Apr 2019 06:15:25 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x3A5FPNc017212;
        Wed, 10 Apr 2019 06:15:25 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Wed, 10 Apr 2019 06:14:57 +0100
Message-ID: <1554873302-5624-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1554873302-5624-1-git-send-email-pawell@cadence.com>
References: <1554873302-5624-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(36092001)(199004)(189003)(336012)(26005)(446003)(4326008)(126002)(476003)(11346002)(2616005)(26826003)(51416003)(186003)(426003)(76176011)(36756003)(47776003)(478600001)(76130400001)(87636003)(316002)(6916009)(2906002)(42186006)(107886003)(5660300002)(105596002)(86362001)(50226002)(106466001)(16586007)(54906003)(2351001)(8936002)(7636002)(246002)(7416002)(48376002)(305945005)(8676002)(6666004)(356004)(4720700003)(486006)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4711;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a8369c-1cc5-4b8d-a466-08d6bd738c88
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:BYAPR07MB4711;
X-MS-TrafficTypeDiagnostic: BYAPR07MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR07MB471190C4E76E1268F7BF6AA6DD2E0@BYAPR07MB4711.namprd07.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YWF68Pxz9ZO8ul4ErP+mWNGA3etnFFDDLfF+gQPJ36/mmy5YKfh92vfuZi+xdIzpA2/u2Z5uefJsKFtGKuIINyBaYX/n18EnS6F9YEUF94WkNGMwDNyn0RO6fIyc5dtFM8p7OaWuWorJI1ujpXSaxNu8xEIhZNZqgMFhzlQZZm24Zd1d1dqJLYiG1adPG49qllO0WIJPi/ShlGNyvnqzyBRMt+M/6cei4g75rxH46Bx7qssKju0RK8xhOcGS2gbpngJIrqkOgXlzMSiYDIB6XtuFoXbg0FRSNX41t+hZM7Shbzkof4lrqwXlp5hjg99CdGvQwNRyILZHg7RCAiXYef30/knsc/eayEiLnapWyMSrRd9olNKOt4AGN9gpItJyldMMc6Y37j+BEFJilM5F+eaNocPDO/GTAChXyvZBVB8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 05:15:29.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a8369c-1cc5-4b8d-a466-08d6bd738c88
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4711
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100037
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

