Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D9AFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64C220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ji/J+1Zp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ji/J+1Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392460AbfJPKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:44 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:35415
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfJPKen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=ji/J+1Zp78yAUtVtVhe1tn+kYdlPjci8ONd4VJjxkgMZixi6jJgroFmYElEGM3qFBVuHDJV3MPQJo57TwFGF/O3jXN3ZKH1CvrQQGI9e0a0a7uzGfd5jZ404Tydjl2q2EpZim3AB/xX1GvZeJXEvOU/rEq0hY2cIEQvrtE5UsU4=
Received: from VI1PR0802CA0038.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::24) by DBBPR08MB4712.eurprd08.prod.outlook.com
 (2603:10a6:10:f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Wed, 16 Oct
 2019 10:34:37 +0000
Received: from DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR0802CA0038.outlook.office365.com
 (2603:10a6:800:a9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Wed, 16 Oct 2019 10:34:37 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT050.mail.protection.outlook.com (10.152.21.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:34:36 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Wed, 16 Oct 2019 10:34:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7b89b7875e6a661f
X-CR-MTA-TID: 64aa7808
Received: from 552a0589a21a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F6CEAD20-7757-4509-8BF8-6E164F6873B2.1;
        Wed, 16 Oct 2019 10:34:26 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 552a0589a21a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 10:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb5mFZlLHB1EusT3qSYG+NQyRb7kV6x5kC+ucLmy8+sY+qO7oB1kB0yxZicZAc4lmE0xQdaTX/Lz1i/9ydCAhUV3RIZF2aqpObnn8NzdWokjJx2cyHW7h7ivxTHTkXXeWtCos0QuE7XOIIM+0UFa6DtF0F3NZJNK9hS4y4UZI8bITEexTkDjsHGKFqv4it2FbvPJ97BzPv1bCLxmXNzUBy0ZiOx0G6xTnxN4QmyHZuH2GClBwjAB0E92Vx804vNwM0RU4NRq/ukPm3kuQ2orSzGdoTpeb8R8G6wDguMdhOusgVwud3yhGOb5DK/Fv4ig48FzH0/0H1MymAAWdJN2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=ZKgSHOZhRJ7Suvge3ewzIiutWAhN2qliZYJev5ZgnNUiNbo8FLQNkWEYXjcRfcVS8bKutxi82xCN07hLldYmkalrc5kp+PFeHql0k6jVUfIaJ3DJJugM7EydMyjoyglDThX8BdVGS8uRrHAxeBriNU3AL5iBi8F6d3xsNbmweqdEfQQuQJFFsVmEFxp2mUkgJn4jc8dUWgZc7qmgA6zGwXBbeDqkSBV7NKQqrioinvOfTnLa6eDjAQ5MdgjdekfD7uARZMWmLtgkkc7MSrD9ZxRk+FH1ez7G5FU7fwYuftnNkIrAjrX7Zs6mj+M3HyGB6ky47k+/c36YU6Nr8fcPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=ji/J+1Zp78yAUtVtVhe1tn+kYdlPjci8ONd4VJjxkgMZixi6jJgroFmYElEGM3qFBVuHDJV3MPQJo57TwFGF/O3jXN3ZKH1CvrQQGI9e0a0a7uzGfd5jZ404Tydjl2q2EpZim3AB/xX1GvZeJXEvOU/rEq0hY2cIEQvrtE5UsU4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5152.eurprd08.prod.outlook.com (20.179.30.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 10:34:23 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:34:23 +0000
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
Subject: [PATCH v5 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v5 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVhA1Gtm4BORRiPkmxAOi2mqef/g==
Date:   Wed, 16 Oct 2019 10:34:22 +0000
Message-ID: <20191016103339.25858-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2301104-d00a-4ebc-0e87-08d7522470d0
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5152:|VE1PR08MB5152:|DBBPR08MB4712:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB47127D7D3655A352912DD8BEB3920@DBBPR08MB4712.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(4326008)(2171002)(25786009)(478600001)(66066001)(99286004)(103116003)(76176011)(52116002)(71190400001)(64756008)(71200400001)(256004)(66446008)(66476007)(36756003)(66946007)(14454004)(66556008)(8936002)(50226002)(8676002)(386003)(81166006)(81156014)(486006)(26005)(2501003)(186003)(55236004)(2906002)(5660300002)(110136005)(1076003)(305945005)(446003)(2201001)(6486002)(6436002)(11346002)(476003)(6512007)(316002)(6116002)(3846002)(102836004)(54906003)(86362001)(2616005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5152;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3RgZdF6spsqYgK4RVB7WKLLVKDKw04R1xUx+L1xTYPfTqIU5tken4iy29AWLvfqCgPDS+jPreX1QpcrYDWuv5MpYpKERUFIco1HmM4HOFPY87BYGssLT1L6mgYOlBNtvmAE9zIp8anMYuYQNF9VnOIXYAiwzYodUxQtrpYiP3zEq9EnE89vAV12i5ZLA53AODMx+Uo3nwwsinAV00G2ELk2EICseBYafN7dFxruHCk2w1N/am8KPdQlC8jjAGMNDXnqv2iTrgcgMNESz6Pvcx9h+DVSwzdsTNpBEmXToyKLD4zch12lRFtHcHv+H8R+isHSS3MC+xqxS4QGmOz25gDgHjjTlacJfVkSjWPt7kbHxzaHKf5ANaNoasDMMfweDj1lvXGKCJ7BsE+3dJEmeG6kD2+1lhW41AFAoM+MUBNg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5152
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6486002)(50466002)(102836004)(2201001)(36756003)(4326008)(103116003)(99286004)(478600001)(2906002)(76176011)(2501003)(305945005)(66066001)(356004)(86362001)(1076003)(25786009)(7736002)(6512007)(14454004)(23756003)(2616005)(126002)(476003)(47776003)(486006)(2171002)(26826003)(386003)(5660300002)(11346002)(26005)(336012)(6116002)(446003)(63350400001)(8746002)(8936002)(8676002)(316002)(70206006)(3846002)(70586007)(6506007)(50226002)(76130400001)(81166006)(81156014)(22756006)(186003)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4712;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f3ed9998-e2d7-49d9-031c-08d7522468cc
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYpOmjENviF4IjMhiixkd7w6K0pMqMYGFZwwEZy9StrACsU+40jQGDs1Fg6Bldo/iD3vyu02t4UhNAx1WpIt7rq9GXR0+EOJh1QLGhdOmEhcuw/cZ9r99V7mjoTrj+srCVzGva4Nk9np6eegCnAGaLLHQ0/fyyE27UMsrOxVZpybcdVHUcwEhPqgZwKmrM2wpBRT84xjxAPURs/aNETnaZhRmxnTynWNd7COa4QS+lJjgPWs3TeIFoENE3OgzB/8qA9+wmDvk5e4MWfN/Gp3s1XMkBChnqJ0iWBGpJ8ZkHTH60Nms/mk/lguDkmhT5bPqmzd59l6W31zCXaWFD6QsG7aPaxHkSKXkWMlGcDDohBH9GH8b5RffV1RKbmAJE2GUfGeItc4D2yBli2zv2xzN/7sFd0qcWl5H6HkO89Sm/M=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:34:36.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2301104-d00a-4ebc-0e87-08d7522470d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4712
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

