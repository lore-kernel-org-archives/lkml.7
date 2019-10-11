Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A3C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E988214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cjD9HM5x";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cjD9HM5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfJKFsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:48:45 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:50497
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfJKFsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=cjD9HM5xZ1L1JIRCvc+Kafj2je7ePdNBHkH3tj70E5euwE+oBAp+5H/f7fXu2dLA+aoYKdpizmSMyV6hX7tL1OC8ulgGqEydoFHGeNCFiklrtd+gH0EsQU2qB6JQQ749NGesJJ8v7bgHEnh97cnx2hakqnvyfRAYyz99vul5M10=
Received: from VI1PR0801CA0077.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::21) by DBBPR08MB4631.eurprd08.prod.outlook.com
 (2603:10a6:10:df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Fri, 11 Oct
 2019 05:45:59 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR0801CA0077.outlook.office365.com
 (2603:10a6:800:7d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 05:45:59 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 05:45:56 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 11 Oct 2019 05:45:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 506eef3dc52c589c
X-CR-MTA-TID: 64aa7808
Received: from f097dae2e33d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43688E5C-310B-4CF0-A787-3102134EC532.1;
        Fri, 11 Oct 2019 05:45:45 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f097dae2e33d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 05:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIXEn5tMOxD7xWHszFE8c1AWxEP139BVXS7WGlmCSnnS16zvKcn85Cka0roqjRVMyI2vc4lYDTOec9teVCZ+vkAelFRJ+Gh1v49meMLuv/BBlDwFqrviBD0X+IzxQ4wzY8s4ClMyKXruYbcuhfGOz8JJfgbQJ2Noo6mwMcKQ98+9LtJ4rzIx13i2o5gLiJp9FysJkYqKtwcuD8wDs1udaedbSLH8RqvOqa4A0aGjz7vlN2574BgbkCch5yeXEyTmONoIE8oCrbAnfs0m0uB+vIQDG9vrKF0osMInp/rIfQkL/fTSftCZcmE4uVdw7IsqW7HL9ZKd5/IFijVEhp/Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=ZH77U9OW4tFH291JAwI0nBehspeLZ+B+BDwuITpDgfa2O7E97rg7KrpQa6z4PKK5RuLT5Cg2V2oqrC2DdA9r18+sLoPXgxqCKMmQdABZaq42h07or45xuvVOVjX+oTw/8Pl2VuLHyR+tSfnajvzEXpZMNb9/MNauUrywTzEMSQWXPJfMdvM3qgMh8gxWoowPb6dbQOGHuA/pUpM3xhwSmvDiKp3o9+EjThowdhznemGr4xvv2XAarUOkPBZPkwX7B8rYGIz1nbsM3Xp2csXl+HTPnP42BFyF9/5Hz02xY/lVnJTEHkcGIznbQCAQwgZ21JEtsW9HChvCqeSCxmf2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjboglvKAq6uiIJDn2YUD84pCdj+UuHqWJb/1SqjLc=;
 b=cjD9HM5xZ1L1JIRCvc+Kafj2je7ePdNBHkH3tj70E5euwE+oBAp+5H/f7fXu2dLA+aoYKdpizmSMyV6hX7tL1OC8ulgGqEydoFHGeNCFiklrtd+gH0EsQU2qB6JQQ749NGesJJ8v7bgHEnh97cnx2hakqnvyfRAYyz99vul5M10=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4816.eurprd08.prod.outlook.com (10.255.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 05:45:43 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:45:43 +0000
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
Subject: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVf/ce0iEWJoV9sUaEYo7sUivKyA==
Date:   Fri, 11 Oct 2019 05:45:42 +0000
Message-ID: <20191011054459.17984-4-james.qian.wang@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35a5060a-5339-498c-ed0b-08d74e0e49c2
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4816:|VE1PR08MB4816:|DBBPR08MB4631:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4631F8DD5ABEBA67A71043F3B3970@DBBPR08MB4631.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(4326008)(2201001)(2171002)(86362001)(2906002)(103116003)(36756003)(6512007)(1076003)(316002)(110136005)(81156014)(81166006)(8936002)(6436002)(54906003)(99286004)(50226002)(305945005)(7736002)(8676002)(3846002)(76176011)(6116002)(5660300002)(52116002)(6486002)(66476007)(6506007)(386003)(66556008)(66446008)(64756008)(14454004)(446003)(186003)(11346002)(256004)(26005)(102836004)(71200400001)(2616005)(476003)(486006)(66946007)(55236004)(25786009)(71190400001)(2501003)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4816;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JR0DUEcS0sIXhKrvgHNsP58qGnxRONqWsfugxS73WR/RVCbu/C4GjTXUEScmSGi4wUYGfyoRxSvT9jTKIhOstSsYLilsM7f2PdggkB9o1yWwWFcD1MxJCyOpHHGQl4XehADC2SPpwQqVIa5E7M2cs8fFr1+oGOd931Tqq6ob0puKiUJTjb9AIZ1zK1i5pOGIH8kUajD48i4PpIypS8/ExdV4rpiaSXk5ptqPsq5ZbWs35pWH2+s5SRe4EBgCMWMjyeNhVqMGU9Z6ggqGMNQklbNGyWUgsaNsfNdT7B7R0Gr4xr/7me5lNcGb9MKwAnL+dkJkbwdzjodyFsVKhQLvmTSYys6mDpStnqsQU1CvyifjaRt8ayM2oXAf6ZZ4FgtChCS4okHEFKCAWkZ/Utc+o7nfv+IwnjoDMExj1lELG9g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(1076003)(305945005)(446003)(36756003)(63350400001)(6486002)(26826003)(25786009)(86362001)(14454004)(23756003)(336012)(11346002)(22756006)(2616005)(5660300002)(7736002)(478600001)(6512007)(81166006)(81156014)(2906002)(2501003)(76176011)(476003)(2201001)(3846002)(126002)(186003)(356004)(2171002)(66066001)(6506007)(386003)(316002)(102836004)(50226002)(47776003)(54906003)(110136005)(70206006)(76130400001)(8936002)(486006)(8746002)(70586007)(26005)(50466002)(103116003)(6116002)(99286004)(8676002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4631;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a58bbe66-d148-4d33-87dc-08d74e0e4116
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6vVsznczaPUFABSUFS23FOd/LlcXoV3VjoZPH/+dCewH9muUZGjGLjCa/rRWz9vHZX0CvVif5T64TNp9xmNCit5uGeU9fRRZGf97QdrSiJgSXKvHc1NczOdi5DPrYzI/+MmBurq3NkPSK5zyZb3uNkxZoW+XhMs7nR1MkG8Mh/Q1rSyetOcin3PvYbsuQlJAxXzWwzgLAiXhKo8JTJNvoBrh6kupEPudefl/RKOxw/gwbw36Ylt0V/AJnM52oyicTarZ85PTYy/NdN580QnzJ+jemNAKXWxNQzJ3t7Ry7/TsbRyMELxPGSzVM4VYsZo8ix/d1IKFp50Jqi0YlyPhXKm938Hw3LOnU+T/pWIN2gCnbnjIQxc3AqxZePY4XWVBveHxNUMadfW9Gso1P2iwk8BQ98nSyNAkT67jhGMPTU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 05:45:56.8813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a5060a-5339-498c-ed0b-08d74e0e49c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4631
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

