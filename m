Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4DB2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zw5AOh1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfC2Got (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:44:49 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:12825
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728715AbfC2Gos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkCvpErOTQRGIzWhjJlbeWmCpPhXBGbIRIOuSZBPUng=;
 b=Zw5AOh1JwHC+H1BgPSxUJunWC+xAurWsPoLD7xvAUQA1970jdI8D7owLKYApfhK2y5CHP83i9BpBm5le3U1IZZvyKL5uOxHocd28hFosxqSUvmsOWZsx6GmW94dSEcCiRDwiQ/4yYsE4p2hHReh91GNo6T6u4rd6cyszNRtSflg=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3625.eurprd08.prod.outlook.com (20.177.120.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 06:44:45 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 06:44:45 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [RFC PATCH] drm/komeda: Creates plane alpha and blend mode properties
Thread-Topic: [RFC PATCH] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHU5frlAU9hEdci3kKU4rRJ3aBkWg==
Date:   Fri, 29 Mar 2019 06:44:45 +0000
Message-ID: <1553841845-20174-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:36::17) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1e63963-d194-4ff4-626e-08d6b412077c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3625;
x-ms-traffictypediagnostic: DB7PR08MB3625:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB3625322D1E99EA59E27554F49F5A0@DB7PR08MB3625.eurprd08.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(53936002)(316002)(102836004)(36756003)(54906003)(2501003)(52116002)(2201001)(55236004)(71200400001)(5660300002)(71190400001)(6506007)(25786009)(305945005)(186003)(4744005)(7736002)(256004)(476003)(486006)(26005)(86362001)(2616005)(5024004)(14454004)(66066001)(6636002)(4326008)(2906002)(50226002)(97736004)(6512007)(8676002)(106356001)(81156014)(81166006)(99286004)(72206003)(478600001)(110136005)(8936002)(6436002)(68736007)(3846002)(6486002)(6116002)(105586002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3625;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwghcH8JvbTdiFVpC6dOPFFCi024w2Dl3j3lpvbRDRlqaKHz/10AS6eIBDJMHyl/lPBpX5xoTLYCQWQenTUQecaSOGi7KaBu9oXwB6HFw5m9o6dE+tq4GWcBX9WVeP0riP4jZbD3gnzPvaANZD3aLxoFAVjnKDlKiyH+F5azDMwt1kq4yNAKa1g0FonKY2jJp5Ru6xdDGPrEP63EqnG/+TEJf5qL6C0BfMgxcXPGzg7qcKqybE+y+G628d8QumcUZ2V4r1jAj1kmGevUskYRKp29D+ZDZgZFemGj1VjdHpYrFp0YLvkfu5eOIsdVyquw9UGNaAac/bBGb8WFL10Tbn/cp2piGaDUssI+E/Pxi8AdV5oTpASOuh8hK3XGXvMpqei3cJoHl8FNXRAMOY5B9lFzMVv33qnfQ49QR/QGqP0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e63963-d194-4ff4-626e-08d6b412077c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 06:44:45.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates plane alpha and blend mode properties attached to plane.

Signed-off-by: Lowry Li <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index af51f0c..0ebec39 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -212,6 +212,17 @@ static int komeda_plane_add(struct komeda_kms_dev *kms=
,
=20
 	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
=20
+	err =3D drm_plane_create_alpha_property(plane);
+	if (err)
+		goto cleanup;
+
+	err =3D drm_plane_create_blend_mode_property(plane,
+			BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+			BIT(DRM_MODE_BLEND_PREMULTI)   |
+			BIT(DRM_MODE_BLEND_COVERAGE));
+	if (err)
+		goto cleanup;
+
 	return 0;
 cleanup:
 	komeda_plane_destroy(plane);
--=20
1.9.1

