Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5EECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C9D206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zuW0j5Hx";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zuW0j5Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfJKFpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:45:55 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:17057
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfJKFpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=zuW0j5Hx8HGQv59K8T1irjc9S+l+UndyNXCVECA3YSE7+eviUs6qXfYlSlTTfsKbZJ/C9PU1q9LLviHeGjoyhbVGHb2ip0O3EzPf4ckHwkg40uKCCmv+Nmh9gg/iqtU+iwMvG8YzBpwLZvn2oMPrhSK6PIA13lcyDThAyctXF2s=
Received: from VI1PR08CA0171.eurprd08.prod.outlook.com (2603:10a6:800:d1::25)
 by AM6PR08MB4913.eurprd08.prod.outlook.com (2603:10a6:20b:ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 05:45:49 +0000
Received: from DB5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0171.outlook.office365.com
 (2603:10a6:800:d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:45:49 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT022.mail.protection.outlook.com (10.152.20.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:45:47 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Fri, 11 Oct 2019 05:45:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ee33e86667b35187
X-CR-MTA-TID: 64aa7808
Received: from e02de6d1ad5a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 53D50113-D5A6-4B8F-94F2-90B2EFAC6E97.1;
        Fri, 11 Oct 2019 05:45:37 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e02de6d1ad5a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnW9vM/69pyvXM5QdOx/44ArSrxixR9Kvwcoo46GZbdf6Ug/XZzrdSaYWWdDRWZ6gaNiyBVA9fKDspbzsAvgvICChfSJGeHbzl9DLmneYlY4ITVBLJk0LF4HrRSWkVIbAyLPaxr+eSq69iZQGX94H8GTsQpL1CSUIbL/kSQG31aI6s+9QFVS5VTtkvIEGpOSTbApm+foM7shJrMQJEwUAGjPFp6QctYMreI7fuQMlNtslLY317iNQleeE1LSX4hyrEumWtLZhBpjeSjYbhAka0Mzu6JCzG+avym4B3pNbUp6iQ4NgfLVus25YlyXGN2uzBeLKgqr4mUqR6D1kkuEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=c1KAGTB0qU1jk8NveHdZBAxbwGIFz3GB8rfN7X+oz0Lb7aM1uXUaXW7S/rIp0A4Y6wWw4tXgckGKqTmQD2GRLctpbMR9NfcvcrKEvZWwZ2DqQrqUkBmM3smxSZDx0AipwFGq7PY/84xyhMDrFXTf0dVCMtPqZGAvvq97mD8qY2vX44pXmg3xF/vy6UGPXZh23/xq040eI41Pqm/Q+oTYkdHWpn6nFPmkAptSyx4TLTk3V6VCvQvCvufGTnUvZdaxcb+hxlKdpkiZt5a4SWg0eMOdfc9sIIeQ4VGzfwvDWDKTeLNozyvNndf90b5wfUeolNkAazwxEJ2lh1EXHNN4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUBbQ6jci7ZZBrBwHMNuLpOgBHySGEUsJ89UPIG5ETg=;
 b=zuW0j5Hx8HGQv59K8T1irjc9S+l+UndyNXCVECA3YSE7+eviUs6qXfYlSlTTfsKbZJ/C9PU1q9LLviHeGjoyhbVGHb2ip0O3EzPf4ckHwkg40uKCCmv+Nmh9gg/iqtU+iwMvG8YzBpwLZvn2oMPrhSK6PIA13lcyDThAyctXF2s=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:45:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:45:35 +0000
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
Subject: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVf/cahg9HTk7nnke/u6sXaUorqg==
Date:   Fri, 11 Oct 2019 05:45:35 +0000
Message-ID: <20191011054459.17984-3-james.qian.wang@arm.com>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e7c30e78-58e4-4cb3-fc82-08d74e0e4405
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|VE1PR08MB4816:|AM6PR08MB4913:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB491334CCA28F6B1C1902B676B3970@AM6PR08MB4913.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2043;OLM:2043;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(4326008)(2201001)(2171002)(86362001)(2906002)(103116003)(36756003)(6512007)(1076003)(316002)(110136005)(81156014)(81166006)(8936002)(6436002)(54906003)(99286004)(50226002)(305945005)(7736002)(8676002)(3846002)(76176011)(6116002)(5660300002)(52116002)(6486002)(66476007)(6506007)(386003)(66556008)(66446008)(64756008)(14454004)(446003)(186003)(11346002)(14444005)(256004)(26005)(102836004)(71200400001)(2616005)(476003)(486006)(66946007)(55236004)(25786009)(71190400001)(2501003)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dn4tcfyUpPpF4U/YXbMcs75xZEIW+aIPB1vmXTROjeqHPNdrzsvKZ+oQPdMpOAvxZCsFmniQWinA6c5V/sTOAm/Sk76MAK1hQLaWiuo3kPkLZnOgKB6q6ts51HQGqD0hQ//VfVJkP4NHPjizqm/QTNPgKT1fm4C+TuVgM02RbLn+rH4O5ZoN5sruP15J+A4YC9qrfU3iufGxIUG9+ZoVDix8KGcfnKnJ01921vs4HhMfkOVg1CU/oPzyA5GEyywoSx5RNtaDSADhY4rSD8Al9VMlKEwCuIdBjQFd0GlmKSZPKOvFqiMJHxWrMTLT0nwdpwdZzwqS6zj3gdUkBNknnwYXSLgNadGDTHzLb/2N+KB6DW9ZXTsEwqhUKPQyXWrFgOOcJcPTn0WNu0WRZhfSImGpOfPQFWn8AMhk/jcryS4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(386003)(26005)(4326008)(305945005)(486006)(7736002)(316002)(76176011)(99286004)(50466002)(1076003)(54906003)(110136005)(356004)(336012)(25786009)(126002)(63350400001)(103116003)(476003)(2616005)(2906002)(11346002)(22756006)(446003)(5660300002)(6506007)(6116002)(102836004)(3846002)(186003)(6512007)(2201001)(478600001)(26826003)(76130400001)(86362001)(8746002)(81156014)(81166006)(8676002)(70586007)(2501003)(8936002)(70206006)(47776003)(6486002)(66066001)(36756003)(2171002)(14444005)(23756003)(50226002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4913;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2430ebd0-358a-4d8d-7b92-08d74e0e3cc0
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF0v0ErP+f78HmPt7k0kYiooxZxFsjSdJlEU2yCzw8xVgPBTV3jgxLRfLsHGEbLWt/ZLyeZ7vOpXX1/vMxw23XK9kmebk96qmfMh54R/Ag7X1dbrX4EbCnhZZEBSOondRK7q1BFJwdHUxZV+zUUb1iYyuUfYWEm5gAvbXMUM8D+5perie7zr9laKJadsiLy/Moda6CoidGnxHkwLUdDC3H1+EfWot9T1j4HkujAXMRklkzGGs+7P/iEMir8jvaRrsUGld1UG1cw4MT8/ZQ82iQqzmvapzMKRQ9XFqut033TSaC4dKERNN3SlLgi4YelQKWV4xUztGjzbSbHYa/tV62MghP5QgJyByOy2iOnBfOiTU+JrsKhPAQULoB6u1UGU4cq9WWnpchr+za0Q1S2H9MGtEcy36aYFGxe3kGQXlJ4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:45:47.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c30e78-58e4-4cb3-fc82-08d74e0e4405
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4913
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

