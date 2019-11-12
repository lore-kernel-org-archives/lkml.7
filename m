Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D3C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0BB214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jai0Nsqs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Jai0Nsqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLLK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:10:28 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:1113
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=Jai0NsqsHq59Sg27RJ9TlmHDByYltbZHgyuUXWYUIllQokoFCUpRsHD8iIgadgpYuW9kak7vRL2ONd4VV19OVm9qEOUnjEqlPeqN/+h4gJz8ZB+cfle4wSkh0PGb0duIZY4fSxc3pZzN5UA7ZxpC98YAONjljUWz9T8GU1N/SX0=
Received: from DB6PR0801CA0061.eurprd08.prod.outlook.com (2603:10a6:4:2b::29)
 by DB7PR08MB3273.eurprd08.prod.outlook.com (2603:10a6:5:28::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Tue, 12 Nov
 2019 11:10:22 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by DB6PR0801CA0061.outlook.office365.com
 (2603:10a6:4:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 11:10:22 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:10:22 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 12 Nov 2019 11:10:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f0f9c5476530ba08
X-CR-MTA-TID: 64aa7808
Received: from d79f0f428efc.2 (cr-mta-lb-1.cr-mta-net [104.47.4.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4F2DC11C-75F8-4723-8DD8-4A6F944CC0E3.1;
        Tue, 12 Nov 2019 11:10:11 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d79f0f428efc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 11:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHjqLln0srUgmvvp53WCZtvy0+C+NEgo86+CRTkbO6SddJrN82kKdyeAodoNg9u74MN0Pav0oeRH/T5DCihbJdneW4ylmZtrlfOuBbkTSgOk4YqFvMenVaXQn4DAVAECdCdSE5D6mbDivmUHLKbG0J5Zw/b3JP8UaWPx/2RWC4H2B3IA1EJ75j95SEBZnchlpz0YSqTtx1ZIQWsodMlDQTUrNZOKJrCPAS+Fuvmwml8YstBpUt9w89I2ui4Dk8l6DXNkeU9/9J5fU1kF52ARjfJ1ZXUaBcWtBe+4Pg1wT1do1sTirS8YF7uFBofAgM71CBlAcpQyhkl/ifQeTODDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=PtBi0Mq6vG6CnKvSibborgddR4FZG41OJD+8tSNo/KH0NFP4EqzjfSgKUZRiqOfds/ETin62ySFFa60clBeCnmtrJ0ONYFirq1bp/JTcb9Y9XeCn9Ho+arLr1JDI5/c08p9HlfYiNQ8EyyetWG5r1vDYqSHDRIN4o13x1aWvQv8+FWvwGzw6jeQmi4sN0RL3bTxsGmxd5ccwKIkhDlwAEztuyj4YcCzXqfBU814aMuBQjSYY76KH5lJIdIFo7qRfapp/uTkfQvo6ZvxZsMysz0srlU5LGqC8H938uFVpPb9DfJatzG9/JzAT4+c58t3wMs7WkqRGy2Ev3M7YXPQq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwl4JXh3gudDNqqnWSO4qmhHyZFD7hivyUxQxR0plGY=;
 b=Jai0NsqsHq59Sg27RJ9TlmHDByYltbZHgyuUXWYUIllQokoFCUpRsHD8iIgadgpYuW9kak7vRL2ONd4VV19OVm9qEOUnjEqlPeqN/+h4gJz8ZB+cfle4wSkh0PGb0duIZY4fSxc3pZzN5UA7ZxpC98YAONjljUWz9T8GU1N/SX0=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB3636.eurprd08.prod.outlook.com (20.177.43.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:10:10 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:10:09 +0000
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
Subject: [PATCH v10 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v10 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVmUm+oipHNsw4FUeM3rml3PnnBg==
Date:   Tue, 12 Nov 2019 11:10:09 +0000
Message-ID: <20191112110927.20931-3-james.qian.wang@arm.com>
References: <20191112110927.20931-1-james.qian.wang@arm.com>
In-Reply-To: <20191112110927.20931-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:162::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2841295e-2bc1-4e58-1878-08d76760e93d
X-MS-TrafficTypeDiagnostic: AM0PR08MB3636:|AM0PR08MB3636:|DB7PR08MB3273:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB32731BB6DC33C055D0516847B3770@DB7PR08MB3273.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(2906002)(99286004)(446003)(2616005)(476003)(7736002)(66066001)(6512007)(6436002)(6486002)(11346002)(54906003)(256004)(305945005)(103116003)(14444005)(110136005)(316002)(2201001)(14454004)(6116002)(2501003)(86362001)(3846002)(486006)(71200400001)(71190400001)(186003)(386003)(36756003)(1076003)(6506007)(5660300002)(81166006)(8676002)(4326008)(50226002)(26005)(76176011)(66946007)(2171002)(52116002)(81156014)(66446008)(102836004)(66476007)(64756008)(8936002)(66556008)(25786009)(55236004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3636;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: efgPPhW1sIC+T2J3ud2UUGeRox9h2yMuqqqjAoHAwkPC0VELuJamMjU2TdOt2LM+MTxvtZo0wW8xi4NJAGepDA3vNNstuLhaXM5bm9zrgHLIO2Lm6paZhaYgdnLk1p+Kx0GGYI5nJ7em6Uy49sXmjGZ6cKYpmbgs4mLC+uBwZ+267ogL0eT0/WAwEBzGekuefn3eLiy7qIA8wDT5kTk+yUw/Kx+tkGKcyexLeyr1wFFcRMbKuyxnkrauroBPqQ2Q8uKwdHZS1r1z6e3HuQKWJ/i3DVeOJMw960pghVJ+n/giDek4WRjvd2YT99mV/7eTxDvtH4H28Y3edT9TjYIKpaQ22IiledFJ73aVG3o9oz3v8Yh10bXEVOQmZPpAan8caghZrp6datxVXlWDaC00gApCY2mSkO19s/DJTNdRHy5Hv0LfH2tr3gwjcda/C67p
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3636
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(1110001)(339900001)(189003)(199004)(70586007)(102836004)(4326008)(103116003)(81166006)(8676002)(8936002)(81156014)(23756003)(105606002)(8746002)(66066001)(3846002)(6116002)(316002)(186003)(6486002)(5660300002)(47776003)(2171002)(2906002)(6512007)(478600001)(26826003)(126002)(446003)(11346002)(110136005)(25786009)(486006)(1076003)(2616005)(14444005)(54906003)(50466002)(70206006)(26005)(2501003)(76176011)(336012)(36756003)(6506007)(386003)(99286004)(50226002)(2201001)(356004)(22756006)(86362001)(476003)(76130400001)(7736002)(14454004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3273;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e693d14d-60ac-493b-320b-08d76760e14e
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLPotEP6pAhZxVKrWUtreRuBPoCBRNe+2PF1DCstPOFXukcn/8SesazwnhOLthN/FFY8ema2hyqQLH+fA0D9DCshC46q7yZ8us3ujjOnfHPO4f294FIFA8nyTnih9+8uIC9y1ez7MoSvMaUu5aoa+nVmypFE3eU3hoWz5NlzUYXDPzrLfp59RUDhJe339jK2RdTgdMKtkDl85TZ71E+5cWx+mG4rx/OlYf5W+YQAyPb9eCvPV3PyZRCna0yVSy1ZTKxmqg3jXqpgu3C5yrVyiAQGfEQVeNcChhTrSnUzzPdEUpOv8vFk6oQXv86tuLY61E4N7I3uE7IdNyUS2tpgW/Y2hb5bv2+W6nJMxG+QDrh+L7uzGzlyEfOPJFJrZZKy3hi3z9kYwO4DHXQaVoi8eWnNHzQMPz/yIHa/wwcsvZ7ZnPMKCeXTG+2Se3W1fjvS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:10:22.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2841295e-2bc1-4e58-1878-08d76760e93d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3273
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

