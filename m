Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8267F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kurLDjWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfDDKKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:10:39 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:9088
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728671AbfDDKKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eJSYLCXZv4JmgGXeji4IzzFeNLHT9G7kOZpqxQUqhk=;
 b=kurLDjWBygimOeOLZE4pJPvP0LzLNVMB/qfHT6/k3n74Lx284fZK2AQzJlGyylmtLQvEbvIX1WeOkf0XYO3Ya5+GU450FYzKN1ltY61LBwHaKP00hDoWrLNkVtUWevaXkxAdcTljN05p8ojav3pWQ9w7I3GSeZWwONZr8NoviCc=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3771.eurprd08.prod.outlook.com (20.178.47.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Thu, 4 Apr 2019 10:10:36 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 10:10:36 +0000
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
Subject: [RFC PATCH v2] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Topic: [RFC PATCH v2] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHU6s6l9n6BadQNGU+O4hvKDOagqA==
Date:   Thu, 4 Apr 2019 10:10:36 +0000
Message-ID: <1554372625-3659-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec71e70f-16c2-49a9-2bbd-08d6b8e5c79d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3771;
x-ms-traffictypediagnostic: DB7PR08MB3771:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB37712F4A41E202EF1BAABC589F500@DB7PR08MB3771.eurprd08.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(71200400001)(7736002)(81156014)(478600001)(2906002)(68736007)(186003)(66066001)(26005)(8936002)(50226002)(966005)(3846002)(110136005)(305945005)(81166006)(52116002)(8676002)(5660300002)(316002)(2501003)(72206003)(54906003)(6116002)(99286004)(2616005)(6436002)(2201001)(105586002)(102836004)(71190400001)(256004)(86362001)(36756003)(4326008)(6506007)(486006)(25786009)(55236004)(386003)(14454004)(6306002)(53936002)(6636002)(6486002)(5024004)(6512007)(106356001)(97736004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3771;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p72FAITBS48J9yw7NR3D0JoUhwYyWVO8q5zfDbbQe3YEcK76Dq3vuQhreokx6iZeaK/ckgYpfhK67P5aAafpnoFt2ylrnRCCPnmE3F66HZNkrXnG+6RXUkaq2aChepXDT+4NggKzYR5t7Bhxg/4nMAlcxigcRWsbF+0vlW50i2j1FCtyPIYDVyI3gh0tAF4g+oM7+qqOD+3XeanyjJjsxuSttPh1U85mdd9lcFvsoFAzEGEgGLrhL7g4eEG2cPbbQcIMC7vnHAqDnkfARcD5dA04j6ZTP9vXi08gjgmxQ+zaHKW0xe+2H599ilNwWzRSfnFRmvBJLlWg8ySOZspoFIiW1DmIiqJeL6jSaVJnu/FepwZtRL7Pk0We206QF5tpMEsvBrYClGL+vOofAoHjN5a9Uood58aBo8MPsU4VP3I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec71e70f-16c2-49a9-2bbd-08d6b8e5c79d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 10:10:36.1405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates plane alpha and blend mode properties attached to plane.

This patch depends on:
- https://patchwork.freedesktop.org/series/54448/
- https://patchwork.freedesktop.org/series/54449/
- https://patchwork.freedesktop.org/series/54450/

Changes since v1:
- Adds patch denpendency in the comment

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 68cd2c9e..aae5e80 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -220,6 +220,17 @@ static int komeda_plane_add(struct komeda_kms_dev *kms=
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

