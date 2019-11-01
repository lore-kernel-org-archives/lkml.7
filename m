Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E208CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9064217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+DProxGo";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+DProxGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfKAGyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:54:17 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:55969
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKAGyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=+DProxGofEk4F1uuIcstwG/ztC2ADlxa0y28Ga2+l+2yDYcBDil/+YVDsAg0tbNtXTm/rfvst9Dw7uthLCLlMQY3CXAjTrB4vst2KjYRzgV5UUcQLWqm7EHsGZWZihcuuzlcpeiwE3OP5iKHPt1Bv8aVDuiVhF9ZL5cReDS7OBY=
Received: from AM6PR08CA0005.eurprd08.prod.outlook.com (2603:10a6:20b:b2::17)
 by AM0PR08MB3217.eurprd08.prod.outlook.com (2603:10a6:208:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.31; Fri, 1 Nov
 2019 06:54:11 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM6PR08CA0005.outlook.office365.com
 (2603:10a6:20b:b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 06:54:11 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 06:54:11 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Fri, 01 Nov 2019 06:54:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9575279cae463513
X-CR-MTA-TID: 64aa7808
Received: from 40ac0f1fb4d8.2 (cr-mta-lb-1.cr-mta-net [104.47.12.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EA74F343-7B77-451B-B85A-4424F2A7F47D.1;
        Fri, 01 Nov 2019 06:54:05 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 40ac0f1fb4d8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Nov 2019 06:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyGB2eVdXlY4UuVraWM1CN+NQdtnxWFYHRYEeVAn3BJihf+r5tMc5zmrS05qr8ca3h2CaqGeVG53vXhSbhswikKozpnrfd4ajEwr9KVTEOVZ4NNWS8DZnGoVpNWX6TmG6uizFbFe2awTgzGQCNzVVZk6zSHT7uZ9GJOtzt8DuyVR+0JHVkZe1AdjRHT2A/Er4B2CyNumciOVoBBacT+vGVBzzEMEIIvgdKjKpFEU8oGt8G6Ws4glAVNfJf2OvbKnyJzrFio354pjolpedGreOZdECv35rfcA8D3r1mJqOfoK7nKDcioi11y5l5uP/ihIsg4Casg52stLouooKyzlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=GGITmp9cJeb81yTOjIlHONILrd/vJ9OHWYUP6b0IZN2j3bBwv/sga5l6r+13JrHFu9Xb2FYVXmc4EPxUuSOefp3Udcbtj5gyY3MBRaVLmfT6diAs1o0RHag4I/w50DxjzexIF+2K/oOerZCaaH9/qxp+vg1OyoujuP6TbjWfLrto0qzVROcVuk3FhY2X08PHe7UV4N++2jDWUs+NtHD8lZbUSkHXt4P+U0XmLVSKemCWeZHM0xMa0SJs/tjZbkrceqlRmYMpdUZcw1cOvxFeLjaAoumosDLbjYEbYZPrnyA9qBB+gHjOjfDUGMcmW7NO1twQkZOmreoA7hgz2/vcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=+DProxGofEk4F1uuIcstwG/ztC2ADlxa0y28Ga2+l+2yDYcBDil/+YVDsAg0tbNtXTm/rfvst9Dw7uthLCLlMQY3CXAjTrB4vst2KjYRzgV5UUcQLWqm7EHsGZWZihcuuzlcpeiwE3OP5iKHPt1Bv8aVDuiVhF9ZL5cReDS7OBY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1SPR01MB0002.eurprd08.prod.outlook.com (20.179.193.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 06:54:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2387.030; Fri, 1 Nov 2019
 06:54:03 +0000
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
Subject: [PATCH v8 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v8 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVkIElzPvTOe8zQ0iuLclqIJbjiw==
Date:   Fri, 1 Nov 2019 06:54:02 +0000
Message-ID: <20191101065319.29251-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c47210e-7efa-4aea-c951-08d75e984cfa
X-MS-TrafficTypeDiagnostic: VE1SPR01MB0002:|VE1SPR01MB0002:|AM0PR08MB3217:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB32172BDE5C8886CAA99FB86DB3620@AM0PR08MB3217.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 020877E0CB
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(66066001)(446003)(11346002)(2616005)(486006)(36756003)(8676002)(14454004)(5660300002)(476003)(103116003)(2501003)(2171002)(86362001)(3846002)(6116002)(305945005)(2201001)(25786009)(1076003)(6512007)(66476007)(52116002)(71200400001)(71190400001)(386003)(55236004)(6506007)(6436002)(102836004)(6486002)(7736002)(186003)(99286004)(8936002)(110136005)(4326008)(54906003)(50226002)(478600001)(64756008)(2906002)(66446008)(81156014)(66556008)(316002)(66946007)(81166006)(76176011)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1SPR01MB0002;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: J01wp0jxbXeg+FwkNh9o91Hf2h3uOb6SHct8UlpCw82gmhM3xYBfhYaxYFW8L2cXgCSXZTe4nsDGXYLZ4nyWg1z1y69xdLoLz1E2Ac04RvEg5v1l52R+uY+tf6jVKUlDUuNuVLjDAqlciU9up0y02xrPWTtSHLDy6vRowhsVu00A/9q6Xdoi6Sb6E7YYmjzpFjN/ODlOuj5Tj1uGErcupTX9JND4Wm/WGIhiEGXFZO6yKeeBJSbpe6z6aH6QP3FRgQCsCfygkCzlYsf/C3F/OY15FDbKK3C09qqMmGkVr1r5b2iY3YbKfKtp5d0Z/NVPf8pU/XBSgVobidlrnCiXpZDAttWk2ASIihXfB5y8arWoA2PYQkqJWss2UOSBQfWk4Imz1Id1jS3y6mTI492vqfQGq85QlTc1q+d5cNmsTgUKqMZpnN8VSbdukUB7bq1p
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1SPR01MB0002
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(1110001)(339900001)(199004)(189003)(25786009)(7736002)(26826003)(478600001)(305945005)(22756006)(386003)(6506007)(14454004)(102836004)(8746002)(26005)(8936002)(81156014)(81166006)(23756003)(8676002)(105606002)(50466002)(50226002)(76176011)(99286004)(486006)(186003)(36756003)(2616005)(336012)(446003)(11346002)(476003)(126002)(2501003)(6512007)(316002)(54906003)(110136005)(47776003)(356004)(1076003)(66066001)(70206006)(70586007)(2201001)(86362001)(6486002)(2171002)(5660300002)(6116002)(4326008)(3846002)(2906002)(103116003)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3217;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2e337612-2fcd-44f2-1e59-08d75e9847b2
NoDisclaimer: True
X-Forefront-PRVS: 020877E0CB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ6pZL4uhLErEUWe9oH1IkUJHfD+S/SzsdNsGAxufCMdhczUKuelLrg48yP16UKMSyQwS5PYkR3hmT/0qEG5Jfzp7qsENECK/6jxhxoJbE05MmqdEwrISPc5J9uZkrhR/AkLMZcbPJ+3zNn2YCF6gqxThgnS8mZQ3kUx7mxYBtWMPLxDebMy9q2uyTX76TrfA0uBFOAFVAGA4AdWiq0wFL8IYPAXRq7prTOdZ5EKMUmVzUgfVPwKkxJKUBLlJ/X/zuEDY//Tg/Ca6A98sfvsspSeAUJylxSAckyI/O0FNIbc5m73omDjkRaO9Fx+1cVeM9NUSflI45m03fp1fHAULMvvyBlVwWptiwQ8JATVzbnL0hc09+hevcQ/Xb3gz/5QKiVQCf04l/TEoIMoRgfiWVOK1Ltyq89H3Z1QDm/4yd541OL80u8Hvax6idIeDuSj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:54:11.5247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c47210e-7efa-4aea-c951-08d75e984cfa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is for converting drm_color_ctm matrix to komeda hardware
required required Q2.12 2's complement CSC matrix.

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 14 ++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index c180ce70c26c..d8e449e6ebda 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -117,3 +117,17 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob=
 *lut_blob, u32 *coeffs)
 {
 	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
 }
+
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
+{
+	struct drm_color_ctm *ctm;
+	u32 i;
+
+	if (!ctm_blob)
+		return;
+
+	ctm =3D ctm_blob->data;
+
+	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; i++)
+		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 3, 12);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
index 08ab69281648..2f4668466112 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
@@ -18,6 +18,7 @@
 #define KOMEDA_N_CTM_COEFFS		9
=20
 void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coe=
ffs);
+void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
=20
 const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_rang=
e);
=20
--=20
2.20.1

