Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166D3FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C020872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L7wkSdcN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L7wkSdcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbfJPKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:40 -0400
Received: from mail-eopbgr90054.outbound.protection.outlook.com ([40.107.9.54]:54560
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfJPKek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=L7wkSdcN1vpuLJnXkQMX7xWpStzqRpBbrl1NLhxAlkAisQ/P3bmtKKscAsHNtiRFKEm1fr6ff95YoNu0iRBtEz9H7lpkgk12cNP+3d1Ol6wPR6Vf8purYYBdMtUSE5gNAsDxyQJKQq4e6fvpkbsjwgfjnei4ITOmDLJ7vycBVv8=
Received: from VI1PR0802CA0002.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::12) by PR2PR08MB4682.eurprd08.prod.outlook.com
 (2603:10a6:101:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 16 Oct
 2019 10:34:32 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR0802CA0002.outlook.office365.com
 (2603:10a6:800:aa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Wed, 16 Oct 2019 10:34:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:34:31 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Wed, 16 Oct 2019 10:34:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 95c03a061108e5e6
X-CR-MTA-TID: 64aa7808
Received: from c2892146728e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 216C8E9C-AFF0-42AD-932B-836FF78E502E.1;
        Wed, 16 Oct 2019 10:34:20 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c2892146728e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 10:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT0cPretCRCzHFq6+AeIpRf9o+VaIirw65k8pMDETUhyZGaIEyeM63KJINi99bf4HxQmr6cvtZF2lFCCVr0MA/gAs3+ghEBpbiPYD72c1H7FbxkF1MLNsRw8WWKaledQaHazMDjNZJ8e8rRZEV3RUPMTH35SHmM8SW7AfR2m7ezuUj+7cbmNjsDM9vBlhq4dJyPMMGVJgGDfTaAU8/4r2CuDDa2lCcu2PJPVdpe2BiKtq7xjs3EqI2y3pyYiuRdhnIkkGRUCCVLSCg2PxAq+TfP9X4FlXHTRJfFqKOZ/BhrS/2eVYDAYyUe6TVJF2qhqlMEoKBJic9YVonb2bxIxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=D0EmvRQfFeOlVPyZk35nH9xn75e90FlqpRU1zbhBfUr5ywzqUigrpQkjLicF+MrjuI0dak2fKNTzCn6xvmnqFcaPtE+hXAqtBUAO+myU5mZqCjsyftIqDFBpyNeeHRDuMoVnbRn1Upnt3LMSo+MlwIu8NCYDa8CygX45MRrP1p5bLen0Zid112GYr5PHu8fHHNGQMUZilEmqmg1mUdCd45D1W+JoRxA8O6B2YWkqwqYaLxUR57gJuALsTnUwyb5B06plyyPAk2stCECH1fv49YEJraoRhW6i0a4YGqj86ZUdF7wJ0qJXG2ZiPPfpEHjUT4UiVu5Nx73Ezf1BU1seCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=L7wkSdcN1vpuLJnXkQMX7xWpStzqRpBbrl1NLhxAlkAisQ/P3bmtKKscAsHNtiRFKEm1fr6ff95YoNu0iRBtEz9H7lpkgk12cNP+3d1Ol6wPR6Vf8purYYBdMtUSE5gNAsDxyQJKQq4e6fvpkbsjwgfjnei4ITOmDLJ7vycBVv8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5152.eurprd08.prod.outlook.com (20.179.30.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 10:34:15 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:34:15 +0000
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
Subject: [PATCH v5 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v5 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVhA1CCsnvZq8O7EazVvpZbV4JuQ==
Date:   Wed, 16 Oct 2019 10:34:15 +0000
Message-ID: <20191016103339.25858-3-james.qian.wang@arm.com>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
In-Reply-To: <20191016103339.25858-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8b419d36-d974-4cd3-5cb6-08d752246de8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5152:|VE1PR08MB5152:|PR2PR08MB4682:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4682C5DE1067F11F33D77B03B3920@PR2PR08MB4682.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(4326008)(2171002)(25786009)(478600001)(66066001)(99286004)(103116003)(76176011)(52116002)(71190400001)(64756008)(71200400001)(256004)(14444005)(66446008)(66476007)(36756003)(66946007)(14454004)(66556008)(8936002)(50226002)(8676002)(386003)(81166006)(81156014)(486006)(26005)(2501003)(186003)(55236004)(2906002)(5660300002)(110136005)(1076003)(305945005)(446003)(2201001)(6486002)(6436002)(11346002)(476003)(6512007)(316002)(6116002)(3846002)(102836004)(54906003)(86362001)(2616005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5152;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BwlzLsYKh8XrTNZ3BgzlueqRVidK4yexoJDa4gQvQMpe7SR2RMMrvfRJbK6P9eko9NF9tWHuywL+STouNPb10pCbpayA9blmHSGHfGXHI5qHIZsA3eH7RSYJDs+mcwEQpHT2Yd4LJF8IWn8Ecx3uDF3gF8dUa+3g/c9TAoZFZep8G81VUSZjGdRt6DJjRmqvyA2RdD5RiV2Gj8UqENviL1Jakt/F27ICRDrbaZjS2OroI11gk754rc9B0ptXUNLvUaTPspes6aEzKKEErRanEWHUC9ZFM+tUsmME/hG++h6tfhhyM1GooiG41eInMwxrB+kwKQEiTrqJco+TH5iVfj/bjUVDs9YmCy9QeX+763ecM7460MTHKesuHI7F2csb/a+rbxgnbszaHp/alj3QN/5/9tktfiuuJpBbJNzTLqw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5152
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(476003)(305945005)(2616005)(316002)(14454004)(50466002)(23756003)(110136005)(22756006)(103116003)(54906003)(2501003)(86362001)(6486002)(2201001)(63350400001)(47776003)(6512007)(446003)(11346002)(486006)(126002)(36756003)(14444005)(336012)(66066001)(4326008)(7736002)(5660300002)(25786009)(1076003)(26826003)(478600001)(356004)(186003)(76130400001)(76176011)(2171002)(50226002)(6506007)(386003)(2906002)(36906005)(3846002)(6116002)(99286004)(70586007)(8936002)(102836004)(8676002)(81156014)(81166006)(8746002)(70206006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4682;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fff45ce9-f407-44e3-7240-08d75224648d
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjNDzVROmz6wXlSDI6BSJqamIf4TEnjZ0Vo/FE5JRsZXKGAynjVSKYeBmzyFzpaaJyxssC2Eghsd+O5JelS51xXLG+Eyp+y+Td8JtRj2h28ay13bT+u5XPVe0jQUO/lc0tqqn4koZUhHFAg8LS6TcNzvKLiY6yOjQoJM645NNBT0OBUbD0BElKGfg4cXINUJTXES2WzVX7U9wllEFmDJGmDi9Fzf77G2xr6wwLdRbntwjBQyIFVyhKcCs4UvY9qwSnXGqeguExRuuiQTBq6qqBeYayWHFGuQ5/R3RcADW+ZgJDCqgEZnpoDN/S+KneXZ4/G6+sean4DR+tbIr17YmTQtRCY1ckaLSd8o54SRRpcb5l9Ur2RYRJSN+D3LFgDa0MXyWs5Omyv0cKaX0ZG2rCBl0Dg20pcRSxJzFFz3oec=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:34:31.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b419d36-d974-4cd3-5cb6-08d752246de8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4682
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

