Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818B020803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1vdTznAk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1vdTznAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLDLyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:54:09 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:21315
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDLyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrR+yXjDIEHbJRHX1+pVUBG01j4aIovj/Zqj2yFBPiY=;
 b=1vdTznAkTHpyjnfO2SPepj4iGEXNjJD2qANwkjs2j+iegVIJL+Z0BNqBmzLCnbRyUowbmH70v6Fgk9vXj7LAwAzs5yvh+UMPg4mssHd3mvt60EDlV2E/QXkErXwtc0JJHFy1jWWeRh3o1y/dmHenK4gvXpYT6PkZMuz8iwclsZs=
Received: from VI1PR08CA0094.eurprd08.prod.outlook.com (2603:10a6:800:d3::20)
 by AM0PR08MB4498.eurprd08.prod.outlook.com (2603:10a6:208:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 4 Dec
 2019 11:54:02 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0094.outlook.office365.com
 (2603:10a6:800:d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Wed, 4 Dec 2019 11:54:02 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:54:02 +0000
Received: ("Tessian outbound 92d30e517f5d:v37"); Wed, 04 Dec 2019 11:53:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cd0d369be7420467
X-CR-MTA-TID: 64aa7808
Received: from b2b246179d1c.5
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D81B05AE-65D4-4C35-8532-B355C79A0413.1;
        Wed, 04 Dec 2019 11:48:07 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b2b246179d1c.5
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+KBbfAU84+ImEnbIBHCgwEr0hBWa85nLqrvcYqfohg1m0QfZlyW3P9ftZp1v/eVUOWid/Pkn6Oq5i7gTCtd8RrOlwkMAQ2D4w1Oqua7PcFfEGVJMjynkDvG98IFd5D0Uty9bwZ2w9cG8A2i08LyVHKizAvV5Y74+COLB2PIQGhLTALVTgPmpPt5bebKcnXPw+/dK2zGOYABWrgtFGmDxJzYZuuM5cI0FzvDIlion2fSveaBN7XoSL68mm6YDqRHe4vDMshC7iovDnT4VEJqZa7sgjj1w096ejXy/66N2h7wrCFfzb198ulyHS0A3I70qeVodkKhgHOFWlEp6anvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrR+yXjDIEHbJRHX1+pVUBG01j4aIovj/Zqj2yFBPiY=;
 b=Ah203kL8nZSP/pT1ZPVzeNMQLDUIPI3mpDPAfc2e5do1a0JdW7EFs51oOZdrO0CSYLKbvOyZgk5MCIXfti4kDgUwplNFwCj6Tr6t+Xb95o2VwoeQbN8wXoWb4g2pETYBzhTrf/R9mk85w+qKuPwcSYvjQ+aDXTWQVDjx820/Iwtqi4MSAmAEsvqulaL0kH8OfQvLD75kaEJeEXopoa31jpBXEI5HlUyxIewFxZEHx0fCL+1sYhpx3G9feftlZNvk2oI36Dag4k2t55ILbkmfRrIKBg2fxbyZbPxPJTvrIGz+dQ46JbfDUHCjJDJJg44YAMzWfQCRolNGtbKbBTVrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrR+yXjDIEHbJRHX1+pVUBG01j4aIovj/Zqj2yFBPiY=;
 b=1vdTznAkTHpyjnfO2SPepj4iGEXNjJD2qANwkjs2j+iegVIJL+Z0BNqBmzLCnbRyUowbmH70v6Fgk9vXj7LAwAzs5yvh+UMPg4mssHd3mvt60EDlV2E/QXkErXwtc0JJHFy1jWWeRh3o1y/dmHenK4gvXpYT6PkZMuz8iwclsZs=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:05 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:05 +0000
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
        Maxime Ripard <maxime@cerno.tech>, Torsten Duwe <duwe@lst.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/28] drm/bridge/analogix: Use drm_bridge_init()
Thread-Topic: [PATCH v2 03/28] drm/bridge/analogix: Use drm_bridge_init()
Thread-Index: AQHVqpiwLcwZikJoJ0a+RtRcqGJSlg==
Date:   Wed, 4 Dec 2019 11:48:04 +0000
Message-ID: <20191204114732.28514-4-mihail.atanassov@arm.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
In-Reply-To: <20191204114732.28514-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a62292b0-d286-49c5-066a-08d778b0a7d5
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM0PR08MB4498:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB44980C9EB87928D7B1279BDC8F5D0@AM0PR08MB4498.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3383;OLM:3383;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(14444005)(6506007)(36756003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1ffe5rZOEHbjfYqzzbcXz+/I7Hm2qXR1cP4gyHPmGIp6Gl90viHvajFm7GhBDOGYDFvqSsF/rfRxPVjYXl9h5g+lCrto+a9FXmiv4NLYRlFHuJS85HWnRtzXgwdU6u4xbt4i28B4rHOhJFyu4MUzGtq7skv1rhaKF53Do+DdNlzHEBRYP1E4KJSRheJIQsdOHAaWp/NbvKRB1iHOn1OSwtw4lwUoV0G4RHaeLoWJAgzokfjRQr0e+sFILdxsvT6ZSuqxhgSXBTCGPSSV1PhhMF2Vfs9Pi4bAVdK8YTSppG5X+lJPCbNjm9nzBGtYwaf5Zg4hfRpsXYMcGW0d7Z/HcXFYn6WmUgV1j8EFepnG8QoWSGsHHOQ+hUhGQpORpbDK/qeBNZ5kQVbmlAPT0dVldJZ8UF5KYgFPMacQ+a+SVBTLXaxCKAt6xcSQPcA/Sp+q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(478600001)(86362001)(25786009)(6862004)(5024004)(4326008)(14454004)(26826003)(102836004)(6506007)(2501003)(5640700003)(11346002)(26005)(2616005)(316002)(54906003)(6486002)(186003)(36756003)(14444005)(336012)(5660300002)(356004)(305945005)(7736002)(50466002)(76176011)(1076003)(8676002)(2906002)(50226002)(23756003)(99286004)(22756006)(36906005)(3846002)(8936002)(8746002)(6512007)(70206006)(70586007)(81166006)(81156014)(2351001)(76130400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4498;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f9a0e851-401f-4cfa-5e26-08d778afd2c1
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmBUbaOqAxTsKrajCxXRmetDrcqVDwHbdIjDcJpgu/K0IiTHIToDZEMne6JbrVvAMFCQ1SlvDRPv+m2xkbA0wQP1QG5FxiFHckrRGVKFVrtAt4524E+Jp/qkTxLjr4dZO6jTqfwJudIE0ifJhUOEfDY3cLPGgjpep4oK4WRbfMO/hjp0I8ztYCjxYVt5ilmNbbVO+4xFQ19tyCS53/Uefa4SiUVjIpIaHQCT1OnrIxA/a4A/PnqlgrDr2hzWBJ67dBKYg0+hv6EdFGLmWnz6epFF9GfJRDLMzJJHP7nQO9GscRKde1sJZIxmXndo5hFtTxQNKnp8PRPm27o3ak7NNyLhKWaecCrohJUInMEZqclZsukl+VfasUXmeUrnGWFilfkuM9GLfo9zRBJFjac0rdxEgtzkUfTkBozgpxK0ZtuPhMTwRPQxLz3+qHynUql+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:54:02.1007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62292b0-d286-49c5-066a-08d778b0a7d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

The setting of bridge->of_node by drm_bridge_init() in
analogix_dp_core.c is safe, since ->of_node isn't used directly and the
bridge isn't published with drm_bridge_add().

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 5 ++---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 8 ++------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 ++---
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx6345.c
index b4f3a923a52a..130d5c3a07ef 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -696,8 +696,6 @@ static int anx6345_i2c_probe(struct i2c_client *client,
=20
 	mutex_init(&anx6345->lock);
=20
-	anx6345->bridge.of_node =3D client->dev.of_node;
-
 	anx6345->client =3D client;
 	i2c_set_clientdata(client, anx6345);
=20
@@ -760,7 +758,8 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 	/* Look for supported chip ID */
 	anx6345_poweron(anx6345);
 	if (anx6345_get_chip_id(anx6345)) {
-		anx6345->bridge.funcs =3D &anx6345_bridge_funcs;
+		drm_bridge_init(&anx6345->bridge, &client->dev,
+				&anx6345_bridge_funcs, NULL, NULL);
 		drm_bridge_add(&anx6345->bridge);
=20
 		return 0;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx78xx.c
index 41867be03751..e37892cdc9cf 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1214,10 +1214,6 @@ static int anx78xx_i2c_probe(struct i2c_client *clie=
nt,
=20
 	mutex_init(&anx78xx->lock);
=20
-#if IS_ENABLED(CONFIG_OF)
-	anx78xx->bridge.of_node =3D client->dev.of_node;
-#endif
-
 	anx78xx->client =3D client;
 	i2c_set_clientdata(client, anx78xx);
=20
@@ -1321,8 +1317,8 @@ static int anx78xx_i2c_probe(struct i2c_client *clien=
t,
 		goto err_poweroff;
 	}
=20
-	anx78xx->bridge.funcs =3D &anx78xx_bridge_funcs;
-
+	drm_bridge_init(&anx78xx->bridge, &client->dev, &anx78xx_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&anx78xx->bridge);
=20
 	/* If cable is pulled out, just poweroff and wait for HPD event */
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c
index bb411fe52ae8..4042ba9a98d8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1585,9 +1585,8 @@ static int analogix_dp_create_bridge(struct drm_devic=
e *drm_dev,
=20
 	dp->bridge =3D bridge;
=20
-	bridge->driver_private =3D dp;
-	bridge->funcs =3D &analogix_dp_bridge_funcs;
-
+	drm_bridge_init(bridge, drm_dev->dev, &analogix_dp_bridge_funcs,
+			NULL, dp);
 	ret =3D drm_bridge_attach(dp->encoder, bridge, NULL);
 	if (ret) {
 		DRM_ERROR("failed to attach drm bridge\n");
--=20
2.23.0

