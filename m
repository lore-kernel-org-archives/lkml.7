Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D0C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B392171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="QgIuNipe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407046AbfHIORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:17:40 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:2240 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfHIORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:17:39 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79ED7aR015334;
        Fri, 9 Aug 2019 10:17:08 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2055.outbound.protection.outlook.com [104.47.49.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9a8wg13g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 10:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muGhaN/UEGwYn9Euae0HT4G+wbbG7sw1zz/G6PDu4W/XtyDZa2w1hzvF7zw7CToRJj3Rkc01kDv2AMFn3+ePt/ZY5eRgf3Rq63xEqXoZtf/AxE8nvVS6YEknmfEdvSJGgs7ClCefdDrroJwR25wytifGALVJiLKqNWFGQWTy+soeZ/G6Y1VAVa/E13pVFAq2Ab/0WaH8L/cp6r5WyeCmZModuURquJ8WOXr6YT1zXyHwkPfOOl6WqKQczddqabPho3TKxVZf+5NjtJszwGi0p/OIcf42ZSaKIvgFd/LnIUTaCwQLfYWt52nCzOQEXRqzqjjIwgCeP9XeMULnYem4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk5MOBPzXtAPzDjxEajfGt+rT/TxLRzdbikgJ1pAAr0=;
 b=WNfUiCiCZKxRPKVOGNXAG9JeDqGBgzXBnaNQ/hJxonTPMutjk6zARLyHHdhGqY1f/VTcRRU9QKuYmC17P6QKKSWRQRAe15/TWsg9ySmT8j22cw0Uru7IVx1AR8ZfYqfnPGGhnSbBKFY4eek8heat6czTRAW2aQJDzxB0UmnQEkz0C53cdXv67mPLgu4Gx6rqmb1YUacBdP76GjmhofHSbdaGJBFNCjexQqDlHIpftwY6c8uZNxwbXSP7b6nxnsqqppAgCYJkLa8zGV7sgG79S9WLv/v/4dSSVNvBN7h2z2aVZ30dkt2XVjbHb/CRIK2bTNXrm0aweT3ts2m14fXzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk5MOBPzXtAPzDjxEajfGt+rT/TxLRzdbikgJ1pAAr0=;
 b=QgIuNipeFmeJh/dlEkGsdiG93lcy4pn2E2SSMSLU1VaB1mFn5A3LVhp6k/drSgbhH30JstuDp+a2wglQI5+3hHXN3Qz4ku6UAz+pGryYgFjsZnG9WjC6nhPJ6ocFZGVWjApNmIChM0UrybAn4HZ9Vb2vSfYaLm5pELTji9TwNd0=
Received: from BN6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:405:6f::27)
 by BYAPR03MB4551.namprd03.prod.outlook.com (2603:10b6:a03:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Fri, 9 Aug
 2019 14:17:06 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0089.outlook.office365.com
 (2603:10b6:405:6f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18 via Frontend
 Transport; Fri, 9 Aug 2019 14:17:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Fri, 9 Aug 2019 14:17:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x79EH45S005153
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 9 Aug 2019 07:17:04 -0700
Received: from btogorean-pc.ad.analog.com (10.48.65.146) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Aug 2019 10:17:04 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <Laurent.pinchart@ideasonboard.com>,
        <sam@ravnborg.org>, <gregkh@linuxfoundation.org>,
        <allison@lohutok.net>, <tglx@linutronix.de>,
        <matt.redfearn@thinci.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: drm: bridge: adv7511: Add ADV7535 support
Date:   Fri, 9 Aug 2019 17:16:10 +0300
Message-ID: <20190809141611.9927-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809141611.9927-1-bogdan.togorean@analog.com>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(199004)(189003)(5660300002)(47776003)(48376002)(1076003)(316002)(107886003)(478600001)(2906002)(246002)(356004)(6666004)(36756003)(2870700001)(70206006)(70586007)(50466002)(26005)(4326008)(2351001)(6916009)(86362001)(336012)(54906003)(446003)(44832011)(476003)(106002)(76176011)(126002)(50226002)(7636002)(486006)(305945005)(7416002)(186003)(7696005)(51416003)(426003)(8936002)(8676002)(11346002)(2616005)(16060500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4551;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2025538f-51b2-46e0-2871-08d71cd441c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB4551;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4551:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4551BB7AD4CCA5E2482007EF9BD60@BYAPR03MB4551.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01244308DF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DKBfg1E7nOP3I7FoU3FCIJksqm6G3hTNnrlfcb4KCt6oZzJ1/42LWRqBFhVJ1uRHFPKLrWyck76d8WWYcoMq8sjCA19u/xcCQYu/9x5PWVgPZciaQx6pgzOSCVm8B+kpTMrXYcAB7OAGTVntZOPf5rdEN5hDRswXY2ZBgK3M1yWrgzJt92oiPhraR3g6iiMh9no2rvLfJpZJxyWSLtQIbeDEwAOMx5u/53dv/k0jHzM4kpyVs+/QrQlEEpJShaUhhmYO/kITN50vx/Rjxg6r0b4rDhc/z5q3naQkMq+9zfo21k6ty2D8jKuQsRg2IhAyt8YPaaZzmAecl1FfskJEbZQN1r7kFp6quOJWzb08DcHzpO0SAMDD2G8PGf5YxE2SVsxCXmhk9DCzFq4uYvsslzA7nCWs88rGIHTaJ3r9EfU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 14:17:05.2772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2025538f-51b2-46e0-2871-08d71cd441c1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4551
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a part compatible with ADV7533 but it supports 1080p@60hz and
v1p2 supply is fixed to 1.8V

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
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
2.22.0

