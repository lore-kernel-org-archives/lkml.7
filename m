Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A20CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D005120862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2KivfaIC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2KivfaIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfKAGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:54:13 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:5495
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfKAGyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=2KivfaICzHYyUYef9HaUhEchtFV+Fvz/v3Dy7uOo9M37KlIU5zIWTmRioirZC5aRRqTwSmVVMNH3QniYAhm1qxo6EUEc/rjyGqWwCSjY0tYTKbsMGCZFcyO2znhNVSMvjcOn81E1Bp9VlttaxPlmJEEvW59tPPcw70owbKMFct4=
Received: from VE1PR08CA0015.eurprd08.prod.outlook.com (2603:10a6:803:104::28)
 by AM0PR08MB3812.eurprd08.prod.outlook.com (2603:10a6:208:fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Fri, 1 Nov
 2019 06:54:05 +0000
Received: from AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VE1PR08CA0015.outlook.office365.com
 (2603:10a6:803:104::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.19 via Frontend
 Transport; Fri, 1 Nov 2019 06:54:05 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT048.mail.protection.outlook.com (10.152.17.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 06:54:05 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 01 Nov 2019 06:54:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 929eb414ead90db0
X-CR-MTA-TID: 64aa7808
Received: from a5a1095d5c28.2 (cr-mta-lb-1.cr-mta-net [104.47.12.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0B309B24-EFC7-451E-BBDB-CD2C8B6C9A38.1;
        Fri, 01 Nov 2019 06:53:58 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a5a1095d5c28.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Nov 2019 06:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4K73owtHgtucvqFEUkoGVkrG0Z9vrQpINDNhylo5DUsXMeuH65pqzYxeTJsnA/P2HnzpMPR0O2qBiHLss4P2vIjB7jnFI7Oz2Vw/WHAYtXo9BYi0I18kwRJ1d8MmzbDBlEgOss9LXy9y/ItNWQQgfVjAYPhzltBkWtvc0DG5/tTI7N0LzhtGvgaR8Iws78XFwAYL4y3bMM+588PhtFXBqyzBeBcon1uyFdzSHf4HEf2k3KpfD9mO1MY3UbNCSOs2UN/eO/0gi0etocLc5xxArxLt/r5+xuPrG9vHjkryTMOXmFQpOvxzI20IUS1iH8knmugpJTuH93CKqyraWAJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=WQzAB7dSJx1S3J9sLVMloLHtn2+Cyg+gKsGHlSNBnambCNbJ7HfTxVsUiJFLwiFp0iHKWwG/FfL/m87dP27Z+94XGDWB/U2cfwG7FqYbyp7AnF6XK2SHvG/vBjO2u4Mi9xWc14ia/j3y1unnmHY8wFEjpsKqukW8JTAVl4LibvCgnpHxDxJ9lbnrClShLUb852vvWSj8KZSmh1dsZ9mKHWdtd/2h/6p5ppW7KbkIc3UTqvfFUYez5equbfvpUT/WvClfBhDn8xHSTRXtpyCGoLDz7q66m+QpM/l73w/+QrXYdG8eJHXyVAva9SskrJUrtyvqYKyPMxnEk0jtL2IvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=2KivfaICzHYyUYef9HaUhEchtFV+Fvz/v3Dy7uOo9M37KlIU5zIWTmRioirZC5aRRqTwSmVVMNH3QniYAhm1qxo6EUEc/rjyGqWwCSjY0tYTKbsMGCZFcyO2znhNVSMvjcOn81E1Bp9VlttaxPlmJEEvW59tPPcw70owbKMFct4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1SPR01MB0002.eurprd08.prod.outlook.com (20.179.193.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 06:53:55 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 06:53:55 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v8 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v8 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVkIEgVFu/k1utEUml4A+vyEm+iQ==
Date:   Fri, 1 Nov 2019 06:53:55 +0000
Message-ID: <20191101065319.29251-3-james.qian.wang@arm.com>
References: <20191101065319.29251-1-james.qian.wang@arm.com>
In-Reply-To: <20191101065319.29251-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8767e92b-1232-4b0f-ab2f-08d75e984926
X-MS-TrafficTypeDiagnostic: VE1SPR01MB0002:|VE1SPR01MB0002:|AM0PR08MB3812:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3812AB256AD176705825998DB3620@AM0PR08MB3812.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(66066001)(446003)(11346002)(2616005)(486006)(36756003)(8676002)(14454004)(5660300002)(476003)(103116003)(2501003)(2171002)(86362001)(3846002)(6116002)(305945005)(2201001)(25786009)(1076003)(6512007)(66476007)(52116002)(71200400001)(71190400001)(386003)(55236004)(6506007)(6436002)(102836004)(6486002)(7736002)(14444005)(186003)(99286004)(8936002)(110136005)(4326008)(54906003)(50226002)(478600001)(64756008)(2906002)(66446008)(81156014)(66556008)(316002)(66946007)(81166006)(76176011)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0002;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qZDG91QD8O+FoDU/18w1oR5vlENb4mdrhD6VlYHDQ+PoUMSGhGWABd5h8e9Dd6kpesqmxrji4Slb9dJzDcOZ5xsPvtAB6HLtwX0lc5jNPnKAcCo0Z2MwzQHe+WM2jb9ghP9BihkGhgb2n1czjlSIYGdueyPT75bqycGgYOjm/smWIQCsJ3h8iD7e7kye8KD9QBdO2DT1gjaVvdaX9Hk0X7+88fC2KnAMTC1kX7yLxzP6BBrZQj96LKk0Ml4J+I/La4uqUbBpVw4EBflGPYSpQuliReg49pFue14FQrrscrYjVKc9pNEgmidPQvEn4NonPx3uOfdgrOvQo8WXUlG/wHwKMdOxhnJlZ3ynQw2Fg1w17EUB+vp34uqok/RwE4lKEViCUJHX/8Z87PEEAH25B8YLrOvPWb6hHJLfT5uOutTSqzOgwauCAqoD3KoXFb6u
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0002
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1110001)(339900001)(199004)(189003)(22756006)(81166006)(4326008)(2201001)(81156014)(6506007)(8746002)(76176011)(23756003)(110136005)(11346002)(14454004)(25786009)(54906003)(5660300002)(386003)(8936002)(86362001)(36756003)(8676002)(476003)(2906002)(102836004)(50226002)(26005)(126002)(76130400001)(1076003)(7736002)(2501003)(3846002)(2616005)(356004)(486006)(186003)(2171002)(99286004)(336012)(26826003)(6116002)(446003)(305945005)(6486002)(70206006)(70586007)(36906005)(47776003)(66066001)(50466002)(103116003)(105606002)(6512007)(316002)(478600001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3812;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6063315d-7c59-40e9-bf82-08d75e984354
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaqfOLxYuaZoEN7kbXn35N6lmYUgZiR8Bp5YvRsV/fsSwgbq8TjSQ2UxpBlMrtLiwEpLIH64RGlQfrsUeeWgFJ3/AYqMXARAmqEy6j5TokrTXcwsT7blN/yhhHpwK/4b7VqjygAEM9Ap34Grr7oTBCpdQN3yZKMVjOViOpntuzcPu67Z0zjVV70z1l71r/pZSdTlB7A28vU3dImhwqjFRXFULrtmhelbQ8tydcaagLKzS8t27Qf+z/4U0Sqx+SYnAI9i6WrvPf8E/dlc4Pn8MIGHszzpL/O/VLo99fxfaHxwH5c+6wEf/7cYZSaXsj95SDhK8Q9gOJ9yjYA7RRt7YM0CQ+2SP23fboMftgG22lTgt1lAmAppQtGDI+3zeXhl0hl2Ve3f9yZRPDFASINFS8bFVKqUdxB83U7rs1q8FGdUPz8Y3HTS4ABHNWDhX6Kg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:54:05.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8767e92b-1232-4b0f-ab2f-08d75e984926
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3812
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used to convert drm color lut to komeda HW required curve
coeffs values.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../arm/display/komeda/komeda_color_mgmt.c    | 52 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    |  9 +++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index 9d14a92dbb17..c180ce70c26c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -65,3 +65,55 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encodi=
ng, u32 color_range)
=20
 	return coeffs;
 }
+
+struct gamma_curve_sector {
+	u32 boundary_start;
+	u32 num_of_segments;
+	u32 segment_width;
+};
+
+struct gamma_curve_segment {
+	u32 start;
+	u32 end;
+};
+
+static struct gamma_curve_sector sector_tbl[] =3D {
+	{ 0,    4,  4   },
+	{ 16,   4,  4   },
+	{ 32,   4,  8   },
+	{ 64,   4,  16  },
+	{ 128,  4,  32  },
+	{ 256,  4,  64  },
+	{ 512,  16, 32  },
+	{ 1024, 24, 128 },
+};
+
+static void
+drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
+		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
+{
+	struct drm_color_lut *lut;
+	u32 i, j, in, num =3D 0;
+
+	if (!lut_blob)
+		return;
+
+	lut =3D lut_blob->data;
+
+	for (i =3D 0; i < num_sectors; i++) {
+		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
+			in =3D sector_tbl[i].boundary_start +
+			     j * sector_tbl[i].segment_width;
+
+			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
+						KOMEDA_COLOR_PRECISION);
+		}
+	}
+
+	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
+}
+
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs)
+{
+	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index a2df218f58e7..08ab69281648 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -11,7 +11,14 @@
 #include <drm/drm_color_mgmt.h>
=20
 #define KOMEDA_N_YUV2RGB_COEFFS		12
+#define KOMEDA_N_RGB2YUV_COEFFS		12
+#define KOMEDA_COLOR_PRECISION		12
+#define KOMEDA_N_GAMMA_COEFFS		65
+#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
+#define KOMEDA_N_CTM_COEFFS		9
+
+void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
-#endif
+#endif /*_KOMEDA_COLOR_MGMT_H_*/
--=20
2.20.1

