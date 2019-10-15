Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6231ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RyP3qy9l";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RyP3qy9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfJOCLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:11:12 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:12965
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfJOCLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+CVUl4qWxenCBixN/jWd32qUXnMZcRNCV0P3x8wYzk=;
 b=RyP3qy9lmz3B6X+mVDqdsXTc9pLR19quzSSv2uVAJdTAXoPCK2i3VGfNp7EQ/EfIqi88z9KMW1KaM4KR+4rxYvZm0PzX4pPr0+CySnXkaMoKqrcG/dO/b2CiTPI3CMCBAtFkQEXKNH+gRucOpu9KQnk696fXUfuY5xcjC2NOrU4=
Received: from VI1PR08CA0103.eurprd08.prod.outlook.com (2603:10a6:800:d3::29)
 by DBBPR08MB4361.eurprd08.prod.outlook.com (2603:10a6:10:c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Tue, 15 Oct
 2019 02:11:04 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0103.outlook.office365.com
 (2603:10a6:800:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Tue, 15 Oct 2019 02:11:04 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 02:11:03 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Tue, 15 Oct 2019 02:11:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1ea56d70985e14a7
X-CR-MTA-TID: 64aa7808
Received: from 67c7e3bd8aa3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 82CD08CE-DCEF-46A6-AAE7-FD7736A85D7E.1;
        Tue, 15 Oct 2019 02:10:56 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 67c7e3bd8aa3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 15 Oct 2019 02:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5GCFt8S9ZbVVQLQkPJ5Q8JAYjUBXpPOWLnsfaha+28Cltyj6C1UVOxbeDzuMltN6V5WNnzkGL1sl7YKnsS/xaLYV3rbqAJb8HUkeXkentzqWRV2OpQDS5AsOa8eX2DuckiF1K/lGH+pn4cZ1Yjuvc7GykyW9JUho6bIWSsXA1FULM8t0xPBG7zkKl4Byt/SN9gaSBXeR4GkP8FsK2mPexsCXR87L0rXTFrFe0QXlDht2Gvpt2nU+cM1519zvBvpZqt5iGNpi1s1JjtqU9t3AYjgjPF/HY2nL6b5VBQxk6PCM80uwGM+soAwmCjxTMvo0asIo4GQ3kHMvM/S1LUryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+CVUl4qWxenCBixN/jWd32qUXnMZcRNCV0P3x8wYzk=;
 b=gb2CgO027n2vz1EmLZq60cdLiuQ4stbjR9MoDEssugnatDZZvdu+ylNhHJYSVl84bnTVykSP5vTgPUPY66q41stpnpk9vfulcOeqNbLA0FMeQ0bXhHIE37yGQxbpWg+dlZEG3Q/KawfPjQFtt8P3iMS7ZCCroIuy5rsd1VFsFbMnL1COXvXc7/r+kFcTF+J+wrNalGW1CSL31Nebbep0vjf0UjWuhq3ViQr08TaRjyhCNub1vU2+VrfrdYl88M3t1IVtsJwBm4EiiVFOyVk7JjBV/942zAM//YkXKQVkiICVozWzmPO5xCNjWTZYFoVsSnGEv7kfwSt3Vd5uOyBEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+CVUl4qWxenCBixN/jWd32qUXnMZcRNCV0P3x8wYzk=;
 b=RyP3qy9lmz3B6X+mVDqdsXTc9pLR19quzSSv2uVAJdTAXoPCK2i3VGfNp7EQ/EfIqi88z9KMW1KaM4KR+4rxYvZm0PzX4pPr0+CySnXkaMoKqrcG/dO/b2CiTPI3CMCBAtFkQEXKNH+gRucOpu9KQnk696fXUfuY5xcjC2NOrU4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.115.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 02:10:54 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 02:10:54 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
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
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVgv3GI0L46yKgNUGru0epkUV1dw==
Date:   Tue, 15 Oct 2019 02:10:53 +0000
Message-ID: <20191015021016.327-3-james.qian.wang@arm.com>
References: <20191015021016.327-1-james.qian.wang@arm.com>
In-Reply-To: <20191015021016.327-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b88d412c-ad8e-40c6-a9db-08d75114ee05
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4799:|VE1PR08MB4799:|DBBPR08MB4361:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB436166FB6E5148FD9EE854D4B3930@DBBPR08MB4361.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(66066001)(476003)(76176011)(110136005)(54906003)(66946007)(64756008)(66476007)(66446008)(71200400001)(66556008)(26005)(103116003)(2201001)(86362001)(6512007)(186003)(71190400001)(316002)(36756003)(6506007)(446003)(11346002)(386003)(2616005)(486006)(2906002)(256004)(52116002)(14444005)(55236004)(102836004)(2171002)(8936002)(14454004)(478600001)(6486002)(81156014)(81166006)(305945005)(50226002)(2501003)(4326008)(8676002)(7736002)(5660300002)(1076003)(6116002)(3846002)(25786009)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cfKYnAsGCVJorudqwrhl2d7VJ7+/yWklsxh2CWOpj/VaB4F8b93xUFNR3HjS/vQ6PbhVtUHez5H5V+/OmgwtY2HWTUOmCk1aRsqB6ezsT740USWkGWhpfG/dklQ0vla9XNkzyNtSzlNQWD3RwILqjfwdU+gOmbt6gCDzHOfBJCawaPvo1Fkq0S1+UU7U4tUwiyeSlQG5hqPb83nc3535iHNPn2n4fx1+nCJMlS4vsq0tk8DyHTedKoAdOgh4Ft7c/wONs4j6JRyNSuV0KjKc49Dszi3z9LF3wf3R8K+KarXFIt+nlK65ALgwanRq3vJ4r8ldIdQ3TJzT5KvNuQshpL9/1ebtD3fikpEhkeUQ+CQZAoK5Oqb9q9a1vEzmKg9lH75LJIbu8OqQ4lWH/yM5v7uxdFtrigB4fW4HEu7Agvc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(70586007)(70206006)(186003)(47776003)(316002)(54906003)(110136005)(50226002)(2501003)(76130400001)(103116003)(2171002)(22756006)(102836004)(76176011)(6506007)(356004)(14454004)(7736002)(26005)(386003)(36756003)(23756003)(336012)(4326008)(66066001)(99286004)(14444005)(478600001)(26826003)(6512007)(305945005)(2906002)(81166006)(81156014)(8676002)(8746002)(3846002)(6116002)(25786009)(2616005)(476003)(5660300002)(50466002)(11346002)(446003)(486006)(6486002)(2201001)(86362001)(126002)(63350400001)(1076003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4361;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4800d94f-3272-43bb-2a78-08d75114e867
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/45Id26OjSlcXT57n+EmB/twBPGE1oqq+ha6s3DviADa89P+3wKMOdTq0V/mZ/1mk5swfivK6gmGj9zB+o1hYkzKho4TIteofWnl1YFpXjNpJhUvXLwLx2fljaYfeEW5bLQool9o+IjGNXVFbWR+7Y2UN4Tv6gYGB4raBK4bKaVjjz5TMNnl25wHnjtGE7/Qm4ljcCZa8sIsLAsy2bqfCUXvkfI5oAbINyVGFXjOatwBTmPJ8zRQ4+ijDaTgEO/5KEcKm94y+Wv3tNmZlgc5Z2Y77hFrX3FiWeH/5Vw5CfKtKPWcIIdsEJVCwh5WtuUujH3KeD4OCFHJ0zgxDM8Qpx0Yi+fMeKcUdJ2dUcIzmolnpZPtAcaHCE8YLhtttZY75v/r3WJPFDpWnLqYEtKVwFTI+y+Hrj/2EifA4Ol2uE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 02:11:03.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88d412c-ad8e-40c6-a9db-08d75114ee05
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used to convert drm 3dlut to komeda HW required 1d curve
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

