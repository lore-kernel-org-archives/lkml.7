Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C3BECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A9321835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UeGGyF+r";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UeGGyF+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfJOCLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:11:25 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:23872
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfJOCLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGXLdi+Pb1SSmWtgl3GmMopU1EC0Z2mssefcs3oA9Y=;
 b=UeGGyF+roAj8bBhVeKxNTe6wM4DZZLIyU2RC48IJUnu5Pec8c0VNLEW/FZJ/QVey1x4hWco6zoS+qcjwNIKZaIm6aT/EleFyKQ3w5MxbdKNcgv5maPIiuTtu8QhZtP1N1VjGo/XylZKREnyJyokq3rJYAELZRLwcvZFR/xowxlw=
Received: from VI1PR08CA0104.eurprd08.prod.outlook.com (10.175.228.30) by
 DB6PR08MB2760.eurprd08.prod.outlook.com (10.175.234.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 15 Oct 2019 02:11:17 +0000
Received: from DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0104.outlook.office365.com
 (2603:10a6:800:d3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Tue, 15 Oct 2019 02:11:16 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT036.mail.protection.outlook.com (10.152.20.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 02:11:15 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 15 Oct 2019 02:11:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1049427a500a475b
X-CR-MTA-TID: 64aa7808
Received: from f09d0f69effc.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A93CFC27-508E-44BE-967D-04F6648B714E.1;
        Tue, 15 Oct 2019 02:11:03 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f09d0f69effc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 15 Oct 2019 02:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN20tlCqrkTxICy6dSiApX1k7KOQ9/oYTbBahFb2h/apFYzbvC8x9DVZCmj8cp0H6n0mBZ/eAXyahNWhgTbSeeZXAIK4K84xTVMoXIavGbMzc13hb5X78bSgQIz5MWlCBoU83BSEbyjU97Hqgt5Q8lYLUmJdGfC477MPtulW2vHDbOEPSCpBQfjbfuf7KKz0VRQWYDGdtOvEQATXgSfyEPmvp5poNuFsHnf3lQu7xEfSSYBaGOQDvCD0IYvyQ8ujre2a0P0s3oe7vEy8bgtyostn675f4g4Xn23xWqIENZCLjIyh5o/hTMsBwYyZ0DE9ufzCUYHTb6VKkYO9KxV6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGXLdi+Pb1SSmWtgl3GmMopU1EC0Z2mssefcs3oA9Y=;
 b=esiL8ON/K3FDnG+Ak77u6X9s3M23yOEwokXlplm5y5B5UIRUHvTHM/NQYcswJv3fkAjN1xf8PRPcR8bGBSZsR2bc4hiJj0wVYoXMDKIXHdIbZ3lR1OwwnkXuRb5z/SQWUfDvEUnJPTPg3oI66fH0Hwb3827A/jkzj6c89OFk7c9C/bbn8T0b9/gxfL19AJPYBrdNJtPUjVSlLSv02XYxZDO0uFoeonu+pgTNoLOFfgSvgi5Y0BENRji0UuhIIBo2ftCpewHJMgHxOMa59lv8ht2O+T/+YJ0ZwZOcoZ14nnESBFcuICVzz6jUVWRRQ2ITQf2t2yPlgT5TlkAv5Jmfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGXLdi+Pb1SSmWtgl3GmMopU1EC0Z2mssefcs3oA9Y=;
 b=UeGGyF+roAj8bBhVeKxNTe6wM4DZZLIyU2RC48IJUnu5Pec8c0VNLEW/FZJ/QVey1x4hWco6zoS+qcjwNIKZaIm6aT/EleFyKQ3w5MxbdKNcgv5maPIiuTtu8QhZtP1N1VjGo/XylZKREnyJyokq3rJYAELZRLwcvZFR/xowxlw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.115.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 02:11:01 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 02:11:01 +0000
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
Subject: [PATCH v4 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v4 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVgv3K+gTD1TOgJkesN8hoYuRc/Q==
Date:   Tue, 15 Oct 2019 02:11:01 +0000
Message-ID: <20191015021016.327-4-james.qian.wang@arm.com>
References: <20191015021016.327-1-james.qian.wang@arm.com>
In-Reply-To: <20191015021016.327-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 75daac45-49f8-4aba-e674-08d75114f58d
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4799:|VE1PR08MB4799:|DB6PR08MB2760:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB276014E0E97874CB3F925607B3930@DB6PR08MB2760.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(66066001)(476003)(76176011)(110136005)(54906003)(66946007)(64756008)(66476007)(66446008)(71200400001)(66556008)(26005)(103116003)(2201001)(86362001)(6512007)(186003)(71190400001)(316002)(36756003)(6506007)(446003)(11346002)(386003)(2616005)(486006)(2906002)(256004)(52116002)(55236004)(102836004)(2171002)(8936002)(14454004)(478600001)(6486002)(81156014)(81166006)(305945005)(50226002)(2501003)(4326008)(8676002)(7736002)(5660300002)(1076003)(6116002)(3846002)(25786009)(99286004)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EEYDHKvmldHpZ9RTMKyOnlnd1odOSUE+q+Y598+4M13CugwtaRq/oBQmRuYjxK2T1sMqjijZ3fY/usKXkXFLn4243BnNLyUb3N1UXKOyx+7pKjEAdmpGOeDDsIoGg+WllmYg7tNei1GmP78Ce+QbM6hMimy5/oma0YjZJi+54oi6toWxn9St7rBOBO3X3zNWWvHwECnDseDgkLixpdNVF+3gP7bLzNr60f+NHk19swcWEwjBEnwRml+oOaHqrqFD2ZxVVWOIKpZwGchOdJljbXw3PQZw1U4M3BOT0b6Xoxx0U+3wlGvC8ut8L5mNyI56Ub6G0HC2RduVtesLJIOM5f8pxLUyLCaGVqxsgD7W/KwkFFpMKN3mHT5qsbtcpOWcWoDAEL0RXDOZvID97f5NLJvGbY2Sl4dC/Qf2I22cudM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(3846002)(26005)(5660300002)(22756006)(63350400001)(103116003)(6506007)(336012)(386003)(6512007)(66066001)(486006)(126002)(186003)(2906002)(305945005)(446003)(356004)(476003)(7736002)(11346002)(2616005)(2171002)(6116002)(70586007)(2501003)(70206006)(76130400001)(4326008)(50466002)(110136005)(54906003)(478600001)(36756003)(47776003)(1076003)(99286004)(102836004)(316002)(6486002)(26826003)(25786009)(76176011)(23756003)(50226002)(8746002)(8676002)(86362001)(81166006)(14454004)(8936002)(81156014)(2201001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2760;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: adb12df8-1c4e-40a3-abcd-08d75114eccf
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmhyWoTAMcTj/L9oGGt1T1oljKpRp5TDVld/9+cm0ftP5xq9uZZZrNCf+MojNGWEOco6wlXQnFYGHW5+g8EDmvssokdF7+520K7hRbegW+IYXYoSwWKrKaLCAY9yPEuxMFacN1RDlio5TZHB8JVA4lYyn/eOs0YGYfWHTw8iH14K7yog0zKCszJIqrLFxhMGM6C9065P0MhIXBFuJCU40cI4pnRsU5RRzr8YYp400u9dd+9yZitNK2VxO+O9VpY+RNbFdu1cdqyXmA7ICTBk1aP3iHK21XPLyJEGAU8cCU4DlY0/CtwQwqVPcaJOLYl1a0fHQ7tohUO6hwKDOfW8nQ75A7t2AAnWkPMU3c+gz5LuMfKobOLK0TeQzpts4HvRsixlE2G7HissAWCJS8kts9T0dtckhcptuKr46DHGAik=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 02:11:15.6497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75daac45-49f8-4aba-e674-08d75114f58d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2760
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
index c180ce70c26c..ad668accbdf4 100644
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
+		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 2, 12);
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

