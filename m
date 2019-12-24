Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2164FC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89682071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kytft3WL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kytft3WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfLXRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:34:48 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:5734
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726882AbfLXRem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0jWwWLLMB0S5WuYpGadsNiUw9pXePSigM7IcaavYBY=;
 b=kytft3WLg3kRS8zKHOE09V65fFXdHkaVIfgBAsW49ZubyKHIP4JgRef5ydwPuPq28HBl5i03kwCBNM51z3XnUip5MvsKxhb3/A5IKwpnBcnu74x9pixcYNkcUjeyVdbflEz+0ikRDXUaLINgLY+uup03avQ6ePc+hC6JVRMuMqI=
Received: from VI1PR08CA0228.eurprd08.prod.outlook.com (2603:10a6:802:15::37)
 by DB6PR08MB2869.eurprd08.prod.outlook.com (2603:10a6:6:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:34:38 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR08CA0228.outlook.office365.com
 (2603:10a6:802:15::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:38 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:37 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Tue, 24 Dec 2019 17:34:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 98e897c25d104c9a
X-CR-MTA-TID: 64aa7808
Received: from bce15b33d58b.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 24AABA8E-B277-4B85-8C75-AA0E9CE6173D.1;
        Tue, 24 Dec 2019 17:34:32 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bce15b33d58b.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We+cmYLhfn/nQh8VlXETG+ip0ZRcYprQg+3HR+zXeTDbjibY7uW0VeBSpkUy0tVVda+igrWLpsrROyjFQO2BCWZUtLSBZTJDEY9c+SbHBSc5GflEoEYo+YBzndWa4l6fnJi8vsjvYO93lTZD/4hp3ddjPRtPFcNgegUKWsy0sW4xuN7YFd3InbSfTPOVJbXKi95j8qaFMyYAnXY/TISQ6EzlureNl/AWtVeluO40INhsKWDKAuPVXFqyTPvAHwiaJ9DzsitO31tfI481bpecwOSOd9O5Z0Gj8Rko7HzcEwD7ZWJcxRUHE9oixKe1mqNYq9nR6eD8MYLGqkxcfGq0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0jWwWLLMB0S5WuYpGadsNiUw9pXePSigM7IcaavYBY=;
 b=oEwK1agh7r401T9oR0i6SLdtYa5Dv38Tf9n9OeXIBbnig/65msw40yN8RK0jPXvD4e0XC3fQ7uY1UrXGpN1/ex0qYkORLi7Daxhm2TaQjPamfNV+yMepRr3YPwGBXu2iy+o979dstcQjyzMLA6mCrRDP2mdIL+IFakc/4qJpmrU+zYV2AWIRRzRSu1O+AxHdD1gGibK443f64WyKsaWtvR4P84bTObph9WimrFuItZNcpCZi9GujXCgdQrMDTMeQrvvJkwrUqabpTKyvB/pVEt6njLExjJ0wJOEFjnIS6y08vt08g8WPBboKbJ3oWf5Y/YdAjgilsqjzcOclhTPzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0jWwWLLMB0S5WuYpGadsNiUw9pXePSigM7IcaavYBY=;
 b=kytft3WLg3kRS8zKHOE09V65fFXdHkaVIfgBAsW49ZubyKHIP4JgRef5ydwPuPq28HBl5i03kwCBNM51z3XnUip5MvsKxhb3/A5IKwpnBcnu74x9pixcYNkcUjeyVdbflEz+0ikRDXUaLINgLY+uup03avQ6ePc+hC6JVRMuMqI=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2702.eurprd08.prod.outlook.com (10.170.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 17:34:30 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:30 +0000
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
Subject: [PATCH v3 11/35] drm/bridge/analogix: Use drm_bridge_init()
Thread-Topic: [PATCH v3 11/35] drm/bridge/analogix: Use drm_bridge_init()
Thread-Index: AQHVuoBlpOm1s13reUyMoPETVyW9PQ==
Date:   Tue, 24 Dec 2019 17:34:30 +0000
Message-ID: <20191224173408.25624-12-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8a0f491-1549-425f-16bc-08d788978cd3
X-MS-TrafficTypeDiagnostic: VI1PR08MB2702:|VI1PR08MB2702:|DB6PR08MB2869:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB28694B039D59E3CF569581878F290@DB6PR08MB2869.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;OLM:3826;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(81156014)(8676002)(478600001)(36756003)(4326008)(8936002)(66446008)(64756008)(66946007)(66476007)(66556008)(26005)(186003)(44832011)(6506007)(2616005)(81166006)(71200400001)(316002)(2906002)(1076003)(6512007)(54906003)(6916009)(6486002)(86362001)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2702;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 670oSzKSuyj3Jef60y6ZI1pM2O7QWQaoVSDHAbqei9FeP7p6z5rsiaxy6Qtcl/lR/gDzY7XaO2F7DFsNjMd48f9VlN0tEYHTPyEvMkLW6NiUsD/h1OK4295C5uBXoPbjcC+yMlZ1HH8240aurjr6KPb5/enWPX024GY1PIhI97xmK0HWPzzJh7sNtxU/j1jDHYRkpZQSN+yk2wVAp7OjOKPSK3fXOa+JUEphBz715+mZ8taZgqQsT9bPlBQfwJC9VCvmAjBcuBy3wDM1Ep7NNDsF6BCFl4SNDqsXFTUsUs5r6MK9j0XjUsJZ7Nh6zFBfr8msLSuRUZ3R5lMwYEjnomB5LXas+jEO/1abJ3Au98vpI4qIpmq8p+ONJtTSZuSs8UMkttG+lyo3uZ8sChpyRN2RlIH9hZKHeEd9yUh3/UTT8iUD1LMHgxlw7+H0ulD0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2702
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(36756003)(26005)(70206006)(336012)(70586007)(76130400001)(356004)(186003)(6512007)(26826003)(81156014)(54906003)(81166006)(6506007)(5660300002)(316002)(6486002)(4326008)(8936002)(2616005)(8676002)(2906002)(1076003)(6862004)(478600001)(86362001)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2869;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3d4fb853-b5df-46d2-63eb-08d78897883b
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJz+3Z9KBNFdGT6eTHwxMY/ZQo60qQmz849AJWs2yB2x1N6YFDz4K/2xxWnOY7giXXaUyqxP44Whm232P9AUd8cU+Svu3mQgmWr7Pd6qJB94qDd7EYzKyciJmV3+xuBlJVy466RbZNfMDrzW5UiXOaIVX3mgg9rUMtK0voAU1cs6iakS9aNyJuGjLnXtvmLonF2A13q0Hz4bT2Kb6TMA/4xm7f0WhLVI+sFGNVEq+AW2IqCbrczzh/x6t0wRRenFaJiOWyIPTsg+0K5AjDcQrB8lv6MlcuEJaerXNZKynma/1MtRpNJGQ2dSSDvHbVktq08EaZ/U25wen0mzzQGB+ZVNQ5Tf/3ykk6690KTiAAbd28mWJRNpK3XvmNXWysjpZiu0XyhWNZ6XRatqrXGKsgsuHciAmrmsiRZ35RKZH0YQYI42GBrkMB/XzR02O0+x
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:37.9257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a0f491-1549-425f-16bc-08d788978cd3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2869
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

The setting of bridge->of_node by drm_bridge_init() in
analogix_dp_core.c is safe, since ->of_node isn't used directly and the
bridge isn't published with drm_bridge_add().

v3:
 - drop driver_private argument (Laurent)
 - pass correct struct device pointer to drm_bridge_init (Laurent)

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 5 ++---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 8 ++------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++++----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx6345.c
index 5b806d23fcb3..62404b0f2fc1 100644
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
+				&anx6345_bridge_funcs, NULL);
 		drm_bridge_add(&anx6345->bridge);
=20
 		return 0;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/g=
pu/drm/bridge/analogix/analogix-anx78xx.c
index 7463537950cb..e30df40ec512 100644
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
+			NULL);
 	drm_bridge_add(&anx78xx->bridge);
=20
 	/* If cable is pulled out, just poweroff and wait for HPD event */
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/g=
pu/drm/bridge/analogix/analogix_dp_core.c
index 56ea3be27f2b..29693d48682e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1571,13 +1571,13 @@ static const struct drm_bridge_funcs analogix_dp_br=
idge_funcs =3D {
 	.attach =3D analogix_dp_bridge_attach,
 };
=20
-static int analogix_dp_attach_bridge(struct drm_device *drm_dev,
+static int analogix_dp_attach_bridge(struct device *dev,
+				     struct drm_device *drm_dev,
 				     struct analogix_dp_device *dp)
 {
 	int ret;
=20
-	dp->bridge.funcs =3D &analogix_dp_bridge_funcs;
-
+	drm_bridge_init(&dp->bridge, dev, &analogix_dp_bridge_funcs, NULL);
 	ret =3D drm_bridge_attach(dp->encoder, &dp->bridge, NULL);
 	if (ret)
 		return -EINVAL;
@@ -1745,7 +1745,7 @@ analogix_dp_bind(struct device *dev, struct drm_devic=
e *drm_dev,
=20
 	pm_runtime_enable(dev);
=20
-	ret =3D analogix_dp_attach_bridge(drm_dev, dp);
+	ret =3D analogix_dp_attach_bridge(dev, drm_dev, dp);
 	if (ret) {
 		DRM_ERROR("failed to attach bridge (%d)\n", ret);
 		goto err_disable_pm_runtime;
--=20
2.24.0

