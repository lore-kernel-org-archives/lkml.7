Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF3C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8CF24655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GiFu6jK1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="7oZFwpJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfLKNJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:42 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51960 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729423AbfLKNJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:41 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48ZK020455;
        Wed, 11 Dec 2019 05:09:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=8dPc8HV9TrFMT2zWUu2V0r2dTxDGBHKNWQh8P5/K+sk=;
 b=GiFu6jK1+kokL2WHxngEroM21gO4yYaWIrZL3KADOYLaZIzlZOa5LV3s4El0neIwQZzb
 1TzWrcByL6t+5DiS7NWTCfYG8Dk+a046UKfXB7eERn/j578QBEj4lsCiWkrd8p+T3qzj
 33BHwZqYb2XndC5I5C3/lr0r6jCBOWyaO1osxQafom3Wqe/Vc+8n6mmiNLty9HA8zvaW
 MAh6AGfXQpL3PpFjykVJ1EZvfz/QaB4iHvUQlzEVnMHptWDuOcOqmm+4COYJmWJOO42G
 BhQD/RP0rmPbwdMDzYEhnV7esdMouRicf5A34L2yACvmOzAxlJW48FMYYSOv8dbql+YB Fg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp689-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3oilsVoenDOpucWZhuaR81m3U8lonHYK2wFwSISpVFXUWfgXDrySJE0zue3DM3L/Ky4Ksh9Tu/uFz1CGYTNtBmuG6W71VF08sbkoIFZpqmBR10BlVXdqdL/40wnBuiI/YKGw8SrLhqM1+UxU5+x/y2TbDEP9Rv8Q8PziwZb5+JaXzCpGYRSjfWsHVxeTL76WRpx7XL02RcSKtxRpNQzGxLS6vqD7nHe5XQHxMxm5UEH++cRXX2nUcmmaB5hXuXjz/WVCq5F/VB8K7QpWZ6WDAjvjml//dw2b/9cZJBKKRBmEqNZU3WPgeRWvy6maHTYEe9K4UGtcbqgeD4jQJXfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dPc8HV9TrFMT2zWUu2V0r2dTxDGBHKNWQh8P5/K+sk=;
 b=A+jbwdQSE4jiHr09sQkf9JKJQnhh1VYMx3KCZ8JNCUj0I+emf7nosrpvZB24kiisUqyrl7T9rjdYBE1As2uHaCyCBhRinXmM8OLhPdXOjmJfgXpAuRGJja21gumSethtxOUVhIrNTfd1UWDqlPm5y94nSFJ+W3L8dwUvMl9clYyQEuhE0G6ywigePlvmv+FOFwQ3xoN9r7sxAmzYDDQKY1+eG73z7kFX/WNiooSDaO8+gZgsF4qOgeAr8y+3FZ8tJ/vBwUhPSwvVUYxUNm0J5Pzp2fIJbXG7hEtLSPl+JpR2wRaJp437mqBBmgAoSZ2ll0X3t/QLtYqXUVN1smn/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dPc8HV9TrFMT2zWUu2V0r2dTxDGBHKNWQh8P5/K+sk=;
 b=7oZFwpJL9/VfQat+8X+MhWNeM4Jr6vHsZsBHG0cg2snef3PqKR3VCCQgZsGFUZm2KSuNh1atmZahhaZPzKwOTxwsEmcrzQxuvB5Hv5ZhprrxhUgel5kv/ZCNKnzw7fePAdtKTNRJRBbzfeH2OtPouMz2vdDfUQXBxg5V3adEk+U=
