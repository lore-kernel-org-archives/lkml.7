Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3433206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+Pgg5dtC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+Pgg5dtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKLKkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:40:45 -0500
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:60130
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfKLKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=+Pgg5dtCZX15W2ngjSFIKapDfjxtJOhi4FimOi578ORS9OHEXdzezp5gRyCy42S3x8btny2crv8qnTdU40lWejK233hJmEOYzJENO6rxHuM418u5Tmgv2MdKuWXxINScCCKoI7oh/YKz1ZCuzXFoIGbl9rsodSHm2Db3KLqJWg8=
Received: from VI1PR0802CA0017.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::27) by AM6PR08MB3477.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 10:40:40 +0000
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR0802CA0017.outlook.office365.com
 (2603:10a6:800:aa::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 10:40:40 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:40:40 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 12 Nov 2019 10:40:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b9988feed9b57917
X-CR-MTA-TID: 64aa7808
Received: from eebcda1cfdc6.2 (cr-mta-lb-1.cr-mta-net [104.47.10.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 85B22660-2E5E-4997-BD9A-D9C91F06BD67.1;
        Tue, 12 Nov 2019 10:40:33 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eebcda1cfdc6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 10:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBg0CEXLzW7JPTajW6rvaUgGk9barZtq1prZG+3b4ZEREFeTJYay85kDmrfgr+iuIL0CJX7mv1vczfhiHlfV2mxNCXJ+rQvyJ6trHdQZm78AmDhgZbVG67k3vWaG2IFT3PvVsl5wQ9bJge0448dDWzgssM5x3ThR7XiL+M4t8XetufgTQ6SdZqDf3bdfMZEi537NBfGRr2LFBrY5CHI+1UWemixCooJdJAkKOOy2tmhcgZCNYKjGBkx7mwOHrMju/v08emaHA6O/PpjmHF0XsdDeIOQjnfXNIzv6BGteA4+vvF0rLX1W7cNHemhhRKo0V5EnGOvGo9tEhBbZCS31aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=evPEEmoEwP5tfRzEvXOhFboOHEYcGaKwO9Y6SBqRzSBlnUCqkASMK732cxNklB5oZOQ2RF1RHmQ6fVIx8xG3w7/Z6STxkw423kpnsRdxrQvtOvEtfJ4SjO39/mE5FN3JpTY5bSNWUJ9gDfb2mnRMYHX26lYG7UdKdkY6hPBBDG8gr85F1z2f1WIeH2VblPLNeT735n7YWy9hnMWRHmvR5vM+UaVyv62kR44LRBCfTpRwTn7GnfvhD29CxqXmUqs4Ui5B5nhcGraY5uojArhwBOBbbUBZCSLgfcHmtsU/+20Jk5tG7Mo8CDUlEQ5maSZmNhKdHL39K9HCPNcAOi3b4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=+Pgg5dtCZX15W2ngjSFIKapDfjxtJOhi4FimOi578ORS9OHEXdzezp5gRyCy42S3x8btny2crv8qnTdU40lWejK233hJmEOYzJENO6rxHuM418u5Tmgv2MdKuWXxINScCCKoI7oh/YKz1ZCuzXFoIGbl9rsodSHm2Db3KLqJWg8=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB4082.eurprd08.prod.outlook.com (20.178.119.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 10:40:31 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:40:31 +0000
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
Subject: [PATCH v9 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v9 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVmUWbKgyTbmPF30mDCSrJAJAYVQ==
Date:   Tue, 12 Nov 2019 10:40:31 +0000
Message-ID: <20191112103956.19074-3-james.qian.wang@arm.com>
References: <20191112103956.19074-1-james.qian.wang@arm.com>
In-Reply-To: <20191112103956.19074-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3f940a8-7e4f-489e-5854-08d7675cc303
X-MS-TrafficTypeDiagnostic: AM0PR08MB4082:|AM0PR08MB4082:|AM6PR08MB3477:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB347795902691F985C491852EB3770@AM6PR08MB3477.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(6512007)(478600001)(66066001)(54906003)(110136005)(316002)(5660300002)(6486002)(14454004)(2171002)(11346002)(446003)(2616005)(6436002)(25786009)(476003)(2201001)(14444005)(1076003)(6506007)(8936002)(386003)(99286004)(2906002)(4326008)(55236004)(102836004)(103116003)(256004)(66946007)(66556008)(66476007)(64756008)(66446008)(6116002)(3846002)(52116002)(26005)(81166006)(81156014)(8676002)(186003)(7736002)(486006)(71190400001)(71200400001)(36756003)(305945005)(76176011)(50226002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4082;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a3v/DQSfKb9ZZFqlQ2LipZjWy8dFhQAnHCkcn8pf0fi6AHxYczSwTGPAOb4RoCIGQOkSvD9HLZ9jHk4CA0mxXodCeWpgvv3IPBfESGVxOz/6ZM5QzzHM6vBVUtNZAozTueldrJaZtNsS2pB3NQ97bZb4KUaZGYkN1f+aZxCrDuSR/i7RmfNtmjNFimIbpvs9DrOMwFsFYbJNcoWjliiVlH4NbsJkHe5uxRFK5+K/qFEE+zgcf9ar2rJpKSDls/dG57Y2Phg7qr99/dN8Qo8LXH05wPtl3Lxj6yqt7r+q5dBk2vizPFOcYznQ+sN3nBAvrxtxXioYiK70TledlUPuwnXraXIlyeb7tpf51va5WyMsu0zvB2RXSyl5UfEEaW+Q9FV57dx41iJsvl4i1CDZUPk8Tcq9imkDYDrjDjM5WKPgcrZ/X6sCzMpiCOknWStt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4082
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1110001)(339900001)(189003)(199004)(70206006)(386003)(103116003)(66066001)(126002)(14444005)(6506007)(76176011)(2616005)(476003)(446003)(70586007)(4326008)(11346002)(76130400001)(22756006)(486006)(102836004)(47776003)(2171002)(23756003)(186003)(6512007)(356004)(336012)(26005)(6486002)(105606002)(36756003)(2201001)(8936002)(1076003)(2906002)(8676002)(14454004)(110136005)(316002)(305945005)(36906005)(7736002)(478600001)(8746002)(50466002)(50226002)(26826003)(25786009)(99286004)(2501003)(86362001)(81156014)(5660300002)(6116002)(3846002)(81166006)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3477;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5aaa2bfe-eacc-40e4-cf60-08d7675cbd74
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKXuJFX0/WfW6jn65IVDanZFKLOVdhs116TBe0+5vvQTrjPidMQpcMDze0bwd41Ce7jS36bL0J0fF8JkYEw8iLiaEsxrWNhAHutAup5YQFW8uJ8J1jez4d4A4hQBIXf8Ak5dw37DcVmtVF8alPYY3YL7ezWBnQPbOGm6mmAR5XFaTa8APcb6fEYOaIt58TipU6MfZLgZoh5g2F4aqrX2pFmr91LF85n+R8Z7P5OYYz/In1R+egTgKczLaVL5cD3pt+i18TS9VXSsBX4MYzem1oiiSJjP9ot0wkjnyjXVmT8kFTyF2nOLZ66s0oT2MtI4Z8srLxXonMKq4h08BEggc3vBhnLDBv6SypHxKhkHBsCggMmYzAYYMRkACaqN6ziT6+He79/zEgkjQoyZP0kO+l+pkjh5V0/trcDQcZPrX1kL+qHnXFwEYqI/NTALlCeK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:40:40.1231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f940a8-7e4f-489e-5854-08d7675cc303
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3477
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

