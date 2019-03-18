Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68947C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC902064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="k7aJQGIW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NpJreZ5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfCRRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:45:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51944 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbfCRRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:45:24 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IHXvmV013524;
        Mon, 18 Mar 2019 10:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=w3ID/WW2ceIwQBMbElRCxOJkcpTWV2d6zvfaHD2krXc=;
 b=k7aJQGIWBlxJQGsRGpidUBwcrrhzqJiwPNtjNSLbXMxIntJfj225Zy1bR3ljRbwrzfNU
 LJccj3E5CX5gnctfwbD0I0ZjeQTk2RiBZLZ+7hqvPB+/zn4eBd1ksBsWebVyb/KTVnC2
 O9dTGIuIdAqeDn4cfVgejyJ41rxTl53Y2NW5iAcc0IJzGLEemxu5jhTb5Y+jMrcAQtYT
 Hb+N9CoA6Ai2PYiqQpOcs9q+1qMhdcnW2POy1MW2fkQt+pN+YV1EOoq08T8UlMEQxYPP
 WP8agBtCWm6ZR+mqKXLTXSIvgfHwN4Iw7cBJK37rjwOUNXdZXu1wuDA0tJax8QY8m0v2 cA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2r8vqx1k1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Mar 2019 10:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3ID/WW2ceIwQBMbElRCxOJkcpTWV2d6zvfaHD2krXc=;
 b=NpJreZ5DwaaVGWl8EXiV2Ll2/OvTqfTj7awLAG+5w3x07Dk7QEsAJYaynXNQOKLfRb9qH7D/RxBT6ZH39EWNHVWAfwYnIKgx0kpZm+1fqDvORXMa1xwqi6DvxjIxylQ8UwtrqxUQ1CKh4zpboecgJaE2YBsNKLdgDBn9It3ABNg=
Received: from SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) by SN1PR07MB2303.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 17:43:15 +0000
Received: from BY2NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by SN4PR0701CA0014.outlook.office365.com
 (2603:10b6:803:28::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 17:43:14 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT013.mail.protection.outlook.com (10.152.100.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.2 via Frontend Transport; Mon, 18 Mar 2019 17:43:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x2IHh8mZ026513
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Mar 2019 13:43:10 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 18 Mar 2019 18:43:07 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Mar 2019 18:43:07 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x2IHh3Jl008198;
        Mon, 18 Mar 2019 17:43:05 GMT
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <andrew@lunn.ch>
CC:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <rafalc@cadence.com>, <piotrs@cadence.com>, <jank@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v2 2/3] net: ethernet: cadence: add c45 PHY support in MDIO read/write functions.
Date:   Mon, 18 Mar 2019 17:42:28 +0000
Message-ID: <1552930948-6755-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <20190223152540.GE10693@lunn.ch>
References: <20190223152540.GE10693@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(36092001)(199004)(189003)(6666004)(54906003)(356004)(336012)(50226002)(2616005)(68736007)(7126003)(476003)(126002)(11346002)(446003)(86362001)(81156014)(81166006)(305945005)(53936002)(426003)(486006)(47776003)(53416004)(105596002)(76176011)(316002)(186003)(8676002)(16586007)(5660300002)(77096007)(26005)(2351001)(50466002)(106466001)(48376002)(107886003)(2906002)(7696005)(36756003)(26826003)(51416003)(97736004)(69596002)(8936002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2303;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc83f99c-e13e-494e-99c2-08d6abc932b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060);SRVR:SN1PR07MB2303;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2303:
X-Microsoft-Antispam-PRVS: <SN1PR07MB23039F38B08DE8525AA27A47C1470@SN1PR07MB2303.namprd07.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dtJpvEgViCyA38J7xGkhG6EA0jvUynDHr+j+AaFwLfmxbsiKgVOfZIUZ7rxC+y5G+G7yJTYTh2p9QqZeg3nIoAWWa5dGSQxvCF6kJHxfFdlntrf4b3cvojdwRl6UMP1kiplfhlHOwb476cAiTXiE7v7GcL6m4X/DwVgruMwVeTI9bN6K7R8dnwugKy8UJFW6/3ze2WasjBi68R868ohk1orf4WmfLWRsqSIHw0j8Hz9y4M0o4V1pOSLr8umgy0XOZUL9Qq30FTUDFercODvCpOc0tEWShGxIioZXc8TF5S2h7ApmIpwLAeve5/iuWjMckglVBUER6UdqQ+GuffHORvGcOXWf/W4FYAyT2PKlWyn+iTW/iBJWAqTSjRBWgNJjjAZcSQDbz/QCyREdAY8+8rDJgLK961X1HfPyWoJc4JU=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 17:43:14.4399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc83f99c-e13e-494e-99c2-08d6abc932b3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2303
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending this patch again, but I didn't sent previous
email --in-reply-to last comment on v1 of this patch. So
rectifying this mistake.

This version 2 of patch to modify MDIO read/write functions to support
communication with C45 PHY in Cadence ethernet controller driver.

Changes:
	1. Added timeout
	2. Removed unused operation macro MACB_MAN_C45_POST_READ_INCR

I thought of starting with relatively smaller, independant and simpler changes.
This patch is independant of patch series and looks relatively straight forward
with aim of supporting C45 PHY for support of high speed PHY's.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |   14 +++++--
 drivers/net/ethernet/cadence/macb_main.c |   61 ++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index acc66a7..d25fa03 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -629,10 +629,16 @@
 #define GEM_CLK_DIV96				5
 
 /* Constants for MAN register */
-#define MACB_MAN_SOF				1
-#define MACB_MAN_WRITE				1
-#define MACB_MAN_READ				2
-#define MACB_MAN_CODE				2
+#define MACB_MAN_C22_SOF                        1
+#define MACB_MAN_C22_WRITE                      1
+#define MACB_MAN_C22_READ                       2
+#define MACB_MAN_C22_CODE                       2
+
+#define MACB_MAN_C45_SOF                        0
+#define MACB_MAN_C45_ADDR                       0
+#define MACB_MAN_C45_WRITE                      1
+#define MACB_MAN_C45_READ                       3
+#define MACB_MAN_C45_CODE                       2
 
 /* Capability mask bits */
 #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ad099fd..17072fd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -345,11 +345,30 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	if (status < 0)
 		goto mdio_read_exit;
 
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_READ)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(DATA, regnum & 0xFFFF)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status = macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			goto mdio_read_exit;
+
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_READ)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_READ)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)));
+	}
 
 	status = macb_mdio_wait_for_idle(bp);
 	if (status < 0)
@@ -378,12 +397,32 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	if (status < 0)
 		goto mdio_write_exit;
 
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_WRITE)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)
-			      | MACB_BF(DATA, value)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_ADDR)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(DATA, regnum & 0xFFFF)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		status = macb_mdio_wait_for_idle(bp);
+		if (status < 0)
+			goto mdio_write_exit;
+
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			    | MACB_BF(RW, MACB_MAN_C45_WRITE)
+			    | MACB_BF(PHYA, mii_id)
+			    | MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			    | MACB_BF(CODE, MACB_MAN_C45_CODE)
+			    | MACB_BF(DATA, value)));
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_WRITE)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)
+				| MACB_BF(DATA, value)));
+	}
 
 	status = macb_mdio_wait_for_idle(bp);
 	if (status < 0)
-- 
1.7.1

