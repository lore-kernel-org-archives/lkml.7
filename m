Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E135C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BCC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Q1IShsvh";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="islgdFMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGBNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:39:23 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33396 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfGBNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:39:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62DSmUi025110;
        Tue, 2 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=Q1IShsvh4VUOMDcphpIJU3DvmfnGPSE8RmMoi/HcEHNOWbwZ3MoUs+lPqAP8MjZw8IET
 ruNne233avF17jbSKC1dq21iY1xdCZ2SkiKPE7V4mkIQWMTDr1ugcUYL1ElEl9wAc+tR
 KhBBRrdWo/2jZu18xjnvCYW8riPnbIpHE1qvH+poKzbtlSRGBPh/CScE0IIs2sxqqB08
 0Jc92uHVZx7B3jn6XA8kmhs67J560X4Lv/ff6uRggALjtaCKAGQBNs8rLR9gBfMaz1HT
 UtDL4UonLY3QmpKMFRyBTnlGFMwIiAKN7fHW+SCqlzy102CCyLafKBzLQ/U6RAb4tr/L 5g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2te3jx49rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=islgdFMOz55z7JY58Mu4/BY+6fdBNvJTI8L9DjJesawAxCx5ktf7yxhR7FJ/5HXUUY94pN5EtYFDNXqzESaGpuCFIRNkLpjlVQ9E7fmLhAWI0XfjAKi+C+rQx+Bk44qOWBHMVSh77lSR0A11yeLEj7ed9U658X+FnlgSJsdf8c0=
Received: from BYAPR07CA0019.namprd07.prod.outlook.com (2603:10b6:a02:bc::32)
 by DM5SPR01MB82.namprd07.prod.outlook.com (2603:10b6:4:63::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 13:38:25 +0000
Received: from DM3NAM05FT041.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BYAPR07CA0019.outlook.office365.com
 (2603:10b6:a02:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.15 via Frontend
 Transport; Tue, 2 Jul 2019 13:38:25 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT041.mail.protection.outlook.com (10.152.98.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.8 via Frontend Transport; Tue, 2 Jul 2019 13:38:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKJu032652
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Jul 2019 06:38:22 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 2 Jul 2019 15:38:19 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 2 Jul 2019 15:38:19 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcJln032116;
        Tue, 2 Jul 2019 14:38:19 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x62DcJ9X032115;
        Tue, 2 Jul 2019 14:38:19 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, <aniljoy@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v8 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Tue, 2 Jul 2019 14:37:57 +0100
Message-ID: <1562074682-31579-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562074682-31579-1-git-send-email-pawell@cadence.com>
References: <1562074682-31579-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(36092001)(186003)(2351001)(5660300002)(26005)(51416003)(36756003)(76176011)(2906002)(26826003)(305945005)(8936002)(4326008)(7416002)(50226002)(336012)(7636002)(6666004)(87636003)(8676002)(86362001)(50466002)(107886003)(478600001)(42186006)(48376002)(6916009)(446003)(316002)(16586007)(356004)(70206006)(76130400001)(246002)(4720700003)(126002)(11346002)(70586007)(476003)(54906003)(426003)(486006)(47776003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR01MB82;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17300211-54ac-4efd-1772-08d6fef28ed3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5SPR01MB82;
X-MS-TrafficTypeDiagnostic: DM5SPR01MB82:
X-Microsoft-Antispam-PRVS: <DM5SPR01MB826E40852D0BD6BD3B0EDFDDF80@DM5SPR01MB82.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 008663486A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AtIhh+TXsFACdZZH6FjypTg+qq6leiyk9U7mqydFHEyvA0qSpjzwrkaUc5gIly38jagB+RAZoLcJG2lkxaHHYeN5fSOp62+PeglAjcptGb26VgZj5ZRjszPxtK8/073NSMAG2PisQBfyyyrC3Zgr0v7syrkOCGYWoJG0HDGc3AeJ/xIJOmp1QkxgKEQQNywOdybRkP5LOp1cuVTauJSZOW62iur+AgLFHV9Hk17J3u9ODHE4bWvWmeT2TL85u7PPAQAiY/zm6/rMJfi5Dz5Dt2lHzZkhXzAcoBy5NBXCL3PdG7Chq5jLLZXc/Hi4CVRKkA7JvuWHPr1omT+jT4dqOY3LlvI/UEk+vduw9G3KIvxbnaufe6hSmQ3+LO7QANNyBmPTP5127Ww0SgoQXnZZU8mbPe6lHQ7ugn/0Sgc0brk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2019 13:38:24.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17300211-54ac-4efd-1772-08d6fef28ed3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB82
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020148
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

