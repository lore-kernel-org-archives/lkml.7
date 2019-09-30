Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA680C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63B2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6LFj2bBD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6LFj2bBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfI3EzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 00:55:01 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:22404
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfI3EzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=6LFj2bBDUDf6PPzsngLgAge8gnWBtUiqapCSf6+PCwANsj/U48Pk1CcAfBJ1lNP4PNlmT5rEJ6fF/b5/BnPcvgfDOdgqaxZwCq1mWQx/dkefihxfYk/3DjQbiJn4pu4AlpjnE3Ni6bCXpOHd1KJuat2yl4r93uSvWjx/f0f+LRo=
Received: from DB6PR0802CA0034.eurprd08.prod.outlook.com (2603:10a6:4:a3::20)
 by DBBPR08MB4267.eurprd08.prod.outlook.com (2603:10a6:10:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 04:54:52 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by DB6PR0802CA0034.outlook.office365.com
 (2603:10a6:4:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 04:54:52 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 04:54:50 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Mon, 30 Sep 2019 04:54:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 449fa4edf9518bb1
X-CR-MTA-TID: 64aa7808
Received: from cda93119b744.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01DA1FD6-318D-466A-A93B-1013410DD6CA.1;
        Mon, 30 Sep 2019 04:54:38 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cda93119b744.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 04:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAmxKax6gf7ZEaaWofuM3U3D8NH0E7Rj6+nJ9XcS4pYsYEF8QFF6H7tQwU/+HUMbRLtX0vN5qZxsTAuv2Uc9DduS8w7rMDbd9COLFhHgjDRT2yL1f2vYIxKyxzkCZUn5nJ766x3lS5CSZWPMhMuXPtcRScxEjb+PXPs1qU5JEli2UGPjFjWr/TAzOtNfNTyC1j2/9g1yCk8Z+ECUFHX7eiJgv/+0q4rJ/sFP5lVIVBSLAIElDTBqmk4TUbZoCrRCNXeMK0X5v6GhKzKaT7Xu9VINxhwdLqW/KE63RJtgTS3TahIxZf1q2wbeBf7tUKXtYdCYF6X1ycs/mJYO/dFmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=G8p14T5zzsEVDuvuNqAfIV2/Lu1wkm1STaTxKDjP/Q7UIbpqmZa6jyScr/VLgZ4LBMqeOeLayGp4agORNLJ+M1Sj40D7mCykPoZRm2Hwabph/o1qDXgG0tH2ctmR1k6M1DYHK0cYsA6z47wnFS+gxEGzHLYgb3+WGX8jBqGJVbjEMInGRNY9cELNo6c5a0CeIR5YlFFXPSeb76dKUA5OW0hWQDPfoQt+kcFov97Ubgbay+MfQh1hOH0O6B2ed2eEnHnTOBVc2cw0fPTbthpbiRMI4u7Uq7smBYkFpC6lvzdMwlS2RQusFk/Wb71cRyqLM94wKsPpWcX1gWmQAK+fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=6LFj2bBDUDf6PPzsngLgAge8gnWBtUiqapCSf6+PCwANsj/U48Pk1CcAfBJ1lNP4PNlmT5rEJ6fF/b5/BnPcvgfDOdgqaxZwCq1mWQx/dkefihxfYk/3DjQbiJn4pu4AlpjnE3Ni6bCXpOHd1KJuat2yl4r93uSvWjx/f0f+LRo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.27.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 04:54:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 04:54:35 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH 1/3] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH 1/3] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVd0snT33H/BtpsUmrR4CGKgAzPQ==
Date:   Mon, 30 Sep 2019 04:54:35 +0000
Message-ID: <20190930045408.8053-2-james.qian.wang@arm.com>
References: <20190930045408.8053-1-james.qian.wang@arm.com>
In-Reply-To: <20190930045408.8053-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 23025991-7a98-409f-b470-08d745625345
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4703:|VE1PR08MB4703:|DBBPR08MB4267:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB42679F0761A7A3EB44C0EC0FB3820@DBBPR08MB4267.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(189003)(6116002)(3846002)(103116003)(26005)(36756003)(2201001)(256004)(305945005)(71200400001)(7736002)(6486002)(55236004)(102836004)(8676002)(81156014)(2501003)(52116002)(71190400001)(66946007)(6436002)(81166006)(14454004)(64756008)(446003)(76176011)(11346002)(2616005)(66476007)(66556008)(86362001)(66446008)(478600001)(99286004)(6506007)(386003)(6512007)(14444005)(66066001)(8936002)(1076003)(476003)(2906002)(316002)(486006)(4326008)(50226002)(54906003)(5660300002)(186003)(110136005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lZ7mBFKlE3zMXXk+ZEbCOVOUPdhbtGHn3mzRXNDpumBXjQtJsOspw+lLufuqAlNhw3nV/vg5lIHQ7uyp2sOzcO1ElowG5bFlVrjiMnh9ST+4xDr44FnQbAq1saj9FB7SJvmwcs0sBaauKMD8pCwcMOONS6G1Dn/y4bzWO9gWrAK4e+TPWfyIkF4KC01IPeA1ywrrx4AY8DBvaSMr2RowYqfluSvXqfZBQyp4rHhrRoqR1SzVZL8j+odUJ1L3jHuAzuYhT9w9enadgRlQ+DiV3q38UoJvb+d8FAuj/WMR/kIhQNrHvr9sG7qqTBzbfpldJZ/ramabn+uDOjzTU6Nj1BUJPTKuYHrAVNdEPeHi3EWP1C5Mg2mMSLZBm0mtwCsLZ00uWYHaZ7uz+7187fCzcy93WMqACsOeeMdntQ1A6rw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39850400004)(189003)(199004)(70586007)(70206006)(110136005)(3846002)(4326008)(5660300002)(25786009)(76130400001)(86362001)(54906003)(50466002)(26005)(26826003)(14444005)(316002)(103116003)(6116002)(478600001)(14454004)(36756003)(6512007)(23756003)(6506007)(386003)(2501003)(47776003)(102836004)(356004)(76176011)(6486002)(81166006)(66066001)(8676002)(22756006)(2906002)(50226002)(8936002)(8746002)(63350400001)(336012)(126002)(476003)(2616005)(305945005)(446003)(7736002)(2201001)(11346002)(99286004)(81156014)(186003)(486006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4267;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d4a3009c-24e0-48a2-de47-08d745624a1c
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9muTnSqyZF7fcH0Z9i2LsksUpO+qSjZmkLQPxZmdEo2AE1Gxy+xnuPHaMBO1tEcss0zfu1Oo7Vo2AE9XUi4+nQra9MrYAZmMbAEPtYUXucsgAf7QfwZ440VojX7onMp/IBLZZtc4PZAB9br1XKv9xWEpB5uNb+4jcZ/1sNJ403/dYtCdzzilD78wtBlJEs2vmm4jFc8diP9Jd17LIWaY/0xJwUYt8jgCFL3o2xUZIIZHVyioAcXX+8lGYDDSWTEq/mcBtyfQE4gO+yg80nl7jniAIqbocO9AjdKQOEQBwHL390V+oX+zalxawnptwlDL6Ds6hZiYnHvbGUH7O3MaG9+8poXQjqPntVRH7gSSNza22uR9i7k8TazFxyakUsRhU9jvalQ3xZBDzH0jJrw0PeMqO6dutq1kS/IkJGal2A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 04:54:50.1102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23025991-7a98-409f-b470-08d745625345
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used to convert drm 3dlut to komeda HW required 1d curve
coeffs values.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
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

