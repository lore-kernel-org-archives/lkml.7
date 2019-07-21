Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA3CC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F62083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c5b/+oQM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BVCFYelq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfGUSeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:34:05 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11936 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbfGUSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:34:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LIT2eo010946;
        Sun, 21 Jul 2019 11:32:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=c5b/+oQMsZoRGuxrZxR2Qebpq1GBxhfOSHGGtj1aTkKJc+4UzNcK0UMzZq+z8n5/vFNB
 +PsvAcfvK61QzC7/UokRQqmpZZBuCzrkcMlrYHwVDmFPIqdP7NvvZk7UKSp5gmDOY4vt
 pEaqBa4FOE0TzCZ6yXQsDdPmZSola8DqOoLADZWTGZWvasJVqDx+wlwOf31F1iG7tu73
 yn0ygZovGenk2rzCk3k0OjXEf0VDAxNrodSGZ25eoNmepW/I4OerBgEnX5n2sgtPA3PQ
 1guZpzcaV/uF1jriCvzWOufDN4Wmy74BEgtvF4yB+QfanG3VHTSyutp2B++sXluFSsON lA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwc1wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 11:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJRsPq3SOt+XDk4Zsukd8OFRo2rK720CEeWuBBtJYivHhOu6PDRRBTHF/r4BNDREF+W7s6lYljhH9/OJzdcM2xp+JKTpa61jZ4d/dIvqVNA5CtZRQ1kqW/whewU9TSw6GlNXTtLetsn1iWEnkMe28WZAs/NRVo3iqj5RGHuylXmLSO6QXfZqGXnEjXlUjkzhcHSo+6sGw2rCbgKfwNJVJvCWCCbnJaqjYxqoBxh2F9+BgmuWO8Led32xyH3xcu9njo26b/BMGGe3vOlzwSBKIe+ygvYJoMI7MqYAuyqSN6oOBD/jlgAYdFSN+Ff7C+mxgGvuvb38E80qO0HM6hs+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=ivZ1KMntcP7+4u309/MEICYmHWglUK+r1lNRGipvvVs3TCiQSNLSixFfw5IwBuiszHfi2KGTkIZkV9lG5bjPvUJ9YSKfzByc1ekFA/hhuaaLgUPmm/C0z6Q8N38i+2KmUZNzRWZvwjL6TfxX6yAR+ZqVFlaCtqYWytjZufoQAnkxbhpjeAw/8GjBMYdz9i3Ydm1lWE9sZ1uH7Wh7PzCLKiMzHCeyVrKmLZ5NOB6XeO1qGhJ3N8xkId9bfhp2kCfWUcpUTlFv/BZC+fTwoKmLCCYAJ7TaXCbuJjirp8A/JJZICTEYnkxsm51/ZKaexIRc6QCk3eH+7b57NzXevwTmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=BVCFYelq5bUArGYW9vC5UAHE3KUlkbX4ODGYj4Zj0s3s59pLWo/ZAkOS52ZDckZhv3YIxsXq7mpdFN15Xwe5D+sAkoNkZEFqQjqHPRjKui1l0n3N7v5rnQA8wAfZ8OHHVaMlX3WmdgW+ahpSS2cKuM0Rn0NqCOb34GHQUszq6eY=
Received: from BN8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:ac::40)
 by SN6PR07MB4463.namprd07.prod.outlook.com (2603:10b6:805:5a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Sun, 21 Jul
 2019 18:32:56 +0000
Received: from CO1NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by BN8PR07CA0027.outlook.office365.com
 (2603:10b6:408:ac::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14 via Frontend
 Transport; Sun, 21 Jul 2019 18:32:56 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT013.mail.protection.outlook.com (10.152.96.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.4 via Frontend Transport; Sun, 21 Jul 2019 18:32:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWoeU006437
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 21 Jul 2019 14:32:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 21 Jul 2019 20:32:50 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 21 Jul 2019 20:32:50 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWo7H022399;
        Sun, 21 Jul 2019 19:32:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6LIWoJW022398;
        Sun, 21 Jul 2019 19:32:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v10 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Sun, 21 Jul 2019 19:32:14 +0100
Message-ID: <1563733939-21214-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(36092001)(86362001)(2906002)(36756003)(107886003)(81166006)(81156014)(47776003)(4326008)(50226002)(8936002)(68736007)(53936002)(5660300002)(2351001)(6666004)(356004)(16586007)(51416003)(76176011)(336012)(42186006)(426003)(126002)(476003)(2616005)(316002)(11346002)(446003)(70206006)(26826003)(478600001)(76130400001)(87636003)(4720700003)(70586007)(6916009)(69596002)(50466002)(48376002)(8676002)(486006)(54906003)(305945005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4463;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f256c96-9502-4578-2834-08d70e09d920
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:SN6PR07MB4463;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4463:
X-Microsoft-Antispam-PRVS: <SN6PR07MB446363ECCAAE590D9D8D6CF5DDC50@SN6PR07MB4463.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0105DAA385
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0QTY2T9XuEdIsK7mLxtM9wJPcvvzu9hMckBYe6dsq56Lbzf1R5hndho/SXoqQjyVp6cPETS3WZfygsP3Orcvkb/vy5s+hMP5WtdAHh0d6G9XcoYMpnBIPEFhRbCvsmrXaDL/w2/fwUuzqaxFh0wMd8W49jqnSeeFU0hk7ou7bLqoAgGKZ/+e41fRdEdG9z3nXFymd8+jXGf0xDCQreaEnkpnXNE0piNoWzSneHUuJO3izmpoRSuHJhir6ZgJNgo09Y6zvuHRsMjZX/XRRfGD3y5cssxZJHqVMDi3qP/FISFXWBkRsGRROc3aPCwK7If7Wy/dypExEgrHfN9YXrrv5bahqMYVNOb0nIlNQJKko25cWMvKyKjGfBTM4B8FVICOmR/8Td1m9WIHW/+LdKxKtPC8zkAVWvlxxxSdAFk7hug=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2019 18:32:55.2789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f256c96-9502-4578-2834-08d70e09d920
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4463
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210214
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

