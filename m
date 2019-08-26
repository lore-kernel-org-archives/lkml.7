Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4FCC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DC32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DcLlml45";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="y51U5ELn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfHZLUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37410 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730758AbfHZLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:28 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBJL3b004601;
        Mon, 26 Aug 2019 04:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=DcLlml45y9CRn0fjoOOIIM7rbNA54S4gHM/zxCpjoDO+fNlo2kkZCxhTPwveBItsNgka
 aYJKeYgE/xSBSlydJ4SA5zBWuTARDcHPzkyCZU8VBaqrcjVx8D0hR6rPUZ/24wC06FGL
 wEmGFg3w17E2tTRooKB57DJuoJO2psolVBe0Bnlgugpt51RQDAnAk5c6kcqZUzAo3nMW
 SCisD1K0Zkt9LGqsCuwrZKdbwxiwHgzJmH6iJcOnXSYAsj4jATZbBDaidIeF7qobF5ze
 sN98dJBndp7tc8rvZ+XTT5bUCzr1eGZwc7nEUA/U69NVi5uIF5nyGJ1YGTDb6s7Z3WXi 5g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uk21yp6gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQNZAm6JI3uBSG+Fxukb8RpiNAUbC4qQ+F9knENg6RSaG5PcH4qc3nFs/8plGUhTYcOg4k+wZaCrqsd0RpwDpwPdWpo8AW8YcZSfQjDiEFJcr5kPZ51K9Ed5AG/IZZX5JJjeJV+oKb+qfTDpmUALLSoeUd4px5N298b3u/YRaWh0AACRySgaVf6TkOtw/kXwggWrMTfD3C4DXBrdhH6kHlA6YYa09SLrDPPDtepaOkSqP/KMJPwBiRHPQ3JyTMKs/awbGoBNmVbkl2D4xdGGcdt2jBOzXMLch9b+zvh+pMdz0w8oQ0TxsXvcu/+iEWQVGgDtqildZU27A7v+6qK6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=KqtUZCSconHUO2L6C5nrw9UxRadPOgXOvolO8Y9GRmmk+5D3LZNulZO6o9NSo0PsIcB/ip0VQeSyNm+/iNkgIY4i9F/trdMudG7mZYszktRhSquSeSB/M/IyNWsB2mp0RXaZ5NZqNsIEAQDApesDbKIWWRH18B8vFNTrcqPCdJ+qyna0bpTjAgI4ZgEQN0PhHZhIhqtvZMJUa/WMIlnbgazpcCptvwTUzo0zGys6M3XlC65/FsOe3+Vp3pVmTGjsYg1EymWv3CcAEfqc8l1LPLZZsYlEptCCyX6yJBD0/2+5C9L7KX+RW7jo5CIUzEmEqsT7qzBvtOVB+4w060QsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKtH+RhvVQMMFkhWzWocbT+nHQyRdqM4RpQ2yJ2BvW4=;
 b=y51U5ELnipzD0orkQbSRXEh67WVJR7HEcculg11WCiWz1qaclGTnBQHt6JnzPCk4OUpN706UMKpstdfYDN6Q3X93fmMSqk0BVxnUgkGJrNxukQVlsxudziNPO9z8Na+8vGDllVnam9wJJcQb8IrCkPMleTAjXbMRIm+Jn0+KGBY=
Received: from SN4PR0701CA0015.namprd07.prod.outlook.com
 (2603:10b6:803:28::25) by CY1PR07MB2476.namprd07.prod.outlook.com
 (2a01:111:e400:c61b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Mon, 26 Aug
 2019 11:20:14 +0000
Received: from DM3NAM05FT064.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by SN4PR0701CA0015.outlook.office365.com
 (2603:10b6:803:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.15 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT064.mail.protection.outlook.com (10.152.98.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WR001206
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 26 Aug 2019 04:20:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 26 Aug 2019 13:20:10 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 13:20:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK8JF029071;
        Mon, 26 Aug 2019 12:20:08 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBK8E1029070;
        Mon, 26 Aug 2019 12:20:08 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Mon, 26 Aug 2019 12:19:26 +0100
Message-ID: <1566818371-27721-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1566818371-27721-1-git-send-email-pawell@cadence.com>
References: <1566818371-27721-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(36092001)(50226002)(51416003)(2906002)(16586007)(36756003)(6666004)(356004)(336012)(446003)(426003)(48376002)(50466002)(8676002)(246002)(54906003)(316002)(42186006)(7416002)(47776003)(305945005)(7636002)(8936002)(26826003)(478600001)(87636003)(476003)(4720700003)(6916009)(86362001)(4326008)(107886003)(11346002)(70206006)(2351001)(70586007)(76176011)(76130400001)(5660300002)(186003)(486006)(2616005)(26005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2476;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b66d8d2-3420-4029-e27d-08d72a175d77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328);SRVR:CY1PR07MB2476;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2476:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2476BD7F33AD78DB32BAAA6BDDA10@CY1PR07MB2476.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lTcalkE3+fV+Hz2kxFcVPgouANPlN3BjYbM8na9uPuEmTW4qccpUo0yzJWaWvti1h/Utt/OYqYuqcmycgodOnY16qFZmEqv9KGq3lmLEOSoO8ghtMFAwL06OL8h1rCCHTftIUm6ZENvdkBDuMRuFyj/HS9cVri/wwk4rdlaxAhb1PmeSCIf3hqA8fCMWUa/PtlZNKjaS8ntzExRmpYpb/BsEb0L4CW+C8HyaoKqS2zQliZrqU/eBbiD70deXvYnJtGGcEZd7lUNUNL71oeyeW468tdb5r9EyiUEVPUq9HDiw2lXk96yYHyzgjRQxfMj3EZ4G/HuxUDPDA/rqEg8iGZLfFDc4Uvz/TZs25+xCMT1zo1OA4Zdx9VEV5pK4rT0PnkC29uRSOvA7EMdC9QdbiXEc1LzRGEIASimS+qax4uQ=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:13.1582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b66d8d2-3420-4029-e27d-08d72a175d77
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2476
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=1 clxscore=1015 mlxlogscore=837
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260127
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