Received: from CY1PR07CA0027.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::37) by BN7PR07MB4291.namprd07.prod.outlook.com
 (2603:10b6:406:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Wed, 11 Dec
 2019 13:09:28 +0000
Received: from DM6NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::204) by CY1PR07CA0027.outlook.office365.com
 (2a01:111:e400:c60a::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT035.mail.protection.outlook.com (10.13.179.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5b006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:25 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Ln8011597;
        Wed, 11 Dec 2019 14:09:21 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9LMV011585;
        Wed, 11 Dec 2019 14:09:21 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 02/15] dt-bindings:phy: Convert Cadence MHDP PHY bindings to YAML.
Date:   Wed, 11 Dec 2019 14:09:07 +0100
Message-ID: <1576069760-11473-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(199004)(189003)(478600001)(426003)(76130400001)(336012)(70206006)(107886003)(26826003)(70586007)(8676002)(81156014)(81166006)(5660300002)(110136005)(86362001)(54906003)(2906002)(186003)(4326008)(42186006)(8936002)(36756003)(2616005)(26005)(356004)(6666004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4291;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 080cb062-a984-447f-aad4-08d77e3b5a21
X-MS-TrafficTypeDiagnostic: BN7PR07MB4291:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4291C604AA12EDD4CE45EF0BD25A0@BN7PR07MB4291.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2XZvNTM7I1qN6dWpsXr2xY0joYL00XX+DSBXwHGmzclQFH0yfvyhCRIO0cQ9x7At8D/bz4qme7sOymHGzzqHv5ovZ/WvI0iAuZ5SjjsuY32eNHTe3qlZAFYpX7Oru1T5MAVA1jYPaKMMZ2TTm40AMa42q6/yFrez/WH6+ZzCtigJKzYhVIBh3XqEbmsMgaMthgYjUPC4n2mdGyzgWNkyDif6X50A4SihYPoLD8tVAMxb+FXXs4p/maQM9UjV2a6tJSrz2PdKqS683LmVc15ThU4s5uB2NUqXpiBXClAV4TjtJKLydpZkx0xveZOfeFWfLXuq4wujhNEqdhOSLBABYqBBggtTzkjR5+Us/nSATk+nYcyTUuCYjmk7ffwzP79BiFtVeG1ay7IdinNfFh7AhrNmkuZ8aRRyZep2FfZ4mFrO/MWS0FH3I0nPKLb0DfpFwWSSPBArNDgXNjgzp0+erzqclXuPcbFL6TnnwZ8U6ercg44Y6bl1pht2HPuLyw/Ng7XjDqxbtoa84JXaVI9e2ZHI0srRsHIYy7Ni8H4YlM=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:27.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080cb062-a984-447f-aad4-08d77e3b5a21
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4291
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=926
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert the MHDP PHY devicetree bindings to yaml schemas.
- Rename DP PHY to have generic Torrent PHY nomrnclature.
- Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ------------
 .../bindings/phy/phy-cadence-torrent.yaml          | 57 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
deleted file mode 100644
index 7f49fd54e..0000000
--- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Cadence MHDP DisplayPort SD0801 PHY binding
-===========================================
-
-This binding describes the Cadence SD0801 PHY hardware included with
-the Cadence MHDP DisplayPort controller.
-
--------------------------------------------------------------------------------
-Required properties (controller (parent) node):
-- compatible	: Should be "cdns,dp-phy"
-- reg		: Defines the following sets of registers in the parent
-		  mhdp device:
-			- Offset of the DPTX PHY configuration registers
-			- Offset of the SD0801 PHY configuration registers
-- #phy-cells	: from the generic PHY bindings, must be 0.
-
-Optional properties:
-- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
-- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
-		  2430, 2700, 3240, 4320, 5400 or 8100)
--------------------------------------------------------------------------------
-
-Example:
-	dp_phy: phy@f0fb030a00 {
-		compatible = "cdns,dp-phy";
-		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
-		      <0xf0 0xfb500000 0x0 0x00100000>;
-		num_lanes = <4>;
-		max_bit_rate = <8100>;
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
new file mode 100644
index 0000000..4fa9d0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -0,0 +1,57 @@
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence Torrent SD0801 PHY binding for DisplayPort
+
+description:
+  This binding describes the Cadence SD0801 PHY hardware included with
+  the Cadence MHDP DisplayPort controller.
+
+maintainers:
+  - Swapnil Jakhade <sjakhade@cadence.com>
+  - Yuti Amonkar <yamonkar@cadence.com>
+
+properties:
+  compatible:
+    const: cdns,torrent-phy
+
+  reg:
+    items:
+      - description: Offset of the DPTX PHY configuration registers.
+      - description: Offset of the SD0801 PHY configuration registers.
+
+  "#phy-cells":
+    const: 0
+
+  num_lanes:
+    description:
+      Number of DisplayPort lanes.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 2, 4]
+
+  max_bit_rate:
+    description:
+      Maximum DisplayPort link bit rate to use, in Mbps
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+examples:
+  - |
+    dp_phy: phy@f0fb030a00 {
+          compatible = "cdns,torrent-phy";
+          reg = <0xf0 0xfb030a00 0x0 0x00000040>,
+                <0xf0 0xfb500000 0x0 0x00100000>;
+          num_lanes = <4>;
+          max_bit_rate = <8100>;
+          #phy-cells = <0>;
+    };
+...
-- 
2.7.4

