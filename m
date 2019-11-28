Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB98C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443A321771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="MaVcDfqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfK1QDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:03:20 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18324 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbfK1QDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:03:18 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASFwWJe013476;
        Thu, 28 Nov 2019 11:02:25 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2whux8b603-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 11:02:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Wykp640PkzmZPQR7TnwUsM9H+NrX6KOO2/QYLfUVXDDWD8cgqtgh5L/+pS1A92AiC1uUbPK8bmp7prCQWMAEEIJH2xiDAZyIbThV/vdVadF/PXtn0mePZacDGHg8FC/3WDhBhZhsQKnIwhU43/Ka5kITP9IqZxv7NWy0yRQ5W4oTNfm6eSS8okSdazAqpaGUgj2DX+ogmwMQrYIwWZcolJiehgOLmH8SHD1QP9STTynT7fuKL45V6gaMHMnANoiDMdnMx+/ePijpDuzQhLJBSf9UgV9xklNqF4dqgRj3AFo7YmxLb1UgTt2JOq6u9owZnj2br+JUT6OIE6UOo3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTS5MjprULROAWlenvx7VJkfS5XKGVLfzC5afYK0ChY=;
 b=ICoByxiiMVWKPC6vw4X4gGpVshTiE2wdvZCyBZZzwPNVIpOynPAudBExo4D5qmAzHjb/18/gSqV4v7fOdQnqhudSdSUI3K2rnrwuahyNP1mS+exfuEZBk5SBPRUgdxVKsYXjgl9tAE3yzFrEPNFSGQG2FZIoOPrm6JxcLfnIbfGWGn9eEvbMXShf9a24xejXQkwA+2XNQoYejUVS3YBnTBS590DiHrWCYOUragoIDj1O9kO0EE0FytIfAAsNqNZiePn0aw8Pvhh+v6VA8HnuhWo0WltHmZCVtLmsycQHc5wT0zS5ocN8+bh/gg35RU1q0AlhSDGARHJ8n2hNLnxucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=baylibre.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTS5MjprULROAWlenvx7VJkfS5XKGVLfzC5afYK0ChY=;
 b=MaVcDfqyOHLJjXNoH4Hjw/h6RxMglD0wfXPXhB/GoyVao++0fBbIHVWArhqAJvbgTWS9BqOGQ+2MuZ6xqCshwb5gW83cNI5homizIJkIpuixkAUs9AjxJ1jBaJPjK/I8KWc5QjZNCoviKKJzMxMO4tuaFKUEXsn1boRgFlmwiEo=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by DM6PR03MB5116.namprd03.prod.outlook.com (2603:10b6:5:1e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19; Thu, 28 Nov
 2019 16:02:23 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Thu, 28 Nov 2019 16:02:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 16:02:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xASG2Cdp004608
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Nov 2019 08:02:12 -0800
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Nov 2019 11:02:21 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <matt.redfearn@thinci.com>, <robdclark@chromium.org>,
        <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 1/2] dt-bindings: drm: bridge: adv7511: Add ADV7535 support
