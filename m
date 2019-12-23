Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A3C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8C206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Kkh1oe0d";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jHmwQD90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLWPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:59 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35344 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfLWPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:57 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGaem027203;
        Mon, 23 Dec 2019 07:16:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=p8Rf0GQGKkRwxSCyMKOKyEUunYpYbHeSeMxZAkg7DAs=;
 b=Kkh1oe0dc9GV03f33IBoNbdV33otBZ6fgd38PY1ygWSVlyK7qbg3Q7EIx6ZRs31BdtJq
 3QxD1cBnNbYCD4QQ9wZjrUyjrNIQ1UZb4O0LEb3LVvtdjvBgPUaGb9xpWiIOlJOHYJjg
 ZGA93S+ups3JOzufNcf1VsSgBALgCEtUgCDD+IAZeUQeV4WF9zkMCS30DpklMsdNTjBa
 dvAp8NSxs00XmNcx751LpAiFRwAmr1qhiz7KEQYg7fotVX8PGpZNjQiJsb+YBT0MvAhO
 FFfbMGIJ+ttaHlbucLXq88tRcPEETxwB/Y6aZfKtR1jdXyfzZ4qUQQ8PP/sJbEPr0PHi Ow== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP9bbu8dl4MdkpGLt+7/S0ruULx8ej2iYl0cmkmUhk28s+B1v7rQOgbL2epFB6F0HgcXeGSRsfIrTodHPwmO/u+Ye3U56r3QouCrts1+O8z/EwpioZWZ6fpq0/kn5EY7Bi6oRhUZkU9blftnYi58xbOsHzLZDNA16GHWHFakUTGKLJ6zZBcB7zaUnsy7mXgDe2Bb5XNcvormYYsayfLYL3KoSuXMIZRDp2AUO9k4VRGB2I1yUnvA2GY1MlwLN3A3cWDTVOUikRo9NWqiqOjHcsDUiBLDQyxZLIFoC63AEmk0qRD8Kl9rM/kyGC0KnG1ov6m8svE+/OYQK0wp7Gd5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8Rf0GQGKkRwxSCyMKOKyEUunYpYbHeSeMxZAkg7DAs=;
 b=mz6L6wM20Yn03IKMx7S2+4fYzN1VI5APxYMozdHi1QHOBAPuKy6UX4RCUkX6lcB4xowYvz5RdDQlxJM/HPNRwalrYE0jzm1jDRE2a4vi+p8d1+DMtEaNbZQ3PAbVIdadANXluGOVcN7FELHCaknwtx/8NrKG29ubfChEtk/JYEypoKUA3WIcLhXUyH9hVpprB8Fky2R1UcZhWr/iBSJ66DGzhTiTRUfCqAgozvt9b8/VbCjvlz98gkPk/BXlVHrBDO7mXMfo0gFda9TAW3xz7Zd8/qeqiqlsg+7xvP0TORnI2QYVzolIf40D1bOQKTY4xorcPzULEzZsTVNDSgsLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8Rf0GQGKkRwxSCyMKOKyEUunYpYbHeSeMxZAkg7DAs=;
 b=jHmwQD90srS1qJ60OTfbDmPbtfWuiTOtFtQmlI2Opxr+F4CgnJXsgipgaEGfRs8sgfBjlpZjuw7wJB+yE1+Pc1+pt3DI+a96qrwrKzgw6inaO0OZizhGR5kcweXXYcsejOqTWe40rynU1qc4T4a683nxS5rmFaaqXec2IHZucSo=
Received: from DM5PR07CA0041.namprd07.prod.outlook.com (2603:10b6:3:16::27) by
 DM5PR07MB2907.namprd07.prod.outlook.com (2603:10b6:3:c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 15:15:45 +0000
Received: from MW2NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::201) by DM5PR07CA0041.outlook.office365.com
 (2603:10b6:3:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT065.mail.protection.outlook.com (10.13.180.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVS093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:44 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:42 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFfnr015143;
        Mon, 23 Dec 2019 16:15:41 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFfrr015136;
        Mon, 23 Dec 2019 16:15:41 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 01/14] dt-bindings: phy: Convert Cadence MHDP PHY bindings to YAML.
Date:   Mon, 23 Dec 2019 16:15:26 +0100
Message-ID: <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(36092001)(70206006)(107886003)(81166006)(81156014)(8676002)(316002)(70586007)(4326008)(86362001)(36756003)(42186006)(36906005)(478600001)(6666004)(110136005)(54906003)(186003)(8936002)(2906002)(26005)(2616005)(356004)(426003)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2907;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35de6737-4057-4229-6dcd-08d787bafbbf
X-MS-TrafficTypeDiagnostic: DM5PR07MB2907:
X-Microsoft-Antispam-PRVS: <DM5PR07MB290710F444793FEF6205FBE9D22E0@DM5PR07MB2907.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRnJeEtvA93CTluTcZzyoFOHxZ1wpcoF2WWUC08isRGG2b7xplUmsxmpgDkl+f9H3UY51cGnrEupzEIwaR2qU5/F+HncG1ZJW9+hIUxKaH1JCcAnakW5c4Jq05ZoNCgibNVwuHp558QJ6Zuy3jrmjf77JdWngS5a13lK6TJgcTHZCKRJ60+RPAgbPn0R96QcLCdbVFFsYdkKzLnw2+rLv3gu8Da0zqn4n3wDvGqGzP6SRemEkDjvdtqsV3erNZt9I8K0+dOCbbIQfEbwSGbz0zaemXeT2yQi2YeUPPNwdkn7KTwcG4Pcu8rNpn/xibygUZ97Kbm6+CFqOvWgF+S+C3gMpf1w3w56jO0nsG3Yw1w8jrT56fsVHlOEGuxcDF14tIyhgRl6miD2wDUurXdrMyeDGZmZ0SWzlXZlsfrt4e9oLFS015/xZeMPNrjHf6Xdo/avMIzklJQs+QxAfwdFkZU37chcOsvJ1517S89SmltPCOSsGfHU44/EpYz54wgwyuviaEBnKEusCJg71k+pEeFWp9C8jithEckGlV1ME1U=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:45.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de6737-4057-4229-6dcd-08d787bafbbf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2907
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert the MHDP PHY devicetree bindings to yaml schemas.
- Rename DP PHY to have generic Torrent PHY nomrnclature.
- Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
  This will not affect ABI as the driver has never been functional,
  and therefore do not exist in any active use case

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ----------
 .../bindings/phy/phy-cadence-torrent.yaml          | 64 ++++++++++++++++++++++
 2 files changed, 64 insertions(+), 30 deletions(-)
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
index 0000000..3587312
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -0,0 +1,64 @@
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
+  reg-names:
+    items:
+      - const: dptx_phy
+      - const: sd0801_phy
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
+additionalProperties: false
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

