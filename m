Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1141C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796D9206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3viNEZC7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3viNEZC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKLKky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:40:54 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:60745
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbfKLKkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=3viNEZC7HJOZbeLf+UCIaKL2UR7my6B2ub48hVwaHTTwt0BsWnbOwIlV3MDFjMW/c81PPBZyu5MyqO0lhLLZX51USHwZvhyYsk1dbyI9IZYoIfkTbkaza3CUMFhTMzoEkbjp5CMj686kj9dLxC/VDCtf4dp3Fp01kVVsytIT7yM=
Received: from AM6PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:20b:b2::13)
 by VI1PR08MB4573.eurprd08.prod.outlook.com (2603:10a6:803:e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 10:40:49 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by AM6PR08CA0001.outlook.office365.com
 (2603:10a6:20b:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 12 Nov 2019 10:40:49 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 10:40:49 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 12 Nov 2019 10:40:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cce31c35067135f7
X-CR-MTA-TID: 64aa7808
Received: from d981cce78eee.2 (cr-mta-lb-1.cr-mta-net [104.47.9.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A5F06376-502B-421F-8A7B-8FEBFE531604.1;
        Tue, 12 Nov 2019 10:40:42 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d981cce78eee.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 12 Nov 2019 10:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n92d6PvBTLOYVxR/ZTs3g7pD1M7PctfgQEF4HZExbBbewosiWjavSYGY4HTlCf7VnCZiUSaLX7uncj6sHvuNwiSY8BXmmhY8CqepD4ZqQuKrXYzT4ytYaDRuYMG5Iatk1GtULLEqHk7uNlU7YL5quKW8qX6zwluVLv74SGURRpz+FUWVp4q7LRwczaAZNg2k/ztq6oLeKluYVGNOKZflMM1VHpKQUaJXafsU7aWoUhLbSAEuySha9HrbzKWxvfv8qc0UPrwzX3O39LpwUVWdlfl86f+JVwxU3i3bbiRNua51T980w102i6pU+cZlmB/a8JN4lr4ghI6C6Nqxn22jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=WPBgaqoOVlyhfGuyJx7/vH9o//7S0zc4brTayxxOMFRQZU7niufLx/235/iZtmv2ck3KYzZ1blbxXJPoGZK7Uy+70Kwz845fiEWEdcH97gzqZ1mz14ZmJQo1HpfX6lLG0uEHYKuheFSIgKu7gNxNJOQYRWnh8xmA1EeHulJoA3dVWoJF/QgaYJB7ANKkUNtVUVwB5IBciiq5WxLff/e3qCU4Hy1AmXHq6oA9VeZa+R7QDPR8UVVMhKPl9GiStnFlR4x8rvUFdFkp27zhUeRrusweNU1GEhmsrmZQ+tN4Wr/4nvkgMWjzCmDSBSHDN1ydvMG5Fo3rA7tKfcDY7bB34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaLJ9iCW/GukE6Q6/g2aWg+NqCkBH1FlUg88c+A1ko=;
 b=3viNEZC7HJOZbeLf+UCIaKL2UR7my6B2ub48hVwaHTTwt0BsWnbOwIlV3MDFjMW/c81PPBZyu5MyqO0lhLLZX51USHwZvhyYsk1dbyI9IZYoIfkTbkaza3CUMFhTMzoEkbjp5CMj686kj9dLxC/VDCtf4dp3Fp01kVVsytIT7yM=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.30.207) by
 AM0PR08MB3313.eurprd08.prod.outlook.com (52.134.92.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 10:40:38 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::3c0c:3112:ccbf:13d0%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 10:40:38 +0000
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
Subject: [PATCH v9 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v9 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVmUWfqKXksz1BtEuyt+x5WWTWPg==
Date:   Tue, 12 Nov 2019 10:40:38 +0000
Message-ID: <20191112103956.19074-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 08af1155-5734-4de1-aeb2-08d7675cc876
X-MS-TrafficTypeDiagnostic: AM0PR08MB3313:|AM0PR08MB3313:|VI1PR08MB4573:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB45735ECFF490C0E57820F7F6B3770@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(305945005)(8676002)(102836004)(476003)(2616005)(5660300002)(11346002)(99286004)(55236004)(81166006)(81156014)(7736002)(2906002)(50226002)(6506007)(66066001)(386003)(76176011)(26005)(186003)(71190400001)(71200400001)(2501003)(52116002)(8936002)(1076003)(25786009)(36756003)(256004)(6116002)(3846002)(4326008)(2171002)(66476007)(6512007)(446003)(478600001)(54906003)(486006)(6486002)(103116003)(64756008)(66946007)(66446008)(6436002)(14454004)(86362001)(316002)(110136005)(66556008)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3313;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5nPUsM/sEumHnGKHMxynTlM/yrvf6V2IsxcPPQ6bE8hOmL/ms1UK9pWpDK/YGCO+B+PaSk5r4wTeg34B/qrvFaa8oMEcQJXpPeSpicLPB5ugSZKhhV3S1gJmFryw6Z50CX2tW/lSIURLRHMG7WywiRm8n10JWOoy/Qic7OGUNZLV4XSKHqR57VzgknsgsGLrDu0gcJi43rbqVlHbAowrl/C8O4iMIKtQKRsRiwtO9/Awtgllar4UzRzN5Hh4p0GX8io0vySJpycuttFFk4cNI8SWNKWAi2bj006l0Aoh1or5b6sqpXcSaRQr9JALYSDnwoH2SBXdkV5HzL1mlI/Nye1rQ+pFyhZRho5Fuo2BmrbJbxE9H84Vw3ig5rxAU2b7t8TJ/LVb1DTFTmuZAj6BDqXyvZ5h7BT2nJMkt0glAw0baM3tLeJbHIBjkNGf1Bge
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3313
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1110001)(339900001)(199004)(189003)(8676002)(70206006)(105606002)(2906002)(70586007)(8936002)(8746002)(2501003)(81166006)(25786009)(81156014)(22756006)(50226002)(3846002)(6116002)(356004)(103116003)(6486002)(6512007)(36756003)(54906003)(26005)(50466002)(2171002)(316002)(36906005)(99286004)(1076003)(4326008)(336012)(386003)(126002)(186003)(102836004)(486006)(446003)(11346002)(47776003)(6506007)(2616005)(476003)(110136005)(5660300002)(76130400001)(76176011)(23756003)(2201001)(478600001)(26826003)(305945005)(66066001)(14454004)(7736002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4573;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8346d92d-9665-4d5c-bc98-08d7675cc18b
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu3matMIch3qf/Uxh3G8ettUlZ4QFwJHFNfM4DJhV/vE5I1jtOmaNx47bvyqUVP7Cn1WW8JbIiI717k7onG4VX+4WxLAbPIxVclCrcH+LV7npG9sz7L/5B4gh9ny8kuAMu2Ezu7JD6hbMEdnJi/eoLYoZfVugrtzhanvMwj/sRZa6DoxwCvbL0r75YerOJH/qLDMS9NJNiBfdNMGVkydLaxX+uLq/iO2qMwjFrwtCMTcXVWppNQXJ5LnyzL+L6OHywzYd5qUmZ06PhmtDTpotYqWZ0aC+vYYegaEbzodfgpMSj5yrifvfndFJJhuo2GdSeKs4Ktr2gP0yZYp4ZKRAVZphMslSBZ4xLORlnPiLM+PVdPE+MQ8sGIn9EWWIjdQm10vZeMbGIktxphiQJzZ3iDpY0HaajK0+9kIo6DmfN6Us98RYyOJI/YZaE0tjoj/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 10:40:49.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08af1155-5734-4de1-aeb2-08d7675cc876
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
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

