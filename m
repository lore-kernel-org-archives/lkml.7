Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7DC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE74C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wed33W6+";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wed33W6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLXRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:38 -0500
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:63041
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfLXReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5Js54wztOxzF/TQea784rwrZsTPXu/ICpATsm64vvI=;
 b=wed33W6+QfV35Mh2izYSx6mYU7HrIXJh8a6mKxmPMoXm792QvHKHYxetu8TUIZriCq4COloUKs7+dkmGqJ91YsjCMhFuCNtxqp5uXqgNCG0Fl20F9RVZK+b7NGjKGAtiFkDk4+7deXfSIx8aeN+J9HrtWZQNv53yt3Tspc7V46s=
Received: from VI1PR08CA0087.eurprd08.prod.outlook.com (2603:10a6:800:d3::13)
 by DB6PR08MB2631.eurprd08.prod.outlook.com (2603:10a6:6:23::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16; Tue, 24 Dec
 2019 17:34:30 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0087.outlook.office365.com
 (2603:10a6:800:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:30 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:30 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Tue, 24 Dec 2019 17:34:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 51c5c14281955d99
X-CR-MTA-TID: 64aa7808
Received: from ac55e6cc70e7.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1D37A69D-E821-447A-BB03-34533D11DBFC.1;
        Tue, 24 Dec 2019 17:34:24 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ac55e6cc70e7.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S40pI8K/2bi80x5aGnlBRmr+VuAxXBoKF4OUeAST0FbaAMaZ8bYqPMf/2wR5ItLamdp0p+urgsocu+3x4pQfR1KVU+iw3kvYxBKetJkmogrdGBy1CIfawMyPhfOe+XBhqb4CCfY+R4Cdprf3Ywx8MXV6+Dh8cpEBf/K3EtOalwoYysfc0A2zYNnUjYXdLbrWrr2X7CmekeuNxoEodUAieItugA+EURnBKYe36Cu94qDwogrX3KBrpb7119Yyg3z3w+TqZoA2s8oSXBhCBqtVoPDG9jThEl+N04YlZ+ovqlulgGRuK3AmDmIL5zNGFlN1ZcTxz739WzIUrjjWE9Of/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5Js54wztOxzF/TQea784rwrZsTPXu/ICpATsm64vvI=;
 b=NgYB7oaqX/+/cSMs599/Hf3TO1RWHi9iCTKoW8nXPKYPrThYg/gRbHBE40zMo0wYhJ62XNsZcO+i5pWVMgNK1F7ED0ThIgX5C2Oy5xaji4OEU43UUHITpDUe9+buwnZ7k3GGTWz6y1mCEDUm3zH7EW623dvcd9kCMdtyQIJRAPYmwb0QZVHoLS9YoFyfY+Xk99VOErgteWLYdN21xX4uFB6Qq1+10YdJzvRw4zxsb+zZBF2uwn52x1MlI5wJga4vQ4sfBMOy8ersak855HekonNazTEa9JFruIcNZClmD5MNo+rXxhHLjz4uB+U2MXVJnAJeu3Z+Mht8+Jlh33168w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5Js54wztOxzF/TQea784rwrZsTPXu/ICpATsm64vvI=;
 b=wed33W6+QfV35Mh2izYSx6mYU7HrIXJh8a6mKxmPMoXm792QvHKHYxetu8TUIZriCq4COloUKs7+dkmGqJ91YsjCMhFuCNtxqp5uXqgNCG0Fl20F9RVZK+b7NGjKGAtiFkDk4+7deXfSIx8aeN+J9HrtWZQNv53yt3Tspc7V46s=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:23 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:23 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/35] drm/bridge: analogix_dp: Stop using
 drm_bridge->driver_private
Thread-Topic: [PATCH v3 02/35] drm/bridge: analogix_dp: Stop using
 drm_bridge->driver_private
Thread-Index: AQHVuoBgZ7jOh/XVtkGuR+n5m9qjRw==
Date:   Tue, 24 Dec 2019 17:34:21 +0000
Message-ID: <20191224173408.25624-3-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c1074cd-cfbc-4dd2-3b53-08d78897885e
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|DB6PR08MB2631:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB26313BBBBABAE59CCDE985938F290@DB6PR08MB2631.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;OLM:1388;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5mg2fOEJi/wmJvGKqPvL3mRQVXqKgG01pG8JUo7eZBOMv9YMxn4loA2G+i2SbvtSMl80G75avJ8Wk9PoMSIHYxXwJsPZc4+0i/s+34Hjkt7fmwio1He3IqHky4IiBChkHW6eVwQrUmhJ2PBxZuRnvm6dlu9shCzsB/EsaNX59AqBU1l+dTaJO00P52kUtjrUXwMioM8A/mrQfEiAwnry2X3kG8kJl89bz6L0FEYz3M3bVMAGooSRwdlgFT1E7JaCYhuPLkTAMPqg6R49FiC/r+Uku37MtH8W/38gEdI3dFsEy6IO5yX1b543J9fGE7ytOVc0LayS93qTCS9IUH6y2VNR+D/i1AqcXCm8rKthA8hO5Evx3Q8WktA0i2dEYV3MGPyuAzNdRI63nlWiXqR05B8NQL06fv74OUUyKKbXAtXCdXBPpIfBoZxyJRLjvTo7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(2906002)(4326008)(186003)(8676002)(6486002)(81156014)(81166006)(76130400001)(26826003)(316002)(5660300002)(1076003)(478600001)(6862004)(54906003)(2616005)(356004)(70586007)(6512007)(70206006)(8936002)(26005)(6506007)(336012)(36756003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2631;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b485abaf-c70c-4649-96c9-08d7889782dc
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vkq/Wd/86mItk92R6jrTDLC8ye8gJvzN4jBLjygpS+aVw5gO2NBRdLLWqZHW3SClfIs/Red9IGUKJI+o3pqIGIubIuJeKzykUWV9jXTtYmA9iVbX3AI6dv3WpkN65sj1iBcPAYW641Jqn1LzYZMFW52bTWx/D52AuSrTjwSqDz6Zcs0M3fzxiM/PXoZIzy+MNc1Kp+gpENHHoSquL7NPVOslaiOVShytrn5Ys0X8Ya72NckRqVMD+Ut9t1qmjCCbaPDNrMYN6XwjNfXNpn8b0GXQXsyDnOWWJKvY1GAMSS5oDplbfA8iOySIOS27e1t6XCTTULU3oOb7t35dCpfzaBjs+23SWdoIw5o50Wf+GJ/S+W46BLI+UHzybDiLrLgajdRSm9n9i/JJyyC+JWAwUBHUoOXsXlPqqKJ338v6kuZHhw6mF6IJJBP5m3T7Z0Eu
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:30.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1074cd-cfbc-4dd2-3b53-08d78897885e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead, embed the drm_bridge structure into analogix_dp_core and use
a container_of wrapper to access the latter.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 40 +++++++------------
 .../drm/bridge/analogix/analogix_dp_core.h    |  8 +++-
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c
index 6effe532f820..56ea3be27f2b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1218,7 +1218,7 @@ static const struct drm_connector_funcs analogix_dp_c=
onnector_funcs =3D {
=20
 static int analogix_dp_bridge_attach(struct drm_bridge *bridge)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_encoder *encoder =3D dp->encoder;
 	struct drm_connector *connector =3D NULL;
 	int ret =3D 0;
@@ -1292,7 +1292,7 @@ struct drm_crtc *analogix_dp_get_new_crtc(struct anal=
ogix_dp_device *dp,
 static void analogix_dp_bridge_atomic_pre_enable(struct drm_bridge *bridge=
,
 						 struct drm_atomic_state *state)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	int ret;
@@ -1369,7 +1369,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_=
device *dp)
 static void analogix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 					     struct drm_atomic_state *state)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	int timeout_loop =3D 0;
@@ -1406,7 +1406,7 @@ static void analogix_dp_bridge_atomic_enable(struct d=
rm_bridge *bridge,
=20
 static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	int ret;
=20
 	if (dp->dpms_mode !=3D DRM_MODE_DPMS_ON)
@@ -1443,7 +1443,7 @@ static void analogix_dp_bridge_disable(struct drm_bri=
dge *bridge)
 static void analogix_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 					      struct drm_atomic_state *state)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state =3D NULL;
=20
@@ -1467,7 +1467,7 @@ static
 void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
 					    struct drm_atomic_state *state)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
 	int ret;
@@ -1489,7 +1489,7 @@ static void analogix_dp_bridge_mode_set(struct drm_br=
idge *bridge,
 				const struct drm_display_mode *orig_mode,
 				const struct drm_display_mode *mode)
 {
-	struct analogix_dp_device *dp =3D bridge->driver_private;
+	struct analogix_dp_device *dp =3D bridge_to_analogix_dp_device(bridge);
 	struct drm_display_info *display_info =3D &dp->connector.display_info;
 	struct video_info *video =3D &dp->video_info;
 	struct device_node *dp_node =3D dp->dev->of_node;
@@ -1571,28 +1571,16 @@ static const struct drm_bridge_funcs analogix_dp_br=
idge_funcs =3D {
 	.attach =3D analogix_dp_bridge_attach,
 };
=20
-static int analogix_dp_create_bridge(struct drm_device *drm_dev,
+static int analogix_dp_attach_bridge(struct drm_device *drm_dev,
 				     struct analogix_dp_device *dp)
 {
-	struct drm_bridge *bridge;
 	int ret;
=20
-	bridge =3D devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge) {
-		DRM_ERROR("failed to allocate for drm bridge\n");
-		return -ENOMEM;
-	}
-
-	dp->bridge =3D bridge;
-
-	bridge->driver_private =3D dp;
-	bridge->funcs =3D &analogix_dp_bridge_funcs;
+	dp->bridge.funcs =3D &analogix_dp_bridge_funcs;
=20
-	ret =3D drm_bridge_attach(dp->encoder, bridge, NULL);
-	if (ret) {
-		DRM_ERROR("failed to attach drm bridge\n");
+	ret =3D drm_bridge_attach(dp->encoder, &dp->bridge, NULL);
+	if (ret)
 		return -EINVAL;
-	}
=20
 	return 0;
 }
@@ -1757,9 +1745,9 @@ analogix_dp_bind(struct device *dev, struct drm_devic=
e *drm_dev,
=20
 	pm_runtime_enable(dev);
=20
-	ret =3D analogix_dp_create_bridge(drm_dev, dp);
+	ret =3D analogix_dp_attach_bridge(drm_dev, dp);
 	if (ret) {
-		DRM_ERROR("failed to create bridge (%d)\n", ret);
+		DRM_ERROR("failed to attach bridge (%d)\n", ret);
 		goto err_disable_pm_runtime;
 	}
=20
@@ -1775,7 +1763,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
=20
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
-	analogix_dp_bridge_disable(dp->bridge);
+	analogix_dp_bridge_disable(&dp->bridge);
 	dp->connector.funcs->destroy(&dp->connector);
=20
 	if (dp->plat_data->panel) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.h
index c051502d7fbf..aae4110c7bf9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -9,6 +9,9 @@
 #ifndef _ANALOGIX_DP_CORE_H
 #define _ANALOGIX_DP_CORE_H
=20
+#include <linux/kernel.h>
+
+#include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_dp_helper.h>
=20
@@ -159,7 +162,7 @@ struct analogix_dp_device {
 	struct device		*dev;
 	struct drm_device	*drm_dev;
 	struct drm_connector	connector;
-	struct drm_bridge	*bridge;
+	struct drm_bridge	bridge;
 	struct drm_dp_aux       aux;
 	struct clk		*clock;
 	unsigned int		irq;
@@ -180,6 +183,9 @@ struct analogix_dp_device {
 	struct analogix_dp_plat_data *plat_data;
 };
=20
+#define bridge_to_analogix_dp_device(b) \
+	container_of((b), struct analogix_dp_device, bridge)
+
 /* analogix_dp_reg.c */
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool ena=
ble);
 void analogix_dp_stop_video(struct analogix_dp_device *dp);
--=20
2.24.0

