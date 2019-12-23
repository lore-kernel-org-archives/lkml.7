Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E08206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qLhiStwZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hzIOqfgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLWPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:53 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46888 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfLWPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:51 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGaej027203;
        Mon, 23 Dec 2019 07:16:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=bAUX9IR2Wahwg70z6LtaaXsaCBUqgDwDbdU2BByF0bA=;
 b=qLhiStwZ7H1WacoAocaRbTJmV1Zwb/Rzl2GqyJlXOrRWgU5Ib/ac1nHMySkwnF5D62wa
 GsKXLykRq/UXoJuXih8gGfrmNy6IVuSrj5OEEuFmGglS8dpC6IZ360z6CP0Bgq358Zl+
 OOk6qQR4j4uxbQnz8RT7xesSptae6AzZDcM0dUrwQMcr6GJSpn37t9Y8AQq6PThCZVCc
 7ylpqrSvscJBwmrKGEeZV7CFfQY7EgP2ggc0i5XfX1segJS3N+ncTrmrIqzJ8nxWbEae
 HSaDosyeK4IPLxsASC3FQtH1PXcJVTJNqrPO/iwJ9pF7cuwRZ84k6jx3lgMmKwMSPg0M yg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/BIY9ZydHxnvIP4FvO5+PgPgc6L6n+r9pNT0iy2AjDt4wZdmummgrGeaeY2NEmiuCDVXCcILer3A9w/zXcbcS36NV3FVlgLHqLqJhmh3TucClmphFvTXr3XIa+jdVocUz8/x3lyrBv2MsJ1kW9QsYV2JUV67thTR4lZ4s3P/QZjL+BCVgdKOINSeUpTYxmk9TphWLQCNPlJ9KxGp6lh/y/cssSlFvjjAP34rA5ltTlztz3vpX7ZY61bLhIXm37bhx0GkZKkKrYbTMx9o2qktaSW9pVbWvGSFjfFNGn4roY79qg0YHUMEAzWR33Eh9akpreFwtNOn8tbqraVqjw0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAUX9IR2Wahwg70z6LtaaXsaCBUqgDwDbdU2BByF0bA=;
 b=arQKKpKnzeJy8SEnQ0RIRBZtfS4Iw4zQq0TRoXmaIY7j51KdA929tX6n/jpJ5P13c9KusyHv+oY/yyV9ekydq1Nh5MH0nds0I2OCr/hcwNPU+AzDLXv+z/6xU4GkCjabowhXcleXMcpv7T0C3iBgyAAvaCqEaDeVBIjSothEBetZccFtkwfP6gdO9mzkBf3UzFOH8dTdTSQhimmObNFu35Zy+ovPORnh7pXutoMd0twbbj5u97nZ7hNkuENU3Mi/VNH5cYMhZr0h60dTWTuuTJMcSNGci3Aat/huIQaUiDTTip5UJSANaYuTtlNTfm42YhhFt+kPEzsvCotTPzSiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAUX9IR2Wahwg70z6LtaaXsaCBUqgDwDbdU2BByF0bA=;
 b=hzIOqfgTKBucDlzy9FbmRHQMCYhc4bGtCYJdAAnLSL2rafRL1PeOagYtSomCM1PB1nSkcQ6mK/M78bso9HMNqfo7Gus19cqO4vfbzdTao6zTS9j2k3vD7ytY2BjoBttNQ40iUudi5O+kEVEg3+ZQfnS2dwGmQyiCzVnfD5YcRoA=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by BL0PR07MB5668.namprd07.prod.outlook.com (2603:10b6:208:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.19; Mon, 23 Dec
 2019 15:15:50 +0000
Received: from MW2NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT009.mail.protection.outlook.com (10.13.180.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVY093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:47 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFhov015188;
        Mon, 23 Dec 2019 16:15:43 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFhga015186;
        Mon, 23 Dec 2019 16:15:43 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 07/14] dt-bindings: phy: phy-cadence-torrent: Add clock bindings
Date:   Mon, 23 Dec 2019 16:15:32 +0100
Message-ID: <1577114139-14984-8-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36092001)(189003)(199004)(8936002)(4326008)(426003)(8676002)(81156014)(26005)(107886003)(2616005)(81166006)(478600001)(336012)(186003)(6666004)(356004)(2906002)(316002)(42186006)(110136005)(54906003)(70586007)(86362001)(36756003)(70206006)(36906005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB5668;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ef7a2e-06ff-4d29-8a31-08d787bafdac
X-MS-TrafficTypeDiagnostic: BL0PR07MB5668:
X-Microsoft-Antispam-PRVS: <BL0PR07MB56682CF865178587B26AE37AD22E0@BL0PR07MB5668.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgUJ/gtxzZev7kVWz0FUohSdmBQ8xrz4u6NLFW3ZtW0BmjkRjXGdEQsVZCYLooXIhWCO//zvBCV5aNXntBpew+fHiCtGXipJJ9Zu9CK/viyvtH/FeWKOz/rp3cAmxJIEvqxpzaGiZ6puxK+OWwDlDJZlOeHqoZVDpraURam+yBr78qpQqaF98pMvdUhiUHkwFO56IeRfTes8RBhCKzBelZn1qraE7ONmXTg9sYIb3SpqE7vTq5PAHNHhDlT5OG8XaRpNOtouUqYGPitnVd2O6JNbysMQO8i0g5qbNqKVGk+RA1RT1jVreysHp8wb6YAnX6soxToyRCF+BW1zmYWlJMFSH6xzB69msCMJwoHhKzvKb5oYwKPbbAxti2YYgHo4qfQcbzTTWCaa3PB2SltNxS+5tkStGhxNhvHcOUS90Z7yjGtEZqZWQ54rVvRb+Ce/8tjh9zxNBcKgErbNrVYblQvZ5nGQhZECMeDlWabf082J0E8YTM3w1Y3wcT9sdbHB
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:48.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ef7a2e-06ff-4d29-8a31-08d787bafdac
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5668
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

Add Torrent PHY reference clock bindings.This will not affect ABI as
the driver has never been functional, and therefore do not exist in
any active use case

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 3587312..907b627 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -17,6 +17,14 @@ properties:
   compatible:
     const: cdns,torrent-phy
 
+  clocks:
+    maxItems: 1
+    description:
+      PHY reference clock. Must contain an entry in clock-names.
+
+  clock-names:
+    const: refclk
+
   reg:
     items:
       - description: Offset of the DPTX PHY configuration registers.
@@ -46,6 +54,8 @@ properties:
 
 required:
   - compatible
+  - clocks
+  - clock-names
   - reg
   - "#phy-cells"
 
@@ -60,5 +70,7 @@ examples:
           num_lanes = <4>;
           max_bit_rate = <8100>;
           #phy-cells = <0>;
+          clocks = <&ref_clk>;
+          clock-names = "refclk";
     };
 ...
-- 
2.7.4

