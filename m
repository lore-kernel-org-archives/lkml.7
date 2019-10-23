Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB65CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950EF21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qAJ9pAUP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qAJ9pAUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfJWGnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:43:22 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:26240
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=qAJ9pAUPPZGyS6WwxCPJincnvsW7AubD4Iib93fcAyAI7tFhmd5zFdT0g2Xc04me9EVY+E/naL+I2OAzzRHVm0NRN6zfJT8zGObGLUMlO9ao3Zw1FqXZIa/cjMCbZeidLTYdoEEJDtqn6CIjZHIDz9n8DX1fWFgFYzNaBrpz3L8=
Received: from AM6PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:20b:c0::17)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Wed, 23 Oct
 2019 06:43:11 +0000
Received: from VE1EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM6PR08CA0029.outlook.office365.com
 (2603:10a6:20b:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 06:43:11 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT058.mail.protection.outlook.com (10.152.19.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Wed, 23 Oct 2019 06:43:11 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Wed, 23 Oct 2019 06:43:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3f0e5afd2a6b8878
X-CR-MTA-TID: 64aa7808
Received: from b8d509519dc2.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9F5E5C31-FCD1-401F-B28B-E7595C5FECF3.1;
        Wed, 23 Oct 2019 06:43:04 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8d509519dc2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Oct 2019 06:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDD9eDug6PJPtn+KoeO51N8Wir4M8XEPu5iEO6Z9CjxnUkVSAja7lv6IHfqomdOjV2IVFe0mA0lwl2R+CVmTCJO4I4Tn2UREnzU4lbvZchnaz48B1+upshLUXsnkzpcJ6Xi03/I5JdfbNsLDyTKyF2jHmCkZgNGIiJKVQ+MvJEVtRpcX+AnjHWYgqVLbBmFA18pfwEgmnF2t22AgZCtojN41pKPaTUN1UeYXLHsv+wLM+6s/A2I7gl1X7ZsvI/0Jl1jOLpqa5v5mTEPnHq5veDSeUqktXUsm2B2wB8ibLbFK0OVJYoi+86v6d271r3TpMimJ53kBBOb+xui1MSTMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=GyQRI8z9pe3mJbbOdfyj+Oa1YD8Y+oWJPEoPS0UvH7db+Z856MyzCNPWLD/2yBkfJhnt8g0gmNm55t9St3r4/wVr5jn7WIcOrRnxS5XWxGTyd0nOVDuyQzhLaOIA5G5B3k+8AWBRGbCCpgd6iNwLkH0LbnANjzCaFPipru4imU7KB/j6UCOHOnW+LOGtqiFzpS3xoXsVGQZjZPzU7rkdJrmLliCy3hhsfiHuxjecISOOvEmr05dVR0HGTKpNoHGHF8igQsk71sixmYEZ1e3sEEOYSkmtwoetcOMt29HrseFDfWF481mCCCNjPvJwny7oo9aL09pI7gmYCvlDSxjkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=qAJ9pAUPPZGyS6WwxCPJincnvsW7AubD4Iib93fcAyAI7tFhmd5zFdT0g2Xc04me9EVY+E/naL+I2OAzzRHVm0NRN6zfJT8zGObGLUMlO9ao3Zw1FqXZIa/cjMCbZeidLTYdoEEJDtqn6CIjZHIDz9n8DX1fWFgFYzNaBrpz3L8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4672.eurprd08.prod.outlook.com (10.255.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 06:43:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 06:43:03 +0000
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
Subject: [PATCH v7 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v7 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHViW0eTRzKlLORfEigId1iRu45AQ==
Date:   Wed, 23 Oct 2019 06:43:02 +0000
Message-ID: <20191023064226.10969-3-james.qian.wang@arm.com>
References: <20191023064226.10969-1-james.qian.wang@arm.com>
In-Reply-To: <20191023064226.10969-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bee320a5-377a-40d1-356b-08d7578445f7
X-MS-TrafficTypeDiagnostic: VE1PR08MB4672:|VE1PR08MB4672:|AM7PR08MB5478:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478E603261D0F97693A1413B36B0@AM7PR08MB5478.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 019919A9E4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(7736002)(25786009)(2906002)(386003)(71200400001)(4326008)(36756003)(305945005)(6506007)(66066001)(2201001)(71190400001)(102836004)(5660300002)(26005)(478600001)(52116002)(14444005)(55236004)(316002)(86362001)(186003)(6116002)(76176011)(3846002)(256004)(2171002)(66446008)(66946007)(103116003)(64756008)(6512007)(1076003)(66556008)(50226002)(66476007)(476003)(6436002)(8936002)(446003)(2501003)(11346002)(2616005)(6486002)(14454004)(486006)(54906003)(99286004)(81166006)(8676002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4672;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fp4LKsL/+am5Me5BtVSYezdXE3Pvjta396ABbaGdtnmlhEFfrm9ZG/QnHoLenEt+jEimTK9cBFinTT+hHZLMv2ttu2sRMapNc7INeqyTGCCqF2YR8y+OGdc8PRq6X9HlzE8lQEf8j8rrIZt1ISqBmQd0g5irLxc1ImuMmCSKWJLBaCZJGORUa9ULdnRdjslQFImr/gZzUno+D+G8zY+xBgfema6d8j5D7fX8XDbfnW5bQdDTdl4Ry8PTlkuXGgQMxYRAlPGPGjPbcdcWlJ9eBA9fSUCX5UhDQzWUjxMsydf1IafvEKJ4bdz2gnPfGHR27XIc9HTlYkx8n/7IZWdhfbF5yvjCQNSx6TPFqIhdvQNYryG3C8Dgc6sY+YphfqOT7tbPByvazBsd3nudBn1Jk640qHDQzuhcbaX8/2ZnLZ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(1110001)(339900001)(189003)(199004)(356004)(336012)(1076003)(103116003)(22756006)(5660300002)(2501003)(14444005)(2616005)(476003)(126002)(11346002)(110136005)(47776003)(54906003)(2906002)(305945005)(2201001)(486006)(36906005)(25786009)(316002)(86362001)(81166006)(7736002)(3846002)(6116002)(76130400001)(66066001)(446003)(70586007)(70206006)(186003)(6512007)(8746002)(81156014)(102836004)(50466002)(6486002)(50226002)(26005)(8936002)(4326008)(76176011)(23756003)(14454004)(478600001)(386003)(99286004)(36756003)(2171002)(8676002)(26826003)(105606002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5478;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c5eac636-4a83-4e9b-00c1-08d757844098
NoDisclaimer: True
X-Forefront-PRVS: 019919A9E4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5fwaWZaeZv40pdWVcLp6+yn/17ef4rf0t0hNdU/iBnveuxv91qUs4HaA7EwUei+B73EB/l51avWig0ayOwShfhp97lNfjB2Gc775Y4PReUU8Mwvj1cRhLJT80+IUeH6tlAAturxTdegVywedbmK7MG9vrZly1Z8F8b508ZI3VrR5iWMBJsPmVdP1DVopzsLdmbangIaxw+HIkJeF/MtersIXLUKS6NlD1W9dB3K71iENqw0yWIsJmL4Vqc8Haw3d2WumJsVhzVos0AiwSSKab4SkpbtWJ15Bvws2O3/g8X+0s053t4X4wDH5+2NswK6uH4YbnTMaMsLl/KsF+bKNIeF0p2ChC47GppnagQ8j2vSSN0FgzYtxi5MCgtJazbHeLJ42A0L4l9Gb5OyAVg6bcIMIZnjIBv1D3etKkW27/sj6gtAB9Y2YsKm3RPcciH5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 06:43:11.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee320a5-377a-40d1-356b-08d7578445f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
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

