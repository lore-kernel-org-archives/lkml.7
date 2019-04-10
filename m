Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1AFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1EF20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qJCv+9yW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QN/sCuyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfDJIAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:00:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728942AbfDJIAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:00:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A7unBv001170;
        Wed, 10 Apr 2019 01:00:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=qJCv+9yWmhP8t2wXQohM+uXUXUOLFM1qx46bL4MhMItElBtIiNEqDbfba6fAHFptdOwQ
 Yi9LkNTS65kSXeZoQo3tpPQ8cFdq19hu9TnEaz9B5zrgY0CVv4Y+0jM+W8KtPMII6Z1S
 pVg07cauXUtF5EYkPIoqoSTZ21br39hYz7Vch9ltnsmQCnGUVvcWdXYMz9FtToMvvePv
 u89yG8hjioeM+bOPL0oxJGVMSg1mdRDwUFjVMZFtKFy0G1Bz3jXsCEEDgRMW/odrhNhy
 IpkSl2DyeEhr9v9G1l6OdYdN0Gmh97H63zFzyetyhq2pvVOHcUpPIsOj+4S+ZiIxYv/g KQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rr9dg0cgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 01:00:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPf1wT9AFvNWtTKwGOCGtsZhCbx/yD5HtyjeovmnVhM=;
 b=QN/sCuyv8IEzqccGXjIJyDNHFmHRGdgIquF/rE/hWPi8AWIQFZwim4HlV3MzebaCoAj2ds/L0pKZrWHdLHAuMTICofRjZ0nbzuLgp4Z1jI59BYAUamHJ+zfgGUZsaPDWiLV549ANuScL0zu2L7T1XOYxcSwwanBJETDHs6jDnx4=
Received: from CY1PR07CA0028.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::38) by BN7PR07MB4706.namprd07.prod.outlook.com
 (2603:10b6:406:f1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.16; Wed, 10 Apr
 2019 08:00:35 +0000
Received: from BY2NAM05FT063.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CY1PR07CA0028.outlook.office365.com
 (2a01:111:e400:c60a::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.14 via Frontend
 Transport; Wed, 10 Apr 2019 08:00:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT063.mail.protection.outlook.com (10.152.100.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.7 via Frontend Transport; Wed, 10 Apr 2019 08:00:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x3A80TDN028108
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 10 Apr 2019 01:00:32 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 10 Apr 2019 10:00:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 10 Apr 2019 10:00:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x3A80Sng021667;
        Wed, 10 Apr 2019 09:00:28 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x3A80SwB021666;
        Wed, 10 Apr 2019 09:00:28 +0100
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
Subject: [PATCH v6 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Wed, 10 Apr 2019 08:48:19 +0100
Message-ID: <1554882504-9010-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1554882504-9010-1-git-send-email-pawell@cadence.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(36092001)(199004)(486006)(36756003)(8936002)(2906002)(106466001)(4326008)(87636003)(478600001)(2351001)(51416003)(105596002)(356004)(476003)(2616005)(42186006)(126002)(5660300002)(50226002)(316002)(7636002)(246002)(54906003)(50466002)(6916009)(16586007)(76130400001)(86362001)(48376002)(26005)(26826003)(305945005)(6666004)(76176011)(7416002)(4720700003)(336012)(446003)(107886003)(11346002)(186003)(426003)(47776003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4706;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582f8c5b-0123-4faa-afea-08d6bd8a9c65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:BN7PR07MB4706;
X-MS-TrafficTypeDiagnostic: BN7PR07MB4706:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4706E9A1E74BA2301C321BD5DD2E0@BN7PR07MB4706.namprd07.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Yfv6HqTKI8908XQo8Z9FV1lP/NCqdRTtsUN/9R9pXBGzYnLnlOAFZh+9YygtbUqyfFPCoSw1v6+jOHfPtukTcvrNy9E9JEVINhDl1e5PTAHFkyXZWTUqcjZrkXpmxQCLu4snIjJ97exDpXUdn/gI286/ylzI+0Q5Y9KccK1xU8Tz6kDLphXuQGH6yguV7dtExjfWE5h7aMJfP99LyF/tphEHVTF4O1Cznle3JCbYcSMt0NFUlE5wu3zafeZQ3BxXOvyNuIRvBxAP5M4gL/IpNeEAztGs61OF/boK89gXy93hdAFOdbVWXilsUhFqfAfywAgdtZdabhv9kQn98tZgE/08we1lzMeeL8bIzudargOU7ZYIHPRFpq7bWhQriOT/0K4YJ89AHVOtE7qlrjmNV9uQTx3me/yum9/u1pyufCg=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 08:00:34.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f8c5b-0123-4faa-afea-08d6bd8a9c65
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4706
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100058
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