Date:   Thu, 28 Nov 2019 20:00:19 +0200
Message-ID: <20191128180018.12073-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128180018.12073-1-bogdan.togorean@analog.com>
References: <20191128180018.12073-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(70586007)(356004)(1076003)(70206006)(106002)(316002)(2870700001)(50466002)(54906003)(478600001)(2351001)(51416003)(7696005)(47776003)(426003)(446003)(8936002)(36756003)(50226002)(11346002)(44832011)(336012)(7416002)(7636002)(26005)(305945005)(48376002)(4326008)(76176011)(246002)(186003)(86362001)(5660300002)(2616005)(2906002)(6916009)(8676002)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5116;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3d5dfb5-7eaf-4783-7389-08d7741c5ae6
X-MS-TrafficTypeDiagnostic: DM6PR03MB5116:
X-Microsoft-Antispam-PRVS: <DM6PR03MB511679C4A330B052CA9D6A259B470@DM6PR03MB5116.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0235CBE7D0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCtIPMgMhysQWZnN65fvKJpTNaxJltusksXFTK/IkEg7LthJj+7jJ0PCQbZrgzvfZkaYUtpCk9n/gI/MDzuRZHD3fSNOTLJarOFHZThyrTqJFj5sm6uhbD7q3VbcDP3UjVm2U4fIAm6Op6UKlvCHnN9N6wdl3ZQPxHkzMKSMe9oiYsEY1yxAe9dnU/6p4Hi78s6Bc8zbRL83LFc9hjX91XNY5aRUU1S2dGWZa9HOCQhnlmY5u8QO56ny/4FbAof6Hr/ta+kKf303m15+bmDx9xlKJXuaVFXCB8B45Jm+nqvWjKuSXh62vyD8qcrToQzOKxJZ8IAzKGP5PaJovODz+TgaPEGlYBG/87CCJXWHVaqvmec3/jQyIUoG7C5d1K647Ru2BC0HM1ZPCyP545PyulRcNKTKCVgsCAl3QGSSagv/YauzCg2/56d12tlI/bzs
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 16:02:22.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d5dfb5-7eaf-4783-7389-08d7741c5ae6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5116
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_04:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=1 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a part compatible with ADV7533 but it supports 1080p@60hz and
v1p2 supply is fixed to 1.8V

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../bindings/display/bridge/adi,adv7511.txt   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
index 2c887536258c..e8ddec5d9d91 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
@@ -1,10 +1,10 @@
-Analog Device ADV7511(W)/13/33 HDMI Encoders
+Analog Device ADV7511(W)/13/33/35 HDMI Encoders
 -----------------------------------------
 
-The ADV7511, ADV7511W, ADV7513 and ADV7533 are HDMI audio and video transmitters
-compatible with HDMI 1.4 and DVI 1.0. They support color space conversion,
-S/PDIF, CEC and HDCP. ADV7533 supports the DSI interface for input pixels, while
-the others support RGB interface.
+The ADV7511, ADV7511W, ADV7513, ADV7533 and ADV7535 are HDMI audio and video
+transmitters compatible with HDMI 1.4 and DVI 1.0. They support color space
+conversion, S/PDIF, CEC and HDCP. ADV7533/5 supports the DSI interface for input
+pixels, while the others support RGB interface.
 
 Required properties:
 
@@ -13,6 +13,7 @@ Required properties:
 		"adi,adv7511w"
 		"adi,adv7513"
 		"adi,adv7533"
+		"adi,adv7535"
 
 - reg: I2C slave addresses
   The ADV7511 internal registers are split into four pages exposed through
@@ -52,14 +53,14 @@ The following input format properties are required except in "rgb 1x" and
 - bgvdd-supply: A 1.8V supply that powers up the BGVDD pin. This is
   needed only for ADV7511.
 
-The following properties are required for ADV7533:
+The following properties are required for ADV7533 and ADV7535:
 
 - adi,dsi-lanes: Number of DSI data lanes connected to the DSI host. It should
   be one of 1, 2, 3 or 4.
 - a2vdd-supply: 1.8V supply that powers up the A2VDD pin on the chip.
 - v3p3-supply: A 3.3V supply that powers up the V3P3 pin on the chip.
 - v1p2-supply: A supply that powers up the V1P2 pin on the chip. It can be
-  either 1.2V or 1.8V.
+  either 1.2V or 1.8V for ADV7533 but only 1.8V for ADV7535.
 
 Optional properties:
 
@@ -71,9 +72,9 @@ Optional properties:
 - adi,embedded-sync: The input uses synchronization signals embedded in the
   data stream (similar to BT.656). Defaults to separate H/V synchronization
   signals.
-- adi,disable-timing-generator: Only for ADV7533. Disables the internal timing
-  generator. The chip will rely on the sync signals in the DSI data lanes,
-  rather than generate its own timings for HDMI output.
+- adi,disable-timing-generator: Only for ADV7533 and ADV7535. Disables the
+  internal timing generator. The chip will rely on the sync signals in the
+  DSI data lanes, rather than generate its own timings for HDMI output.
 - clocks: from common clock binding: reference to the CEC clock.
 - clock-names: from common clock binding: must be "cec".
 - reg-names : Names of maps with programmable addresses.
@@ -85,7 +86,7 @@ Required nodes:
 The ADV7511 has two video ports. Their connections are modelled using the OF
 graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
-- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533, the
+- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533/5, the
   remote endpoint phandle should be a reference to a valid mipi_dsi_host device
   node.
 - Video port 1 for the HDMI output
-- 
2.23.0

