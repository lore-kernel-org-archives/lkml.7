Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02CC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4987E2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fKZfMydu";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fKZfMydu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfI3E4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 00:56:38 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:19268
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbfI3E4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvbEac7OETtKJD9fllmHTJ/Fl/DPCKR8vUreA20Jicw=;
 b=fKZfMyduqFWv/HNLuIlfp7fyuTxrhglD+scnYh0Pfvcj2RQBioz39GMqoZUoo2FmuayGrR4aTNz1A+VUDHB7F2UQQEj60NdVOmNSPDZfP1gRIJRagC3phMEgjzHKYLtVUbUw0d3ukQc0mBnrw4JqMWXTGD2sbLgWJZVp99ZWOyI=
Received: from VI1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::29) by HE1PR0802MB2153.eurprd08.prod.outlook.com
 (2603:10a6:3:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 04:54:52 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR0802CA0019.outlook.office365.com
 (2603:10a6:800:aa::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Mon, 30 Sep 2019 04:54:51 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 04:54:50 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 30 Sep 2019 04:54:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 824b97fff89316d1
X-CR-MTA-TID: 64aa7808
Received: from d5dd76d7e6d0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6FE777CD-0CB5-4C4C-BDA6-25D9613B6C2E.1;
        Mon, 30 Sep 2019 04:54:43 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5dd76d7e6d0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 04:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8nuF3kg6g72EXC91iWZ7gG6ziPxNQdLCV9RWqoch+rSfoYp2v+EnHSJt+4JxkjDZ3ouE+LFtO3fiXCNOSsIMDQ9XO8IUfmblIGFJGNshZANzvCDd6Y4gMlGSLCxxalkATHuA4JAld7rjxCFpCDypslDLw6/uwHMvQ23RbmA9aik/shSl06dUjHclDPbydTLSqAYaFVH16PvQc9pQPhZy5E8sNrr7ZU1DUyrPIqUnP45GwYyzQuigvZm9iw5iaqzE+D3E0G+WSnl+6jkKGDgp1++BJf6t4wKEl6VU7HbJx8Uc0vVKNjRd+5aTSs7fA1pJ9PNfXyds4f+FrV/xHDM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvbEac7OETtKJD9fllmHTJ/Fl/DPCKR8vUreA20Jicw=;
 b=Ka7ivca9vb+82L612XlrH8c+B26at/6HKFb+1omtxZYykFlZZISKQm6pFV0CC8/Dv5MO5730u+rtIjgRqqqLY0i8LAfDW4XSLdUXGhsrPmSKkB99XqdfD2kPznlFPyh1dsoew9/0PsHb8TejzLHry1ZjY26zirNSi04A/qFEEWRZpBaq1e7Vhu9idBWFT6kVURUdM8VxwFKUsVTe+ZzfOdxSQdU+H/fB4Xs4Umzdq9RaS7NdwmL+3qA3aaO8QYMIP4/+NAJrp8wKuefxVJ7BJnP5YYqY37HH8xpCyNd339fFXEE8KjorjanK7XZQeStXHSGp1l3hmvWblL/rRbl18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvbEac7OETtKJD9fllmHTJ/Fl/DPCKR8vUreA20Jicw=;
 b=fKZfMyduqFWv/HNLuIlfp7fyuTxrhglD+scnYh0Pfvcj2RQBioz39GMqoZUoo2FmuayGrR4aTNz1A+VUDHB7F2UQQEj60NdVOmNSPDZfP1gRIJRagC3phMEgjzHKYLtVUbUw0d3ukQc0mBnrw4JqMWXTGD2sbLgWJZVp99ZWOyI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4671.eurprd08.prod.outlook.com (10.255.115.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 04:54:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 04:54:41 +0000
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
Subject: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVd0sr2eIkvH1CKkK4ZygjJg2yVg==
Date:   Mon, 30 Sep 2019 04:54:41 +0000
Message-ID: <20190930045408.8053-3-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 943d75af-ed0a-4d98-87e4-08d745625374
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4671:|VE1PR08MB4671:|HE1PR0802MB2153:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2153CB1CE0D8425B0460D355B3820@HE1PR0802MB2153.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3826;OLM:3826;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(25786009)(52116002)(55236004)(11346002)(50226002)(486006)(6506007)(8676002)(8936002)(6512007)(99286004)(102836004)(6116002)(6486002)(3846002)(1076003)(2906002)(81166006)(5660300002)(86362001)(2616005)(476003)(446003)(386003)(6436002)(76176011)(81156014)(186003)(54906003)(110136005)(26005)(316002)(14454004)(2201001)(478600001)(66066001)(66446008)(64756008)(66556008)(103116003)(66476007)(66946007)(2501003)(4326008)(36756003)(71200400001)(7736002)(71190400001)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4671;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6dBgWVlXMfRMwCCEFy6F9eSikyP7EJwgv5VvV/2Cbcod7A9KzusJ1nRYQLXZ8ZnU0cuJaBhbOUg51Lomb2jGGvoWDiHf1jKso8jFFchoOWRB87NLxNHObfRP1SrvCRSW4SgwNCipYQZCHl11J03gz/mVdGGHbQPT1sahUKv6jGhAt1iQuiwhF4Zxc+5ibYYQWiY4PLdGcW2V37n9Qe3f1GrGm0+/QskSCTv8xptzIdksqhjxuW657D15Q//zyG6e/nXAFAWS+gCxzKh/+G/fNjUkpZPMwenj+HILFDzLB11mxFOPksROyCXHG81pZ+yNz+71qwvyV8Of+PTHleuIlESCuodrVb9xytPYKN7gxslgXsm+Eg3Uc8t7uD1BRtYOmrYyYC51LMiRt2RkwFSp6o+zk/ORMqOYl46FHtwNpvY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4671
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39850400004)(346002)(189003)(199004)(70586007)(70206006)(76130400001)(8676002)(103116003)(81156014)(36756003)(50466002)(81166006)(5660300002)(1076003)(25786009)(356004)(2201001)(8746002)(26826003)(6512007)(4326008)(86362001)(478600001)(2501003)(305945005)(8936002)(3846002)(14454004)(7736002)(336012)(2906002)(486006)(11346002)(446003)(6486002)(66066001)(47776003)(316002)(6506007)(386003)(76176011)(186003)(36906005)(6116002)(99286004)(54906003)(110136005)(476003)(2616005)(22756006)(50226002)(23756003)(102836004)(26005)(126002)(63350400001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2153;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f0cd0d40-c547-484a-7e98-08d745624df2
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aWHZfwtOMriatSdeRUVP2NxxxkHJ8UcwzbAuVXYcJqnhV6/fAke+y1u3ZOlpvyeog508YCv/FL+5aclhjrqy6fP0epjwNbyMaYxQW7Cyjh2/1a5WuQoRjhd5T7+QnOKyxicOQSPOZDsrQh1iAwr+qyTjOA7uXqEthGpNZU7ZBTuy+o/Pd9zBZ22QhA1Q8fKTd8W2mW7/fhEO6dSIUN4oL+mWzhT0y49psIjx+OlQff09bM7bX2tzlMdKzM5i65YEpjJMnFq2c0QEsKxke93jn7vWYysjBHngqhtvS732LpxrJ1t7QoATZ+TaYpl45B2Php3d7hetDnzncK+dySFYIPGIyzjDfyPFf12SKSSb670f9ZILKLWmWl8xg8nANwBWeIEgzYMpCh/tndgeQeNE408xLg577Qj5YZdinuf4xc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 04:54:50.2799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943d75af-ed0a-4d98-87e4-08d745625374
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used to convert drm_color_ctm S31.32 sign-magnitude
value to komeda required Q2.12 2's complement

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/komeda_color_mgmt.c    | 27 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index c180ce70c26c..c92c82eebddb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -117,3 +117,30 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob=
 *lut_blob, u32 *coeffs)
 {
 	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
 }
+
+/* Convert from S31.32 sign-magnitude to HW Q2.12 2's complement */
+static s32 drm_ctm_s31_32_to_q2_12(u64 input)
+{
+	u64 mag =3D (input & ~BIT_ULL(63)) >> 20;
+	bool negative =3D !!(input & BIT_ULL(63));
+	u32 val;
+
+	/* the range of signed 2s complement is [-2^n, 2^n - 1] */
+	val =3D clamp_val(mag, 0, negative ? BIT(14) : BIT(14) - 1);
+
+	return negative ? 0 - val : val;
+}
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
+		coeffs[i] =3D drm_ctm_s31_32_to_q2_12(ctm->matrix[i]);
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

